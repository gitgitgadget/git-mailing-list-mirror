Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE68E76033
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237110; cv=none; b=Mp4jr2Qi9+sW7dENYnylE2EsAUZwxpwAiNOAwqInEECj2AhXG5NvKOYat7aA2D+N6xkPP+53K9qebvAf3f/V4smpzZczD3/Rs58UEjuFhyRSLwmU9pe9jp9q2AuVMYXmPKYwtIVNgXZvQSeDdYy9aLuyFjfoK48k0cnSRK3t7MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237110; c=relaxed/simple;
	bh=8+MUym6qWX4Uq+vkRHBrAwa0VFZXtzqPS+aozXxFN54=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NxxAZsP0L85JAVERJ9V69CnykqsBMF/q8R8t/4cqBU6AI9RC+ap68PWlI3sJujJddU4w8EJZePyqSnYPjpQ4xE6b79CaGDjEfeqg9wM8Ma3SR1TaTt1fgqBc29utTGdUlr3o5/5QQkkSSQeiQ93LWCZsdnJvCspybPM98dm7Zjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XLY0wOHU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vl1LnrKx; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XLY0wOHU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vl1LnrKx"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7BC5B1380161;
	Thu,  4 Apr 2024 09:25:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Apr 2024 09:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1712237106; x=1712323506; bh=PHgGSEoHgYgN5T8mapMT26LtuoBM1r+Q
	uXRckq9K05Q=; b=XLY0wOHU0cqxQe0dRTnP8XzhxFFhCehTwTAUM4TEVo0UZTjg
	h/62Rf3zkDEuKhc+/WFmAkG2RzqwOB90uG52g8EEBK9/ld5yeGFLHMlZekbwuk4x
	vA1ZsLhcy+LFAZK6mtClFdFVAL0yJxG6rmFjbBmiK+Ym6ZcvSc54YmMIgiL+00Cq
	UKzkuWx6NGygCxfbL+oE4LJitOR1R5dVpHBsXOj48TSqXk6IVoGkxBChYXVee92I
	7CCxuorSOiGB/6xBcgG8FCB7mLypknnR/ASew45kII2qoy8tKPneHaA3g2CgCojB
	UgTpUyVI4iN/A8P8GYL4enn2QiK5Do2zZ56qHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1712237106; x=1712323506; bh=PHgGSEoHgYgN5T8mapMT26LtuoBM1r+QuXR
	ckq9K05Q=; b=Vl1LnrKxm+CDlGIvdfnMpXYJpckTDFuIz1x4qvjVqAsXshh/mub
	ZyflDbiXb02RH3FuYFkzxcmaEXxIPEt5U7bAc2ON0pvADl5Igta3dQhmatwrVWfb
	yoMyjj5BkhuxUYa7epbozEt8jFmD1q56yKs6dj3D9upN1ka7WbXgN73GO1BFqUjx
	Cvx6KXG7Ey9EXhtqXsWnwQk0A0NIZ/+1zeg/o2OJRFQ/+C7wORBQcHl6WNWO3her
	R2njtNxWXGdDtOno+HmWJT6gtovGpe3gBv4RAc0SKed2DJBB92B9V0/THs6Cn4/D
	KAba4+n7nPyettz2vwNyNn1izSfUQJpkJPA==
X-ME-Sender: <xms:MqoOZkoC1oxnh0pjjM0T4YNO8G_Wu7DEptAcGtzTtjUz40vzCCi4FA>
    <xme:MqoOZqqRW83n73A6pfHHUiESMO-HM8r9RDXBFcif19Y08i0h9DN-Cd_S7A3Fw7BhL
    GfR_7JZ2MchsTCenQ>
X-ME-Received: <xmr:MqoOZpMZ9GDLwKWhxpv9pcfh1EuZM3wpzJR3X6KidXsA2uzqu3U61kRxuYcWaggk9u0QlmB6QI4tMMHGoqx9zU7OMUsfBuGcslwpSvduP2lCBEmo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epgfetveevkedvvdejhfeigffhgeejkedthedvffduieeigfeufefhjeevheeltefhnecu
    ffhomhgrihhnpehgihhtlhgrsgdrtghomhdpghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:MqoOZr5hUOlr_8rvOKlFGMAesMNxn-n4GoTh2c0AozeGh9uesv3AyQ>
    <xmx:MqoOZj4Wdqon-WOET5YlL6byddwkBEqESjQub0JAACjU6e7FoNSVUA>
    <xmx:MqoOZrjIUXJ1ZKj0q71-eRzzw7HuEWAIC5Vixa2pjW_JURuJuh_P0A>
    <xmx:MqoOZt5XZTP1PdkmGvOSNzvqCViAX9rALrZa8MmnUDDrsefMuMRFxA>
    <xmx:MqoOZguOUOP6Ca8xcwkZr1wAdnFY5uvCxdKeNJsVuUtdONv6imSCf453>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 09:25:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 42f7fe64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 13:24:59 +0000 (UTC)
Date: Thu, 4 Apr 2024 15:25:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: [PATCH 00/12] t: exercise Git/JGit reftable compatibility
Message-ID: <cover.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="778Vgm0aFwgJfC/V"
Content-Disposition: inline


--778Vgm0aFwgJfC/V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

while the reftable backend is a recent addition to Git, it has been part
of JGit since 2017 already. Given that there are essentially two
different implementations of the reftable format now there is a very
real risk of these two diverge and become incompatible with each other,
which would be a shame.

This patch series addresses this risk by introducing compatibility tests
which assert that both Git and JGit can access reftables written by the
respective other implementation.

The patch series is structured as follows:

  - Patches 1-8 merge "install-docker-dependencies.sh" into
    "install-dependencies.sh". This is done so that both CI job flavors
    have the same dependencies and thus the same test coverage available
    without always having to maintain them both.

  - Patch 9 makes JGit available.

  - Patch 10 starts running backend-specific tests in all jobs, and
    patch 11 addresses a portability issue surfaced by this.

  - Patch 12 adds a very basic compatibility test suite for Git/JGit
    reftables. I mostly consider this as a proof of concept, it should
    likely be extended over time.

These compatibility tests surface three findings:

  - JGit does not support reftables format v2, which was added to
    support the SHA256 object format.

  - JGit cannot read reflogs written by itself when starting from an
    unborn branch. This smells like a bug in JGit to me where it
    misinterprets reflog entries with a zero object ID as new OID, but I
    didn't dig any deeper yet.

  - JGit is incompatible with split indices because it cannot handle
    'link' DIRC entries. This is unrelated to reftables though.

I have tested the CI changes against both GitLab [1] and GitHub [2]. The
macOS test failures on GitHub are caused by the recent curl regression.

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/123
[2]: https://github.com/git/git/pull/1696

Patrick

Patrick Steinhardt (12):
  ci: rename "runs_on_pool" to "distro"
  ci: expose distro name in dockerized GitHub jobs
  ci: allow skipping sudo on dockerized jobs
  ci: drop duplicate package installation for "linux-gcc-default"
  ci: convert "install-dependencies.sh" to use "/bin/sh"
  ci: merge custom PATH directories
  ci: merge scripts which install dependencies
  ci: make Perforce binaries executable for all users
  ci: install JGit dependency
  t06xx: always execute backend-specific tests
  t0610: fix non-portable variable assignment
  t0612: add tests to exercise Git/JGit reftable compatibility

 .github/workflows/main.yml             |   8 +-
 .gitlab-ci.yml                         |   4 +-
 ci/install-dependencies.sh             | 100 ++++++++++++++-------
 ci/install-docker-dependencies.sh      |  46 ----------
 ci/lib.sh                              |  14 ++-
 t/t0600-reffiles-backend.sh            |   8 +-
 t/t0601-reffiles-pack-refs.sh          |   9 +-
 t/t0610-reftable-basics.sh             |  12 ++-
 t/t0612-reftable-jgit-compatibility.sh | 115 +++++++++++++++++++++++++
 9 files changed, 208 insertions(+), 108 deletions(-)
 delete mode 100755 ci/install-docker-dependencies.sh
 create mode 100755 t/t0612-reftable-jgit-compatibility.sh


base-commit: 7774cfed6261ce2900c84e55906da708c711d601
--=20
2.44.GIT


--778Vgm0aFwgJfC/V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOqisACgkQVbJhu7ck
PpQJdQ/9FHSkx0mSkM4uAxA43KhDh9fQZToGzHphdl7dHRvVupfuLOyd/foUG7aM
JMp7YRzbIOOG36/OzRo99YMZQBIIg4OI0Ug60lurYOZjX24GscgyXAOdqtpGHS/8
iWVnprbFJ8IJxvE561qyzKjKk38KDTHRnv8BlNNKDAjBIK2W5oxPKQmVncv2HEKX
DFrFn8KRtP0iwzIerBThMUbFBvKTDm0P74tYoyDsQlKL0IQ7kMjzkt58wpNdbc17
dCZE+YfyVVnd1X1ZagPwqB5HVniXdajK+zTSLeh2qdA/Z6MRycyM7OwPjzpR9xtO
HbA9BOI/zsB8CGWKfGUUF2iUmqLDWv40FE7QZnM6CfasJIuI1AYZu/9UHfjmdfRH
sPhOqLXENv/mN3CXkQTBGqCN0zy+IAQE+vFLqDKpLLL/P5UudR2VljclhOtHyuTK
xSeJxBzwfOLyjcSYARG7melZpH1fCKzFoGsVcB1HRGQwuV25cQh3zMAAcb4ttXEp
qQUoaRn84+aVo3UgPadjt0jjdQdh8qTBjoeUKFASizN7qf5yPcFX+5gxXGzrZuFc
atp2ameh2FGnGMuMjhn/OebdT94EdzoDkK3oUGO3lf1YpVrmI8FyWa2Jn3zZ1UcG
FqzmHA1Qn5sAQAmhJDh782A24sDgFTlEXTNYGTWE0DCz6W8huJI=
=Quwr
-----END PGP SIGNATURE-----

--778Vgm0aFwgJfC/V--
