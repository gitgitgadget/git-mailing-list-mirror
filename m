Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F17A20248
	for <e@80x24.org>; Tue, 19 Mar 2019 07:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfCSHC2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 03:02:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40283 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSHC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 03:02:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so4069045pfc.7
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 00:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p2Yf/e/P37OF7gUU/g/pNc7a6CIDDvtKnTXbxhCM1lA=;
        b=OFRVtmytPsEPZkVcsgk3jdxwTkVuR1UIiMvo/yTcVfkyH4ieh65s4jj1ySln50fMQX
         Ik6CNFHU0QtYEuQfHyXcgyhBERQWgWnUxqk1bQzQwZscY6dRfBn8C63iYR49bHI4SlHe
         DF/rMhusnYTcvl8cWevSZlNvsYWs17sXRmDPHiB8UaB4Ku4MdX3IN20Jn8LO8Zv3ZyrY
         QONPyfJXWLRI2Kp4RcX5eatNp60iZ5uNj/Ip9hrtS1OcltGGiGIuV3vaKgbQgnJ5Hl7q
         qLN+NUAn1dr402SQ6I0gY3MPU3Qx0DVTDq4965AZvak4LyZ0k8w4kWgdTdmtotE6JWzB
         VwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p2Yf/e/P37OF7gUU/g/pNc7a6CIDDvtKnTXbxhCM1lA=;
        b=mZ6qwHG3L264WlLsOvGreJuHywuEJZaQacnGFIJxuDbDEYig7ZZfNYYyITDfQISPfM
         TQuImhKeMZo+VMm95rneNl9oOpQZTCvTa5dD2lnBtCJ7lSguJK4y99kAYzdOcm5uUO+0
         uAphPFt9qB5rTvNl/7RSO/Hz0SHD0AEckkK96ehac/eAAtZWVnNSlNivsyhLFoM+nOYW
         fGcdhvYJjynGHz/h0qNsMstNF+H+jcuziBoKxGjUPFRAhUdoVSQ53jURk42h9aLLOhBT
         AtRIc2GHiKkyPe+bIS/8oFjQRWtfn8a5DMRUHYunaW3djb60mvWp5qn7yM0w06N8jEbH
         fMyw==
X-Gm-Message-State: APjAAAV9aTQ4Ti0t0aoXsysNHO+eiQpJsu7QbLVbztZDTzrZVu3IGHWe
        8NE2Qdjm8C8GWZX3aM4koM5ahHZzxHDujoSCJhBMN9iv
X-Google-Smtp-Source: APXvYqw8FDKwG6KrmkO2U37a3eCxhFZmqDw7XC7Yp+iUUE6OlUmXBiRqjz4sfZD+2iN5jqIaGa4oJ3HpgvGXyf4TjEA=
X-Received: by 2002:a17:902:5a8c:: with SMTP id r12mr486311pli.130.1552978947933;
 Tue, 19 Mar 2019 00:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190317144747.2418514-1-martin.agren@gmail.com> <20190317194431.GY31362@pobox.com>
In-Reply-To: <20190317194431.GY31362@pobox.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 19 Mar 2019 08:02:14 +0100
Message-ID: <CAN0heSrajiswzpm+au_5nmZMZG9406iZa-CK9p5CaHLTuxm8nw@mail.gmail.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Mar 2019 at 20:44, Todd Zullinger <tmz@pobox.com> wrote:
> Martin =C3=85gren wrote:
> >   * Provide the `mansource` attribute to Asciidoctor. This attribute
> >     looks promising until one realizes that it can only be given inside
> >     the source file (the .txt file in our case), *not* on the command
> >     line using `-a mansource=3Dfoobar`. I toyed with the idea of inject=
ing
> >     this attribute while feeding Asciidoctor the input on stdin, but it
> >     didn't feel like it was worth the complexity in the Makefile.
>
> I played with this direction before.  Using Asciidoctor we
> can convert directly from .txt to man without docbook
> and xmlto.  That does have some other issues which need to
> be worked out though.  Here's what I had as a start:

> +ASCIIDOC_EXTRA +=3D -a mansource=3D"Git $(GIT_VERSION)" -a manmanual=3D"=
Git Manual"

So to be honest, I still don't understand how this works, but it does,
great. I really need to improve my documentation-reading skills.

> I munged up doc-diff to set MANDWIDTH=3D1000 and set one
> branch to default to asciidoctor to compare.  (Your other
> recent series looks like it'll make doing asciidoc and
> asciidoctor comparisons easier.)
>
> There were a number of differences that I didn't work
> through though.  Most importantly was the change in the
> links noted in the commit message.

I had some more time to look at this. Thanks for getting started on this
switch. A few things I noticed:

{litdd} now renders as &#x2d;&#x2d. We should find some other way to
produce '--'. This should then be a simple change, as we're already
providing this attribute inside an `ifdef USE_ASCIIDOCTOR`.

"+" becomes "&#43;". I didn't immediately find where we do that.

Backticks should result in monospace.

`./doc-diff HEAD^ HEAD` shows how several "git-\nfoo" become
"\ngit-foo", i.e., linkgit expansions are now treated as non-breaking.
That's arguably good, but it brings some noise to the diff. Maybe one
should try and see if it's possible to break that to have a nicer
diff, then remove that breakage in a follow-up commit. Or, if it's
possible to make "git-foo" non-breaking before the switch. Hmm, was this
why you increased MANWIDTH?

A double-space between sentences turns into a single space -- at least
in constructions such as "... to foobar. `git-foo` does ...". Not a
problem perhaps, but noise in the diff.

And I'm sure there's more lurking in that huge diff. Whether any of that
is significant or not is another matter. ;-)


Martin
