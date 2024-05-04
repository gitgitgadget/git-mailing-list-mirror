Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDB0803
	for <git@vger.kernel.org>; Sat,  4 May 2024 01:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714784801; cv=none; b=k1Zw73BRtRg5j5CJP/lCR0juCQgPYPDtLkdksXYreqem9hX8E0ID4E983KPv7uPhGVeDtP7t+aaWtKO0j9/HVGt0JGM9RbMZ28ZyEfrgCvi7yuSfxbsU2gWztxRzA5EK0loUgykSvc5cTubu9z01yPFKvaz9xfA9CLEIt8S/28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714784801; c=relaxed/simple;
	bh=LWrDQ6KQPaf7ZAaImMKODC8+DjhhSaseK0QxrBWqT9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSYigfTL+TjTdTDX87/twizM42aid1TL5MvMbVZZV2Z17CVc3aQQtzXVk2JAxpz1bW2Fe3UMUm/12UHScFtfv7ktw3WDnxG/ALlIAzeZvxJuGoHq3KhJVQDJb9toSq8lp55v8HkXALGDeXLHsnbjOA9shpvVRx93AdoWDC1O2tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uVwMMGty; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uVwMMGty"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id EED105B2ED;
	Sat,  4 May 2024 01:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1714784797;
	bh=LWrDQ6KQPaf7ZAaImMKODC8+DjhhSaseK0QxrBWqT9o=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uVwMMGtyDWmFp1jf8BrX8Cdl0aZapYOhGvKnu6QMrpwdZZSokeivXEI3RPHaF28TI
	 k8nCWPhNaIBnfe3SczcxFO4sjhp92fYB4Pb03LqI/4zCUaJofestQZJfQj59aZwOs2
	 q/539e7UPF4jVWzGAUA9QFV6Gw6dpOTzidW8uVTglqIQ+i3zfeTrfEk20lK2jAxGFM
	 0Lzh6FMMgvuo7uwwf8lRqjkzt/TSuuAq9eZTISQ9WqEnBzmrWbuQl0nBSjN7hqsVjc
	 WPZr98VTGvHkEANMoHyfxLQp0y8pqdFaGIjVihsNZgj1iiaIHuJSa/KVxXgk4+Rk3W
	 vDVOf7tYkaDqX0oMVUsuliCyzAQXDEek0rhcOR2vVRh/DD94Ztqn+Nbf61PT3d8jQN
	 K6mzGgbbHt8hcTlQl6SIFLlBAI8x7DftqNAAtttI95I8tOXk1iCxt1BVDacslZKx/s
	 PqnKfMsjBljnazOKMVJH0KARcgKJYUMBE9GWzq8AjmS1AkRqNQe
Date: Sat, 4 May 2024 01:06:36 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Simon Thurston <simongethurston@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [Bug Report] git config includeIf not traversing symlink
 subdirectories
Message-ID: <ZjWKHJD50PNcWu5R@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Simon Thurston <simongethurston@gmail.com>, git@vger.kernel.org
References: <ZjVt5jtC8cKgWpqQ@tapette.crustytoothpaste.net>
 <B240544D-1695-4627-B7EC-5C9CA7716265@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VWCA9QptDKXdTkv+"
Content-Disposition: inline
In-Reply-To: <B240544D-1695-4627-B7EC-5C9CA7716265@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--VWCA9QptDKXdTkv+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Please keep the list in CC so others can chime in.]

On 2024-05-03 at 23:41:14, Simon Thurston wrote:
> Thanks Brian. The issue I'm having is that I have two main development di=
rectories, for "home" and for "work". I have includeIf statements in my pri=
mary .gitconfig that sources different public/private keys for each subdire=
ctory. Under the "work" subdirectory, I have folders for projects, and then=
 a "Deploy" folder that contains symlinks to folders over the network, so I=
 can quickly cd and git clone/pull to deploy things manually, as well as us=
e with some CD powershell scripts I have. The important thing to note is th=
at the directories that are symlinked to repositories.
>=20
> In short, if I have an includeIf that encompasses a parent directory, any=
 subdirectory symlink that points to a repository on a local server does no=
t properly resolve to include the settings from the includeIf.
>=20
> /work/Project/.git can be detected, but /work/Deploy/ProjectSymlink/.git =
cannot, and thus any includeIf statement that checks for repositories under=
 /work/** does not properly detect the repositories that are symlinked.

Yes, I think this is intentional.  Git doesn't consider the repositories
which are on the UNC drive to be under /work/Deploy, because the
canonical path is not in that location.

> I have tried to get around this by adding an extra includeIf statement to=
 include //the/direct/unc/path/** but that was not able to resolve properly=
 either. Mapped network drives with drive letters also don't resolve, and t=
he only workaround I had was to blanket apply the config file to every dire=
ctory, which is not ideal for the environment I work in.

Yes, the mapped network drives will be resolved to the UNC path with
`GetPathNameByHandle`, which is why that syntax doesn't work.

> If the behavior around symlinks is intentional, then that is fine and can=
 be worked around, but not being able to specify UNC style paths in the con=
figs is something that makes it difficult to work on SMB shares with specif=
ic configs needed.

As I said, I don't use Windows except extremely incidentally, so it's
difficult for me to speak with any authority on UNC paths.  It's
possible that they are supported using a syntax I don't know about, or
it's possible that they simply don't work at all.  If it's the latter,
I'm sure we'd accept a patch to fix it.

What I might suggest is switching into one of the symlinked directories
and running `git rev-parse --absolute-git-dir`, which should show you
what Git thinks the directory is.  You can then write that path directly
in the configuration file, nothing that inside the double quotes,
backslashes must be escaped (so if the path is \\the\direct\unc\path,
you'd write '[includeIf "\\\\the\\direct\\unc\\path"]').  You may also
want to use gitdir/i if you're not already, since my guess is that your
paths are actually case-insensitive.

If that doesn't work, hopefully someone else more familiar than me with
Windows can speak more to this.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--VWCA9QptDKXdTkv+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZjWKGwAKCRB8DEliiIei
gc2CAQC9Ojw3z5qm7f+oOidclaLDSjD+ZKKOd3HlZUPbU6UvOwEAjmPJR3isgs9H
PuZcKY9KqB27la/JBl973AmZ0u3wxQc=
=q9Dy
-----END PGP SIGNATURE-----

--VWCA9QptDKXdTkv+--
