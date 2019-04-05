Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C4220248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbfDESNK (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:13:10 -0400
Received: from mout.gmx.net ([212.227.17.21]:59797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbfDESNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554487985;
        bh=daSh7w5Vo2eTGolT9TaNq7RZ7fgV0ztYbDjmQEQ/ARc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LGzSt396GJMtWD8VCNiCi0Kmp5wHF5Z7LNbuBzYCWlRP+W5vTRyLKNcynXvEznn6F
         CKFLNqRvEcv8QsOoh7wfLyn5Lb92UHA94PES0x0Sw6Am6tvMs+b+vDdG3vi1FEHO4p
         h2V1IncHqbS//yeU3Nom0z9xkJto9TOqEuLrck5M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtUHA-1gkwYW3NZc-010xT1; Fri, 05
 Apr 2019 20:13:04 +0200
Date:   Fri, 5 Apr 2019 20:13:05 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 10/32] commit.c: add repo_get_commit_tree()
In-Reply-To: <CACsJy8Aa_Zcawoz07FBWjUjYE+RbMpxwrgim-tvQhMZW9+h2gQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904052011180.41@tvgsbejvaqbjf.bet>
References: <20190330111927.18645-1-pclouds@gmail.com> <20190403113457.20399-1-pclouds@gmail.com> <20190403113457.20399-11-pclouds@gmail.com> <20190404170427.GQ32732@szeder.dev> <CACsJy8Aa_Zcawoz07FBWjUjYE+RbMpxwrgim-tvQhMZW9+h2gQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-551784916-1554487986=:41"
X-Provags-ID: V03:K1:sHr9B+kq2XmxQHMQOI+eA5wZgbw10AmniqkFKcKzhsJNT7ewg+o
 oE5J2nmsJ0hefe7xD8VoZ7QtbUO8HaXNuDBSQJLVKRAAAjv6En2rAJdHF6louv3HlG8Vlm9
 PCDD6XEPamL/Kje0wwzU/T/5b6+QoANU3f9WNYR732AejruHY7LZUnAhIA6gPtEzlUbcAet
 SA2gvbupf4OWGn49bm+Rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YiXAT+ADVX0=:cjL1Kl696akkNjoy5FIdV/
 mDGfGbvjqkHY7KKYbCeETb+cEgzTJUNCTaOCujzwP6VTjieX0ZJvIPqdQOaG6sNGXjVU1v6xJ
 L+7nGB+vxlcXbDvyIp3O0GYt5rUP0jzw/K3uApL8c/uLIMTtk8JnHDPaYEa+WAgHZP3VHfTsx
 jPgEoZ0Xs2b20JAJbDQDc9sGAm25okYp/rG6j0bzoYL1L7oIDOoLp73kd/+fVBiIaVw0In/1G
 OyGH/vx7VmExt0EReALrodNPunVDrmmd9gCSIVURsOggQrlvu281s8riZ1mqmY0D25v2WWLg/
 J7rhq2hcNxSMwOaZzn6qYx82YcuOBg6svFZNWgy5iKhxjMTW0VFPMNDUvn0zlIbBpkDe/ykaX
 PCSs0N7uM9SqG76KfWuG/DQXKuV0TNE5wO+jCjJsisFwDgBwiEC3Gntpk4GiE4sti2CHQO/eF
 SEfH07wHo+XlxmVrP53LDNul6+Sy6r7TgwlaMF3/T1jgxHMpQYqCdjrK2T8IijR3SRo6sPpP5
 LXDNRNI5E2jkFb9RZcxwNZZX5ycvAzD+3wqR42BUaxLAtL6rvdY8GHquAgKbqva4u4KEhQFKW
 1N9uW5mm2J/yOu6V0RHbuFpV3mJTi4T6DyfRbwJtvke3ropcyI+1UDbBtODnkcyk0E3fs3jdB
 sff/8MB9/hR61AEbdrhx7PJZV+LKEOvxAibthjPbWRQUc8hiPHjKiEvuyqbRURcrpWV1oCMPX
 +4uSeY9TAAPfZ82USrly5W7B/KpiTHgOk+Q8Da6hXsr47ctSmRcBgFj4SEjsig0F9esTjX4l1
 ZY7laL+gWwgVy6g8qf4QNNNdlQ976ihUpZSoH8wdgI2dRlBdd8NLNKFTIfX/IN45psE6EjB0V
 tzfzo3FUadLcwyHeZdt1PR/qu9ztOHlKmQjF6AcF9/U8ifmQYPo3dtkDv0EpHnydu21Di6J47
 lZE/PVVUl8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-551784916-1554487986=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Duy,

On Fri, 5 Apr 2019, Duy Nguyen wrote:

> On Fri, Apr 5, 2019 at 12:04 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com>=
 wrote:
> > >  struct object_id *get_commit_tree_oid(const struct commit *);
> > >

> > >  /*
> > > diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/co=
mmit.cocci
> > > index c49aa558f0..f5bc639981 100644
> > > --- a/contrib/coccinelle/commit.cocci
> > > +++ b/contrib/coccinelle/commit.cocci
> > > @@ -12,12 +12,12 @@ expression c;
> > >
> > >  // These excluded functions must access c->maybe_tree direcly.
> > >  @@
> > > -identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph_one|loa=
d_tree_for_commit)$";
> > > +identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_on=
e|load_tree_for_commit)$";
> > >  expression c;
> > >  @@
> > >    f(...) {<...
> > >  - c->maybe_tree
> > > -+ get_commit_tree(c)
> > > ++ repo_get_commit_tree(the_repository, c)
> >
> > So, why this change?
>
> Because get_commit_tree() now becomes a compat wrapper (yes I'll fill
> in the commit message ;) and should be avoided.
>
> > It would also require furher changes to 'commit.cocci', in particular
> > to the last semantic patch, which is supposed to ensure that
> > get_commit_tree() doesn't end up on the LHS of an assignment, but with
> > this change Coccinelle does suggest transfomations with
> > repo_get_commit_tree() on the LHS.
>
> Oooh.. I see now. I actually updated that then dropped, thinking that
> a function call cannot be on LHS and that conversion is for
> already-long-gone code anyway. But yeah when you stack that conversion
> on top of this, it makes sense that we need double conversion to avoid
> build error.
>
> Since I will have to update this patch anyway, I'll update the commit
> message on the first cocci patch too.

This actually broke the build. So here is what I have on top of `pu` to
make it work again:

=2D- snip --
Subject: [PATCH] fixup??? commit.c: add repo_get_commit_tree()

The search/replace of this patch was apparently not done fully.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 contrib/coccinelle/commit.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.c=
occi
index f5bc639981..7f53f361c7 100644
=2D-- a/contrib/coccinelle/commit.cocci
+++ b/contrib/coccinelle/commit.cocci
@@ -24,5 +24,5 @@ expression c;
 expression c;
 expression s;
 @@
=2D- get_commit_tree(c) =3D s
+- repo_get_commit_tree(the_repository, c) =3D s
 + c->maybe_tree =3D s
=2D- snap --

Ciao,
Johannes

>
> >
> > >    ...>}
> > >
> > >  @@
> > > --
> > > 2.21.0.479.g47ac719cd3
> > >
>
>
>
> --
> Duy
>

--8323328-551784916-1554487986=:41--
