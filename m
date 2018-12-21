Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0E1D1F405
	for <e@80x24.org>; Fri, 21 Dec 2018 23:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392220AbeLUXVC (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 18:21:02 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57858 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390982AbeLUXVC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Dec 2018 18:21:02 -0500
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3FAE26042C;
        Fri, 21 Dec 2018 23:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545434460;
        bh=BVpkl27biGDPam3D058RKrxnaVnecjs78iJz3JwysEA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vRg4UVu7iE2rFgddjQanNmERdVllbN0uLgXKi7WqSHmj5lYd65nTrmj5L3lt0lOGe
         XyhLT89YFpSbLAsZHxMcb7fpmVkfl4dN15xVMHEKi3Q4LmHws85QD46IQ22UVOwU3B
         8KM37MayS01HUv+TvYhQN1apctXAjByJ1mnaVuPmHhyPnp3Q0GNZpAMwF5c7vGAx6c
         9+NSVSc783qmmmbMueXfjWHKs50eAL6FxjcdzqvfQksP/C8/oe9tI8gOlY/YHNaP5I
         j2BQ/GG/3oBKUxBMdW5+IVZ2rmW3YhD/0n5YVeSOm+wSHbTPn2d4DrK7HC7tVEICLa
         7lPdhYJBN/Th392NhHPKgJNevxcwSu+oz/3bKRSbTYocnMQYo1uxOlsi9lZaixy61w
         GCYDEaCG2we8SkC18EyVkTADWop4yEcqjoKE2qvFTqY2OZk91yRHEeKzgmSIOa81Hs
         UxcwT2e0kWgImy7Mi3x6XHNxH8KjmXx4tJVMm81yWSl/zYUH9bS
Date:   Fri, 21 Dec 2018 23:20:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] diff: add support for reading files literally with
 --no-index
Message-ID: <20181221232025.GA10611@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
References: <20181220002610.43832-1-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1812211246050.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1812211246050.41@tvgsbejvaqbjf.bet>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2018 at 12:52:04PM +0100, Johannes Schindelin wrote:
> ... and in Git for Windows' Bash, it would result in something like:
>=20
> 	$ git -P diff --no-index <(printf "a\nb\n") <(printf "a\nc\n")
> 	error: Could not access '/proc/24012/fd/63'
>=20
> ... because the Bash is "MSYS2-aware" and knows about `/proc/` while
> `git.exe` is a pure Win32 executable that has no idea what Bash is talking
> about.
>=20
> Sadly, your patch does not change the situation one bit (because it does
> not change the fact that the MSYS2 Bash passes a path to `git.exe` that is
> not a valid Windows path, and neither could it, but that's not the problem
> of your patch).

That tells me that I need to exclude Windows (excepting Cygwin) if I add
a PROCESS_SUBSTITUTION test like =C3=86var suggested, and that indeed is
helpful information. I'm sorry my patch won't be useful on Windows,
though.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwddTkACgkQv1NdgR9S
9osAKg/6A2qXrIDFZ51d3rUc0KB1Iso7RLRIiHDVJ1wVz0mHKTC8U891x/tVtoUv
Lf0nJmGJI3kwSHjP7mof+pxg2LBs33b5OuOC6qgMFmzX/EuDnuxanKYclBCxvdpi
QLn3AWOSTSRwHwJOR2CcUjGDKhNv227Cfmm8Xigh5ACeSEx00SQr+qPZompHDa7A
yvdpMobDfjP8HPSvleA0UMlLGgQ7tXB5PP3LUC3d9pifFJb2G5lg5Zxbm3avdkyw
t2mHh5QnrefI8SC2X0AOd8xR5+YzNc4BeJjYyhJsR4Ug99i/fheRBL1QYeC9gTgW
Ph5ogp6kpszK1LUGkrrO9gHO4EdYioiMng1RlI05Z7n380PhLLiJZcbA9Pgcqu5/
+F3ylWhVtusPR3EkkThAIUriBHWRn8ETOgnFAWWD+s299AOfJ+mmwAZukgd+IzCI
z6Ivv5GeEaD0DrgxS0OAUbl18xEtptH1ETRFSMNxDrz4aE9rtZ8wPl7J9CpFE8jj
VOsbr9vxnYWElg7sU7Ok9UW84uAaB5ZpZY9rB3j4IHxDer+jFE96OcRc3YTbKfvN
1sXKd+7yil3SoV0wOFaXCF7Tajo6ujaNZI0/RrINrNO2ai0fAeHHJ5/bHCkC3KzP
3Vt1P+T/NcFxjnc0nawCLVlaC3PnkXCytwN6bBWcISvEWMQ0X4w=
=dEoA
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
