Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A45C4BA09
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 02:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC222082F
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 02:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MzXZKvdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgBZCXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:23:38 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41520 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729395AbgBZCXi (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Feb 2020 21:23:38 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D630860791;
        Wed, 26 Feb 2020 02:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582683817;
        bh=RMTeWjrH7kFuXMpKPA3N+f6FjT7ol5DGOzaoF3azVjw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=MzXZKvdAkmgoboZpCd63AmjovhI2ZvPlNiSlu6THURxsSiNq3CBkPay/P1gOrlkam
         RbBmCdrwQNHK2CTh1umnRJ84naW81cmORM73bDc839NwYsJJ0QfV8w831g9HWwfT/y
         Dh/KTKcDUnoV0zxBxCPB9mJeXugOkCL0Mkbni6eIMoHPtX5Q1EWhXZ7a2w9zssKrgb
         DYiMZtzx0WYDkzG0qIf4syaSBckA2e2+f6b1ij0xV7PJ0sDTiiZeZJUwGSClwvXKgh
         pi0liABvZ8BHRYumbn+PjlS50c58NqHrKSIUcfYOSSl4eRU0fdAS+uhezRPe/H8iX3
         JwTtM8qoc0HvHPnxxFzBk6MY8QI2watYSD6zBQivBk/wXMzOFqdLotkvQLNrP99mbu
         Un37i37EUSNtaNKv0s6fL/0hbqZQmfJ4JjnplzyXFIYL3dPvBrqfHiMXvaqsrs37jI
         XIYD4ls2UbUg3nMoGRqPHPSRDLKEx7bdIGJqatZ0iu0B8dNs4J2
Date:   Wed, 26 Feb 2020 02:23:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 18/24] gpg-interface: improve interface for parsing
 tags
Message-ID: <20200226022332.GB7911@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
 <20200222201749.937983-19-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2002251127320.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2002251127320.46@tvgsbejvaqbjf.bet>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-25 at 10:29:26, Johannes Schindelin wrote:
> Hi brian,
>=20
> On Sat, 22 Feb 2020, brian m. carlson wrote:
>=20
> > diff --git a/ref-filter.c b/ref-filter.c
> > index 6867e33648..212f1165bb 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -1161,7 +1161,13 @@ static void find_subpos(const char *buf,
> >  			unsigned long *nonsiglen,
> >  			const char **sig, unsigned long *siglen)
> >  {
> > +	struct strbuf payload =3D STRBUF_INIT;
> > +	struct strbuf signature =3D STRBUF_INIT;
> >  	const char *eol;
> > +	const char *end =3D buf + strlen(buf);
> > +	const char *sigstart;
> > +
> > +
> >  	/* skip past header until we hit empty line */
> >  	while (*buf && *buf !=3D '\n') {
> >  		eol =3D strchrnul(buf, '\n');
> > @@ -1174,13 +1180,14 @@ static void find_subpos(const char *buf,
> >  		buf++;
> >
> >  	/* parse signature first; we might not even have a subject line */
> > -	*sig =3D buf + parse_signature(buf, strlen(buf));
> > -	*siglen =3D strlen(*sig);
> > +	parse_signature(buf, end - buf, &payload, &signature);
> > +	*sig =3D strbuf_detach(&signature, siglen);
>=20
> While I like the spirit of this patch, it makes the Windows build fail. I
> put this on top of Git for Windows' `shears/pu` branch to fix it (maybe
> you could adopt a variation of it?):

I'm happy to squash this in.  Sorry for the breakage, and thanks for
catching this.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXlXWpAAKCRB8DEliiIei
gV9bAQCy81xYlvaPWFgvoD58MuhMvYqjWiNIe+VglDECBDWymQEAthyyCwNleA59
x0gEGuGiCDCxCVHi5ZgqOGQPZ6OTgAg=
=zaMT
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
