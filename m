Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A83A43147
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766769337; cv=none; b=OZDAasx+QMyGSzKqafvqX/V0FzKrd3ADh8oFptUhZDuli9Wvk3W08tWruqxCJO9L2mIisYLeoMmue8s2Zd3QhvQrZId88xultLdgXaHiQ7Duo4P4p9OS8wi556EMAsiQg1eb7VjOtC+HDkbdfYpAQ8qTpZOSzl+ObYKMC3uZbUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766769337; c=relaxed/simple;
	bh=Ly5TbsdK7J7fvGP5hmpSEZrzoewb020WdepcIKCMXuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2cp1fjogVfoePOsHV1GYSmvXY++mTMgqwIKrVIHsIp4QHCiiOsdy0vPBvlCt6FJN6B2yAMuWuW4phs8ZdFRQhmdX6cAxEbzYHGfU+dndyYhUd3XGyoJI/BjcLkDfmzoG+USd6yQLCbfkiys3NMyLeEQg/hXISWdPPoBdd0xmes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=jemldfy3; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jemldfy3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1766769333;
	bh=Ly5TbsdK7J7fvGP5hmpSEZrzoewb020WdepcIKCMXuU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=jemldfy3Qd5KaL1OA4cZm424AtOafWjlGll9RnzqJRZ2fSNApp6GjmcrcnvlFCxVC
	 XV0d8tLA7ugsAxQDR8C78CqAybVmgPFNEGpRPmpBOxqcPWuyKAIS3HYxdVPxfKKZQx
	 A7vq7O5GEBbqYfk7kD0SOpuktQ9WRz3ypO2gjNx0FhP7I9dRuWgl7D4dqMGjGKSxch
	 X5Snzr1kHQ19quK2yztlPY7Gx5+HVoVoNLPXZHo8FwjSrJevxFFnBiBpfgs/ygaCdb
	 CTxZpZrAymhw9bXKdLXzmzsOH3F+Ob0jMHy2z5DFSzu7mLRe1VHE21Pv8D8i+NmoHl
	 b5OGF8pGZ+2wNeVLvk6m2Yj5/weMhabjYmF1vdZ4WXMibskZF+CpCRKZhcAwaNMzTp
	 V5MextRMCUEGD/ZzDwhSXmZ5ecJkdOX+42dVqfg5jP28BsEqGyCu3XvGfJ9kKza6ai
	 /jvRT9GGWy2kCzpk2jlvoBSTLugPcGPo40aD/fkrjWIQoTfLc4v
Received: from fruit.crustytoothpaste.net (unknown [99.209.153.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1B97D200B1;
	Fri, 26 Dec 2025 17:15:33 +0000 (UTC)
Date: Fri, 26 Dec 2025 17:15:31 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Martin Fick <mfick@nvidia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Message-ID: <aU7Cs2pXiXInfBh4@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Martin Fick <mfick@nvidia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>
 <20251226044507.GA1971832@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y6s6dvLP4e1b6kH+"
Content-Disposition: inline
In-Reply-To: <20251226044507.GA1971832@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--y6s6dvLP4e1b6kH+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-12-26 at 04:45:07, Jeff King wrote:
> On Thu, Dec 25, 2025 at 11:38:30PM +0000, brian m. carlson wrote:
>=20
> > I think this is from `should_pack_ref`:
> >=20
> >     /* Do not pack broken refs: */
> >     if (!ref_resolves_to_object(ref->name, refs->base.repo, ref->oid, r=
ef->flags))
> >     	return 0;
> >=20
> > So Git is going to need to verify that the object at least exists.  I
> > don't know why we would need to _open_ them, however.  Perhaps someone
> > else has ideas.
>=20
> The packed-refs file stores tag-peeling information. So pack-refs opens
> the object for any newly written ref via peel_object(), which has to at
> least read the header to get the type. That call happens via
> write_with_updates() in packed-backend.c.
>=20
>   If we wanted to be really pedantic, anything in refs/heads/ should not
>   point to a non-commit and thus should never need to be peeled. I'm not
>   sure if we want to embed that assumption in this code path, though
>   (nor would it necessarily help Martin's case if the refs are not in
>   refs/heads anyway).

I don't think that would be a good idea.  I know that people definitely
do updates of the loose refs by hand (although they should not) and so
it's entirely possible for them to contain invalid values, such as
having branches contain non-commit objects.

I wonder if reftable would avoid the need for this kind of expensive
check since it would already have the data peeled if need be and
wouldn't need to recompute the values.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--y6s6dvLP4e1b6kH+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaU7CswAKCRB8DEliiIei
gUTkAQDQoQJs4NtA/9t0sux2/zWXqh6bKOBF8T0MLUw27gBiTwEA2zLdZuOvwL6y
GhfPBhLJdMR2HwyW+ITV/L0QTD1xrQw=
=RPlZ
-----END PGP SIGNATURE-----

--y6s6dvLP4e1b6kH+--
