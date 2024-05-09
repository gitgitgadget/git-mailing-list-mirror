Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE9785266
	for <git@vger.kernel.org>; Thu,  9 May 2024 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715290365; cv=none; b=MCuMByC2S02fSzQWahPyf/AnvEbXQKD2fWqAz+NKiSS8l00rst+VSq3kV3glZjVIqWo/6pO/lPgEy5ugyiWEhgTMR9sU1Qstt7HIC5x2Aai2tU1Vy39XZyV7XX9DORmtbdSSW3KU57Vl1KFqK8lEvZGINYin9NzLMYw+fqjHy4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715290365; c=relaxed/simple;
	bh=eIr1Mc0+ZUieevT5G3+SL/FiUwFg6gZGt0fx6bZP2BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWpu3jHn8pwRGxADnK8pmk5berQaaU/IzxnBlvxbtXel73WNaSrNk6KAsKWU+qH14+JePRZgh5dsAzU4a3D7hNHdlyhcvyKRLSxI6JiWTD/ogjbWEOetHhBhldg/hT2SMdEuy2xdkmUaDiasczRwDYbx3NZX7l3p3Xp5M/6s/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=iQlngWgY; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="iQlngWgY"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 1C80C5DA75;
	Thu,  9 May 2024 21:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1715290355;
	bh=eIr1Mc0+ZUieevT5G3+SL/FiUwFg6gZGt0fx6bZP2BM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=iQlngWgYg7so+gcJwp0IzzeP42ii761V46NHutbRVi+Bve78B6pHjImjcXx6073C0
	 kL9IjEfyzFB+J88HlnfFydjnlGQpHqYPcTcjY0I5en49OOoVZzW01uBA1vFmkZZWW0
	 Bd9BJDf3bDXpkcx6zMRpoMHw4YGGVn18NYq9Qe87YGxuYq2f9DGvfIMRzHkOUik55d
	 RzSlov0Ar6POHxLx2Pu5zoGp9YsX+z+7kBixQ0ooGmat+2lsuGstTQaOvfTk5smagb
	 JFLyDTRqIpRGqm0WH3H6ooKJPMpPr5buVLUZD+u5lCKzeTGV9hfAf6/wrkfDMe+y0n
	 MMH18BSrIqEUuzVp6HGg9ilHNhsXLul6oPgLH6FxNU0rhCVzWzNPPSu0UU+coR8IPm
	 v7VHAbgtpElGdNwl2pF9K4okarcFnC1iTUUeLhO7FInavv3kwuP6MDpPFaMIUR7xUM
	 AjSo3V/Mj31YDNcO8vyUem1LDocXONFmjoBLLFd8ol9+7eVyEOE
Date: Thu, 9 May 2024 21:32:32 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: dev@dev.maltese.cc
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: $PWD expanding to incorrect value Podman run command
Message-ID: <Zj1A8MsBRejNm_IF@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	dev@dev.maltese.cc, "git@vger.kernel.org" <git@vger.kernel.org>
References: <21209940.11022921.1715263583414@email.ionos.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qUi28RUBycOJYaA4"
Content-Disposition: inline
In-Reply-To: <21209940.11022921.1715263583414@email.ionos.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--qUi28RUBycOJYaA4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-09 at 14:06:23, dev@dev.maltese.cc wrote:
>    Thank you for filling out a Git bug report!
>    Please answer the following questions to help us understand your issue.
>    =C2=A0
>    What did you do before the bug happened? (Steps to reproduce your issu=
e)
>    Installed podman and executed: "$ podman run -p 8081:80 -v
>    $PWD:/usr/share/nginx/html nginx"
>    =C2=A0
>    What did you expect to happen? (Expected behavior)
>    Expected the nginx image to run and map the current directory to the
>    '/usr/share/nginx/html' directory.
>    =C2=A0
>    What happened instead? (Actual behavior)
>    Received the error "Error: invalid container path "\\Program
>    Files\\Git\\usr\\share\\nginx\\html", must be an absolute path".
>    =C2=A0
>    What's different between what you expected and what actually happened?
>    I expected the docker $PWD (or ${PWD} or $(pwd) or $HOME) to expand to=
 the
>    actual working directory, but it seems to expand to the directory of t=
he
>    gitbash executable.

This isn't really a Git bug; it's more of a difference with how the
MSYS2 runtime shipped with Git for Windows works.  Note that the Git
project doesn't ship binaries or any software other than Git itself; Git
for Windows is the distributor of that and can be reached at
https://github.com/git-for-windows/git.

However, the reason you're seeing this is because most programs on
Windows don't accept the Unix-style paths that MSYS2 and Git Bash
provide, so to placate them, Git Bash converts paths that start with a
slash into Windows-style paths.  The root directory for Git Bash is the
Git installation directory, so when you write `/usr/share/nginx/html`,
Git Bash turns that into `C:\Program Files\Git\usr\share\nginx\html`.
The `$PWD` is not necessarily related here, although it may undergo the
same expansion.

If you don't want that behaviour, then you can use a double slash (e.g.,
`//usr/share/nginx/html`), or you can set `MSYS_NO_PATHCONV=3D1`, like so:

  MSYS_NO_PATHCONV=3D1podman run -p 8081:80 -v $PWD:/usr/share/nginx/html n=
ginx

Note that you probably _do_ want `$PWD` to undergo expansion with MSYS,
though, so you may want to do this instead (untested):

  MSYS_NO_PATHCONV=3D1podman run -p 8081:80 -v "$(cygpath -w "$PWD"):/usr/s=
hare/nginx/html" nginx

If you have more questions about this, I'd reach out to the Git for
Windows folks.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--qUi28RUBycOJYaA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZj1A8AAKCRB8DEliiIei
gbrLAQCQM5BPkPuyAntUlm+EPtIGXzUDF56vP5BqHQVFgd0FCwD+M31bGdXO+R0+
lIpFl+7Du3JcqgLuYr0FdayEUcmGeQg=
=dEkg
-----END PGP SIGNATURE-----

--qUi28RUBycOJYaA4--
