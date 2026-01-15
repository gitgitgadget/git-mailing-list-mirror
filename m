Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8718322B72
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768518660; cv=none; b=urATS+L9T6LbwD2sRu054nUjp70AmLw0g2TcMx8eXzEPHR1Mls+s7JlIzMV+ScmrNUxBTPaMgdQCCFVMEqmQVe3RLWZtKTzUSch141fYm7Bdu5rN5jJrRRFpxg4eMAADLBLa6nh6fnlz5MtRB3c7QeNQIDMCF30QXF2hnx76xFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768518660; c=relaxed/simple;
	bh=rEF//U+tmgyCYZ29/YVgB2oozitxO4LD1ajZbiaN54M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwhAxwAvJyNQa+kJ2UvJvriVpdWj15B5P4AXYzVZa0csBb3tr7HLRGlc8p53NQb95zju1uxfrygVOE7rIv9DCu1kqB/RE61+jm1WJFCPuHLRRJ4QpxAJFsBgIqGTZGuF77WO23W1VL908H+Hk+/ngW4x3Afj8/9iy0DBvSOC20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Fe6BrDkE; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Fe6BrDkE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1768518652;
	bh=rEF//U+tmgyCYZ29/YVgB2oozitxO4LD1ajZbiaN54M=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Fe6BrDkEIoT4LAJt60vr0gGCSbCKsAEl6e95oTOQP1Yo2SUFEWPJFDGk7aImLzqrK
	 InmaCGG5k3WCTVO3SkVG22m1isQPYxjQhzbMla9wAWJiDaEN8SvifrXHngkmQs8ZKC
	 qx4eOV1FMoFmqmbnBqJ9T7cDS2kN7Xq/HAfqaTlIVyt1SPxwI0qZUjTpzRAZMiVPoh
	 AoxxgJ8THJ4b2s62TJWzZdWBwKBZ+qxqSegVVYPC254yl4JmZOCfOceDWgJWfZyLNG
	 ptp8yiuOPyJlYPqTqA6vAn4Yo9LE1lE/8xQQ6tOAgPJ596Skq8eSJ4dgc9ch1T1gMx
	 LJK8DVdoXugxWYLDQUtBOOrfDPYWTgONNfbWF90VGNjo40rEwH8yq2yRhnGJSCkLvq
	 Y0yQ46byqEtPFS9PTWQPfjlMl42OKuAbEixjZyqfmBVv0+GdIEv5a7AVh2PMFYT6Ut
	 yzGTMETG8nhObGMOkG75NW3kyamsEy4CeaVmGVn/TeYK8dIIj2F
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d124:1890:72d:aada])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 50EA92006D;
	Thu, 15 Jan 2026 23:10:52 +0000 (UTC)
Date: Thu, 15 Jan 2026 23:10:51 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
Message-ID: <aWlz-0AOlsFLaBO9@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
 <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
 <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
 <aWD2x154F5f-c3pL@pks.im>
 <aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
 <20260115211448.GF1053259@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gem9hCRvZG83uKO8"
Content-Disposition: inline
In-Reply-To: <20260115211448.GF1053259@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--gem9hCRvZG83uKO8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-15 at 21:14:48, Jeff King wrote:
> Is there any reason we cannot introduce the new functionality as a
> config option but _not_ enable it by default?
>=20
> That gives people the tools to protect themselves if they want to bear
> the potential cost. It just feels a shame to deny them the tool because
> we can't agree on the default.

Yes, I think that would be a fine and reasonable approach.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--gem9hCRvZG83uKO8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaWlz+wAKCRB8DEliiIei
gYBUAQCrFAByTUsuTS4r6mMzLT1RgiGc5mGlZnkrIls4WYafGgEAxjh/KUO5loyq
s+mIxICNVJHtTPDXEtCtxCKxcL9ExAY=
=7wy6
-----END PGP SIGNATURE-----

--gem9hCRvZG83uKO8--
