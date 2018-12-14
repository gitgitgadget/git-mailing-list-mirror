Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AF6020A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 23:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbeLNXO3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 18:14:29 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35768 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbeLNXO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 18:14:28 -0500
Received: by mail-oi1-f193.google.com with SMTP id v6so5912112oif.2
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 15:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KPKkoEZKg9R+u8F97wCxePMKxxkoC1HXYmqawQdApF8=;
        b=TCafLNnr4lo4a1KSWnAjrLYxv5NKJnOqm6sU0rCtx+csGGtI+Dm2FB2RI3u6+weSq7
         ca7cwdajxYoC4aSQY0wo2S5I1LdWUKFDTHOfDl0mPitvEHpkvQQJR+XVoQSDLw+J0Q6v
         1BMyH4CfFMfViLdKTPZthXVRcT9KotEun/7pVFU9H4k7S5x2IU4vgDU3hwnw/aGf7urm
         7NUWFkemjnEfE0Q+SdJf2NbFUl2MQRmXSEnWLnEYZaZpDysyqlPFUc524CtiYTNAV5h9
         6bAMsM0eXFikbENricKV6w3TeytGMDQvxEOv/YxJUnVlkMBugDjhmsypjJp3KQ71iVCe
         L7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KPKkoEZKg9R+u8F97wCxePMKxxkoC1HXYmqawQdApF8=;
        b=HdRB3KHtAT7pUIkbuTzieZnaXSGOVhBGtyvrteKW8TeUjVnxOkUhyksyIVHs55IImQ
         rVz2xZhJXUI06aV1kXr/BqLk1nA4LImCNC6Wbm1cVWq/XXEor+vBf34CKAyi0gnDefUP
         CKFRwHC0svchflKTSDVT1s9JYGobxK4FpGO6DJJImUzy/VVD+wElThsBvYxqqHJVybSA
         mtk7hPDWUq1y82rq8yPkmZZtxtEh8zu+9p3TcYLpjvkQAnQ5OVJdw3ACvPeOGumoqu7F
         z/LUJwH647dVA4HO+tVt+RDn1bOc4PGXh8KvhWOPh07TRzzEoqhs79eZYssfkvxq8uhG
         DOZw==
X-Gm-Message-State: AA+aEWbgpJ7sPXTLCfro3KFIJyefx0mItxSb63RePqJ/24YDHZqi3Uwo
        5B3Mg1q6FNClq4qhf0CKYFkvlQsWGbnjZExj8/A=
X-Google-Smtp-Source: AFSGD/WUAg1NZU02NbCTB7Rh/FN6Lc46MpFeSLiav8wBrt8KJqxli3hY8XkgQC2bu1pTdacGDdB4O7UWlgAuSe1A/Lw=
X-Received: by 2002:a54:400d:: with SMTP id x13mr225486oie.225.1544829266314;
 Fri, 14 Dec 2018 15:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20181213212256.48122-1-john.a.passaro@gmail.com>
 <1544760713.970.1.camel@gentoo.org> <CAJdN7KjExd6T+H4-wEupO2dg_mMWzeA22oYaskkfhz+GuFbfRQ@mail.gmail.com>
 <1544806139.7371.1.camel@gentoo.org> <CAJdN7KgWQyjrfifqNEr5SeHM0F1KzrKyoK0gy0AeTd-jPvMtCw@mail.gmail.com>
In-Reply-To: <CAJdN7KgWQyjrfifqNEr5SeHM0F1KzrKyoK0gy0AeTd-jPvMtCw@mail.gmail.com>
From:   John Passaro <john.a.passaro@gmail.com>
Date:   Fri, 14 Dec 2018 18:13:48 -0500
Message-ID: <CAJdN7KggRedPRfGRExTy8q6rGAAgbTCBc+_tdzSwF5kEYom9fg@mail.gmail.com>
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

On Fri, Dec 14, 2018 at 6:10 PM John Passaro <john.a.passaro@gmail.com> wro=
te:
>
> On Fri, Dec 14, 2018 at 11:49 AM Micha=C5=82 G=C3=B3rny <mgorny@gentoo.or=
g> wrote:
> >
> > On Fri, 2018-12-14 at 11:07 -0500, John Passaro wrote:
> > > On Thu, Dec 13, 2018 at 11:12 PM Micha=C5=82 G=C3=B3rny <mgorny@gento=
o.org> wrote:
> > > >
> > > > On Thu, 2018-12-13 at 16:22 -0500, John Passaro wrote:
> > > > > Currently, users who do not have GPG installed have no way to dis=
cern
> > > > > signed from unsigned commits without examining raw commit data. I
> > > > > propose two new pretty-print placeholders to expose this informat=
ion:
> > > > >
> > > > > %GR: full ("R"aw) contents of gpgsig header
> > > > > %G+: Y/N if the commit has nonempty gpgsig header or not
> > > > >
> > > > > The second is of course much more likely to be used, but having e=
xposed
> > > > > the one, exposing the other too adds almost no complexity.
> > > > >
> > > > > I'm open to suggestion on the names of these placeholders.
> > > > >
> > > > > This commit is based on master but e5a329a279 ("run-command: repo=
rt exec
> > > > > failure" 2018-12-11) is required for the tests to pass.
> > > > >
> > > > > One note is that this change touches areas of the pretty-format
> > > > > documentation that are radically revamped in aw/pretty-trailers: =
see
> > > > > 42617752d4 ("doc: group pretty-format.txt placeholders descriptio=
ns"
> > > > > 2018-12-08). I have another version of this branch based on that =
branch
> > > > > as well, so you can use that in case conflicts with aw/pretty-tra=
ilers
> > > > > arise.
> > > > >
> > > > > See:
> > > > > - https://github.com/jpassaro/git/tree/jp/pretty-expose-gpgsig
> > > > > - https://github.com/jpassaro/git/tree/jp/pretty-expose-gpgsig--b=
ased-on-aw-pretty-trailers
> > > > >
> > > > > John Passaro (4):
> > > > >   pretty: expose raw commit signature
> > > > >   t/t7510-signed-commit.sh: test new placeholders
> > > > >   doc, tests: pretty behavior when gpg missing
> > > > >   docs/pretty-formats: add explanation + copy edits
> > > > >
> > > > >  Documentation/pretty-formats.txt |  21 ++++--
> > > > >  pretty.c                         |  36 ++++++++-
> > > > >  t/t7510-signed-commit.sh         | 125 +++++++++++++++++++++++++=
++++--
> > > > >  3 files changed, 167 insertions(+), 15 deletions(-)
> > > > >
> > > > >
> > > > > base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
> > > > > prerequisite-patch-id: aedfe228fd293714d9cd0392ac22ff1cba7365db
> > > >
> > > > Just a suggestion: since the raw signature is not very useful witho=
ut
> > > > the commit data to check it against, and the commit data is non-tri=
vial
> > > > to construct (requires mangling raw data anyway), maybe you could e=
ither
> > > > add another placeholder to get the data for signature verification,=
 or
> > > > (alternatively or simultaneously) add a placeholder that prints bot=
h
> > > > data and signature in the OpenPGP message format (i.e. something yo=
u can
> > > > pass straight to 'gpg --verify').
> > > >
> > >
> > > That's a great idea!
> > >
> > > Then I might rename the other new placeholders too:
> > >
> > > %Gs: signed commit signature (blank when unsigned)
> > > %Gp: signed commit payload (i.e. in practice minus the gpgsig header;
> > > also blank when unsigned as well)
> > > %Gq: query/question whether is signed commit ("Y"/"N")
> > >
> > > Thus establishing %G<lowercase> as the gpg-related placeholders that
> > > do not actually require gpg.
> > >
> > > And add a test that %Gp%n%Gs or the like passes gpg --verify.
> > >
> > > I'll put in a v2 later today or tomorrow. Thank you for the feedback!
> > >
> >
> > Technically speaking, '%Gp%n%Gs' sounds a bit odd, given that
> > the payload needs to be preceded by the PGP message header but instead
> > of footer it has the signature's header.  Also note that some lines in
> > the payload may need to be escaped.
>
> It's indeed failing with
> "-----BEGIN PGP SIGNED MESSAGE-----%n%Gp%n%Gs"
>
> This appears to be a misunderstanding on my part of how cleartext GPG
> messages work, as this message seems to fail verification even when I
> construct it manually:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> tree 3820419b50e9827493beedf6a1423e7d9c7edf3b
> parent 356f37356edf1a45c8494870e1c051e2fbe529fa
> author A U Thor <author@example.com> 1112912413 -0700
> committer C O Mitter <committer@example.com> 1112912533 -0700
>
> sixth
> -----BEGIN PGP SIGNATURE-----
>
> iHQEABECADQWIQRz11h0S+chaY7FTocTtvUezd5DDQUCXBQzKRYcY29tbWl0dGVy
> QGV4YW1wbGUuY29tAAoJEBO29R7N3kMN2QYAnA2A/VpD4qMI9rJlIYnyyO32rTXz
> AJ0drWlJsASMcf6AEX6nSQPxWq81Fg=3D=3D
> =3Dfr2F
> -----END PGP SIGNATURE-----
>
> I got this by running tho following inside the trash directory for t7510,
> which as far as I can tell is roughly equivalent to
> The gpg --verify fails.
> {
>   echo "-----BEGIN PGP SIGNED MESSAGE-----"
>   echo Hash: SHA256
>   echo
>   git cat-file commit sixth-signed | perl -ne '/^(?:gpgsig)? / || print'
>   git cat-file commit sixth-signed | perl -ne 's/^(?:gpgsig)? // && print=
'
> } | tee commit-as-signed-message | gpg --verify

I should add that when I took out Hash: SHA256 (don't ask), gpg went
from saying "signature digest conflict" to saying "BAD signature". Not
quite as bad but still confusing.
>
> All seems to work fine when I treat %Gs as a detached signature.
> How should the combined message be constructed properly? (Goes
> to usefulness of printing signature payload, and indeed of raw crypto
> data in general.)
>
>
> > --
> > Best regards,
> > Micha=C5=82 G=C3=B3rny
