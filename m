Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795731531;
	b=HAhISmi0bh7yqRCmW8NszksIjD8QuRkLBDfDag9tVROsNrrbue9ol5Hz5pHqJBWJ8Q+d
	 yK0YqVIDIl7+s2TujFuNpAt/8vXRSeMhQddNszpPluTB442jsiw2IwNgFEG0M3xAWS6ew
	 dml3MjGQBe+VnEyu68lJzantXwHbeG0C3Mygpm4sygpFZ5WzkDxu+Y8EAdHTbFfq0pJKQ
	 ilgPC1VNLsWq/bSOIO9WiW7qpEHb7DOJCMoKo39CnrmkvJ9GkUePl9L+lTPO5QZswIAK6
	 0eT0MO/Kv2aoqANVWCEvr9tGLXKonK8bcqir7TMUlatdbI9Zbz2w17N/jXIWINjIwtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795731531;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=6NaQjTa6jKzQlXl+Ymm0eHNNKJUkUDqdTDr1RKsh5uE=;
	b=Rcy225m7Uvb9c94m4dEx9dkKAIGs0NGNY76KQMcKYfPK0A1FAXnzbT3olSL42+eOnRug
	 tBAZ2FJ8PSDyRRohcDdMSr660OZC+4emIZOee/BiV+tDFzZmwNdLGuJiMefSedFDja+kV
	 T2FdoY5W6EhzpBZ5ztGGbHaAjCUvG0uu4s8qbVy2I42Ko0mTArVd+OiZk+7aw/54N7j5s
	 dao0tOZu89g1NirVh2BhTAxD8EBUMw8aJZL1HeMc9EmNOG8AZTbmFFfqpdAOJ980CjAwy
	 92YsJrJngw+MrLyik+XxiPqRM7chtQ1UPnXio7j4b+FqcelVEh2o0iQoOKy+3fXcS3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=dLp573+s;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A9606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 22:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 441A9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=dLp573+s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1795731524;
	bh=7MWxx2iPIrWe7rt1SWDUpwYjTeRX/jKM6C3gAa035Es=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=dLp573+s0aGVmhujlJ2qgBo/eZyG3cbq9RHYGdcuFSoyAzuxvZawD1NJ3PFRH+Nv0
	 mJwpwAxwlQSd0mUQOMdOxyMOOXbBAGkpmJ9LqksVNj//ddGVLuoZlzviua34yjUpzk
	 9Nvgej52QpK4y+lJbU2O3Kx9bm2YhRm3pZavWPPRNoKGe3HbaEJZTw7iH8AQ0EjqZB
	 udngwKjboimcPNPd7I0AFH2p6A1hWAy95BNEtRDFTXH7mrKYaa8J3fZ/tKdkzsZ1z7
	 6ZqU/9yochF1/LQygeCWvB7NDTwk2g9GgIs0Xx3rAWNSlqR0nGB6t2d4kzIynstqrt
	 /IGqaZCySIdOxw3et2aX9crhzaGLS1oZGk3FmENJlJf9byT8pyPiiTh+GHSEs428bp
	 sZYD5vcPHcDAUg8vUcZ6+15HW1Fq6v3mVI4LAmMRakah4E86iNX9EsTbh5yz2/l8JE
	 aeMkd0hRrjcywKAcb65g5NrxL9a5hLuhTVZalEkVh1Olr63lCb1
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3039:9617:3790:4535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EC59B200B1;
	Thu, 26 Nov 2026 22:18:43 +0000 (UTC)
Date: Thu, 26 Nov 2026 22:18:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 03/13] loose: add a flag to control whether we write
 mapped OIDs
Message-ID: <awiwQoVqW5MJZpml@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
 <20261023072559.3204273-4-christian.couder@gmail.com>
 <3b70d34b-5dba-48fb-ad5f-137e73c36c78@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VFkVl+cxw5j+nt44"
Content-Disposition: inline
In-Reply-To: <3b70d34b-5dba-48fb-ad5f-137e73c36c78@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--VFkVl+cxw5j+nt44
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-11-26 at 13:57:01, Kaartic Sivaraam wrote:
> On 10/23/26 12:55, Christian Couder wrote:
> >=20
> > Right now, we always write the object to the loose object map.  However,
> > in the future, we'll need to temporarily store some object ID mappings
> > in memory so that we can rewrite other objects, such as when we're
> > indexing packs.  Let's make this easier by setting a flag indicating
> > whether we want to write this to disk.
> >=20
>=20
> In retrospect, I suppose the "Let's make this ... " phrasing is kind of an
> unwritten unexception to the "imperative mood" guideline. I could find a =
lot
> of commits using it.

According to Wiktionary, "let's" is use to form the cohortative, which
is equivalent to the first-person plural imperative in other languages.
If I wrote this in Spanish or French, I would use the first-person
plural imperative here.  It is technically not imperative in English,
but only technically; it fulfills the same functional purpose.

And Peff has used it in his commit messages without problem (which is
where I picked it up from), so I claim that it's okay on that basis.
It also sounds a little more informal and approachable, which is why I
liked it.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--VFkVl+cxw5j+nt44
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmsIsEIJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ/+0yLgJsX1scfGghKxrAYpeGYpJAnBEhC4cddw9Ar5y
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAK1IAPwMrjRcJshmyGB8fOt/3V9WOF/M
3wdXz9ZfC7DOnhaYeAD+KB9v9vEOszFiGJ1NaGVF/JNIBqUD7ctveYRhzHRXKAQ=
=6h3l
-----END PGP SIGNATURE-----

--VFkVl+cxw5j+nt44--
