Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39580C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C509D207BB
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbgKJXj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 18:39:26 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38502 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726706AbgKJXj0 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Nov 2020 18:39:26 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 561186045A;
        Tue, 10 Nov 2020 23:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1605051534;
        bh=MG9qnTfwxRBkaWa8kVnQiu0/zFDF3bJYbRmFauA5pnQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EuPgw4YC4ulSCTNbC+ig6+ZIqvo3uGbyWJUpItY2H9jCO4VLCXkjSP/psxu8MTXTg
         cB8FqhMT9eU+Hy4uyldfqF192Tbat5q0F5btXvaMiciL7w87T6oXPpsuQ2Ri3J1Rd5
         1K4BtCS2YHRtPkml20W0gizany79OHdU0loc67yVXgPaSncJneQ6zYn2Q2LLOoXhCs
         LckKSc5IXUMzJv5ntD7n66zKKdZpsR2MWTjJKe1g3pY41WlJTyl6sYY8xWx1IfZ/Jc
         qc8/NwOFLBrOqNR0M86EJfI0Gf/ay+TP2h2p/DdE3pq8/PGWPO/w0OO1Is8uh6ga9H
         0HLtA9bqw/E0PBpzerZnzISZDO3fxnn+jW2lr7BXXb9G8gD4U1SPOjM7CcJLeRG/MY
         xOgdJZ8lhz2Ky5jLqfNQPJDYTpifDS8bJEgBByrRhdA/l1lg3rxqXRYIIuN2FxoYJZ
         LbaVJGQ/+K6/T3i9Zj7jjKLxu++TPakcJwtGFiew0zUqWYuPd2n
Date:   Tue, 10 Nov 2020 23:38:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Daniel Gurney <dgurney99@gmail.com>, git@vger.kernel.org,
        Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] compat/bswap.h: detect ARM64 when using MSVC
Message-ID: <20201110233850.GJ6252@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Daniel Gurney <dgurney99@gmail.com>, git@vger.kernel.org,
        Sebastian Schuberth <sschuberth@gmail.com>
References: <20201107221916.1428757-1-dgurney99@gmail.com>
 <20201107224747.GF6252@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2011101418550.18437@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/0U0QBNx7JIUZLHm"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2011101418550.18437@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/0U0QBNx7JIUZLHm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-10 at 13:58:21, Johannes Schindelin wrote:

> The biggest question now is: are we certain that `_M_ARM64` implies
> little-endian?

For Windows?  Yes.  I'm almost certain Windows has only supported
little-endian architectures, possibly with the exception of gaming
consoles.

> I remember that ARM (the 32-bit variety, that is) has support for
> switching endianness on the fly. Happily, MSVC talks specifically about
> _not_ supporting that:
> https://docs.microsoft.com/en-us/cpp/build/overview-of-arm-abi-conventions
>=20
> Likewise, it says the same about ARM64 (mentioning that it would be much
> harder to switch endianness there to begin with):
> https://docs.microsoft.com/en-us/cpp/build/arm64-windows-abi-conventions
>=20
> So does that make us confident that we can just add that `_M_ARM64` part?
> Yes. Does it make me confident that we can just drop all of the
> architecture-dependent conditions? No, it does not. There _were_ versions
> of MSVC that could compile code for PowerPC, for example, which _is_
> big-endian.

PowerPC can actually be either.  Most 64-bit PowerPC machines these days
are run as little endian, and Windows has always run it in little-endian
mode.  Macs ran it in big-endian mode.

> > As far as I know, Windows has always run on little-endian hardware.
>=20
> I think that depends on your point of view... IIRC an early version of
> Windows NT (or was it still VMS Plus?) ran on DEC Alpha, which I seem to
> _vaguely_ remember was big-endian.

Alpha appears to have supported both, but as far as I know, both Windows
and Linux used it in little-endian mode.

> > [0] Wikipedia does not specify the endiannesses supported by the MIPS
> > edition.
>=20
> I have another vague memory about MIPS (a wonderful SGI machine I had the
> pleasure of banging my head against, for lack of Python support and Git
> requiring Python back then) being big-endian, too.

Another architecture that supports both endiannesses.  Debian supports
both, but I believe Windows only supported the little-endian version.  I
have a small MIPS board that uses the little endian port for Debian.

> Short version: while I managed to convince myself that _currently_ there
> are no big-endian platforms that we can support via MSVC, I would like to
> stay within the boundaries of caution and _not_ drop those `defined(_M_*)`
> parts.

While I'm confident in my statements, you're the relevant subsystem
maintainer here, so I'm happy to defer to your judgment.  I think Junio
can just pick up the earlier patch version and we should be good to go,
since that patch seemed to meet everyone's needs.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--/0U0QBNx7JIUZLHm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX6skiQAKCRB8DEliiIei
gcshAP9I/nm9VOKBlTNrrffC/VXxeH1G+VyW7XWKwReGl1axAAD/cQhirFdo0qa/
sfyZMzoRqN9lqJSMciAUDdpFuqVahgk=
=OFLP
-----END PGP SIGNATURE-----

--/0U0QBNx7JIUZLHm--
