Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A9C2046B9
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736376301; cv=none; b=t2PLxS5YxQQ+F/qzno7h0GlMHEApu5Gs9mWzjeLv+0RsvsDE4JuKaCGnmcUKLGz4kxEkRc1OhfFkyar+9cIvJFna0uMuwoZiJuiyilFuOWpVNgVJNkP1qL74ySgf5m9Y+WG4VVZ/NIgljGczrTvhmeU5cUpaeMxhyUCzTZJZJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736376301; c=relaxed/simple;
	bh=ewN0x4z5zkz8BLPDeGR38Sga4hmekiDC0OmlPTo/UaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCcl9clsK9cUmiVabX8E8WVTfRfLJ15oHCh2bDYsdddPJMKLzkY8HRLmRC+xWi5V2HfINXvdEP4T2G6PXmhTm1LDxB6NTEHkHuSZiscij4MwzDjdHIMlvU2sqoBGv1oIsK//9lsQu4LLwEWft6mT57Mwb/RR8N55mwN5BjpiTuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=DwSJUyh0; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DwSJUyh0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1736376293;
	bh=ewN0x4z5zkz8BLPDeGR38Sga4hmekiDC0OmlPTo/UaQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=DwSJUyh0cbH7Qh0Lx4Y//G6dzNYllaQNpKdZyAIHRorHoDIQDNwM7T8v9WOQswk73
	 tyNbUlshFkPfe+ZCopdw3vkk1/w1FFGQ7d847n5cVnvHfNefvT2/AMFqIbkezh3K/e
	 qb5AAvPvWO3tv5bx1s1Rexr/IK5iqpLYer1xu6g1V1H6Eq/qASl6udmKe9gz1xAabc
	 bGml42GWsIjbFr42ULJSyIO1fO+DHVyWMbbVZxMrxx0wA4lnrUq6Swc9Z/fovPHZaH
	 nnxWbYYDxrJd0VRqiW+QHS8YY3FL5jVvT8xxApoD7mFj9JMXKTw6DDSsjoxN6OJdae
	 Q3OFT4CIEgeDSQ1tIeORe4LzOi5GCwaHuclw8jjvgQdtiZe8+9s+MuWE0VU9IXIGSZ
	 5jXayuJIdiHiINM93UN4axMqztZHrfsJ7uD+ejsVJWY3sLLCe/MWApxVDHilI14/qT
	 4u6tKbwz/lOvuR/t8SrK+dCjrUU8JFkdbTHJI54V0U4qD8NOjqw
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id DEFAD2441B;
	Wed,  8 Jan 2025 22:44:53 +0000 (UTC)
Date: Wed, 8 Jan 2025 22:44:50 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org,
	"'Randall S. Becker'" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 0/2] reftable/stack: stop dying on exhausted entropy pool
Message-ID: <Z37_4hoUgeVd3p9x@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, rsbecker@nexbridge.com,
	git@vger.kernel.org,
	"'Randall S. Becker'" <randall.becker@nexbridge.ca>
References: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>
 <Z323CLrRsnOko1gB@tapette.crustytoothpaste.net>
 <00ac01db615f$70b72600$52257200$@nexbridge.com>
 <Z34m1HRLAeEszXDG@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ls6WjfMk44fBTyLY"
Content-Disposition: inline
In-Reply-To: <Z34m1HRLAeEszXDG@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Ls6WjfMk44fBTyLY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-08 at 07:18:52, Patrick Steinhardt wrote:
> You reported in [1] that a couple more tests are indeed failing, not
> only t0610. That changes things in my opinion as it shows that this is
> not a localized issue in the reftable library, but likely in multiple
> callsites where we use randomness. So my current patch series is not
> sufficient as it only fixes up the reftable codebase. But in the case
> where it's a general issue I tend to agree with brian, because I don't
> want to play whack-a-mole with all the callsites of `git_rand()` where
> we can indeed use insecure bytes.
>=20
> Honestly, this rather makes me want to remove the OpenSSL backend for
> our CSRNG completely. NonStop is the only platform that uses it right
> now, and it seems to be easy to misconfigure. All the other backends we
> have don't have the same issue as explained further up in my message. So
> does NonStop support any of the alternative backends that Git has, like
> `arc4random_buf()`, `getrandom()`, `getentropy()` or reading from
> "/dev/urandom"?

OpenSSL's backend is only as good as the system entropy source, which,
apparently in the case of PRNGD, is not very good.  The last release of
PRNGD was in 2007 apparently, so I don't think we should hold our breath
for a fix.

Or, of course, it could be simply that prngd works just fine and there
aren't enough sources for it.  If the machine has an analog microphone
input that isn't plugged in, streaming some data from that might be a
good source, since that will be noisy.  A second of recording signed
16-bit PCM data as 48 kHz might provide at least 64 bits of entropy[0].

I will say that libbsd provides a fallback implementation for its
getentropy code, which would allow the use of arc4random as a backend.
I know there were some portability problems with getting that to run on
NonStop, and of course I provide no guarantees about its suitability or
security, but it does appear that there is some alternative if the
porting problems can be overcome.  We explicitly have support for libbsd
in the Makefile already.

That doesn't avoid the problem of TLS and SSH not working, but it may
get the tests passing.

[0] That's 750 samples per bit of entropy, which I think should be
reasonably conservative.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Ls6WjfMk44fBTyLY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.45 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ37/4gAKCRB8DEliiIei
gUG3AQCNWGQ4hjPRD/nmJWnv9h8aLjKGhAF/mfFjfgWTJ4I1QAEAorS8Et545Ngf
MGW3oVgZs12XXS86uxo1YOUsxLManA8=
=1yj7
-----END PGP SIGNATURE-----

--Ls6WjfMk44fBTyLY--
