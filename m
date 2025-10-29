Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D047F221726
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698021; cv=none; b=OS/lxzXnC3wBHvy8OfDz/hjMqHAEsrHY1kNK8KYvrXjiLtnK7YVRhfeRmqUj2+VhC5uOdimTQ4pcm3skuR7q+LK6tYYyVj5XCsdMSTRpkB6cDBdAhpzyHJP6QrzyB851h8q/XbLYk6pH9TU3oyzQZOFVykLUSCjPxxkNGam716c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698021; c=relaxed/simple;
	bh=b7in75P49+gVvJ3GLntW8qrbU/NQv3nLtb8YrrNO0+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9Zo9RRFKVvQfoZCpSOd9+vUpdBE56tdJg0HxpT5OUs3i1L6TfksLZ8zIT0as8tURErsBRUSKXQOr6ABxGNNcHMXnfuF9MbiaH1ziC4FQ2qJpRSZtEEut4iG4tV48EswQ/dIYaUd6JN9TbdR7pOYB+xj1SQcIklcQX1zMy8xQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=iFICIs5H; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="iFICIs5H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761698011;
	bh=b7in75P49+gVvJ3GLntW8qrbU/NQv3nLtb8YrrNO0+o=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=iFICIs5Hf7gBPw071h50ZIrsGKR2KgLuoiVqN0Paojt2HFyWiNuYEy2jnZBJqKcJp
	 aU+7HR6Sups7MnDAreF25UEU1kNX/zR3ft7JVneRIUiDSGQ5GbYXPq+lJX2kS8Sk70
	 F9jzDW31VjMTuRsOtgNBA09zInE6u2fF6gLAhROUI30QhMKEO42JiPD+KWEpIBDJG+
	 zuW4U8pHRsN+pO6an2Lo9tnIWNwTcoQ+nnHJvFTgHczHLEs/M5qd3Lfc/NbnBZVEzs
	 iwowvKraRYT3XxEc8ni7ShZXdqR25QYjk6xRzetJ7ARgzEJcw0dyWXYfRj18hyN8tI
	 O61mEMnGLlA94e21TcT0v0NhYvOEPXaklUutz+eWlii783/3+NW/MUR0XwUaURhbPY
	 h/xDkoYKqScLI0EhkS7/+aj1mCq+I8ASdnO9hNgGswetDNJJiix0n6l3VA39ii3ztj
	 s1X6etehqmfKChJwZXzWpDfBMk9mAAmJ/W+ZFW89fDNI3YqpWiL
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9578:8587:8ed:424b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D665320036;
	Wed, 29 Oct 2025 00:33:31 +0000 (UTC)
Date: Wed, 29 Oct 2025 00:33:30 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 03/14] hash: use uint32_t for object_id algorithm
Message-ID: <aQFg2tvS6Wf7WGd4@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-4-sandals@crustytoothpaste.net>
 <aQCKCfuaEKBArD-g@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wWwqJkQMaKQkZHPW"
Content-Disposition: inline
In-Reply-To: <aQCKCfuaEKBArD-g@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--wWwqJkQMaKQkZHPW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-28 at 09:16:57, Patrick Steinhardt wrote:
> An alternative would be to introduce an enum and set up bindgen so that
> we can pull this enum into Rust. I'd personally favor that over using an
> uint32_t as it conveys way more meaning. Have you considered this?

That would lead to problems because we zero-initialize some object IDs
(and you see later in the series what problems that causes) and that
will absolutely not work in Rust, since setting an enum to an invalid
value is undefined behaviour.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--wWwqJkQMaKQkZHPW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaQFg2QAKCRB8DEliiIei
gXq3APwOTpg13fDmEYcpJdmCXYCK9MeTb9xOHJPryN59ZvHAnwEA5Gaixy13cvXQ
EFHCSwMkv19dygxXmKSnUszSi73nhwM=
=qDQA
-----END PGP SIGNATURE-----

--wWwqJkQMaKQkZHPW--
