Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7E914830A
	for <git@vger.kernel.org>; Mon, 26 May 2025 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748289358; cv=none; b=DG07wIBdUp3UKPf5rkI6475TdjwIuTQvFsVnmfOHRKi5Z8qiyQS1pKRxQC8h/FlGmmTvIkzps7Og5bK2/bHaxvtJvLcMt36vEVUfwOkjDFNb3tcFl9noD62lUkNUlXbaj6cR6lMCwD5hG/5tX8nLdXxfaJGtH29d8ZpRWn4OMBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748289358; c=relaxed/simple;
	bh=rdcxtSKduE8LefUxLXe0gyzfSf4RDa+3pxeo93X2Y5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+03uIsGqYsujrxPxp17eKuLUMbAKA6GQFceo03C981X2NzvJgB/eX/MTl/rg8Gidx0E6TNiD/SCCSDV9R6dyeI7jkcK9vmsfQSU9TU/9z5kGCD2+zTYC/AzDLZmYEGnWkL0zfosVtXKeamGEomhG/yfSZJia/R6phfoM251NXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=IL4IGxJx; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IL4IGxJx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1748289354;
	bh=rdcxtSKduE8LefUxLXe0gyzfSf4RDa+3pxeo93X2Y5s=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=IL4IGxJx8FLGqi0X4FogEUdcnC7FHrqdW8Fw2x24uw+6OCRv3m3TcDPNK/8eFF63n
	 h1bLL7hs1zm69Q+iWH6x9HIlDgz0VM26P0J4Z21IZSEugmzPGt8q19KzPyD7yyVzqJ
	 FFWq10WNZX+XVNfE5AfpSClSnQhnQv9q6aEKHHL2SRyb7mW0CwQHQxnYf3xwH+Ksz0
	 vPMU7yl0eQSuW6KCaeAHOdmMsle/LR0o0KheuxiJORvUZOtaDOI6+4cu7VzbyoCWbD
	 51JAGEB/Sm0LEt6TPZJApLf9lTMgWqagMkU+JhLRx9Lpk9lOn0YAfwdiu7lC0YZZdM
	 CKxy1JpBKqpX6+DRng5jDpVq7l2Oww0vaFBckLPgnVkPz4s2r7bREF/IMwfIzWxz4g
	 IZE/kES9YYBnYSrzWtX8ymg4wdQom298jbVQrn2DUW1H1VgqLOxUgVZy1YZ8q7Pn1+
	 CSrCVn62oiu2FviS0E/B3MgYk9/sGTRAGvZmYbUkDaek06LyUl/
Received: from tapette.crustytoothpaste.net (unknown [204.148.157.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5891D20038;
	Mon, 26 May 2025 19:55:54 +0000 (UTC)
Date: Mon, 26 May 2025 19:55:52 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 2/5] reflog-walk: expose read_complete_reflog
Message-ID: <aDTHSOodIuhBgZ_x@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-4-sandals@crustytoothpaste.net>
 <2e8e7eb0-f526-49cb-8f75-379fa7ef6446@ramsayjones.plus.com>
 <aDEDGfyvkTFyf0I8@tapette.crustytoothpaste.net>
 <b8a94020-0a7c-4d3b-92bc-a8a80b8d7af0@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fd7MV+EJYDAcl4/Z"
Content-Disposition: inline
In-Reply-To: <b8a94020-0a7c-4d3b-92bc-a8a80b8d7af0@ramsayjones.plus.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--fd7MV+EJYDAcl4/Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-24 at 01:09:49, Ramsay Jones wrote:
> So, at this point, 'git-compat-util.h' will already have been seen
> by the compiler (so it won't cause any problem, but equally it is
> not needed). In order to determine if the header can stand alone
> you should just need to:
>=20
>     $ make reflog-walk.hco
>=20
> [That is what the hdr-check target is for].
>=20
> So, yes, include 'hash.h' to make the header file stand alone,
> but 'git-compat-util.h' should not be needed.

Okay, I'll change that here, but it does make clangd much less useful
because `hash.h` does actually depend on `git-compat-util.h` and so
clangd flags lots of missing types.  Perhaps we should revisit that in
the future.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--fd7MV+EJYDAcl4/Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmg0x0cJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ7TiXTjc2UJJVB4sfcuyPXMMIYTDZg42aWI4vAKGczWZ
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAHz+AQCQevrqYl3g/7hj4xMvuwmqMj5W
IA2y3I9sEvhzJC3BVQD+J+8bBrMxBZyLsIhqL9qBUX4PqWdC/iH0H2MRAa9JRwE=
=Tc5y
-----END PGP SIGNATURE-----

--fd7MV+EJYDAcl4/Z--
