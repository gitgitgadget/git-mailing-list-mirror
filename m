Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8AB1F4CB7
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577126; cv=none; b=drbD/QaH5PXTpdh4wr62c3gVXA37VKcS+PJvCs9+NaE46ccflBtjgfuX+/ddwGfdOr/2pBHA0rgRMvXXV3u0lzd8SQzT8aqGLeU76iEI+7fsQGV5i2Z4zE9s9EBfBO+zChLKR/lkmAy6JQsklkwqJkq+3oT4cDeK8rDLrtQIS/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577126; c=relaxed/simple;
	bh=Ql5APieTcpph6C6MmQne3UzCQpH33OTdxqJIJlLu6rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oR+tN2nDQmW1MnVe+Y0SR6FgKC3267Tgg++RAqgRZx25x2KEZpN0S9dM7GnU5+kBLeH2BgEfQxFBeseZFh2d07IZh0kJcwSS/cQFYSlihL3g6ULNL+1fUVda1FGW/UyEgSO3gLrrjcj7ViFCmMbFoGCe10AxSYC8wHl7VB6RlM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=k578CY+9; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="k578CY+9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758577123;
	bh=Ql5APieTcpph6C6MmQne3UzCQpH33OTdxqJIJlLu6rw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=k578CY+9A8pecxGhjvR+tTT+yuW7QSA8m0tF1Q3/sx+eTVXmKVPi/zyZRzNFUqWEe
	 lAPCKuZfWDt5ohGDCHB5lZmHMGPmwoineyUtPdKO1/VbqsUUslLhMLjTnaGooB8SZd
	 s0oJuLQ/3etcRhMs4oM/Bmo4Edx77M069EEwySHwCbIccilezsJtiYPTqOK1hVgCdU
	 CriGkMxt7ZSJ/+k/ZKr0YcCKlioIU5gChOY1/V9b/cb6q3DykHF9a1h2z0b/S7A+jm
	 CV7Dvr3QIVP14TtuXKE3NDTl6fmC0BG8Jn1Bz4XdfYqDh29uu+46W6ntDlTkxxkoM4
	 q5sRv1oDLz3fi+eQa3KUvZgmp5gROHdhuTpvWvAm7Kesm9QzNYTjH4PuFxrzdCkbA9
	 lzpuuwf/OCWgIfEcLJsgrvRabgiwxSycvVwgvmOR5wSMXIDihOeVDDsYlSYtRnW54d
	 5qpBipse1bOPbMSBrG1Hn5K7gEol3g/DVQM8Hy7LPmvCW8ED65V
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7cc9:7232:f513:ebf7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 219E220105;
	Mon, 22 Sep 2025 21:38:43 +0000 (UTC)
Date: Mon, 22 Sep 2025 21:38:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 7/9] fsck: consider gpgsig headers expected in tags
Message-ID: <aNHB4V7figj9lmfk@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20250919010911.649831-8-sandals@crustytoothpaste.net>
 <xmqqecs2yq83.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="manxOibBXFnqh1uk"
Content-Disposition: inline
In-Reply-To: <xmqqecs2yq83.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--manxOibBXFnqh1uk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-19 at 23:31:08, Junio C Hamano wrote:
> Could you wrap this overly long line?
>=20
> 	if (buffer < buffer_end &&=20
> 	    (skip_prefix(buffer, "gpgsig ", &buffer) ||
> 	     skip_prefix(buffer, "gpgsig-sha256 ", &buffer))) {

Will fix in v2.

> Do we allow a tag object with both "gpgsig" and "gpgsig-sha256" or
> detect as an error?  I think the most natural way to extend this
> system in the future with a third hash function would be to still
> have the primary hash in the payload and signatures created with
> other compatibility hash functions on the header, so if we were to
> detect, the rule may be "gpgsig* in the headers ought to be unique
> and should not include the primary hash algorithm" plus "if you have
> gpgsig* in the header, the body must also have inline signature, and
> if you don't, the body must not", perhaps?

In v2, I'll make it such that `gpgsig` is allowed only when we're not
using SHA-1 and `gpgsig-sha256` is allowed only when we're not using
SHA-256.  It may be that we don't have a trailing signature, though,
since we might turn a SHA-1 tag (signed only with SHA-1) into a SHA-256
tag (which would have only a `gpgsig` header and no trailing SHA-256
signature).
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--manxOibBXFnqh1uk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaNHB4QAKCRB8DEliiIei
gb25AP40Rcylh7NoM+P05rzqsCc6aaNayXlhOCOr68xvU/mnhgEAr+l/5tBXUZ9R
mw0HC8Ls8wnZ7Lt/9f5U7SsSobYTews=
=0ltF
-----END PGP SIGNATURE-----

--manxOibBXFnqh1uk--
