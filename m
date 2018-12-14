Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A18220A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 16:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbeLNQHn (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 11:07:43 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38270 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbeLNQHn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 11:07:43 -0500
Received: by mail-ot1-f66.google.com with SMTP id e12so5864954otl.5
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 08:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dMFAgECtMq2xfv25VJzLc8+NSCWi6ICclbN/5rd+qxg=;
        b=HAcyUGaOPibSW6+GWUX+JAzDzi7HZVIkCRr7vCmlTVgF3K4r4JVbSUYda74pAF9fm/
         SZZs4Hh8lSwxLQt3uysi2cn5LB51lA+o37sv4f2SnQ2HwOELisyaA6Y1GxKvMXuzygOP
         oJjOSYwEl48HeIuLZW6XBhj5HoFre0YJj2xNr25C6U7nGNFiiFDStBuoD2kv5SMvqFTG
         Nf+YTnZQvmH8iGdf4Z9rQOh4nr7pGXJglS1wnP3cALXnYJ56D9UKiAl4Nz/yip7BEKtL
         XbhpxgmvuwspA9xWDICIY04OAnjdCxRxAx5OgkDroXkGBrawhmCn9wtM2rP6kXb8BZI4
         urgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dMFAgECtMq2xfv25VJzLc8+NSCWi6ICclbN/5rd+qxg=;
        b=ft9MBPPBJ1CpNXtod34l76CKBTgaphaV56VC+sDxpIMmxq7UEAgvkliXzEVLJaGdSC
         OdSIXhXPKg962mh3oZmnNElsEdKJPEbgaikdju5mTlYglYrbYn9JP9Sshsie5WWgMsAc
         jLnSAeWM3IOAzgxpeGld4Qs6ko8GSE2kmwWxGTC0o7Gu2K2FBz2b6EFo7oL3jpSG5j9C
         Ikb4bzorTXTVGoNooM4vZYZColbk+zgjiUGU+3GQUgcwi7hVzw4SWOi2SH9dJz15MCuX
         4GZtsjFguHT9hiQyRISSvjNSuNnWDUqDOLexWIFdRHQv5yGq9NUKUKbKrN9VdrVZuBGo
         hzjQ==
X-Gm-Message-State: AA+aEWZtPmSF07fcSxwRrMBp7BElWNWs3v/VReJC++eLqNTVcUO8tkIC
        nHLWyUY2k57Jl2XsSiJR1WNbtVWOyfUfVDEsNCA=
X-Google-Smtp-Source: AFSGD/WtNS3GvrM8cpGHLLrZa+NMDZcMRE8/q8Jmvtbgq75IahQPJCxXD4WDk9NJs7aPFQ/2cRbZ4IbnFHP3FbLTSdU=
X-Received: by 2002:a9d:a83:: with SMTP id 3mr2524400otq.88.1544803661579;
 Fri, 14 Dec 2018 08:07:41 -0800 (PST)
MIME-Version: 1.0
References: <20181213212256.48122-1-john.a.passaro@gmail.com> <1544760713.970.1.camel@gentoo.org>
In-Reply-To: <1544760713.970.1.camel@gentoo.org>
From:   John Passaro <john.a.passaro@gmail.com>
Date:   Fri, 14 Dec 2018 11:07:03 -0500
Message-ID: <CAJdN7KjExd6T+H4-wEupO2dg_mMWzeA22oYaskkfhz+GuFbfRQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Expose gpgsig in pretty-print
To:     =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Alexey Shumkin <alex.crezoff@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 11:12 PM Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>=
 wrote:
>
> On Thu, 2018-12-13 at 16:22 -0500, John Passaro wrote:
> > Currently, users who do not have GPG installed have no way to discern
> > signed from unsigned commits without examining raw commit data. I
> > propose two new pretty-print placeholders to expose this information:
> >
> > %GR: full ("R"aw) contents of gpgsig header
> > %G+: Y/N if the commit has nonempty gpgsig header or not
> >
> > The second is of course much more likely to be used, but having exposed
> > the one, exposing the other too adds almost no complexity.
> >
> > I'm open to suggestion on the names of these placeholders.
> >
> > This commit is based on master but e5a329a279 ("run-command: report exe=
c
> > failure" 2018-12-11) is required for the tests to pass.
> >
> > One note is that this change touches areas of the pretty-format
> > documentation that are radically revamped in aw/pretty-trailers: see
> > 42617752d4 ("doc: group pretty-format.txt placeholders descriptions"
> > 2018-12-08). I have another version of this branch based on that branch
> > as well, so you can use that in case conflicts with aw/pretty-trailers
> > arise.
> >
> > See:
> > - https://github.com/jpassaro/git/tree/jp/pretty-expose-gpgsig
> > - https://github.com/jpassaro/git/tree/jp/pretty-expose-gpgsig--based-o=
n-aw-pretty-trailers
> >
> > John Passaro (4):
> >   pretty: expose raw commit signature
> >   t/t7510-signed-commit.sh: test new placeholders
> >   doc, tests: pretty behavior when gpg missing
> >   docs/pretty-formats: add explanation + copy edits
> >
> >  Documentation/pretty-formats.txt |  21 ++++--
> >  pretty.c                         |  36 ++++++++-
> >  t/t7510-signed-commit.sh         | 125 +++++++++++++++++++++++++++++--
> >  3 files changed, 167 insertions(+), 15 deletions(-)
> >
> >
> > base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
> > prerequisite-patch-id: aedfe228fd293714d9cd0392ac22ff1cba7365db
>
> Just a suggestion: since the raw signature is not very useful without
> the commit data to check it against, and the commit data is non-trivial
> to construct (requires mangling raw data anyway), maybe you could either
> add another placeholder to get the data for signature verification, or
> (alternatively or simultaneously) add a placeholder that prints both
> data and signature in the OpenPGP message format (i.e. something you can
> pass straight to 'gpg --verify').
>

That's a great idea!

Then I might rename the other new placeholders too:

%Gs: signed commit signature (blank when unsigned)
%Gp: signed commit payload (i.e. in practice minus the gpgsig header;
also blank when unsigned as well)
%Gq: query/question whether is signed commit ("Y"/"N")

Thus establishing %G<lowercase> as the gpg-related placeholders that
do not actually require gpg.

And add a test that %Gp%n%Gs or the like passes gpg --verify.

I'll put in a v2 later today or tomorrow. Thank you for the feedback!

--
JP
