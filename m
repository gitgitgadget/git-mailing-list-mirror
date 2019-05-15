Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3B51F461
	for <e@80x24.org>; Wed, 15 May 2019 23:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfEOXWm (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 19:22:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36588 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbfEOXUl (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 May 2019 19:20:41 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:89af:9dea:d4e0:996c])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4567960443;
        Wed, 15 May 2019 23:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557962437;
        bh=452HuBnHuF6/Nv5h0XZGZ9yJ76bE7EByGrHZPAoVxm8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=GnHhfECl8yB2Dw7UbbuX1zTkPS9cTlna+ih7XaGs3oVTMzQ4XkRCPjAw7bW3RDm1y
         NZOcwG8uGOjLtPyAnkxKASeTvFPSfM/NTwCSY8VsUSPJia1RDSrECgG2GlPlbZztjQ
         +rgFYE0PhflBCpANqjXh6W1QGFIqTYlhmMuEpbkzVyxaSdcbu6rTs+ViKLxaYK2Kv7
         3mcT9HSeIcZ+SP5UkZMELmr5f3l+r94ih9sAM8Za7o2zNr26mRQRi9bcC8tG0/Sial
         5AZKLTzrYNP9VvBprm3Z9zBj67orh60qbr2G8j2WNu0qwxGbIH5E91uHPar60DeTbl
         DHRskNZbcHfXq5ULtwEGcCpzXJZiJOW90Z0DNrn4XDBPGL44lw57L6j9HK52naMhSH
         azOfkBK4PLgq6cgsSDx+Px6pvcodLWMxRLmvYXdPsrzqgeEC7cWGNxEjC/W1Rj1PmO
         9cfOfDf4ZCHPhZkG/7UumNO3Kd6SMvyhLiubSz69odBJdrqCdfj
Date:   Wed, 15 May 2019 23:20:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: try harder to ensure a working jgit
Message-ID: <20190515232032.GN7458@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>,
        git@vger.kernel.org
References: <20190514020520.GI3654@pobox.com>
 <20190514021419.GI7458@genre.crustytoothpaste.net>
 <20190514084534.GA9567@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l3ej7W/Jb2pB3qL2"
Content-Disposition: inline
In-Reply-To: <20190514084534.GA9567@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--l3ej7W/Jb2pB3qL2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2019 at 04:45:34AM -0400, Jeff King wrote:
> On Tue, May 14, 2019 at 02:14:19AM +0000, brian m. carlson wrote:
> > I think this is an improvement, not only because of the reasons you
> > mentioned, but because we remove the use of "type", which is not
> > guaranteed to be present in a POSIX shell.
>=20
> Isn't it? I have always treated it as the most-portable option for this
> (compared to, say, `which`).  It is in POSIX as a utility (albeit marked
> with XSI), which even says (in APPLICATION USAGE):
>=20
>   Since type must be aware of the contents of the current shell
>   execution environment (such as the lists of commands, functions, and
>   built-ins processed by hash), it is always provided as a shell regular
>   built-in.

It's an XSI extension, while "command -v" is not. "type" may be more
common for historical reasons, but if you have systems that don't
implement XSI, "command -v" is the way to go.

I suppose this doesn't matter unless we have people try to build with
Debian's posh package, which only implements the minimum requirements
for a Debian /bin/sh (which don't include XSI extensions, but do include
local).

> All that said, I think Todd's patch makes perfect sense even without
> wanting to avoid "type".

I agree this is an improvement either way.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--l3ej7W/Jb2pB3qL2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzcnsAACgkQv1NdgR9S
9ovUQBAAjCEqZ82fgQzeLwSXFXhbw+HMaaIOtxlWppMcIS+RkFUtKCvrq3zKdzof
sjhApSUa5bI2KX7QpNezLp+02hFJfCx/BLqFIhGc8EBY7Ycq2zd9tENUTuSXalsN
KY1qjiJsdsavNokOwOpc3cd9tm+B3EuLeMexzmdZBcLXpNrkT/Cm/ZBPFEQe/fM0
T07zOtbVbh682gsdYkCg4fzzVn4mmGC3yOZlccTDMjNa47Chmmhi6MFHY1uSkbiQ
SZcZVVRWUNDIPIogI5sTa1/omPLtmbSez8vkYdVbbSYCdYOk/scOLoGd4QpMbNOE
cuIBMX0OuD0PhRVIN+LeCZJVbUt4GNDGj9Qq8t/h10DsfJmGPHjrB5KlTFK+Elzv
j4P0owUuBXZ6OH4e4a+CziSY5HsE7W+8VXobc1jrlYGwiXIkBlpmlMzgw8anQRVd
L2xopCgEpLkykCrZd18vZXBzOtWVjZIE7alZI/kJlrznKnHHAnLQUVyoY1e+Fh1V
IXgdDcIw0sY4iKQLSNauG/dK4GlC6AmFcUkQ5aNQ5G+xJBxlPFb3XwjSq2XAQekN
gqG73tqzBrqwE7iP3DUMc5CB7Hiw4sLYfuKSjqaY0WVyKcaYKhsLbmj1ornHI/v8
EwGuIyfRdzu2XPcFkfgkjSEG15sPvXiifMaz+IZUBDUzEsXURWg=
=8jEe
-----END PGP SIGNATURE-----

--l3ej7W/Jb2pB3qL2--
