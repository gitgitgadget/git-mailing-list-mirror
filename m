Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289CC86621
	for <git@vger.kernel.org>; Sat, 25 May 2024 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716673631; cv=none; b=UCMVgGBQJTdouQMXpmoTImn74FM9IZeJfPNXEykpVzPQB/Z4rvNot/eBL4aY0ZKrnF+YxjcVCFjPOJrLZq+dPDweMmn6/C4L9IsxhL9kXy8C7QPXxplLu6e/hv0rKOHs6Sv8BEsapTzh5hBGpvlUuMd+UQyokOnQSupPfZuMndY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716673631; c=relaxed/simple;
	bh=l+ZVr6xc9qSFe0K5v4aj+SpRmyM5CZ8oq3Sz5+ud6Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZHvhJvvylNpNL5TUMvZZRSs+1WXQ9py6uWhFEsrTEmmUadKLhT9IEJwM5E5fTgqHM8YuBArj99y97iE7NMScK/b9Bw/WwkspXRmKoMqOR0axTjDVJhRGhuRsPBiM6rrlV9hnCBM+KmZIghKZu3hdapgpywoY63l8hNTUkiHacI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=QbZIff1l; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QbZIff1l"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7E4BE5DAA1;
	Sat, 25 May 2024 21:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1716673119;
	bh=l+ZVr6xc9qSFe0K5v4aj+SpRmyM5CZ8oq3Sz5+ud6Es=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=QbZIff1l/URrvfpaK9dqGXGSwjYRmb/MW7cur7b17H7Cq/n9Llc4i+FwhlGrcu2LP
	 QD57ve+GNO9IcY6yRfdSGCoQ9MrrHynwxkm79YNtUS8f8N2ce2c6E05qp2/fsx4LmW
	 e4coB/XYLIIykUdHHwRsaaRdmiOryPmLCOGAcH3WzB+AE09YANgs5KQIZvIBJ/XzTc
	 RJynfoHzVyR5UwIDo/w0wtBa3BBWqusqs2ZDjJhBG+fNwPiUdty0WF4rtzi3ib6QCU
	 HInaKPBpx7R6WBODM3CPLBJCGO09kwvyBqYZEA1vm4oYv6xEfxWDUld2jTGX6A4a3C
	 3Ovzi7v1BV2MuYjQ4y8cBmMq+2kNltJd7WIcrlREf47Y+riuM9ACLg2mSpU6KCLDQa
	 7/ButLqYCQAvJsDjP8eTBrjAlSH35U1JVzaE+Tlm6xmE4+a5ar6xrQ4Z0QtUMb0lha
	 643f1puZH5QPTq9nvOOeLvgwqVZ9ZJ5LhpE+/c9iLTNsLqvUN3J
Date: Sat, 25 May 2024 21:38:37 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: William Ruppel <wcruppel@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git "safe directory" not working correctly
Message-ID: <ZlJaXfLc5fvBl4UK@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	William Ruppel <wcruppel@gmail.com>, git@vger.kernel.org
References: <CAHa7PX8THmTAYFVwAtjimgcenUPC4A5BF2OHExC82Cnrdtbn=g@mail.gmail.com>
 <CAHa7PX_JwsvADE0Xv9AW--5ZgAChwQTWrqNSGhwWbuabk5_PKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WXULyAy5VCNU7owC"
Content-Disposition: inline
In-Reply-To: <CAHa7PX_JwsvADE0Xv9AW--5ZgAChwQTWrqNSGhwWbuabk5_PKQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--WXULyAy5VCNU7owC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-25 at 20:22:38, William Ruppel wrote:
> FYI, I discovered that the issue appears to be related to the single
> quotes. If I do this instead, then all repos are considered safe:
>=20
> git config --global --add safe.directory *
>=20
> And in a similar vein, to whitelist just the single repo I was having
> an issue with, git itself  says the command should be:
>=20
> "
> To add an exception for this directory, call:
>         git config --global --add safe.directory '\\bill\gitmaster\Src'
> "
>=20
> But, again, the single quotes don't allow this to work.
>=20
> All the examples I've seen use single quotes. Has something regressed
> w.r.t. to how single quotes are handled?

The examples are given for a POSIX shell, where single quotes prevent
any interpolation or escaping, and double quotes permit interpolation.
You're running on Windows, probably with CMD or PowerShell, where single
quotes don't work and would probably be interpreted as part of the
argument, leading to the `safe.directory` value being `'*'`, not `*`.

Note that at a POSIX shell, not quoting the asterisk will result in it
being expanded to all files in the current directory, which is why
quoting is necessary.

If you use Git Bash, then using single quotes is correct.  Otherwise,
you may need to use double quotes or read the documentation for your
shell to determine how to properly quote things.  (I don't use Windows,
so I can't say what the proper syntax is.)  Git itself doesn't
necessarily know what the shell used to invoke it is (very especially on
Windows, where SHELL will not be set), so it provides the default POSIX
command.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--WXULyAy5VCNU7owC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZlJaXAAKCRB8DEliiIei
gWznAQCIz4AVNohaX4/HXcVLYaGldfsMQsjG/FQvu+CmvtaqjQEAz0sTXb95FZMm
pWZMxfM3JHITz8S5RbWaORUjBtwSqA8=
=FKf4
-----END PGP SIGNATURE-----

--WXULyAy5VCNU7owC--
