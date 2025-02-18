Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95871D618E
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 22:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919206; cv=none; b=M5UlZ6yLGmHLuZDYTJXMIBOoKGU9Ouw92OjGv7f6BJ46bIP35MJYmL5VocAn662h1O8X0Iy+kNZvjWOyJ4pnFEfhhQ8slwkAWjc2mnwemDul+QQw+DBYQ2bdtWmP6sUP8X4gvU683QwwFG41Afi4rZRaWRIPjWN/VZtM0z5tvIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919206; c=relaxed/simple;
	bh=QItgQAuhQ6cO7wMkb8PHSk4Sz9yfYf78YtZRuRhjDTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ip7kSwiEKl+Lfm2sjQ7odZ42d0R9mLuEodbSvzNM27wHuuQF+ceA9NuD+sOCrQSnjJBt885sVdQpEVwo+Zlpx5Zmow7sYwfXE0jHBS4Wb5dZK6GPGEXM+xeTI/2Le7yd5FGu8JdBzmLQ3Fz0c3NXmeDk/trZPZVk/pec2fToyKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=sL+kuGVW; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sL+kuGVW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1739919202;
	bh=QItgQAuhQ6cO7wMkb8PHSk4Sz9yfYf78YtZRuRhjDTI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=sL+kuGVWhjc/fqghcLJo0hkbJO75lH74Cgq2ZzxGOyvCTINJeBADHwZ6dulqDwTXV
	 qH2Uu7RF0onTzz1auMs7uYcUVcWuHRcXQNf+49aANzGW10n0KQs4Ha/VmdZwBSIoa0
	 Un0KaYVtIccO17jGJI5ja2YuBIOo0JGjgQ0nluXsd2deV2oA71Cz295yulneIxN2eI
	 qkiHpLfLaw5l1U0mej6om8GoxrfMb1r6DUjA4IyEMd5AtuDFNac+3lHzw+s6H1dyfY
	 rl2OyjsYKw+rV6ROmljiE7v0iYtP5+dXaJLugnuMbWNeG8jWBrcNUEFnowj2vMweIn
	 u8UqUQq+uzEDqeCRrB8X4qTlHkeO+XdAi2gihagMclm64clpC15xg6DiJbrtS9vxwF
	 3ed0hWI6C3ToKZjyz9EEVkLqdcPbS88ubg1h5HBH1xQJC7r/b9PR8NSdQEFSUe2ANv
	 Qp3OriO3kgV1z0A/h5SyX+dmBgZ2fOiYcqL7KTLWheGgR0Syyrf
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 678482007A;
	Tue, 18 Feb 2025 22:53:22 +0000 (UTC)
Date: Tue, 18 Feb 2025 22:53:21 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Peter Georg <peter.georg@physik.uni-regensburg.de>
Cc: git@vger.kernel.org
Subject: Re: [Bug] git-http-push authentication fails using netrc-file since
 v2.46
Message-ID: <Z7UPYY24uk7lLzeP@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Peter Georg <peter.georg@physik.uni-regensburg.de>,
	git@vger.kernel.org
References: <2f9629f6-d742-4ee4-8441-8b70981a4629@physik.uni-regensburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nVX47udmjYWH5VD5"
Content-Disposition: inline
In-Reply-To: <2f9629f6-d742-4ee4-8441-8b70981a4629@physik.uni-regensburg.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--nVX47udmjYWH5VD5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-18 at 21:34:59, Peter Georg wrote:
> When pushing to a https remote git used to use the credentials specified =
in
> netrc-file. I have not configured any other credential stores.
> Since Git 2.46, in particular since commit
>=20
> 610cbc1dfb4ad947b82d7312c54c7987177f979f
> http: allow authenticating proactively
>=20
> this is not the case anymore. With http.proactiveAuth not set or set to n=
one
> git uses the credentials provided in netrc-file at first correctly, but at
> later connections uses empty credentials and fails with:
>=20
> error: Cannot access URL https://<redacted>, return code 22
>=20
> fatal: git-http-push failed

This does sound like a problem.  We've long had code to use the netrc
but absolutely zero tests or documentation for it.  I must admit that
I'm not even sure how it works, so I'll need to do some testing.

> With http.proactiveAuth set to auto or basic Git asks for credentials on
> prompt. Should it use the credentials specified in netrc-file?

I hadn't intended `http.proactiveAuth` to work that way.  It's
specifically designed to call the credential helper because it may get
credentials back which are not a username and password (say, a Bearer
token), which it can't do with a netrc file.

Also, from the documentation, it specifically looks like the netrc file
is only used if no credentials are provided, and since we can't query
libcurl to tell us if we would have credentials from the netrc file, I
don't see how we could support the netrc file since we'd have to take
the risk that there are no credentials and we'd get a 401 (which is
exactly what the feature intends to avoid).

> With http.proactiveAuth not set or set to none and no credential specified
> in .netrc a git-push asks me twice for my credentials and then fails with
> the same error as with credentials specified in netrc-file.

I'll start taking a look at this tonight, but it may be later this week
before I get time to write and send a patch.

In the meantime, you can use the git-credential-netrc helper from the
contrib directory, which will probably let you get back to normal.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--nVX47udmjYWH5VD5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ7UPYAAKCRB8DEliiIei
gU4PAP0YRR0ckTvpzWvtRnN2xrFc/qOSRTjSXXkHuh/mUGVzLQEAsNj4+6KCBiTn
4TndzIRZ5dJZsPW5oSx0RnSlu7g8/Ak=
=eIfT
-----END PGP SIGNATURE-----

--nVX47udmjYWH5VD5--
