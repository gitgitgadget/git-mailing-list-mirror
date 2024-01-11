Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4E14F6A
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eAR7Mbaq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gBwsHgmz"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 4961C3200AC9;
	Thu, 11 Jan 2024 05:41:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 11 Jan 2024 05:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1704969712; x=1705056112; bh=2Ipr07Ah87UQt9lCf1UF32kJbLBHdHoo
	ofJgzuKwHdI=; b=eAR7MbaqK+ytMXpPGlMstw4WytEUbkikuzBB5P1OlDH4Lrhi
	hd+MVKTa1BmL3aH4XcrOSxzUQMOpe4i9wQrR+6XzoX08/5r+8fyAaLg9L4u4VfiQ
	W1s0G/hNtL2Wc/Sa1NpnzzBU4kWeH0NxCokfxPZ0y4qMiU1apUyK+OWG6y1GR5AT
	0utxs4tDdFGbx3FarHW49D6CiuJTS+KfrJbGEu4bSWmkO5UI+fMDd8ZdrCQz+x63
	62W4IIOpN6gOJcbLDoPlv11hiyboREfgvtkN/N/r1NhnsOwjTgw1LfHAixu1y+CN
	7HML3Jq45kKHa20GFQX4YE66lK53VZRucR5J3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1704969712; x=1705056112; bh=2Ipr07Ah87UQt9lCf1UF32kJbLBHdHooofJ
	gzuKwHdI=; b=gBwsHgmzHLD3g5czP2rKSODbmYqcfSZsTf2ITJcviR5U3dHJgbK
	RTUdg6rGDj0Kx94VEUsodeXeJw9Zd6C66TRSMvR8BhxCckR+rqkXU+Pv8/6xX36E
	U80fDIqUastcR0vWh2OpFTqypTcXXY9yqw/6moiSp6BsJpF/Gmo3YA7iU6dt9VUF
	4Ja6Tr+3wI1xQhlhI5iGmMr4p6/mtdWZQr9i5dunjRxq+xgu7P2KsChK1iyE9fQC
	Z4HmUxM1HXRnjZONxOSah844RYlXewwwcWoHRbIbhIVEtorQ/5DDTysY5390N22j
	fhvkXz/o7VKJ5rYdD4RNDtdJDPXL1YYcRww==
X-ME-Sender: <xms:8MWfZV6H0c6g08ueHIlNCaNkn_ZXX5wh8PRh77ry3UPpJp6MlJ_6PQ>
    <xme:8MWfZS4zc-WEOCNomlmXcJepA0B_DR32EgDdmUU-7RpWPHOQXQQ-_BVzFHuAkhc3W
    -HUt-9K1JarPts23w>
X-ME-Received: <xmr:8MWfZcd20DvDOwNrb0Ju3VHREuLiB_DMskzwWidQtw5BvhumzXgDWGqqfKIq90EkOHM26ujdWW5v7HZbjdBE3v11kOkeSR_4_vdRLS0dux5nDX0DMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epuefguedtueeiheetleevgedujeekjeehleejjefhhffghfevgfekueekjedtieejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:8MWfZeLI0BjWa-TpuegBu4BvPeAEk9kE4DLJbHVm5LApDpzjpMmIRA>
    <xmx:8MWfZZJY_I2voxnNd8zT7eLmTZnEOqVNF0e41tSTgSgHqqXNJ0xG4Q>
    <xmx:8MWfZXx-g-98MG0RINBbUYRMrmtXqS0IaZbfXjGEqPEQRsweToOXog>
    <xmx:8MWfZbwFtRvLjUgVsZtvGZQvaDV1h0h-C3NUfehmHBjs53z1ZGWlRQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 05:41:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7b10a458 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jan 2024 10:39:09 +0000 (UTC)
Date: Thu, 11 Jan 2024 11:41:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Stan Hu <stanhu@gmail.com>
Subject: [PATCH 0/2] completion: silence pseudo-ref existence check
Message-ID: <cover.1704969119.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rHMeJenf7ob3wZ9N"
Content-Disposition: inline


--rHMeJenf7ob3wZ9N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I recently noticed that the Bash completion script started to output
object IDs in repositories which use the "reftable" backend when
completing certain commands. This patch series fixes this issue.

Patrick

Patrick Steinhardt (2):
  t9902: verify that completion does not print anything
  completion: silence pseudoref existence check

 contrib/completion/git-completion.bash |  2 +-
 t/t9902-completion.sh                  | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

--=20
2.43.GIT


--rHMeJenf7ob3wZ9N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWfxewACgkQVbJhu7ck
PpRFwQ/+I2AynnPabOtM4cPjOgHaF9gjCd6HMq9HKATOedVLvcAKaYyzwKUUSSZO
dxEsBCI2B2Hb6CkZ3XH30WJLRzctkgCHG9v/g4RyQ+y3thX9Ha8SbJTHOWFuldT5
NzOKfH2E8keAkLbc38z7ZEr7f31mEXnV9cEyBBPIJOz+HnKSR8oW68zb8/7IpWQa
KK1kX/OruaMswCK+XZ4i7cBCragZmMxxGY7GzuCUL0fwk+KjW/zaUGMGQJrKqBR+
vLUiuj32b0sNJosDnhnyOTxFYtEjQ4F1aZNFJcRDzOnXJ+8r2gQ7HErNA+if1aOO
TwSuwi+vfJ6zNk6TZGvj2mkUpINp6D5eNWQRa5YSoeKJ6yJIg4VBGeh2QU48bmfK
82IYhwUQXFaNlYPdUTFfqSeYlocqW8uowig2vX5HgYzVubk+yhr48/HtHGzpwEtd
JiZSceNM78VxqSeb7A7aT03WwiRZ+hUgtW0Cu4i3Fdi2srclgyeWCRsfrVL8iCui
1d0AC+cl/wx9zKNjX4GtzO8bRdRLWjGDi1kfl6e6/tKjvKbr6XvVp/ZLWN4ucugx
N4TWqKKLCrgT6yceILc8GgCgQrwIawCtae2iYgMD4aWYKbhyfhsoNJDY2mxNkhuI
sX1E/lK7+P0BuH5fNDKHqnBrtfzy2CWHiic9RyW54iLz2Wn7qW4=
=Dxqs
-----END PGP SIGNATURE-----

--rHMeJenf7ob3wZ9N--
