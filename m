Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B14B26CE2C
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769640659; cv=none; b=PdoXn5nHzg56nlyj1MC/kgiSh/z+PLVJZGYGdUS+wY0KHYU51edBH4s9LUwDK+D3GX9Z4wPc4DAYR5DAvDwsZE4qyv8BZOK7TGpJaVmloUr/vwWRcfOzyjNyLX9lTErBXBuo7Q2aWfADin4V1ZEbVQ9CP6SEarlFnBmqJpTvgxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769640659; c=relaxed/simple;
	bh=FLjv1aiBeFGH5zRsscQoSveON4AcCK/K8JZiWiVvMfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsJ+7st7L/AjkRUUw9haufV5KOGDf2Pi5waEo8xQGf2YtFqbpP4mClGGnYPUiM9ySoFiJZ1c7/DHmPb3RtNuEqYcBvt6PRcZzUpU5Qh90F9wArTIfMFxjsGjhBM601GpvBEhAUgKZoeUL7BmywQdZ+ttOa5N57S8QBjmsgMZjRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=alSvYu6k; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="alSvYu6k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1769640652;
	bh=FLjv1aiBeFGH5zRsscQoSveON4AcCK/K8JZiWiVvMfw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=alSvYu6kQy5oaQFt3SAKcMeNU4Nh3tt8SCDu1ytUPjkH+PHwHEGiDG6Ol459RUKwK
	 dabV/kA9tgUW55DUAv9dOoGs8LiI0nHUlF6Yi4LFv1wiQqLFxDuUZRSN3zZGPHHC1A
	 iPnkmlfO6kPevDVW3oN46Vi6gI+8GPjNZQoWciavgv8yTdGszjn3MAUmak70mhYqhd
	 tKFVU4gWxcqBi2dsB+HB9Aitp7rP21JZKqCnLUeY3xGjdg4adLzDmkEecDjf8aHVH7
	 vmx9/taObyzShC9Vqk/nI1D+lebCOYiD1XvzwTZPkMl6Z0kpapKvR8JP+BMwe6hRra
	 mzF0SKXK8PeHAMxGSwIN+VGORiVMBmvCAvCidZzbipJzgf0p+LCQGW4W0i0vB/EsOZ
	 rZHOXRe/c7eT2zqIaSJ87UXsRS1cUtppYLsq8V/2F3te8NAIvkixgCAVs3vPL06RFS
	 Cti3WXkggBmEh1O8NnQOIPAaOZ2pHGth6ViRiMfymbwDmp1CBAX
Received: from fruit.crustytoothpaste.net (pool-99-237-158-163.cpe.net.cable.rogers.com [99.237.158.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 66970200B4;
	Wed, 28 Jan 2026 22:50:52 +0000 (UTC)
Date: Wed, 28 Jan 2026 22:50:50 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <junio@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #09)
Message-ID: <aXqSyn3Mfcgs8MUG@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
References: <xmqqecnbeyvr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r23APUL11s926Hr7"
Content-Disposition: inline
In-Reply-To: <xmqqecnbeyvr.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--r23APUL11s926Hr7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-27 at 17:42:00, Junio C Hamano wrote:
> * bc/sha1-256-interop-02 (2025-11-17) 15 commits
>  - object-file-convert: always make sure object ID algo is valid
>  - rust: add a small wrapper around the hashfile code
>  - rust: add a new binary object map format
>  - rust: add functionality to hash an object
>  - rust: add a build.rs script for tests
>  - hash: expose hash context functions to Rust
>  - write-or-die: add an fsync component for the object map
>  - csum-file: define hashwrite's count as a uint32_t
>  - rust: add additional helpers for ObjectID
>  - hash: add a function to look up hash algo structs
>  - rust: add a hash algorithm abstraction
>  - rust: add a ObjectID struct
>  - hash: use uint32_t for object_id algorithm
>  - conversion: don't crash when no destination algo
>  - repository: require Rust support for interoperability
>=20
>  The code to maintain mapping between object names in multiple hash
>  functions is being added, written in Rust.
>=20
>  Any progress on CI breakages???
>  source: <20251117221621.2863243-1-sandals@crustytoothpaste.net>

Not yet, but I hope to spend some time on that this week or early next.
I now have some more time to work on this at work and I can try to poke
around and figure out what might be wrong, or at least try to beg a
colleague to try things on their Windows VM.

My apologies for the delay; things have been busy lately and I've had
less personal time to work on Git.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--r23APUL11s926Hr7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaXqSyQAKCRB8DEliiIei
gd6KAQCnID4iTKKNhoGB1lOnaFlDKZ5p/9jL/7S+6mddlgDggAD/XOaFGy0r+oiF
MVpPnK9IC/DRQNnh+j/FKL6tllJfrgw=
=gwlq
-----END PGP SIGNATURE-----

--r23APUL11s926Hr7--
