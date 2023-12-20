Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D930D1F5F4
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KF5nwHz7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AV4IQozk"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 7075D5C00D5
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 04:17:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 20 Dec 2023 04:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1703063826; x=1703150226; bh=NGeFcX67vsynCvLhbxAB9N88UcXyudEw
	fZYG0zpuB94=; b=KF5nwHz7XIXE2rFMg9vqI3NO3BUEDbgLCwJgshhQQmo0tUU8
	AET/zR+p4cmcoa/ckp8PzTjJyC5ceDBUsyTq7HR/n/+j1NyBsDKLf4x8F3hhfD4Z
	umR90yPaVlPFzcMvUSj3c1ydiPPKDIsWzNfQEbtanhXDtTReeiYLnDgvHbyhpPCT
	stK2Q6FuB6sSWG6y0b6Ngww81JZjjxHCC18k3yWJMsnVwh1l0GqtfRPK1sUqibj7
	CYxPKYOi8AaKSPuLUSdVrvcNCzLybICEf9O0us1zmhkYegcWf+N6SVoelX8n9abO
	K/1EvbvMyUzKl0rEugzUwLeyyJeSo46zojhN8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1703063826; x=1703150226; bh=NGeFcX67vsynCvLhbxAB9N88UcXyudEwfZY
	G0zpuB94=; b=AV4IQozkYUjxFOWg5i2AUgScYDBWKbQgzuCa9Zv7m+CZjjnrkqK
	vpWCHBYTNCE32zHFzjtlfebAB/bA39/XCTU7HDW0x32HxZKFBUZTGQd7DcELuH8N
	XYjvFphz907RKAxNWscdXEX1ZzhNI3/7J+sjxWdszHwobegr3DaByRfUb1QdLdLa
	qS5b93txXoc9vgdLkxAlCfKXtF/EPw8tqsweV1woCT+VOYJyUl3BGlwjaTaZu1Vg
	gt8r6ybJdnJ2jTKLF1I1O8Yum5+Asl+d1ZwQhAPO3CJps5OYTVrYmjnyp51kqvrp
	xihzsWVEeaysY+EJMfmUIiFbLeTsXZKp/Mw==
X-ME-Sender: <xms:ErGCZRUKvrB1M-Sl090HnEiSybVv8rSbSHyXR1hCS_xKGsJCuUVMpQ>
    <xme:ErGCZRlFS8c07cl6DU1LP68qUiKKqxR7r__AwwOR98x8Uwe2b9KGjkIewc7EGfmvm
    wUn2EkXJh8Svlm4hw>
X-ME-Received: <xmr:ErGCZdY5jdNDt4-4mHYb5fPB6FC_JlOShJ2K251FUaRhp-iqxA-7SkzFyFnVMb5D0IejX4raPtjlmvwWiYSKWKj7gsmcSM7ncpyuccnT7GZfWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ErGCZUVQQx9nazeWGEv1dzlvB3VAazIURxsCkFsvJlMfayccAOtP-Q>
    <xmx:ErGCZbnvpttn0ihnzZRhQkIdJ5FZ1FkVF_0ltBjH2CgdU6VcYXWfzA>
    <xmx:ErGCZRfk5m5jIJVgXbXdvXS8iJEeX7ZAkqm1KdRJeCQcjnrw5jV6pg>
    <xmx:ErGCZRSi_2OIF7gKfoUrcnsRi1pghTgLaCiOimrdQJmbzCJFM0siUg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 04:17:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ef14103b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 09:15:08 +0000 (UTC)
Date: Wed, 20 Dec 2023 10:17:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/7] reftable: fixes and optimizations (pt.2)
Message-ID: <cover.1703063544.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RrZPrcIFiP86mTyN"
Content-Disposition: inline


--RrZPrcIFiP86mTyN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second set of patches that fixes bugs and performs some
slight memory optimizations. The series builds on top of c0cadb0576,
which has been merged to `next`.

The series is structured as follows:

  - Patch 1: some hardening to not corrupt the reftable stack on
    compaction.

  - Patch 2: fix corruption of a reftable when writing multiple indices.

  - Patches 3 - 7: various smallish refactorings to optimize memory
    usage. Overall these reduce allocations when iterating many refs by
    almost 85%.

Thanks in advance for your review!

Patrick

Patrick Steinhardt (7):
  reftable/stack: do not overwrite errors when compacting
  reftable/writer: fix index corruption when writing multiple indices
  reftable/record: constify some parts of the interface
  reftable/record: store "val1" hashes as static arrays
  reftable/record: store "val2" hashes as static arrays
  reftable/merged: really reuse buffers to compute record keys
  reftable/merged: transfer ownership of records when iterating

 reftable/block_test.c      |   4 +-
 reftable/merged.c          |   8 +--
 reftable/merged_test.c     |  16 +++---
 reftable/readwrite_test.c  | 103 +++++++++++++++++++++++++++++++------
 reftable/record.c          |  17 ++----
 reftable/record_test.c     |   5 --
 reftable/reftable-record.h |  10 ++--
 reftable/stack.c           |  20 +++----
 reftable/stack_test.c      |   2 -
 reftable/writer.c          |   4 +-
 10 files changed, 117 insertions(+), 72 deletions(-)


base-commit: c0cadb0576d4920915eb3bd38a7d1abfcbd25f98
--=20
2.43.GIT


--RrZPrcIFiP86mTyN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCsQgACgkQVbJhu7ck
PpREBQ/8DRnh4wlfteJdz4eg8BSU1GIwm7+PlAt/oNUJ+ur+sPYgj2UqRmF8KbG8
Vzl4pI49awoeXo6ABdB+A+XGsKO84dQMfW3+cz0gQWLnCnJyj4EEWTq2C4pqtYHi
BcMRgfKxIqVP2N1o5NqbxN+CPKZ5xQ34cd+ljUIWDd4PlQPT4GlHTTGoeaP0ZovP
XTUUJn0yRev77+eTXHukmxBWXot8rNBJP0y4EnoRyCgR+OR0Em9XXC/Jt/kW6mqj
22LNR52h2jjbNWGJNt2HJmV7gj6fdAW+rUUVBE8/jtOIfOlNf3MmllnuBhmT6H/u
wxUMAfY1742gOsWek1mAJxjMXdF6yn+wiNiNFheNFYHSZR0GHD33z3LAHox7vI6n
Ix3x6E1l52GKS3tn18a6q1MIdvGvBpz+nYbGmVmzhxv55+9AClrEuPvoCEVgLgis
ANo7yz/I7Ung4/s0I19j1KCcpIAwCPeMdzEK2hAWYuH94E/H5q7wb99Q+PpYA6Hy
Q+hVBw9rNmXu2r9MSmwzg9uE3chm/hXqFQskzSnrdfxfpRrFXCFEF1ob+EWJq88/
xrWsJW0NvsBbVjOQBpI2alDlaQaMDHTbq5ItMW0w62pMcxGjyDaBlQBHtqu8YZxu
Ee5u3PFJhocAyUdPBp9hxcCHNsYwiSLfYa3W/2/H463/MHm0nck=
=GcWi
-----END PGP SIGNATURE-----

--RrZPrcIFiP86mTyN--
