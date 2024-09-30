Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33E17B505
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732438; cv=none; b=TFBbxzchr6TCARao+8JGe51uWRAs6OX/AiOsuGokOX9qSuSHdBMSc+iy8Xao72HOS9UiYNwSP2g2tpIjlsLjZSrDva7PLARjG9CumqyaSdjRR+I0We89iGokzHjr6J5sOlmLLHr7fo6nN2nGT2HtjCBy53Jj86Pf2qod9IwIrhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732438; c=relaxed/simple;
	bh=GE/QyfrQYUzz6xVN1Rf43h2CWIoQAutSRkqBNeafANg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMJi1nznsTuZMnD4px35MpytiCCTNHZiORbOPZvveZATfjSj64FzhIfPYWbWroWC71OdP5Dk6oUxn4+ctkz+QI5woO/dyqe44ceCiFLel1YFgY6qquGrzOMGo1HumHaqwuy4cXnfVlO6PJuzZlkXDGT5GJT3X4Md0bsbF7MHBKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=L2EihPLr; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="L2EihPLr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1727731607;
	bh=GE/QyfrQYUzz6xVN1Rf43h2CWIoQAutSRkqBNeafANg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=L2EihPLrmvFSpJfeeQ/M974wrg/8BZBFTkGHH8ezESZ5FJXaW1nO1he8iLBBbTOy8
	 rIfUh1A3kyvb7UgXnR9HoYpcMV4otz1LDA648iu1zlyQN/T42O20yeHmAB+eNKdD6h
	 025Iey8KhI6LyAlDYmF8oedBncqEmJofqlteVie+CFfmQ5fIiTZhdT82ySs/WQ6043
	 xRafKFkV9hXPB3Vbr4CJ5SuJE52OS6QG/Xmd9ZIEMJkvf2ywaXdgB/AyW3BiS32bps
	 ehui72mYw7mK9CgiHTRHH/hxFnFkcK71UVzuG4URCiZpN+M6cpenCfNVuscn01oijL
	 PLbOUGm5G6QvGmV5rZLztsyps7/T24joh2+YejmNTzCAd/tU47vNjMA06BjModIeAx
	 wQF8Eti7eVjrmrdB2mzooFnX70n8p2vEU0VPKWzYwT1tthi3cjcHYgMmj2BjZ7oBVq
	 VI1KIiPEfLP6Bxm8I3FeyFerCMiYrIXOUjetOrRii7q6pRlCoSz
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3B67720082;
	Mon, 30 Sep 2024 21:26:47 +0000 (UTC)
Date: Mon, 30 Sep 2024 21:26:46 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 0/4] Introduce a "promisor-remote" capability
Message-ID: <ZvsXlq7-28mdxNc_@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240910163000.1985723-1-christian.couder@gmail.com>
 <xmqqikuijni0.fsf@gitster.g>
 <CAP8UFD34YJ23WSjaP3m8Ao6iZja_NJWfQ0BNEsaNU_F_X3qA_Q@mail.gmail.com>
 <xmqq34lkg1ck.fsf@gitster.g>
 <ZvpZv_fed_su4w2-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="awRcy58nva5OUJ5q"
Content-Disposition: inline
In-Reply-To: <ZvpZv_fed_su4w2-@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--awRcy58nva5OUJ5q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-30 at 07:57:17, Patrick Steinhardt wrote:
> But there are still a couple of pieces missing in the bigger puzzle:
>=20
>   - How would a client know to omit certain objects? Right now it only
>     knows that there are promisor remotes, but it doesn't know that it
>     e.g. should omit every blob larger than X megabytes. The answer
>     could of course be that the client should just know to do a partial
>     clone by themselves.

It would be helpful to have some sort of protocol v2 feature that says
that a partial clone (of whatever sort) is recommended and let honouring
that be a config flag.  Otherwise, you're going to have a bunch of users
who try to download every giant object in the repository when they don't
need to.

Git LFS has the advantage that this is the default behaviour, which is
really valuable.

>   - Storing those large objects locally is still expensive. We had
>     discussions in the past where such objects could be stored
>     uncompressed to stop wasting compute here. At GitLab, we're thinking
>     about the ability to use rolling hash functions to chunk such big
>     objects into smaller parts to also allow for somewhat efficient
>     deduplication. We're also thinking about how to make the overall ODB
>     pluggable such that we can eventually make it more scalable in this
>     context. But that's of course thinking into the future quite a bit.

Git LFS has a `git lfs dedup` command, which takes the files in the
working tree and creates a copy using the copy-on-write functionality in
the operating system and file system to avoid duplicating them.  There
are certainly some users who simply cannot afford to store multiple
copies of the file system (say, because their repository is 500 GB), and
this is important functionality for them.

Note that this doesn't work for all file systems.  It does for APFS on
macOS, XFS and Btrfs on Linux, and ReFS on Windows, but not HFS+, ext4,
or NTFS, which lack copy-on-write functionality.

We'd probably need to add an extension for uncompressed objects for
this, since it's a repository format change, but it shouldn't be hard to
do.

In Git LFS, it's also possible to share a set of objects across
repositories although one must be careful not to prune them.  We already
have that through alternates, so I don't think we're lacking anything
there.

>   - Local repositories would likely want to prune large objects that
>     have not been accessed for a while to eventually regain some storage
>     space.

Git LFS has a `git lfs prune` command for this as well.  It does have to
be run manually, though.

> I think chipping away the problems one by one is fine. But it would be
> nice to draw something like a "big picture" of where we eventually want
> to end up at and how all the parts connect with each other to form a
> viable native replacement for Git LFS.

I think a native replacement would be a valuable feature.  Part of the
essential component is going to be a way to handle this gracefully
during pushes, since part of the goal of Git LFS is to get large blobs
off the main server storage where they tend to make repacks extremely
expensive and into an external store.  Without that, it's unlikely that
this feature is going to be viable on the server side.  GitHub doesn't
allow large blobs for exactly that reason, so we'd want some way to
store them outside the main repository but still have the repo think
they were present.

One idea I had about this was pluggable storage backends, which might be
a nice feature to add via a dynamically loaded shared library.  In
addition, this seems like the kind of feature that one might like to use
Rust for, since it probably will involve HTTP code, and generally people
like doing that less in C (I do, at least).

> Also Cc'ing brian, who likely has a thing or two to say about this :)

I certainly have thought about this a lot.  I will say that I've stepped
down from being one of the Git LFS maintainers (endless supply of work,
not nearly enough time), but I am still familiar with the architecture
of the project.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--awRcy58nva5OUJ5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZvsXlQAKCRB8DEliiIei
gSq9AP90Qp3Z2jWS/1IfKgXstX9WjxhiqW7au1Q9ZBQHSiLm+wD+Midt9/KGzMc3
31F3b0MG+j5CaCV4g7ieByX0mK2bJAU=
=MH/w
-----END PGP SIGNATURE-----

--awRcy58nva5OUJ5q--
