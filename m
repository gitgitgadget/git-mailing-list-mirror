Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF75279DB6
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483156; cv=none; b=hfmCBmTMc031Laz/jq4tE6wtuYk7qqD/uOMaPM6kBmh6i6GyNAf3f8Cd88Dn9voTINLWEzWpsTy2KrkSQgxOfnrVFKRWLjXnimTfYcofLl8y4aHChSkmvfno2vBtdKZlsplSXCpVMLyrMXerTuf/oDs+Ttnfn9i/nnQg+OAQchA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483156; c=relaxed/simple;
	bh=5vhvEauh9nMhj2WrufjfDLV1ROXcRvfUkJyy+MMg+E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4l7dYNEEFVyDRboqlalzZXG0B/t7x+t/f3rhNQIki223gWN2dEhCikMnq/B2rAgCs4GlcUzQ1CR/rmOZyywSN2mFNlDt6QjIqTHuPq+hpkoWdL/WX05wvxrivlOJedd5BsQVxY5Hpnh+oh/MlXuuJMMNZhrabvinhbjYck4beU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=cCaDAJx3; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cCaDAJx3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1786483146;
	bh=5vhvEauh9nMhj2WrufjfDLV1ROXcRvfUkJyy+MMg+E0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=cCaDAJx3q1FmXgvbOcTv0K3tUAfP8ehxEP77sdjzfLxwRaIo+5ksIz8jRhztNWUnd
	 93jM6/C2A/y+vH1xEkcshg3En9du5L6SNDq0SpaqmRUcR4w9RHDExT8pokGVHdFaI/
	 3TizZ0KsxL1xsK7zc+drD+vqMmG/uQUrDQjnhqmkVIyLTgK/Y7iMo7qDptTbreU0KE
	 6pAvtG2Ew+sieVZXTfUTZsSBJMn2k1xR21/CofNKT8K2zc1YEohac2Epfy8XQ5JpfH
	 vvcCd/APebRp39tM4uEh+XwPUUbniYKbvkXWqlA/T4GTU1vMWEjvfJXbfjDJ3CSqCg
	 UcIrqAmn9BYQ2K/JaC0EeqJf7DNJU87EiZ9Sf5kRHYmOlFmrNpn8kOovnJVVUQafvS
	 e91mWYbDSRCJkZRs7Q9J7gFJ/IO72oxzCO4mORHyUlMDf2/+z2paA4G2PtKL6Qzj2X
	 CrNGOiaMfIqBzHKAxB2BmxyLhYw0eH+vDpGaPY+nuYnxrv6CZIc
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b5bd:7de1:8f85:4bea])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BE74F200C6;
	Tue, 11 Aug 2026 21:19:06 +0000 (UTC)
Date: Tue, 11 Aug 2026 21:19:05 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ron Nazarov <ron@noisytoot.org>, git@vger.kernel.org,
	Stanislav Malishevskiy <stanislav.malishevskiy@gmail.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Subject: Re: [PATCH] config: add http.sslVerifyHost option
Message-ID: <anuRyMJMyAS9OMNl@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Ron Nazarov <ron@noisytoot.org>,
	git@vger.kernel.org,
	Stanislav Malishevskiy <stanislav.malishevskiy@gmail.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stanislav Malishevskiy <s.malishevskiy@auriga.com>
References: <20260807153315.9586-1-ron@noisytoot.org>
 <ansYP7cDvtNWueIz@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4DneUKerS9GPNaL5"
Content-Disposition: inline
In-Reply-To: <ansYP7cDvtNWueIz@pks.im>
User-Agent: Mutt/2.4.1 (2026-07-04)

--4DneUKerS9GPNaL5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-08-11 at 12:40:31, Patrick Steinhardt wrote:
> On Fri, Aug 07, 2026 at 04:33:14PM +0100, Ron Nazarov wrote:
> > This allows for disabling host verification without completely
> > disabling TLS certificate verification.  This is useful when using TLS
> > in a decentralized way (similar to how one would use SSH), where the
> > remote endpoint has a self-signed certificate that does not
> > necessarily have a valid CN (or any CN at all), and you set
> > http.sslCAInfo to that specific certificate.  Without such an option,
> > it is impossible to use a certificate with a non-matching hostname
> > without completely disabling TLS verification, which is insecure.
>=20
> Arguably both options are insecure, this new option just pretends to be
> secure. If we accept arbitrary certificates for an endpoint, then it
> becomes trivial for somebody to perform a man-in-the-middle attack
> against you by simply swapping out the certificate against a self-signed
> one. And man-in-the-middle attacks are basically what we want to protect
> against with TLS.

I agree.

> So sure, using no encryption at all might be even simpler for an
> eavesdropper to intercept. But in both cases they'd have to sit between
> you and the server, and consequently they are very likely to have the
> capability to MITM you.
>=20
> There are of course going to be exception to this, like for example when
> you sit on an unsecured wifi network. Other users might be able to read
> your traffic there without also having the ability to modify it. But I'm
> still hesitant to add this new option here as it oversells the security
> benefit it offers over disabling TLS entirely.

No, on an unsecured Wi-Fi network one can use ARP spoofing to send all
the packets on the network to them before they relay them to others, so
they can all be modified.  I've done this in controlled environments and
while the network can appear slow in some cases if you're just using a
plain laptop, it works.

Some Wi-Fi networks have some sort of isolation feature to try to
prevent this but I've read papers that they're easy to bypass.

The assumption you absolutely must make is that anyone who can see your
packets can also modify them.

> Maybe I'm missing something obvious. But if so, I think both the commit
> message and the documentation would need to be amended to document that
> gap and state that yes, this is still insecure.

I just don't think we should accept this option because it leads to a
false sense of security and it's easy to misuse.  Moreover, getting a
reasonable working TLS configuration is extremely easy with ACME and/or
DANE these days, so there's really no reason to need to accommodate
broken self-signed certificates anymore.

I'll note that technically nobody actually uses CN anymore for
certificate verification (and I think Go's TLS library ignores it
entirely) and everyone uses subjectAltName, so it's possible to provide
a reasonably large number of different names for a single host.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--4DneUKerS9GPNaL5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmp7kcgJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZw6IWDAZplkKlhyWeNkrYxsS/8nUTFQWOoBP7XjkDSWF
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAGe2AQCxobY4p8ouM+jhUsFsCYKL26Yf
r2Sy+cQEsZsiZGZXNQD9FeAXp5PCorxJ5adRyr2LXXiU6Oo8ffTVijYWyZtbZQg=
=hbte
-----END PGP SIGNATURE-----

--4DneUKerS9GPNaL5--
