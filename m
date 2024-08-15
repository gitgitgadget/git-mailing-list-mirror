Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C59814EC56
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756927; cv=none; b=pGf+xJ9oTIeRHEEnQOTXuAWEMjXLgDZhDCwLy/BIZdPRsL6lPGyAOyYNSAddubCniQUmGsZrQDwLsWTwTagCqqd8NBZpf2ex3gB4/VYfTxuiPOmh0MZoyJZifkmOBIthkcOdEYEZ21HYtlGkQ0XxG6M2Eby79gXnif9MVE2FTy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756927; c=relaxed/simple;
	bh=29QZw5cYwTjVJ9o8x8i2Kr1dFL33ugEKBk8iWaftfrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXjjSEWMh0T+NB3kyffJbv45eEbIt47Fwa9b0BLsVi1bdB1oNR3+0AcnyIECxvEYU094LHowxhY0tUdhdcrhPykYWK98CJ0qIy8YCeA8hdBedAAAiHgfnOWnbuC9vhiSsKKjC6Yk7T4fSMQPKM2FDsyq73p+veAYiWamtVIgxxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=dTqArMuh; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dTqArMuh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1723756924;
	bh=29QZw5cYwTjVJ9o8x8i2Kr1dFL33ugEKBk8iWaftfrQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=dTqArMuhXYO4yGZdGZSrtO4Iie65jJeDE9E0YLBDmATvndcHlSOzhxUJ7OkgSB+JB
	 JRZK1Vth/+lc0A8P0Knxgy5034swVxX/PNbzA0gxA5MWhf6blpZ/IkbWSz0qzFB3tn
	 l71gjwjieIeHGOlHj2VNLsmJCH5rQXaUd/RSZHYPoa6GNHOM2WDEFEcUyzwclntZws
	 QKGlgdTmr8IudDEJ6S8mefNOnIKApIXsDP6oFGY2sPbZDcV09xmLxBeOf/f4grmawy
	 ktxm+CANvNhSxpHRpMIBm9n5pGY+9DEPwg5BxfTIsYm47U3TmkRp5hqOqTl7EtSzf+
	 kulEtwLnu1JKJN3YiV9PHe4ZyMbobwwDSjTk7Ri6Yl1YUnZ4uuTNZRCRyHPS4kRUFE
	 YQ7ju3kFvVHc4fJA8MK7uHH37nbcAQrVapHp+fM3kZnvOsb27MVZW9Rh1e7AW60ONB
	 ARR8whIzPRC0zxe4rWqf+DyqbF1jHYHS1xeveEK2k6UwTkxea3/
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3A0AD209C8;
	Thu, 15 Aug 2024 21:22:04 +0000 (UTC)
Date: Thu, 15 Aug 2024 21:22:01 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 0/5] Introduce configs for default repo format
Message-ID: <Zr5xeURcnoqcZsEg@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>
References: <cover.1723708417.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="omJOekSNLqybk+AF"
Content-Disposition: inline
In-Reply-To: <cover.1723708417.git.ps@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--omJOekSNLqybk+AF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-15 at 07:59:54, Patrick Steinhardt wrote:
> Hi,
>=20
> to set up the default object and ref storage formats, users have to set
> up some environment variables. This is somewhat unwieldy and not really
> in line with how a user typically expects to configure Git, namely by
> using the config system. It makes it harder than necessary to globally
> default to the different formats and requires the user to munge with
> files like `.profile` to persist that setting. Needless to say, this is
> a bit of an awkward user experience.
>=20
> This patch series thus introduces two new configs to set the default
> object hash and ref storage format for newly created repositories. Like
> this, folks can simply use the global- or system-level config to adapt
> to their needs. This also has the advantage of giving them the ability
> to adapt the default formats via guarded includes, such that e.g. repos
> in some filesystem hierarchy use format A, whereas others use format B.

I like the idea of this series, which I think is a much nicer way to set
these defaults and can also correctly apply to existing terminal
windows.  As you mentioned, this also allows different configurations
per directory, and it makes it easier if you need to have a system-wide
policy for whatever reason.

I've taken a look at the patches and they seem fine to me.  Thanks for
sending them.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--omJOekSNLqybk+AF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZr5xeQAKCRB8DEliiIei
gdjAAQDRXLep/vBRHClph4HsoKAhkqBZnYCjyKwTebWefL2jfwEA3Y6OUw742f5t
vLnsJVXmGQjFS2ebV7EWMIvKzmfpeQw=
=U3SN
-----END PGP SIGNATURE-----

--omJOekSNLqybk+AF--
