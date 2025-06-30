Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0645C3D69
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293880; cv=none; b=V72iA/6ynCu5lmKpDubUKWrwzxq0runaMpGaEhLB6P+oZOyhn7NLCfLotk40gB3PM8ga3bSVM0MMr7fWTYWUpMRl5LAeeMORRzNCeBEiePbj+Xczxkrr+9C6VqdKfQ/yhR46IcHO0bT7nHUl4cSxrWUDor6HdGpIiz+odaIzhSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293880; c=relaxed/simple;
	bh=O1ivOdeYSLggUD8Nc7bkBkbTF2VWoFUKm4hGPCQpG7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euBC/0jpKQqJ33T9qY68xnwIffAE/mcUYU4U4xMyKPddCh4bTX/J6cloLOEVn41VqDeSjXS5Q5vKX6A5rpL0uYOgza/mdskG2AOZBvxvHGKkn/EulaPooHFbgrYBmzDzn68P2f949caVl7PkliY+ATw5CWRgkFjxcP7minz/upc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=KpH/WK1W; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KpH/WK1W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751293876;
	bh=O1ivOdeYSLggUD8Nc7bkBkbTF2VWoFUKm4hGPCQpG7I=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=KpH/WK1WBpre4INUypR7vEFvNtSo38xss6xlBnNVtTwEU3yg4gP09ZzCntZBMaCSo
	 //XVk9PToI+LNwrxYLPiJrW8bSfWDuedtvqNV6oZAwu006rQE+4OUL3taFp7qmQK0b
	 wFl+aN0swgaHnzCCtsRbM/67T4sUEOsatCEodqSlLvQ05FQtI9NQn+lMGR30Za3ThM
	 Ei4gXZ6AYoUw1NOERe1kwv9hsTwmXBIwKf+rn27IXjmsnsRsNy6g6XRuIYzMB45uYz
	 RCNo3obJ/q2rWHEjVcuu4kkBY58Pd1tYIHmjqtOnpIGG1QBUuZwsJM4ikfBUVs4O22
	 fL9WJ9RsaEHga5E2hr0adm1pxPjhUdS+fVnsiZ4t4aYmwglxCdez+2AfsseiJGBxD9
	 7ybvbSSTFqa6NfWVdoZ3BW24UTS1zHQCAD1ivgdR0E2K6X6ls3zln7N9iSGo5sIntP
	 Ld3C04AonrnziI48/gqWrnk8K+3RUAgwq6uGeevUGxj1Ld1WpwS
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:8741:7f1a:929:ce34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E49D520067;
	Mon, 30 Jun 2025 14:31:16 +0000 (UTC)
Date: Mon, 30 Jun 2025 14:31:15 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: git@vger.kernel.org
Subject: Re: Failing to push to a repository erases authentication helper
 credentials
Message-ID: <aGKfs5VRdmnw6Pqc@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	git@vger.kernel.org
References: <aGKU-o9eXB1VHuN9@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DPifmrdK+lY/a7as"
Content-Disposition: inline
In-Reply-To: <aGKU-o9eXB1VHuN9@kitsune.suse.cz>
User-Agent: Mutt/2.2.13 (2024-03-09)


--DPifmrdK+lY/a7as
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-30 at 13:45:30, Michal Such=C3=A1nek wrote:
> I was trying out AGit https://docs.gitea.com/usage/agit with oauth
> helper https://github.com/hickford/git-credential-oauth encountering
> this bug https://github.com/go-gitea/gitea/issues/34583
>=20
> When doing so the oauth helper asked for new authentication, then for
> some reason I was asked for authentication by some other helper.
>=20
> After that pushing to repository to which I have permissions asked for
> authentication again.
>=20
> This hints that any failed git operation erases helper credentials.

This is true and it's by design.

> That does not sound like a desirable behavior.

It is in fact desirable because otherwise the user continues to attempt
to use the bad credentials and then can never again authenticate
successfully, since they are never again prompted for credentials.

> Could the previous credentials be preserved?

Git doesn't have a behaviour to do so, but you could of course craft a
custom credential helper that just rejects the erase command and passes
everything else through to another helper.  That would achieve your
goal.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--DPifmrdK+lY/a7as
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaGKfswAKCRB8DEliiIei
gWZ3AP9GWI8liSgPl+Exbe60MiRN1RfT75wMx8DqHLSoOicTCgEAowG94sxJexCB
n3I45d5UYDBcLKSgnJvHFFcGqgZAKwk=
=Tv5C
-----END PGP SIGNATURE-----

--DPifmrdK+lY/a7as--
