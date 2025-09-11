Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861741957FC
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627759; cv=none; b=pUrhA01QUOkhwfjMq8PRtOLDzZdZCbOC+jIKSnd75r9Jh+wF37Db8woBZIHYnxL8PXzHOS3EZ9AgEv/9DcDTyPJDth6Qssf3EHby7qrZCFpFHSOrNm3DuKtehbwO2Js0EYYDuGmg4JPJ/f29lh3cexUSd7j5SqM8ybq374qjJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627759; c=relaxed/simple;
	bh=CaED51Y0XZJpaa7WvJm96sMJydCNNbj3+HoELvKo76c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJk56MJf8jXvVJmoLpysgYRXoFpC2MiUineFty6KIjyf63Jv2OBtF/tNNH2gZG8hQLKqAOSqFBFfemuFErqO8QkhkfR5ILBjcOgPhUmcnvsg+vhDwZjwQ2cS+xmaXUBS9Ek4N73JBV9W0R6YQ/hUU55B+rkMbgzWvbiUMRWF+44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=AaHnMd8s; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AaHnMd8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757627755;
	bh=CaED51Y0XZJpaa7WvJm96sMJydCNNbj3+HoELvKo76c=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=AaHnMd8sxk6sx4/rY7G6iGjtN+jqJyBKrcjzrhVaqaHtNNFfLUxTmn7NIDLnAwTOi
	 66ohtU4fLGkUZwjCV12K/76jfzEzCdU6VBQvK7V72XM2nqplp8IRAtEgJAPHSRia+h
	 6bAU3mxrgMHPRG0TEUDvkwEzF0MsTljpZ33N0dwVoDuG25oXBfhBsO0Z/OF5xFLsIS
	 KxU6pQzBx6E1zCrSicYZ3lWkVryA8PIpKjcdf3h5KvSCzRyvZWwgzECViDxMOKOsj5
	 iPdtlxgBGsTGzt/t2N5btFCNElWBijEAMiEaQpXZmpUp0MKxJtV7ProS18cdoEV/Jd
	 Ch/xQzlAh5jV1LG+1ols396i+h3Lc6Ok6S2QMl1MjYg2OJy6egAbK66W60r3+BrFaf
	 LuxmJxvffg+Di3Dj5+6GXQki3h4D3tiCRMxkZtq8CEbIZavFn9FZH4u0r/+DNPVRZS
	 V8R2LOMNAHAuXWou6O34ota3ZpmJNHISz+NRZib/ifK2rBABTLC
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:8d65:5356:c950:b152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BDFD720105;
	Thu, 11 Sep 2025 21:55:55 +0000 (UTC)
Date: Thu, 11 Sep 2025 21:55:54 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v4 0/9] Introduce Rust and announce that it will
 become mandatory
Message-ID: <aMNFao0yGZ6yzKKv@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dnlE8M8kO76ryUll"
Content-Disposition: inline
In-Reply-To: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--dnlE8M8kO76ryUll
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-10 at 15:35:46, Patrick Steinhardt wrote:
> Hi,
>=20
> this small patch series introduces Rust into the core of Git. This patch
> series is designed as a test balloon, similar to how we introduced test
> balloons for C99 features in the past. The goal is threefold:
>=20
>   - Give us some time to experiment with Rust and introduce proper build
>     infrastructure.
>=20
>   - Give distributors time to ease into the new toolchain requirements.
>     Introducing Rust is impossible for some platforms and hard for
>     others.
>=20
>   - Announce that Git 3.0 will make Rust a mandatory part of our build
>     infrastructure.
>=20
> The test balloon itself is quite uninteresting: I've chosen to convert
> the "varint.c" subsystem, mostly because it is trivial and does not have
> any dependencies. But it does allow us to verify that C to Rust interop
> works as expected, and to play around with tooling. All tests pass with
> the "varint.rs" implementation.
>=20
> For now, the series only contains support for Meson. If we agree to go
> down this route I'll also introduce support for Rust into our Makefiles
> at a later point in time.
>=20
> Furthermore missing is additional tooling:
>=20
>   - At least one CI job to verify that Rust builds and works as
>     expected.
>=20
>   - Tooling and CI jobs to ensure that we have consistent formatting via
>     `cargo format`.
>=20
> And probably lots more. As said, the entire goal is for us to have an
> easy playground that we can experiment on and develop the infrastructure
> incrementally without yet having to commit to anything.

I may end up sending in a patch or two for these if I have some time.

I did note the discussion about what the LTS process looks like, which I
don't have strong opinions about but do want to make sure the project
(including folks on the security list) is willing to support.  Other
than that, this series looked reasonable to me.  I also confirmed that
it works with my existing sha256-interop-part-2 series, which I
appreciate.

I think once we have agreement on the LTS process, this should be good
to go.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--dnlE8M8kO76ryUll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaMNFagAKCRB8DEliiIei
geXNAP9YNIEKXcIFTgVdS7q47N8eOhM2B8Z8i0eYodsb1kyj2wD/WLjvR84oa0SS
qWA5pry7dRo1As2kWAJ3mHyXxDpXfgw=
=gVOG
-----END PGP SIGNATURE-----

--dnlE8M8kO76ryUll--
