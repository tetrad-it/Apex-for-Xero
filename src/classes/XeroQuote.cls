/**
* @author Emandleni Moyo (emandleni.moyo@tetrad.co.za)
* @date 09 Nov 2021
* @description Wrapper class for serialising and de-serialising a Xero Quote
*
**/
public class XeroQuote {
    public String QuoteID {get;set;} 
    public String QuoteNumber {get;set;} 
    public String Reference {get;set;} 
    public String Terms {get;set;} 
    public XeroContact Contact {get;set;} 
    
    public String Date_Z {get;set;} // in json: Date
    public String DateString {get;set;} 
    public String ExpiryDate {get;set;} 
    public String ExpiryDateString {get;set;} 
    public String Status {get;set;} 
    public Double CurrencyRate {get;set;} 
    public String CurrencyCode {get;set;} 
    public Double SubTotal {get;set;} 
    public Double TotalTax {get;set;} 
    public Double Total {get;set;} 
    public String Title {get;set;} 
    public String Summary {get;set;} 
    public String BrandingThemeID {get;set;} 
    public String UpdatedDateUTC {get;set;} 
    public String LineAmountTypes {get;set;} 
    
    public class LineItems {
        public String LineItemID {get;set;} 
        public String AccountCode {get;set;} 
        public String Description {get;set;} 
        public Double UnitAmount {get;set;} 
        public Double LineAmount {get;set;} 
        public String ItemCode {get;set;} 
        public Double Quantity {get;set;} 
        public Double TaxAmount {get;set;} 
        public String TaxType {get;set;} 
        public List<Tracking> Tracking {get;set;} 
        
        public LineItems(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'LineItemID') {
                            LineItemID = parser.getText();
                        } else if (text == 'AccountCode') {
                            AccountCode = parser.getText();
                        } else if (text == 'Description') {
                            Description = parser.getText();
                        } else if (text == 'UnitAmount') {
                            UnitAmount = parser.getDoubleValue();
                        } else if (text == 'LineAmount') {
                            LineAmount = parser.getDoubleValue();
                        } else if (text == 'ItemCode') {
                            ItemCode = parser.getText();
                        } else if (text == 'Quantity') {
                            Quantity = parser.getDoubleValue();
                        } else if (text == 'TaxAmount') {
                            TaxAmount = parser.getDoubleValue();
                        } else if (text == 'TaxType') {
                            TaxType = parser.getText();
                        } else if (text == 'Tracking') {
                            Tracking = arrayOfTracking(parser);
                        } else {
                            System.debug(LoggingLevel.WARN, 'LineItems consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }

    public class Tracking {
        public String TrackingCategoryID {get;set;} 
        public String TrackingOptionID {get;set;} 
        public String Name {get;set;} 
        public String Option {get;set;} 
        
        public Tracking(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'TrackingCategoryID') {
                            TrackingCategoryID = parser.getText();
                        } else if (text == 'TrackingOptionID') {
                            TrackingOptionID = parser.getText();
                        } else if (text == 'Name') {
                            Name = parser.getText();
                        } else if (text == 'Option') {
                            Option = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Tracking consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public List<LineItems> LineItems {get;set;} 
    public List<XeroQuote> Quotes {get;set;} 
    
    public XeroQuote(JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'QuoteID') {
                        QuoteID = parser.getText();
                    } else if (text == 'QuoteNumber') {
                        QuoteNumber = parser.getText();
                    } else if (text == 'Reference') {
                        Reference = parser.getText();
                    } else if (text == 'Terms') {
                        Terms = parser.getText();
                    } else if (text == 'Contact') {
                        Contact = new XeroContact(parser);
                    } else if (text == 'LineItems') {
                        LineItems = arrayOfLineItems(parser);
                    } else if (text == 'Date') {
                        Date_Z = parser.getText();
                    } else if (text == 'DateString') {
                        DateString = parser.getText();
                    } else if (text == 'ExpiryDate') {
                        ExpiryDate = parser.getText();
                    } else if (text == 'ExpiryDateString') {
                        ExpiryDateString = parser.getText();
                    } else if (text == 'Status') {
                        Status = parser.getText();
                    } else if (text == 'CurrencyRate') {
                        CurrencyRate = parser.getDoubleValue();
                    } else if (text == 'CurrencyCode') {
                        CurrencyCode = parser.getText();
                    } else if (text == 'SubTotal') {
                        SubTotal = parser.getDoubleValue();
                    } else if (text == 'TotalTax') {
                        TotalTax = parser.getDoubleValue();
                    } else if (text == 'Total') {
                        Total = parser.getDoubleValue();
                    } else if (text == 'Title') {
                        Title = parser.getText();
                    } else if (text == 'Summary') {
                        Summary = parser.getText();
                    } else if (text == 'BrandingThemeID') {
                        BrandingThemeID = parser.getText();
                    } else if (text == 'UpdatedDateUTC') {
                        UpdatedDateUTC = parser.getText();
                    } else if (text == 'LineAmountTypes') {
                        LineAmountTypes = parser.getText();
                    } else {
                        System.debug(LoggingLevel.WARN, 'Quotes consuming unrecognized property: '+text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }
    
    public static XeroQuote parse(String json) {
        System.JSONParser parser = System.JSON.createParser(json);
        return new XeroQuote(parser);
    }
    
    public static void consumeObject(System.JSONParser parser) {
        Integer depth = 0;
        do {
            System.JSONToken curr = parser.getCurrentToken();
            if (curr == System.JSONToken.START_OBJECT || 
                curr == System.JSONToken.START_ARRAY) {
                    depth++;
                } else if (curr == System.JSONToken.END_OBJECT ||
                           curr == System.JSONToken.END_ARRAY) {
                               depth--;
                           }
        } while (depth > 0 && parser.nextToken() != null);
    }
    
    private static List<Tracking> arrayOfTracking(System.JSONParser p) {
        List<Tracking> res = new List<Tracking>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Tracking(p));
        }
        return res;
    }
    
    
    
    private static List<XeroQuote> arrayOfQuotes(System.JSONParser p) {
        List<XeroQuote> res = new List<XeroQuote>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new XeroQuote(p));
        }
        return res;
    }
    
    private static List<LineItems> arrayOfLineItems(System.JSONParser p) {
        List<LineItems> res = new List<LineItems>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new LineItems(p));
        }
        return res;
    }
    
    
}
