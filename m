Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B118145A05
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765408224; cv=none; b=JHvcrlpTYocnDb6XgHR4bg96VvykxwGL/LGdujKABdHBYKF376SlS4qKG1pdiQWEgGHdAysoC1NPQlGm9iJPZLV7QDz7TTe0mo5lpD1W4YatQlUa9szFlxcaIn1dIX8nvuit96W0VM/5stKtrtd9o9g8szxhKWxWmJMEiTAsJ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765408224; c=relaxed/simple;
	bh=rqqqYozNTfvcoIoXCTcc4WI7D4yE1xpm+fQEgvM/ego=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IglevqkGg4sAoWaUWPjL/3hUuuckB/zBZCY0aIwDFwDMEvqXal3GFrW9CtLJlwts9Ph7oB07uNVj6h1cAg9JW6vztPu2fBTm6jr7DX8HD/YDQcY2mJrBb1bWzlTt+fl5ZaEtxSegSQdJZm7zDTXnl9RkLaeQTgIxJj1doCewYFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=cF1oPZVE; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cF1oPZVE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1765408221;
	bh=rqqqYozNTfvcoIoXCTcc4WI7D4yE1xpm+fQEgvM/ego=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=cF1oPZVEVB8eOk6pvMSmUS8hxrwGcjKoqriWkAVLGMWXJo4uPAZYlaPb/uB0y69n8
	 PLAL5Un0/VIecOlEZJeyISSHjP+beXwxIiJO6QpiIL67Fzkpz7sLxgCOqVxdxTWMPc
	 4O7VFXVWF8TX3FUt10H1z4FSxni4r7EUFX44n4X0ERBarLoXvD0t7Keg375byWUads
	 Itvg0dnDd6i2rFWoGWhqTe4xJiEpuQoJ1ruzdWz/a/T/+S1thdT/Q+lrmyIJ2sG+F0
	 oZ9EpCm2iVHsZXo4Qn+ujoj1rSKabOH1l7V0zpL7oYhbKeZVlZ34o29UfW78FH+T1Z
	 OeIMC0OSCTE2vRNIckHusr0gfLKlLUU6EfVGXdaTBOkfSUVkSJDnFAg626LdJiZF+W
	 FJwCYcyy8JXaohnWwa9BMxhBFMNwYXClcOm6ojMl94BIg95Gq1gkNgy4Zl9Xosaxqg
	 GPgLBDahy5UV1a9fI//ZBtiEbW+aPgk/Dx9Qby+EiKVvflLYgH/
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:8938:8011:d856:6a36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 04AAC200C2;
	Wed, 10 Dec 2025 23:10:21 +0000 (UTC)
Date: Wed, 10 Dec 2025 23:10:19 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
Message-ID: <aTn92yqtSDyVoLgh@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Koji Nakamaru <koji.nakamaru@gree.net>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XU8if50VMrVjOIN7"
Content-Disposition: inline
In-Reply-To: <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--XU8if50VMrVjOIN7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-12-09 at 19:35:34, Ren=C3=A9 Scharfe wrote:
> The library function iconv(3) supplied with macOS versions 15.7.2
> (Sequoia) and 26.1 (Tahoe) is unreliable when doing conversions from
> ISO-2022-JP to UTF-8 in multiple steps; t3900 reports this breakage:
>=20
>   not ok 17 - ISO-2022-JP should be shown in UTF-8 now
>   not ok 25 - ISO-2022-JP should be shown in UTF-8 now
>   not ok 38 - commit --fixup into ISO-2022-JP from UTF-8
>=20
> As a workaround, use libiconv from Homebrew, if available.

I like this solution, since it means when Apple ships their own Git
(which doesn't use Homebrew), they will be incentivized to fix the
problem since the test fails.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--XU8if50VMrVjOIN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaTn92wAKCRB8DEliiIei
gQyyAQCedoTKL7Pc933uuSZtGwgGFmf+m9mceF7rvjhAs1yuNwEAvTw94Jtvb6fQ
TM/gRv8a1oOLxAn9A+LEvTs/z3klFgw=
=sZ73
-----END PGP SIGNATURE-----

--XU8if50VMrVjOIN7--
