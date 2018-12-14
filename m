Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0339420A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 23:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeLNXLW (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 18:11:22 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40067 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeLNXLV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 18:11:21 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so6999195oth.7
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 15:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kxjv2WK4hkuNUeHL3WRNh7D+zHz4P1sjNLBeb1j2R88=;
        b=uXCVjY8LWDa0LDif9XnEzo4c19rDKcilF77o5D0HA0Pcz77HQ6qbQeRkeqTCj2mMag
         GoLjGhJGCtHmKF4kd3IRwZCxcGatRGoImw7/+gzRid94hPAg1IYUdIMELWr7sVKU1Mcb
         cTDh3qWOotYzE+DQyrbai5L1eUdxmSFV+uOTwALB1v69SpIa1cEIrk3ehrMNR0wGGP8l
         6H0WJJBGMaanxmSrnWfLpo4sIDyK2cQFJ5/1ShQAu2S5iREe6+zzkPJtIjqFOs/EdWLb
         zZ8axcxtdP6xZZ0ML0An1NLUqSGOsUE5LcaZy5TmfNitFkPX3cuqtofA+CJbWrWFVA5R
         XGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kxjv2WK4hkuNUeHL3WRNh7D+zHz4P1sjNLBeb1j2R88=;
        b=CnGyTW4myU9jvwwdA+5DEjrPN+CuNEmBefgj5LcHOVIRGxoLwpotDeDvtMq+pHHF0s
         nhQKRLuPtS7fhAMgUz+TgdYvymRC0z2PjpWbJOudwhG3lLagIixVuKECG69Sle2/RD/o
         PTgBFItHTUqAg3RVxivKRe0NeDZGLEluqNNrH3AMfPJqc9ZeHGjgfd5tnLeguJajmVEe
         WvIhd4xMAP5S9rGjc1dGE/9PLJd5a55wh9S8OkvyRGHcWZ9uI+TM2Z7nTsZtaIM7ivpp
         SjVysmNN/r1GZn9UMB4IXUgWALAL4dgjoa29dCLOr/ikslPYggsUwutJL7swIEGJaP3X
         QJdA==
X-Gm-Message-State: AA+aEWbzI4sZcMpD1rkA9wJuJC7uDmMXXU2Arg4XHsHEeNywT0/K6FXF
        Gt2dMhkXmR3NKOfvboxNa4Jn0m0g6UzIIGYnQy7gWHk1
X-Google-Smtp-Source: AFSGD/XnnUohLigP1pNHx+Nkx6rWCjJpPAxRsnd4x8V35I9USeacMHSCatoaqCoSto6tSzosJIpIB3KQOJH5KC5QbcA=
X-Received: by 2002:a9d:6a8e:: with SMTP id l14mr3326380otq.348.1544829080348;
 Fri, 14 Dec 2018 15:11:20 -0800 (PST)
MIME-Version: 1.0
References: <20181213212256.48122-1-john.a.passaro@gmail.com>
 <1544760713.970.1.camel@gentoo.org> <CAJdN7KjExd6T+H4-wEupO2dg_mMWzeA22oYaskkfhz+GuFbfRQ@mail.gmail.com>
 <1544806139.7371.1.camel@gentoo.org>
In-Reply-To: <1544806139.7371.1.camel@gentoo.org>
From:   John Passaro <john.a.passaro@gmail.com>
Date:   Fri, 14 Dec 2018 18:10:41 -0500
Message-ID: <CAJdN7KgWQyjrfifqNEr5SeHM0F1KzrKyoK0gy0AeTd-jPvMtCw@mail.gmail.com>
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

On Fri, Dec 14, 2018 at 11:49 AM Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>=
 wrote:
>
> On Fri, 2018-12-14 at 11:07 -0500, John Passaro wrote:
> > On Thu, Dec 13, 2018 at 11:12 PM Micha=C5=82 G=C3=B3rny <mgorny@gentoo.=
org> wrote:
> > >
> > > On Thu, 2018-12-13 at 16:22 -0500, John Passaro wrote:
> > > > Currently, users who do not have GPG installed have no way to disce=
rn
> > > > signed from unsigned commits without examining raw commit data. I
> > > > propose two new pretty-print placeholders to expose this informatio=
n:
> > > >
> > > > %GR: full ("R"aw) contents of gpgsig header
> > > > %G+: Y/N if the commit has nonempty gpgsig header or not
> > > >
> > > > The second is of course much more likely to be used, but having exp=
osed
> > > > the one, exposing the other too adds almost no complexity.
> > > >
> > > > I'm open to suggestion on the names of these placeholders.
> > > >
> > > > This commit is based on master but e5a329a279 ("run-command: report=
 exec
> > > > failure" 2018-12-11) is required for the tests to pass.
> > > >
> > > > One note is that this change touches areas of the pretty-format
> > > > documentation that are radically revamped in aw/pretty-trailers: se=
e
> > > > 42617752d4 ("doc: group pretty-format.txt placeholders descriptions=
"
> > > > 2018-12-08). I have another version of this branch based on that br=
anch
> > > > as well, so you can use that in case conflicts with aw/pretty-trail=
ers
> > > > arise.
> > > >
> > > > See:
> > > > - https://github.com/jpassaro/git/tree/jp/pretty-expose-gpgsig
> > > > - https://github.com/jpassaro/git/tree/jp/pretty-expose-gpgsig--bas=
ed-on-aw-pretty-trailers
> > > >
> > > > John Passaro (4):
> > > >   pretty: expose raw commit signature
> > > >   t/t7510-signed-commit.sh: test new placeholders
> > > >   doc, tests: pretty behavior when gpg missing
> > > >   docs/pretty-formats: add explanation + copy edits
> > > >
> > > >  Documentation/pretty-formats.txt |  21 ++++--
> > > >  pretty.c                         |  36 ++++++++-
> > > >  t/t7510-signed-commit.sh         | 125 +++++++++++++++++++++++++++=
++--
> > > >  3 files changed, 167 insertions(+), 15 deletions(-)
> > > >
> > > >
> > > > base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
> > > > prerequisite-patch-id: aedfe228fd293714d9cd0392ac22ff1cba7365db
> > >
> > > Just a suggestion: since the raw signature is not very useful without
> > > the commit data to check it against, and the commit data is non-trivi=
al
> > > to construct (requires mangling raw data anyway), maybe you could eit=
her
> > > add another placeholder to get the data for signature verification, o=
r
> > > (alternatively or simultaneously) add a placeholder that prints both
> > > data and signature in the OpenPGP message format (i.e. something you =
can
> > > pass straight to 'gpg --verify').
> > >
> >
> > That's a great idea!
> >
> > Then I might rename the other new placeholders too:
> >
> > %Gs: signed commit signature (blank when unsigned)
> > %Gp: signed commit payload (i.e. in practice minus the gpgsig header;
> > also blank when unsigned as well)
> > %Gq: query/question whether is signed commit ("Y"/"N")
> >
> > Thus establishing %G<lowercase> as the gpg-related placeholders that
> > do not actually require gpg.
> >
> > And add a test that %Gp%n%Gs or the like passes gpg --verify.
> >
> > I'll put in a v2 later today or tomorrow. Thank you for the feedback!
> >
>
> Technically speaking, '%Gp%n%Gs' sounds a bit odd, given that
> the payload needs to be preceded by the PGP message header but instead
> of footer it has the signature's header.  Also note that some lines in
> the payload may need to be escaped.

It's indeed failing with
"-----BEGIN PGP SIGNED MESSAGE-----%n%Gp%n%Gs"

This appears to be a misunderstanding on my part of how cleartext GPG
messages work, as this message seems to fail verification even when I
construct it manually:

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

tree 3820419b50e9827493beedf6a1423e7d9c7edf3b
parent 356f37356edf1a45c8494870e1c051e2fbe529fa
author A U Thor <author@example.com> 1112912413 -0700
committer C O Mitter <committer@example.com> 1112912533 -0700

sixth
-----BEGIN PGP SIGNATURE-----

iHQEABECADQWIQRz11h0S+chaY7FTocTtvUezd5DDQUCXBQzKRYcY29tbWl0dGVy
QGV4YW1wbGUuY29tAAoJEBO29R7N3kMN2QYAnA2A/VpD4qMI9rJlIYnyyO32rTXz
AJ0drWlJsASMcf6AEX6nSQPxWq81Fg=3D=3D
=3Dfr2F
-----END PGP SIGNATURE-----

I got this by running tho following inside the trash directory for t7510,
which as far as I can tell is roughly equivalent to
The gpg --verify fails.
{
  echo "-----BEGIN PGP SIGNED MESSAGE-----"
  echo Hash: SHA256
  echo
  git cat-file commit sixth-signed | perl -ne '/^(?:gpgsig)? / || print'
  git cat-file commit sixth-signed | perl -ne 's/^(?:gpgsig)? // && print'
} | tee commit-as-signed-message | gpg --verify

All seems to work fine when I treat %Gs as a detached signature.
How should the combined message be constructed properly? (Goes
to usefulness of printing signature payload, and indeed of raw crypto
data in general.)


> --
> Best regards,
> Micha=C5=82 G=C3=B3rny
