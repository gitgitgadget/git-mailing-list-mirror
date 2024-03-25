Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FF13A3E8
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 00:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711326693; cv=none; b=Qj9tQ6bU2ePkXOasLSZ51EqIfLSJM+C6NRrIAx41DOiojWC6VL+lvKv+/AetYXhsIJjPH3tnwIY7f+CuX+K5ZB5q13dynuuXjgz0FiqSukvWf3uTcqwIXw1VHYqLph7lhJUb6GQQbKtVPDgajbj2ckE6w7ZZa/0dADIZDpQ7IdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711326693; c=relaxed/simple;
	bh=WPaPpRkUSCy/wsywcLQHNMaFZUDUBzmHmuPeqd+hAks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoLhFU2zBUIYM1V0//kRnEtxIwA/J1i4ObntjutPiscmkYmBgpEUKpUb83jxvBrKA5PtcZ8G1vQvs2KUJaQ6/1pRkILHsTDhijSrz6wG2Pkp3qj1XvenH0MRN6Q0xuAfL8r9IcpI4ft+yUzWXsF/IVLxy/Zi7qLZGwRYNIynvbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=aaBukfe+; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="aaBukfe+"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 42C7F5B41A;
	Mon, 25 Mar 2024 00:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711326688;
	bh=WPaPpRkUSCy/wsywcLQHNMaFZUDUBzmHmuPeqd+hAks=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=aaBukfe+2XRbDY9K1GtOEFaqXQ3l/BfuxhRJYrxTBR+gMYTjpmneIMILlMmoJEeft
	 5gSylygxydw5elnzsoE0hIRuok0HqYzfneUm1a1jPG6QVwZa8NKa7/dOFT9XjbOq2l
	 U6UKBv2gOs3Jg8EEKtJbZW0HCeCE/YXQQL9FC02Ds6Se6I7S3hx3nmNu2Ed4QD7Opu
	 tgp3AdRmUchelKZ1CvziTXKJLxaWZtLXQH6RSR0TjrwgD2ZvyCfmZQwXUUEi8AmwMw
	 p5u9KP9w8Fitx/iAwm9T13Ka2mNv6/qZs1TmUAucjh3uOlCV07KTtm3MYzxst+i2Gd
	 d1y6+smrwA9A82/hflJoQgVqXP58ogIeRBlTPNXP4ETVXwOpn0Wh/Ez/DZHdR8O0bV
	 uclOUKcBUcCOiJDS2Eo4Y7eMYhXmYzJ12CUFuEBBUrOD6MJILcnHvWAZxvkvBNOzLM
	 DlGzbYZ3LS4SLs7swyNrzhe9e2ROlFHE4FBrvA4V/iry9BB9Vxw
Date: Mon, 25 Mar 2024 00:31:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Tim Landscheidt <tim@tim-landscheidt.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Inconsistent/buggy behaviour of "git config --add"
Message-ID: <ZgDF3uIEYNbawplE@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Tim Landscheidt <tim@tim-landscheidt.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <87o7b5dj8h.fsf@vagabond.tim-landscheidt.de>
 <xmqq8r28ygwi.fsf@gitster.g>
 <87o7b3xxta.fsf@vagabond.tim-landscheidt.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vXVZ2VVqff5+Iv51"
Content-Disposition: inline
In-Reply-To: <87o7b3xxta.fsf@vagabond.tim-landscheidt.de>
User-Agent: Mutt/2.2.12 (2023-09-09)


--vXVZ2VVqff5+Iv51
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-24 at 18:57:21, Tim Landscheidt wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> >> My expectation of least surprise is that "git config
> >> section.key --add value" should be equivalent to "git config
> >> --add section.key value".
>=20
> > You cannot have "--add" as a value by doing so.
>=20
> > [=E2=80=A6]
>=20
> The standard way to achieve this would be to use "--",
> i. e. "git config section.key --add -- --add" (apparently
> even part of POSIX as "Utility Syntax Guidelines", but also
> commonly used elsewhere in Git).

POSIX mandates that all options come before all non-option arguments.
So by that rule, `git config section.key --add value` means that `--add`
is a non-option argument, not the option `--add`.

Certainly some GNU tools do break the rule, and Git begrudgingly allows
it in some cases, but in utilities in general, it isn't allowed.  Many
non-Linux OSes and non-GNU tools don't allow options to appear after
non-option arguments at all.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--vXVZ2VVqff5+Iv51
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZgDF3gAKCRB8DEliiIei
gfWLAP9iDxiuIFa6LvN86h6eh0Sy8PPHxFw5vapwfMH9NS/8+QEAnrghjxCr3Bit
rb65uKwAiy1fbeRfgO+Mrs4l8sAcHgM=
=2WVU
-----END PGP SIGNATURE-----

--vXVZ2VVqff5+Iv51--
