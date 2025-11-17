Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F209320CCD
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417402; cv=none; b=YT7Uy+Q11InbJVks3MY/3fGLYnUbKd/X37nTdxRAHNXu8LBz4N9Cq7W5Nqe668I1lEZSXlRBpWbfx7OjZCR0lYoSdkjHKxwgOJo5ZXVBiH0+lmbq79jSJlmUAa4sjxSIFHeJbnxR77qHtx1Mnrq6yt/8gg75yP+qtoFo5+k8ixc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417402; c=relaxed/simple;
	bh=1NobgbKwI0oKTWPwNjup4hHEdW9aJk/09dn42v+Xm3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp2lPIejR79x8Aow3tYzjtv9enbIyIOzb8slb0fHVcnD+dE02YUP8/ITcBS0M1Gp5fmHr2Z8KfKQrug/FV4PRf4baRHGgT34StY+t+s2PklRh2N6rk6py2up6o3pp39QwYWvQV9+hdE4EhrHgNkKIrxlsVv0YvDHTrq5a7gsHqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=rHetfLju; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="rHetfLju"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763417391;
	bh=1NobgbKwI0oKTWPwNjup4hHEdW9aJk/09dn42v+Xm3Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=rHetfLju4ypfHumGv/M0P9Ff6ccIrQv7RUaFO3ymi8CQww8Gqdlxh9YfGIr/3jQtP
	 IjGp0K3f6A0E6qQkznQBH8SrS71bQhWBlfmWSnKjqGJjhTu6e0tusSuIdhL3YY23MV
	 u1Wx0ldytzBVBKIZRLlFVR1EoXV9EpMC86xHQ2KAto5Od5t9nWl04My+S7KBQ1Fyen
	 M4FOARZe2Peg916Q/mMZ9JagoFekLdSLKtWjPpQ6a8cPvjruH4PvIPxIKMyqfOO11Z
	 kxH2oWeSmOQsuNdNW4XxJ+K7LtboMFHhhkpyLRGmjZWiyJA6N0aQ7SMVT90uKjfnRu
	 GIJJhnISG0I1zrBunZQV6/6z8Be7l1QpN7DlSML8tC9lX8OnT0xc2jt8vmGjfIr21c
	 kagXC48p2Sjn3QlDr65brQwf2Cfh/k+O5Cip08sjjLWHwkrOrA4EGUWTLHg9ol3c0x
	 cIK5OYIT0qGaa9wkPIK5ZaQF9qZ8AIpLsNLMZyOFkzZQ67GNEJg
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b6c6:bf88:c872:dae4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D02C520065;
	Mon, 17 Nov 2025 22:09:51 +0000 (UTC)
Date: Mon, 17 Nov 2025 22:09:50 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 00/14] SHA-1/SHA-256 interoperability, part 2
Message-ID: <aRudLpkRdRtCAoi3@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <xmqq7bvsjzlx.fsf@gitster.g>
 <xmqqpl9h9mgo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/9inmGPxZr76Oo/O"
Content-Disposition: inline
In-Reply-To: <xmqqpl9h9mgo.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--/9inmGPxZr76Oo/O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-11-17 at 06:56:07, Junio C Hamano wrote:
> In addition to "cargo clippy" I reported earlier (and attempted to
> fix) in a separate message, we have been seeing constant failure of
> "win+Meson build" job at GitHub Actions CI.
>=20
>   https://github.com/git/git/actions/runs/19414557042/job/55540901761#ste=
p:6:848
>=20
> I attempted to build tonight's 'seen' without this topic and it
> seemed to stop.
>=20
>   https://github.com/git/git/actions/runs/19418361570/job/55551045554
>=20
> This topic may need a bit of help from those who are clueful with
> Rust and Windows.

I think that has been failing with Rust since well before my code came
in.  It has failed for me for a long time (well over a month), so I have
just ignored it.

I'm going to send v2 shortly, but we can squash in changes and do a v3
if there is something actually broken in this series.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--/9inmGPxZr76Oo/O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaRudLQAKCRB8DEliiIei
gbzWAP9Kb5Vrmn6gCttvOxCiMqtIxXBjwymYgTzGIHm7z9RtEwD8DSrbHM48yGnw
aMgZqVf7ok74NgxrCc97lKNuXnrtcQY=
=4O4Q
-----END PGP SIGNATURE-----

--/9inmGPxZr76Oo/O--
