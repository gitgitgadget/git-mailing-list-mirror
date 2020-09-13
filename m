Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EB3C43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 17:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ABC621655
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 17:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgIMRMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 13:12:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58996 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbgIMRMp (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 13 Sep 2020 13:12:45 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 82A6160457;
        Sun, 13 Sep 2020 17:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600017133;
        bh=RtA8C73HHq+1H4kYl4uI26GsWC85iRYj38zZU4EQDh4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=WRcMsC/nmfInIpyzXJBbKF5ntdhHKZjf8O7BbE93iTv7d3RSG6d48Z1+ScGDKBl59
         iZoYMyIJwnS2qXgIJcDSJgoOK82aWfJSaCpEaAtInH2tMUo/FXA424RgA1t966cwP6
         fCi4vsQ/RzKWnAr706OLPgJGYGAtu7DgDAE2qZFC7g+8rZHkTQHusZonX8ejNwG0tx
         7B2knI4rBKtVMSbdinNwbrb1nxwC+CrDTCsA02Wf8pnGIe5uOsZNDnww678+R4Qdp+
         zKibUEwnU2tHs2ZjVvaPPL4Jjx43FR+Qj4eF+xWvlKK/urKVM++5f7h7gBNLOHPOie
         b0XEJqWEdaan1/3DPQdKJ0cao7l2A9v785BTfuAxSvVrx7cJwRZWirH/NbrQPnJcMC
         Z9rUhrlG94akNASuSUW6Ec7dDS+nXdPGisGHlfoj9mxacIMdR/Cu2zjoX6bOAQ2DZh
         CmBIRQvdv1hCUAlcG6R6NB68QmtRiwHkVMiCI4fHPJEKkYVWw7t
Date:   Sun, 13 Sep 2020 17:12:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] docs: explain why squash merges are broken with
 long-running branches
Message-ID: <20200913171206.GO241078@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200912204824.2824106-1-sandals@crustytoothpaste.net>
 <20200912204824.2824106-2-sandals@crustytoothpaste.net>
 <CAN0heSo8XsToRm1st4PqPp8PNwc98Csx-+o78J-mh3bbYoneWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ck22u5fw4m2k6hx2"
Content-Disposition: inline
In-Reply-To: <CAN0heSo8XsToRm1st4PqPp8PNwc98Csx-+o78J-mh3bbYoneWQ@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ck22u5fw4m2k6hx2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-13 at 15:05:31, Martin =C3=85gren wrote:
> On Sat, 12 Sep 2020 at 22:52, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > In many projects, squash merges are commonly used, primarily to keep a
> > tidy history in the face of developers who do not use logically
> > independent, bisectable commits.  As common as this is, this tends to
> > cause significant problems when squash merges are used to merge
> > long-running branches due to the lack of any new merge bases.  Even very
> > experienced developers may make this mistakes, so let's add a FAQ entry
>=20
> s/mistakes/mistake/

Will fix.

> Very well-written, as always.
>=20
> I grepped around a little and couldn't find that we're using this "long-
> running branch" notion anywhere. I think it might make sense to
> define/explain that somewhere early, e.g., with something like "...
> merged repeatedly ... more development...".
>=20
> So in particular, a "long-running" branch is not something like
>=20
>   I branched off a long time ago, I've been hacking on this feature for
>   a long time and the branch has run quite long with lots of commits.
>   Now it's time to merge it and be done with it!

Correct.  By "long-running branch", I mean a branch into which code
routinely gets integrated from feature branches.  For example, the
branches master and develop in a Git Flow workflow, or per-version
release branches if you use that workflow.  I didn't mean an otherwise
divergent branch which has persisted for a long time.

The problem happens, essentially, if you have two branches and you merge
one of them into another repeatedly with squash merges, so I'll be sure
to make that clear.  That will probably help with intelligibility for
non-native speakers as well.

> Once that piece of background is in place, what you have here reads very
> well to me. It was only somewhere halfway through the second paragraph
> that I got what you meant by "long-running branch".

Thanks, this is helpful feedback.
--=20
brian m. carlson: Houston, Texas, US

--Ck22u5fw4m2k6hx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX15S5QAKCRB8DEliiIei
gQqTAQD7YMJqdTFieNu2X59zzEFwZJn5MYrDWQ0KTQqas4WxDAEAgUQsEgelx5QD
5GP1DUBr904sPnn47I/LQehLMfwANA0=
=+5ob
-----END PGP SIGNATURE-----

--Ck22u5fw4m2k6hx2--
