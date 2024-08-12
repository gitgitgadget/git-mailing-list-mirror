Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AED1802AB
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496753; cv=none; b=aHAtcP+q9+2H6XcC/K+mbW0hOjd7YKpoIXgSE63weHgbrKBm6OH7R78dTWCbagYLRNXCi6rGbLe1rK224xLZ5u2+5x2aS5CWrHyL5xvjcr3WMqZP6+idDyxSxMWfhDy85/3cHrq/GiQs8lTejYz1y7XtkrZkpeDLy7xDp8Q5fbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496753; c=relaxed/simple;
	bh=gj8a2LC9Paa1cXGn5ExtoGVyhM6XUMkiy75HYhnw3qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORJkntnLl3jd4J+Bfr8BAiKYmV0l1cU3BswHz0xAOdu7DVkFzFZLwIZyFkbWtoo4//9xnKLbWNTyrxw75YHYcIdp1CAnk4NyB4D3xBkn+AGfc/A3lZxuxCy8wqLzxOFHxR3bERyXQOx6gI7QMH2LBsLBn7HXZFO71PuoOJ2YS3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=NdTXvW1Q; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NdTXvW1Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1723496744;
	bh=gj8a2LC9Paa1cXGn5ExtoGVyhM6XUMkiy75HYhnw3qE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=NdTXvW1Q8lRfjp96k13j3uJ9fLne6V8+5Jr1qbqPrwhErCHtZObMJtB1SQc/wOZKa
	 4VDbmpDSrRGsnmKO7EYLd1w2J5bS7FO2ONI3UhNMvzoePWY7oGi5QYNLKAQ7KcCkZt
	 dzBzs9EjlmUHsaR/PsPlgs1YudcnkS1UjxR8EHZLx5cm3lNeaX0+c2/TdYMsC1zjA9
	 m7u8Nzl2/05jdOucqIrniInSrOkPBozT2JQI1JiLbaqtYDf1BTxpAv4jdASfGBAwk/
	 lZiO36bhYjjBV7FtyrcUU5OIDa1eynmCwKqG86+nbGDQogii9I0fObZiP6FlBLIx9E
	 o5ppysTkONqSCKZAo1cTV9Bqe1OaqPncy6LmvSWMM+qY8a4LTpFuOLNXomQwA0ngP4
	 rJQ7QvH5zhwXbJHXaY+JXsKwHp8VH6PWfWjLcOfrWF8788Q+zHKNpFtFZMTGay5Yo6
	 bKtL7Ew9UBE7yU9i11KnHyMpkOu0PWfiH84F67gkKKAaiAhIVNL
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 486B4209C4;
	Mon, 12 Aug 2024 21:05:44 +0000 (UTC)
Date: Mon, 12 Aug 2024 21:05:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: ArcticLampyrid <ArcticLampyrid@outlook.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: SIGSEGV Error Occurs When Attempting to Unbundle Without
 Initializing Git Repository.
Message-ID: <Zrp5JnsVHbqs4TyN@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	ArcticLampyrid <ArcticLampyrid@outlook.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <TYWP301MB0563973ECA440E7DAF0F7E89C4852@TYWP301MB0563.JPNP301.PROD.OUTLOOK.COM>
 <20240812114733.GA3732689@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P1SafgcKYX4UyXGl"
Content-Disposition: inline
In-Reply-To: <20240812114733.GA3732689@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--P1SafgcKYX4UyXGl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-12 at 11:47:33, Jeff King wrote:
> So one option is to just do that check earlier. But that leaves other
> sub-commands of "git bundle":
>=20
>   - "create" likewise requires a repo, and seems OK. That makes sense
>     since we're not reading anything.
>=20
>   - "verify" requires a repo, which I wouldn't have expected, but I
>     guess it's because we probably unbundle under the hood to walk.
>     Anyway, it gets the ordering right here and checks the repo before
>     opening the bundle.
>=20
>   - list-heads doesn't require a repo, and segfaults. So it really does
>     need some kind of detection or default to know which hash to use.

If the bundle is v2, it's SHA-1.  If the bundle is v3, then it should
have a an @object-format=3D header, which is sufficient to set the hash
algorithm.  The default for v3 is still SHA-1, but we have never emitted
a v3 bundle without an object-format header (except for maybe a commit
or two somewhere in the history).
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--P1SafgcKYX4UyXGl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZrp5JQAKCRB8DEliiIei
gaDJAQDtfdw6DS235Gb4jU5aS2r0jPl0q1yajAGtdSNt2PCDAwD/XZQy+F0DUOuy
ce/0uQsewFn1nchI7NNyg3mcBiKFngk=
=6TUL
-----END PGP SIGNATURE-----

--P1SafgcKYX4UyXGl--
