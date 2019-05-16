Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0191A1F461
	for <e@80x24.org>; Thu, 16 May 2019 22:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfEPWgx convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 16 May 2019 18:36:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36530 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfEPWgw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 18:36:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id l203so3797704oia.3
        for <git@vger.kernel.org>; Thu, 16 May 2019 15:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2l5GOAZbP/7a3/EZ0E4v1EC/7QHsBR1wdDntox139ng=;
        b=EhSbJ39pySUYlIyXB9wcWyCm1vyfhqrMRGrFCu/QwZNF5y9i7F/nml61YQ56jOJkbK
         oy7fUbAnD/dPtaxFEdf9IsgWkQfWMEJ82eVR+VdJ0DhUSKvCkRIFhTZlSBXl+ztXlURI
         Ib1PnrrW1+QqcBbklXe3TdFGVSww1LOo97/MXy0phOYXK4NU/fyE3KGbOOwwpVvuZxYg
         NmL1Ig6Ymmng6sL1FnBO+uJNPOB1KEiVWWvuswBQfXAhc473+Ad/CqRagShCbytPC50W
         yyZ03mWiHVuDnmE4t2G+Snep0/TqAISBonH9PgutPl2n38+4GDV1duzyzHdVZCOyLq7Y
         fNjQ==
X-Gm-Message-State: APjAAAV7Ua3IxXvp18VaXjr6qsCnVdPHlQ0/ZASPTZF8mnKRjPQq8KI8
        o0cgXFUR0z2oyMza+ZKzLw+wBYOL2Z9YejPiL/INTRa92YU=
X-Google-Smtp-Source: APXvYqxyirMS62/xt7H28tf3fXOmbZnzgRgSe3H3ueSLbIBetn3ALkNX3pBcDbxkIPOPUMvye79ccTDUlM1skGtIH/U=
X-Received: by 2002:aca:b344:: with SMTP id c65mr6682908oif.46.1558046212024;
 Thu, 16 May 2019 15:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190515183415.31383-1-marcandre.lureau@redhat.com>
 <c8b6e9c6-12a4-c6dd-bea9-7f07c8af7d15@kdbg.org> <CAMxuvayAS=UbM6JF1WHkb5XsoVwQa2i4HQJM=0A4wo-t+T2cAw@mail.gmail.com>
In-Reply-To: <CAMxuvayAS=UbM6JF1WHkb5XsoVwQa2i4HQJM=0A4wo-t+T2cAw@mail.gmail.com>
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date:   Fri, 17 May 2019 00:36:40 +0200
Message-ID: <CAMxuvayShHs4=ykFaVgmvr0NkO=nb7n7Lht1-5MdafDavNF6MQ@mail.gmail.com>
Subject: Re: [PATCH] RFC: userdiff: add built-in pattern for rust
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Fri, May 17, 2019 at 12:17 AM Marc-André Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Thu, May 16, 2019 at 10:29 PM Johannes Sixt <j6t@kdbg.org> wrote:
> >
> > Am 15.05.19 um 20:34 schrieb marcandre.lureau@redhat.com:
> > > From: Marc-André Lureau <mlureau@redhat.com>
> > >
> > > This adds xfuncname and word_regex patterns for Rust, a quite
> > > popular programming language. It also includes test cases for the
> > > xfuncname regex (t4018) and updated documentation.
> > >
> > > The word_regex pattern finds identifiers, integers, floats and
> > > operators, according to the Rust Reference Book.
> > >
> > > RFC: since I don't understand why when there are extra lines such as the
> > > one with FIXME, the funcname is not correctly reported. Help welcome!
> > >
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  Documentation/gitattributes.txt | 2 ++
> > >  t/t4018-diff-funcname.sh        | 1 +
> > >  t/t4018/rust-fn                 | 5 +++++
> > >  t/t4018/rust-struct             | 5 +++++
> > >  t/t4018/rust-trait              | 5 +++++
> >
> > Nice to see tests!
> >
> > > diff --git a/userdiff.c b/userdiff.c
> > > index 3a78fbf504..9e1e2fa03f 100644
> > > --- a/userdiff.c
> > > +++ b/userdiff.c
> > > @@ -130,6 +130,15 @@ PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
> > >        "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
> > >        "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
> > >        "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
> > > +PATTERNS("rust",
> > > +      "^[\t ]*(((pub|pub\\([^)]+\\))[\t ]+)?(struct|enum|union|mod)[ \t].*)$\n"
> > > +      "^[\t ]*(((pub|pub\\([^)]+\\))[\t ]+)?(unsafe[\t ]+)?trait[ \t].*)$\n"
> > > +      "^[\t ]*(((pub|pub\\([^)]+\\))[\t ]+)?((const|unsafe|extern(([\t ]+)*\"[^)]+\")?)[\t ]+)*fn[ \t].*)$\n",
> >
> > The last \n there is the reason for the test failures: it adds an empty
> > pattern that matches everywhere and does not capture any text.
>
> Oops, thanks!
>
> >
> > Can we simplify these patterns as in
> >
> >    ^
> >    space*
> >    ( pub ( "(" stuff ")" )? space* )?
> >    ( struct|enum|union|mod|unsafe|trait|const|extern|fn )
> >    stuff
> >    $
> >
> > You don't have to check for a correct syntax rigorously because you can
> > assume that only correct Rust code will be passed to the patterns.
>
> yes, but with
>
> extern ( space* '"' stuff '"' )?
>
> I'll try that
>

Or do you want to capture any line with "extern..." or "unsafe..." ?

That's a bit too much I think, in particular, with unsafe, which is
commonly used with a simple block.

So perhaps this instead?:

[\t ]*((pub(\([^)]+\))[\t ]+)?((const|unsafe|extern([\t
]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn)[ \t].*)$


> >
> > > +      /* -- */
> > > +      "[a-zA-Z_][a-zA-Z0-9_]*"
> > > +      "|[-+_0-9.eE]+(f32|f64|u8|u16|u32|u64|u128|usize|i8|i16|i32|i64|i128|isize)?"
> >
> > I assume that
> >
> >        +e_1.ei8-e_2.eu128
> >
> > is correct syntax, but not a single token. Yet, your number pattern
> > would take it as a single word.
> >
> > > +      "|0[box]?[0-9a-fA-F_]+(u8|u16|u32|u64|u128|usize|i8|i16|i32|i64|i128|isize)?"
> >
> > You should really subsume your number patterns under a single pattern
> > that requires an initial digit, because you can again assume that only
> > correct syntax will be shown to the patterns:
> >
> >         "|[0-9][0-9_a-fA-Fuisxz]*([.][0-9]*([eE][+-]?[0-9]+)?)?"
> >
> > (very likely, I have mistaken the meaning of f32 and f64 here).
>
> That doesn't capture 0o70, easy to fix.
>
> Then it doesn't capture the examples from the reference manual:
> 123.0f64;
> 0.1f64;
> 0.1f32;
> 12E+99_f64;
>
> Thanks for your help!
>
> >
> > > +      "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
> > >  PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
> > >        "[={}\"]|[^={}\" \t]+"),
> > >  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
> > >
> > > base-commit: ab15ad1a3b4b04a29415aef8c9afa2f64fc194a2
> > >
> >
> > -- Hannes
