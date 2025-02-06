Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDB323C390
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738880288; cv=none; b=fDnvNkJLg+obQODgVKr01z2GEXYsJXpuvVsojA+UrBv8+cbBnEJg4TFFQZxRHeHLsFAxKCOv1MVpcs9EKKr7JEx6tyiNjsp6je6hrT6Evyw/G3QqTM1MbecIg/GCD4NQUAugYxbQ4K3k60x7wVhJe4tUOaS5hwxCLkFWj9Q319c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738880288; c=relaxed/simple;
	bh=A/RNyfNtfN8fjmJbR+UBYJQtCcm39cDUIvVupFnlXGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4HG0kDmihtPThQom0jxR1ck/5UDsqY0zB2uNxo9USjTxhntA7+N0ofkkHEs3SLBw1mxWnzuWYl2EQOUzdYHXde1uYFyqD4IGJo+xz8nXtlHPEM4iVLTBBfN/MuwskYR/evW52mT4Qzf2F2RYkvN7a2bRhudE7sSECDYBLY5ztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=kcjskLM+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kcjskLM+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738880284;
	bh=A/RNyfNtfN8fjmJbR+UBYJQtCcm39cDUIvVupFnlXGM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=kcjskLM+pXkvV8TDToLYM+608BxiOMqRkjgidOzui9mtGl+CqgooYU48M2N0aXqGT
	 T0rOv7cQxXmP2ylefQWu8LBFoBsz84iaiAFpYMB6Eggydg9UzYFjmgB1XrnTrhpxpq
	 JHSm2vAtVdY2he3DJFgWIMQwdyobAha3Ft3CyhwtEWLPceLcbxvmhZFEIU01ivvkfY
	 2fokdLxF2kDvQRnGAb0yj3vB+GwY3jCu0XbohzVKdWnkOFEX5Nid/N2dCidDv9xl+q
	 sR9hf/9vcgN7mcnuUrsfj3xaGY+mgGo+FpH+beYOKs/VBdtc1pbQfXg2zIiwbf1CoK
	 BiUhMJ3p9CWIdxqr+gsiNxTMRbFPJtSJKtsnWTXF23t08dXqgShCIxdBotuTNue1wy
	 8sxPRIgveHj9AdfBq/Kj0vT9yQADbrJ+lxV5VLSopWSaAFWMdu5mq/i0t47FlN5uue
	 k6p9n4MdeuhEMm6mYFY34HlDwEGYAFVYAbFVZeb0Sfmbru8KwG+
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 052C720076;
	Thu,  6 Feb 2025 22:18:04 +0000 (UTC)
Date: Thu, 6 Feb 2025 22:18:02 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kapil Somani <kmsomani@alumni.ncsu.edu>
Cc: git@vger.kernel.org
Subject: Re: `git p4` broken on machines which do not have python on path
Message-ID: <Z6U1GoGVA7IiPg3A@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kapil Somani <kmsomani@alumni.ncsu.edu>, git@vger.kernel.org
References: <CANF_+=4dG7bVF5n+s4ezHR=HneeMgvYNhsOjsz7e7bFapG2f2w@mail.gmail.com>
 <Z6QUeaoH_tV2ncwn@tapette.crustytoothpaste.net>
 <CANF_+=7hM7QqLNE3d4=UO-8erYoeQwYG5SrsDTXtgqZq3AKJwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KB+bf0mUmZfM8btC"
Content-Disposition: inline
In-Reply-To: <CANF_+=7hM7QqLNE3d4=UO-8erYoeQwYG5SrsDTXtgqZq3AKJwg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--KB+bf0mUmZfM8btC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-06 at 02:12:02, Kapil Somani wrote:
> Thanks for quick response Brian
>=20
> Yes, our team compiles git for use within our organization.
> I'll reach out to them and see if they can provide path during build.
>=20
> Meanwhile, I was able to update copy of the git (compiled by my team) to
> use python3 on shebang line.
> It appears that the git-p4 is compatible with Python3. Is git team planni=
ng
> to update it near future?

It's my understanding that it's designed to work with both Python 2 and
3.  It's unlikely that the shebang will be updated until it's no longer
guaranteed to work with Python 2, since `python` is more generic than
`python3`.  When that is, I don't know, since I don't use Perforce and
don't maintain git-p4, which has a separate maintainer.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--KB+bf0mUmZfM8btC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ6U1GgAKCRB8DEliiIei
gY92AQC9dA7ECbHqD00gHCPug8HcbAYk+6JHNh5Hq0JM5JKmhQD/T8H/ZgBClW7F
g7L3OIpdpxPZiRJJmBncsRIS44F+lA0=
=2qh1
-----END PGP SIGNATURE-----

--KB+bf0mUmZfM8btC--
