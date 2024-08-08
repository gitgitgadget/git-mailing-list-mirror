Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4FE1C32
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 01:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723080808; cv=none; b=DACFUeQVKox1iatj8G2AhkHCBdGamMbdjSY9aUgc1vTjF7K0gY4HZPbtRG1NLoUdoBShkFg7wnXf+CEo/hWK3lhlAJYg4UPedg4Rs5lJwuiE41JIdggXRQ48q3mDCxsfbEyh0jC1QvZ+UUt+hOD2e1nk0GnCNfDPSt9KZya7uPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723080808; c=relaxed/simple;
	bh=6XWki/GZOGBfJnYQ8ek5sW3lfMwraTtGUMhnY/0CQZo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YF4kRoBaHHwOzZFIr9qflA8OqP+q9a7QvrmiWlwktl+OnbkKedbq5deyJmn5Ro/qBGM7U4cUAKHSmlwUT0/71e0QWIGZ1D2jfm+GHGclNwi9rBeQ56GsCZy7ngA16lkxB4BXX0SnSohg9EYIB8KovyklbW+UQFMiUIm0NvOXxlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=xVISLTqi; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xVISLTqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1723080804;
	bh=6XWki/GZOGBfJnYQ8ek5sW3lfMwraTtGUMhnY/0CQZo=;
	h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
	 In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=xVISLTqiBNSHpuK4s872abP9rpvLtP2pF3QxsIAKSlY98sozhhlTyrfo/OdgX+rnJ
	 Jmcgvu8PCWzIdUOnPv5WvCvWb4zVWd5gl5+zUkMXqBjyagbd7wi2pcGlmMvjmtBsuj
	 xMOKFpQbrMwvhpQ3XvV+u5zwhf1kkZpkePXg4Q+9GfqWxkVL27QDtNSrTR2IdsfCQt
	 YcEg2G0diH4cAyg+L157zijJ4WwFXtisuitYLF8QR2D/EDxD41S7Udz2BCiE+zmri9
	 5uFojD+ifNwhw3dhVUyN9OrlmasJIpMSP02Pg7XxcooNqCc6U/gL48Qkun8OfCqGeT
	 zxJCW9DjcNJsJAn3W+omRiNFP3DUzTcVvfCjJjNvx/8GUHD4F5LKIxwMEqBPgQoDsh
	 NJh/nM2jP4VND+SGpofDzdTjYyvA8GalHFW6f+HsZYesbVyXRoyfceS33ZkrYf4Z1W
	 /WtTv+qMjjPM2l5CTmgpgRlvYoucNMSEg3MqnpRVWRBVbHnDozV
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id AE70C209C0;
	Thu,  8 Aug 2024 01:33:24 +0000 (UTC)
Date: Thu, 8 Aug 2024 01:33:23 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 0/6] [RFC] Introduce cgit-rs, a Rust wrapper around
 libgit.a
Message-ID: <ZrQgY1pehCH5O78w@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <ZrPvSWoUOEaUIjWq@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NOVQ9FmxZSLmnd4U"
Content-Disposition: inline
In-Reply-To: <ZrPvSWoUOEaUIjWq@tapette.crustytoothpaste.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--NOVQ9FmxZSLmnd4U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-07 at 22:03:53, brian m. carlson wrote:
> I left some comments in the series.  I think this is a nice first step
> as a proof of concept, and I'm very pleased to see it.

I noticed a couple of other things.  First, the code has not been run
through rustfmt.  I think it would be helpful for us to do that since it
makes it easier to not argue about style and it can be easily enforced
in CI.  It will also reduce diff noise, which I expect Junio will
appreciate.

Second, cargo clippy complains about some of the code.  It's again
helpful if we can fix those warnings or, if they're not appropriate, to
disable them with an appropriate `allow` pragma.  (In this case, I think
they're both spot on, but I have seen some cases where I've disabled a
warning.)  This is something we may also want to test in CI in the
future, and downstream users of our crate will appreciate not getting
warnings when using clippy themselves, so we should be kind to them.

I noticed these because my editor complains about the latter and I have
now intuited enough of rustfmt's output that I can tell sometimes when
things aren't formatted with it.

For those members of the list who are less familiar with Rust, rustfmt
is the standard code formatter (and formatting verifier) and clippy is a
lint tool recommending best practices.  Both are shipped with Rust and
using both is customary for Rust projects.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--NOVQ9FmxZSLmnd4U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZrQgYgAKCRB8DEliiIei
gQUBAQDPYE/Kqh1yG/PYBrd7HiUHNzgDjp0LjjB/X0zf00TmWQD8CiBfvu8g87qK
by+UcyuriZNSHHXX1GTmhXZIRlr4hgw=
=XioJ
-----END PGP SIGNATURE-----

--NOVQ9FmxZSLmnd4U--
