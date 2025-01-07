Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E846D1E25FA
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736292109; cv=none; b=KYznRCOPOb482rUN/4hA4mwmPPzOZBwHSkhZbbgwvwTQYjFHIcNqox3zfnciV+WGIHnvviJO2aAQpzh+tLB1RVU7uitwJe9vBEinMZ5D/RUxLdwLUA1vhP4MdSWSMX3xDA/LEiqmqXusyx43V09I5ZGcgiaB2vFeaTatVIrsTIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736292109; c=relaxed/simple;
	bh=94nsO94f392jU4Co/ptSv6X3lUPyrk1Qtscq+3i3Ze8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJd5x2cvNPqQaPsoSYmgEEOB2LxYlLN4gAooz3eCTS+jDH8qXulpu3/kmqUbndcdk6U8gSOGUx97N4EVnc1BXFjfLkuOMYCTPLo9ZS18QTsZZI2PkSPtjAmkwAQFB84NvE4OFZU+X7LflArOyNNQ9l3ErJPvp0aeWjhaQkXfZ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=FJ59EuPY; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FJ59EuPY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1736292105;
	bh=94nsO94f392jU4Co/ptSv6X3lUPyrk1Qtscq+3i3Ze8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=FJ59EuPYxTGDFh6GELeGBRdfTQeDS111+jdTbLwe2iJdAF2PD1S6LLmLOCZVLyjFY
	 uHnzMJGGu4YCw0oySNp6z3CCsc+Wdv2BKp+3JRTtmBrq4FX2yFNKHZ98qCK6sEuKWV
	 Xpp7g1/+06IzgU9S7ZZcx3c5AHfKjL0scIoUJzuN+p97sXuM4IAoiC5a7pMK3ZSEYh
	 BfU4ousrliPLfhBwjpsutINT/3GUXrhYXDtmxh9iKMAOBoG7WAVvXmT4hb5SiEYFVf
	 mSMQJbq78FryeyYAAsP5Qpz8GBfMDrloV25pCNTY/cdV9NTL26VFtz+qHS621hwLG3
	 /4qUOvSLfGrzwn93rQhWaOdHSlbZIPCaS1SflRjELCoyphD2v/NWIpR+8ek666MrXT
	 /gJUY6nOAD6DZfqvldKOQdTfuHeuo8pkNalCyfhB9jzcTGMubTJJ4Slrjj2t3ulN01
	 MudJMM2Sj1Vj/gi0lzTu5P0DCKENxuOvdd2dx5N/K5D6MNITFCG
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A9960209BF;
	Tue,  7 Jan 2025 23:21:45 +0000 (UTC)
Date: Tue, 7 Jan 2025 23:21:44 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 0/2] reftable/stack: stop dying on exhausted entropy pool
Message-ID: <Z323CLrRsnOko1gB@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"Randall S. Becker" <randall.becker@nexbridge.ca>
References: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K8inMK79QvD7Cah4"
Content-Disposition: inline
In-Reply-To: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--K8inMK79QvD7Cah4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-07 at 15:26:58, Patrick Steinhardt wrote:
> Hi,
>=20
> this small patch series fixes the issue reported by Randall [1], where
> an exhausted entropy pool can cause us to die when writing a new table
> to the reftable stack. I _think_ that this is only an issue with the
> OpenSSL backend of `csprng_bytes()`:
>=20
>   - `arc4random_buf()` never returns an error.
>=20
>   - `getrandom()` pulls from "/dev/urandom" by default.
>=20
>   - `getentropy()` seems to block when there is not enough randomness
>     available.
>=20
>   - `GtlGenRandom()` I cannot really tell.
>=20
>   - The fallback reads from "/dev/urandom", which also returns bytes in
>     case the entropy pool is drained.
>=20
> So OpenSSL's `RAND_bytes()` seems to be the only one that returns an
> error when the entropy pool is empty. I did wonder whether we even need
> to introduce the new flag in the first place, or whether we cannot just
> use `RAND_pseudo_bytes()` unconditionally. But I'm a bit uneasy about it
> given that OpenSSL has this doc:
>=20
>     RAND_pseudo_bytes() puts num pseudo-random bytes into buf.
>     Pseudo-random byte sequences generated by RAND_pseudo_bytes() will
>     be unique if they are of sufficient length, but are not necessarily
>     unpredictable. They can be used for non-cryptographic purposes and
>     for certain purposes in cryptographic protocols, but usually not for
>     key generation etc.
>=20
> It might be too easy to accidentally rely on `csprng_bytes()` where it
> actually requires strong cryptographic data, so I was erring on the side
> of caution.

The reason I didn't use RAND_pseudo_bytes is because it's been
deprecated since OpenSSL 1.1.0 and RAND_bytes uses a CSPRNG just like
RAND_pseudo_bytes as of that version.  Once it's seeded, it should be
able to generate plenty of bytes, because I believe it uses a CTR-DRBG,
which only needs to be reseeded after 2^48 bytes (which is far more than
we should be using).

We can full well use RAND_pseudo_bytes, but all operating systems should
provide an appropriate entropy source that can provide 256 bits of
entropy on startup.  arc4random will just kill the process if it can't
seed itself, so your changes won't actually prevent dying on a lack of
entropy.

I don't want an option that chooses "insecure" bytes.  My preference is
that we require people use a different backend or an up-to-date OpenSSL
version that shouldn't have this problem.  We can use RAND_pseudo_bytes
if we really need to support older versions, but there are also no major
operating systems which require that old of a version (CentOS 7, which
is dead, used OpenSSL 1.0.2, and CentOS 8 uses 1.1.1k), so it's probably
not within our support policy to do that.

Note also that if OpenSSL is being used for TLS, a lack of entropy will
result in TLS not working, which means that Git will be randomly broken
on that system, which is not really an experience that we want to
encourage, so that should be taken into account.

Can we get some more information about what version of OpenSSL is being
used and what the system entropy source is?
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--K8inMK79QvD7Cah4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.45 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ323CAAKCRB8DEliiIei
gWoZAPsE9OpK6NWJKFQvOEZ+zgBp+EqZyVQlP49Dcp1poehD3AEAtCgmEXoaG71E
qkkmZaEa1RNkZ5v/jB+k1ZyXuZ44uQ4=
=ZAiQ
-----END PGP SIGNATURE-----

--K8inMK79QvD7Cah4--
