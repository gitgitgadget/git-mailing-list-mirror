Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0026A224B1E
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860533; cv=none; b=P+JG5R7oXE4VgV+coZt9IDiGcdNNwCBwB278V5q0XEBXmDioANQW+JkhBvOeafLcOn6+fvb44dTTfebfoBGR3n2ULLrQFROkKnthTdBFbGtGsdn/5CSLo/a4UUkl4mzn5Igrux/LSmaS0czQ75OYkv9bfHz+4FX0IgJ7Kb77Nm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860533; c=relaxed/simple;
	bh=uSJoYvaBqObBpDyzYhE5XSGy5VsSjVi8h69kZpW9X1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOVZE5cD7jouJWnfHPW/5Vi6Sw1MCdM4Lvw2Jwgl/9nsG7nZXCjKrknBE9twstzcUd7MrQrI8FOYHeM2W8G43k5W/JZJVuEhYCgpvtwHW3Ci+1MuEYN3oXLqZ/qO3wRP9jgixoYEwIITx4uET7VXSN4rl5GVIBa9ozKhrqiChzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=dPIVd4qp; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dPIVd4qp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761860530;
	bh=uSJoYvaBqObBpDyzYhE5XSGy5VsSjVi8h69kZpW9X1M=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=dPIVd4qp3SqwJp6YpGJ+zZ2qH7OvnY70Ema5/Yjrzvf07patARwcDRubdaWPyU9iA
	 tDAxBdagczh1WQCFTZTziH9/YYr6qOahxIKB22ALKYmZftYIazwW5i78QZ/tdy79Y7
	 C8nF3d1SENnIfJG8rRLtXYvBKyK39UggtRWzVHqr0C5u0bADVKAKbVa6VtgVvV8Asp
	 Gs5a8E3mqof1WYq9fPGBGCVfO8FxrKqy86+a1ARbmxtjpOscmetD7McFWzVjvgtqbt
	 dDWFfg6zudhBt3wC4GP5zf8h7Z8q9vbF7u5MQ+pFlesTZo2tQmETZCjBY7q2znFhLw
	 ndE4CpwKobMmtjs7Sj8zAB5iJcrb0F2NKIBbtfus/yeMisOU4zYw8fowoYBHJggsim
	 ebigjKYLpRti3L1OnBnyCyOZpkScws8Vi8lUtNm1h4zqJZNLmFciEBl/xlX42gOXAq
	 emh1XDW1afzwTCKhXp4znxRTSfxJslC6ORhd2ei0nQ4O/qwPWbP
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:bbe9:68f3:1302:8e3b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CF3FE20036;
	Thu, 30 Oct 2025 21:42:10 +0000 (UTC)
Date: Thu, 30 Oct 2025 21:42:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 09/14] hash: expose hash context functions to Rust
Message-ID: <aQPbsX-J4eKvRTar@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-10-sandals@crustytoothpaste.net>
 <xmqqqzulacst.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x6NHugciTuSJprQS"
Content-Disposition: inline
In-Reply-To: <xmqqqzulacst.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--x6NHugciTuSJprQS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-29 at 16:32:50, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > +struct git_hash_ctx *git_hash_alloc(void)
> > +{
> > +	return malloc(sizeof(struct git_hash_ctx));
> > +}
>=20
> Not an objection, but this looked especially curious to me because
> it has been customary to use xmalloc() for a thing like this.  Going
> forward, is our intention that we'd explicitly handle OOM allocation
> failures ourselves, at least in the Rust part of the code base?

No, I'll change this to use `xmalloc`.  Rust handles allocation itself
and just panics on OOM, so we will not want to handle allocation
failures ourselves.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--x6NHugciTuSJprQS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaQPbsQAKCRB8DEliiIei
gWfNAQDMUNSYCQQfHR3BY6ktYZHaQaMrxz07Gne9MizseKUPgAEArRqLPtHV4gep
JWELPh5S00BEAi4tZIehZVbg7r8ECQo=
=cGcg
-----END PGP SIGNATURE-----

--x6NHugciTuSJprQS--
