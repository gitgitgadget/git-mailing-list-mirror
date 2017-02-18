Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61EE1201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 19:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754003AbdBRTM1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 14:12:27 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:33608 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753357AbdBRTM0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Feb 2017 14:12:26 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 99ECF280AD;
        Sat, 18 Feb 2017 19:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487445143;
        bh=o02qMXAsO/RHofyt17kBAePUB8L0HzJCa6M+acRoxYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tefH0sm0mrjou2edL0LKhsgClu5xRnsGbWCdxL8wM3MhSnhP4EN6G+CVbKdV0dEKS
         MaSqbWZHEB0HB+KWfKa3u4cKU36LpGOfzCGIpHDSZndGLsCzRRdvVXiB19FMIqpiP5
         8qrJ2vNYbKI/x16U3VjC2u3QIyKUBjDEH6xmgiTZcczoCoDGRyxW9DnGzH3tzFVLp3
         dPH3xyM3GZyKms525vln81Su9CDBdjP7QIAoOnDGeApBSSLUGQ8JSbYhSN3WqeRPN+
         jfEhAQCbl1ENIwh7nO960XWHtY+TRJBfQ6yOyKJooN56KBOMRC9tOR8NK2D565QRV6
         afKQhGmcwdRJTnTBflmfDwRwF2mNOzvi8kWAwSm0v6cy2f3lELYjY47dJG+i9YXbtD
         17RMp5h0/Ztk+iJb435nW93sHx1EM62bK7nSI/A16kL1p1Mry2WSFh+FPKP2PsH2sB
         gOH/TTCX2LowegUNmZ0OsoSidN7Fo+/GEI4obredBGOg1aUo5bx
Date:   Sat, 18 Feb 2017 19:12:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/19] builtin/diff-tree: convert to struct object_id
Message-ID: <20170218191217.thn3c2bympv2g7pm@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
References: <20170218000652.375129-1-sandals@crustytoothpaste.net>
 <20170218000652.375129-3-sandals@crustytoothpaste.net>
 <3630da01-5af3-bc02-3a8c-1e3495512279@ramsayjones.plus.com>
 <20170218012607.kdisudmmponvts35@genre.crustytoothpaste.net>
 <20170218014217.sil4jyukkbqguxfz@sigill.intra.peff.net>
 <20170218031530.2bhlnjcukl4ybt6h@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nf3z7bmdxmszdpxr"
Content-Disposition: inline
In-Reply-To: <20170218031530.2bhlnjcukl4ybt6h@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nf3z7bmdxmszdpxr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2017 at 10:15:31PM -0500, Jeff King wrote:
> So for this case, something like the patch below.
>=20
> Incidentally, there's an off-by-one in the original loop of
> stdin_diff_commit that reads past the end of the trailing NUL for the
> final sha1 on the line. The problem is the:
>=20
>   pos +=3D GIT_SHA1_HEXSZ + 1;
>=20
> which assumes we're slurping up the trailing space. This works in
> practice because the caller will only permit a string which had a
> newline (which it converted into a NUL).
>=20
> I suspect that function could be more aggressive about complaining about
> nonsense on the line, rather than silently ignoring it.

I'd come to basically the same patch, but I did pick up a few niceties
=66rom your patch, like avoiding the off-by-one issue you mentioned above.
Can I place your sign-off on the resulting change?
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--nf3z7bmdxmszdpxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlionJEACgkQv1NdgR9S
9ot1qA/8CjEi3ePe6NfGbwiweSGBpMUHKGE+7GVFNgKTDyFxk0VAL3vdV3Qs/8Jp
Qu4ttpmY7mY2LYzPqdTMpzxSyveOaHkj2jLE6pScfZa3kgZY9VCHxfQtoBEqpRHO
zvLJK9HBdFvEKZSrKda/763oHNVOjqU6eWYoOhXpQxlYAtz0/wHBZOU3dg/VBYsG
q2D/5JD8TS/D2mnRUkj8WwpDxoXp5SnCx8TwgbB9ldFJkMrpcs7ySgZQ2di6tuY7
ki1fVHjUwypbA+dVSibpOKb20lR464tiXLUwvkWB+e/RlFeAQwmcn3M+uu0+dCnt
37Ncb6xvZVa0wzUI4wOrITiK/s603XNIAeoCL3f4g3Mbn4Wj8Y2lkoVw8WOuk1pW
r//udwZoTeiNsrTTd+hof6bpm5dw4H9ct6ZA1vJSHda+Wg5GhkCC+jJFncbHBc+3
MvhT057g8H0OlYTvKg/9YUsEJtYLaNG1aU9kEGSfl0dKek86lX4AddrG6EaAPwHk
7z+KJbmR3zY9cjw00p745+byYJ4Vgic1EOR3i8QuT758t21Zb7WYv4NfXDLn/NU9
i0bmC5gdfQCmvZXAsb9+Fe7c0sxwxjK2KKvdveSGcNVd91JEHiqzn5KH1LBlf5dl
M4O1ZtlzTdkPodJK3Y3qaa+iBn8Lyrzlo+j9htHIjIXLdwD7SeM=
=AE1m
-----END PGP SIGNATURE-----

--nf3z7bmdxmszdpxr--
