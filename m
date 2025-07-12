Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7D52AE6C
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752343217; cv=none; b=FGpluSrTWMMdzzEvZ39Qzp/pNL/48O3dGxDBQCat5oXhJD+SYQRPPwfWEJqpsFsOSJ9zGJf59XbQwbEUmVu60tTXMADkMg6yqXZtvtoOP9+nKTV2H8K0vXbWZIi1ZfzKz9/HQ3j0O80rDk91+QAE3EzfISkvvxfYWOxibcKZgps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752343217; c=relaxed/simple;
	bh=Hd4A7/vmm0jc5f+nWOcrf3ZgwKNmQxRdKFFKgVhMjrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJl5lIimC8zMsVHb63QmDcwSSMzX78YaHjVFvC4Hd26hb0aIDDq9/hKZjfau2k60yvR7inlCffsZhrArajG9+y2vB77oCQQnommzyL7qShpz3WzDvE98XMP57DhsFaG+P3RyDcLJHncx8u2gqxhTUo3+4dF6tRfYRRKE9987FHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=yQvpmDpM; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yQvpmDpM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752342716;
	bh=Hd4A7/vmm0jc5f+nWOcrf3ZgwKNmQxRdKFFKgVhMjrQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=yQvpmDpMLGtXF8lUNzqj2RxqmKayyi1kAvXoA+65ima6L8USNu2phkISGlUPGPDHY
	 07Br28Igc1N+R4q213EAco3xqawd0p0J+jqQ9zXObfLn0ljQOWWLbjooLjPc7S5jfn
	 OeFemI6i7Xs+6yIGiCPWUwR/87o+IOic8Vi87m5GQQTRQ8nOo9Pkgv5YYhYG9CPLcQ
	 zzQSrwqObZOgisimv9tZe47T7WYsqcE68OpzPm6bw7QTDfkm7lFo3f/SAqRbu+K3dl
	 XOFzEZkLFuM65C13ArlMkA1K42kN3yWftXNGR5DsbAj6LJHvf5pMqIZ3tRvo4guc58
	 uFFUWZrr+bPDQcGohCoRrRO+sR0nc+/CagYCu7NSQNtRk1+NZag1hFXIj1q+UsjQ+r
	 6dvTzRnXZ7w/1X3uDV6FlHjbL4e8gmSuyzQty6KlFnK50ymfSvdTL0+ogUfkOX0OiO
	 /A35vNjbzdQYVATT1CeqHUy9lrTRbWav/rY1e6a/vYl7S6AOiQs
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 80C2B2006F;
	Sat, 12 Jul 2025 17:51:56 +0000 (UTC)
Date: Sat, 12 Jul 2025 17:51:55 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] meson: disable PCRE2 dependency by default
Message-ID: <aHKgu3Ew3Pk0PL2v@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	git@vger.kernel.org
References: <20250712172615.11364-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s2reChrrcIhKGfgb"
Content-Disposition: inline
In-Reply-To: <20250712172615.11364-1-carenas@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--s2reChrrcIhKGfgb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-12 at 17:26:15, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> Makefile requires the user to provide the USE_LIBPCRE2 flag to
> enable this dependency, but meson has it enabled by default,
> which can be problematic, at least in macOS.
>=20
> While a popular option and matching what was done by cmake
> (which itself reflects what is preferred by Git for Windows)
> could result in a broken build or linking with the wrong PCRE2
> library.
>=20
> While not git's fault, macOS provides a PCRE2 library in base
> that is not usable (even if it would pass the test) and not
> configured properly, as it installs a pkgconf module that
> points to a non existent pcre2.h header in /usr/local/include.
>=20
> Change the default to off, and let the user enable it once a
> proper dependency is installed or meson instructed to fallback to
> the wrap.

Can we disable it by default on macOS instead of everywhere?  For most
builds on Linux, the system libpcre2 is the right one and users will
expect to find PCRE support by default.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--s2reChrrcIhKGfgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaHKgugAKCRB8DEliiIei
geUBAP9a0iaWCFgWHgj1oZ/zDf+Go1pdv0i07s1ntIJflEJWYAD/TyJVQhB4fWG1
Yl3LxoZJyeUDq7/hKooPbSMbZT3Hrw0=
=qAlk
-----END PGP SIGNATURE-----

--s2reChrrcIhKGfgb--
