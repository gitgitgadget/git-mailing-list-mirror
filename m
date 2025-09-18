Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B6DBA3F
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758238155; cv=none; b=A3Nsfu4h9YRDwXEYxBgXZflPku6NBQRTHg8N58y/2xwEekzOXGOvtGTXr9YwrPqwu+QW1R4gCIwu5xxdceEjR4BB5/WFy0iiHspRbxRBepEaTe1TwBqHEmG2jiCLRRV3sgLSwI8zR05+qq8LQy0aP8lCxZ05Af1ZR7efYP2LEB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758238155; c=relaxed/simple;
	bh=T0Z1Bb1APB2cy40H8xX+BbR27Mz+PfflcuC0yHjvt/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tf8ol/p2UsSBvqbYBcCdlySJbSgKjpyQbN1jleZoyiavV+rL2GkOMyPqJDwYXPaUW2aY2RxaoyOrRKTJegDScIKTOut+RUozmVCEBl1vTg+WDJUnS34PQvau54NtQV9gTdMMmlF1TqfyXc7kmQL2l0s2J7SMl5ls7UYnYqScViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=av1seLE9; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="av1seLE9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758238150;
	bh=T0Z1Bb1APB2cy40H8xX+BbR27Mz+PfflcuC0yHjvt/Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=av1seLE9OgRWfojPRvOAET7ACo2ZV2bzrJLAxC386YGXDN+VkjOUV6SnOoh6gyN4Z
	 BnSLizGqVBIMxuQsMFgQnUe6ek7/Vx/267vx4OjAe3g0JEsB7qBGSx4m0qJJjVq5mw
	 PnQGHGDDL5jfEY+pC+wKwFEbmofyC7jOCEndlCrNXpxHm5yXLKeSR81Rt9H/USmCAc
	 zjYgoNPuHYHOcNSXRHNXKL7tqOQrYkhOSxmf4J7g/UWUBOr0GUZB+tRm94C1TNvXTk
	 sYU60bJ+neOfDlp/SlW5ouvXKYMDJJWe4tV5ENsP2gvvpozyAWAlHA2AEuPIAOrJsT
	 tZXKtINM/gYdJCSdx4OXKMCyT+Elim1qD8TMfdABuYSILAHfHjudles78qiwiX6M4/
	 ZTC3jRV5Fqz8hirb78hJIcKYzvPUXkOcpc+DlNtXWkE/M+8xILrO+bXm/nffJ8j0ky
	 hfg/TWnV3ZRvb37U0iBc+T5ARlkMiUrMPG/BSJAFkyaur0qZJgO
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ada0:faf8:3cb8:a81f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 60BDE20105;
	Thu, 18 Sep 2025 23:29:10 +0000 (UTC)
Date: Thu, 18 Sep 2025 23:29:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Subject: Re: t5564 seems to be failing on Debian unstable
Message-ID: <aMyVxQALCoIPpxox@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
References: <aMnjKgAcad9_I7qK@fruit.crustytoothpaste.net>
 <20250916224629.GA1182621@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XhyLLUpUFStmOSzc"
Content-Disposition: inline
In-Reply-To: <20250916224629.GA1182621@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--XhyLLUpUFStmOSzc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-16 at 22:46:29, Jeff King wrote:
> On Tue, Sep 16, 2025 at 10:22:34PM +0000, brian m. carlson wrote:
>=20
> > I've recently noticed that t5564 is failing on Debian unstable like so:
>=20
> Try:
>=20
>   https://lore.kernel.org/git/20250827080702.GA3572995@coredump.intra.pef=
f.net/

Yes, that does seem to fix it.  My apologies, that's in master but I
was on an old branch (based on Patrick's Rust base).  Thanks for the
quick response.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--XhyLLUpUFStmOSzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaMyVxAAKCRB8DEliiIei
gf9qAQDycZhGZ5bMtsA9BNF4tehdXHyLUZ8xVCCjFYYxlSKy/QEA4qyPjgBEthOt
k8i5gKNBsZjhVV3LdlwunU77jN9vjgs=
=vKJ0
-----END PGP SIGNATURE-----

--XhyLLUpUFStmOSzc--
