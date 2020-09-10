Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F945C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 02:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F8320708
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 02:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgIJCAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:00:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56710 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729953AbgIJBqD (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Sep 2020 21:46:03 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 25C2E60489;
        Thu, 10 Sep 2020 01:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599702326;
        bh=dS6uMV1LiZpl7fOsEKzYfqIa8EWI3Gh2jDp65WYlLg4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Px16mh3NcKmqyf1HI6a72aCI75VZhyzjmOga153GLr+kWl42VbPpx1HwPo1KIblHx
         TsHXRr7RsczXzBDydwYIAn0rkPje1SLRxkL0a6QpgQOGdQDeGdfHB1KBCqd0jjCVua
         LjW/n9bEHLuKf6aXgqLiCsjx6MR/aFsyXRN89G7Ss1DW5eqKUccaobID0c4ipZo+wL
         7/lb2p1dgpHfboROKOAzlxeZO4K4THAanNjcJ47iwHH7JtaprAf493jerGjqy1i1x6
         lm87n4/qiguGFuR2MtoAOK0SDj0nbsbx2fFr9vLUvNHwMi5FMPgU9KhrZzyMAiIDhI
         D7arWQ9zaPPdU51o7sIYH8/OeFZ+m0MZShBZr+l+deVI+2c2U9azZ15a3cjmj2NVQY
         bLkXuiJQmm68YNNrcvgdv9HmwXTKnzuZhYC0ZDtHf5Da2IzBZnwZTAzryypHTggcNG
         xlDyjusQO6LqlKqHw66dAXN9VIbrAvwFEWskwVc1jqZ/Hkmd57R
Date:   Thu, 10 Sep 2020 01:45:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Proposal: server-advertised config options
Message-ID: <20200910014520.GJ241078@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Drew DeVault <sir@cmpwn.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <20200907205242.GF241078@camp.crustytoothpaste.net>
 <C5I1TZ1OCN40.2BHKV9GD572FL@homura>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3MMMIZFJzhAsRj/+"
Content-Disposition: inline
In-Reply-To: <C5I1TZ1OCN40.2BHKV9GD572FL@homura>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3MMMIZFJzhAsRj/+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-08 at 14:14:47, Drew DeVault wrote:
> On Mon Sep 7, 2020 at 4:52 PM EDT, brian m. carlson wrote:
> > The Git security model doesn't permit untrusted config options, so I
> > think it's risky to add support for config options from the server
> > side. We need to consider not only advanced users who are going to be
> > able to make a good decision here, but novice users who are struggling
> > to understand how Git works and are prone to social engineering. Just
> > because your server is not malicious does not mean that others aren't.
>=20
> Hm. If we view some of these use-cases as legitimate, maybe it would
> make sense to only permit a hard-coded list of config options to be
> advertised, removing all other configurability to avoid letting users
> configure themselves into a compromised system (potentially via social
> engineering). For example, project policies like sendmail.to and config
> options in the server's domain like push options would be in-scope, but
> something like core.editor would be out of scope.

sendmail.to would potentially leak information if you cloned a
repository from one server but intended to use it internally to send
patches elsewhere, especially if you'd already set that option globally.
I'm pretty sure that other scenarios exist where even mundane config
options can be leveraged as an attack vector.

That's the problem: we as the defenders have to come up with every
possible scenario to allow a trusted config item, and an attacker just
has to come up with one scenario to exploit it.  We've seen security
problems in the past with .gitmodules multiple times because it's
server-sent config (in the repository).  Vim has also seen multiple CVEs
=66rom untrusted configuration (modelines).  It's just a minefield waiting
to happen.

As a result, I'm very much opposed to allowing any config options to be
copied from the server.

> > In addition, if I'm cloning a repository just to build it, I don't want
> > to be prompted to set those configuration options at all. My experience
> > in Git hosting is that clones and fetches far, far outnumber pushes, so
> > adding a prompting feature adds a bunch of impediment with little gain
> > for the vast majority of users.
>=20
> That alternative approach would also eliminate the need for prompting.

Are you suggesting that we just accept the server's settings without
prompting?  I certainly don't think that's a viable approach.

> > That doesn't mean you can't provide a downloadable shell script that
> > people could check into their repositories to configure this for the
> > user.
>=20
> Yeah, but that also eliminates most of the convenience factor and is
> even more of a risk.

It's also the standard approach that every project uses already, and it
has the benefit that the user can inspect it at their leisure before
running it.
--=20
brian m. carlson: Houston, Texas, US

--3MMMIZFJzhAsRj/+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX1mFLwAKCRB8DEliiIei
gWuYAQCSe6w/kh0VitAZ94mzzy+2QeduggfAH8Pgm26wcOyOLAD+OZ2dL+dEngg5
JpKNdY2vUkTEuLWweKWpPn5LJXHc/Qw=
=TDrG
-----END PGP SIGNATURE-----

--3MMMIZFJzhAsRj/+--
