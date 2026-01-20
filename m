Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CD6340DB0
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768951441; cv=none; b=plaFYnDtrUSvn1E6D8fCAvzNiw61QeMafUKmUT4+aijVIwrhs2u49ET09wPvjWkE8V35qcXU9+DTdDv9CpbN8RvHPKtRyslKyxOsFaWtWWPbzhVBz5tRTrTGnLtCj1Q32G8LiAG/LXvbTHzRwbDFqG6vxMZw3cIL1hj9XzY77LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768951441; c=relaxed/simple;
	bh=TC7aBgoNFh/70wOh5s80oO/trpHxqHbAIwmGsQH1ZrU=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3RMe7/k56FYALvf4TemtQuHpFgk132i8jdke1w38d5+xlyiTJD4hped71t+NoEZsuJdeFfRopbSt9a7gzh1e3Tj433fG+PYjGgpkydIIxEaZznlfvsg4ayS8LWnywoPvm8QCHnnBexEs5zmz5BQ0dTZXqbWpdZoBSGhl1nfghg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=yygJVwzE; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yygJVwzE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1768951430;
	bh=TC7aBgoNFh/70wOh5s80oO/trpHxqHbAIwmGsQH1ZrU=;
	h=Date:From:Cc:Subject:References:Content-Type:Content-Disposition:
	 In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=yygJVwzEXtTgiD4pjXgdsHR0n2rF8IPYdF1hdsExc77JWkwy6p6nTpLA3dlIq8C6h
	 nUOhqqpAMG5GRqNWMwYIdOB+zl+5ub3M3EI1BOTIsDvdyqz6mKEck9oGjBLSJJoQHA
	 USGEJ9fmt1xlbS+M9uBsVGtj20lHPF8z9tvaFvuedtKRtVOFfQtX6xF+WxWB8Vta2c
	 IsRm35JnZkYGzHQOogWeIUIQgbhQvVJ4/FHz9BiFWPEZjdo7htlN+8Fcq93+V8JORj
	 RVSlEEpyltDOY5ifWFc5+KOGLT0btFNUpXnNFIlZVPqYu1TgmsG27CamK+PkadQsSH
	 C3RdDBZvmYiCj9S8u0uI/acYwjJRPYszd1J5rt49HoszlIAZXP260wHto30Zurpd/3
	 K8DTCAzJdd/7v/TdhHHp9fz/Pqnv+H4PTkjKUEY2duixLDbrM4LH8vre5rxJBG8G1m
	 bnqYitAZO8/sOFK0ZA+neTBEMZcabhg9XGumqaHYCUzUoRSS4ti
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:29e1:ea3:cc7f:75cb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CC34B20081;
	Tue, 20 Jan 2026 23:23:50 +0000 (UTC)
Date: Tue, 20 Jan 2026 23:23:49 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: ps@pks.im, Johannes.Schindelin@gmx.de, ben.knoble@gmail.com,
	cb@256bit.org, collin.funk1@gmail.com, contact@hacktivis.me,
	eschwartz@gentoo.org, ezekielnewren@gmail.com, git@vger.kernel.org,
	gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
	phillip.wood123@gmail.com, pierre-emmanuel.patry@embecosm.com,
	sam@gentoo.org
Subject: Re: [PATCH RFC v4 1/9] meson: add infrastructure to build internalg
Message-ID: <aXAOhTx07g4LVTNo@fruit.crustytoothpaste.net>
References: <20250910-b4-pks-rust-breaking-change-v4-1-4a63fc69278d@pks.im>
 <20260120221844.6085-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Azd4JXMoxbm1yI0D"
Content-Disposition: inline
In-Reply-To: <20260120221844.6085-1-ben.knoble+github@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Azd4JXMoxbm1yI0D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-20 at 22:18:42, D. Ben Knoble wrote:
> As far as I can tell, v4 of the Rust series introduced this script [1]. I=
 didn't
> notice any comments on or about the use of "--quiet" here, and Gentoo's b=
een
> carrying a patch to remove it [2] (also attached below). I don't think it=
's been
> sent upstream, but we could=E2=80=A6 any thoughts on "why --quiet" or obj=
ections to such
> a patch?

I have no objections to either of these patches.  We'd want `--quiet` by
default for the Makefile due to the output format, but I don't know why
we'd need it for meson.

To be clear, I don't use the meson format at all, so someone who cares
about it and can speak to it should definitely chime in, but I would say
that given the explanations in the patches, they seem reasonable.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Azd4JXMoxbm1yI0D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaXAOhAAKCRB8DEliiIei
gck4AQCgxkNLYEqqkx3jo080m0dwWaNB1+YfICxCQyQ0AzdQGgD/ej1lg9SZgUof
zaGGlzEpvDB8egoamr2+JkDhAwUMrwY=
=qpFw
-----END PGP SIGNATURE-----

--Azd4JXMoxbm1yI0D--
