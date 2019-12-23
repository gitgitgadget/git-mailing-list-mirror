Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7369CC2D0C8
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 01:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D849206CB
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 01:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xBqtltZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfLWBNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 20:13:12 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43028 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbfLWBNM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Dec 2019 20:13:12 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6EF3560436;
        Mon, 23 Dec 2019 01:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1577063591;
        bh=XOlfoq0nXwtbt2f5wlQf4ehVK+kI81Uws0hWNWQdtjk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xBqtltZr7dm7eUlpWTvYPLZFonjzfaeSG5vHse0VweOC092Re0qF8xsYKp+Ew/Iq9
         nRHOui7IRygKs51xUGTpcf4VZ3SnPrBp/L2s10ZfBMvnPeen+zpPpIGsCW1TchCND9
         Cl6Clh5uHiXVnMx2tU+ubULYsNbG2Yn439DP9k/e3uUHNtj3kOOYd47egKYbiP+mN8
         TfIg/OwDYfi8UzIvamcB/mhE5hoegC0lZWyQVG4iSH82xMTNmb4vdLllOjN9jUM1wS
         no7GGZb6ZkO073mk/chlX+1qygOkwvR79MgacQU7LVfVrqDqAAFZTqjBXtyQbyK8Y9
         xarZifmkdNnrUPhnPAyhXF+Ol/0Z5h0tTkYmqu9KfgI9TOZFkKz0tWw6LLTvmCCe+e
         4O3C76XXfykgMzlpiqpuJO4UhLFTrG8NvZnmYr0f+ALuEAkjCnPNaBT66eqEXaXCkX
         trIYjcA21Q7aasPb454E1lccj+oCX3lGFAecOHCx0aJY18LMbPs
Date:   Mon, 23 Dec 2019 01:13:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michael Clark <michaeljclark@mac.com>
Cc:     git@vger.kernel.org
Subject: Re: NewHash alternatives and SHA benchmarks
Message-ID: <20191223011306.GF163225@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Clark <michaeljclark@mac.com>, git@vger.kernel.org
References: <20191222064133.35276-1-michaeljclark@mac.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yH1ZJFh+qWm+VodA"
Content-Disposition: inline
In-Reply-To: <20191222064133.35276-1-michaeljclark@mac.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yH1ZJFh+qWm+VodA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-22 at 06:41:33, Michael Clark wrote:
> Recommendations
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> After performing multiple benchmarks and thinking about this for
> several weeks I have come to the conclusion that SHA512/256 is a
> very good alternative to SHA256, both from the perspective of its
> length extension resistance, and performance. It seems that NewHash
> implementation is some way off so it is not too late to change.
>=20
> - Consider SHA512/256 for NewHash

This has been discussed extensively on the list.  Git is not in general
vulnerable to length extension attacks because it hashes the length of
the object as part of the object header.  This was documented as one of
the known aspects in the transition plan in
Documentation/technical/hash-function-transition.txt.

We've considered a lot of hash algorithms, including BLAKE2b-256,
SHA-256, SHA-512/256, SHA-3-256, SHAKE256 with a 256-bit length, and
others.  This was no doubt controversial, but we discussed the pros and
cons of many options and this is what we decided.  I will state that
while our choice was not one of my more preferred options, I value that
we have a consensus on the way forward.

Among the reasons we chose SHA-256 is performance on newer x86-64
processors with the SHA extensions, which support only SHA-1 and
SHA-256, and compatibility with a wide variety of cryptographic
libraries.  I have no desire for Git to provide assembly implementations
of NewHash, and that means people must rely on existing cryptographic
libraries.

Cryptographic libraries overwhelmingly do not support SHA-512/256.
While OpenSSL does, it's only in the latest versions, and people
generally cannot legally distribute both Git and OpenSSL linked
together, so they must rely on system libraries for good performance.
Apple Common Crypto, for example, does not document any SHA-512/256
implementations.

There is also a benefit to chaining using a single algorithm for
signatures, which therefore necessitates using SHA-256 or one of the
other original SHA-2 algorithms until the next version of OpenPGP is
implemented which supports SHA-3.

Because we decided some time ago, I've sent in a bunch of patches to our
testsuite to make it work with SHA-256.  Some of these patches are
general, in that they make the tests generate values which are used, or
they are specific to the length of the hash algorithm.  Others use
specific hash values, and changing the hash algorithm will require
recomputing all of these values.

Absent a compelling security reason to abandon SHA-256, such as a
significant previously unknown cryptographic weakness, I don't plan to
reimplement all of this work.  Updating our testsuite to work
successfully with SHA-256 has taken a huge amount of time, and this work
has been entirely done on my own free time because I want the Git
project to be successful.  That doesn't even include the contributions
of others who have reviewed, discussed, and contributed to the current
work and transition plan.  While I appreciate the benefits of
alternatives to SHA-256, I'm a bit annoyed that you're proposing to
throw away all of this work after we explicitly sought to build
consensus about an algorithm so that this stage of the work could begin.

Of course, nothing prevents you from proposing a new algorithm and
fixing the testsuite to make it work, but I don't believe that we're
likely to adopt a different algorithm at this point, given the previous
discussion on the list.  The code is designed to be pluggable to support
arbitrary algorithms, but there are pieces which assume that the
algorithm can be distinguished by length (e.g., the dumb HTTP protocol)
and therefore you'd need to devise a different way to distinguish these
versions.

If you'd like to see what a Git binary that supports multiple hash
algorithms looks like at the moment, you're welcome to look at my
transition-stage-4 branch at https://github.com/bk2204/git.git so you
can get a fuller understanding of what's involved.  You can run the
testsuite with that code and GIT_TEST_DEFAULT_HASH=3D<hashname> to see
what passes and fails.

> SHA algorithm patches
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> I will be sending a patch series which adds SHA Algorithms which
> are in the sha-algorithms branch of my git tree.
>=20
> - https://github.com/michaeljclark/git.git
> - https://github.com/michaeljclark/git/tree/sha-algorithms/sha
>=20
> This is a precursor to asking some questions about the proposed
> implementation of multiple or compat hashs (N-hash or 2-hash?).
> I am curious about the pack format and directory structure for
> loose objects. It seems there needs to be a single hash chosen
> for loose object filenames, and auxilliary hashes will need
> hash to hash map to go from a compat hash to new hash.

That's correct.  There's documentation in the transition plan about what
this will look like.

A stage 4 implementation (where repositories are either SHA-1 only or
SHA-256 only) has been written and I'll send it out once the remaining
test fixes are merged.

I should point out that we specifically chose not to support a plethora
of algorithms because the goal is to encourage everybody to adopt a
single, secure algorithm.  The network protocol will need to
interoperate using a single algorithm, which means the repository will
need to contain a mapping for that algorithm.  Since the current plan is
to support no more than two algorithms at a time, one of which will need
to be SHA-1, allowing users to pick and choose from a variety of
algorithms harms interoperability.  Seamless interoperability between
SHA-1 and NewHash repositories was considered extremely important in the
transition plan.  That won't be coming immediately with the stage 4
implementation, but it is planned for the future.

My hope is that whatever we pick now will be secure for some time to
come and that when we need to adopt a newer hash, whether due to
cryptographic advance or post-quantum cryptography, there will be no
existing SHA-1 repositories and transition can take place from NewHash
to NewNewHash.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4AFKIACgkQv1NdgR9S
9osZ0Q//b38O/MCUWgEisHG6s/+3wGVxZgtQZLbYxVbx0ZBo4SxwKhGnVkNgYz4J
0i7EkyIrPIZl37jyd3dLBrKpfGgiScV6/vw8RxorhueGjbUbZsa0MmU1x8EGuexU
Cg4XqQvWxXirH5qdFaSezbfvZDkbyb5GsSutoH1sAyuI0sTaHtoDNIk3gOapHeOL
dC9yKBy+Z+rCj/VrUjK14Q3lfe4P0lAGKJj22guq1YrUV/zpylanZ3lxP4HpgJaB
wN/H786m5DWOa+EEe0M68IFZHNE/hsnbJL1bCjT9BUi954Gab6veCmZta9njizIn
lXB3DOQ1RlbFaJwYBxh8+qiZwM7uqPEjks+cQP35AVBLWLs0bOK0bEui1Gq78HIr
XxWPzkQhyK3bU9O1XkZVhj5bddN6QXtB/hBrUZp3FcRKQ+3kVS7Cl6FyyA3J4Yk4
tDZh3jhRg9HhKKwnlFhN/RtU9e2kqlAnUaoY8mHZ7aDbZOn1oBIFOQLEm+9gz+yn
S9CW8BrJI/GsPzSqah1VwSz+QTI0coICS4lwM2Ih+/9gGOf9bAAoQ0hdL41VPFi+
n5fg3qL/9aIJKub2ya6JlQ5yb6UfDz39rpBo5CRmyEFuWfQ0DZNnDsnfWJvX/z5R
iI9knTOrK6zGEaUxGxn3B1gaIGRgNzX06Y2AUnn3IB7ePUXffvc=
=s1AJ
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--
