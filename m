Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD82DC388F7
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 00:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61FDE208FE
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 00:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgKHANJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Nov 2020 19:13:09 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36654 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbgKHANI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 7 Nov 2020 19:13:08 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9A36660752;
        Sun,  8 Nov 2020 00:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1604794387;
        bh=mB2q/kwXk3WRwqwLh03cTJRcK1Gv0vcvfCL0A0ro1O4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QATzuIllltfPdRsK5YW1IhH71pm6Z27z3vMaZwL0ahG1SFA0CrILvzwSjt6GXqvV0
         1zYPfxPtgppyTjLdZbxr2NGzhu03yPTSxe18gzfIDWOHchzErLsh4/JDVkuxIdVB1P
         uW+5YJ8NIR6aCUFQb+EVZ5Q+NiEmTGVAUvnMn6uw0I2kaQwmoZTox0RotSzWZhRllh
         6JGqjr6RHvCW2WYqTfhDONnQMgnIggApmf9e65p8pQaAzgVHWMLnl6qwZIqirwWpKR
         SHyKgvs0QmsGhi6fpvWzzD1x3/p253GEA/cEX5HuyAepdyWnssW5xk40qqJ8QmJ1Zt
         9faNZOPy1DHwQWSt7dasMydQ8O4R/pwYvDQJ9uLjIJZ5SJNEUPGtssC1L7qVo1tDAu
         KWYGnBw6jQhjtljTeanB/5lIQferJfwaPFLsNnLkKCNQHVAp9Wub2wNOim6u+JzcgR
         nkVIetcWTx889jWx4L7DRdpE1X2zmoW6ZwgBeYG8a5kcHk0bGGz
Date:   Sun, 8 Nov 2020 00:12:54 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Daniel Gurney <dgurney99@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] compat/bswap.h: Simplify MSVC endianness detection
Message-ID: <20201108001254.GG6252@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Daniel Gurney <dgurney99@gmail.com>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
References: <20201107234751.10661-1-dgurney99@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Content-Disposition: inline
In-Reply-To: <20201107234751.10661-1-dgurney99@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-07 at 23:47:51, Daniel Gurney wrote:
> Modern MSVC or Windows versions don't support big-endian, so it's
> unnecessary to consider architectures when using it.
>=20
> Signed-off-by: Daniel Gurney <dgurney99@gmail.com>
> ---
>  compat/bswap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/compat/bswap.h b/compat/bswap.h
> index c0bb744adc..72f225eaa8 100644
> --- a/compat/bswap.h
> +++ b/compat/bswap.h
> @@ -74,7 +74,7 @@ static inline uint64_t git_bswap64(uint64_t x)
>  }
>  #endif
> =20
> -#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64))
> +#elif defined(_MSC_VER)
> =20
>  #include <stdlib.h>
> =20

The patch itself seems fine to me, of course.  For the message, it may
be valuable to mention that this enables the proper behavior for ARM64,
which was your original goal.  Also, by convention, we typically use a
lower case letter after the colon in the summary.

And of course, thanks for the patch.  I always have a soft spot for
patches that improve architecture support.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX6c4BQAKCRB8DEliiIei
gQ9lAP0fcAIi1FA3cG5mpNIDvxX0XFq4Ea4W9XQovejOn6c0AgD/bJDsFLv/I4GE
9Ar33pAb9VFmddy0gYj081mmgTZgVg0=
=GgIJ
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--
