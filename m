Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA542D063E
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 01:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701875; cv=none; b=Zr7onlA+viotrCQcGlguKzrs0WOJjzkRxklCSgabzEUYsC9txyDqfW/JRXegX+r7MQ+f35xRynyfzIio67/yK3uPFxjGv41SucvHkDHypY0MhAV+SegW45HdC4zqW87o51AHyAwoItkJTNDpzyN93KfBtuIC4ai66BRvaEtR000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701875; c=relaxed/simple;
	bh=m/tR5hOeSMm+lm1ddsPtY27C202tjpVH9/k+/pVTQeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeZd9wibskqNSd/CvqoMlh/NE0C5YDEGNoF4+B1t7xXQ998zVqIjfCJnYTjmTui00Xv6Zpe5BSnWv79ntlIKP1VPYkwLGa2TEUyxerDwyazpfwJpdxpxdgReWKj/AlUceEIRdgqgLXrxXyYPO+gbAd3qqj+wYWRPFmS+0jMBcgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Xd8orucH; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Xd8orucH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761701871;
	bh=m/tR5hOeSMm+lm1ddsPtY27C202tjpVH9/k+/pVTQeQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Xd8orucH+ZXJ1A5/feP36rSBqzdmtUO+kmwkoSsmXLqCTbeN4xtsV9Lin4P4QmpUP
	 ZagVYNjBAGgnuNEoHOQYq6UnYmnBAmWhL2AvXdltjKVevEfb2a70vACLfBsz9+uhHn
	 t2C4Yol9WgXbrNvG2B7kZIGMWis8S4p6NIYAb2bp2p7Yqo7fWKPhh4YmWDE72uujMa
	 E4asO0XBVA1O8Q00I1zVcbdcDh7aKqYVjl07jPWPSMECy6UgU1Ytku618A/Xiu0FaB
	 p3IRLWaHCTi9CeY5TS33k7ZYpPaAAMnW/pX25sGTwhkODmmjJtRtU1Dy9gBUXXgmos
	 5I+VjAZK7XB6jd8uNQhTlyGkYckKrFBf3K4mw9zaBJz5XYqgtVH2EiafbvGYtRr1Eq
	 YL31NISxRkeCdCEiGy7PybzC6si3zbE4BRsS5GZkS5tMniWjtimvjA/VlD38fusiXd
	 iUUgMbX9U6ijtdznPJcVm27mCS5bIZ4TeYr5IP5fndLxbBV4vTN
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9578:8587:8ed:424b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3AD3620036;
	Wed, 29 Oct 2025 01:37:51 +0000 (UTC)
Date: Wed, 29 Oct 2025 01:37:49 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 12/14] rust: add a new binary loose object map format
Message-ID: <aQFv7cJUYaSUipF-@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-13-sandals@crustytoothpaste.net>
 <aQCKaK6kTfwoj28O@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a4O1hb0znIwxc+ia"
Content-Disposition: inline
In-Reply-To: <aQCKaK6kTfwoj28O@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--a4O1hb0znIwxc+ia
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-28 at 09:18:32, Patrick Steinhardt wrote:
> Doesn't this indicate that calling this "loose object map" is kind of a
> misnomer? If we want to be able to store arbitrary objects regardless of
> the way those are stored (or not stored) in the ODB then I think it's
> overall quite confusing to have "loose" in the name.
>=20
> This isn't something we can fix for the old loose object map. But
> shouldn't we fix this now for the new format you're about to introduce?

Sure.  I will admit I'm terrible at naming things.  What do you think it
should be called.

> s/enabling//

Will fix in v2.

> As far as I understood, this legacy mapping wasn't really used anywhere
> as it is basically nonfunctional in the first place. Can we get away
> with dropping it altogether?

Sure, I can do that.

> Given that we're talking about multiple different hashes: which hash
> function is used for this checksum? I assume it's the main hash, but it
> might be sensible to document this.

It is the main hash.  I'll update that for v2.

> > +`git pack-objects` will repack existing entries into one file, removin=
g any
> > +unnecessary objects, such as obsolete shallow entries or loose objects=
 that
> > +have been packed.
>=20
> Curious that this is put into git-pack-objects(1), as it doesn't quite
> feel related to the task. Sure, it generates packfiles, but it doesn't
> really handle the logic to manage loose objects/packfiles in the repo.
> This feels closer to what git-repack(1) is doing, so would that be a
> better place to put it?

I've actually put this into `git gc`, which will come in in a future
series, so I'll update this for v2.

> As far as I understand this allows us to even store multiple
> compatibility hashes if we were ever to grow a third hash. We would
> still be able to binary-search through the file as we can compute the
> size of every record with this header.

Exactly.  We were discussing BLAKE3 at the contributor summit as a
potential option.

The careful reader will note that this format looks suspiciously like
pack index v3, which is intentional.

> > +  * 8-byte offset to the trailer from the beginning of this file.
> > +	* Zero or more additional key/value pairs (4-byte key, 4-byte value),=
 which
> > +		may optionally declare one or more chunks.  No chunks are currently
> > +		defined. Readers must ignore unrecognized keys.
>=20
> How does the reader identify these key/value pairs and know how many of
> those there are? Also, do you already have an idea what those should be
> used for?

I'd imagined we could do something like fanout entries for tree
structures to help parse large trees better (since trees cannot be
binary searched).  That's something I wanted to add to multi-pack index
as a set of chunks.

They are read until the end of the header section.

> How does one figure out how many NUL bytes there's going to be? I guess
> the reader doesn't need to know as it simply uses the length of the
> header section to seek to the tables?

Exactly.  This is what we do with pack index v3 as well.  As a practical
matter, every chunk of NUL padding contains 0 to 3 bytes: just enough to
align the data for 4-byte access.

> > +- Tables for the first object format:
> > +	* A sorted table of shortened object names.  These are prefixes of th=
e names
> > +		of all objects in this file, packed together without offset values to
> > +		reduce the cache footprint of the binary search for a specific objec=
t name.
>=20
> Okay. The length of the shortened object names is encoded in the header,
> so all of the objects have the same length.
>=20
> Does the reader have a way to disambiguate the shortened object names?
> They may be unambiguous at the point in time where the mapping is
> written, but when they are being shortened it becomes plausible that the
> object names becomes ambiguous at a later point in time.=20
>=20
> > +  * A sorted table of full object names.
>=20
> Ah, I see! We have a second table further down that encodes full object
> names, so yes, we can fully disambiguate.
>=20
> > +	* A table of 4-byte metadata values.
> > +	* Zero or more chunks.  A chunk starts with a four-byte chunk identif=
ier and
> > +		a four-byte parameter (which, if unneeded, is all zeros) and an eigh=
t-byte
> > +		size (not including the identifier, parameter, or size), plus the ch=
unk
> > +		data.
> > +- Zero or more NUL bytes.
> > +- Tables for subsequent object formats:
> > +	* A sorted table of shortened object names.  These are prefixes of th=
e names
> > +		of all objects in this file, packed together without offset values to
> > +		reduce the cache footprint of the binary search for a specific objec=
t name.
> > +  * A table of full object names in the order specified by the first o=
bject format.
>=20
> Interesting, why are these sorted by the first object format again?
> Doesn't that mean that I have to do a linear search now to locate the
> entry for the second object format?

No, it doesn't.  The full object names are always in the order of the
first format.  The shortened names for second and subsequent formats
point into an offset table that finds the offset in the first format.

Therefore, to look up an OID in the second format knowing its OID in the
first format, you use the first format's prefixes to find its offset,
verify its OID in the full object names, and then look up that offset in
the list of full object names in the second format.

To go the other way, you find the prefix in the second format, find its
corresponding offset in the mapping table, verify the full object ID in
the second format, and then look up that offset in the full object names
in the first format.

>     Disclaimer: the following paragraphs go into how I would have
>     designed this. This is _not_ meant as a "you have to do it this
>     way", but as a discussion starter to figure out why you have picked
>     the proposed format and for me to get a better understanding of it.

The answer is that it very much resembles pack index v3, except that
instead of having pack order, we just always use the sorted order of the
first object format (since we don't have a pack).  That also makes the
data deterministic so that we always write identical files for identical
objects.

> Stepping back a bit, my expectation is that we'd have one lookup table
> per object format so that we can map into all directions: SHA1 -> SHA256
> and in reverse. If we had more than two hash functions we'd also need to
> have a table for e.g. Blake3 -> SHA1 and Blake3 -> SHA256 and reverse.

Yeah, and then the file gets very large.  We mmap these into memory and
never free them during the life of the program (except when compacting
them and deleting the unused ones), so we want to be quite conservative
with our memory.

> One way to do this is to have three tables, one for each object format.
> The object formats would be ordered lexicographically by their own
> object ID, so that one can perform a binary search for an object ID in
> every format.

We have that with the shortened object IDs and we do a binary search
over those.  This is more cache-friendly and all we need to do is verify
that the full object ID matches our value (as opposed to a different
object stored elsewhere with an identical shortened prefix).

> Each row could then either contain all compatibility hashes directly,
> but this would explode quite fast in storage space. An optimization
> would thus be to have one table per object format that contains the
> shortened object ID plus an offset where the actual record can be found.
> You know where to find the tables from the header, and you know the
> exact size of each entry, so you can trivially perform a binary search
> for the abbreviated object ID in that index.
>=20
> Once you've found that index you take the stored offset to look up the
> record in the "main" table. This main table contains the full object IDs
> for all object hashes. So something like the following simplified
> format:
>=20
>         +---------------------------------+
>         | header                          |
>         | Format version                  |
>         | Number of object IDs            |
>         | SHA1: abbrev, offset            |
>         | SHA256: abbrev, offset          |
>         | Blake3: abbrev, offset          |
>         | Main: offset                    |
>         +---------------------------------+
>         | table for SHA1                  |
>         | 11111 -> 1                      |
>         | 22222 -> 2                      |
>         +---------------------------------+
>         | table for SHA256                |
>         | aaaaa -> 2                      |
>         | bbbbb -> 1                      |
>         +---------------------------------+
>         | table for Blake3                |
>         | 88888 -> 2                      |
>         | 99999 -> 1                      |
>         +---------------------------------+
>         | main table                      |
>         | 11111111 -> bbbbbbbb -> 9999999 |
>         | 22222222 -> aaaaaaaa -> 8888888 |
>         +---------------------------------+
>         | trailer                         |
>         | trailer hash                    |
>         +---------------------------------+
>=20
> Overall you only have to store the full object ID for each hash exactly
> once, and the mappings also only have to be stored once. But you can
> look up an ID by each of its formats via its indices.

This is very similar to what we have now, except that it has mapping
offsets for each algorithm instead of the second and subsequent
algorithms and it re-orders the location of the full object IDs.

I also intentionally wanted to produce completely deterministic output,
since in `git verify-pack` we verify that the output is byte-for-byte
identical and I wanted to have the ability to do that here as well.  (It
isn't implemented yet, but that's a goal.)  In order to do that, we need
to write every part of the data in a fixed order, so we'd have to define
the main table as being sorted by the first algorithm.

> With some slight adjustments one could also adapt this format to become
> streamable:

I don't think these formats are as streamable as you might like.  In
order to create the tables, we need to sort the data for each algorithm
to find the short name length, which requires knowing all of the data up
front in order.

I, too, thought that might be a nice idea, but when I implemented pack
index v3, I realized that effectively all of the data has to be computed
up front.  Once you do that, computing the offsets isn't hard because
it's just some addition and multiplication.

I personally like a header with offsets better than a trailer since it
makes parsing easier.  We can peek at the first 64 bytes of the file to
see if it meets our needs or has data we're interested in.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--a4O1hb0znIwxc+ia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaQFv7QAKCRB8DEliiIei
gTKxAP9kL6FkeJ6fqFMlMbM3z0vO/uZmkQziNDCkcA/gTv9z9wD+IzWMCw7F9BBn
GzXf/r2bJYWwblR9OP2pxe7aqdTDXQM=
=+g4p
-----END PGP SIGNATURE-----

--a4O1hb0znIwxc+ia--
