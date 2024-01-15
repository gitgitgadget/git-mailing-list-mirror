Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56B92C68A
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ffB9dqFH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XYcbK04c"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id C5FD65C0152
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 06:44:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 15 Jan 2024 06:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1705319096; x=1705405496; bh=hNaUc8IqCt2XyzRkf61/nInJv9RHlHdj
	2fa161gB32o=; b=ffB9dqFH/iItxwRXgD8fyNyOj6U1X5cm5iNznDE7SHBTAII3
	apeQ4WEEfAmlMazYlaOue/L/r6/wIKhTc7JUULbpONl5/sfZXHZgAD6CcWo2ZoUW
	oItozmyqWblly694XSeLPUqFEZL/yr+3YyF5HFox1qbJtHWr9jf193J/8mDEHnFo
	5dDO3IEeOpNthsbYw+1BOyOeALhusbjVTFkvTvHbaZLNYIzr52UJvL8C5APTFUwT
	wRqaHwjeJd5xUwkwMPg1Dc2Q2W4d00CKQg/S2NtC/UDsqf3L0Xmfo3LS16Ze1mCi
	Qhw7IN1cws3Ue5lXv2GlsbdySDgpfEmvimDifg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1705319096; x=1705405496; bh=hNaUc8IqCt2XyzRkf61/nInJv9RHlHdj2fa
	161gB32o=; b=XYcbK04cqZql38iGKoPx/m0B82xA29cFLtzACCTonsJcymoKFtQ
	JFuXcw270rfDhq6ukcL52mlaiFh2Xey7gtUV8I3ZpsQYEKKb79gmA2627rARi+OL
	KsRPl8Nk5BXq7Io31uw0oMO7VbRvduNflbEf/MihjwwvU1bO0/9adifQbDPhKXfp
	qy1eEemtmscYbSkhHTqeCYQE5Wwe+mE34PuYzOuqgbZ8J3pqhadk+k2Cqw107MrH
	h/YLapArXy/dX2gC1sa5uACeqPaMwOsV2PTEtxkI3+JUIgCwuU8lzWz2PvJHzbj8
	++TqbSA0sR6FM0Zo85HFXyRVdPhyGFStq7Q==
X-ME-Sender: <xms:uBqlZRsly_AW9-3dNdZ6hYxGXc2SV0C28BF89lN5PNco7-SR6UfePg>
    <xme:uBqlZacqr_Cm0aJgUEMjZS56vpSJ2cU_Z1jPUsYoFkfvKIEQIwXEZXzb9BKjxJALe
    5mBJS-Q_JSMuw6o3g>
X-ME-Received: <xmr:uBqlZUyLO_ZloVMCi5MMGfSRFESU4b4-fmJeljeK5wqXrg0d1PsOsZ_W5JnqmAZ-UXzvmdx4nzmtwS6jGw8NNy8j08LrzD0_sHHSE5eTCUa9KA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:uBqlZYMDdO3vWqwV4PQYdsbVjqOFDEnJHoVGIdPSfJkmi5KYT19pyQ>
    <xmx:uBqlZR_1lGj_LNOvNaA33XvpFcPNzYN_aX79YPlRWECKwEyxpb38KA>
    <xmx:uBqlZYXUILfK6LyagUZ9sQfFtDTOuCTwQR2vGrysf-kP6ZFz9y9RHQ>
    <xmx:uBqlZWJr-SQH3Ru9ytpXZycJCmOQZgOdgpJ8TxwDkBVyEcm7T-Ya6g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Jan 2024 06:44:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 323e298a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Jan 2024 11:42:04 +0000 (UTC)
Date: Mon, 15 Jan 2024 12:44:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/3] ci: add support for macOS to GitLab CI
Message-ID: <cover.1705318985.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PdhtGmriwDzyPMaV"
Content-Disposition: inline


--PdhtGmriwDzyPMaV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series extends GitLab CI to also support macOS. Besides
extending test coverage for GitLab users, this change also has the added
benefit that the macOS runners at GitLab are based on Apple silicon,
which to the best of my knowledge is not something we're currently
testing on.

This patch series builds on top of ps/gitlab-ci-static-analysis
(currently at cd69c635a1 (ci: add job performing static analysis on
GitLab CI, 2023-12-28)) to avoid a conflict.

Patrick

Patrick Steinhardt (3):
  ci: make p4 setup on macOS more robust
  Makefile: detect new Homebrew location for ARM-based Macs
  ci: add macOS jobs to GitLab CI

 .gitlab-ci.yml             | 26 +++++++++++++++++++++++++-
 ci/install-dependencies.sh | 10 ++++------
 ci/lib.sh                  | 12 +++++++++++-
 config.mak.uname           | 13 +++++++++++++
 4 files changed, 53 insertions(+), 8 deletions(-)


base-commit: cd69c635a1a62b0c8bfdbf221778be8a512ad048
--=20
2.43.GIT


--PdhtGmriwDzyPMaV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWlGrQACgkQVbJhu7ck
PpQlbQ//emF3uB7WgQmREgcU+ajPU5X7tmhRIweAFjpqjRESxYlqQq382HDZIAkF
8GjRmZLNG7K09xaqugb+1PKBgN5h9SOz6HDKn6xOresacu2yDiUz+21qrZ49Udeo
g6nmMRzToomz9Otlw69gjnEnbRXZJWWlYEQ8lgpSFsf1pTG1PDAF9m90uBNLb6Kd
UoxYVd7ryFJalt09vrWtV2EX6zTcJZGvuSOySkeAEPjbns/wGuKrGaDYqXimh9xX
h9+2h9ES7XqM9TegvEPVfavWM5O5OClEYdjS5W3k6R4b5QJO9pPvyDzrX1jS6aJU
1lO9lHKlhxvb4nLvlYveG/5NiWJRTgyHoZ/tJHJFvpMfMDKmG63e0qE4QtCu4z/t
HSJVbdaZbRhOnA0a8cPFvpFotDnwqtYGVB/pb6nhi/A7vu6gy43MoEZBmKZyhYST
dFylCMlic7aWRxiabOkoNmMT1B2BqIsVEDFV1P1TF3e2wx9BQVmyAOGVT6+vkTde
6Nu4NZd//BBWK5bekEpNATW/q6Zo+VXL+jrOoE2sII0If0v/2WLo3C3DQJFvGaJ9
uKkfi+3+p7f/5Td0W3NkZQ1ne0BenoYISIUCy8nV+JE0wpcdes9S6hPhmotq9K0P
ktaJvuxDBrcLCvkQ2OwHSYml1TS0+OQtVeyWBFeXMCTUqhRcJjs=
=0ou0
-----END PGP SIGNATURE-----

--PdhtGmriwDzyPMaV--
