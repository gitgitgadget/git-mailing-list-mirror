Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BBC15B968
	for <git@vger.kernel.org>; Wed, 15 May 2024 22:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715811935; cv=none; b=fHfKkGdxHcmaAfLTbSVN6fYVxB5TLChKk8QqrmsvScECLptGa16Nl7GAB4zjoE8doTAk+jpU7i6voYUE0NvD4NCbnV7fkOqkiI90K9UuTwOhEYvI4LIv/GzMRQap9F1/eLtQUutVJjkMCnjPzAUXgHIyMSfKk85jJ1546UoS71Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715811935; c=relaxed/simple;
	bh=O9clPr1ulh1AX7wb5p+zHTcuZFcmi6vCT3VjLNT9AYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRJoueZIwmQEj2h+XZcxT/DcfB/5NhHv+HFYJ2oipag7hhFbwbyq3vzRUPqeeX1nbCcno7lu+p80UcCdvnPZjxlSwqQP1N/mvOCje5lwdtPjpnk5FtoRsVWZcX3fRnjWtVZVKMnh6qGlqwoEpvfBHdnYLi+Mj/I7urAHKGu3ICQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=vcF21GXt; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vcF21GXt"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id CC29B5DA8D;
	Wed, 15 May 2024 22:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1715811926;
	bh=O9clPr1ulh1AX7wb5p+zHTcuZFcmi6vCT3VjLNT9AYM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=vcF21GXtC5JDEBH9IAjk6TdXObUYjlidxg/o0A1AsjXUsPvfjhaJMY6zChNhEF5F1
	 Rta7ZFOibDBVMJ0vL0CEcMXY0jYEJ2xcqVKCFK1r4mlIhj6u5iM92OtX9htvvq6fMK
	 o1OXqkVlZNv0KljVKvyaG8ZP6D4BRvN6U7AnYNHwiES8bTD70vL+IUqvonCVOh/w6G
	 oFdgLuo4n0sgoz25IDCLBQvsZlO4qmaZmnxI9sEDcUdd8e/J1ZDc0xEcar1bFSGJBc
	 L182G+JbIxnbNQYGsItHNYTqJexxbMETHlcAdcuDfixzLnYaTOZuZiANIXxA5Gr1m6
	 qd8TNMD4CD0dm/aYyveNI6TgjTqKX/6KbvMXqdo2i9pfxrEByysm4XYtMT/wE+ZHnm
	 k1OhZzG2QKirkzb5epowI99Dq0FOmuTcYKmTottuNsrtjumrGFeX08URQpINA6jt/f
	 D17FTj3R8znQy8bafPOTHwZ6/TMMAKfRiQF5hQprZ9s7phiykPY
Date: Wed, 15 May 2024 22:25:25 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Brooke Kuhlmann <brooke@alchemists.io>
Cc: git@vger.kernel.org
Subject: Re: Git 2.45.1 - What is the right way to clone with global hooks
 disabled?
Message-ID: <ZkU2Vao8yBHYdUmJ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Brooke Kuhlmann <brooke@alchemists.io>, git@vger.kernel.org
References: <FAFA34CB-9732-4A0A-87FB-BDB272E6AEE8@alchemists.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1Ke53gqw7o2wrMEW"
Content-Disposition: inline
In-Reply-To: <FAFA34CB-9732-4A0A-87FB-BDB272E6AEE8@alchemists.io>
User-Agent: Mutt/2.2.12 (2023-09-09)


--1Ke53gqw7o2wrMEW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-15 at 15:53:26, Brooke Kuhlmann wrote:
> Hello. =F0=9F=91=8B
>=20
> With the release of Git 2.45.1, I can no longer do this when cloning trus=
ted repositories (my own) for build and deployment purposes:
>=20
> git clone --config core.hooksPath=3D/dev/null https://github.com/bkuhlman=
n/infusible
>=20
> I have automation in place where I want my global Git Hooks to be ignored=
 when cloning like this. The solution is to do this:
>=20
> GIT_CLONE_PROTECTION_ACTIVE=3Dfalse git clone --config core.hooksPath=3D/=
dev/null https://github.com/bkuhlmann/infusible
>=20
> ...but is there a better, more secure, way to clone a repository while ig=
noring any global Git Hooks from firing without a lot of effort?

I think the solution you have is the best one for 2.45.1 right now.  The
patches which introduced this change also introduced a regression with
Git LFS, and I've proposed two revert patches, which would also restore
the old behaviour for you.

My reverts are somewhat controversial and there's been two different
approaches proposed, but I don't believe they will solve your problem,
so if the reverts are not merged, then I think the solution you have is
the best one for now.  It's possible someone could send a different
patch to address your use case, but I don't know of any plans to do so
at the moment.

I didn't see my patches in seen earlier, but it's possible that Junio
has just been busy with other things and may pick them up (or not) in
the future.

If they're not adopted, while I'm not personally planning to send
patches for your use case, I do think it's a valuable and useful use
case for us to have and consider, so I hope someone does send a patch
separately.

[0] https://lore.kernel.org/git/ZkO-b6Nswrn9H7Ed@tapette.crustytoothpaste.n=
et/T/
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--1Ke53gqw7o2wrMEW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZkU2VAAKCRB8DEliiIei
gVj4AQD8gh9lGu8NvZG6mb1HrfbUzUCvJEAM5LU4A0Wvbr42uwD/dyDVEeiuLaW/
rJ9OhMVicVNSObkzxNoptW2ytrIPpwA=
=KVek
-----END PGP SIGNATURE-----

--1Ke53gqw7o2wrMEW--
