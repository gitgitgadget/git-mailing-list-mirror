Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307282DEA95
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023608; cv=none; b=fnXPlN7KF2YX682JjyCX/u4lIjBDqVn9+m6wc9doQi84RhyQCwvzxpwvY65lq8d9kDxMU6ROa7dvaIq2TJil1xs2WaS5F7WvhdAz5EVLnaP9w0p6IrXPGn7NLKiYxWLmfYFS/m2r4B/5GoV+o492jK3+5e5NnqaXcswh6Yzkn3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023608; c=relaxed/simple;
	bh=VGx1d5V8/FxaPXEV/D1gsvMAygBlTTxyIjjbApD1JyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqYKYHgNRbSC1n4+99y1th4NkcZymFsOVgRO2uoPqTqaFXb1NlDG8QBKMQdLgJPyGiBR1/w9Znzv5IDF6GbB7uyE4tJD65AO6EF0y9vyUDqk4FYE1fLCcyESw/tUuU/q3C+toKym0PwezOy36hTUB4YnYYnR1ZORMk4sYq6MHac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=qE9LPL73; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qE9LPL73"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757023604;
	bh=VGx1d5V8/FxaPXEV/D1gsvMAygBlTTxyIjjbApD1JyM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=qE9LPL73RdPOTBSONH2BB39awoS13vOsB7uFiMke8O7GF4lPtpxxWX1kSo+R4g1kV
	 xZ3nWyXMHMHb4yqse/to8x1N2PK2yn1kwPRtAZY0aDVjD1Stg/RcGnA6iMEdhl1bkk
	 6IsS7lebMkYdHF97pMqixaXUJbuAgd2JNDZDjSjNtBalGBKq2ETJnGoPygETK6of18
	 OOGAckve+LIaTlvet47jh7acCXyHyAC6CSZpe57esPqnGjGvg+qvgCLOaxhTEreiFQ
	 s+vNFYndpopWSzBk85XEcpWLif6NiljbTUJWLjNIhSbXVu6N6Agp9NpCfvALH4TdX1
	 3DuMcaCbJvLhY+FgZJ9LN2VLf6WryhAB8mWDdn6C+IXyHZLvNCDKOoFObYO2/dEBXC
	 p+hqW1YR6c8MUwJ45HqEE8Cy8GCKGAiX/KfXxF0xEVmIKxSidN1BjfiHXfxfI1hfKX
	 P6N9AB5nw1hTjGPWtANLuYVLjN1iTaBtshFtPm0BzWGRwNnZXoq
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:bf12:8113:e329:8d0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 75F2D200BC;
	Thu,  4 Sep 2025 22:06:44 +0000 (UTC)
Date: Thu, 4 Sep 2025 22:06:43 +0000
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
Subject: Re: [PATCH RFC 1/3] meson: add infrastructure to build internal Rust
 library
Message-ID: <aLoNc5S6PVW8jLu5@fruit.crustytoothpaste.net>
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
 <20250904-b4-pks-rust-breaking-change-v1-1-3af1d25e0be9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gLkX4LGYQqazU5Jn"
Content-Disposition: inline
In-Reply-To: <20250904-b4-pks-rust-breaking-change-v1-1-3af1d25e0be9@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--gLkX4LGYQqazU5Jn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-04 at 14:26:43, Patrick Steinhardt wrote:
> Add the infrastructure into Meson to build an internal Rust library.
> Building the Rust parts of Git are for now entirely optional, as they
> are mostly intended as a test balloon for both Git developers, but also
> for distributors of Git. So for now, they may contain:
>=20
>   - New features that are not mission critical to Git and that users can
>     easily live without.
>=20
>   - Alternative implementations of small subsystems.
>=20
> If these test balloons are successful, we will eventually make Rust a
> mandatory dependency for our build process in Git 3.0.
>=20
> The availability of a Rust toolchain will be auto-detected by Meson at
> setup time. This behaviour can be tweaked via the `-Drust=3D` feature
> toggle.
>=20
> Next to the linkable Rust library, also wire up tests that can be
> executed via `meson test`. This allows us to use the native unit testing
> capabilities of Rust.

I don't see any changes in this series that wire up the Makefile to do
the same thing.  Lots of people use the Makefile, or things based on the
Makefile like the autotools, so we'll want to make sure this
autodetection works there.  For instance, I build with the Makefile, we
build with it at work, and Debian builds only with the Makefile.

We also probably need to test this configuration in CI as well.

> diff --git a/meson.build b/meson.build
> index e8ec0eca165..1c0e98bbc14 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1702,8 +1702,21 @@ version_def_h =3D custom_target(
>  )
>  libgit_sources +=3D version_def_h
> =20
> +libgit_libraries =3D [ ]
> +
> +if meson.version().version_compare('>=3D1.9.0')

I think we need a different approach.  Debian 13, which was just
released, only supports meson 1.7.0, and you have to use testing or
unstable to get 1.9.0.  There are no versions of Ubuntu, released or
not, that support meson 1.9.0.

If we require this version, practically nobody is going to actually test
this case.

Our platform support policy implies that we should be requiring nothing
greater than meson 0.56.2, which is available in Debian 11 and has LTS
support until 2026-08-31.  Ubuntu 22.04 offers 0.61.2.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--gLkX4LGYQqazU5Jn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaLoNcgAKCRB8DEliiIei
gWJ+APwMQmqsmWtq2r89S/tL2YFAzdsTQhnpmq9X0Q59Rc7kaQD+N3VMJ1jkwa3w
ynNeBOCnqE0pw/vSc8SBbIcHlu8psws=
=dcou
-----END PGP SIGNATURE-----

--gLkX4LGYQqazU5Jn--
