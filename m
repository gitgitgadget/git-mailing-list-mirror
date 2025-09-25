Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D55D322DA6
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836429; cv=none; b=YHluMBTjy4Y7bhGg9cpk/VNAK19omFojOJBskOgEpMB8sK5HJFUwui1SUVTeHhBOYu6zkRQ8Wfc9bUu3eABNeXeeDV9NvVmK/qjK809JuC8LwMCmptnNRSdep472BIDnlIb5lOJtBjD/ts3pj56CcYtEqDEdd0/EPv8wXLZjuRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836429; c=relaxed/simple;
	bh=bd1y3BxjM+3lFqyT5iuWb5pv6fHutci01tuQPXyl7fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Al4oJ7+D95TXj3WsaQfXXs/9i/IOeKv5cVG1wS/Gu6dfkgX3p5rLlbL7bwi0Y4A+60o6nix9WUoM5Z22TT39tZyVy7EXzOV2rxMua5C21/PKcANlJCGNU4ZEFvhE4NSVuKwMtMidGRP3M0FIiviedRezPfjIXgNoaIv3kJ2yYAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=tmXX4ZcJ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tmXX4ZcJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758836426;
	bh=bd1y3BxjM+3lFqyT5iuWb5pv6fHutci01tuQPXyl7fs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=tmXX4ZcJT8DP1ZMwcvpquMSfWy1PWPlyiSPXuhUsjnzfs0d8CaSg/hJnVF9alfV8V
	 Dd8Jf2PTN6u/ry/9yB6Bxa+/D3X3CpWJsW+cRM3wX+BmINDVMaXKW1FCXziHFMrb/6
	 d0p/YMvBEzXzkRGqRweR7leOEo4cHOP1qKy3ah/ctxL2qpvGf1kUcO5EbqfhDq4zA0
	 emSPTr2CERUp4xFVNziXBQnX1d35M6T6QCPd7cQ53hV4sABjlepl0lT3R8P5bvelVo
	 7vwcx1Iy2kc+Xsy2iiDMCYN79cpM3fHYszOG4WFRg+ho/rh+j7F+N09hMWjT91E6Ff
	 +5kZKVntM+4TUw/dVXX6aode/T5YBrTYHMbaC+BZOuTLdiYW/XRjlzBT1tytnFEzwn
	 vPNWExXJ+161pvOYQtf2GVgf8/Ri44bB32DvvHjRETiz04aJ00rbBMK1lqSs9OwLVS
	 WDOZyCC0WzAtAZHa3M/a1gyH1cEU/RSo548wV1Jw5q2dt34EJT3
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:916c:9d5f:e4b:808d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A817620107;
	Thu, 25 Sep 2025 21:40:26 +0000 (UTC)
Date: Thu, 25 Sep 2025 21:40:25 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 5/9] docs: add documentation for loose objects
Message-ID: <aNW2yds9UFFpntQr@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20250919010911.649831-6-sandals@crustytoothpaste.net>
 <xmqqv7le45t3.fsf@gitster.g>
 <xmqqms6q45nl.fsf@gitster.g>
 <aNOkAYsqavZjnYSO@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LIMg3oFXpDPxox2o"
Content-Disposition: inline
In-Reply-To: <aNOkAYsqavZjnYSO@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--LIMg3oFXpDPxox2o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-24 at 07:55:45, Patrick Steinhardt wrote:
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 6fb83d0c6e..e1d38fbfe6 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -34,6 +34,7 @@ MAN5_TXT +=3D gitformat-bundle.adoc
>  MAN5_TXT +=3D gitformat-chunk.adoc
>  MAN5_TXT +=3D gitformat-commit-graph.adoc
>  MAN5_TXT +=3D gitformat-index.adoc
> +MAN5_TXT +=3D gitformat-loose.adoc
>  MAN5_TXT +=3D gitformat-pack.adoc
>  MAN5_TXT +=3D gitformat-signature.adoc
>  MAN5_TXT +=3D githooks.adoc
> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index 41f43e0336..64f70ac724 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -172,6 +172,7 @@ manpages =3D {
>    'gitformat-chunk.adoc' : 5,
>    'gitformat-commit-graph.adoc' : 5,
>    'gitformat-index.adoc' : 5,
> +  'gitformat-loose.adoc' : 5,
>    'gitformat-pack.adoc' : 5,
>    'gitformat-signature.adoc' : 5,
>    'githooks.adoc' : 5,

I've got these already fixed up for v2.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--LIMg3oFXpDPxox2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaNW2yQAKCRB8DEliiIei
gUT7APoClk8vkgObhetk+RZdI/HWxg4hU9uiY5xP+x9try+q7QEA23gNxvgIUaKJ
CzOMsOLNS4FMm8vi6hPHL9q5C4V9jAI=
=Nu2G
-----END PGP SIGNATURE-----

--LIMg3oFXpDPxox2o--
