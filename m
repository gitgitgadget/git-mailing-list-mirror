Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D68175A5
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 21:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759355134; cv=none; b=jVdZtFym/p0IZhbUkhGCVjn2mGG8kA5xd7Bph84rGBZcLVlXLjt2c6EjU36t7e51WbptM5hAMJ164NV7MjnHOO8CKb+dn4HDFRNCEWZAH3fj/gblUHu1su/TTIRDX0VhKUvUrKbkEX8RDKXtJ5QIblRU7CWa6annQSHyNUYcetI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759355134; c=relaxed/simple;
	bh=99GWqKNxb/IG2llR2Khii4+XNH5H2hkKwENYffEsHuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzJE2XsWBG24cmObJHuaxYpyF8CpW8vgTScbkJTeapYIrXNpT6CoIK6BlQU1I2C8JQph6sJJX7YKNJrhfgsKIsfUpR2MtfKU/3Cz9wZUsz4SvX755rZG66QMq9LQgYem2Y9Q3BnMkhDRp6KsP9rNPL347nfBDNVU5ztI45LYXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=s/IM5YiF; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="s/IM5YiF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759355130;
	bh=99GWqKNxb/IG2llR2Khii4+XNH5H2hkKwENYffEsHuA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=s/IM5YiFSd7TU52nQUNXgi9j39Oa1k+W9G+kqKIkQNE+dbNTp0yErS0p4xew3CkNM
	 WBH/yBT7YCjiz+p0qe1M9doDRNBpSYktYdK4m/GiqKI3BrpkyfhSqccroWzHpVJr4f
	 e7E2lfxAZ8KaZgRHj+BjtAiPHVwGaFpQTyiLjKcPTCC1HHHn/iv2GdzmrOV2w0RooZ
	 XoSeBWqkxAY3ZgILFco81kxOdnpdPA1XIq/YvoBFLvnwKLvjMLnT1DKXxXoLJqn8xx
	 SQ3JO9+uRlkQzxMGIL7vdMJhy2d08wsxuQfuaRJ5TTBA8XFhTciCwwvLzgIXpBm5XZ
	 UyUE9m3nD/lZf9OPuTbP2NM/6Su4uatExlSt6NdWCrMO8hbQY98x8n7jWu8UpqGMfW
	 xSzpCzAsbl4JeBRh80YsLi2DSg2Hjdhe3BgnYNuk9ekGXZNVsAMIB0bnw8PvU8J57z
	 NwnUWRBaeNVLZ+CjTI9C7aib7MT0bd4lzkC20OqeuxdORw5VkwY
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:eb6:3c64:95b3:ebcf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A7BAF20119;
	Wed,  1 Oct 2025 21:45:30 +0000 (UTC)
Date: Wed, 1 Oct 2025 21:45:29 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] Define an extended tree format
Message-ID: <aN2g-RCLVuUYD7h2@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20251001005814.846992-1-sandals@crustytoothpaste.net>
 <20251001005814.846992-2-sandals@crustytoothpaste.net>
 <20251001174110.GA137600@peff.net>
 <20251001211140.GA140550@peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BVrcaWl7byICx4ii"
Content-Disposition: inline
In-Reply-To: <20251001211140.GA140550@peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--BVrcaWl7byICx4ii
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-01 at 21:11:40, Jeff King wrote:
> So it all works as expected, but I feel like it's mostly by accident. My
> gut feeling is that we probably wanted something like this to protect us
> from confusion:
>=20
> index 06ad74db22..295b0c6318 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -719,6 +719,8 @@ int add_to_index(struct index_state *istate, const ch=
ar *path, struct stat *st,
>  	if (S_ISDIR(st_mode)) {
>  		if (repo_resolve_gitlink_ref(the_repository, path, "HEAD", &oid) < 0)
>  			return error(_("'%s' does not have a commit checked out"), path);
> +		if (oid.algo !=3D hash_algo_by_ptr(the_repository->hash_algo))
> +			return error(_("object format %s of '%s' is incompatible with this re=
pository (%s)"), hash_algos[oid.algo].name, path, the_repository->hash_algo=
->name);
>  		while (namelen && path[namelen-1] =3D=3D '/')
>  			namelen--;
>  	}
>=20
> Of course that is strictly worse for somebody who is relying on the
> current accidental behavior. ;) And in the long run, I think this is the
> spot we'd want to hook to do whatever massaging we need (whether
> converting to the equivalent in-repo algorithm, or hacking up the name
> to store the foreign hash).

I think sending in this patch is a good first step right now.  The
intention of the transition document is that the code is in one and only
one hash algorithm at a time and it would be better to reject this case
until we're ready to wire it up correctly than end up with data that's
corrupt down the line.

> I also won't be at all surprised if you've run across this already in
> your interop work.

I have not, since it's primarily involved working with the testsuite and
some test repositories.  I know that submodules are broken in interop
mode; I didn't need to test that until I was writing code to make them
not-broken.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--BVrcaWl7byICx4ii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaN2g+QAKCRB8DEliiIei
gUOhAQDLEX0rVd7z699LAeZ4L9EOrcH6CgEKhOoxVPiLR1LfYgEA0K9fC331WPh5
NiB4o4+yxegPrxDaBSP2OKXPHeuzQA4=
=0CbE
-----END PGP SIGNATURE-----

--BVrcaWl7byICx4ii--
