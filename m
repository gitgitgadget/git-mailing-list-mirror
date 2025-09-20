Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D772B2FB601
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758382151; cv=none; b=lxfg76N2KVMP4YAFROKb8g7CgIAHjET+5DnUPaggIOGB9W4xMKRbnIGgJnxhrnesZeJhfU2B9MmM5M9Oq7tgVbdAsh1aKM+W3x5+JZucnHic3igRBKgoitIl8NX+jBbRqMyll5k5WieMXThLDZdho/m7nD7OwUsYM6sJn7NbSdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758382151; c=relaxed/simple;
	bh=5bi2EPiYNPta2QPYE615guiO+OCjx2fRK7BQ9B0l4R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDa8bd3BIYGkt8kDAZBtE73+Ka6aEkcSTZGS3lnjufygoaE+2N3AHnTNW6W1Nv32UE3vSA8TDCGhcNSGqSjyc0UawuVVQKGgjcl0K/woenV1wdjJomv835+2JxRqqpVzH5j9n7Vtdr2pTWtYmWSWCnr7XWTv0qcdZFDhCOrq9QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bxX07tzI; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bxX07tzI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758382147;
	bh=5bi2EPiYNPta2QPYE615guiO+OCjx2fRK7BQ9B0l4R0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=bxX07tzI90uBgNbP1eaxgES7nxMStdat7Az+mSQhdyZG4Yh1n2ltHiu02Y4DY4i4w
	 haH+tuoSHmj3I6pJXoKn+gV+jcEw3xJC1iiPZOCpmELPAIMhW5/CZdlfqFHSjW9svZ
	 k86v96nCj+nFvcgwOVhJvpgwZx92Qj9upzNEKT7ZpOBzdLYwUNGJYcRV8kbe4uGBFQ
	 gZriHH69YKsIqpFP3JGoKWs0urOvUSw/x+uOXAufAEHVceG4BJv6udB1AQkA6f/r4l
	 OjUlYocrOVvcbrjsv7InRsz6qg8XXnOwhWlVzl6eEqVJOG9pYB9aUuBPrXXAd5Nn50
	 RhE5PecaUBBVx3bMzWyOh3iaeLYKPE7ICPm5SOWB47iTbLLGLN4LD4RzM+gm368Bqo
	 LGSqyKumt1p0OEs2cMdZ5DYBbQaVGZdBaU97VPkQBtWjt1D9GB33hxrUad3bi62and
	 e/72nXG+n/vtWMZC78tACebFYkikrH+gsH4pwcQ19CHVTt5gTdV
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:69d9:2a04:7f4c:de5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9617A20112;
	Sat, 20 Sep 2025 15:29:07 +0000 (UTC)
Date: Sat, 20 Sep 2025 15:29:06 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/9] docs: reflect actual double signature for tags
Message-ID: <aM7IQibwwKFJZcYE@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20250919010911.649831-4-sandals@crustytoothpaste.net>
 <xmqq348i138l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ubRMxMhyIwvmaWEw"
Content-Disposition: inline
In-Reply-To: <xmqq348i138l.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ubRMxMhyIwvmaWEw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-19 at 22:34:02, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> >  Signed Tags
> >  ~~~~~~~~~~~
> > +We add new fields "gpgsig" and "gpgsig-sha256" to the tag object forma=
t to
> > +allow signing tags in both formats.  The in-body signature is used for=
 the
> > +signature in the current hash algorithm and the header is used for the
> > +signature in the other algorithm.  Thus, a dual-signature tag will con=
tain both
>=20
> Not suggesting a change in the text, but to make sure I am reading
> the new text correctly.  Does "the other algorithm" refer to the
> compatibility hash algorithm specified by the compatObjectFormat
> extension and the "current" algorithm refers to the objectFormat
> extension?

The "current algorithm" is usually the main algorithm (that is, SHA-256
where `extensions.objectformat` is `sha256`) and the "other algorithm"
is the compatibility algorithm (SHA-1 in that case).  However, when you
convert that object to SHA-1 to hash it in SHA-1, the "current
algorithm" becomes SHA-1 and the "other algorithm" is SHA-256.

Does that make sense?

> > +an in-body signature and a gpgsig-sha256 header for the SHA-1 format o=
f an
> > +object or both an in-body signature and a gpgsig header for the SHA-25=
6 format
> > +of and object.
> > =20
> > -This means tags can be signed
> > +The signed payload of the tag is the content of the tag in the current
> > +algorithm with both its gpgsig and gpgsig-sha256 fields and
>=20
> My reading of the previous paragraph is that we cannot have gpgsig
> and gpgsig-sha256 fields on a single object at the same time.

Correct, unless we come up with a third hash algorithm.  Hopefully that
is a long way away, and we are not considering that case here.

> Should we say "gpgsig or gpgsig-sha256" (instead of "and"), to get
> the resulting text parsable as:
>=20
> 	both=20
> 		its gpgsig or gpgsig-sha256 fields
> 	and
> 		"-----BEGIN PGP SIGNATURE-----" delimited in-body signature
> 	removed.
>=20
> instead?

Sure, I'll include that in a reroll.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ubRMxMhyIwvmaWEw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaM7IQgAKCRB8DEliiIei
gbPsAPwK0YgQp+Ll5oOCyVKVsN5q9CDLurXNouXyd1kQwEjHXgEAwmGvKov97Nlw
rDtgg/qPPgtQwawTY5vWtdSUZEWSXAY=
=5sDO
-----END PGP SIGNATURE-----

--ubRMxMhyIwvmaWEw--
