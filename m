Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42329E0EB
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188927; cv=none; b=AD9OyVPMounUDw0vygu5lWeLIObWtBWO6ty6LWkEwK4SGiAzGtz4KHCRtnesK1e5KK2KLiCv6mwY1qWJl+/KYhzErDlFML2sRxbzIcZuG72G6R+Z00uZN0nR7btog1VNN2tuDqvXBjl4to98xYnAveg22ATkW8r/bV55aksW4mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188927; c=relaxed/simple;
	bh=a3lr3Le/ve1amFyb54NQKv9YstWkn+Ul731fYzF/2hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsIhIfbHVDgseFt2gmVt7nN7LejmLMH5mTwotiiXirzS5iKWJ9TajXlBRbLxEGVUo8uIUubWU1hh2MLLw/z4M9V9wICkoi6PCFZsctbac46rZkEUPYyx21DqyDStSN3anlFF/evN48VqlVGostDWrAdVwfmAPmmdwv98kJt0w6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=macIoEWc; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="macIoEWc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752188925;
	bh=a3lr3Le/ve1amFyb54NQKv9YstWkn+Ul731fYzF/2hc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=macIoEWc6JW4nLnbMbzdco7YrQ2v1++JFOJTQqt8Uo9ZUrUeKD34AU84cqMQ3Vl85
	 qcHoEp8qAUL/0V/1FMdEhMKxwc/5uTa5voEGAF+SY21VOKyA1Z8wHxp9gF16RAapW7
	 YZoohWt+K6NJ3m9kapYhNhqNbC2W/ALa+4d/O1PxJcNXj6F1TeIfTdAXC4ueS/Mvqa
	 pJKVw6Vu08rpdbdWezGIRelUJsQYKUjuVpeeCdbpHtTZ4Ti1shWU9ycUQ0uHkx45qD
	 Pm5TlfjmRITZrkXGXdsH2YOh7Lyi9Lvd5Pyu/Q9ZQBHN011RYnoMl2NH/dqvXYslej
	 gCqyQk2yqqa3tKDOR5IJxx3gqnBv2M8FmTTLSrAv+HoMuzzQvDH1NKCM5WXbR9g3Hq
	 RD3yuugK1QAt0pvcokCQ/09VJGmor5+gfuqmdgKOQ04VA8+5rpt4ICPBxvFPrdvjc1
	 j//509PkKJ0fPcYwGXl3vQ/heWzR/mGqU2N8QMZI7I6fV2fVl54
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0AFA120077;
	Thu, 10 Jul 2025 23:08:45 +0000 (UTC)
Date: Thu, 10 Jul 2025 23:08:43 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Yi EungJun <eungjun.yi@navercorp.com>
Subject: Re: [PATCH 1/1] http: don't send C or POSIX in Accept-Language
Message-ID: <aHBH-3io3rqw4pK4@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>,
	Yi EungJun <eungjun.yi@navercorp.com>
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
 <20250710221641.857081-2-sandals@crustytoothpaste.net>
 <xmqqbjpr4q8z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GTzjwKQZB6gmQs5H"
Content-Disposition: inline
In-Reply-To: <xmqqbjpr4q8z.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--GTzjwKQZB6gmQs5H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-10 at 22:47:56, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > ...  However, these two values are widely used in the LANGUAGE
> > header, are well-known and widely used non-language locales, and have
> > been seen in the wild on the server side.
>=20
> "header" -> "environment variable" I presume? =20

Ah, yes.  I'll fix that for a v2 in a few days while I wait for other
comments.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--GTzjwKQZB6gmQs5H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaHBH+wAKCRB8DEliiIei
gYWWAP4oVt7SZKE5x81cpp1Z6VJKG4aXYBiovZH7Xr2/MGQgEwD/ezXrzTY/MXgy
AVoIMnrogURg0TuzyHqOmgF4Opf4Zgc=
=7QeR
-----END PGP SIGNATURE-----

--GTzjwKQZB6gmQs5H--
