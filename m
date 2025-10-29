Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2512773E5
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699205; cv=none; b=VRPTjxSpO8miLNXW4kEDZMnUkGY5dTHiq7v+L4tisOTjt6X0YQTID2nnZ3T2iCXe4t7JpbUQq8tixPAEQwIWZbG9MzMN6UA+iYiAM9WD06spunaMgA8eYZIO7RG6a+WMu2sTs+jXrxBC79qWDfeycnlQKQxlN2rQwfVDt6EZ9Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699205; c=relaxed/simple;
	bh=yq8lnDFYYnAYPj9/KoBMqCvzXYZIKxDG/epHSHcotdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h95FyHjBGboDPgWAlzOgD1Fyd1rhkunIo7jZ3oHh5eM69asUsKCT56wwmQ0aDu5COBO8zINi/3mSBJEgZnRwCve1Iw/ntdpKAtYpU9Z3X8uiifZHuzNXgnJCeB9CbwA/sKe6j7GLJ7Wtt9OzoS9IIpYWOp6mVFsxiVMoclc+t6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=zCcPZwFm; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zCcPZwFm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761699201;
	bh=yq8lnDFYYnAYPj9/KoBMqCvzXYZIKxDG/epHSHcotdc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zCcPZwFmeFTek3TX46UDc4pBkRtimfY3z+Q0rVCPvJgOGbeXqSqTHcTOMNXW3FY0r
	 kyl3Cu1REtDZ+ja7PmcuJ+5ZDAqzscB8Ez0PdEeBxuoQPApykii26SU6ks7RXBC0xw
	 e9jxdjtjruiYEr4YDoSH3FnA7T8lHK7zg7Nu+6C/1xW2BBllgheuM/C44/HmyH0KnD
	 hAAYHgHQ664GcxdxElxMr4kvYsgCnRsDaI6vJ8NntFvAmdDuowmArfrKPsfckhRoAj
	 MGyQzyOPTMP5KD8LiCn+y+UmIkdkKM1hoJKo45uBk0haES4R3uS5vVOUlrSoNjEOiN
	 fqwhX+iKmhAtLTFQh/FYvYyFoS48hMmDkwGhzGsoCacGBwEM+VCRU4+k3g3S6EVYeT
	 RXClBtla7juFfVXVRyZjBQWCeQtMX2lGotcFkPdowRL5OxEj8KjE9SO8sqx/nXX0yG
	 T8jUQcQU2Ae5fN6iaMhbAmb4xbFiFP5KZ0fvWMYHW3y/3g7T/NQ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9578:8587:8ed:424b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A25A520036;
	Wed, 29 Oct 2025 00:53:21 +0000 (UTC)
Date: Wed, 29 Oct 2025 00:53:20 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 11/14] rust: add functionality to hash an object
Message-ID: <aQFlgIJ2asBamlQT@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-12-sandals@crustytoothpaste.net>
 <aQCKYtvzaP6SXmDE@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qvp5uXvFJSwW6L6M"
Content-Disposition: inline
In-Reply-To: <aQCKYtvzaP6SXmDE@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--qvp5uXvFJSwW6L6M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-28 at 09:18:26, Patrick Steinhardt wrote:
> On Mon, Oct 27, 2025 at 12:44:01AM +0000, brian m. carlson wrote:
> > In a future commit, we'll want to hash some data when dealing with a
> > loose object map.  Let's make this easy by creating a structure to hash
> > objects and calling into the C functions as necessary to perform the
> > hashing.  For now, we only implement safe hashing, but in the future we
> > could add unsafe hashing if we want.  Implement Clone and Drop to
> > appropriately manage our memory.  Additionally implement Write to make
> > it easy to use with other formats that implement this trait.
>=20
> What exactly do you mean with "safe" and "unsafe" hashing? Also, can't
> we drop this distinction for now until we have a need for it?

It's from the series that Taylor introduced.  For SHA-1, safe hashing
(the default) uses SHA-1-DC, but unsafe hashing, which does not operate
on untrusted data (say, when we're writing a packfile we've created),
may use a faster algorithm.  See `git_hash_sha1_init_unsafe`.

I can omit the `safe` attribute until we need it, sure.

> > diff --git a/src/hash.rs b/src/hash.rs
> > index a5b9493bd8..8798a50aef 100644
> > --- a/src/hash.rs
> > +++ b/src/hash.rs
> > @@ -39,6 +40,81 @@ impl ObjectID {
> >      }
> >  }
> > =20
> > +pub struct Hasher {
> > +    algo: HashAlgorithm,
> > +    safe: bool,
> > +    ctx: *mut c_void,
> > +}
>=20
> Nit: missing documentation.

Will fix in v2.

> > +impl Hasher {
> > +    /// Create a new safe hasher.
> > +    pub fn new(algo: HashAlgorithm) -> Hasher {
> > +        let ctx =3D unsafe { c::git_hash_alloc() };
> > +        unsafe { c::git_hash_init(ctx, algo.hash_algo_ptr()) };
>=20
> I already noticed this in the patch that introduced this, but wouldn't
> it make sense to expose `git_hash_new()` instead of the combination of
> `alloc() + init()`?

The benefit to this approach is that it allows us to reset a state in
the future if we want.  If we don't think that's necessary, I can
certainly switch to `git_hash_new` if we prefer.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--qvp5uXvFJSwW6L6M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaQFlgAAKCRB8DEliiIei
gZvZAP9mmVCxlqYxvlEzUN66ZabevJ51WU+I3mqzgB9rNPT9ZgD7BhA/LStZCg6o
zjakyU/hdFLqtvntMrkD0lMM6XsvZwQ=
=PB/j
-----END PGP SIGNATURE-----

--qvp5uXvFJSwW6L6M--
