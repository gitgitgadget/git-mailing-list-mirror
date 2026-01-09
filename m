Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317F268690
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767997089; cv=none; b=cPncT00wge+M5yRQri4PP7FSceBF5pnIYo6vGmgXzg3jomdXwcyb4Y4d0rxZBlT2bjjofcUZP3oNHF4c7Icpp40N3B/64WPjUYxz9EZkH5Bl0AzNqBv6h+Xr8naryA5rmvyCI7V9zdq8fKBjJcpZv2bUZoM4vf+f5OaoF3v7RpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767997089; c=relaxed/simple;
	bh=TLTmItwAbO5J+mJkTyIHat/eWe/AoV2q3INyxLXiabs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFqN12JJT4Mo2GJCxVPBrgoh7CZ84l/9QV9g9Sl20kykyT2jJzRBspQ/48aUjse/OBnDv+YV6TCHw14nKHc3pBiHlVMCBlx0Nq3HP/7axHuv92LrTYGqtp6Z814JoPng9cnUWTf/yhUUTGY2aOfnXHRBXyw/moL7nyiGBwNPg8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=zP5mVX/n; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zP5mVX/n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1767997086;
	bh=TLTmItwAbO5J+mJkTyIHat/eWe/AoV2q3INyxLXiabs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zP5mVX/nlTzklKOkOErni4QmTeVfV0zh6gzQ/WoEJTKaqa33XRb08ACO54t9S8xjY
	 lcba1ub0EgdnxOXbWJzoipxlKpu1cwoduE0GFwm91D0aP4q/i7gkh8VsBsiPA3b0gK
	 8H8ZYF1gVgtMmUQdkZB+HuHoQOVNpH91WUPrBL0K4jGK1uMnR+IaKaNx5CrqVnj6kD
	 4zlOjrrb6AO6rbNLV0Ltz4PqcRruY1UCY+oqLsDdEM4KZBw5h6oCGrsQ7L5UJrGpkR
	 5DtpUHZz2yQSo4afEEXh+36x3uXAULNWooWcFcmRM4plkLg6Wg0jAT6hZdlxvhfgwu
	 j/3Rk7aST5rpwIbj5+3kvM16xZcXp9+EeSuHqiQmKbqkY217JvTIzKt7zVoFfTRrW7
	 gav9/KUpULrUAVBxfEAUVh9GhW/lYGUmZTTdL6EJdCreO+OZLE++WeOacaXOOYmyho
	 74srMJAH04xPIgkmwroskECJERIiIbEBURTtuVDuERZpctLdZkV
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:8a11:cf76:28ff:b0fa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BDD25200B5;
	Fri,  9 Jan 2026 22:18:06 +0000 (UTC)
Date: Fri, 9 Jan 2026 22:18:05 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: correctmost <cmlists@sent.com>, git@vger.kernel.org,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: Re: [Bug] hook: -Wanalyzer-deref-before-check warning in
 run_hooks_opt
Message-ID: <aWF-nZ9MXp31QzXs@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
	git@vger.kernel.org, Adrian Ratiu <adrian.ratiu@collabora.com>
References: <72d123b8-b75e-4b1d-8506-95eb9ad350da@app.fastmail.com>
 <aWDm_n2YgjvaRmpV@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JbkVYoKckVvfAh/i"
Content-Disposition: inline
In-Reply-To: <aWDm_n2YgjvaRmpV@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--JbkVYoKckVvfAh/i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-09 at 11:31:10, Patrick Steinhardt wrote:
> It's not a real bug. If you take a look at the the `if (!options)`
> check, you'll see:
>=20
> 	if (!options)
> 		BUG("a struct run_hooks_opt must be provided to run_hooks");
>=20
> So we'd abort immediatly with an error message in case the pointer was
> `NULL`. Which clarifies that this is a case that shouldn't ever happen
> in the first place.

You might think that we'd abort, but that's not what modern compilers
do. Dereferencing `options` if it is NULL is undefined behaviour.
Compilers are free to assume that undefined behaviour never happens, so
what most modern compilers do is say, "Oh, we've dereferenced `options`,
so it can never be NULL," and then use that to omit the check
altogether.

This sounds bizarre and like it might actually lead to security bugs,
and you're right.  However, compilers keep wanting to make code go
faster, so they keep relying on eliminating undefined behaviour to make
more assumptions about the code to optimize it, even if that results in
code that doesn't do what the programmer intended.

This is one of the reasons why I'm in favour of writing more Rust, since
safe Rust doesn't have undefined behaviour and therefore doesn't suffer
=66rom these problems.

In any event, this is almost certainly a bug because it almost certainly
does not do what it looks like it does and the compiler is right to warn
about it.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--JbkVYoKckVvfAh/i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaWF+nAAKCRB8DEliiIei
gTn2AP9A5PGaqEhnhft6JvfziVdJPc3wg+K1XJwPwPNcMm6m+AEA4OAvsS/x7q5L
1YrExLXmLaq2nFjVaUeED/hrhvtfMQk=
=EFaO
-----END PGP SIGNATURE-----

--JbkVYoKckVvfAh/i--
