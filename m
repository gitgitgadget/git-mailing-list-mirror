Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3874315D
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844338; cv=none; b=uhvhcsxZdzPQC6tK7CT55e4h8cGqUt4e/I0mqYBNx3PNEaqmpQD6G7HKrkox0vhvKdtuvVBJJyvSnBa10DE00ZmYiGLXpF0JM3pg1HF8ojMU3R/nb0BO/cS/7QmbJXxmUt8CkuDUTMpf/XuNk6oiaaueYcVp2X0Fsd56HfoYSDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844338; c=relaxed/simple;
	bh=ZNROoT+1ewQngiNflN3O1an/cU0tiS35i1y0zWTpRnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzCDHzsxfrKjRi0OfLazmEsFGgwP/bLzXJKmkDCdYdgRk+WMa1DiubzmLnIUcFxgnlTFnv8dIxuHmv7IM5+6kkJlzhMPjDyJk8uyhXai1XxegrfvoqaRK+qs6GjMn6AAIJcfsbvgBDMjhoT0MWGTVuxVH95tEiEuev2fPosLmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=IYHuG2jc; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IYHuG2jc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1723844329;
	bh=ZNROoT+1ewQngiNflN3O1an/cU0tiS35i1y0zWTpRnc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=IYHuG2jcL7UgmlRS35oaYVhgRQxQy0VF5kg0/aw4OV+a3fMqQxr/lgYkLYS9+gqAf
	 MlQVvFFkkEok1nHJiW9573zk1UeXayad0soR6MXt4W9Lro2eEl1cWmi3zD554wWHVC
	 ydu3CuKQkqfsrocrGbCZYknWsJq5+u7f824nmYh5nxuW8TJsm3VA5xS0q6cWqXuYS3
	 HiGDkGoFfnQM1uI3Zi1tmAQ3FbUz7VxSHVEejFr07PZaWyNocgcRzuTWp9BlqiiApo
	 dVeJprq4TvU9WKTWOYy+nc/a+UK5C2ZSPyon+ID8ZhhI2CDG7fqV+z7+6LlVPHem72
	 d+T8YtXLzKAk7UhHx/Bjws2+FfR7QVvhNR4wIfCWJxtr4KYa3gEGY0fXvkK6GCgRk1
	 ae1VR9H51lo8HiAgbVRCnlrwCj8KgJpoucRyKIWQ39RN3tQed8FLh482EJXkcdDF//
	 LhoiJCa/RIYWahgas63Vpm0gJoks+xBsS9J0o4XqdBap5KXKesp
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 60502209C8;
	Fri, 16 Aug 2024 21:38:49 +0000 (UTC)
Date: Fri, 16 Aug 2024 21:38:47 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Josh Steadmon <steadmon@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com, mh@glandium.org
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
Message-ID: <Zr_G59cz9HwtYUk3@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com, mh@glandium.org
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com>
 <Zrdn6QcnfmZhyEqJ@zx2c4.com>
 <6398d60387a6607398e4b8731363572e@manjaro.org>
 <CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com>
 <xmqq5xs688cz.fsf@gitster.g>
 <CAPig+cSVNqBPjV3_41f6Ag2X4+-q4HidEo0D=1UaMG-Kv7pa5Q@mail.gmail.com>
 <k4cokm5xtwazlv44ys2uzmrfufubbq7tcmcwzasuccog3zcojf@4ftvda4nfqxj>
 <Zr86bF3y_YMZx0CQ@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xd7QtmUXkMn7AkdM"
Content-Disposition: inline
In-Reply-To: <Zr86bF3y_YMZx0CQ@tanuki>
User-Agent: Mutt/2.2.13 (2024-03-09)


--xd7QtmUXkMn7AkdM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-16 at 11:39:24, Patrick Steinhardt wrote:
> That to me raises an important question: who is the one fixing breakage?
> Hypothetically speaking, if I continue with my refactoring spree to drop
> `the_repository`, do I also have to fix the Rust bindings that I break
> as a consequence?

If we're testing it in CI, then you are responsible for not breaking it,
even if you don't use it, just as I am responsible for not breaking
Windows, even though I don't use that platform.  That's typically been
the policy here and elsewhere.

That being said, there are two things I'd like to point out.  First,
your work to drop the implicit `the_repository` is very useful, because
Rust code implicitly requires thread safety as part of the language, and
you will be making the dependency on the object explicit so Rust can
guard against concurrent access.  I expect that you will end up breaking
very few endpoints with those series because we can't really expose
endpoints with implicit global thread-unsafe state (such as
`the_repository`) in Rust anyway except as `unsafe`.

Second, I and others will probably be happy to help if you have
questions or need assistance fixing bindings.  I've done a decent amount
of work in Rust, including mostly porting a service at $DAYJOB from C to
Rust (the one that serves Git requests, no less), so I'm familiar with a
lot of those kinds of problems, as I'm sure others are on the list as
well.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--xd7QtmUXkMn7AkdM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZr/G5gAKCRB8DEliiIei
gbInAQC0QxQCCEmqnLqbI7FqD+F7bEg0eGvghsKRARTdWKcRMwEAkCv3WENxyNj7
Qw0SwRz0hlJMNMS8mNOxkdJie7ci1gg=
=W59n
-----END PGP SIGNATURE-----

--xd7QtmUXkMn7AkdM--
