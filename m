Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC6333F3
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379837; cv=none; b=l+x4/EjHoebqVueM9Arp8/nwxEW09MC2LVOJABRWT2eW6GRkJPNZAUnIlWq6SYEDZPBxVKeaWiODHVJRKHCUr1VrzP/I+4zxW2wros0NLOCt7IXI3b/XsnwnWofX7OQ5WMjLg0efAmraT1FbRpSeX8QQJ6YSSaVvAUo1HC871tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379837; c=relaxed/simple;
	bh=I04M+HV870dyV0E8l8KmiWqvSnbYXaQG6yCnqE5Sx6k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RK9X+YvSMyb0d0X0k0qUblLdKaL2WbSrPzajkLttxGfsh+ykdnGgAuEdyzSapHTAsAoP9sIdeelJb8HPg0DhktF9pwT4QAwvP24tCZpp+QNnX/Vcl1yIiGOeacj06DEVuGGnxsoJo5sfWSnKcQZyMcurN+FsTh6DG3cKqeVHhZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=N+eD0sYe; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="N+eD0sYe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757379833;
	bh=I04M+HV870dyV0E8l8KmiWqvSnbYXaQG6yCnqE5Sx6k=;
	h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
	 In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=N+eD0sYeqCjODwlmCRy5MTbv7TvNaH3QdxHiaRT1JsAqOWtwRHP7NQxnvL5XgKxwm
	 NcOaufvV6wWbdDRX2L5UqCOZ5dKtptuQ6ptCU90nL+xkzfM5rCxGzC3daZuTogOmM+
	 ON9Tz0qfRopHzTHvZYZyCauapjP9Ptf7laJG3IVg42xQoQ84gUQDBz19qEb2eoC8g7
	 qRkj5X5Agwfd56fn6yEEitkhOTJia9rcLli1yAmWiy/uZzEsVsbr0yhqXeFaA4JVWv
	 DcEfB0iU3xUREEySTyt2F1yQoGHvbDECFtMaP6Hw9cQSnlP58DF9dHRy+YyaCAnBcN
	 y+1lVlSFvhgTwOYEFDprNpqarkyJYebdx6JuUKkxVlv5+ABXmyJy7UfBXynGQI4Ad3
	 XbO0O74BbbaJgMpFKx/8iCVVrbZWhtXYIah0d4V8Zhfs49m9Dsunu1Sqy65QG5L/bj
	 eF5NqxWxVa/Zaqjg15WqAGhKTnXRXjU74EK0/qs1oJnwgUNQUEV
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:91aa:86f1:d85a:ac64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8CF4320106;
	Tue,  9 Sep 2025 01:03:53 +0000 (UTC)
Date: Tue, 9 Sep 2025 01:03:52 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
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
Subject: Re: [PATCH RFC v3 1/8] meson: add infrastructure to build internal
 Rust library
Message-ID: <aL98-Dq9HC5eDOcM@fruit.crustytoothpaste.net>
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
References: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
 <20250908-b4-pks-rust-breaking-change-v3-1-1cd7189fed3b@pks.im>
 <aL9UIeyUqmwwPt2c@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DD6CsFiHKnLkMG4r"
Content-Disposition: inline
In-Reply-To: <aL9UIeyUqmwwPt2c@fruit.crustytoothpaste.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--DD6CsFiHKnLkMG4r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-08 at 22:09:37, brian m. carlson wrote:
> Ah, yes, I've already broken this in my branch (early this morning, in
> fact).  I've added a `build.rs` file (used by Cargo) which is necessary
> to properly link the tests against `libgit.a`.  (I'm using the hashing
> code in some of my tests.) Meson fails to honour that and so the
> compilation breaks.

If you're interested in seeing what I mean, you can clone my
`sha256-interop-part-2` from https://github.com/bk2204/git.git, which
has your v2 merged into it.  You can do `make -j12 all` and then `cargo
test`, which should work and pass the tests.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--DD6CsFiHKnLkMG4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaL989wAKCRB8DEliiIei
gbsLAP91YMt4ZHdF52eLwHHeSURB947xGfr6S4Vk28646SvnfAEAjE2qOPsMIZ69
FS9w6qKMRUtFnRNyiN7h90sZ0KDz2Qw=
=6Xxg
-----END PGP SIGNATURE-----

--DD6CsFiHKnLkMG4r--
