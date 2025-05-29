Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5069021D3D3
	for <git@vger.kernel.org>; Thu, 29 May 2025 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748560392; cv=none; b=tv2ZVuMjy84izSF4iBUbIUR0YrYkbkeSBU5xcChQe4OZWSjU0Gh91w65I8RD8EphFlVx/ilyU6mt7ipKUPsiFpBv6jIulkjqukFvLGCgGxjyl3UM9kQW5k2X2oebi98uK9aF4BGcTVb2G+9N0hi/GFB02RNa0WzQN2btTTcDBdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748560392; c=relaxed/simple;
	bh=A2gmmPjnTQPc3xrbw8vKRsXEZQdrO5955vSLavZEdGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxEaJ0V1/1JTC9bL8fsSquaU30ME45VeUp3YMvGwhB288/ibjeNqwML6E8j03+gwq/NvJq11iE/QJFayFHZGE2RRtRokK0uJlL6eQL5yCpasZk/YZEb9bVQz9RQXF1r9eosXLB0WJoBEG/j2gVjhmQijFEF0OxxC1vMZ+OhUVm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=l5eYQlRN; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="l5eYQlRN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1748560381;
	bh=A2gmmPjnTQPc3xrbw8vKRsXEZQdrO5955vSLavZEdGc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=l5eYQlRNNjpPloqhmcoeLR8FzQ+3lO/yKqzdFlfCdm2oqlpDWlwsTK24Al6m0cNWI
	 yW7ODNruSflX4oQwtw3T3uG0eaydRHlH+Qd8HnMMODES6GsMH2sUpri1eR2ZuWfOo6
	 ookugixjHSiHp5Mv4IBb6gQF4Yx1hATGUU2XQI1n2CN1mEzpkLgEui6mO9KDDbTVYO
	 LnbztSjWFDv3jNuL5Ka4XDujNtB9Ptg1mGWIG7Js9gL+jA+Mq5dy6kN2K5S5S2XBgu
	 9J8v7yxyLVg6f1uvVoRhWN4DtGCVy7zWyqBgGtGJ2iOMhAZMokpT7iRbNlCGLDYJha
	 JLar0ce8QitpaYxuas8zMAhTRWEeP/DpRonvhNiCu8Fkaj6xEUrI7GvmOPcwDtL2ZS
	 Dn0HOL/q/FyYyexhxZLu5ZR/NI4iml8IloX/5LmMUN3Q3LjQvugrZ2KGUe4d+Ln8Vh
	 3Pby1Wh3LkigKC+LE1b5zjYk0lTkiLyocFsRqkUCAhieQju1dH5
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C4EDC20038;
	Thu, 29 May 2025 23:13:01 +0000 (UTC)
Date: Thu, 29 May 2025 23:13:00 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	git@vger.kernel.org, ps@pks.im,
	"Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] reftable: make REFTABLE_UNUSED C99 compatible
Message-ID: <aDjp_IkgmITrl59-@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	git@vger.kernel.org, ps@pks.im,
	"Randall S. Becker" <rsbecker@nexbridge.com>
References: <046901dbd002$a0c245c0$e246d140$@nexbridge.com>
 <20250529101136.16219-1-carenas@gmail.com>
 <xmqqtt53l7cl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ySHDxNRkVy2NQe7B"
Content-Disposition: inline
In-Reply-To: <xmqqtt53l7cl.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ySHDxNRkVy2NQe7B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-29 at 16:17:14, Junio C Hamano wrote:
> Corresponding definition we use in the main part of the project
> defined in compat/posix.h looks like this:
>=20
>         #if GIT_GNUC_PREREQ(4, 5)
>         #define UNUSED __attribute__((unused)) \
>                 __attribute__((deprecated ("parameter declared as UNUSED"=
)))
>         #elif defined(__GNUC__)
>         #define UNUSED __attribute__((unused)) \
>                 __attribute__((deprecated))
>         #else
>         #define UNUSED
>         #endif
>=20
> GCC 4.5 or older may no longer be relevant, in which case yours may
> be good enough.

RHEL 7, which is now well past EOL, had GCC 4.8 and Debian 7, released
in 2013 and also well past EOL, had GCC 4.7.  I think we can safely
assume nobody within our support policy is using GCC before 4.5.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ySHDxNRkVy2NQe7B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmg46fsJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ9hHeuOwYzEZFNNLd5euSoRIeISN4O7kaEo8cBFZjFiZ
FiEECCzmip28ZfuD0cORfAxJYoiHooEAACElAQDEDfabqSJf996YnDFBOFnAsvEO
zbXajKKXUBdxoD5HLgEAseTWEmI/O2YBWD/6nA25Js1s4tp+nqYg5hKNwHpxgQo=
=KSOB
-----END PGP SIGNATURE-----

--ySHDxNRkVy2NQe7B--
