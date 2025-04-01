Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28951EB1AE
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 23:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743551083; cv=none; b=R2bsbTiUBfUSjbk1eKAb3pyKVSWplux1TX0wpqKfeXVPNveb+NKfIbbN3lue+Ga1A5cfLDPyHmS2gBxS/WrEHzK7fcGAqGw3KpSk6qibbCXUhugOWyfjQwD+00AYjFzT4ej8Eebkd0OGw02Fb603PY6p1loaPNEx4a/Te6eszLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743551083; c=relaxed/simple;
	bh=i4zx4REa+nqYc1yLU+mEsJRlGcIa5BIYlUQd37RLQRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3rGVhRTegNvcbaCFXMacvzaE2WWQpWNOvOQSSGYRFZ6f3ThfJXi5DKnNmsxEhy/ToOa4IE8vps4XrwclIi74edJ6234/KWMzNfhpvVklgM+iS0sSNhzzo1XJ92v9uLS2tQdBCFkh6EBFM5k9v6h1Ll9TL2b2c0RxXf3gKrysWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=XamAak9+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XamAak9+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1743551079;
	bh=i4zx4REa+nqYc1yLU+mEsJRlGcIa5BIYlUQd37RLQRk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=XamAak9+g7/Rdnc3rx4hT6YhGHQ8RLLmjtShhp2RPRkD3n1Tf0c5TpKF+dR5IDqI2
	 ycUH4CuE+GB7kCEynYf0CpMGc7deyZsxTUakc81uLdR6Z8Idinbhq9BORFfNabBvGP
	 h3uyWBS4Lvn8rxw6wM6IVzJ5pi6b6Jiq83WFEgIYuwdxN/yelS/eBZZfk8xvVaBw+E
	 SRssp88+0uXnPII+rHmWBuZ22loU0/Y2fiPTS3uojD+ZocKPzzF9zTTf11Q6pE5vmT
	 irwN/B4Vk51636sDDsFKZYxp6bLDS284380WAwzLZV3TzSxjBQJSKpAvIhR3y17ag4
	 rUejQ/QFf3i/IiJYAaCdCGnFudS10Djg5QM1n6W68onDOh9s2KMul+nP4hnBHA4nRZ
	 JDKaFZLw0BUl9OcnFYwxW1SwoP5FB24XVAx1sVe0LZ9YY8L33XCfvDotmwgtWYcaLg
	 vIyGNFxKcXMQSndqEUm9GrVIWs8hvqnNMRUjsxxgtMNdSm87U8q
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A392C200BE;
	Tue,  1 Apr 2025 23:44:39 +0000 (UTC)
Date: Tue, 1 Apr 2025 23:44:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ramkumar Ramachandra <r@artagnon.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [ITCH] Redundant rebuilds when rebasing outdated branch
Message-ID: <Z-x6Zt7ljBj3RhSX@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ramkumar Ramachandra <r@artagnon.com>,
	Git List <git@vger.kernel.org>
References: <4f142817-49a7-4079-b7b1-e54de36a6242@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="REL7beolNZ0asW6q"
Content-Disposition: inline
In-Reply-To: <4f142817-49a7-4079-b7b1-e54de36a6242@app.fastmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--REL7beolNZ0asW6q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-01 at 10:54:15, Ramkumar Ramachandra wrote:
> I think it would be preferable to have something like 'git rebase-checkou=
t', which in principle, creates a new branch based off 'main', cherry-picks=
 commits off the outdated branch, and renames the fresh branch into the out=
dated branch's name. It should be possible to script this using the existin=
g plumbing, but I was wondering if something like this would be useful to h=
ave in core git?

I think `git replay` might do what you want.  It operates as a
non-interactive rebase which leaves the working tree and index
untouched, and updates no references (although it's designed to be piped
to `git update-ref --stdin`).  It is experimental, though.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--REL7beolNZ0asW6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ+x6ZgAKCRB8DEliiIei
gRq/AQDVjb7RqsfdRVndDqXqLH2WhQkzPwRXrT1mPmkd5XfcKwEAswbfOZk4bXW+
H6DFtkIccryd3zgJ3CnRQCbAGj3+wQg=
=iM7O
-----END PGP SIGNATURE-----

--REL7beolNZ0asW6q--
