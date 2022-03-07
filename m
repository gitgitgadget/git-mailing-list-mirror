Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977ABC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 15:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239426AbiCGPLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbiCGPLr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 10:11:47 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E205888F6
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 07:10:52 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id r2so183248iod.9
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 07:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z9wfnYbmvo3RtNfBkSxWgVuVztO4ZA8kHiNb5TZH9EI=;
        b=m6rnEPp7tRJRlvGmGfNMfH6SvCzlyRNzEvSsQ3BWYKejPPO1/yyh0qAw45dmK932D/
         mKqxlPQNTCxmxRYm6wfnjJVONxDR+OvWq5tv9PZgTPotqmzx5PIUAmtszglJwyZZY+jB
         39K0L729fXtdHz/2VzNsB3UYEp60xkw6rYKHKLDRdDy/z3w8Xd2TH7U9482Ds34cuNt8
         KonEs50QPaPEIXIUJLMWRapj/vd1k+Z20icnpg3NBxcT3VcUJJ+eD3fPn25KXZbIsZhd
         qpObpEej14bs9qMYEb1UBlX5qe8ouESfjtyBh0w1tLoKLtfMM0YG28YGpJfikqhEoeDf
         RSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z9wfnYbmvo3RtNfBkSxWgVuVztO4ZA8kHiNb5TZH9EI=;
        b=NfZTkOT/645c1DfZ427LFJxE+Du38lsQsoiFBcJzCeFwkoj+RsRagUuoOvIPdg3Rye
         ArN7KgTSd9gLA3Hq/gnluQS448NREdhot9n93Kyzxrn1LzT6n53XUtxvi5ae3lUJg8K7
         3L9WBInjr/EJyIKIF3lpI02tHPs4RR6Y/kGxfiQWYUZthxkTI6NiMXvqKvxVZ89hQ8Nc
         sX1qV00brVjFIou186JglwVJgwj+FYDyCiAaB0/t2QzX0lz8/yDnIQhOitcrvprzYHrC
         8J++kjBNgPAvMDaX0ZbDaKDpjdpNPJ6aiI2U3zWT1ywo2upHYAT0NSdALoLWhkLb0YvN
         Rybw==
X-Gm-Message-State: AOAM533wwIPm1+eqWmVSsXsHGmYatVcNG8RobBbv/C96F00/Tz+h8Jvi
        FbS/oEzwrdq8Fvfe3nXONtoS3OMx9dlNmZhHH/beOkNlWsxIvg==
X-Google-Smtp-Source: ABdhPJzWaZ4JJRzZO9O+fC9YtrnFgc1uVrn2b/mRTbBvpj9aoWc+Wqo1nr/tG69y0C0ye0M6RVpxvwOCGu6V4iLwXH0=
X-Received: by 2002:a05:6638:1b07:b0:317:57f4:8d38 with SMTP id
 cb7-20020a0566381b0700b0031757f48d38mr10524200jab.260.1646665851373; Mon, 07
 Mar 2022 07:10:51 -0800 (PST)
MIME-Version: 1.0
References: <20220304130854.857746-1-a97410985new@gmail.com>
 <20220304130854.857746-2-a97410985new@gmail.com> <79bd770e-74f1-edf8-884b-c0f916732ce0@kdbg.org>
In-Reply-To: <79bd770e-74f1-edf8-884b-c0f916732ce0@kdbg.org>
From:   xing-zhi jiang <a97410985new@gmail.com>
Date:   Mon, 7 Mar 2022 23:10:11 +0800
Message-ID: <CAN_FRNK-FD+4_Nf_VdmU1N+TBapQ7ZnWo5Bn8M9YDWWhMfBypg@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/1] Add a diff driver for JavaScript languages.
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your review and give much good advice !!!
I will apply much of your advice to my v2 patch. But before I write
the v2 patch,
there is still something to check and discuss.

On Sat, 5 Mar 2022 at 18:16, Johannes Sixt <j6t@kdbg.org> wrote:
>
> Thank you for your contribution!
>
> Am 04.03.22 um 14:08 schrieb xing zhi jiang:
> > In the xfunction part that matches normal functions,
> > a variable declaration with an assignment of function, the function dec=
laration
> > in the class, and also the function is object literal's property.
>
> On the first read, I stumbled over the last half-sentence. Is this
> JavaScript-lingo for the construct
>
>    x =3D { foo: function() { ... } }
>
> A parenthetical note in this regard would be helpful.
>
> > And in the word regex part, that matches numbers, punctuations, and als=
o the
> > JavaScript identifier.
> > This part heavily references the formal ECMA sepcification[1].
> >
> > [1]https://262.ecma-international.org/12.0/#sec-ecmascript-language-lex=
ical-grammar
>
> After having seen the regex, to follow the syntax specification is
> unnecessarily tight. If you follow my suggestions, the note should
> probably be rewritten, but keeping the link to the language reference is
> certainly helpful.
OK, I will adjust the commit message but remain the reference link.

> >
> > Signed-off-by: xing zhi jiang <a97410985new@gmail.com>
> > ---
> >  .gitignore                                    |  1 +
> >  Documentation/gitattributes.txt               |  2 +
> >  ...avascript-assignment-of-anonymous-function |  4 ++
> >  .../javascript-assignment-of-arrow-function   |  4 ++
> >  .../javascript-assignment-of-named-function   |  4 ++
> >  t/t4018/javascript-async-function             |  4 ++
> >  t/t4018/javascript-export-async-function      |  4 ++
> >  t/t4018/javascript-export-function            |  4 ++
> >  t/t4018/javascript-exports-anomyous-function  |  4 ++
> >  .../javascript-exports-anomyous-function-2    |  4 ++
> >  t/t4018/javascript-exports-function           |  4 ++
> >  t/t4018/javascript-function                   |  4 ++
> >  t/t4018/javascript-function-2                 | 10 ++++
> >  t/t4018/javascript-function-belong-to-IIFE    |  6 +++
> >  t/t4018/javascript-function-in-class          |  6 +++
> >  t/t4018/javascript-function-in-class-2        | 11 ++++
> >  t/t4018/javascript-function-in-object-literal |  7 +++
> >  t/t4018/javascript-generator-function         |  4 ++
> >  t/t4018/javascript-generator-function-2       |  4 ++
> >  t/t4018/javascript-getter-function-in-class   |  6 +++
> >  t/t4018/javascript-setter-function-in-class   |  6 +++
> >  .../javascript-skip-function-call-statement   |  7 +++
> >  t/t4018/javascript-skip-keywords              | 34 ++++++++++++
> >  t/t4018/javascript-static-function-in-class   |  6 +++
> >  t/t4034-diff-words.sh                         |  1 +
> >  t/t4034/javascript/expect                     | 52 +++++++++++++++++++
> >  t/t4034/javascript/post                       | 32 ++++++++++++
> >  t/t4034/javascript/pre                        | 32 ++++++++++++
> >  userdiff.c                                    | 38 ++++++++++++++
> >  29 files changed, 305 insertions(+)
> >  create mode 100644 t/t4018/javascript-assignment-of-anonymous-function
> >  create mode 100644 t/t4018/javascript-assignment-of-arrow-function
> >  create mode 100644 t/t4018/javascript-assignment-of-named-function
> >  create mode 100644 t/t4018/javascript-async-function
> >  create mode 100644 t/t4018/javascript-export-async-function
> >  create mode 100644 t/t4018/javascript-export-function
> >  create mode 100644 t/t4018/javascript-exports-anomyous-function
> >  create mode 100644 t/t4018/javascript-exports-anomyous-function-2
> >  create mode 100644 t/t4018/javascript-exports-function
> >  create mode 100644 t/t4018/javascript-function
> >  create mode 100644 t/t4018/javascript-function-2
> >  create mode 100644 t/t4018/javascript-function-belong-to-IIFE
> >  create mode 100644 t/t4018/javascript-function-in-class
> >  create mode 100644 t/t4018/javascript-function-in-class-2
> >  create mode 100644 t/t4018/javascript-function-in-object-literal
> >  create mode 100644 t/t4018/javascript-generator-function
> >  create mode 100644 t/t4018/javascript-generator-function-2
> >  create mode 100644 t/t4018/javascript-getter-function-in-class
> >  create mode 100644 t/t4018/javascript-setter-function-in-class
> >  create mode 100644 t/t4018/javascript-skip-function-call-statement
> >  create mode 100644 t/t4018/javascript-skip-keywords
> >  create mode 100644 t/t4018/javascript-static-function-in-class
> >  create mode 100644 t/t4034/javascript/expect
> >  create mode 100644 t/t4034/javascript/post
> >  create mode 100644 t/t4034/javascript/pre
> >
> > diff --git a/.gitignore b/.gitignore
> > index f817c509ec..de628c53f8 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -244,3 +244,4 @@ Release/
> >  /git.VC.db
> >  *.dSYM
> >  /contrib/buildsystems/out
> > +/.cache
> > \ No newline at end of file
>
> Do not include this change. It does not belong to this commit.
OK

> > diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
> > index 60984a4682..f6554a4651 100644
> > --- a/Documentation/gitattributes.txt
> > +++ b/Documentation/gitattributes.txt
> > @@ -828,6 +828,8 @@ patterns are available:
> >
> >  - `java` suitable for source code in the Java language.
> >
> > +- `javascript suitable for source code in the JavaScript language.
>
> Please do not forget the closing quote.
I will fix it in v2 patch.

> > +
> >  - `markdown` suitable for Markdown documents.
> >
> >  - `matlab` suitable for source code in the MATLAB and Octave languages=
.
> > diff --git a/t/t4018/javascript-assignment-of-anonymous-function b/t/t4=
018/javascript-assignment-of-anonymous-function
> > new file mode 100644
> > index 0000000000..5d4701e84c
> > --- /dev/null
> > +++ b/t/t4018/javascript-assignment-of-anonymous-function
> > @@ -0,0 +1,4 @@
> > +const RIGHT =3D function (a, b) {
> > +
> > +    return a + b; // ChangeMe
> > +};
> > \ No newline at end of file
>
> Notice this "No newline at end of file". Please complete the last line
> of the file, i.e. do add the last line break. Same for all other new
> files introduced in this patch.
I will fix it in v2 patch.

> > diff --git a/t/t4018/javascript-assignment-of-arrow-function b/t/t4018/=
javascript-assignment-of-arrow-function
> > new file mode 100644
> > index 0000000000..6ab73ccb7a
> > --- /dev/null
> > +++ b/t/t4018/javascript-assignment-of-arrow-function
> > @@ -0,0 +1,4 @@
> > +const RIGHT =3D (a, b) =3D> {
> > +
> > +    return a + b; // ChangeMe
> > +};
> > \ No newline at end of file
> > diff --git a/t/t4018/javascript-assignment-of-named-function b/t/t4018/=
javascript-assignment-of-named-function
> > new file mode 100644
> > index 0000000000..85d43123a6
> > --- /dev/null
> > +++ b/t/t4018/javascript-assignment-of-named-function
> > @@ -0,0 +1,4 @@
> > +const RIGHT =3D function test (a, b) {
> > +
> > +    return a + b; // ChangeMe
> > +};
> > \ No newline at end of file
> > diff --git a/t/t4018/javascript-async-function b/t/t4018/javascript-asy=
nc-function
> > new file mode 100644
> > index 0000000000..ebc7c8c05b
> > --- /dev/null
> > +++ b/t/t4018/javascript-async-function
> > @@ -0,0 +1,4 @@
> > +async function RIGHT(a, b) {
> > +
> > +  return a + b; // ChangeMe
> > +}
> > \ No newline at end of file
> > diff --git a/t/t4018/javascript-export-async-function b/t/t4018/javascr=
ipt-export-async-function
> > new file mode 100644
> > index 0000000000..3cd60b7980
> > --- /dev/null
> > +++ b/t/t4018/javascript-export-async-function
> > @@ -0,0 +1,4 @@
> > +export async function RIGHT(a, b) {
> > +
> > +  return a + b; // ChangeMe
> > +}
> > \ No newline at end of file
> > diff --git a/t/t4018/javascript-export-function b/t/t4018/javascript-ex=
port-function
> > new file mode 100644
> > index 0000000000..177ddec779
> > --- /dev/null
> > +++ b/t/t4018/javascript-export-function
> > @@ -0,0 +1,4 @@
> > +export function RIGHT(a, b) {
> > +
> > +  return a + b; // ChangeMe
> > +}
> > \ No newline at end of file
> > diff --git a/t/t4018/javascript-exports-anomyous-function b/t/t4018/jav=
ascript-exports-anomyous-function
> > new file mode 100644
> > index 0000000000..45b0ecd659
> > --- /dev/null
> > +++ b/t/t4018/javascript-exports-anomyous-function
> > @@ -0,0 +1,4 @@
> > +exports.setFlagged =3D RIGHT =3D> {
> > +
> > +    return ChangeMe;
> > +};
> > \ No newline at end of file
> > diff --git a/t/t4018/javascript-exports-anomyous-function-2 b/t/t4018/j=
avascript-exports-anomyous-function-2
> > new file mode 100644
> > index 0000000000..0c572bfde3
> > --- /dev/null
> > +++ b/t/t4018/javascript-exports-anomyous-function-2
> > @@ -0,0 +1,4 @@
> > +exports.RIGHT =3D (a, b, runtime) =3D> {
> > +
> > +    return ChangeMe;
> > +};
> > \ No newline at end of file
> > diff --git a/t/t4018/javascript-exports-function b/t/t4018/javascript-e=
xports-function
> > new file mode 100644
> > index 0000000000..f1587fddac
> > --- /dev/null
> > +++ b/t/t4018/javascript-exports-function
> > @@ -0,0 +1,4 @@
> > +exports.RIGHT =3D function(document) {
> > +
> > +    return ChangeMe
> > +}
>
> Not a particularly important point, but the correct syntax requires a
> semicolon here, I guess.
>
Yes, I forgot the semicolon here.

> > +                                     delete $installedChunks$[chunkId]=
;
> > +                             });
> > +                             currentUpdateRemovedChunks =3D ChangeMe;
> > +   }
> > +  }
> > +}
> > \ No newline at end of file
> > diff --git a/t/t4018/javascript-function-belong-to-IIFE b/t/t4018/javas=
cript-function-belong-to-IIFE
> > new file mode 100644
> > index 0000000000..6a80118e8a
> > --- /dev/null
> > +++ b/t/t4018/javascript-function-belong-to-IIFE
> > @@ -0,0 +1,6 @@
> > +(function () {
> > +  this.$RIGHT =3D function (needle, modifier) {
> > +      let a =3D 5;
> > +      return ChangeMe;
> > +  };
> > +}).call(aaaa.prototype);
> > \ No newline at end of file
> > diff --git a/t/t4018/javascript-function-in-class b/t/t4018/javascript-=
function-in-class
> > new file mode 100644
> > index 0000000000..4b2f9c37e0
> > --- /dev/null
> > +++ b/t/t4018/javascript-function-in-class
> > @@ -0,0 +1,6 @@
> > +class Test {
> > +  RIGHT() {
> > +    let a =3D 4;
> > +    let b =3D ChangeMe;
> > +  }
> > +}
> > \ No newline at end of file
> > diff --git a/t/t4018/javascript-function-in-class-2 b/t/t4018/javascrip=
t-function-in-class-2
> > new file mode 100644
> > index 0000000000..402c4aecc3
> > --- /dev/null
> > +++ b/t/t4018/javascript-function-in-class-2
> > @@ -0,0 +1,11 @@
> > +class Test {
> > +  RIGHT(
> > +      aaaaaaaaaa,
> > +      bbbbbbbbbb,
> > +      cccccccccc,
> > +      dddddddddd
> > +  ) {
> > +    let a =3D 4;
> > +    let b =3D ChangeMe;
> > +  }
> > +}
> > \ No newline at end of file
>
> In the above two, we see class member functions. Is there a test case
> where the function parameter is on the same line as the function name or
> is that one of the difficult cases?
I can't get what you mean, but the second Test case wants to make sure we
can match the function with a long parameter list, and its parameters are
formatted to multiline.

> > diff --git a/t/t4034/javascript/post b/t/t4034/javascript/post
> > new file mode 100644
> > index 0000000000..8bc3e3af12
> > --- /dev/null
> > +++ b/t/t4034/javascript/post
> > @@ -0,0 +1,32 @@
> > +// DecimalLiteral
> > +124
> > +0.124
> > +0.123e-5
> > +0.123E-5
> > +0.123E5
> > +12222222222222222233344445n
> > +// HexIntegerLiteral
> > +0x11
> > +0X5Fa1
> > +0x123_756
> > +0x1234182989812f1289bn
> > +// OctalIntegerLiteral
> > +06
> > +0o5
> > +0O4
> > +0511_567
> > +0o424242424242424242424242424242666667n
> > +// BinaryIntegerLiteral
> > +0b1101
> > +0B0010
> > +0b0001_1101_0011
> > +0b11111111111111000011111111111111111n
> > +// punctuations
> > +{b} (b)
> > +b;
> > +[2,3]
> > +[ ...params_v2 ]
> > +a=3D2 a=3D2 a=3D2 a=3D2 a=3D2 a=3D2 a=3D2 a=3D2
> > +a-=3Db a%=3Db a&&=3Db a|=3Db
> > +b-c a++ a<<b a>>>=3Db a<<=3Db
> > +a&b a|b a??=3Db
> > \ No newline at end of file
> > diff --git a/t/t4034/javascript/pre b/t/t4034/javascript/pre
> > new file mode 100644
> > index 0000000000..b72238f779
> > --- /dev/null
> > +++ b/t/t4034/javascript/pre
> > @@ -0,0 +1,32 @@
> > +// DecimalLiteral
> > +123
> > +0.123
> > +0.123e+5
> > +0.123E+5
> > +0.123e5
> > +1222222222222222223334444n
> > +// HexIntegerLiteral
> > +0x10
> > +0X6Fa1
> > +0x123_456
> > +0x1234182989812f1289an
> > +// OctalIntegerLiteral
> > +05
> > +0o6
> > +0O7
> > +0512_567
> > +0o424242424242424242424242424242666666n
> > +// BinaryIntegerLiteral
> > +0b1001
> > +0B0110
> > +0b0001_1001_0011
> > +0b1111111111111111111111111111111111111n
> > +// punctuations
> > +{a} (a)
> > +a;
> > +[1,2]
> > +[ 1, 2, ...params ]
> > +a<=3D2 a>=3D2 a=3D=3D2 a!=3D2 a=3D=3D=3D2 a!=3D=3D2 a^=3D2 a=3D>2
> > +a+=3Db a*=3Db a**=3Db a||=3Db
> > +b+c a-- a>>b a>>>b a>>=3Db
> > +a&&b a||b a&&=3Db
> > \ No newline at end of file
> > diff --git a/userdiff.c b/userdiff.c
> > index 8578cb0d12..a6a341e3c1 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -168,6 +168,44 @@ PATTERNS("java",
> >        "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
> >        "|[-+*/<>%&^|=3D!]=3D"
> >        "|--|\\+\\+|<<=3D?|>>>?=3D?|&&|\\|\\|"),
> > +
> > +PATTERNS("javascript",
> > +      /* don't match the expression may contain parenthesis, because i=
t is not a function declaration */
> > +      "!^[ \t]*(if|do|while|for|with|switch|catch|import|return)\n"
>
> These will not match
>
>         }while (expr)
>
> note the absent blank before the keyword, but that is an acceptable
> trade-off to keep things simple. Good.
>
I thought not to match with `}while (expr)` is OK because this rule is
mainly to prevent matching too many
 wrong things about the regex for =E3=80=8Cthe function in the class=E3=80=
=8D.
And before keywords maybe need blanks, because some javascript
formatting style is using space
instead of tab.


> > +      /* don't match statement */
> > +      "!^.*;[ \t]*\n"
>
> This regexp can be reduced to
>
>         "!;\n"
>
good advice, I would apply it.

> > +      /* match normal function */
> > +      "^[\t ]*((export[\t ]+)?(async[\t ]+)?function[\t ]*([\t ]*\\*[\=
t ]*|[\t ]*)?[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)\n"
>
> Good. One note though: keyword "function" can optionally be followed by
> an asterisk '*'. You can probably simplify the middle part to
>
>         ...function[\t *]*...identifier...
good advice, I would apply it.

> > +      /* match JavaScript variable declaration with a lambda expressio=
n */
> > +      "^[\t ]*((const|let|var)[\t ]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*=
=3D[\t ]*"
> > +      "(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*[\t ])[\t ]*=3D>[\t ]*\\{?=
)\n"
>
> Let's break this down:
>
>         "^[\t ]*"
>             "("
>                 "(const|let|var)[\t ]*"
>                 "[$_[:alpha:]][$_[:alnum:]]*[\t ]*"
>                 "=3D[\t ]*"
>                 "("
>                     "\\(.*\\)"
>                     "|"
>                     "[$_[:alpha:]][$_[:alnum:]]*[\t ]"
>                 ")[\t ]*"
>                 "=3D>[\t ]*"
>                 "\\{?"
>             ")\n"
>
> Can you not have
>
>         var f =3D foo=3D>{
>
> because I see that whitespace is required between the identifier and "=3D=
>"?
It is my mistake. I should not match tab or space between identifier and =
=3D>.
Thanks for pointing it out. I will fix it.

> > +      /* match exports for anonymous fucntion */
> > +      "^[\t ]*(exports\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=3D[\t ]*(\\=
(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=3D>.*)\n"
>
> Here, whitespace is not required. Is the above an oversight?
>
> BTW, can keyword "exports" be used for something other than functions?
>
=E3=80=8CWhitespace is not required=E3=80=8D is only referred to =E3=80=8C^=
[\t ]*(exports=E3=80=8D? I
would remove the [\t ]* before exports
keyword because exports must be top-level.
The exports keyword can be used for exporting many things, such as
string. ex: exports.SimpleMessage =3D 'Hello world';
, So I define a more precise regex for only matching anonymous functions.

> > +      /* match assign function to LHS */
> > +      "^(.*=3D[\t ]*function[\t ]*([$_[:alpha:]][$_[:alnum:]]*)?[\t ]*=
\\(.*)\n"
>
> This makes me think that whenever the keyword "function" appears, then we
> see the beginning of a function. This would allow a simple pattern
> upfront that picks out all functions defined with this keyword, and all
> other patterns need only be concerned with the exceptional cases.
>
>         /* "function" is first non-space token */
>         "^[\t ]*function[\t ].*)\n"
>         /* "function" is not first token */
>         "^.*[^$_[:alnum:]]function[\t ].*\n"
This is good advice, I would try.

> > +      /* match normal function in object literal */
> > +      "^[\t ]*([$_[:alpha:]][$_[:alnum:]]*[\t ]*:[\t ]*function[\t ].*=
)\n"
> > +      /* don't match the function in class, which has more than one id=
ent level */
> > +      "!^(\t{2,}|[ ]{5,})\n"
>
> For some, hopefully universally agreed upon in the JavaScript community,
> definition of indentation level. Ok...
I had searched the web, the javascript's style about indentation level
has two kinds -
ident with 2 or 4 spaces. So I don't match the line, which begins with
more than four
spaces. If javascript must end with a semicolon, it doesn't need this rule =
:(

> > +      /* match function in class */
> > +      "^[\t ]*((static[\t ]+)?((async|get|set)[\t ]+)?[$_[:alpha:]][$_=
[:alnum:]]*[\t ]*\\(.*)",
>
> Aren't "get" and "set" as universal identifiers of functions or can they
> occur on other contexts? Thinking of it, they can occur in comments
> everywhere, so they would pick up too many matches if treated like my
> "function" proposal above.
"get" and "set" are not javascript keywords, we could write code like
"let get =3D 5;"
In my view, it wouldn't match the comment, because the comment has "//" or =
"/*.
But I would think about it.

> > +      /* word regex */
> > +      /* hexIntegerLiteral and bigHexIntegerLiteral*/
> > +      "0[xX][0-9a-fA-F][_0-9a-fA-F]*n?|"
> > +      /* octalIntegerLiteral and bigOctalIntegerLiteral */
> > +      "0[oO]?[0-7][_0-7]*n?|"
> > +      /* binaryIntegerLiteral and bigBinaryIntegerLiteral */
> > +      "(0[bB][01][_01]*n?)|"
> > +      /* decimalLiteral */
> > +      "(0|[1-9][_0-9]*)?\\.?[0-9][_0-9]*([eE][+-]?[_0-9]+)?|"
> > +      /* bigDecimalLiteral */
> > +      "(0|[1-9][_0-9]*)n|"
>
> You do not have to make the word-regex so tight that it excludes
> incorrect literals because you can assume that incorrect literals will
> not occur. In particular integers beginning with a 0 need not be treated
> specially. You can fold the octal and decimal integers into a single
> expression:
>
>         "[0-9][oO]?[_0-9.]*)([eE][+-]?[_0-9]+)?n?"
>
> Are floatingpoint literals beginning with a decimal point like .5 not
> permitted?
This is permitted. ex: "let a =3D .5" is valid.
And I would follow your advice to combine multiple regexes.

> Please follow the custom to place the alternation character "|" at the
> beginning of the next line, not at the end of the previous.
OK.

> > +      /* punctuations */
> > +      "\\{|\\}|\\(|\\)|\\.|\\.{3}|;|,|<|>|<=3D|>=3D|=3D=3D|!=3D|=3D{3}=
|!=3D=3D|\\+|-|\\*|/|%|\\*{2}|"
> > +      "\\+{2}|--|<<|>>|>>>|&|\\||\\^|!|~|&&|\\|{2}|\\?{1,2}|:|=3D|\\+=
=3D|-=3D|\\*=3D|%=3D|\\*{2}=3D|"
> > +      "<<=3D|>>=3D|>>>=3D|&=3D|\\|=3D|\\^=3D|&&=3D|\\|{2}=3D|\\?{2}=3D=
|=3D>|"
>
> You could collaps many of the operators into single alternatives, but if
> you prefer it this way, it is fine, too. One example:
>
>         ">{1,3}=3D"
>
> But please remove the single-character operators from the list, because
> there is an implicit single-character alternative that is not visible in
> the code here.
>
> > +      /* identifiers */
> > +      "[$_[:alpha:]][$_[:alnum:]]*"),
> >  PATTERNS("markdown",
> >        "^ {0,3}#{1,6}[ \t].*",
> >        /* -- */
>
> -- Hannes
OK.

In the end, I am very much grateful for your review.

Best regards.
