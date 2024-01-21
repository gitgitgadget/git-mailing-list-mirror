Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBE53771A
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705860366; cv=none; b=Ky5clbbmEQDhWiqhOkzcEPFzGCC+pZEpXecWg5SBPWBBcn+gGS0TgbWAxm/YN+Q+slA4sCUG+rFSNnQ9h8TNxEDAgGeGvgrsR19KniwnLvQf8EU2tVccwMgqEyCyQGq0e11i1b9pv0c5/tNanhibkOtgcoDuHJz9olN60Nfr9W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705860366; c=relaxed/simple;
	bh=edlldvYVmm0uqcstDYgTNzYLBNDpfUNatH747OFpOdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuK53eY6vumNKiB8yz+DbPUpJ+te1BLC40pMIxMOc06Cin5Hac9L9pi108lVO+rdG9M+BnCHHXQDeBlA82FXJ5htzbOL5XlwNUUptDJtvdqHQPOLKf/67wBgQhn6afLMW3QOfCBTqe90pOEtoWcOg5nqVypKl6uKJIc6b6ttr+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=UAzHlMR1; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UAzHlMR1"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 00B135A3CC;
	Sun, 21 Jan 2024 18:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1705860357;
	bh=edlldvYVmm0uqcstDYgTNzYLBNDpfUNatH747OFpOdw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=UAzHlMR1YpcTN6T93hFA5ODK8TcEDWRSBcLaswcw9ynK3y0/MVLRcNQSDhVZ+Jpej
	 RqkMhqko4eQv1CkJyHc+I3Dk6OnYYcY9gP32hO3UA8tCpK6DsdBFMakTxpng3cOHv2
	 BWxulGCd+wM40DWIdUI0e1y8XUkvnlc4YygqALt8jPKB2AYvFDotku/9KV/0/gprUi
	 iXxLguYZfZFq5AkEkmewhJIB+NhAWRkyL00srTqFrerTF7eOV5h9adBfsk5kiTTyPF
	 HYQ5/Wj1/VC7rUFoP70Zaj7HsUgzbXlxsduMS4bOW+5ZeAaAST5elTgIUBB+IP8m2t
	 cm7zWwO/nQzYpp2YhsyV8VQvRVVMMTM9B9rTnnIVl37aJT4jeSExNnsr/SGkzNHTJJ
	 6tvDpLMVsDu2UKqx7QAkZd/3DiBdvZuXu0XkPibmUrWLjNcNQtO+4Ap+c5PzcLRIWp
	 FwBG+7cxFNcSnSc0W1PB+RvZ3mnxTAbSdqdaxowKYordbEKuA5Z
Date: Sun, 21 Jan 2024 18:05:53 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Marc C <marc@mccd.space>
Cc: git@vger.kernel.org
Subject: Re: Git pre-received hook not failing with exit code 1 correcly
Message-ID: <Za1dAaKO_IlT3nuM@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc C <marc@mccd.space>, git@vger.kernel.org
References: <CYK0FIQPVI22.2RHKOY4L00FZS@mccd.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4vWZOgS4u5LfMs5B"
Content-Disposition: inline
In-Reply-To: <CYK0FIQPVI22.2RHKOY4L00FZS@mccd.space>
User-Agent: Mutt/2.2.12 (2023-09-09)


--4vWZOgS4u5LfMs5B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-01-21 at 01:57:28, Marc C wrote:
> Heya!

Hey,

> I am trying to understand why my pre-publish hook does not exit with the
> correct status code.=20
>=20
> I have a pre-publish script
>=20
> ```
> #!/bin/sh
> set -euo pipefail

One note about this is that `-o pipefail` is a bash- and zsh-specific
option.  (It's also present in some ksh variants.)  It isn't specified
by POSIX, so you'd probably want to use `#!/bin/bash` as your shebang
instead.

Even OSes such as Debian which specify certain extensions required for
`/bin/sh` (notably `local`) don't require this of it.

> However, when running the script as a pre-receive hook, it is not
> running the commands correctly and returns the wrong exit code. I get
> the following:
>=20
> ```
> remote: Testing nixos config
> remote: building the system configuration...
> remote: Success <-- ????
> remote: error:
> remote:        =E2=80=A6 while calling the 'seq' builtin
> ...
> To myserver:/myrepo
>    bffa94e..a14b3f6  main -> main
> ```
>=20
> Any clue what I am missing? When running it as a pre-receive hook, the
> failing command returns exit code 0. Running it in the CLI, it returns
> exit code 1. It is Schrodinger's exit code.

I know nothing about nixOS, but I'm wondering if maybe `nixos-rebuild
dry-build` forks in some cases, specifically when it's detached from the
terminal.  If that happened, then you'd see the above, where the child
process continued but the parent process exited, and then the error
message would get printed at the end.

You'd also see this if you had an `&` at the end of `nixos-rebuild
dry-build`, but you don't seem to have that here.

You could try something like `(cat | ./.git/hooks/pre-receive 2>&1 | cat)`
to see if the problem is the lack of terminal.

Hopefully that gives you a helpful head start on the problem.  I
apologize for not being able to help more.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--4vWZOgS4u5LfMs5B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZa1dAQAKCRB8DEliiIei
gS5BAP9/+uL8UnY3b9qwOi1Cl88GwGsulk3zsdjOGUtRfleMJwEAx6Rhw3Awr2mL
pLxG7UyeWR/KmVjuuuQxJGhKWjm1+Qs=
=+/gd
-----END PGP SIGNATURE-----

--4vWZOgS4u5LfMs5B--
