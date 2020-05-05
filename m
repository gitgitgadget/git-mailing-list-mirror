Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F90C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 09:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1741206CC
	for <git@archiver.kernel.org>; Tue,  5 May 2020 09:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="A/3YXqkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgEEJY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 05:24:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37914 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbgEEJY3 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 05:24:29 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E36066044D;
        Tue,  5 May 2020 09:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1588670668;
        bh=ax6Qircm54O8UzkKsoPwaHleYqGZataOPtNC8mrkGDU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=A/3YXqkXqA16L0UuNdBV1J3d+1eS/SoR9e5JDV9tK0oqomWsnz2uBKGMrtbgPq0Xk
         XTQCWwAj1/1gGbdHsvFjoEyr3x+75wOGPHFgHmnCSHUWYR0WZqzF/feXbsf+5ACzqZ
         vL1qHPps1dNU4zx6yVhZCicsiNXk4P26E44+qi3lee/H1P1NHIuzZJM7iU65+3mDqX
         TIIO8dXrITVBNfwDFdYVhjG6DoDpjDSr+7hr1k9ifsftkRtDthB5piQ/0nwufw1ei+
         mft+0z/nAwbA1LCrTNrvPU7XdkXzmsCk9ovFFWItC9qWjChAqCFSIDtixYL0oYP009
         NwytWLuEjsS5omF33OzZBTM4zkTRam2eB40AhIoreebGZ/Nj8byKw6C/MtkYJKbip2
         Z/JKvQTgKYbmYii6G0/+sLaqU1JzsKUxNtxePLH5r6Mcdr2pF9uDy1WPMN5Hv/VVbd
         8OebAV4RNZoxC/nSoceEyLgUbawSAqUpsRtI7VHYnHylQne6N68
Date:   Tue, 5 May 2020 09:24:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin/receive-pack: avoid generic function name hmac
Message-ID: <20200505092421.GF6530@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org
References: <20200505054630.5821-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline
In-Reply-To: <20200505054630.5821-1-carenas@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-trunk-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-05 at 05:46:30, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> fabec2c5c3 (builtin/receive-pack: switch to use the_hash_algo, 2019-08-18)
> renames hmac_sha1 to hmac, as it was updated to (optionally) use the hash
> function used by git (which won't be sha1 in the future).
>=20
> hmac() is provided by NetBSD > 8 libc and conflicts as shown by :
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
> While the conflict, posses the question of why are we even implementing o=
ur
> own RFC 2104 complaint HMAC while alternatives are readily available, the
> simplest solution is to make sure the name is not as generic so it would
> conflict with an equivalent one from the system (or linked libraries); so
> rename it again to hmac_hash to reflect it will use the git's defined hash
> function.

This is fine, although as others mentioned, there's a missing sign-off
here.  While it may seem that we can use OpenSSL's version here, we
cannot, since not all versions build with OpenSSL (for example, Debian
does not).  In fact, it's possible to build core Git without any crypto
library at all if you don't need HTTPS support.

I appreciate you pointing this out, since it was a surprise to me that
this would be in stdlib.h without further guards, although perhaps it
does have guards and we coax NetBSD to provide more than standard
functionality (as we do with glibc).
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXrEwxQAKCRB8DEliiIei
gRP8AP99HPZqLAPPYDoIhjInNRSYA9L63zIrw1dc63iTvitawgD/f58xiBXQZYTa
v9E5uQHeBDj2BpJPe2IWI+ay0EohfwE=
=h/HE
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
