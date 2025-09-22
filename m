Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE541E502
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758576939; cv=none; b=jDVHkANkibN2MmnWtfCVV18qJyMtXXiXY+jWwW3cN5hTgL38cC/gI26jRurL94DiqTVqOBjTI61gGQ7FiO87oQBFEvs/qExpzVgZIuf7O71ABh8Y7vyGZtPn3OVJ2rG1m2Gaquy1Cnh/w48m9yAn4CFwc0qYW5oY9jq+Tv5tIQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758576939; c=relaxed/simple;
	bh=tZQoGTt4xYyAZmTkgOOO/FDW00xR9azIk+iviCTAK/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUiBFxJLUuigTQLIJla3Xlsl293SJj43wWkASo1kfQiIY83coxJ32EECaMLzEbIq7XvBzcH8QQZKTpWR8f4eU2BwRajrO4Awfl2zi2V8h0eugi79bz1fvlF2QyrJwSYPcfOHH28qa9moU+ytTXl8kp8105lJZj+mq3VNjD2c1BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Q5HgDfJF; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Q5HgDfJF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758576929;
	bh=tZQoGTt4xYyAZmTkgOOO/FDW00xR9azIk+iviCTAK/k=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Q5HgDfJF3yKFW07QxSQv5z6fB0COBkAR6tGsAmr54F7Xmp5PqKs5GZW+z2um6mVUB
	 LAF3gPjnkb4UbM5eBwKIObZqtmt3BTZB8ZxOYK84pPz4x0PW+BFqFbhGwcqIQsgB5L
	 9rfTHDbS0YBr0yXF1s1jMVSigB1udaeeTIsieR2QEQoNZLATsC76XVeujZOYguJJJm
	 E3iYUChN1EIHs/rmhXXIz7D0GACZgwjpC8fXHDArp/n5jZj6yfCkapA5VIKqc1SwJP
	 8RarN3U3N30ByBRJthHiXVi2RoCpVyIkd6LMkcJBZT8m5eFasHCQk33UDajxRgHvCT
	 TCrVaUDPKzrAP6+aeA7fo5fN4eDBU+IdPyCt+ASOJN8PXf6jcwn6MYAAVB0zvD3vrL
	 brwjdnekyibKtMux1vLgFG2PezLUziF2H8xf7/FplkJNsLS6Rz6Z6caxunHqeq8Ydq
	 qykPUsGR1rBazucKIynlP/ArP4Fc0uFFU8snD2lyeGolP2Al3EJ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7cc9:7232:f513:ebf7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5E73620105;
	Mon, 22 Sep 2025 21:35:29 +0000 (UTC)
Date: Mon, 22 Sep 2025 21:35:28 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Michael Orlitzky <michael@orlitzky.com>
Cc: ezekielnewren@gmail.com,
	20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im,
	Johannes.Schindelin@gmx.de, ben.knoble@gmail.com, cb@256bit.org,
	collin.funk1@gmail.com, contact@hacktivis.me, eschwartz@gentoo.org,
	git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
	newren@gmail.com, phillip.wood123@gmail.com,
	pierre-emmanuel.patry@embecosm.com, ps@pks.im, sam@gentoo.org
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become
 mandatorty
Message-ID: <aNHBIHXYPmS5AvpP@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Orlitzky <michael@orlitzky.com>, ezekielnewren@gmail.com,
	20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im,
	Johannes.Schindelin@gmx.de, ben.knoble@gmail.com, cb@256bit.org,
	collin.funk1@gmail.com, contact@hacktivis.me, eschwartz@gentoo.org,
	git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
	newren@gmail.com, phillip.wood123@gmail.com,
	pierre-emmanuel.patry@embecosm.com, ps@pks.im, sam@gentoo.org
References: <CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com>
 <20250922155949.27019-1-michael@orlitzky.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yp6LgRd2763fstZg"
Content-Disposition: inline
In-Reply-To: <20250922155949.27019-1-michael@orlitzky.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--yp6LgRd2763fstZg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-22 at 15:59:49, Michael Orlitzky wrote:
> There is no problem with supporting rust on Gentoo. Gentoo users build
> from source, and rust is a problem for anyone who builds from
> source. I'm writing this on a riscv/musl system. If there are no
> binaries for your CPU/libc, let me tell you, it's not fun. And this is
> like, my job. A normal person would be completely helpless.

This is a problem with languages that bootstrap from earlier versions of
themselves.  It also happens with other, less common languages.  GHC (a
Haskell runtime) also has this problem and any distro that ships pandoc
has to deal with it.

It is certainly inconvenient, but there is mrustc to help the bootstrap
process.  Granted, it does not work everywhere yet, but it should also
not be too difficult to make it do so.

I do think the difficulty is worth it, though.  With Rust, we're going
to get code that is thread-safe and memory-safe by the virtue of the
fact that it compiles and that will allow us to have threading in more
parts of the code where it might benefit us.  I also cannot tell you how
many segfaults and null pointer dereferences I've written in Git (some
in the past week) that are just no longer possible with Rust.

As my proposal originally mentioned, there is enormous pressure from
governments, security professionals, and large companies to improve
memory safety, which I believe are legitimate concerns.  If we want Git
to continue to be used widely, then we need to address those issues and
Rust seems to be the best possible way to do that.  I don't think
continuing in C only is going to be viable long term.

> Nevertheless, the arch support issues are secondary. I'm sure it's a
> lot of fun for the people who are writing rust code to do cargo
> updates in the two or three directories they work in all day. But I'm
> not writing rust code, don't care what language git is written in, and
> have hundreds of other packages to keep up-to-date on multiple
> machines. I want to be able to use my package manager to do that
> efficiently. You know, the main tangible benefit of using a linux
> distribution.

I don't think this is going to happen as you anticipate it will.  My
original policy was to target Debian stable's release for a year after
the new Debian stable came out and that will make using many crates
nearly impossible.  We are going to have to be _extremely_ careful about
dependencies in general and the things we are likely to use are things
like bindgen and cbindgen, where typically an old version will work just
fine and which are already packaged in major distros.  We are not going
to be adding dependencies willy-nilly and running `cargo update` every
other day.

> But every distribution is "packaging" rust the same way. They're
> bundling random old versions of crates in violation of their own
> policies because the ecosystem is unstable and the tooling encourages
> tight coupling. By requiring rust, you are require me to go back to
> managing dependencies like I'm on Windows XP again. Git is the most
> important program I use, but it's not more important than package
> management itself.

I expect Debian already packages the crates that we need in acceptable
versions, and I assume other distros do as well, so I don't anticipate
this being a problem for us.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--yp6LgRd2763fstZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaNHBHwAKCRB8DEliiIei
geZIAP0ZyPFc4PjvajZBj3ZYrDLB/B0lVGO+/A28pRVtrfYiJAD/WKpyGdCPyc+3
vLRnZLe3zRX/UtfwEuMEAQjVvSE5gwU=
=rLMk
-----END PGP SIGNATURE-----

--yp6LgRd2763fstZg--
