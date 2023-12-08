Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PmD6VSwu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nuiMllPu"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AFF49E6
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 06:53:01 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id A65D23200A39;
	Fri,  8 Dec 2023 09:52:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 08 Dec 2023 09:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702047178; x=1702133578; bh=wt
	ZFOvkeOPHc4ZlGUEbXKL6PpshBcQooz2M77/sSQi4=; b=PmD6VSwuyAL9SwJ7ec
	+GYgLAvdqFFzffGsF8wUsgWd9uDZs07mSBWHlYrfiH70J/62bSNzPt2vEV92may0
	dfBzLklNtweZKoijlcpD+deMxnaPkhlrKQN91lhfPIVqJ0ISA0D+A/Bw0nUAEc/I
	ETeCeJxdJa5R4DvC1wvm2KBfKHVpNAgYQSrQqeL5ZGjqR5jPD0ipNKGg5aMW8D36
	pFDMWAOkgHSNRQC+TodoaA0cpPYZ7mL12/JEEfOvh1sS5HDHuXsL6GK0v/afl/SL
	PIYK8iIvlDf5V4PUZIiNDv/6CqoJiIMggsHUges6KrZuN3FsLDXZATQLE3Tcu93y
	Se+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702047178; x=1702133578; bh=wtZFOvkeOPHc4
	ZlGUEbXKL6PpshBcQooz2M77/sSQi4=; b=nuiMllPuK6RaOzG6wze2ezrGsYgfc
	vvb88DTi/65RY56ScM37sE2ze+03tHiOFVB2aVl+6ek2FfjRMn5Jt9MnpeJUO4wy
	NfQ79AFdByD2h+37sKjLnRfiHBQHTt9MJkv49RvvoReNWlpb9X0vmhpqiIV7uJEe
	0sUjhdoyY6RcrsoLKeLgzzoBTMbiE63FLbbGdY2qrMuITzcfP29wtRgFYnDAH46x
	NLjQogog6KbiF9kvd248DtH8Lw6OrN2hRFGXnu/K8SyTJSauTVCmanafHsshnOtY
	M4t9F/JmdmQEDuNKXgbkexdrZ9v17j+k531Uzyo4Ykvqs+X1h6OYY6GzQ==
X-ME-Sender: <xms:yS1zZc8AgFkgM0byYjdtzna5hjB4sIV2c50Lh8slAb_wQ17rCxQowA>
    <xme:yS1zZUtuBKVcQ_sJZ3dLslJtrWpLNAqFfssjhXsYCy1oFuYGYdC0d3Jao_8f5jySy
    Am6yMN4dlX-2AB2gA>
X-ME-Received: <xmr:yS1zZSCwfuyEJQgFqFkA-RhHrDojvDs4phDKvpTzVWBz4kkifly4l7qad89RoMUMPHuqlkC4Hmi3FZN8I5PiusvBggL_DklE0SRcmnSAT2jIsW8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:yS1zZccpkeaW4IryzGL-c1d9QgzaBLKIfHhUGvsHBK4_ym4W5WGFIg>
    <xmx:yS1zZRNYD-nBokxb8Q1t5b3kNd_9ia4Q5EGLVek_8AZZy1VmxD3NcQ>
    <xmx:yS1zZWkuFDGzp9QLscf2Gjxvd9-ZduK6TEOkZkB4uXkd3FGNX7SKOw>
    <xmx:yi1zZf0Gw5-uHx1Rft16OWFuEM-2QFzwTusoIsDfV5TZUCsw9e8bNw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 09:52:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 848c2d09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Dec 2023 14:51:24 +0000 (UTC)
Date: Fri, 8 Dec 2023 15:52:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 00/11] reftable: small set of fixes
Message-ID: <cover.1702047081.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6+DR1iu4tDM7WG4R"
Content-Disposition: inline
In-Reply-To: <cover.1700549493.git.ps@pks.im>


--6+DR1iu4tDM7WG4R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that addresses several
smallish issues in the reftable backend. Given that the first version
didn't receive any reviews yet I decided to squash in additional
findings into this series. This is both to reduce the number of follow
up series, but also to hopefully push this topic onto the radar of folks
on the mailing list.

Changes compared to v1:

  - Allocations were optimized further for `struct merged_iter` by
    making the buffers part of the structure itself so that they can
    be reused across iterations.

  - Allocations were optimized for `struct block_iter` in the same
    way.

  - Temporary stacks have a supposedly-random suffix so that concurrent
    writers don't conflict with each other. We used unseeded `rand()`
    calls for it though, so they weren't random after all. This is fixed
    by converting to use `git_rand()` instead.

Patrick

Patrick Steinhardt (11):
  reftable: wrap EXPECT macros in do/while
  reftable: handle interrupted reads
  reftable: handle interrupted writes
  reftable/stack: verify that `reftable_stack_add()` uses
    auto-compaction
  reftable/stack: perform auto-compaction with transactional interface
  reftable/stack: reuse buffers when reloading stack
  reftable/stack: fix stale lock when dying
  reftable/stack: fix use of unseeded randomness
  reftable/merged: reuse buffer to compute record keys
  reftable/block: introduce macro to initialize `struct block_iter`
  reftable/block: reuse buffer to compute record keys

 reftable/block.c          |  23 ++++-----
 reftable/block.h          |   6 +++
 reftable/block_test.c     |   4 +-
 reftable/blocksource.c    |   2 +-
 reftable/iter.h           |   8 +--
 reftable/merged.c         |  31 +++++------
 reftable/merged.h         |   2 +
 reftable/reader.c         |   7 ++-
 reftable/readwrite_test.c |   6 +--
 reftable/stack.c          |  73 +++++++++++---------------
 reftable/stack_test.c     | 105 +++++++++++++++++++++++++++++++++++++-
 reftable/test_framework.h |  58 +++++++++++----------
 12 files changed, 211 insertions(+), 114 deletions(-)

--=20
2.43.0


--6+DR1iu4tDM7WG4R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVzLcQACgkQVbJhu7ck
PpRegBAAiiY4EYMT1DhLW0NF4/QFfuQbIUf7MKjsOfuw5LtwtYepS5pYt9/l3lZU
EruzcBUCRbRPsaeTtwQWImyCwZ7i6VdB9HTTJhAPowPDOOTqVVD2TMRUiZIVKqHU
WagHXrh1oVCiydW8frh6N8/mp82MMgh5IXUCdQ2Zn1uNh4B9DcIYGCsArCvCpOHr
LHzwh+ZWB5vIaQM3pTQJPUul2zxxljJ87WVCp00KAlwVrtivN7xwQEB+LAP88gUg
J5RBHi4K6rSaYaaXrrZzTWnEuok2FvcQilkL2bEoQw9HsY5a8sHOUx/iUfI+5LZo
BSS3aIWS8G3Te2OEqXkw/4dNlZMFTO2/UAsJBqcaDCDhOmMxehCFBVRFoNqwifjN
dsE8C9pXxeAuD91WV9bQN7l49g3aQEiahjuN37TiNtW6nNH+TEmMrhOaCPfUQSJb
f22Rg7XyUy/lz0RBITOi49xmeJTgbtV0aUQlCV8DropX5EglgXf6Y6jqA+qDtWyO
Mvzu4MepgW4fxkMrWWurRqhOaDFHNzKS4t33b+g//5UYVnvTlHxNG6YVQQjboRTP
Qw6qAD4OUBOaw38HvK2oaH/O+ohd5a9AM3y2Pc7HRb3x5r/7WBXvpRJeLv95QnfZ
MCYUC18leIbGOB6iUzF5nJWML+QfS4V7yfGL6UUmX7Pg0pPvdb8=
=N9bF
-----END PGP SIGNATURE-----

--6+DR1iu4tDM7WG4R--
