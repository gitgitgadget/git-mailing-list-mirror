Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7892F1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 00:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfBMAAO (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 19:00:14 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34482 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727018AbfBMAAO (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Feb 2019 19:00:14 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D532C60443;
        Wed, 13 Feb 2019 00:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550016012;
        bh=2fSaBFethL9ZSuagihzQn6z4LfWSSo0130nv9M96HX8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zCqsIMnBuTCiuZwG9bz2tUGP4RKiHzR1nRmBJQA6N3vD4SwlD3lJSoSkWi4+kI64w
         vwji175HYfwQByBR0Ajdq1lnmBWeicCP8S/mwWB+zLCLuXD2Sqo3fx8icbomfug7lN
         asWsq5lz7+ZQFnH2aV7SWVo3PLvA2tk8k08mIrhUjf6bKWiR0v5TH6kt1OJr/8vXHz
         fqkjWL4OqxJAN/13BPDv9LBHq5+I4AIV84iFG5hVOUJXSI3IJXecuCOCAfgfqhVFjr
         Zh+ABGYHiwwGfPmBBGRZhb56vXTCXqRsEsrZUVkl20JHRIxpnUr6F7GbxOiXKcoMuf
         GMbTa+42mNwFI2ZF+EUoMBAwqWrnLT0oo2156cZ+wjNvQ8JOVefgDhRags11qoitA8
         UYEpmWTxnO81L6QmVGIBUTliGoQiP/8on3hLxFN34Cd2CrNxpJe4FMLKMNvzOVbv2W
         VP+EPrXhbNYs04ugUQCuafmbd75zlhGSwDDD/imdpWj4N7k6hWL
Date:   Wed, 13 Feb 2019 00:00:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 04/31] pack-bitmap: replace sha1_to_hex
Message-ID: <20190213000007.GG684736@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
 <20190212012256.1005924-5-sandals@crustytoothpaste.net>
 <20190212063749.GC21872@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Content-Disposition: inline
In-Reply-To: <20190212063749.GC21872@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 01:37:49AM -0500, Jeff King wrote:
> On Tue, Feb 12, 2019 at 01:22:29AM +0000, brian m. carlson wrote:
> > -static uint32_t find_object_pos(const unsigned char *sha1)
> > +static uint32_t find_object_pos(const unsigned char *hash)
>=20
> Isn't this really just a "struct object_id"? Why don't we want to use
> that here?
>=20
> I suspect it may be partially because our khash is storing raw sha1s.
> But shouldn't we also be converted that to store object_ids?

I think probably there are some more places that we could convert here.
There may have been one or two places that weren't convertible because
we ended up passing data from some sort of buffer around. I'll take
another look.

> In particular:
>=20
> > @@ -181,7 +181,7 @@ static struct stored_bitmap *store_bitmap(struct bi=
tmap_index *index,
> >  	stored->root =3D root;
> >  	stored->xor =3D xor_with;
> >  	stored->flags =3D flags;
> > -	oidread(&stored->oid, sha1);
> > +	oidread(&stored->oid, hash);
> > =20
> >  	hash_pos =3D kh_put_sha1(index->bitmaps, stored->oid.hash, &ret);
>=20
> This last line (which is actually from the previous patch) is going to
> always truncate the stored data to 20 bytes, isn't it?

No, I don't think it does. The _sha1 variant stores pointers to unsigned
char, while the _oid variant stores the entire struct object_id (not
just a pointer to it). We don't care how much data the pointer points
to.

> I think we need to define a kh_oid. We have the "set" version already in
> oidset.[ch]; I think we need to make that more public.

I wrote this quite a bit before that code came in, which is probably why
I didn't do that originally. I seem to recall last time I looked at this
that there was some reason that hoisting this didn't work as I expected
due to header include order, but I'll take a look and see if I can
figure out a way to do this.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxjXgYACgkQv1NdgR9S
9oujVxAAo/3LtgueFLY5nbbsP8OKD1BU3plL1fy/WjQOR26PkSmz0xdEjxOX1lHG
QUtI7Fl++WItQ8F5Gw2nYZIIHSowvNbcn3Vx3TWg0tUnRVut+yXezC0zgAjm8m0d
aUJhqBxp1q6t+9mzBmgcyuU7KUa/T/zC2SGL29G83YgrjOoX7GCr/IC6ZgAKcrO9
pDK9jwa+2+VbQPBmNAPb2vLodAoYcpkQdfBBQBaE7HksRO/KRixD9jziHbgs37lS
zgtj8VRRWPicMllNi5Jsok089Lh+kJTmqy2phS3yNsfhGbovpghAaKG6QOiclKd2
5gIZIN1aJvwweah+nofAkDkm+3XoZaJx0cRNIXQU8AO5C+xGaUWEmJsC4DQHKa6O
JKrZPvuPD/vQeotfN+wAE2lh7QEI0Gsf4k0uCveUItgGafs1SITTBe8NfiG9pGtz
n+upAYS0cOVMwFt7yoxxbNOFSnPhqeTnACwGp2YzgPOL4EkvoA1EUnCPQV8JbSB/
EstfGWgMvvbzXhKn85MNk++fNyQVH8j8HJlZw7xYdYloaQrdnT90WEvg8EyIeJnQ
5ZU/BGIboLFzGcD6w6xPIuHYG3qFi6bAGkAbHE+fLYaCGi+SHTGH1SkPDx7+3iI7
lg0byVhdL6MaWngtuAALQKcLYzYOPtrdqqkYu3jfTE0fiomdih0=
=VBX7
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--
