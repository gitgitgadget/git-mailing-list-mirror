Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94270C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 11:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C14020675
	for <git@archiver.kernel.org>; Tue,  5 May 2020 11:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ydXIqRat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgEELso (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 07:48:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37918 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbgEELso (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 07:48:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B2DC26044D;
        Tue,  5 May 2020 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1588679323;
        bh=5LUOJK9cEaZXGhIu7pfFWblqdltEajpM+US0kxiw21Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ydXIqRat9E/gYvRPl16jH6mnm6bBTSspQvWLCyVQzfpZcVEPq6b7Gu9vGxK/0kiLd
         QF2VvpbM/eOFIFKW1c/3EkOIgBqJLrTvwR4YEVLoAHGGDw45RO/AM0wOCIRhPlek/X
         KT/42q+8foE986lSvSPTzrXtABlSZQVe4aNe+5ZjQ45yXVgtGU2GKizk+RYLwRpHzL
         xu0NPRfI+Q29FGYe0H4YQt/fEh9GlV3XXdVdQicEB6BKYbYlc9q0mudwmNLa+vrjVm
         +y0YTlE5A8froGD9L9kmupGVutV21C9LeA1wJwaTKBjFyrQ0qNOigr+Bfu9yo3/PwV
         QbTEknGD4Ou+LZV0MtOtuaR9lS3Agp0/NUvGpGrnsJ4IdRICSN3thtwUjh0gnQFYWt
         2aTfbWkkgKoCYyfOThpfZXmLZJ41EyeUcT6MlVm1pWKxLmIICc8COPal193J7p710L
         sLG6x+wFhRZWNsp2133fpo799Re1Ri6NNmtrai7kYnGrOhKr9/h
Date:   Tue, 5 May 2020 11:48:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] builtin/receive-pack: avoid generic function name
 hmac()
Message-ID: <20200505114837.GG6530@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org
References: <20200505054630.5821-1-carenas@gmail.com>
 <20200505095326.36374-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Content-Disposition: inline
In-Reply-To: <20200505095326.36374-1-carenas@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-trunk-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-05 at 09:53:26, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> fabec2c5c3 (builtin/receive-pack: switch to use the_hash_algo, 2019-08-18)
> renames hmac_sha1 to hmac, as it was updated to use the hash function used
> by git (which won't be sha1 in the future).
>=20
> hmac() is provided by NetBSD >=3D 8 libc and therefore conflicts as shown=
 by :
>=20
> builtin/receive-pack.c:421:13: error: conflicting types for 'hmac'
>  static void hmac(unsigned char *out,
>              ^~~~
> In file included from ./git-compat-util.h:172:0,
>                  from ./builtin.h:4,
>                  from builtin/receive-pack.c:1:
> /usr/include/stdlib.h:305:10: note: previous declaration of 'hmac' was he=
re
>  ssize_t  hmac(const char *, const void *, size_t, const void *, size_t, =
void *,
>           ^~~~
>=20
> Rename it again to hmac_hash to reflect it will use the git's defined hash
> function and avoid the conflict, while at it update a comment to better
> describe the HMAC function that was used.
>=20
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

Looks good.  Thanks again for the patch.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXrFSlQAKCRB8DEliiIei
gWsZAQCr+5G7hI28FIE9ZoksOA01klgaq35MHZ+efyO9thz0BAD/XOinNFnjgPJC
cpOaZIO7KUQI//eSgZTj76Zee0VGSgI=
=m5Cy
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--
