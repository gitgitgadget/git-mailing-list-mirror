Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C491678F4B
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 22:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755209193; cv=none; b=gIGP6seOxH3+eo73LXl0j4OwA5lChx3PHwHhy8T0UA50KR3Sspnn9KMA9O09vtThNiyo7ksPagMY++2zai/ix4wIxGt3fUZIfcWLLcARIjEW3M1zRH6phh1KX4Ffm9moaxhP9H8/6CQdtFRUnq1uW83WHfrkIabpk69qqnnE72Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755209193; c=relaxed/simple;
	bh=l+cu/UUzgk5mGd1vAL4hIjzwPCGY361HnFDxcIweb+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9rb99n56CUbX3cX4NaW1DiU3GEHdNa/ApPaLf+x7ISoz3AeVOapGwnHOgZsy7VVnb6ntoqd/u2Kg8ZO3asQawYsm0/uiF0iwAVcfdB6qJtlpB4mWq1fh1ZYpt23kM2kgkh7YwKluPjtXCrDq6WdRlo2bvFQDXjM0zXpebUt51c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=l+a9hM4D; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="l+a9hM4D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1755209183;
	bh=l+cu/UUzgk5mGd1vAL4hIjzwPCGY361HnFDxcIweb+g=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=l+a9hM4DaxxOcbdCw6bk2Np0GkOis866sEepUA6H/OZQHcAdDxH9B4kKBC3iXzN9E
	 7Uan5tTDgOVgM1C5GOaNrXVXWKjw0I/9sKwAR0JW8isxyrKXXT3kM+SPY1zQFFt3QT
	 yAtkY9XyjuP9S3xZOV/RNgp15NzcAXBrKx626N23x9AW0xo0tZY4Kf7zrfn/CYhNbW
	 PyBaaE4DGSPfUYdhMXwt3j4yzmejmtwDx+cOVHx/UBEeLJYSPCjRpZIzM1F8quxXl8
	 kWyZabrw19v+wYKWCR5v82tu5lG22Z8Epi3bn7HJP3rZ9sq2QJ6zmQArn0njQbqNcI
	 md9/Dc3hiVUTaERZROPUHecAsr6BqJqQ07Ly303YRczS1S/5firyjaJ0sdGkJ+lv0V
	 ApEldVMgJTf4CT4aQ3QBAKLhpJ7i2KDV/B53n7bF6jFglETbbcrWP5BrScX//W+8eZ
	 GlT/1+uu7knR1rjKWJVbxl04FSnllzXXnb3NCsOwOZnUmxW8uD+
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:8756:2fa2:aa23:19b4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 66392200B4;
	Thu, 14 Aug 2025 22:06:23 +0000 (UTC)
Date: Thu, 14 Aug 2025 22:06:22 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Efficiently storing =?utf-8?Q?SHA-1_?= =?utf-8?B?4oaU?= SHA-256
 mappings in compatibility mode
Message-ID: <aJ5d3tvrm2S1ZTR9@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Nieder <jrnieder@gmail.com>
References: <aJ03RTHaE_JvHA1t@fruit.crustytoothpaste.net>
 <xmqq1ppe9e5h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mqO8j1wlquXKLvQy"
Content-Disposition: inline
In-Reply-To: <xmqq1ppe9e5h.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--mqO8j1wlquXKLvQy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-14 at 14:22:18, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> I do not know if you want my input (as I wasn't CC'ed), but anyway...
>=20
> > ...  We can store them in the
> > `loose-object-idx`, but since it's not sorted or easily searchable, it's
> > going to perform really terribly when we store enough of them.  Right
> > now, we read the entire file into two hashmaps (one in each direction)
> > and we sometimes need to re-read it when other processes add items, so
> > it won't take much to make it be slow and take a lot of memory.
> >
> > For these reasons, I think we need a different datastore for this and
> > I'd like to solicit opinions on what that should look like.  Here are
> > some things that come to mind:
>=20
> I do not see why loose-object-idx is not sorted in the first place,
> but to account for new objects getting into the object store, it
> would not be a viable way forward to maintain a single sorted file.
> We obviously do not want to keep rewriting it in its entirety all
> the time,

It's not sorted because there's no way to do so and efficiently handle
both lookups.  If we sorted it in SHA-256 order, then we would still
have to look up items in SHA-1 order with a linear search, and vice
versa.

What we do for pack index v3 is a sorted table of abbreviated names, a
mapping of that order to pack order, and then full object names in pack
order, with a set for each algorithm.  The abbreviated names all use the
same prefix size, which is just long enough to be unambiguous.  This
means that we can easily look up an object, find its index into pack
order, and then find the full object ID in any algorithm.

We could probably write some sort of data file that contains these
same mappings except that since we don't have a pack order, we could
just use a sorted order in the main algorithm and omit the main
algorithm's mapping table.  We could then have a single table for the
necessary object metadata.

> If there aren't any radically novel idea, I would imagine that our
> design would default to have a big base file that is optimized for
> reading and searching, plus another format that is easier and
> quicker to write that would overlay, possibly in a way similar to
> packed and loose refs work?

Yeah, that could be an option.  Or we could have a base file and some
incrementals, with a `git gc` when we hit 50 items, just like when we
hit 50 packfiles.

> As there are some objects for which we need to carry dynamic
> information, e.g. "we expect not to have this in our object store
> and that is fine", which may be set for objects immediately behind
> the shallow-clone boundary, may need to be cleared when the depth of
> shallowness changes.  Would it make sense to store these auxiliary
> pieces of information in separate place(s)?  I suspect that the
> objects that need these extra bits of information form a small
> subset of all objects that we need to have the conversion data, so a
> separate table that is indexed into using the order in the main
> table may not be a bad way to go.

My plan is to just wire this up to `git gc`.  We'd know what entries are
potentially disposable (such as shallows) and omit the unneeded entries
when repacking.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--mqO8j1wlquXKLvQy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaJ5d3QAKCRB8DEliiIei
gaDpAP9dO71F5VIP8pblZ1pxviwV4RPvMp+fk7buSCMfoAsa1AD/TWisunYBF8l6
jHXz50ttO333ZOfRo87650yr+9WmMQk=
=kni4
-----END PGP SIGNATURE-----

--mqO8j1wlquXKLvQy--
