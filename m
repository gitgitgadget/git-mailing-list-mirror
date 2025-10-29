Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483032D7DC2
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 01:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699936; cv=none; b=sqVOprAGJIu4OC8MjjSYL6w6JMOR0YcFyhpjyLoEZ5LIJT5Aup7qceJFdPeYdlkpEvM1knUHT3fBAU9kVVsCHXMfUxdNuOk4eQ1C4nLD6bAPhWxgkQIGdDTp9bY3W4ttOVP8d+vT26rOsNkkhxYz7Ev7RSh9zzQUiwyVrXuSu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699936; c=relaxed/simple;
	bh=hV/149vvCKCIfVo5Si9o2xQm6ONdxMdYBvKDjf0NPLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvF5WXMCTZbO1qcQIOAx5nkUibzb+e3zzElSlYn7zExtevGe8aXmm/XSufovppxXrp5KLLToq3rSv++BSZMEik8EoSO47yJIrux9VqV9MC1QvQAxJQISi4UhpXJF7fql07UQHPSRUnYxtECsxyuDDpK6wLaSeRqekgitJA/dTi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=x2WWrK1X; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="x2WWrK1X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761699932;
	bh=hV/149vvCKCIfVo5Si9o2xQm6ONdxMdYBvKDjf0NPLQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=x2WWrK1XWrk7frXAb76dRGfsCae/o8Xx1Pe40x0KjaQso9j8Y+H1Gm2/VVN9xeK6e
	 hQ3OentL6rrHi1qyMtOqz20kZbdqRO3/Nh2t2Blua7OuxmGM/UjIDrPuWb2ZkPHSm7
	 WWSBV3ql6u35lN2VyExH+d9H5XtYSn2Y1NFNZE6SV+Oi20dw28J5Q+Mm2svuuStnSB
	 h4PeT6gKZCd4/q64HFAZBRxRgP0aVwxmSLMa9Z6iaDV7ewRwX5POE2hDXwRL92X/8g
	 WxvNDof6g8CkIMnmKn/0m6/QJVNu2RLbGU+rJcr1BEAMRfujZDZC75PdpmGf0PSk4H
	 HETgl5WoY53oAdgwjcBNnNYuGrJCHAs8TF05jkHZb2wKYRuZrDi8Gqt24g6QM3tF1/
	 ykMBPX57PdOFxzRyQ9r7QdpH8CDQ1Vrb2tSwFFD2mOAtRb4C0JA+aIeaTDTytKj4zP
	 jzAf/J8+a7KvYK9sSKnryiTYO7XhX1t8WRFy7zWs+rN1KUnI411
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9578:8587:8ed:424b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1684920036;
	Wed, 29 Oct 2025 01:05:32 +0000 (UTC)
Date: Wed, 29 Oct 2025 01:05:30 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 11/14] rust: add functionality to hash an object
Message-ID: <aQFoWoyj7FyGlB-h@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren <ezekielnewren@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-12-sandals@crustytoothpaste.net>
 <CAH=ZcbDCrYuSW7nLerQZnT-R_CoCtN2RNycLqOEEV-T-T7VoZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ntTKwxCvoIHeqC9K"
Content-Disposition: inline
In-Reply-To: <CAH=ZcbDCrYuSW7nLerQZnT-R_CoCtN2RNycLqOEEV-T-T7VoZQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ntTKwxCvoIHeqC9K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-28 at 18:05:59, Ezekiel Newren wrote:
> The name _Hasher_ is already used by std::hash::Hasher. It would be
> preferable to pick a different name to avoid confusion. Perhaps
> CryptoHasher, SecureHasher?

Sure, I can pick a different name if you like.  There are also myriad
`Result` values in Rust: `std::result::Result`, `std::fmt::Result`,
`std::io::Result`, etc., so I don't see a huge problem with it, but as I
said, I can change it if folks prefer.

> I don't understand the point in being able to query whether a given
> hasher is safe or not. How does that change how this hasher code is
> used? If the functions are safe then you wouldn't wrap it in an unsafe
> block. If the functions are declared with unsafe then you'd always
> need to wrap it in an unsafe block whether it's actually safe or not.
> Using unsafe in Rust isn't like error handling where you do something
> different on failure. If something fails in unsafe it's usually
> unrecoverable e.g. segfault due to invalid memory access. My
> understanding of unsafe in Rust means "The compiler can't verify that
> this code is actually safe to run, so I've made sure that it is safe
> myself and I'll let the compiler know what code to ignore during
> compilation."

This is not like `unsafe` in Rust.  We have some SHA-1 functions that
are safe (the default ones) that use SHA-1-DC to detect collisions.
People may also compile their Git version with a faster version of SHA-1
that doesn't detect collisions and that may use hardware acceleration in
cases where we're not dealing with untrusted data.  Taylor benchmarked
it and got some pretty nice performance improvements.

My preference personally was to simply say, "SHA-1 is slow since it's
insecure; use SHA-256 if you want hardware acceleration and good
performance," but my advice was not heeded.

So this allows us to do something like `assert!(hash.is_safe())` in
certain code where we know we have untrusted data to make sure we
haven't been passed a Hasher that has been incorrectly initialized.  We
have some code paths which can accept either (and, depending on which
mode they're operating in, do or don't need a safe hasher), so separate
types are less convenient.  We could do that, however, but it would make
things more complicated and we'd need a trait that covers both.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ntTKwxCvoIHeqC9K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaQFoWgAKCRB8DEliiIei
gQ7RAQCKU8ow+fshRYyiPvi48qobHfb503Ecv31PJynLpOXs9gEAp4f55aKL5DIA
ZkgL7euaafnONJIT2wTkF0cwqB9LRQ0=
=3kfi
-----END PGP SIGNATURE-----

--ntTKwxCvoIHeqC9K--
