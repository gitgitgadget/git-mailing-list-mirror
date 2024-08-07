Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8549C14830F
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723068238; cv=none; b=uGhOeThkLEcgEetngQcc4nnv1LW3RhA0ZqrPIQgU7C3+HVUAijPPTNGHBngK5HNt+udX76aNL5W2+g0p2r7fDge1q5bJur5pRPzckxK+RI8GGV3gWagaSIzyc4MS+Ogw8Q6rRQ1nQqtm67ayCbTvn9y+0kD5rnMoijxuYQXXDQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723068238; c=relaxed/simple;
	bh=M6aBL/ryQ7KTwT7MjhDtwkkKP03nHS2qMQltIEbZ3tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLh55pIGzzC+XuRlpZGE2bm2xASSvblRw90L852/CF+SaKOBCek6gHzPicYZUbrRSt5L6Gy1ObP6sqADC1cyxh0zvmWIs0VABV1mCM6zkrhzRXqqjs3AFJeshhuXdbITcgpaANy773Hy9IMPBk4LlHnoUKJM9L8cnZ4p5MU37Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=niaEdPiO; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="niaEdPiO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1723068235;
	bh=M6aBL/ryQ7KTwT7MjhDtwkkKP03nHS2qMQltIEbZ3tQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=niaEdPiOgva/+dYtv1gyqVlIDccgfQborw9VGbxcv6FTckus4uDrqzovl0ScA1H5K
	 0oY76OyOO3RItvtqDEEMcJkMI0LWfV98rYqUGrG9tqH2HoUqVkZTP+kmK+Jlq2eYQB
	 9Ih3+cN14uQbX9NXoOBf5GIySmyVz1RKrvN/zCKO4ZDqLviaaZPwadO+Z3Tf6P3XHN
	 zTsqQyALNDCtIBVnV3yApASNrFMQqSMGzZlKeS6BpRsZqI1WtO0UlOJGjQgSvYhsPY
	 h8x8ULPtJn5YIB99a+8OIik1Fv/k6TGKEYIOhGPsrwvFYebmOh5nXwcFHpE/W+WnJY
	 PHCzf5lSV9hrT9aVpWIS47guVZhX0JnmypB5tw4w6BI/znWPI9CiMXHwvfiIMtL8HA
	 15gpgMrN4sdQRm+eLF+7OAsMGsvUpttnOvZH1eIa3/0CuqYp9pBxRpY81voRHH1eWy
	 naY0Vxzyn9x241sjUqqRTiG8BcGLyfiF4ZYxgweOcMlIBXZz8qT
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 39101209BD;
	Wed,  7 Aug 2024 22:03:55 +0000 (UTC)
Date: Wed, 7 Aug 2024 22:03:53 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com,
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 0/6] [RFC] Introduce cgit-rs, a Rust wrapper around
 libgit.a
Message-ID: <ZrPvSWoUOEaUIjWq@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kgP1ewAmu0CUxqdA"
Content-Disposition: inline
In-Reply-To: <cover.1723054623.git.steadmon@google.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--kgP1ewAmu0CUxqdA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-07 at 18:21:25, Josh Steadmon wrote:
> We are putting error handling on hold for now since it is too complex
> and we intend other CLIs to be our first customers, in which case
> printing out errors is not the worst.

While I think that's okay for now, that really needs to be one of the
first priorities of things we fix.  I have some ideas about an approach
which we can take, which I'll send out in the next few days in a
separate thread.

> While the wrapper itself lives in contrib/, there are a couple of
> patches that touch git.git code. These patches are necessary for the
> wrapper, but not for git.git itself, which may seem unnecessary to
> merge. However, I would argue that other languages (not just limited to
> Rust) have issues calling functions that require a pointer to
> non-generic objects and essentially require a redefinition in their own
> language.

I don't see a problem with this.  It seems very self contained.

> We're sending this series as RFC because there is remaining work
> we'd like to do, but we'd like to get early feedback on this approach,
> and particularly to ask for advice on a few topics:
>=20
> * alternative methods of exposing only a subset of symbols in our
>   library

We should probably support symbol versioning in the libgit_ code on
supported platforms if we're going to expose it.  Otherwise, we're
setting ourselves and distributors up for a world of pain when we change
the ABI, such as when we add error handling.

> * bikeshedding on the name (yes, really). There is an active, unrelated
>   CGit project [4] that we only recently became aware of. We originally
>   took the name "cgit" because at $DAYJOB we sometimes refer to git.git
>   as "cgit" to distinguish it from jgit [5].
>=20
> * gauging the level of interest in calling Git code from Rust

I left some comments in the series.  I think this is a nice first step
as a proof of concept, and I'm very pleased to see it.

If your goal is to simply expose C APIs, I suggest calling it something
like cgit-sys, since the -sys suffix is customary for wrappers of C
libraries.  If your goal is to provide actual wrappers that people will
use in real Rust code, then I think that we should _not_ expose the C
API, since most Rust users will not want to use that.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--kgP1ewAmu0CUxqdA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZrPvSQAKCRB8DEliiIei
gb6HAP9c68qHIOSfF4rq294AGUL6SVJgoAQoSEPyrPgo+OBFqgD/bR6w0FHvCNWJ
6L046tnMeih7AyWaumkg6Qcm6m+tVQA=
=y/L8
-----END PGP SIGNATURE-----

--kgP1ewAmu0CUxqdA--
