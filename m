Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D3921CFF6
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754001487; cv=none; b=XCxzVBoJTfut1BHEcnrTn9hGyJeZfSexX3WPiKtwgKNuKIAmSF7oynZgz96hw3FTSwdy/URw2lPsubWLY8saN0LXmL199GTfPrW1X9fw5hcIouxUrAKWqaYwtNDELfZtreKJdanNYaWAfsol/1GdWU900AWwL4P/80fqERIzeAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754001487; c=relaxed/simple;
	bh=FEptdWRmBziSSpmcnfJFcf4njV0PJnGDe1yE4DRmdaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7881FTPvwxPfN/BlEPSYDFkZUcTedJ4f05cRiW4Qn5w/Quii0zh/Ag1xAOhgAGFuzbZtlW4YI4nIZqtR0wK3Umdqj3SSycxBgkExeVfrjBPIy9jg05LJK28p+aG4d7HYsqyqRnoSnMp/r0C5nGpPoEmYdjI24Pj2UPdSodenQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=EUOO6dKJ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="EUOO6dKJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1754001478;
	bh=FEptdWRmBziSSpmcnfJFcf4njV0PJnGDe1yE4DRmdaQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=EUOO6dKJc6wHgo33mWr7w4qHDTKuwLiUO0pI3Vv9gOFaGBrr4ZWPrqtLPzuu5jqbK
	 7+68DeYWY9LUiuSrJOuOOuFs+gOZMHKRowlfUyy+4S7oEF/S86JrSC8bGzpVTVOEGx
	 eEuJ5pa+I+KaJ+U73eyd+Gd6sC/JUcEI+x6Gt4iqvE+6V0pQyok3ZTMQg31ns+29Z0
	 BzX+xDsDw0pm9qTtSEodU/sZXCuKaGY/hA+0zRta0KvZgp58MTsz26qER5cFEaLM0t
	 3PgDUDyiI5B951Gszh+BTEVyoovLAQmgmbi4kN8CuVbhaVZKu+dYoZwjeYctQVE8iD
	 ZrzK89K58OzOxCsmzuwxW/SXpmlMK3ctUI4lc+YaM9293uyp0NgtziK9pmys2VjwtJ
	 Tq9TrON1+CNqTC3w2GOcWZtj1vGYikwV74BQ8wtbGBDq+7EteqdRMfL0yDkURRtCra
	 0c+m/6O1LEM65uwAK0p3Jscy0dLGuCM88vpo8azmJhXwx+RljIW
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2600:1700:f991:38c0::34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EA3AC20007;
	Thu, 31 Jul 2025 22:37:57 +0000 (UTC)
Date: Thu, 31 Jul 2025 22:37:54 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/7] xdiff: introduce rust
Message-ID: <aIvwQtLCSNHo7D_3@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <2a1f4be13dfbdee21811b7a4907f99042c791c2d.1752784344.git.gitgitgadget@gmail.com>
 <aHlrg7pbFqi2qNWH@fruit.crustytoothpaste.net>
 <CAH=ZcbBebM6CememqOUFY2YPOXpk_mC=zE0OnLOKDqcJQTdMuA@mail.gmail.com>
 <aIFauT8M0wRfaZV8@fruit.crustytoothpaste.net>
 <CAH=ZcbBNg0Ku0VKvF0HUyksrcZdbT=8Xmk6_kQV0178ROATf8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2J1j5tuD6lzpt5YL"
Content-Disposition: inline
In-Reply-To: <CAH=ZcbBNg0Ku0VKvF0HUyksrcZdbT=8Xmk6_kQV0178ROATf8Q@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--2J1j5tuD6lzpt5YL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-28 at 19:11:34, Ezekiel Newren wrote:
> I like having the Cargo.lock file to figure out why a build worked on
> one system, but not another. After talking with Elijah I've decided
> that a good solution would be to add Cargo.lock to .gitignore and
> change the github workflows to ensure that Cargo.lock is preserved for
> all builds. We should also add a comment to Cargo.toml stating that
> any build or test issues should include the Cargo.lock that was
> generated when asking for help. What does the community think of this
> solution?

That sounds like a good solution.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--2J1j5tuD6lzpt5YL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaIvwQgAKCRB8DEliiIei
gfPKAQCFq7ccfeQgPPWhMHZbLkVIZ/CAQS+RBNPWDFhu+JA2dAD9GKegJcUExd9M
Ai77Rpu5h2T40kqZ+e/2h30D+I5ZGwo=
=WYFV
-----END PGP SIGNATURE-----

--2J1j5tuD6lzpt5YL--
