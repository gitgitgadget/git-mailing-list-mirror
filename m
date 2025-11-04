Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA11F72614
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 01:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220913; cv=none; b=WS7BmBicRPcuLlqg28o53RgxtQUhQcmypjbQUWYAhf/QJwJ1lU3v0digTi4aQ42iD87rnBn35lRWLqj8VdbmP1pRCSneFzEql4vnngLedUT/Ahj5QUHhfmn6dgQaHsJ23nVc5vcL76Vx81PPkqPgVju35UZVXnlOjoYMkFhVCwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220913; c=relaxed/simple;
	bh=vPm6k34a2f+RIjK2DliZcjNWtXNLFh92foLvDAMdWK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3czfuoni/bz+lh8/kl3zRKNUxgXzLAiepoYJvQeiEWoVtNn6GLPSE/Rncrg9A13LVJDoTv8ynQ8pVpMkjnx/1fO6HDrDyclHU+ULWYDkqZxlbczCDIGyi7nnISb/bqAq3NVYUC/SRuoYr22GmqK07WZXzK5frGsd1XPObAqVqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=qX/kXui7; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qX/kXui7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1762220903;
	bh=vPm6k34a2f+RIjK2DliZcjNWtXNLFh92foLvDAMdWK8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=qX/kXui7oRSNCQ1MuSmSEqZp7uVG10r/RKyXA+tzmEe6nmJEA3Agtw7BdE5DaMqiq
	 7aBiG9XjWfQNWqBINuh/3Ff5/2eFb4/UIiyjAQz+xPzc0E45A+pKpjMNGAkBKCbyiX
	 uIl56+SNxR6oANmSFig3Oj6bSBdLGCRplGf9m+ascqJT9/sSigymqWKfNVMvKyXTqu
	 CfHzOsGlAmiQYKuA8ymP37p1wrDAo7/ezHVlqQkc5DGRc2He1BDrHOCzVHOBEkE2MK
	 tXkVTgPBgjSBildE6cQod1qECV7RsUKaQvIOwk4ebm2yDXk4jKrA47rWD1PIbZCgnv
	 SYTtiPMvUxqcQtTnNWPlf/UR55TyfZ6t/ljPMFkTwBhXj6wWELfQ59Yjqo5HAu6MIM
	 DHnrO4WHJ7CL7ucENGH0rZcue2nGRNlmeqrHe2lOhF+0S+56zENMa/u8WvwfRyk9oe
	 dNsuyBq/lgGfw6oCAoKh1KhiU/+lJOX2ooez5dvOBZV9u0eZP02
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:1415:e24f:af2a:d05d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 83DC620036;
	Tue,  4 Nov 2025 01:48:23 +0000 (UTC)
Date: Tue, 4 Nov 2025 01:48:21 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 06/14] hash: add a function to look up hash algo structs
Message-ID: <aQlbZRAKq9RwYnqe@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-7-sandals@crustytoothpaste.net>
 <xmqqwm4ebxap.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wuzCdsqT9KIM8+hu"
Content-Disposition: inline
In-Reply-To: <xmqqwm4ebxap.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--wuzCdsqT9KIM8+hu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-28 at 20:12:30, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > +const struct git_hash_algo *hash_algo_ptr_by_offset(uint32_t algo)
> > +{
> > +	return &hash_algos[algo];
> > +}
>=20
> Hmph, technically "algo" may be an "offset" into the array, but I'd
> consider it an implementation detail.  We have hash_algo instances
> floating somewhere in-core, and have a way to obtain a pointer to
> one of these instances by "algorithm number".  For the user of the
> API, the fact that these instances are stored in contiguous pieces
> of memory as an array of struct is totally irrelevant.  For that
> reason, I was somewhat repelled by the "by-offset" part of the
> function name.

I fear I don't have a better name.  "by_id" is the format ID.  I could
write "hash_algo_ptr_by_hash_algo" but that seems slightly bizarre and
difficult to type.  I could do "by_index", but you might have the same
objection to that name.  Would you like to propose a nicer alternative?

> The next function ...
>=20
> >  uint32_t hash_algo_by_name(const char *name)
>=20
> ... calls what it returns "hash_algo", but the "hash_algo" returned
> by this new function is quite different.  One is just the "algorithm
> number", while the other is "algorithm instance".  Perhaps calling
> both with the same name "hash algo" is the true source of confusing
> naming of this new function?

Note that the name is "hash_algo_ptr", not "hash_algo".  That is, we're
explicitly returning a pointer to the structure here.  I realize that's
slightly hard to notice at first glance, but it was intentional.  I had
the same thought about using "hash_algo" as you did and for that reason
decided to not create an ambiguous name.

> I am somewhat surprised that we do not expose "struct git_hash_algo"
> the same way a previous step exposed "struct object_id" in C as
> "struct ObjectID" in Rust, but instead pass its address as a void
> pointer.  Hopefully the reason for doing so may become apparent as I
> read further into the series?

We're going to replace this with a nicer abstraction in Rust.  Since we
don't have bindgen or cbindgen yet, it's going to be kind of tricky to
deal with the complexities of the structure such that we get it
correctly aligned and matching and we only need to use it when working
with C, so we don't bother to write out the details here.

I certainly haven't measured, but I think the Rust compiler will be able
to better optimize a function like `raw_len` with two explicit
possibilities, especially when its `const`[0], than the C compiler will
with reading what could be an arbitrary value out of the `rawsz` member.
Because it's const, the compiler absolutely will be able to evaluate the
size of anything where the hash algorithm is known at compile time and
the fact that `hex_len` is defined in terms of `raw_len` provides a
helpful hint for the compiler as well in that one is always twice the
other.

[0] `const` for a function meaning in this case that it can be evaluated
at compile time.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--wuzCdsqT9KIM8+hu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaQlbZQAKCRB8DEliiIei
gb9BAPoDyhieDtthLVqUpMPcw3zgwZzexGQBgLZ1zadsTFe9iQD+IQj8Nvfqc0g9
j5cxc7wmQMrg5QBjE3KpghV5A1QrcwA=
=JQ8N
-----END PGP SIGNATURE-----

--wuzCdsqT9KIM8+hu--
