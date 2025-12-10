Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896D623BCF5
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765405706; cv=none; b=Ddzj5Y4U0DilJWXT7KJtLA0hT8ZIwq4cHRZzMAO6tKGjPS6mRt56KBi3wGzOk3nX3+ic9Dd9VC9QIdwIo9QfoHKZx+T3IJSXKKugO5vaSGdS8/zVnE+d25DYO0BooptT9G0ZMftGlunUcfFe3zFDjKi3fEgZvDJCnCkjf/3ewdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765405706; c=relaxed/simple;
	bh=Nic6j5oFUGcPrl33hwNZSVQoW4Erz4KYQnFw6QKZMxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4BHS0B4QX3d5gwyWAosa2dwbYENqN0u1DYIB6Ff7DNXjcoD/IDLBnCcs7QvKKFcaHYAho69t57grwt1yXbMP9lcdFFNqi58raMgeUGg5N3dBl3OJj1WSDvLGAg7UGjkU52zRfmG4cl7VwTJSo/VqYS9wY9QHHBwO5cp2Q5x1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YXlBVmtT; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YXlBVmtT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1765405702;
	bh=Nic6j5oFUGcPrl33hwNZSVQoW4Erz4KYQnFw6QKZMxQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=YXlBVmtT3jebixMFi10/tUqzttvHXfZOMRJSEevtCacGmiXbj5UrM8Hh+tHAsYqdO
	 Qyao+Pn5UdSAaJpAg2lIWwMhfejYghbuq8PCrLiKELYlJszEfNr7ZGqM7Bdcq2frA0
	 SBugRCTK/YGX7snuu3UttfVOgEdYegnzTPuP0Zy3qNbBVOysBwpevPYC+urVnmg1nB
	 fM+tA+II7XbkJ+OL7sfePzJket1HyGot+rpLG3SRZCfdL1g5sJz//5hMwpw53h4lj/
	 +AId9iJO1fOOR9szWHMYZqDi7PSv0toIocguLJVCCmtDrOq1BfvMWM4oZeq+1oxlJn
	 K+GyKQW3SN2TZrRqcmBJfIUqzrSfGQHtPXuBeNRqac5qoPGEoi8NABtQm4jZG4KBQB
	 xkM+r1IP0KJvjnGerybp1MJhb0Pn6xkkDkMaEAvr7Xqyvx+86SmGR/3gB4TgufOiB6
	 0IGG9KDcIX4Nd9CpKJbI25UH+yTwP5lE9XesYiI4URJXVHp/6ld
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:8938:8011:d856:6a36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 49887200C2;
	Wed, 10 Dec 2025 22:28:22 +0000 (UTC)
Date: Wed, 10 Dec 2025 22:28:20 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ashlesh Gawande <git@ashlesh.me>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] http.c: prompt for username on 403
Message-ID: <aTn0BOM07Lyphq_1@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ashlesh Gawande <git@ashlesh.me>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20251014144354.1457818-2-git@ashlesh.me>
 <aO7Aqooz-0ppbcMP@fruit.crustytoothpaste.net>
 <30639771-4999-45f4-a8d7-1ed4774ffd8e@ashlesh.me>
 <aPAg3gYwzA9fHCC3@fruit.crustytoothpaste.net>
 <79d2226c-b568-4385-a618-f0d3c06cd0a8@ashlesh.me>
 <aTjVenutFBprwrrz@fruit.crustytoothpaste.net>
 <37c3b31e-900e-4df0-ac30-284e71660487@ashlesh.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lOL8Cx9QRUcxwAfQ"
Content-Disposition: inline
In-Reply-To: <37c3b31e-900e-4df0-ac30-284e71660487@ashlesh.me>
User-Agent: Mutt/2.2.13 (2024-03-09)


--lOL8Cx9QRUcxwAfQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-12-10 at 12:30:27, Ashlesh Gawande wrote:
> Oh, that http_code =3D=3D 403 is my original proposal to prompt for
> username/password on 403 (I did the diff on top of that instead of base).
> But you pointed out that it would wipe out existing credentials. This is =
an
> attempt to fix that by not prompting on 403 if git credentials are set.
> So when credentials are provided through default netrc file (such that
> http_auth.* are not set; git credential helper is not set) then we can st=
ill
> get the prompt on 403.

As Randall said, I don't think it's a good idea to do this.  It's a
major change in how functionality works and it will probably break
users.

I did mention before that a better approach is to add a config to decide
whether to honour the netrc and I think that would be the right choice
here.  That lets people opt into different behaviour if they want it
(and, to be honest, I _do_ very much want to skip netrc for Git
credentials since I have similar problems as the ones you're describing)
and avoids breaking things for existing users.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--lOL8Cx9QRUcxwAfQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaTn0BAAKCRB8DEliiIei
gaJ3AQD4Ct5ObmPXdRm4BC67WGI8oLUQSwL/3xm1W9DNXqZnxgD7B+mVYW7cFiRQ
JnlaOLhsyVHuBqmfAZhW6+mufh1Vyw4=
=CMu/
-----END PGP SIGNATURE-----

--lOL8Cx9QRUcxwAfQ--
