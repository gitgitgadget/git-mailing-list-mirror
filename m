Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 086712047F
	for <e@80x24.org>; Wed, 26 Jul 2017 23:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751428AbdGZXmo (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 19:42:44 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40276 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751078AbdGZXmn (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Jul 2017 19:42:43 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 00528280AD;
        Wed, 26 Jul 2017 23:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1501112563;
        bh=kd+AxclqyHyuiDWxt2/BozswL/0kOA9sW746Is8SZww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v2DlMtbUDJ1PCHxSbxFMVAWSRFFsNdqZYhluqiOHS6hBc9NDtocEjDyUmErzR/UYE
         IpQFv54BWafHSeKN20NsHIxkBm9vUrH2xaFohY0EMi3aWXr2IR3i4LDb0UIR/Uz6yu
         gTR0iRUFogd6/WJaE2zDja4EtU6LN62XdMGSbedKQeSnZ6+Y28480ZOSLojOg2/Csv
         43Ti1U0uiHDuu11puRgIene9em28ALQaBSemtohQGyfFPAAxkhP1tmiOQnDWlDzQCB
         75f1HqcB/06JWkoguhGbfxESZAVgTHnbGi47CpCI7a0UpGKPhvwV/JrNuQ7LJ2ltFz
         POP2HCzEmErCDGuqldF8LpwTha7wxmDq+oJBumpWXDOVJi7EEYK0tD11afdcakUSI2
         e6LAz7vv+yez8ouP1zuUKiYPzu1p0IYSWntYGPSPwGTsJXQVdmQbOtRA2ulUWUo6e/
         PZc2TVWQNtEDc6zCcba2/9xQbo6xgtQn0CAK5dInRJdKpYvtKaW
Date:   Wed, 26 Jul 2017 23:42:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [RFC PATCH 0/4] Some patches for fsck for missing objects
Message-ID: <20170726234238.2osugw2lheubmetw@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peartben@gmail.com, christian.couder@gmail.com
References: <cover.1501111615.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="omb5ndqm2y7pcs55"
Content-Disposition: inline
In-Reply-To: <cover.1501111615.git.jonathantanmy@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--omb5ndqm2y7pcs55
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 04:29:58PM -0700, Jonathan Tan wrote:
> This is an updated version of my previous patch [1], but without the
> list of promises. It is somewhat different now because fsck cannot just
> mark all promised objects as HAS_OBJ.
>=20
> This could be adapted and incorporated into patch sets that have objects
> missing from the local repo.
>=20
> I split this up into 4 patches so that you can see how the changes in
> fsck are being tested, but eventually these should probably be combined
> into 1 patch.

I looked at this and I like the direction it's going.  It's pretty
simple and straightforward, which I also like.

What I'd recommend is that instead of making lazyObject a string, we
make it an integer representing a protocol version.  We then add a
different config setting that is the actual program to invoke, using the
given protocol version.  This lets us change the way we speak to the
tool without breaking backwards compatibility, and it also allows us to
simply check the lazyObject script for supported protocols up front.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--omb5ndqm2y7pcs55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAll5KO4ACgkQv1NdgR9S
9oviBw/+OzV8tqhpdMQFDBBSsstGwBrqTndVARmlIwMm/vuye7wdVo4lglhwIVHi
J1k8crga5y6Bwy8fDP9s4MJjkg2/3CjJNSehIaPZc6uJ0ymQWqIUR7uzAB51G+Y7
h1YIzllx518UXN2509rM0mPoIKLuME94unRvNZ16yRfzmI/l4NDc3xNbrQ9tUnWD
A2PeDxqKzAluTRO8TkKUpsGKJ6AnCAKM5U9n7uVUWt9g8+4vk13pH4xv5zayd8/L
Yf+sH1IJ7IQ7s6ECJ6pvco9zMDyXdysBmZ/8QBGe+8lbEPSbA5ns1q1Y5ksfT0Ti
7T9JuOcvg4577BPKL71mDYDVOvtS5blsovXAdY3Fz5bMg3+PFzijnLFEy919J4WN
ra8k+eOkhtKjgprtGDjMXL2nHuknDbJVg8Z/KiCr0g5LX2hpcoBwZN58u1TWGAvL
PI8MLxzk2Ebni2sG+lWDMJ22FiSipoQtDvPvOuq5HCXuRAFohW0CwQsk2+vcBC4z
1Stjx4/qRGVCr7KnBy256nVeaLdgH0RHcJKDpfshx5ZzXLtVL+5dbNnmZLeSVDEx
N2eo8yAC/DRWW8Vsuo2iq/7Mwq4tzdqL8eXWrtHIkNcGoUaVmzi9d2YDupZG1mM3
DOuMv8P+yEOJkwFzD7gTySJhNPsnbx6OXZoDTc5zLFPcYWlaEvw=
=XnqQ
-----END PGP SIGNATURE-----

--omb5ndqm2y7pcs55--
