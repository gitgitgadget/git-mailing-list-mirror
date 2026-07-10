Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E9938C42F
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783713031; cv=none; b=PYrALoVWXRk8V47+hlytHYrkvbQMuxivKJRXTBRKchpw+i1fEgLm94jJ5x86Y/h0TwjNtMTyJcY+6zxIoR7rr6w52GzXOxjHxmj4qLBX2cXUJGCYkfldt686KtvYoZRN06qFTpHt5q+dDEK3p7uowjxmW8G6EEpBCH159CnY/AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783713031; c=relaxed/simple;
	bh=BmNB9RsbaMe8cKt85fC/3RMZaicxc0XE1qqG5a0WUR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQmYuwBPiasD0QRKgHdgHbw0LIVzW5mK+rt3AraCWZJSoZwk4Js8mewLL6WBU8BqAyIsIvZS8u57XRQVJoQMNn5qrGS8jyKG2RYJNJs7gFKXWOiHpL9Ls6odngNLaYfwGZPtJdc7RmhwHra+mTl4x1LEk1JKn1DY+X9WN93lmho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=PdY+ra53; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="PdY+ra53"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1783713021;
	bh=BmNB9RsbaMe8cKt85fC/3RMZaicxc0XE1qqG5a0WUR4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=PdY+ra53mEWGuuNtBudW0IhAP0vgUWz7OotTJHB3q3isdaINgR2wV1LI7ihXk5buu
	 0sVAziOeWg+DI5xPF3/gQ+bbWmCmoMjbbHmImUh9rCTw3dX8IqYDXFqhh6y0i//gua
	 aDQnYFFl3SsKyRNKTHd9t6cfDgeyxL9v0p+bu5vv08jtdXTbtNlChNiNGK7x6q8w2T
	 krVPFqMInToDNbUgWEdd3Z4ofFWynO7xeYFYlWagqCwNasq3RSHQM3NBTSAj+fe8PK
	 BQUgMabDko5L8aVSaZFRHLugLB/+dGCDWkwwRc+Bi5Kxrd575HpKyU4YIsNOof0ofF
	 IIL3CNXwuKZDSgFOPen4XafT5rqHkXO2ww2CKfmkhW2SR0FtPjIk9vBnaVFhMRL2aZ
	 ZH5QexyXbJ3tP2HWZaolzLZzwGCVwJcPXjm2hVWKf6fd6vEBDTiJShz5P6hyoKA2al
	 UjsddH/cBb96YfuS/rWbTyE8VRW595Qax8HbzTEKAbGysna3c51
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b043:f8a8:cf8:995e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E21A6200B0;
	Fri, 10 Jul 2026 19:50:21 +0000 (UTC)
Date: Fri, 10 Jul 2026 19:50:20 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/3] Introduce a 'fromAccepted' option to
 GIT_NO_LAZY_FETCH
Message-ID: <alFM-4FJQfaEjyju@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
References: <20260710085137.4171240-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/XVXSmktqRKfXArG"
Content-Disposition: inline
In-Reply-To: <20260710085137.4171240-1-christian.couder@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

--/XVXSmktqRKfXArG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-07-10 at 08:51:34, Christian Couder wrote:
> Since 7b70e9efb1 (upload-pack: disable lazy-fetching by default,
> 2024-04-16), lazy fetching has been controlled by the
> `GIT_NO_LAZY_FETCH` environment variable. This is currently an "all or
> nothing" boolean that is set to 'true' by default when calling `git
> upload-pack` for security reasons.
>=20
> Recently the "promisor-remote" capability was added to protocol v2,
> allowing servers and clients to agree on the promisor remotes they
> can safely use.
>=20
> This series leverages that capability to implement a pragmatic middle
> ground. By setting `GIT_NO_LAZY_FETCH` to 'fromAccepted', lazy
> fetching is allowed only when fetching from promisor remotes that are
> both advertised by the server and accepted by the client.
>=20
> Note that using an environment variable for this is probably not the
> best from a usability perspective. An `upload-pack.allowLazyFetch`
> configuration variable would likely be better.
>=20
> Unfortunately the `GIT_NO_LAZY_FETCH` environment variable is the way
> things currently work. It would be a much bigger and more invasive
> change to implement `upload-pack.allowLazyFetch` in a way that is
> compatible with `GIT_NO_LAZY_FETCH` which has to stay anyway for
> backward compatibility. Therefore, transitioning to a configuration
> variable is left for future work.

I don't think this is a good idea.  We get a lot of reports on the
security list involving various tooling that isn't within the scope of
our threat model.  This substantially increases the amount of code which
is now subject to that threat model and therefore our security
guarantees and I don't think we should do that as it stands, very
especially while so much of our network-facing code is written in C.

The fetch code by default reads lots of configuration information from
the repository, including remote settings and information and we really
want absolutely none of that code running in the context of an untrusted
repository.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--/XVXSmktqRKfXArG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmpRTPsJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ8dfwQs3Z/2ShqV2zAeoYkgQscj70sQLhSN1MFZwcfRW
FiEECCzmip28ZfuD0cORfAxJYoiHooEAABkWAQDFQqpfJUQrr7pxZmkPVgf7+GhI
Z8CaPa0re+Y1zzSXQAD8C/bhrnfGN8oq9wWPSZo4vzeLtvJfHQm0NihqfZyzgQo=
=6/Aw
-----END PGP SIGNATURE-----

--/XVXSmktqRKfXArG--
