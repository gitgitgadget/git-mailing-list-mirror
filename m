Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DC278F4B
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762133443; cv=none; b=m00Ql9nmFqLKo+AbkGcSUmzTlSC/lRrEzxR+y00UUQUorvStZc/QZnghw3wp640n9kjH8HRk/F3cbn0NbJT6R6xEEKoLJWbh2/4U9LPgFgG5cLKmS6Yn4Cnyn1RbSIK3t06rwcVS4MxI0cgckeBbzt3sQUnMIzZ+MgO0xW8JLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762133443; c=relaxed/simple;
	bh=evgogiADSkKvdvKshiWz012GGuw2WKlliaSy29pJDQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD4tgSNElmopDVYqwd+jvCekWaEt081FATNK5MTyalvRQ1XygoP9+9+oKl1+C3UmQ5AQRXRxwcmr3YArAKaVQjW0NefTPEE+mM9SjBR0d6PlShTgDGQJQnLauEw3I5MQ0ye04QhCmG0GY0Gwa+4A/gWyzAGvyZ/pbP8fYhqxkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=q8AXbifp; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="q8AXbifp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1762133438;
	bh=evgogiADSkKvdvKshiWz012GGuw2WKlliaSy29pJDQA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=q8AXbifpPxfSaFdrM5VyqG6qcShSTIHdtRJ91QR6ADrMbcJguQrGA5cElhAbu70B5
	 mnjAr/INTIcKPt65XODS6mBadDapFb4BxyGf9qVmOYg+uchn8WRbZzTFOWk5sKuo0N
	 7zEWOO3tHDaOn43hDooX10Hh44tGNjr5tZ24EQyWLe3pHD2efhOFXnqWeNxEPSEV9M
	 tNCaiZ7JxIxXTn+Hjpq3/ZGhYSDNzbfIQ+c2bES4rG0+EBOtZ4jR/sa74Tb9xlR1ZD
	 4Zmq6tXBUsYnr/ovRUKYTJ8HvmfspgP85YCTuVVd32wJ/YvRzD+KIqpvGftxxfzpWJ
	 JPKzghz/DolFK/lEJXYP/aWyxDBh/t8G1SWay/GHp1kKmEhZxOhUCMryGOKwHTSSwm
	 IgwkntoKNjpYL9pnF3vBIf61fTADUJGYhDdJ5JzMDRfo5YLj48SHuGJjDiJv6tjFWc
	 PBx3fNQHoyi1LjuRPIU8J1ezHwMrxjst14AkxrmaMo+fH+ERUMB
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:8116:1140:7c3:372d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8100B20036;
	Mon,  3 Nov 2025 01:30:38 +0000 (UTC)
Date: Mon, 3 Nov 2025 01:30:37 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Collin Funk <collin.funk1@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 03/14] hash: use uint32_t for object_id algorithm
Message-ID: <aQgFvfMwPcXgYHX7@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Collin Funk <collin.funk1@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-4-sandals@crustytoothpaste.net>
 <aQCKCfuaEKBArD-g@pks.im>
 <xmqqh5viddo3.fsf@gitster.g>
 <aQKv550C6nXhCzf0@fruit.crustytoothpaste.net>
 <874irh6tgj.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1AcXZoRHc2ho5H+k"
Content-Disposition: inline
In-Reply-To: <874irh6tgj.fsf@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--1AcXZoRHc2ho5H+k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-30 at 01:58:52, Collin Funk wrote:
> I guess intmax_t and uintmax_t are probably not usable with Rust, since
> they are not fixed width?

They are effectively 64 bit everywhere, so `i64` or `u64` is
appropriate.  These types are not actually the largest possible integers
anymore, since they were originally defined as 64 bit and implementers
refused to change them once 128-bit values were supported because that
would break ABI.

With gcc or clang, you can do this to see:

    % clang -E -dM - </dev/null | grep INTMAX_TYPE
    #define __INTMAX_TYPE__ long int
    #define __UINTMAX_TYPE__ long unsigned int

Rust also has `i128` and `u128`, which are part of the ABI and are also
used for things like `std::time::Duration::as_nanos`.  Rust claims that
it is ABI-compatible with C's `__int128` where that exists, but it does
not in all C compilers and on all architectures.  Compatibility with C's
`_BitInt(128)` is explicitly disclaimed.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--1AcXZoRHc2ho5H+k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaQgFvAAKCRB8DEliiIei
gbOqAPwIQQImOgh6psQ8hlThy+V2x7sImtX1pxgwhzgD3/AzlgD/a+u+uYEn3uYf
vq9P20re3qTJVx0SqNdCvaRxTbSpRQY=
=d4SU
-----END PGP SIGNATURE-----

--1AcXZoRHc2ho5H+k--
