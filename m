Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0C33D9559
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086431; cv=none; b=PWo+/SEMDsj48fm4GrQqpzSt9PjP+LvrnE0PNVlnnzFly2pp+lmBWTzElP36Vwd3Hpll2ZVJ7GOmbv9Rq4x3OVNNSw/kyqdNN6RGQT+hxnBpV2TMGMxICdFDD0+t5C8eYWJ5JFfeSjPcMUCQGEpa7bEoZbZ6H5JzN2Lf81z37ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086431; c=relaxed/simple;
	bh=VquhUtlgzTbP4ZNtsPK1/JfO8D1p2HNTx7povVaL5BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eb9wN7e27IBiB4Tuv9c3az7Le9N82aAcCvXyPt0VfU6oO4Qshoq4WiKGQFyAYfSy5BMN0pDuaOk6Zg5rIv6O7k2oj0qYgS33iejxlAiZDdeKs3/jTFMhOb8LX4i4B6idCEVb4P1BINZUxemIh5Gs5ZmM2EukI8d0zGagoQRJcYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=A4TVhN23; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="A4TVhN23"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1783086427;
	bh=VquhUtlgzTbP4ZNtsPK1/JfO8D1p2HNTx7povVaL5BQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=A4TVhN23xS40TuxITAra1jm1fq3+eZ8IKdKWwWmTzush0u9q9ZM91QtSgApIvP5OT
	 RuFV41bMRUz+nITdnhAJf4rdrtKJb0kJkw5eTsPa3QGX/yq/SvfJC8OjsYLpFJjFdT
	 2ah5ekHWxRsZV3dUIiwVjoWWq2ZdhuyAwgdGltMIzlWNxGBNS7XNVGo1SH8wXUr87w
	 KTWyjDbvBKKrav357SuOGRtV/cMVCibb+bF4XPhrtC9UAMGNimY2bMkqYzRbvPTL9q
	 lNmbQaSZ+H3W1t8m3cUpFcxfkUx5HjCfZCfZDEk9V7HeaD7fVLUfDz8JKpLvvEunut
	 einMobIkYecKaWaXtQ+TdRfV421jqiuc9ZNyya7gl+Eug1gN7BXNbO2VVUEvHbnJ4u
	 M4GXGhLcSqFWXTz2k+H5eCHC9YoU3cFCTBn2Hz/+ak6C1S1s9j+oJZgYvWKQGc7yxA
	 EZoqaTZhGlam7VAan5/9yUcd/r4SNBUnnaQ524P31Dwx4G3hvQs
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4c68:467a:f157:4800])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6B49720074;
	Fri,  3 Jul 2026 13:47:07 +0000 (UTC)
Date: Fri, 3 Jul 2026 13:47:06 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 7/9] http: discard hash in dumb-http http_object_request
Message-ID: <ake9Wng-Q9p_sf_H@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
References: <20260702075234.GA1548258@coredump.intra.peff.net>
 <20260702080707.GG2029434@coredump.intra.peff.net>
 <akecqPq4F702E8Cq@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xgiQR9enH8FDr7Tr"
Content-Disposition: inline
In-Reply-To: <akecqPq4F702E8Cq@pks.im>
User-Agent: Mutt/2.4.0 (2026-06-19)

--xgiQR9enH8FDr7Tr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-07-03 at 11:27:36, Patrick Steinhardt wrote:
> On Thu, Jul 02, 2026 at 04:07:07AM -0400, Jeff King wrote:
> > The flag handling could be removed if the hash-discard function were
> > idempotent. This could be done easily-ish by having the underlying
> > hash functions (like the ones in sha256/openssl.h) set the context
> > pointer to NULL after free-ing. But it's something that every platform
> > implementation would have to remember to do, and the benefit for the
> > callers is not that huge (it would let us shave a few lines here and
> > probably in a few other spots).
>=20
> This answers an earlier question of mine. It would indeed be great if it
> was idempotent -- I've been bitten by interfaces like this once too
> much, where you have to be very careful to manage the lifetime of a
> specific object. The prime example of this are (were? I don't quite
> recall whether we fixed that interface) reference transactions, and that
> caused a bunch of bugs in the past.

Yes, that would be fantastic.  The Rust code will need a few fixes as
well (which I will send on top of this one when it's picked up) and it
really simplifies our Drop implementation if I can just do
`git_hash_discard`.  Otherwise, I need to keep track of whether we've
already called one of the final functions or not to avoid a double free.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--xgiQR9enH8FDr7Tr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmpHvVoJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ8bf2eKd6C+Ub5H6hRMwUvPcOVs4RCIOLMTtgoccGpOw
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAC0fAQCKEQh24Ygem1ykvnWQGniMEhSD
YBcdjqpFr4qkA6mzLgD/S8IOhUEcYdxi+Up053+p7o3Mnq9NnjLCGH6Uj5z1KA0=
=A1jr
-----END PGP SIGNATURE-----

--xgiQR9enH8FDr7Tr--
