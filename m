Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD3B19E992
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286110; cv=none; b=K+4L4xHd3psWo/6culBtUcTD4BqBoKopa3NGgaezEKYF/24Qkw+GhIVO+1VZI0XF7GZOHF9LCa1U9QswnaB8+1FUlxOLMgisBxj5IjPUld6wxeh5iqGIpSx8rMFVdI5yTeNikRd7OuArN7rBwlEDvbUALNmSITtnKQGb2qbtD7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286110; c=relaxed/simple;
	bh=x3lmgrcS1zj3uyKRhB2GXTYY7a2zqCnNLzjgsNnZ9dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rox0eT7EvQ+vMNcE1bg8Csr3lK++DOCm8tng6evGnL7FOOH05vaE32pziOGQ4wR4+0lWy2Ajy3knBKRWZqEAD9P4rveRdyFB8DFybfEUWcUTaWNV519t1Wjc9Wu7lMW0nfNyyJwaq6ouroAmTFxPgd5S3OZNsXYtjLosostaqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=b/D665z4; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="b/D665z4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1725286107;
	bh=x3lmgrcS1zj3uyKRhB2GXTYY7a2zqCnNLzjgsNnZ9dU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=b/D665z4IQqeO6H3BSNiXXJzFcOdkK77WyNP41G5a94RMWL65v/6IF5V3rG1Lomvt
	 ntT+VxfRfDrzLI5M6l9m2CmWpOwUMY5ga94rOcTGrD7XEFpBPZq0olPTFWQ9G8abrK
	 9BkD9ulIDEppPigV+TH0qGkviock/YZKaWt1t16YQDV16sUuJ6zFL9A8dv8OpWKLFJ
	 dFSBdlzPP27+K+K4qoYVv8g7UtCGnxY/KMeYXJ99XS11yiMzmhU0+gWJRyoR1Vja4L
	 DCt3c0l5dgKUP6QH0S20KZoHRSRCOTcmi5Jl2KRzqUU51bZtRNhJVLZw6Q1MGOTlur
	 HOvgk94JlwDzFY5kA9wN0pyHP7risCVCAhPkre9q64P01wFUp6F7uSuBBQQhZklcTm
	 OamVGZiDhLt7qSkZo0NGjfXL5AJZxGA3GBo7rFGfN+t61RUvWmuK63zwI1BD59XXtE
	 AhVYYjCgPWLpkS8aRfsDLUXwO+kQ4wcSLYYATUj92R9FJYjR7mJ
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 26B6E24454;
	Mon,  2 Sep 2024 14:08:27 +0000 (UTC)
Date: Mon, 2 Sep 2024 14:08:25 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <ZtXG2cEbxr8pNg7j@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <cover.1725206584.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/e/G/NUrB8GQsvpN"
Content-Disposition: inline
In-Reply-To: <cover.1725206584.git.me@ttaylorr.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--/e/G/NUrB8GQsvpN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-01 at 16:03:15, Taylor Blau wrote:
> This series adds a build-time knob to allow selecting an alternative
> SHA-1 implementation for non-cryptographic hashing within Git, starting
> with the `hashwrite()` family of functions.
>=20
> This series is the result of starting to roll out verbatim multi-pack
> reuse within GitHub's infrastructure. I noticed that on larger
> repositories, it is harder thus far to measure a CPU speed-up on clones
> where multi-pack reuse is enabled.
>=20
> After some profiling, I noticed that we spend a significant amount of
> time in hashwrite(), which is not all that surprising. But much of that
> time is wasted in GitHub's infrastructure, since we are using the same
> collision-detecting SHA-1 implementation to produce a trailing checksum
> for the pack which does not need to be cryptographically secure.

Hmm, I'm not sure this is the case.  Let's consider the case where SHA-1
becomes as easy to collide as MD4, which requires less than 2 hash
operations for a collision, in which case we can assume that it's
trivial, because eventually we expect that will happen with advances in
technology.

So in that case, we believe that an attacker who knows what's in a pack
file and can collide one or more of the objects can create another
packfile with a different, colliding object and cause the pack contents
to be the same.  Because we use the pack file hash as the name of the
pack and we use rename(2), which ignores whether the destination exists,
that means we have to assume that eventually an attacker will be able to
overwrite one pack file with another with different contents without
being detected simply by pushing a new pack into the repository.

Even if we assume that SHA-1 attacks only become as easy as MD5 attacks,
the RapidSSL exploits[0][1] demonstrate that an attacker can create
collisions based on predictable outputs even with imprecise feedback. We
know SHA-1 is quite weak, so it could actually be quite soon that
someone finds an improvement in attacking the algorithm.  Note that
computing 2^56 DES keys by brute force costs about $20 from cloud
providers[2], and SHA-1 provides only 2^61 collision security, so a
small improvement would probably make this pretty viable to attack on
major providers with dedicated hardware.

This is actually worse on some providers where the operations tend to be
single threaded.  In those situations, there is no nondeterminism from
threads to make packs slightly different, and thus it would be extremely
easy to create such collisions predictably based on what an appropriate
upstream version of Git does.

So I don't think we can accurately say that cryptographic security isn't
needed here.  If we need a unique name that an attacker cannot control
and there are negative consequences (such as data loss) from the
attacker being able to control the name, then we need cryptographic
security here, which would imply a collision-detecting SHA-1 algorithm.

We could avoid this problem if we used link(2) and unlink(2) to avoid
renaming over existing pack files, though, similar to loose objects.
We'd need to not use the new fast algorithm unless core.createObject is
set to "link", though.

[0] https://en.wikipedia.org/wiki/MD5
[1] https://www.win.tue.nl/hashclash/rogue-ca/
[2] https://crack.sh/
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--/e/G/NUrB8GQsvpN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZtXG2QAKCRB8DEliiIei
gYJ5AP45kZhSd+8aJcqw4UKk4p3gceu/oqhsfESc4Bnpee5glgEAhYlzoPMBvW8d
g7f4TnHA1tSjEcxKKWsxI6A3LJbZzw4=
=5nF4
-----END PGP SIGNATURE-----

--/e/G/NUrB8GQsvpN--
