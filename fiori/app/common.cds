/*
 Common Annotations shared by all apps
*/

using { sap.capire.bookshop as my } from '@capire/bookshop';

////////////////////////////////////////////////////////////////////////////
//
//	Books Lists
//
annotate my.Books with @(
  Common.SemanticKey : [ID],
  UI                 : {
    Identification  : [{ Value: title }],
    SelectionFields : [
      ID,
      author_ID,
      price,
      currency_code
    ],
    LineItem        : [
      { Value: ID, Label: '{i18n>Title}' },
      { Value: author.ID, Label: '{i18n>Author}' },
      { Value: genre.name },
      { Value: stock },
      { Value: price },
      { Value: currency.symbol },
    ]
  }
) {
  ID  @Common: {
    SemanticObject : 'Books',
    Text: title,
    TextArrangement : #TextOnly
  };
  author @ValueList.entity      : 'Authors';
};

annotate Currencies with {
  symbol @Common.Label : '{i18n>Currency}';
}

////////////////////////////////////////////////////////////////////////////
//
//	Books Details
//
annotate my.Books with @(UI : {HeaderInfo : {
  TypeName       : '{i18n>Book}',
  TypeNamePlural : '{i18n>Books}',
  Title          : { Value: title },
  Description    : { Value: author.name }
}, });


////////////////////////////////////////////////////////////////////////////
//
//	Books Elements
//
annotate my.Books with {
  ID     @title: '{i18n>ID}';
  title  @title: '{i18n>Title}';
  genre  @title: '{i18n>Genre}'   @Common: { Text: genre.name, TextArrangement: #TextOnly };
  author @title: '{i18n>Author}'  @Common: { Text: author.name, TextArrangement: #TextOnly };
  price  @title: '{i18n>Price}'   @Measures.ISOCurrency : currency_code;
  stock  @title: '{i18n>Stock}';
  descr  @title: '{i18n>Description}'  @UI.MultiLineText;
  image  @title: '{i18n>Image}';
}

////////////////////////////////////////////////////////////////////////////
//
//	Genres List
//
annotate my.Genres with @(
  Common.SemanticKey : [name],
  UI                 : {
    SelectionFields : [name],
    LineItem        : [
      { Value: name },
      {
        Value : parent.name,
        Label: 'Main Genre'
      },
    ],
  }
);

annotate my.Genres with {
  ID  @Common.Text : name  @Common.TextArrangement : #TextOnly;
}

////////////////////////////////////////////////////////////////////////////
//
//	Genre Details
//
annotate my.Genres with @(UI : {
  Identification : [{ Value: name}],
  HeaderInfo     : {
    TypeName       : '{i18n>Genre}',
    TypeNamePlural : '{i18n>Genres}',
    Title          : { Value: name },
    Description    : { Value: ID }
  },
  Facets         : [{
    $Type  : 'UI.ReferenceFacet',
    Label  : '{i18n>SubGenres}',
    Target : 'children/@UI.LineItem'
  }, ],
});

////////////////////////////////////////////////////////////////////////////
//
//	Genres Elements
//
annotate my.Genres with {
  ID   @title: '{i18n>ID}';
  name @title: '{i18n>Genre}';
}

////////////////////////////////////////////////////////////////////////////
//
//	Authors List
//
annotate my.Authors with @(
  Common.SemanticKey : [ID],
  UI                 : {
    Identification  : [{ Value: name}],
    SelectionFields : [name],
    LineItem        : [
      { Value: ID },
      { Value: dateOfBirth },
      { Value: dateOfDeath },
      { Value: placeOfBirth },
      { Value: placeOfDeath },
    ],
  }
) {
  ID  @Common: {
    SemanticObject : 'Authors',
    Text: name,
    TextArrangement : #TextOnly,
  };
};

////////////////////////////////////////////////////////////////////////////
//
//	Author Details
//
annotate my.Authors with @(UI : {
  HeaderInfo : {
    TypeName       : '{i18n>Author}',
    TypeNamePlural : '{i18n>Authors}',
    Title          : { Value: name },
    Description    : { Value: dateOfBirth }
  },
  Facets     : [{
    $Type  : 'UI.ReferenceFacet',
    Target : 'books/@UI.LineItem'
  }, ],
});


////////////////////////////////////////////////////////////////////////////
//
//	Authors Elements
//
annotate my.Authors with {
  ID           @title: '{i18n>ID}';
  name         @title: '{i18n>Name}';
  dateOfBirth  @title: '{i18n>DateOfBirth}';
  dateOfDeath  @title: '{i18n>DateOfDeath}';
  placeOfBirth @title: '{i18n>PlaceOfBirth}';
  placeOfDeath @title: '{i18n>PlaceOfDeath}';
}
