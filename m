Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C9E1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 23:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeJRHCM (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 03:02:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51292 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727101AbeJRHCM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Oct 2018 03:02:12 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6020961B72;
        Wed, 17 Oct 2018 23:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539817454;
        bh=Q7g8bi3pdxVmJI3G1RgEE6TDPaQs/9Un0+ukbnJUnBc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=i3D1hmVIqx7CMcH70C5pETXCFOC6odYyx0Kegvj/ppfnllxnJJKI/m/p0tO1vh3Ak
         KoYQ8IM7kf6ajM/8gylP/Mlz2Lz1T2HOtTqniOXf3Q7cMncmQHg86vCu9Sow2GqQmP
         nK4Ded2hPuQBCj77sXnueDpP8BB6JScfTY88h/To2W564LfdLcMkgUXU5dsxtdBX8F
         yFuIH7YqGeNamE6h0xQoc/2vFh+UA3PZVi5y/+yGGQJcPVVz/Uu8CnfspIoFvpag+I
         UYM5LIVF5eJS2vysOP0GO39Iq+c7udl5+i6vZkugALtHEBbpdcZQHxltKF589fTrJA
         hUMyg3bJQ+1qaaPr+BUpVVBc9gEtjhDm7GjdAnhfJPcJAz4yn5P3lBesvPDZg/Q25G
         ivdNFdQO80+SSiyN0FJvzKkXn89m6LSf6R6LVhFzV6kIRVaNDyNWBe/DqYPbEbt2rv
         osgXU3Hcl4o291oa0QtWXHySgQEYDLHCnuRIuhSP8hUQjZ2KuEW
Date:   Wed, 17 Oct 2018 23:04:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 10/13] Add a base implementation of SHA-256 support
Message-ID: <20181017230409.GK432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-11-sandals@crustytoothpaste.net>
 <20181017161241.GS19800@szeder.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/0kz5dD/9FLhi4MI"
Content-Disposition: inline
In-Reply-To: <20181017161241.GS19800@szeder.dev>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/0kz5dD/9FLhi4MI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2018 at 06:12:41PM +0200, SZEDER G=C3=A1bor wrote:
> On macOS there is a MIN macro already defined in the system headers,
> resulting in the following error:
>=20
>       CC sha256/block/sha256.o
>   sha256/block/sha256.c:133:9: error: 'MIN' macro redefined [-Werror,-Wma=
cro-redefined]
>   #define MIN(x, y) ((x) < (y) ? (x) : (y))
>           ^
>   /usr/include/sys/param.h:215:9: note: previous definition is here
>   #define MIN(a,b) (((a)<(b))?(a):(b))
>           ^
>   1 error generated.
>   make: *** [sha256/block/sha256.o] Error 1
>=20
> A simple "#undef MIN" solves this issue.  However, I wonder whether we
> should #undef the other #define directives as well, just to be sure
> (and perhaps overly cautious).

I'll undefine the macros at the top.

For MIN, I'm going to go with the simple approach and pull pieces from
the block-sha1 implementation, which doesn't require this code path...

> Some GCC versions (e.g. gcc-4.8 with -O2 -Wall -Werror) complain about
> the above line:
>=20
>       CC sha256/block/sha256.o
>   sha256/block/sha256.c: In function =E2=80=98blk_SHA256_Final=E2=80=99:
>   sha256/block/sha256.c:174:2: error: dereferencing type-punned pointer w=
ill break strict-aliasing rules [-Werror=3Dstrict-aliasing]
>     put_be64(ctx->buf + trip, ctx->length);
>     ^
>   cc1: all warnings being treated as errors
>   make: *** [sha256/block/sha256.o] Error 1
>=20
> Something like this makes it compile:
>=20
>   void *ptr =3D ctx->buf + trip;
>   put_be64(ptr, ctx->length);
>=20
> However, it's not immediately obvious to me why the compiler
> complains, or why that intermediate void* variable makes any
> difference, but now it's not the time to put on my language lawyer
> hat.
>=20
> Perhaps an old compiler bug?  Clang in general, newer GCC versions, or
> gcc-4.8 with -Wall -Werror but without -O2 don't seem to be affected.

=2E..or this code path.  Presumably GCC 4.8 and macOS are happy with the
code that we already have in block-sha1.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--/0kz5dD/9FLhi4MI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvHv+kACgkQv1NdgR9S
9otHHA//fIIoB4NqBhfHbGP2VIjCCLL7piQ8vRBxE4UellQVTcE7MBP5dcrc2RbR
hVzUg9a8b/ivhMIiOnNeFMyrXKSw3E8tUqqkfIAVYzw4ixbV9QtxGLhzhtu4R701
UtZg2PlSlIbPVVREbaoMLu++1XhtNzc/pOyfPYQ3raqhLRahce+77ZuS+LKTA5EB
kthaw9uz7EJOmJsZszmAuL2OdtYDkpfJsOCgKguF7azRwdDuhBp/8TRYw016R4ue
+nanj4ECka90lgwxIvqDcv+9T/8Jvc5hDCGWPMKaXVpeokPAkzhba571MlyB7zAN
bXeq/vykvSXTziMbh5hETsg8mb1gvVKkrGFkMnytmIwQLb8x3+ua1ljO3LXSbNfR
z+OfyrGMyiBAELQQ+xtL7f9vGZvnAMNQZWaP3HBaePOhn9Va26mRE6A6Q81z4dOR
/4CFemopa7FreDpWTov+JjcvsMqY6DsaHwX4+nZbgfaDmvB7za4CdwkobYA5+wjH
QLOs+irTijW99vZkuu7bz5VXgw6go9mSc7U02H+sj9Hj9NdKIy8AUlN679h7NpI0
PIiRBR628vl54rnetCgHu2zBVVAArpS81KAO3HbKDYv8gRQOUAn/gZ5+/A9t9+rT
lq4xqpCsSKv5oveLehOQDxvsT2RndMvFzafxttvinPJP+lKvR0s=
=EYZd
-----END PGP SIGNATURE-----

--/0kz5dD/9FLhi4MI--
