Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477242343B6
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250682; cv=none; b=KuWII7XrMrxuaORgRZBIxq7RJpzocbZSiLpAEl3jbf+udBRqYgZwjkL9bTevvjkamyZshJyG0j8/MSXWKypkPzstTfWsiugAEquXRYhFUmWRAoK3TIF/2agwESiRHQuuW2xnWEjo4X2ZcRrgHs7jfJefWhvnV7g75zcxTzI2m5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250682; c=relaxed/simple;
	bh=OvO/t+C48qltjwGraftbXUrl+00WSn35r7ThJjjPsTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhXEG9G5I5FBaiqeqnLtiV7O43tVL2kyzzf2edDsIjdfiCjWeRhIhvubBqkQg/wehmvPCuwJ0352j8uFK30mjo0tvuyKey2GoGgnhOPZ+x6INDouQ+ACRTp990ESutE8fnDyjW6ESYEDqdaAW9go30pxHos/V4gWXEzVU1DfUkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=cFneuGF/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cFneuGF/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759250679;
	bh=OvO/t+C48qltjwGraftbXUrl+00WSn35r7ThJjjPsTI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=cFneuGF/WnPPhcIkxmvMAP+0IhJ7zS5klJL3D2EUl/mC96RJrHad16VtLOAVt4Amx
	 c9u2B+YJN5WsnAbpIKuMDzSe+LXk4wCgfhO3wRqE8N9WeL1CcWFt9XRThwNBZskkU/
	 OVYlc8B0tEAFzkaWL3NC0AiFuaY6exQNepjstozNsHWtvLJuw273LCCNxbwqjiQ61N
	 7e/bz3U7tB6u7ldAcJsEVfLixPs0Jv/+qOVpZiDhd6nQ/Oy7ZdBLla9saMSUPvoqJc
	 Ll9hO8ZuK39zxDASpJFY6GYrvIv5+OPrUSNNN6+IrwCyj4Mqbzt1lVuRGCQw3ohX12
	 vvnWdGPTp3o2XqC8HkLNcI3uPta6LX9vq6edTexlLuKiKMLA+yx96UYtqmWqls9PIu
	 aIjUVlEhbvGSB+Kp9pBGQY6Zx7+fopGvtBQEdt4EPtuenNtan04z9Tn+f3GlSvD+I2
	 bxh1u3JQPjm8N26vfktHPA8GdXhlM1YxJmTACj4UzzIEWh4KUaY
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3c0c:de88:5b0d:9364])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5442820119;
	Tue, 30 Sep 2025 16:44:39 +0000 (UTC)
Date: Tue, 30 Sep 2025 16:44:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 8/9] Allow specifying compatibility hash
Message-ID: <aNwI9gLAGp7QvpI4@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20250919010911.649831-9-sandals@crustytoothpaste.net>
 <aNOkEVUag91bv2RP@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LsBEjlH3bDVu3/mV"
Content-Disposition: inline
In-Reply-To: <aNOkEVUag91bv2RP@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--LsBEjlH3bDVu3/mV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-24 at 07:56:01, Patrick Steinhardt wrote:
> Makes sense, I guess. It's a bit hard to judge without seeing any actual
> tests, but I don't think that should hold off adding the infrastructure.
> Worst case we can still adjust it at later point in time.

I'll send in an example test as part of v2.

> >  '
> > +# BROKEN_OBJECTS is a test if we can write deliberately broken objects=
 and
>=20
> s/if/whether/

Fixed in v2.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--LsBEjlH3bDVu3/mV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaNwI9gAKCRB8DEliiIei
gVF/AQDiZMnRVbJMZ8eZ0/30z6dhwVdUZumBN8UOmjOecw0b9QD/QF62LrsW6gEr
X7zH5A8tMajR1lBP3Y9Z911AX2FTMwo=
=ImeN
-----END PGP SIGNATURE-----

--LsBEjlH3bDVu3/mV--
