Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA642D7D47
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074310; cv=none; b=esbfPv7oDXNFTMi68vc+GSR7Bzf5j6ydGWzaCifrbKu2CGFq9sdV9GDo62HLE/4zqSnOsopR5UxU3Bt90CV9HTS+Y88QnDoLEXfjuFP+0fTrwnAi6K/CaYj5CpciQnZUcqhTkNWZapnOuzfa4DDr2+LX32rj3cdeA196wPHN7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074310; c=relaxed/simple;
	bh=rigrE7QMOj6KL7wpzoO6I5aJxAg8cYJ6HfKqr6lmrC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4/FTow+rHX6pydB/UiFixxxI8g9mDODt3+0jKxSycp5TvP+71TdWR5exsUgIDCDG/Uavi7gaJvK3MWLYaexR1R3ggv/OXgaHkd+4E6GYmqGqzJGVJL5ign/vbSLpCZTYF/9HU4dU0HXzVrpEMKfOHVyAqbbmznO/BiSXIDe9kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Q8iAtmfA; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Q8iAtmfA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763074306;
	bh=rigrE7QMOj6KL7wpzoO6I5aJxAg8cYJ6HfKqr6lmrC8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Q8iAtmfAlW+bV4+KoPU36AGbnTktzmzEB17CdHjUffX884fD5ngjyaTN+8D1yjoJY
	 m8O0YpELWrlGRXHbxBqylqH0aloLfh8ksAKMbedc3cexCCRADM1j5zGu2zPs3+TmEe
	 P5tQuuiBdKB6us+//51zFN1Oo0To1b/MdrinSMq/N5+e0hSgjgNrJm0XyWPRXbEJdq
	 S+j3SpW8yT826g/Nyxmn5xwXduFDd90tThSkrbzgIc2GfbC3o657KDiAzY/6E4NtEo
	 +/VT5uRv57jMXWCv2cbgCScn395geT0tMsFfTfNJa3DBZxmXzSz+5m1qPSm7vOkb3c
	 rknWxHticUwhSKBKxaBpHu+Y18cjXBxhZ5ecXsj6hky1CrIXmKzhpnnvIJ6eXZtaCe
	 d3o2jT9h/G7rVUQLG2lBHHKTd6q/M2x6g2N6F+MM2bJCYMN+KZanR6hnGEmYh9tpqG
	 zCGRaYbrjyKQm2RFu+neDNfsWrENA3wImX7YVfsmfl11qxv1vvQ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:663d:867d:4eb4:3b8a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3451420065;
	Thu, 13 Nov 2025 22:51:46 +0000 (UTC)
Date: Thu, 13 Nov 2025 22:51:44 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Martin Wilck <mwilck@suse.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Adrian Schroeter <adrian@suse.com>
Subject: Re: git fails to checkout SHA1 submodule in SHA256 repo with
 --depth=1
Message-ID: <aRZhAEpm8PbBQcIM@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Martin Wilck <mwilck@suse.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Adrian Schroeter <adrian@suse.com>
References: <c94a929df63f79e49eeae0cd67c1f59f859e3d62.camel@suse.com>
 <xmqq7bvvtdoe.fsf@gitster.g>
 <aRUaR6IfH9imrF5A@fruit.crustytoothpaste.net>
 <a1c0440a6eef8f306f53793b2f96636945d4ced4.camel@suse.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oUMpju1eH9K05gJP"
Content-Disposition: inline
In-Reply-To: <a1c0440a6eef8f306f53793b2f96636945d4ced4.camel@suse.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--oUMpju1eH9K05gJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-11-13 at 10:15:30, Martin Wilck wrote:
> Let me just explain the use case: The distribution ((open)SUSE) has
> switched to git for version control of its packages. We have chosen
> SHA256, because we'll need to support the distribution for many years
> to come, much longer than SHA1 is going to be considered good enough.
>=20
> We can store the source code of the package e.g. in the form of
> tarballs (and we do). But it's convenient and efficient, and thus
> tempting for developers, to simply link to an existing repository
> hosting the sources, using a submodule. And upstream repos still use
> SHA1. This is what lead us to experiment with this sort of mixed
> repository.
>=20
> I get it that the concept is flawed and unsupported. Up to now, that
> wasn't obvious to me.

It wasn't obvious to a lot of people because the assumption is only
documented in the transition plan.  Mixed algorithm submodules are
something we should have thought about earlier on, but we didn't.

The original transition plan was to have full interoperability support
early on, in which case this wouldn't have been a problem, but for
technical reasons it ended up being much easier to have SHA-256-only
repositories, so we finished that first.  I then lost interest in the
project for many years (having kind of burnt out on the work) and, with
the exception of one set of patches that were sent in, nobody else
picked it up either.  So this ideally would have been implemented sooner
under the original plan, but it wasn't.  This is one of the pitfalls of
open source projects, as we all know.

> So what we can do now is either keep storing tarballs, or wait until
> there's a full solution for migration between / interoperability of
> different hash algorithms, and until the source code repos we're
> interested in have been fully migrated to SHA256. In some special
> cases, where (open)SUSE owns the source repositories, we may be able to
> simply migrate to a SHA256 forge. We can also invent a "poor man's
> submodule" mechanism to link to sources on some external repository
> from ours [1].

There is work underway for SHA-1/SHA-256 interoperability.  However, it
is a thing I'm working on primarily in my free time (although also a
little at work) and nobody else has stepped up to contribute, so it will
take some time to complete and is not expected to be included in Git
3.0 without additional assistance.

To be clear, the existing interoperability code does work for
repositories without submodules and you may find it on the
`sha256-interop` branch at https://github.com/bk2204/git.git, but it
isn't production ready.  I might use it myself, but I would not
recommend others do so in its current state.

For right now, I would say that you should keep storing tarballs.

> Another question: If I, in the current repo [2], create a commit on top
> removing the submodule and replacing it by a tarball, would the
> repository remain broken, as it would still have the deprecated
> SHA256/SHA1 combination in the history? Should I expect errors if run
> e.g. "git rebase" or "git bisect" in a repository like this? IOW, do I
> need to rewrite the history of this repo, eliminating all instances of
> such mixed-hash submodules, to be on the safe side?

If the mismatched submodule remains in the history, then it will be
broken, so you'll almost certainly want to rewrite the history.

When the interoperability work is done and fully functional, a
repository in this situation will not work at all with dual algorithms.
The reason for that is that the SHA-256 main repository will try to use
the submodule value as a SHA-256 submodule (using the incorrect padded
SHA-1 value as a SHA-256 value) and it won't be able to create the
appropriate SHA-1/SHA-256 mapping since that object ID doesn't really
exist in the submodule.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--oUMpju1eH9K05gJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaRZhAAAKCRB8DEliiIei
gVP4AQD9c+WB9zzK2rM7/J2qqHpb+OYVX8Bq81YkZC6EVpmG0gEAmkzn/sVMW81A
YcFNco3yeL+zshMhyJs5ogf9fA4Fjg0=
=chb1
-----END PGP SIGNATURE-----

--oUMpju1eH9K05gJP--
