Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376B52D2483
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263849; cv=none; b=VIchvUsSt4CMPe5jGo5x/FIWw9vQUAwR2rOn9VX7ZgvURoL5y7bDMJzDkyA+in59SIXgggGPO7DNKL1qxrIsCHKlFQpZ5U9LREfhXjWVrY5uUNGskO89oLE7ddxakWTI2//KLSu/lgZGMTh3wHntS2N2NMrB7B9Ob4Buz1YVMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263849; c=relaxed/simple;
	bh=6/zjyT3IFgSKN/Zg+Qt732VRsiwHwL2a/R/7yid68W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZX9OH9vHEeajns1Ov2oy6EY5be7hix0w3tsAA7jBuyCzqpUt0GfzpIqpWchW6GRt3Xkt7k9m5dRAnM6Hbyysha2HRw8WFNwRYS1Xnj+4D7tBSt3Gj2lBOvVELlIjzpfOgZAaIEzF+CM4B7l8qvp2rB27jNvl38hPE20VBWzgihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=RZ577Xoq; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="RZ577Xoq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1773263847;
	bh=6/zjyT3IFgSKN/Zg+Qt732VRsiwHwL2a/R/7yid68W8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=RZ577XoqKjUmO6Zrk+dSH3btAVEpPYEYER4iPgSJPfPfB8e/dhD8wHw1gx1Vo+jAL
	 TspTCgeINk9eJ3wpzEDlekpl20449+3cQ78hOspQL5YcAkbbtKZd/OE253EcbT0zfI
	 Ea/UKyD8YySYEmPH62ioM9/rIIowkovv34SINQqAGJRvK+xtlrzIPuQXuyf/+EY1VL
	 mY4c9fQEfyA3mGe5nFOmyD9JyEbPV9IYzPIyBIcGldfCQIrJdPKbI/siIRHIRR10IU
	 wWWZjky7U2PwxhSXtkfgyO82ZLJ3WsAmEZovm/YMwXljoE1/uy77xEupQ38SaLr+GX
	 homU89grPWXch0SV3asHyoHASxC0hgwhy/kKxjTK26AzLmyjK35UZC3337ZU/f/NKL
	 xblauyvZZ4bdZOEXrPxLj4CoZGfYbqnd75e1ymx3cWZ5S4gnJftjvwgNgOT/G+8QyX
	 PgAy3BCv7vTj7Kne5Ky4zjVXvEq9mn/bfNUzEdHSsuQFBkywHRC
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:1cc6:4e25:b9fd:13bc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 83E1220107;
	Wed, 11 Mar 2026 21:17:27 +0000 (UTC)
Date: Wed, 11 Mar 2026 21:17:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t3200: replace hardcoded null OID with $ZERO_OID
Message-ID: <abHb5k4otqTSgPb8@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Siddharth Shrimali <r.siddharth.shrimali@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
References: <abFP9vZOVHGI536G@pks.im>
 <20260311174120.76871-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q+/3Gym/lECGJO8n"
Content-Disposition: inline
In-Reply-To: <20260311174120.76871-1-r.siddharth.shrimali@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--q+/3Gym/lECGJO8n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-11 at 17:41:20, Siddharth Shrimali wrote:
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index c58e505c43..e7829c2c4b 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1494,7 +1494,8 @@ test_expect_success 'refuse --edit-description on u=
nborn branch for now' '
>  '
> =20
>  test_expect_success '--merged catches invalid object names' '
> -	test_must_fail git branch --merged 000000000000000000000000000000000000=
0000
> +	test_must_fail git branch --merged $ZERO_OID 2>err &&
> +	test_grep "must point to a commit" err
>  '

Yeah, this seems reasonable.  It's failing, but for the wrong reasons,
so checking the error message in addition to switching to `$ZERO_OID`
seems like the right thing to do.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--q+/3Gym/lECGJO8n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.9 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCabHb5gAKCRB8DEliiIei
gTVoAP40nvdCtJHoXo+RvRUA/O+V6YbJvVf+rLXNGzZdbwwleAD8Cgi38GnswzUX
3jyILTMCOprAWoc4+Q7jxuI6hS0PHAk=
=kET1
-----END PGP SIGNATURE-----

--q+/3Gym/lECGJO8n--
