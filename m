Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356CB3624CF
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 22:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772749370; cv=none; b=oooShXNQ/OgPiwt5y3nDcd+kyLYCJkk46Et0J3hojtuMMM8EsvViAAwN+g7bPneirC5vTmt+UlG1moooTyP3iuf3ld5ZlGgvCb1gEYfK3jlUEEV4RK9WH9La7PnCahdwF/7A2IvAAKH2TR6/u/B23pZ1tYQqJKg/tkUSg5elLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772749370; c=relaxed/simple;
	bh=pfnJlCTFxB004gx27FuESecnrbnzxtvkADHEhPKy51c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIQfZ4Lorh3I53cNMn3jkyYIFgGGsTLAt0D+s5QY0uNEIiNh6tNci7nTIKkBrYI+90Yo7vOOz8dpM15u4U8PCDJiiVv3cs6LGPUavduOJBcrhfPMkWoHVJTY3bLrm228PGqxYbudnNJWvIxYTKGqxYkrIZdvfZ9Q8hfet09IUZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ZHjsyajp; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZHjsyajp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1772749367;
	bh=pfnJlCTFxB004gx27FuESecnrbnzxtvkADHEhPKy51c=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ZHjsyajpbiRnhcNzfJUqcJnrOFpVJZnAS4gk6CxGP33Z5/IWMInU/6xs4DsdsgCYl
	 kT7hEm50TsBdQsCSZvemo05kNJrGiND3zmCV9W8AgUcpXJF1jThO24kn2KpIr01ixB
	 4FbhSa4Cp9Q8dAdwEEv1Ed58CptJD+a/6BUnPcmoXhsAPd4Qdl6MSr5NAVrnFR/ehl
	 a8ENkzGycRSov1p8H4Ia8CKUyHRQK9V+a8tkKoak7buEpA8vM/aJrkkQCpz+LxExPQ
	 tkKEacY59mKoqSZGAIBZvrKP+UO62nCzhxk9WmmjXufyYjEZScM/sf/UlmnLSXQsSs
	 AEQFToEB9OOPe0jDizScNM+ARC1tqygpjKvEH4S+NP771qA/AE1kwqHzQ4wrfBl2XT
	 BaZohbg6o6Fo2gE1MlKetl25RZ3DV2pkIzHG3J9EdsKtDjCFgJOLSlhgAWXlsRPhz9
	 QwWfrEA09d0d9xMLw+JjIAQjJgQbQW8pkQdUluTMIxs3KKifJPr
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:941e:963:e525:3a6c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1248F20107;
	Thu,  5 Mar 2026 22:22:47 +0000 (UTC)
Date: Thu, 5 Mar 2026 22:22:45 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Matt Smiley <msmiley@gitlab.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 05/10] compat/posix: introduce writev(3p) wrapper
Message-ID: <aaoCNUY3XVyFaDcu@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Sixt <j6t@kdbg.org>, Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matt Smiley <msmiley@gitlab.com>, git@vger.kernel.org
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
 <20260303-pks-upload-pack-write-contention-v2-5-7321830f08fe@pks.im>
 <xmqqseaf5k5t.fsf@gitster.g>
 <20260305003745.GA4943@coredump.intra.peff.net>
 <aajnZZI5yqL9CYeR@fruit.crustytoothpaste.net>
 <7e8b51d1-382d-47f8-be71-74e76f0c9888@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4zWtHAhLs1Wy5yYY"
Content-Disposition: inline
In-Reply-To: <7e8b51d1-382d-47f8-be71-74e76f0c9888@kdbg.org>
User-Agent: Mutt/2.2.13 (2024-03-09)


--4zWtHAhLs1Wy5yYY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-05 at 06:39:13, Johannes Sixt wrote:
> Please don't. The use of writev may mislead you to depend on guarantees
> that a kernel implementation of writev can provide, but a compat/
> implementation cannot. (For example, I read something about "the file
> pointer shall be unchanged" in the case of errors.) Please use simple
> and stupid functions (write). I highly doubt that you can squeeze out a
> noticable performance improvement with writev.

I have Rust code that does show a substantial performance improvement
with writev and I use it for a very similar purpose (printing the size
before a packet of data).

I am okay with slightly loosening the guarantees to support our compat
implementation if that's what we need to do.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--4zWtHAhLs1Wy5yYY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaaoCNQAKCRB8DEliiIei
gWAYAQDnP9FdXnW1r1eF1l19Rkdd7ZHABrcjzRxStjZg6Sa9XAEA0HC100B0XLIg
VJYk9Dgby43Mo4xhjuuzx8ApG1F8Ag0=
=DUjl
-----END PGP SIGNATURE-----

--4zWtHAhLs1Wy5yYY--
