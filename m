Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA5221C17D
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765837780; cv=none; b=jijDnav3Mn+nOGg9wG1alTb7YXktp+KdCH2aw/jRt3AUyjW94JnHpNddG8Dhj+AqSag2jWvzLtq7GSqeKEvRGLhes9XKon1YtjOadqDEUo4hVjt4WVKi9zcDheM8kmdJ12W8rP/DnYFvBWxh3RdLnRWLW60PEKqUpxy3LMKwb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765837780; c=relaxed/simple;
	bh=Jgqie/ZVNriaJIw4A/qqp6h6AjSQMkmEhqFo/t2KGX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBR+SzbvsWr8Fxfj4HiTyWQ3zN6fLtm6JLnmmDV+oOVZfEsD7yzOQsHhgtSlJcJKJNfUPBs85//2scbKTnH1fnIbrDRJJFDQjX3Q0Op4phekDAoOeAEX3bxS7m0zq/ITQyJfk4P+8/890qmlyZyUi0ia3+pkm7Zl7R7M1sm0Y8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=zc7l6M8x; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zc7l6M8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1765837777;
	bh=Jgqie/ZVNriaJIw4A/qqp6h6AjSQMkmEhqFo/t2KGX4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zc7l6M8xgOWzfQIykjUvFlUGvDw1NwlNDdcM0vQoldzBQi7Lzg9fivJmXkiWS8Zy0
	 8obfInzE44cH872yw+L6UHW1p1uNZgsta4BKcoW7hXrC/PrCfowugqx8sbCLt1Aa8b
	 ix6D6Agw1IO3vsbS1NDn7UpdvNyJznFFMA19yTUKWXnL1SGNakuxDuzFluUXCKZ86u
	 Q9YCelJ6wWVlvWF69K8hSTcyzAYUomTOEsdQrq847itIt0GoZ5/2Yaxzc2NwHfh69t
	 iqJi9UZ73vaZBwWbW0DP+a8zP47zVkdBCoPe/O215ax1rCuTuQfM0g8etEu2M2qpWE
	 y0qQjcFO6G7aE010FnSmd8hqxw1PohWTCTXr+w7OdpFbD/ofeqqqpaeMZDMP+sg1RJ
	 54ZK4Tf3z9XwxsijAkw2+Mu2CU8FACIw70ukoQvSdcEPBQjcoCUe0NeXyowo08dNvq
	 wmJyEc3aoUFtwHffIg0+UN+AxqFjHdvnma6ZKkyxyXXDLcq0iKc
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4cd1:4dc0:5be:c1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 194EF2008B;
	Mon, 15 Dec 2025 22:29:37 +0000 (UTC)
Date: Mon, 15 Dec 2025 22:29:35 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>, Git <git@vger.kernel.org>
Subject: Re: Would it make sense to add a commit.signOff config?
Message-ID: <aUCLz1wTOwilflAD@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>, Git <git@vger.kernel.org>
References: <86c5d40d-5a06-4a69-90d8-a737685b0536@haller-berlin.de>
 <aT7lkXl65-TBIsRS@Carlos-MacBook-Air.local>
 <xmqqsedc8w7k.fsf@gitster.g>
 <aT9iu9He3yJ3npWX@fruit.crustytoothpaste.net>
 <xmqqldj48pyl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T7EDo1a7NYqyA/9L"
Content-Disposition: inline
In-Reply-To: <xmqqldj48pyl.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--T7EDo1a7NYqyA/9L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-12-15 at 01:59:46, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > I think this would be a fine approach or we could add an entry in the
> > Git FAQ (or both).  I agree that this is something that comes up
> > frequently and writing it down in a more visible way would be kinder to
> > users and mailing list participants.
>=20
> Something like this, then?

Yup, that looks good to me.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--T7EDo1a7NYqyA/9L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaUCLzwAKCRB8DEliiIei
geL3AQDX/GhZFUnOQdPv4vjpq8WEn+nTV/t3JgFGlciKAwFzAwD9F02r/RHknsjs
X+9H2Txan4JbKC5AS7ZWegMeTL2Q2wo=
=CRe4
-----END PGP SIGNATURE-----

--T7EDo1a7NYqyA/9L--
