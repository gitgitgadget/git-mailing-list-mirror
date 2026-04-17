Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EED3B9D9D
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453520; cv=none; b=oa+Y03ARVRuxjYB1bLk5/1G30BIT8aEvdW8gNx4Mo2gI/PgEQZiWVCu7eR7ZKxcX2y3UVsYnx9vVLvTKf6JmeiqnAb8iHfaO0KG2Wr1JGaWOZFYbqUIh1fhDChd61HKJPfw5MrJmzzMpZZCamEZ1fVp6nuSzL8kpU2bVOAba9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453520; c=relaxed/simple;
	bh=7Ybo0TeyZwLO6Y1cpdVfXHrdK6/k2GgPqR4IOWdVwEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6XyZMbUbl6yuakGs7fRXO9243GbyQ+HZfSLlXx0rxp82vaB3il9kx4E69bUWtXcz+TFSPMhjS7fZu0gnE0p5UFbmH3W8WinUcynauyPvf0fFf0F7ksm9rfbmQDThYLdv3/jmn2UMh7agRIvuBmKP0MNJLr6RsLczCBVCN6T9Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=T6V3rPfh; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="T6V3rPfh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1776453509;
	bh=7Ybo0TeyZwLO6Y1cpdVfXHrdK6/k2GgPqR4IOWdVwEs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=T6V3rPfhdpz3KtmsFJMmhYFb/C3D1O1rnukNdqUz7Q1wQuNW23gL9dAaBisgf5MK7
	 5mUxILnhzqdfdr8gYAluReXXI1Zs8uJ3HfzjYGo+sQWRCgRHYMHrLG0/nmVGNDSHdb
	 jwAmtpR3ejLZ8O0bWUzxZwZUAZUXGr8DMmlylBOBioNGNDo557MtwM8N6Gz9PsqbNU
	 S3HRXPbMtPv3AtCLLOFKJTUlTCrDQa40COaS71dRdy8TX+wWHfHRl/33HbWLpF8al5
	 Afd24hj1V+6AtqbyZ/ehxz+Df3e1Tax77g05ke5wjMKKZfXYUthHle7lO1AfqTgwur
	 fq34PPCd7APVeXK9JnC+F+6qZU7hPlebxeTQ/8RU7CPwEy9JdP/fjO/W37dGqp6TIZ
	 NGlDmCmSLUVeggUwXKYPD/ar2vgc7579x3b3D3dXuQB4YGAbxql14V3dn1XzcXMWAe
	 A8n42a2A/4LEdMZk7yax1LgcDSmqvsb0j2e5TGCdSYF9fPPYSfX
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:80df:d30f:2b85:39bf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BD8D9200FF;
	Fri, 17 Apr 2026 19:18:29 +0000 (UTC)
Date: Fri, 17 Apr 2026 19:18:28 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <aeKHhHVPUxqMa18L@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im>
 <20260416-pks-libgit-in-subdir-v1-2-03afc731df55@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L7J2ZeMThq35t4os"
Content-Disposition: inline
In-Reply-To: <20260416-pks-libgit-in-subdir-v1-2-03afc731df55@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--L7J2ZeMThq35t4os
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-04-16 at 13:24:31, Patrick Steinhardt wrote:
> Introduce a new "lib/" directory and move all of our sources for
> "libgit.a" into it to fix these issues. It makes the split we have
> evident and reduces the number of files in our top-level tree from 550
> files to ~80 files.
>=20
> This is still a lot of files, but it's significantly easier to navigate
> already. Furthermore, we can further iterate after this step and think
> about introducing a better structure for remaining files, as well.

I have not reviewed the details of the patch in general, but I think
this is generally a good idea.  Most projects in non-C languages put
files into some sort of directory structure which seems to help
organization and discovery, so I think this would be useful here as
well.

I'm also fine starting here and evolving our directory layout later on
to make things even easier to find.  I suspect upcoming Rust code, which
has a more rigid structure, will influence some of our C layout as well.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--L7J2ZeMThq35t4os
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmnih4MJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ6d8j1QqhNarhXRxf27c1SCxgzgEm3951w8c7wxh2poL
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAOHEAQDTpYMBk1m1Ku/CP2sC0OcmPWy5
hbxzFRnwQbwjecic4AEAxfHOPq/EB+uV7GGllY856hyHP649iySsYmHXSoZuFws=
=78qT
-----END PGP SIGNATURE-----

--L7J2ZeMThq35t4os--
