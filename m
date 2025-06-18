Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628627A455
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750285661; cv=none; b=FycarlRpH5ncqG0tZsYKMODegADKKfE+yTw5awpuTJqZRbbK659/i1KTN16AGzsqVTGhPYaGSj/IXfF2uYzliGvzyrcSs192W+0wk/xlA74oMdruNvulwEKxVvAvgDNnDamLhnsW6FLeLJtwSBQzX6YhKgSe8mpflUEXjE8GCv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750285661; c=relaxed/simple;
	bh=VmeVTaSxr3UXj23XlxOc3dg9IOgdFpHHALN2PLBv/zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDmXPrLEWUoMkYWLZhesquK9hdXa1Wfp1SiontQG47Wo7X+RciQLCILj14qjGU87JpHPB0Cbsbxbej7aYmODsf2qxvN7XWNzC2IT73O+vv+v6FVvoonz4Fm7q/BPO/HJXEJTX//KAsO2ZbXFV7tBBp95DM/md1a18mv+dTRHT4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=g/Jv8Ci+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="g/Jv8Ci+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750285651;
	bh=VmeVTaSxr3UXj23XlxOc3dg9IOgdFpHHALN2PLBv/zo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=g/Jv8Ci+ltJ464aMp4bWoDFEvNuJqA6mPyO+ygfoRmgUvCCBvSnT3KXN18Cv4PE+A
	 iq1QYcOPY2HGcDGMn9Upn/Wdv9BRlD94o4+8cyKIwTeaLno5T5SO/eXg1GZV2YmYqA
	 K1W1tDOr82hBtfAvsu7GG1iZX0xxtRFMQJUQL/AZ0Kgrmr20yCW7DP3u7euZeKGsem
	 pch1+a6X2k+SEPewTMqHi/YN4l1q92BLbbypFRsR4ek9H6Lz0kJoqRn2JbQIan1qS0
	 guWE1P1488STMpnKWrHHU6HixVHm6q4v3Yprjn9/SkzhXlwcrxeN5ytKSJvg9Z81YC
	 ovdNgf3M5xD7nqVFw8MLBzTYq/pIrMP/bW12Mcint3tNLBNAEKtx34/86FlgmddDrR
	 u2/jLqZ0gCAxnng1JPyc0eHq2a+h4CZdajgs95191UgGCKGFhHiFcGtWAkrlYrVqWw
	 OYZbevoMa+71taFCCA6Wuhj4KT/mXGFXLLKQCIAvJcbgJQB3fep
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:84c:b721:30a8:e437])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 860DE20120;
	Wed, 18 Jun 2025 22:27:31 +0000 (UTC)
Date: Wed, 18 Jun 2025 22:27:30 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Haylin Moore <hmoore@qumulo.com>
Cc: git@vger.kernel.org
Subject: Re: git only writing 4k at a time
Message-ID: <aFM9Uh0K2TSAuoHb@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Haylin Moore <hmoore@qumulo.com>, git@vger.kernel.org
References: <CALnKHDCH_174KnP6Um+G8YCpDBGNNk40xS0T2K6VtnDv9hE37Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EjTjoGzBJgZqMwZ3"
Content-Disposition: inline
In-Reply-To: <CALnKHDCH_174KnP6Um+G8YCpDBGNNk40xS0T2K6VtnDv9hE37Q@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--EjTjoGzBJgZqMwZ3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-18 at 20:58:52, Haylin Moore wrote:
> Hiya list,
>=20
> I've been investigating some performance issues around git clones over
> network mounts. We have noticed that git is only writing 4k at a time.
> These small serial writes are making it such that even though each
> write is only a 3ms operation, the total time balloons. Looking around
> the source code I found that reftable_writer is initialized by default
> (though I cannot find the block_size argument being supplied in my
> cursory look) always to DEFAULT_BLOCK_SIZE (4096). Is there some way
> to increase/configure this block size such that larger writes happen?
> In git/Documentation/config/reftable.adoc this block size is mentioned
> in a manner that almost feels configurable, but I'm not sure if this
> is just internal for development.

It's fine to adjust reftable.blockSize upwards if you'd like, which
controls the block size for reftable writes (which is what you're seeing
if the writes are from the reftable code).  I think at least some
versions of JGit use 64 KiB for various reasons.

As the documentation describes, there may be some performance penalties
during reads since more refs will have to be read, so reading a single
ref will likely be more expensive.  However, you may find that
acceptable and you can adjust the values such that they provide the
right balance in your environment.  I would definitely recommend a
power-of-two block size, though.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--EjTjoGzBJgZqMwZ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaFM9UQAKCRB8DEliiIei
gRoJAP97FpPo+Dw2ciDR0pl66PVQo616lZmnX0kaKuP4tiILjQEA+MR5VcptFzGN
ulPDblRNJHMo09O0pTK8RhkBzsO8rAs=
=ISqD
-----END PGP SIGNATURE-----

--EjTjoGzBJgZqMwZ3--
