Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36BB2877E2
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750889574; cv=none; b=Zrk/frd3NKDRjyjI2H9z0mwK0G0FU2pKA0aVbjdCUAsneObOeFuwNMVOw2zx9rFkCeOiRbfRLpEPTVuRk/JPqexYpp8CTDRp0GaAd+ogkTJMRDGoB9QJ4JD6oRIXKzRsIQUtc5PE/YcCpqdx2jvbjljY6SwjePJRsuMTd92aDDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750889574; c=relaxed/simple;
	bh=cq3KwfKwI4sjpDd9MTLo+iB+54y8CXxyvXy3ctofeYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3CScs5XhmCo1xZkBZCfk1PRavZNrNK/v/fRq0vngxiE2Xfl/Yk5piJC9jI1NU81yfMtEkItrKesnTTv6MD2+tFB8IRoPbXFwD0CyCpA27YvXeknMRZ1WhWUQLwsua8QSzOAQmo7ZSDjz30EGhLkyL7wQ5P9PJavsqxKC9bGN8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=dFBxCuZd; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dFBxCuZd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750889564;
	bh=cq3KwfKwI4sjpDd9MTLo+iB+54y8CXxyvXy3ctofeYg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=dFBxCuZdY6OwOb2EMk1sqWx5REg/thC3GUOOmRAoJVChe5h4OzXnKHNCh+btHplkf
	 l0JD6cGmSc4FRdVnrUYY2IKojWVXdOM7AEn+lCagas4QVxpndiF5A/I/lvg9Ar1Hht
	 THGTyszBhjmM9aJ7np21FnuvEigliMmFwy+90GGLP7QF4wQTxujlhU36ZTqwrj/zby
	 dd5zkmFVOlVYhgmIm2YFbCg4Th5iE/Lm+Oysbmx83BjTJAnxb8063bYcIwR060oHAX
	 agEaA6agShMZLgmOcNtkSK6YCNh1K++aV8LhDPkUZFjZCwnNOQ+SKL0gbMqATmwlM8
	 /i+4Nq31T0YyEhzqIAcO6TG0R/Qr+ITBWLssQ1WnICGkT6bmI0dlyL20+ELDf9TVPs
	 aazD/XaP4LeM5xTyka0hkIa2MxfC8briH/V3vujkRDsZs41Zbpy4CYQiVBD+qTuRRY
	 Ux5nrJ4hrFMThXbNcOpR/etSZm+sARTLR3ZTkLVhxH/3EOHpSVQ
Received: from fruit.crustytoothpaste.net (pool-99-237-158-163.cpe.net.cable.rogers.com [99.237.158.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8D6C72003B;
	Wed, 25 Jun 2025 22:12:44 +0000 (UTC)
Date: Wed, 25 Jun 2025 22:12:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2025, #08; Mon, 23)
Message-ID: <aFx0WlgwJpRiHC2Q@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqtt462bye.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ensHBOCXZWp5/k1Z"
Content-Disposition: inline
In-Reply-To: <xmqqtt462bye.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ensHBOCXZWp5/k1Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-24 at 00:57:29, Junio C Hamano wrote:
> * bc/use-sha256-by-default-in-3.0 (2025-06-19) 10 commits
>  - Enable SHA-256 by default in breaking changes mode
>  - t5300: choose the built-in hash outside of a repo
>  - t4042: choose the built-in hash outside of a repo
>  - t1007: choose the built-in hash outside of a repo
>  - t: default to compile-time default hash if not set
>  - setup: use the default algorithm to initialize repo format
>  - Use original hash for legacy formats
>  - builtin: use default hash when outside a repository
>  - hash: add a constant for the original hash algorithm
>  - hash: add a constant for the default hash algorithm
>=20
>  Prepare to flip the default hash function to SHA-256.
>=20
>  Needs review.
>  source: <20250620011943.586596-1-sandals@crustytoothpaste.net>

You'll be getting a v2 here based on your comments.  Of course, if
anyone else has comments or feedback, I'll include those in v2 as well.

That v2 will probably come this weekend, since I'm in the middle of
doing crimes to index-pack for SHA-256 interop and don't want to change
branches right now (although I suppose I could use a worktree).
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ensHBOCXZWp5/k1Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaFx0WQAKCRB8DEliiIei
gXk+AP9LzoiTOrn5qsjI8QNXTMBj6MXSlNLUSiya01KMahNfYwEA94M4ddu3vyFO
vDcu0uYfOaUe2xTrHak3ym4Nvv60HAA=
=n69Z
-----END PGP SIGNATURE-----

--ensHBOCXZWp5/k1Z--
