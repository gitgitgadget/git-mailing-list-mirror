Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B8B2C11E4
	for <git@vger.kernel.org>; Thu, 25 Dec 2025 23:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766705920; cv=none; b=lRyZb2HvXhJy2GWuYEVnPIK+m1dmkELR6347rklxJAmhfIO1L1OFWaZ1Sg3Kkrh+EztPt5yF+eyVzRy3gQ4bMeY5cE7xb44IscGHYA9Ls1t47WNhq8MrwTXLvnp2jVx9wHj4ddTAmkUkGLjRIF6sQ+YhNpHI2lqLjCycYnOjaSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766705920; c=relaxed/simple;
	bh=eDHqEZCJb8/5E2ZfDbhafwa9f+/M+QwDDLU3b/tEbQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/JkP6FCx5r6Sho5tEz5tj5aer0JJzfBXxT3rEIcTWHGkDciUAUC+OHsWHIlVXdxAGdnu9J/NGpGhcdYKAXmqbjyM6GEC+rnu0WKNEvPPuZ7lbzhAuYOFLUsMbGd02Rnr+6RdHlDdYeV/X7YYfqoLY+JWrs6ELTmmQpxORWdAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=oq9YHOkf; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="oq9YHOkf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1766705911;
	bh=eDHqEZCJb8/5E2ZfDbhafwa9f+/M+QwDDLU3b/tEbQ0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=oq9YHOkfUC2nWnZnQfg+zUZvVHF5fAQOW9iQa519YTyeBnLa2T+8YVu7E5NnYoCsp
	 uW2PV81zfrXWsUA0u/BALc7nLfaN24ajcLWvvMgD7nHHO14cxGDfHhwXx9D/MIgr+N
	 w3NQlBvt3bs0QN44KcUb6LvH3y62+w+H0Qn+xQwXVyqLco/J9ihEfyMvHlbZU9kZO+
	 3fB3rDG/p8Qfqu0rwictSqFAXDmlnkfB2rMWPoR9zttf/r1u8cpwS9GOy9vL24Q2JF
	 +1FDXWlqy8LtixUc/BxKSbaczi4TUEyi2CqCgcrt1BD0jKdW6/2XEgQBsdgzrzi9BI
	 Vibx2zbg8wZKVmOWq76a9VR+wPnF/Qew3s0+sRZTacXzPDeURiaFw/SwPCfdQeGUik
	 WqBsyeYjqzHkVB2z2+D0WBoPPTyieVItH8akZmXX1/UDy4sKQS882v53UtzWBSgc23
	 U5ljxPLQ38uiafIrbIMKJq3K5PAGcYEpvg9xRZS7vJiHbZhFoyp
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f8c8:2944:974d:642f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4C64020079;
	Thu, 25 Dec 2025 23:38:31 +0000 (UTC)
Date: Thu, 25 Dec 2025 23:38:30 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Martin Fick <mfick@nvidia.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Message-ID: <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Martin Fick <mfick@nvidia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7NyIB1DnU5168lAu"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--7NyIB1DnU5168lAu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-12-25 at 22:13:54, Martin Fick wrote:
> Although the packed-refs file is large, copying it takes less than 1s,
> so there isn't a writing throughput issue with the filesystem.
> Additionally, jgit can pack-refs --all in under 20s on the same repo,
> so I don't believe there is an issue locking the 200 loose refs
> either. When observing the filesystem, I do see the packed-refs.new
> growing at a rate that seems slower than expected as if much more is
> happening while writing this file, than just writing the file.
>=20
> An strace shows about 200+ open("./objects..") calls interspersed
> between around ~26K write() calls. I am surprised to see pack-refs
> reading objects at all.

I think this is from `should_pack_ref`:

    /* Do not pack broken refs: */
    if (!ref_resolves_to_object(ref->name, refs->base.repo, ref->oid, ref->=
flags))
    	return 0;

So Git is going to need to verify that the object at least exists.  I
don't know why we would need to _open_ them, however.  Perhaps someone
else has ideas.

> Although the repository is not in terrible shape before packing refs
> (~1500 loose objects, 37pack files). Surprisingly, repacking the repo
> first does speed it up so that packing refs then takes under 20s.
>=20
> This repository is on NFS.

That's almost certainly part of your performance problem, too.  Loading
a single pack file and index is going to be way, way faster than making
lots of network calls to open 37 pack file and 37 index files, plus at
least stat some loose objects.

I will note that at least some forges always have Git write pack files
and try to avoid loose objects altogether since that almost always
improves performance.  You may want to set `receive.unpackLimit` to 1 to
see if that helps in the general case.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--7NyIB1DnU5168lAu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaU3K9QAKCRB8DEliiIei
gbTtAQCjXklCuvVp1rghlKGdSQKJjcdmMYdOAX/w4pSqO/NgtgEA/QcC7q0TtONY
gV8dlauTRPUgeILxOi5VP4AFynr17A4=
=JhpK
-----END PGP SIGNATURE-----

--7NyIB1DnU5168lAu--
