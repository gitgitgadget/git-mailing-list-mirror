Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C122215E88
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944181; cv=none; b=IOBgeUKxknVIEkTb/dAO3ViGUCMkCamAgYJwxWpHNtCj+ebRBeFMKVxLcBGqs2gUSPqSXVK4iXCVStvgzrvU/epxXlVmdzByw4D+wekPSGCTcWxnGNVFesMtaPSHNsrR/96eJZJ/ncxHZFHjxIu1CKzNbA0bxcsRmS0/V4DP2KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944181; c=relaxed/simple;
	bh=6+O/O0FAsucqgA0yihLBDtGeO51bcu1qet4867yduEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j39JCKvJSWIYsLn2yEwfrpkPj0Qa3NbrxG3H72TQFgakO58y2T+ea0OH4SVVyKbscj1FgSRFpFwXJLm0011rly5fQLPINaprA83Yywa1kDG6fMAkWBHSmb37hXKgQz5eMPJ5IoEClwuS7V9Ws7zZb9aKRG4wY9UTIal13Dr1ji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uDB9TbF2; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uDB9TbF2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1730944177;
	bh=6+O/O0FAsucqgA0yihLBDtGeO51bcu1qet4867yduEk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uDB9TbF250THIfXMvyDb7tzR2EiYDXryXK0CZLIgkrEx2jQQzKYf5rWExqB4v3n1v
	 e5J+3PM8660XT71VuC0sRwogZJNY/zs5r/rnTtG2DM2TVSi+xyXVNMY9Mh067GE/4L
	 oW0+k2G2AA79WmhzcNHnMP8dexQ4/3xXQ5z5tYHQ/TPV88A9Lz2UMN62E8IEKXBal7
	 s7Vt9J11O2eIz7RwtOriiKCtCKpiwbtNmopoms96+eUVUrkHY6h3ZsFq81pnaeoYVE
	 l1GZBdOjaLhixvLxV+CMSTYGBGyc/nfUo60s8vzCIXezhMV1oCn54j7zq30medkyf/
	 KRAiLUIHqdIduk3C1H3Ie6X3ETTpWbcM+dR3Jq24p+NFXECD6ga2BcAgarFOHY05sX
	 vh0slHIQMXmjBLNrJ/TsYp2ObQYdNuoB+iCZZeS6PXT2PMsnBWmyE4akmsWCtIFSPD
	 IJ1eTRCIJTNAJH+QM45wdBxyDIJ37nJovmPZgfMTCf5wZxYTuOY
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0E6D320073;
	Thu,  7 Nov 2024 01:49:37 +0000 (UTC)
Date: Thu, 7 Nov 2024 01:49:35 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] t/helper/test-sha1: prepare for an unsafe mode
Message-ID: <Zywcr2lMM_Ij8suu@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
References: <cover.1730833506.git.me@ttaylorr.com>
 <0e2fcee6894b7b16136ff09a69f199bea9f8c882.1730833507.git.me@ttaylorr.com>
 <xmqqcyj9qgyf.fsf@gitster.g>
 <ZywOWn08cGBnBWM-@tapette.crustytoothpaste.net>
 <20241107013915.GA961214@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oIWPVcPBeDsTW+KK"
Content-Disposition: inline
In-Reply-To: <20241107013915.GA961214@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--oIWPVcPBeDsTW+KK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-07 at 01:39:15, Jeff King wrote:
> So I think you wouldn't want to allocate an enum or a slot in the
> hash_algos array, because it is not really an independent algorithm.
> But I think it _could_ work as a separate struct that the caller derives
> from the main hash algorithm. For example, imagine that the
> git_hash_algo struct didn't have unsafe_init_fn, etc, but instead had:
>=20
>   struct git_hash_algo *unsafe_implementation;
>=20
> with a matching accessor like:
>=20
>   struct git_hash_algo *unsafe_hash_algo(struct git_hash_algo *algo)
>   {
> 	/* if we have a faster "unsafe" implementation, use that */
> 	if (algo->unsafe_implementation)
> 		return algo->unsafe_implementation;
> 	/* otherwise just use the default one */
> 	return algo;
>   }
>=20
> And then csum-file.c, rather than calling:
>=20
>   the_hash_algo->unsafe_init_fn(...);
>   ...
>   the_hash_algo->unsafe_final_fn(...);
>=20
> would do this:
>=20
>   struct git_hash_algo *algo =3D unsafe_hash_algo(the_hash_algo);
>   algo->init_fn(...);
>   ...
>   algo->final_fn(...);
>=20
> And likewise this test helper would have a single conditional at the
> start:
>=20
>   if (unsafe)
> 	algo =3D unsafe_hash_algo(algo);
>=20
> and the rest of the code would just use that.

Ah, yes, I think that approach would be simpler and nicer to work with
than a separate entry in the `hash_algos` array.  We do, however, have
some places that assume that a `struct git_hash_algo *` points into the
`hash_algos` array (notably `hash_algo_by_ptr`), so we'd have to adjust
for that, move the function pointers out into their own struct which
we'd use for `unsafe_hash_algo`, or be careful never to call the
relevant functions on our special `git_hash_algo` struct.

> All that said, I do not think it buys us anything for "real" code. There
> the decision between safe/unsafe is in the context of how we are using
> it, and not based on some conditional. So while the code in this test
> helper is ugly, I don't think we'd ever write anything like that for
> real. So it may not be worth the effort to refactor into a more virtual
> object-oriented way.

Yeah, I don't have a strong opinion one way or the other.  I think, with
the limitation I mentioned above, it would probably require a decent
amount of refactoring if we took a different approach, and I'm fine with
going with Taylor's current approach unless he wants to do that
refactoring (in which case, great).
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--oIWPVcPBeDsTW+KK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZywcrgAKCRB8DEliiIei
gWurAP0SWwyAvNTvKTp3xSboX4c5Ds+xsuPuPZYChOJcsFIj/AD/RITX7GURz6Fk
g4yltbEjiP10bDVi+C0/hS2shVWvHw8=
=W4UH
-----END PGP SIGNATURE-----

--oIWPVcPBeDsTW+KK--
