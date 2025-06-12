Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A62182
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749687293; cv=none; b=bJ6Dz56PL+rEHsEbl3k7n6oPN7M5AiCSUiic3rZ6f/rX8ocC6R0akNe0BOSqnPq/CTNV0kdFrEGrgo79ROUoveaYe2eRI+VBqVkw8JSKBV0x/ONsvcPSIpObrlT5o/I/+bYXne6ynoy7TGyd039GmGosfTuHclQ4oUFvX6Lvtec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749687293; c=relaxed/simple;
	bh=L5LpGTJ+4Aa+aZurJLMIOhgsLnW/ct/wTKhAlYE+CQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xz7UZA1zu5maQTHUJj48tUTNQtmo7KulfeZnAhdx4F1cV+ILRuYamO/ZoYT5SQy1egZI64Nw609fv888RNAwobluMAJ5XmjPGBv8bFUgmcgF8CTqYNR/t3cIUkITOBj0qpVNd2fPxhonqCeBItP3exqhAnjFt4NA8Qq51PSe7pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=vCTqxhYb; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vCTqxhYb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1749687289;
	bh=L5LpGTJ+4Aa+aZurJLMIOhgsLnW/ct/wTKhAlYE+CQw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=vCTqxhYbG0aD2sOW7tyfHJlv95NKakhmvJM/n0pOnSVVzngbAkrvMEnlDVitablyw
	 wvWUUXQGDnS3aMhoG8eNgkIHdZ7IJWVRukIrSdDvEMMFfptNWCRflkIrvvG8lZ1jFK
	 HppR9hZVW0rcvU988mStwdFMb7kOEMuQnw0SyaMrTpGvPsP/uBBn1sIqyHY8LyRh4r
	 nlVCYxfl3wBxpTSFdkoDBK8e07mU+9waPNUTpvWRAzjc+x9Kr7Ih8pnBHg8QHA1x/1
	 kTreIoHX/DZ75OqQ3nXFViBxDnwpNi6NaaUDGsj/5h6rIJIsDkPtgKlOkXjrW4xsMN
	 zY/L7g4IOcsrsukNL1cK8kOc5LRSaOIt1X2WDsjTJ/ml8Wo31tiWz/qccPJz7+YPxC
	 reVG2S/ieX79lL5yh6dfhujBUh9RJYTogI8FgTquIAZe0UaIVEOXH/GSB+URO6xpUK
	 YbdYHUBmwH9Txmrae2/dudkKDbQgeIZMmERjmAIw9fLKtEpkIZy
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C5E162008A;
	Thu, 12 Jun 2025 00:14:49 +0000 (UTC)
Date: Thu, 12 Jun 2025 00:14:48 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/6] bswap.h: Always overwrite ntohl/ ntohll macros
Message-ID: <aEob-FXAvc2Wqmlr@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	git@vger.kernel.org
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
 <20250611221444.1567638-5-sebastian@breakpoint.cc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CgjfBfEHPNps1adF"
Content-Disposition: inline
In-Reply-To: <20250611221444.1567638-5-sebastian@breakpoint.cc>
User-Agent: Mutt/2.2.13 (2024-03-09)


--CgjfBfEHPNps1adF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-11 at 22:14:40, Sebastian Andrzej Siewior wrote:
> The ntohl and htonl macros are redefined because the provided macros were
> not always optimal. Sometimes it was a function call, sometimes it was a
> macro which did the shifting. Using the 'bswap' opcode on x86 provides
> probably better performance than performing the shifting.

I believe that the peephole optimizer will almost always optimize them
to the bswap or equivalent opcode, much like it recognizes how to
generate rotate opcodes from two shifts and an or, so they should
actually be equivalent.

GCC and clang both emit simple bswap instructions with `-O2`, which is
the optimization level we use: https://godbolt.org/z/1r8P1Pqo7.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--CgjfBfEHPNps1adF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaEob9wAKCRB8DEliiIei
gSuhAQCmnjJIUGLJJnABIGwpogDvM9FglVrVGfQTs1ZCoTvNHQEA6xGjB7PpNiJg
/cJH7DSt1x1gR/wd4hLCgZ5cc6bOFA0=
=nWW+
-----END PGP SIGNATURE-----

--CgjfBfEHPNps1adF--
