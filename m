Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8247A1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 00:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503799AbfJRATl (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 20:19:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46196 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438805AbfJRATl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 17 Oct 2019 20:19:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2B10C60459;
        Fri, 18 Oct 2019 00:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1571357979;
        bh=Hxgv+jEN/MdZcPg8+BdURgUHK+AVY7X3YE0s8ZzUiEQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zJMcUcuJ9mDndtJFEm8P6hf+58QPSqgrQAQZ30U+m5xmd1BLSKUkHTDEEjbuz3B4W
         7617q9QWmDfwgmhlznQni325DhwtLk2uUdlXYNKulUibKB6rtlbvd694HAZPeQlrlF
         mLkkBRLVau+p91w2s3Eqg4jkgy6yZXZJjU4MXieA1bTUdcA3cPJi5Eb/28qgZbDei6
         dfG9ThOBpRdb2q6ud4ub2BVnBgwNen2aaDbfsD3J9id/QUozXcZHxccky4S6Xuc4oK
         hDgvi7ZLC8PEZg3C3awysfnZXaZvn+Xgv8vhHl2mvH6MioCKgpT7mgbx1E+fUErCmo
         3jtFmzXddNL2qyB8JfR8Vj3t4MwaFbKAM4ItttHrSdw+J+c2GnjWWA0guPAyqkqKOS
         4KKdAeXZpcpgXGSQ2gALVm3NyWsCZsorM59Aym1NMoMQDpnANI2EE1hud+lGIl6Zyv
         iJ0nOMUNmrI1qZt5+EaQIDVGhnkoYBLfUxrzy7H6NpwgJSt8sUX
Date:   Fri, 18 Oct 2019 00:19:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Manoj Sterex <*@sterex.in>
Cc:     git@vger.kernel.org
Subject: Re: Commits with --no-verify option
Message-ID: <20191018001934.cq2bqcron32ql2ux@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Manoj Sterex <*@sterex.in>, git@vger.kernel.org
References: <CAJoS+LqqeD3zLYi=jnxc9A=bLT_bpTrjP1bZMPX4NMehd2V3cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6fvkoatj5xw3ttlz"
Content-Disposition: inline
In-Reply-To: <CAJoS+LqqeD3zLYi=jnxc9A=bLT_bpTrjP1bZMPX4NMehd2V3cQ@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-trunk-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6fvkoatj5xw3ttlz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-17 at 08:56:34, Manoj Sterex wrote:
> Hi all,
>=20
> Currently, AFAIK, there is no way to know if a commit was done with or
> without using the '--no-verify' option. That is, git does not track if
> hooks were skipped when the commit happened.
>=20
> Is there some way to track this in the log?

No, there isn't, and even if there were, it would be trivial to bypass
(such as by using git commit-tree, which does not run hooks).

You haven't elaborated on why you want this, but typically the reason
people ask for this is that they do some sort of data checking (testing
or linting) in the pre-commit hook.  Since that code runs on the
author's system and is trivially bypassed (by simply deleting the hook),
it isn't a good way to enforce policy; usually that should be done in a
test or CI infrastructure.

In addition, it's common for advanced users to make a series of
temporary commits to save state and then squash them later.  It wouldn't
be reasonable for a pre-commit hook to enforce certain policies, such as
a commit message syntax policy, in such a case, so --no-verify exists
for users who know what they're doing and would like to bypass standard
checking.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--6fvkoatj5xw3ttlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2pBRYACgkQv1NdgR9S
9ou7iw//S21TqrZHrC/4sGomWG8FDbqt12U66dVyiO+b46jTaLRr/6S7xRyfJxU6
PGLfRDjumdeJQTbmcxwuQckzTgGX5wyIZhx+FHana4SR3HpZRfaWmaoeBlqz1BWF
tLqDkJF+kWkDdAun7/J6W0jPqNuJQgEpCBtczEoh5YdjSDCY4JRjcGC5Vx6jqe2r
JIKGFV6+tmLGE/ECMo+ls1yE8597d9S2kh5o61qiczVKvaMan4TOaHdJAyBwyfAN
GP+MXxirGBo2OL2jO6xeoR536ZGK41R9/4hbFinS1rIctTPbsM36vyOQOPfkPwzr
kVzsQUy5MszsynKfqbmyS/aWMvXCl7RVSMtYVup3nBZEoYNqYax3zN9rQZ7hkzBA
l4vV057qcN+Tjv3V2axKjq9p2d9zGUanmcWt3DGYTJUQYztjulf/r7FmWePxksSh
HCtidfUDJH5q3weZqIU9Akhru9aZ/g8N4t32c4t2zFrd7YIs7aUbmZkBj+WoDlQj
cmdaoKg0SUI0k1jgzgbSEi9nivyFP+81QODhuwaubN++I7o3CyYWhWQOJelr4sVK
Zhx8HUBokSXS35604vKkbs8h/qBo/UlQDuXFe1YpNn2H/GRHahUqpg0zboanDGTv
3dQwaCebXRoX0tKruVvfkjws1eT71SPeddMaxEL9GnoDCh+NFfA=
=+mhK
-----END PGP SIGNATURE-----

--6fvkoatj5xw3ttlz--
