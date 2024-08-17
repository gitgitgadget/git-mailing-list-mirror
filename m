Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7253CD2E5
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723908864; cv=none; b=nQqa3yucOKv3VcJF2QnL3Zdx/RmXicOQJUJPBdVEy6/xfk7DeLHUlzfxlJ8JlQCCN7JMUAnnmTtw9dOlseLanx3X7fqYED8GVZTYAmb0leByNbtpKJXB6IoC4GnEecfIvjhZKvoekU11eyGBzrGXWqX23OVUcMLW/HnnyG9HR28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723908864; c=relaxed/simple;
	bh=NqXLqgaF+vFiVhrFGUbAHeLGJj5goUCu6OxAvaN9XbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRHILlADZX6all/j4QcihZ8kUSgYvJZjRvzxs2QSLV2NlT5m9vBh5j9kTQyGhZU2SQVUqtUMbNYN+9UvnqIrAUs06Eh28tZPAWnqr7LccbC8LKv58IfE33oCRAsCny0rJvsgzOOL83wjBDwavg/jMtcZxKcuflg4RIKG6MJeiwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=0e4oHsAr; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0e4oHsAr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1723908859;
	bh=NqXLqgaF+vFiVhrFGUbAHeLGJj5goUCu6OxAvaN9XbA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=0e4oHsArGVqZsb7dq0tTd81EdF/TEr4MLcgTGhz12EbeAUx/VcOsxD9llKURdBr69
	 vxABCOlV55SmB7CAMLOExS+1OIdzcJufY/QU6W/zYbAiI8Uq8BUSSmIB6qvs5QjZ9O
	 1qTeiI9SZw3Bok1nOVZZNkDRsCB+EByl8lUWeXDu7CtW16+pj2pjZi4O1KmgAB31nV
	 FU6mQXnEZGlTEfTFxCK9HN9ZmAVy4GC7iSU6isuzR09Tp4tgjUvrGt3QJWSi3pM/J4
	 WFh8uNa3aQSO7GPjM2tgdFthvux541EoE+odFWSdb1LEAB2yg1HnGyyNI8uG/dhMf3
	 HogiKoob4p5TFLR2W8kyttQ2S+gn2zuKakefFAY218u4Knl0F11wZOE9FfO9qBybt2
	 X7VTNH4pb4Nir0x8cCeutAgOwbJS0ODWMGGSAgYN9Lbj70YOVTdZAul1anMY8VJTl4
	 z81oAj52HDxeIDlW37YEmmdc4N8QcT9efacWrrXuftBJcfwSp/L
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E8174209C8;
	Sat, 17 Aug 2024 15:34:19 +0000 (UTC)
Date: Sat, 17 Aug 2024 15:34:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: James <purpleidea@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Regression bug with latest SAFE ownership patch
Message-ID: <ZsDC-nRxPIxQmoTj@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	James <purpleidea@gmail.com>, git@vger.kernel.org
References: <CADCaTgpcmMbLoKR-rWf_roWfbgWJL6HuURDxwovvKQA8syf=vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MaIPzIA5bJ7LntHk"
Content-Disposition: inline
In-Reply-To: <CADCaTgpcmMbLoKR-rWf_roWfbgWJL6HuURDxwovvKQA8syf=vw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--MaIPzIA5bJ7LntHk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-17 at 03:15:05, James wrote:
> I am not a subscriber to this mailing list, so please please CC-me on rep=
lies.
>=20
> I believe the recent changes for the safe ownership patch seemed to
> have introduced a regression. I have a git repo which is on a shared
> server that I trust and control. Adding a safe.directory does _not_
> allow me to use this repo anymore. I can't even run a `git fetch`
> without an error. I have renamed the repo name and directory, but
> output is otherwise precise. Full logs and versions shown below:
>=20
> james@computer1:~/whatever$ git remote show server2
> fatal: detected dubious ownership in repository at
> '/home/someoneelse/whatever/.git'
> To add an exception for this directory, call:
>=20
>     git config --global --add safe.directory /home/someoneelse/whatever/.=
git
> fatal: Could not read from remote repository.
>=20
> Please make sure you have the correct access rights
> and the repository exists.
> james@computer1:~/whatever$ git config --add safe.directory
> /home/someoneelse/whatever/.git
> james@computer1:~/whatever$ git config --add safe.directory '*'

This adds the option to the local configuration, but it has to be in the
global (`--global`) or system (`--system`) config.  A malicious user
that owned the repository could modify the local config, so it can't be
trusted for this reason.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--MaIPzIA5bJ7LntHk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZsDC+QAKCRB8DEliiIei
gcpzAQDDqVLS9hd1dMHY3kbZGwkPx1zADrZTjqkK2OTpzJ2GpgEA0nX2GF+RtE//
0i7Svjq1iHw2Zdl91Tdv/naiWqBrWwA=
=osLD
-----END PGP SIGNATURE-----

--MaIPzIA5bJ7LntHk--
