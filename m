Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B176BFA5
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435523; cv=none; b=JN7VeXcAd+w4zOScGxrUsKoEPCezc4eDYrY4MJYbnBuGk+u2ZOhevHnEehRHNkhbigtwd8YZyxKYiUOKHjXsfSUbS9DcZvdfHpLkBH+YpssNJonqkI60sD3AbmldM1zQvSMwPXmaTfIb4AIwVDwD5NIyyGMO9QiQtPEo/BtUjbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435523; c=relaxed/simple;
	bh=5Wp0nYqYM07QuIoUeuha5252lrURu/1oJ0it8urcYbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7m2PYNfHIajyb9ydwO0Lg9Vs8zzabHRbkQKVZT4f95YMRt3pmgInLB4KCrdhVvNLZAK5JxEYEv/WKEYAMN6WYljuohBid1A32qjURf+V2cYYQ52tgy2I/NcUYbs/oDvPkSM9YLoXnsb5yM1BRJVNXSb+ilBe5AGs1MHS55KG6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=vlp5YnmB; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vlp5YnmB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720435518;
	bh=5Wp0nYqYM07QuIoUeuha5252lrURu/1oJ0it8urcYbU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=vlp5YnmBMv/hfbAa880FO8WtWq9SZfEqxyClXwwRG1fclej9+FcUCgkdJ9VV29KLT
	 m1Mbjm8n/zZDscOLniq9cTAlitSBZBimk6YY4IS6+8byB22thW8C2p7k7IIwd841R4
	 UwPfQDHqtq/bwaladrUumhyGgF8As5V6V5NqkQ/K87dU6WZOpqhTD+A5+nsfv4gyfE
	 j5Zo2SJlQ0brq/Z1HgPe5sSI/bHMM+HA5eh1XBhHm0P5ogGBs+AY5zFYX27FsG797a
	 j/tjn6GEhbX/O84LuetV64KV6OQdqSg5MNSOuHZkWVBiG3XvZdQ/cjBh1cJRZS7sHB
	 IS3g762ii4aSE57MC2s8HJhODF762jkAy6RMMphGI94LWo610seCZ9Zbp+P/aLaq4A
	 ZAO+ODwXqSGg+K1MnbqqNbY+QV9ACsfeiXVQvrtrnOJY9+Qa/Ofeq8peuzCszqjPOn
	 a8w6US/4mBhqpM35F7TSdEsBrX1R8VBSvI6f54wg9u1I8DzFTAW
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 96D2A20998;
	Mon,  8 Jul 2024 10:45:18 +0000 (UTC)
Date: Mon, 8 Jul 2024 10:45:17 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: phillip.wood@dunelm.org.uk
Cc: Git Mailing List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: BUG: "git var GIT_SHELL_PATH" is broken on Windows
Message-ID: <ZovDPbgBS7WJIipz@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	phillip.wood@dunelm.org.uk, Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cc267962-ca2d-4c4a-9ed8-d40c4d282522@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TE/g/W6R5rsqQqbl"
Content-Disposition: inline
In-Reply-To: <cc267962-ca2d-4c4a-9ed8-d40c4d282522@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--TE/g/W6R5rsqQqbl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-08 at 10:07:17, Phillip Wood wrote:
> Running "git var GIT_SHELL_PATH" on Windows prints "/bin/sh" which is not
> very helpful when the path to the shell is actually
> "C:\Users\gitlab_runner\scoop\apps\mingit-busybox\2.45.2\mingw64\bin\ash.=
exe"
>=20
> Support for GIT_SHELL_PATH was added to "git var" in 1e65721227 (var: add
> support for listing the shell, 2023-06-27) with the aim of making it
> possible for external programs to learn the location of the shell used to
> run the command returned by "git var GIT_EDITOR". As the commit message
> notes this is especially helpful on Windows where the shell isn't
> necessarily in $PATH. Unfortunately the implementation simply prints
> SHELL_PATH which is unused on Windows. As 776297548e (Do not use SHELL_PA=
TH
> from build system in prepare_shell_cmd on Windows, 2012-04-17) explains t=
he
> location of the shell depends on git's installation prefix. For the
> git-for-windows builds it looks like the shell is always in
> "$GIT_EXEC_PATH/../../bin/" but I'm not sure if that is universally true.
>=20
> It is possible to work around the bug by doing
>=20
>     git -c 'alias.run-editor=3D!$(git var GIT_EDITOR)' run-editor
>=20
> but it would be good to fix "git var GIT_SHELL_PATH" or at least document
> that it is broken on Windows

Ugh.  This was indeed supposed to work, but I no longer have access to a
Windows machine, so we'd need someone who does have one to write up a
patch.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--TE/g/W6R5rsqQqbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZovDPAAKCRB8DEliiIei
gYq8AQDsxNDfcbt9hV0EYcoXlge8+Cz9vcdfaaSqq6XhXtE9RQEAwPCmq/MyYeim
w3an3M13CpJmJ/+lDsxBZtD7anPvEQs=
=rj07
-----END PGP SIGNATURE-----

--TE/g/W6R5rsqQqbl--
