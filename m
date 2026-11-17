Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959447;
	b=kj1iDIldj0uMBsOHn11okhnAO7M0NrG/7Y8TlVP6WYDhjGrOJb/Dv8OsKBHHHHfz9m2O
	 uBlMC6hYiwvJPe/82rlp9YSMxeFeT4sG6q1eSCC8GgSl6LzWql5OKk2pY66uUhVQRtFdr
	 vx7eAg9Mkn/xWAiDEcA6Tfxpv9pjJH7xjH8yA7quUiZpeLOGos9Lnm/qpl2vrvBI4kunj
	 d5J0qceroLtj6BDC5MKoOIWTPwg/hppqdPW+ByV0/ogVutjWo/zW9mEw34MIj47/Yp4Fp
	 Inq4MOvK7J8i1oAnRHDkpwBIHseKdKiRnmHJ1+LVM1NnrS81kcpU+OHaQTqd18sFssA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959447;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=SddfH0M2f2yMxa8Akae3HyjZTeesmCUs3a6N/1qfw5c=;
	b=miyoOpx8SA7vscsQ/TY11v8f+RGEnjZM0gvDROCgUyCetYzOGRTFa0BMwKahgEz5bCRe
	 sPntDggC7Nu7/zMDOJQt/ffLPHJx5zj5DuI6HKW0bDxnrlC5i2y3HNvuq/NuG0/tflGOl
	 04/zXCx9AxeFuP2MVYngKItWFRK5QAhQpEiEnW9rX1k9N7BwP8+g2fZYsJ/lc0BDISDAu
	 3h2GPNj14K74Rs8cbD7dM+/suJLF/zHrur0L8fCGSnmjpclCPKu+SCL8EM9ruJFZTVK4O
	 Xm0fNYj8Ns44dq86d3cEHCMIZbwe+wk3fH6+/Yp6eKwEKd0/81s+WZNvF4jRcXoztoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=xROO1qaE;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A8606A330
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 23:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A03A8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=xROO1qaE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1794959439;
	bh=iq70JrtMdXfE4X/imWk+lIDj87DFu4tIRnlCnGjXgQQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=xROO1qaEuft2jz5n4k2kDpFLFl4+rT/DUM2QVcGtslEkI6dtKOo3nW+oY0cr2vGrW
	 AT0+wrde7BF0Cxd2i8LXHz6989BADdIqImT+xEHCNYN3a5LLgXX5YLD4gzfWnOoE6U
	 LqztmLwQ6EBKeNZfs6A1zvT/oG6mXn1X9XYlw9/KbxOHeGjQ+9sbF5A46JcF9K+4NF
	 G1INbkM1yTnPlZ5IkQdjI+Duqzqh9l8RvXrjKOOEqNN4SwoGK3wRjFkCm30eI1Twp8
	 YgaMvljzQvYcCRkwIRIDuntGu2TZqbOo3aUXttJSjb0LY3ccTt5v0Psua4NoetzjHL
	 ckLiSVN95TasLh+VnsDimQ4Rq0sYIYGdK0T8bEss1nWKiqYqxG7aCIuvAPluYEnHIX
	 +NCv0MRYiPXYiVA46X/1k684MRadKEQiArFj+jegLCNou6yeKTF3RM9qhLlFKOAecC
	 bOrynt3QcYS+6kTLVpR5/6Vf/vifi67GIAoEw8rQirlZGsHT+sZ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c07:7d00:ae8f:ead1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id DBD06200BF;
	Tue, 17 Nov 2026 23:50:39 +0000 (UTC)
Date: Tue, 17 Nov 2026 23:50:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Neeraj Singh <neerajsi@microsoft.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 1/4] csum-file: use size_t for the count passed to
 hashwrite()
Message-ID: <avzoTWMQbklUTDQi@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Neeraj Singh <neerajsi@microsoft.com>,
	Patrick Steinhardt <ps@pks.im>
References: <cover.1793546752.git.gitter.spiros@gmail.com>
 <cover.1794909894.git.gitter.spiros@gmail.com>
 <07baad46b153b255b6e70f2597f1bf41b9c48dfd.1794909894.git.gitter.spiros@gmail.com>
 <xmqqeccjfipy.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2Tj6xjUJ2qeRd4ED"
Content-Disposition: inline
In-Reply-To: <xmqqeccjfipy.fsf@gitster.g>
User-Agent: Mutt/2.4.1 (2026-07-04)

--2Tj6xjUJ2qeRd4ED
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-11-17 at 17:52:57, Junio C Hamano wrote:
> src/csum_file.rs still thinks that hashwrite() takes u32, though.
>=20
> If a caller of hashwrite() has a contiguous region of memory that
> exceeds 4GiB in length, shouldn't it be looping to call hashwrite()
> in 4GiB (or less) chunks, without changing the API contract, I would
> have to wonder.

Yes, I think that would be the right thing to do.  If we're not going to
do that, then we need to update the Rust code accordingly.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--2Tj6xjUJ2qeRd4ED
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmr86E4JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZxr31zpIXdr5N5k5s/thyDDIkppVFPX34zEXnfBMmdp3
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAG4sAP4u44JGVpuaJfa0oKoayRT8GpLL
MQz+fBm0xgNetYjTFAD/UnwCsGZGr4gKhQ3IRuJYLnevYSs7U8t4u9K51k8x6Ag=
=Tnd8
-----END PGP SIGNATURE-----

--2Tj6xjUJ2qeRd4ED--
