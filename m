Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2512E346AD7
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774995423; cv=none; b=AGsWvEfoRtu1vHUfLC2Km7rUaAlc1Wujf3udcmExLt/8kxupCyKTDbKEw8ZO1+VYHCfOFtKKVz7aIVBel1bV8DAyoXOs+l+uAwqW9k36LNSjsY//kkNux+LGywK3JV0wTxviZJj1Nkeou2zXP8Tsz9zBNxQaAG8z4/UqlYG3XKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774995423; c=relaxed/simple;
	bh=lyKQAqg8SAVcxTF4BT40sbpdUDSdihamJ5N62fTruUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocBDrvf4sY0UmxgGRWDoUguTQjXJo84KSjjJTBbZuKgCqHsOlJ8LuryAfavztZFEnZflRpAqsJ5wN+XOlVO56rMAKNShNYd4wSWxKQENzpe33mtdOGoMiJ2bEIXBgBc4G0P0xf6Ke4LFKxT//4orGgahTR+f7Wj9NOO6fZAfTPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=puTGfCNM; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="puTGfCNM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1774994899;
	bh=lyKQAqg8SAVcxTF4BT40sbpdUDSdihamJ5N62fTruUA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=puTGfCNMN2M4M8krHn44nOPa6NKDVzHau6oXIqVXj8IIgnAgHkfnvnFvwIuqCIe2b
	 IFMumS0ex2AdFr1FOaFe7oXSw+AdFIaO2dN5Cf9YVG1YFSzgFq/61CVxgXSUarxAC7
	 iNR3uqORZgjhxHC8KrL8ObbxvC4/H5aceC3SEyHrybwSwUVBIHVW8XkXXTfS7eGeu0
	 /ZjtYiLrSH0R3LW4D7JAvyNKYTdeolh7olfEK2RvVyK/ZHDr4dyS3kDKJLNIBbfBCt
	 OWC5oGC5yLVVX5pP2k+xG0GK4rCS/CmO2Uzcl6MgIPypXQGIywJYkB4KS7rpEIAFKS
	 7WXcRQjEfkgQDly5K05kRX5P1n1jBE/m0/N5VFKQSvJpxlW0tXdGlu+xUmjzjts9qv
	 Vto2b+3ufNYyfB20YLTFKqGiE+27Jsv/3sBisw63yE8SQ1CsvUOhK/YgoR3QnqxeV1
	 JZ6ed5HmixL4uJthx+pqL8gRGFWahdYj61kyIxAThrBqd42q2Ho
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4a2e:fe2f:cd8f:162c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2790C2011B;
	Tue, 31 Mar 2026 22:08:19 +0000 (UTC)
Date: Tue, 31 Mar 2026 22:08:17 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] reftable/system: provide `REFTABLE_INLINE()` macro
Message-ID: <acxF0cwfVTbqn-XM@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
 <20260331-pks-reftable-portability-fixes-v1-1-46bfae55c68c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xYQWlpDL/+PSq94/"
Content-Disposition: inline
In-Reply-To: <20260331-pks-reftable-portability-fixes-v1-1-46bfae55c68c@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--xYQWlpDL/+PSq94/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-31 at 11:26:47, Patrick Steinhardt wrote:
> Not every compiler knows about the `inline` annotation for functions.
> Consequently, Git knows to define `inline` as an empty macro in case
> it's not available.

I thought `inline` was in C99, which would mean that it's been required
in C for over 26 years old=E2=80=94it's older than some of my colleagues.  =
What
compilers are people using in 2026 that don't know about `inline`?  Or
more importantly, what platforms are people using in 2026 that lack a
usable compiler with at least C99?
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--xYQWlpDL/+PSq94/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmnMRdEJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZyC9EpfZUDeXHTOc8RsFMa6/eOln6vuOhT14NixPCcoY
FiEECCzmip28ZfuD0cORfAxJYoiHooEAABbcAP9QmVpPykC6UKPTh0D+LZ0jRb3q
194weALDjUgtjjWcoAEAtNcp8SX2B2F3LfMwytN9cid6gL5nQOVpbzT2bo1GuAs=
=usAu
-----END PGP SIGNATURE-----

--xYQWlpDL/+PSq94/--
