Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07857B665
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 00:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732235981; cv=none; b=IdP5SHUnzC7/Qtty/qMHWZ24YYeHobIHudUAmRVzCRIDQlBR4Sa5u4an7RYfiSSgMpSGXrX1nmFPKZetX14cvAO0xMZLLjQxjuMCr314plACyK1t9evOsTbrqeEe8Ba8vg4vzdFyj/fax0O84QxjdrEE/oSl7RmHRSik60DIWCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732235981; c=relaxed/simple;
	bh=cZJbvCZQKPhMaYybOHJUfcACQFVNtBTbd8wozlJvFjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSNWaykhg+m2B2w0MmPqO4a/15/bInf+rmB+0d4SgQuzOqJnNXCBSJpqlTYIvJCV0DkDY69uJjIKVM4a63PwEry2ltzwFrSkzNGi6XR+THoidc/d5fvQfm0GkikSrqcVthyXm7cd7qDddrgfBCnwkRkADMobMqk0BFKyyNq5ta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=aWx0T2s2; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="aWx0T2s2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1732235972;
	bh=cZJbvCZQKPhMaYybOHJUfcACQFVNtBTbd8wozlJvFjE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=aWx0T2s2TLhUfl22h4eJQrcudfC6HiXFc7l29yHYsv8qZGQ715+qb+CGytv5RKesC
	 wJysb1IMxAM+TPr3KwVjdru2EZIsX/H4ZE7YZ9GfPuSyIvY++hN8EJnDwmUnCPepdC
	 VwpCluCZsmm5JsFfxDxK7FVAFYNwxwhHG+SEAqMrERMkhy/0kAQew65I/SZi0LOe81
	 MuhDn/CwuLzXY5iL0t6PMmkHoKyQewqxGEojUKH90omJyUcj3n1xDCQvZDUhG8yqRz
	 dKzGgCUUpFgvfK35X+xihwuO20XX5PnjXJzJiSRga9IYVY7hn63gJQzjAoAwTUVvk+
	 FqUtvoUb98MED22hw+fd4NHkguPuUV02ZsTlsfhAcvph3kfVzLWbhYrTKkKVROjVHD
	 rgDZpmGjfW+hj4NbqLNdz0DryRRFhIiTWtzLbr6MejhsIyF7uuCBOKBePeKZgZbyMs
	 vgBYA8brWMoXQ2DECXKmSe6p1uCq31JBRMskcFXR9xUzOpRloVV
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:d026:90f3:853d:a63c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 01A6D20990;
	Fri, 22 Nov 2024 00:39:32 +0000 (UTC)
Date: Fri, 22 Nov 2024 00:39:30 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] hash.h: introduce `unsafe_hash_algo()`
Message-ID: <Zz_SwuEw-KYM9xJl@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <17f92dba34bee235177c8100daab49068fe37254.1732130001.git.me@ttaylorr.com>
 <20241121093731.GD602681@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nv0gcDpfxIDmVR+z"
Content-Disposition: inline
In-Reply-To: <20241121093731.GD602681@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--nv0gcDpfxIDmVR+z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-21 at 09:37:31, Jeff King wrote:
> On Wed, Nov 20, 2024 at 02:13:50PM -0500, Taylor Blau wrote:
>=20
> > +static const struct git_hash_algo sha1_unsafe_algo =3D {
> > +	.name =3D "sha1",
> > +	.format_id =3D GIT_SHA1_FORMAT_ID,
> > +	.rawsz =3D GIT_SHA1_RAWSZ,
> > +	.hexsz =3D GIT_SHA1_HEXSZ,
> > +	.blksz =3D GIT_SHA1_BLKSZ,
> > +	.init_fn =3D git_hash_sha1_init_unsafe,
> > +	.clone_fn =3D git_hash_sha1_clone_unsafe,
> > +	.update_fn =3D git_hash_sha1_update_unsafe,
> > +	.final_fn =3D git_hash_sha1_final_unsafe,
> > +	.final_oid_fn =3D git_hash_sha1_final_oid_unsafe,
> > +	.empty_tree =3D &empty_tree_oid,
> > +	.empty_blob =3D &empty_blob_oid,
> > +	.null_oid =3D &null_oid_sha1,
> > +};
>=20
> All of the non-function fields here naturally must match the ones in the
> parent algo struct, or chaos ensues. That's a little fragile, but it's
> not like we're adding new algorithm variants a lot. The biggest risk, I
> guess, would be adding a new field to git_hash_algo which defaults to
> zero-initialization here. But again, there are only three total and they
> are defined near each other here, so I don't think it's a big risk
> overall.
>=20
> I think this struct is a potential landmine for hash_algo_by_ptr():
>=20
>   static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
>   {
>           return p - hash_algos;
>   }
>=20
> It's undefined behavior to pass in sha1_unsafe_algo to this function
> (but the compiler would not complain since the types are the same). I
> don't find it incredibly likely that somebody would want to do that on
> an unsafe variant, but I'm not thrilled about leaving that wart for
> somebody to find.
>=20
> If we don't care about the speed of this function, then an
> implementation like:
>=20
>   for (i =3D 0; i < GIT_HASH_NALGOS; i++) {
> 	if (p =3D=3D &hash_algos[i] || p =3D=3D hash_algos[i]->unsafe)
> 		return i;
>   }
>   return GIT_HASH_UNKNOWN;
>=20
> would work. I'm not sure if that would be measurable. I was surprised at
> the number of places that hash_algo_by_ptr() is called. Many low-level
> oid functions need it because we store the integer id there rather than
> a direct pointer (so oidread(), oidclr(), oid_object_info_extended(),
> and so on). But I'd also expect the loop above to be pretty fast. So I
> dunno.

Yeah, I'm also a little nervous about this change with hash_algo_by_ptr.
I think we had discussed in the other thread about doing something like
this:

struct git_hash_algo_fns {
	/* The hash initialization function. */
	git_hash_init_fn init_fn;

	/* The hash context cloning function. */
	git_hash_clone_fn clone_fn;

	/* The hash update function. */
	git_hash_update_fn update_fn;

	/* The hash finalization function. */
	git_hash_final_fn final_fn;

	/* The hash finalization function for object IDs. */
	git_hash_final_oid_fn final_oid_fn;
};

and then doing this:

struct git_hash_algo {
	[...]

  struct git_hash_algo_fns fns;
  struct git_hash_algo_fns unsafe_fns;

  [...]
};

That would mean that we'd have to deal with two pointers in your first
patch, but I don't really think that's too terrible.  And, since this
approach doesn't result in an extra struct git_hash_algo, it's
impossible to misuse hash_algo_by_ptr.

I'm not a hard no on the current approach, but I think the above would
probably be a little safer and harder to misuse.  It would require extra
patches to convert existing callers, though, but they aren't hugely
numerous, and the conversion could probably be mostly automated.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--nv0gcDpfxIDmVR+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZz/SwQAKCRB8DEliiIei
gc0pAP9X15i7dBFJOI4M/jDDkaAATxJ+ZyljJ5SFMOxV0sDSOgD6A0G+tBMtRoBA
9IHOqJzymSKHJVljlkr/uv8bWiqmGA4=
=uYUN
-----END PGP SIGNATURE-----

--nv0gcDpfxIDmVR+z--
