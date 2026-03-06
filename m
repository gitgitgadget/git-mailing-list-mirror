Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233CB37CD49
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793581; cv=none; b=RADp4IVOsyQPofT0c/ewGEIEt9OfMKL+NmcjqcQv+Y4Nip4zwlCrg9NI31tnaKtqUulwbfqfWrbk0fqG0wGyEsXVQvJCBTjPixfz/VVuCtmR0vQoY+vCjWvigtPjPDuHgX146kqrf9l95ObxnhtD51tQK2OkB0KZICbbvSoU+pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793581; c=relaxed/simple;
	bh=KxZg8VH5vjJ/fc+ULzPFfmkXk7Mvi2qsw47seM4Sfaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRKX4Oc0KNjIk/Bm24v7vnCquH6AwgKVtV0os2VG1/Hm5Q42LmXHiRyBvy0Y0ttGpgbOKiH/ZprFTz/7rGj+FpRZjQlGbgsAuxUlfSIFZhzJzLen4dF9MAJ9IElCY/9jFNKZNlTpl5tZTQRSEpkqACmiM27xMwDHZyNvDaj4mx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MGE6O3DK; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MGE6O3DK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1772793573;
	bh=KxZg8VH5vjJ/fc+ULzPFfmkXk7Mvi2qsw47seM4Sfaw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=MGE6O3DK4Lv9EavTQ2wuXpDKVKdKLtpKc0WRju/IVIX0UAdCyfM65BCcE4n35vcsH
	 KJUhnKEnBpiyXG+9lcYa83oqKz3iUVz3uPCiScOjRP6amyLZi5iNqm5kP2u1u9uAmD
	 IGIfmFzauOQTcfNOLsmIYZr/Nf0Pdxi1k95daj0WJgcdT+mAf9jzs5Vv/5Z0LIgoBe
	 /FOFseQsYJ03YVeFOfrzBLqr5bKHC2K7x/R6TG4vCNQJ938jIHZAnasGMnKBcxH33x
	 4z0exSo4l5+wS5CJCpQ40lRoR+X2y9jkkNud9H3ZL+2iY3WO5sOLjvJjhSCqfylDyo
	 DAUZJDGoahhRTNtuPXDK4SXSP6LTb3bouCd5e61OZm2ux92UIG2SMBzw6ND2dT/JoQ
	 S2Jj6ZAPS2OKGLoVHAxoRJV7v48/6gNEKR2wFnx33bmkS0IfA4jQa2A1qVHh5tsMHC
	 07IKupRRpi8ghtZ8sv/PRFKBAsWMniX6TiR/JXvepbtWS4QVRKE
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:941e:963:e525:3a6c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2B3CD20105;
	Fri,  6 Mar 2026 10:39:33 +0000 (UTC)
Date: Fri, 6 Mar 2026 10:39:31 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Alan Braithwaite via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, christian.couder@gmail.com,
	jonathantanmy@google.com, me@ttaylorr.com, gitster@pobox.com,
	Jeff King <peff@peff.net>, Alan Braithwaite <alan@braithwaite.dev>
Subject: Re: [PATCH v3] clone: add clone.<url>.defaultObjectFilter config
Message-ID: <aaqu44_sDJYcftWd@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Alan Braithwaite via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, ps@pks.im, christian.couder@gmail.com,
	jonathantanmy@google.com, me@ttaylorr.com, gitster@pobox.com,
	Jeff King <peff@peff.net>, Alan Braithwaite <alan@braithwaite.dev>
References: <pull.2058.v2.git.1772672251281.gitgitgadget@gmail.com>
 <pull.2058.v3.git.1772780113400.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D239mum14bDSZuMO"
Content-Disposition: inline
In-Reply-To: <pull.2058.v3.git.1772780113400.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--D239mum14bDSZuMO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-06 at 06:55:13, Alan Braithwaite via GitGitGadget wrote:
> From: Alan Braithwaite <alan@braithwaite.dev>
>=20
> Add a new configuration option that lets users specify a default
> partial clone filter per URL pattern.  When cloning a repository
> whose URL matches a configured pattern, git-clone automatically
> applies the filter, equivalent to passing --filter on the command
> line.
>=20
>     [clone "https://github.com/"]
>         defaultObjectFilter =3D blob:limit=3D5m
>=20
>     [clone "https://internal.corp.com/large-project/"]
>         defaultObjectFilter =3D blob:none
>=20
> URL matching uses the existing urlmatch_config_entry() infrastructure,
> following the same rules as http.<url>.* =E2=80=94 you can match a domain,
> a namespace path, or a specific project, and the most specific match
> wins.
>=20
> The config only affects the initial clone.  Once the clone completes,
> the filter is recorded in remote.<name>.partialCloneFilter, so
> subsequent fetches inherit it automatically.  An explicit --filter
> flag on the command line takes precedence.
>=20
> Only the URL-qualified form (clone.<url>.defaultObjectFilter) is
> honored; a bare clone.defaultObjectFilter without a URL subsection
> is ignored.

We've historically not implemented default filtering for clones because
it makes it hard to reason about the behaviour of the clone command.
For instance, if I have a script that clones a repository, it almost
certainly expects a full clone unless it requested something else.

For instance, I run `foo setup` which clones my repository and then I
suspend my laptop.  I go the airport and get on an airplane which lacks
Wi-Fi.  I then run `foo blargle`, which operates on the repository, but
that fails because it was a partial clone and I'm offline.  I didn't
realize this wouldn't work because I didn't know that the foo command
required a full clone since it's just a script I got from my distro.

We've traditionally placed this kind of customizable configuration into
`scalar` instead, which is designed to be configurable and set options
for large repositories that would want to control clone and fetch
options.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--D239mum14bDSZuMO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaaqu4wAKCRB8DEliiIei
gZB4AP4307gjoanZMdNDnC9b5PuvjFPy9JF04etCyoNxfmdT/AD/VhUtbCPy/qka
0AtHRa7R40cll/2WOeCmg91U4BqcTgA=
=HkkL
-----END PGP SIGNATURE-----

--D239mum14bDSZuMO--
