Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDD0C35DEE
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 00:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD84218AC
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 00:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="H8F+qMMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgBYAdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 19:33:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40726 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727976AbgBYAdI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Feb 2020 19:33:08 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 362D66048E;
        Tue, 25 Feb 2020 00:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582590787;
        bh=/NAoT2+xejVaO90pKhLZy3rxL96SoiIvkuV9vGDPWEo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=H8F+qMMtbmbooqgcfZIPez/RsCVNM3ur7tNXxfga8k+MqUNeYOWVJJAxVyExdlIWZ
         XcKMfD7O9zJyE9brmkj7L78V2RNCHgrm39/bklRLMMXwZi9LqjQ5Ncw49ZH+jU9NHy
         h4ZWvWGaCTslnhLvAvpHH/uielYN+N4CDh3WV3R934NjRWoBAOZOcdzbKsGB05ny2K
         1GHwc8soSZeqpGQTRRF0jTblpLpzKH13eBqSHQ0WGxvAZ22wMDOqmyHu2kHC9onzbW
         +j3bipFSqvMVTyX5lgkdNnyFXK9rddTVR+4f403vBDby5er4czHKr4Q9QcxR10ECuQ
         XFbl3snIqL0Ok5EI2c7tjbp0PkraxE/3YIMPkal1vyZRmTYRLl4kgZjRFQSzH1XALE
         stZYSVDz39GDwdCJcNyh+aX6NlWyCIsD37vtr/biMeJPhy1muCovTu8KF2dx5YaqZ+
         ccsI/VHCNpZmLjPKA49uyXH2VFygyWjrrsCS6gp3i4EeIrBk6oj
Date:   Tue, 25 Feb 2020 00:33:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/10] removing nth_packed_object_sha1()
Message-ID: <20200225003302.GK6462@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20200224042625.GA1015553@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xtmLDbP6TiKhntQb"
Content-Disposition: inline
In-Reply-To: <20200224042625.GA1015553@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xtmLDbP6TiKhntQb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-24 at 04:26:25, Jeff King wrote:
> This series gets rid of nth_packed_object_sha1(), converting its
> remaining callers to nth_packed_object_oid(). The latter provides better
> type-safety in general, and it also allowed me to clean up some tricky
> bits of the pack-verification code (patch 7 below).
>=20
> This was inspired by brian's work in:
>=20
>  https://lore.kernel.org/git/20200222201749.937983-2-sandals@crustytoothp=
aste.net/
>=20
> but I decide not to base it on that series. It's semantically
> independent, and with the exception of one line, textually independent
> (patch 4 here touches a different parameter in the same call as the
> patch linked above). So I think it's easier to handle them independently
> and just resolve the trivial conflict.

I think this is the right move.  The conflicts will be minor, as you
said.

The series looked good to me, and as mentioned, I appreciate you using
oidread everywhere.  It's nice to get rid of more code with "sha1" in
it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--xtmLDbP6TiKhntQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5Uaz0ACgkQv1NdgR9S
9ou9sRAAyAPdLhLX7gDAEmuTv/J4xQg7jNucmunJC0FWUH8/Yi87p1CjURs82XrK
oqKtlfaQjSf/bWaIXgnx8diKmEUzQfvCBVpcqVDtu5JXLSTre0SprekuMjBlY24o
6dNu56jRnzab+72oYWMwOlYhGpxAMsnfMfdolraI3l7KRTR5Z5NrtLs1bHkxxdVD
QmM/gT7H0LDD7g6MbomIlNyqsAPqSr+SSHtfKr0egRw/unZjuR/9cp2yuoN7ca53
BF166nIuXl+OeQ2E4wygKoP4unK8XcFvvA0AEKWKMMbnxuTYD5WzBBAcjxyZrdEL
+YRapXGcgV2v/WaFnvo9d6MvmmdyTHzYNIFSbOuP/HO5wnKihbn36gpKQhnFLkmE
pCvVFks2VvghJyzEma09su9qde0fbagywv+DMs0syVQLE/Uu445KF5Io8eGvnOEJ
mlH+gakID3ksdxJEl5n09gU+G6TeMY0+8TBKEMYszRe07ObzZ7KjJDBNgIN0MbSb
2w8gwyDz5drjXq/Bb/uNFUabxZ77PCbwGINV0R8XlMqG3PXQQw5yMrvszjNMLCUU
+57L+sSDRdc7jZfQIo5Dw16bPksWFyXRuEDdPo0otoFhEHk9pD7sgS8qJZWYr2U6
p9ru9Ec3r5vlkAS3jzaHysvrJ9B4iG5q+H5Mx9YCUrBE9Pmew9w=
=a/6P
-----END PGP SIGNATURE-----

--xtmLDbP6TiKhntQb--
