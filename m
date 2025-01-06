Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6CF1C3C07
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202351; cv=none; b=ofhKCwq32mcmF6QNSeicNehXYQPfg2KRIn3zRHtkW4HRsb1LmEfUb3FsBGGudabnXHF9Jh/aWTN7rVqt3EhxITNk94ddcY4WDEHNPKKNbvcxW0dOBZEhC2h18Re9i82inSZzdqCckGDgLG3zpwJWvFchZJGAOtiQLdl2qz/WB88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202351; c=relaxed/simple;
	bh=zMGZZqqwi0ztrHEOM+hWfRO5DnINTlIU4Ufq2RP3xJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbXP97jURAyx3bZq+YbLeig3MrdzkGRTguxsIRDvlx7fX5yDzYVzS2vyvQYvRUsVJc9U0B+InIiH8btoQu/fwOZi3Um9qdFK4iNiU8dPn3n+UfFJrxTodSlCHFT6KgZHA1bemhUotQiPWfN58rpzzq8v4BkLxFFSwx6BEhQYOPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=gX84wlcy; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gX84wlcy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1736202340;
	bh=zMGZZqqwi0ztrHEOM+hWfRO5DnINTlIU4Ufq2RP3xJY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=gX84wlcy8g1YkvB3sbuzRKpXf3syyeeQn4AXNRizLPtt+I470gr3UJiDGJZDXSEr9
	 aNGHxVcRshM5r07OZWOAbvUP7Fdj0pDgNij0UtSeeyuf6qKsUgDEeVs4yWVXzG2oyy
	 iYEyhrv/wMNgZQQSXagU8PUoif3uA7yeKjSH65FUtL7tt+vKqQGAZZGYIqLoyf5aql
	 u9NLXolIHcnDN2RmUhYC9Nf/viVV1fep6DUmgkqCWiC9s2613gdd+aWT5Jt8GitSoH
	 Q29d5wPdC6l2onT2TyulffGYQcwlNFo/iN+yZUv42jtxeQzVY/0pBPhtEHbosfg4Qd
	 kASScQcO3CNAEbnPVgxaLsnCDhA35aUu2wdoTbY8VAkIpFPN6D52DYnjM/r7iGrYXJ
	 XlTw/B2jiv9Svt2ww141bh2zOtSxNNIpOT3ZsJJX/sfZc4qYn4n5J9W/7kA1MGA1Dg
	 oO26DjjBvR5oJQj1LLrEcOFQJ22MfeZr5IMzAG0JmkfM+ftINQX
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C6D9120991;
	Mon,  6 Jan 2025 22:25:40 +0000 (UTC)
Date: Mon, 6 Jan 2025 22:25:39 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Matthias Braun <matze@braunis.de>
Cc: git@vger.kernel.org
Subject: Re: bug: Removing branch and creating branch-directory with same
 name breaks
Message-ID: <Z3xYY5A7BblBiYmG@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Matthias Braun <matze@braunis.de>, git@vger.kernel.org
References: <25913110-E42E-4028-B39D-44045623FDC4@braunis.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Lpg/E20dFRqooBGr"
Content-Disposition: inline
In-Reply-To: <25913110-E42E-4028-B39D-44045623FDC4@braunis.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Lpg/E20dFRqooBGr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-06 at 19:07:01, Matthias Braun wrote:
> (Note that I also tried this with latest git-2.47.1 after creating the re=
pro script and it still fails there).
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
> - Removed remote branch. Created new directory (for branch names)
>   with same name directory name as the previously used branch name.
>   After that `git fetch` fails.
>=20
> Reproduction script for your convenience:

Thanks for the reproduction steps.  This is expected, and I'll explain
more below.

> ```
> #!/bin/bash
>=20
> mkdir -p repro
> git init repro/remote.git
> git clone repro/remote.git repro/cloned
> pushd repro/cloned
> echo "hello" > hello.txt
> git add hello.txt
> git commit -m "test commit"
> git branch mystuff
> git push origin mystuff
> popd
>=20
> git clone repro/remote.git repro/clone2
>=20
> pushd repro/cloned
> git branch -D mystuff
> git push -d origin mystuff
> git branch mystuff/branch_in_subdir
> git push origin mystuff/branch_in_subdir
> popd
>=20
> pushd repro/clone2
> git fetch    #  This fails as branch turned into directory
> popd
> ```
>=20
> What did you expect to happen? (Expected behavior)
>=20
> `git fetch` should work...
>=20
> What happened instead? (Actual behavior)
>=20
> `git fetch origin`
> error: cannot lock ref 'refs/remotes/origin/mystuff/branch_in_subdir': 'r=
efs/remotes/origin/mystuff' exists; cannot create 'refs/remotes/origin/myst=
uff/branch_in_subdir'

git fetch does not by default delete remote tracking branches which no
longer exist on the remote.  That's because sometimes you want to keep
those around even though upstream does not.[0]

In this case, or if you just don't want to keep them around, you can use
`git fetch --prune origin` to prune those old branches when fetching, or
`git remote prune origin` to just prune and not fetch (and, of course,
these work with any remote, not just `origin`).  The `git fetch` manpage
mentions the `fetch.prune` and `remote.<name>.prune` options for you to
control this automatically as you see fit.

[0] At a previous employer, large projects were squashed-and-merged, and
I found keeping around the original history=E2=80=94and thus the original
branches=E2=80=94was invaluable to understanding why a change was made or w=
ho I
should talk to about a particular change if I had questions.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Lpg/E20dFRqooBGr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.45 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ3xYYwAKCRB8DEliiIei
gbG8AP44ESWBe4wZbw3fUEWYKwObTYLYhHRHa/21tEvT5G343QD/Qblb7L4D5HzB
RNwWGBS/LEeOtpc1fvgXg2RFlAmMJw0=
=EZ/o
-----END PGP SIGNATURE-----

--Lpg/E20dFRqooBGr--
