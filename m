Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE220B29
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VpwIcn6v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xwCjffn6"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id C08195C01B1
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 05:54:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 20 Dec 2023 05:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1703069694; x=1703156094; bh=EnX+VYV9bgl3A3dfkRT2f9Vq4v3RbefA
	Vi7JBghjuGM=; b=VpwIcn6v5goqHe4BI63TqBD8WnuGyvvNFJQzU6RRtbxZn4sg
	oLa5sQXz5iwSrWNzyVKKpGf7yyR48xoYqC8iqzbBhSFCWbk2Yo5CygiVDt/2RqKi
	62RHg3ozFxqNfcApQ0lCWkj2UyTcwad7LPEcZHWHgs/w0fxxW7RNknNlGloI1TZr
	ZOVkN2f07OvXQ2PhKqL7CSh13mU72ZW32iKqikXxnyZTSVkOCfjNbP/Iq00xlBsS
	2Yy0cAK/XnBaS0dxBhca9eXttf0mXephZUvFhIN80JoyCkEp3utCZoVk8y7NEJpl
	uyVci1znsz5CCZ+J2UXGqy/cvIvIV3msmsEL3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1703069694; x=1703156094; bh=EnX+VYV9bgl3A3dfkRT2f9Vq4v3RbefAVi7
	JBghjuGM=; b=xwCjffn64SAwA5HX1lJuptWUzi+LJFtjItS3OPJygTPxbnuKq4d
	1eWcWqXbU4mWM0lY/sdlx/FCtzEwfMnDQErzWoNo9iUaeANpQ2LVo8g2EFy8BkJm
	l0zuNeKvNvvZ6gSwBl1BxTBuCYBb+jupOeSBA8FCc2SUmfUP1gQ3N4YrId2UjJ9S
	bHNlBuvjW2DZiayUTfSbgXvP8ahA7y1OpBwc3dDZC+7NM66Zpu3lOHcGYHzy8QIL
	+tFtPswVhcmJLNnbzHUpCWAKQHmrtpTLlcne0ucL79fHmkTJ5cObfSwgV4rVX2A2
	ThZh4dtAAgrfSrDKWXTvr1u5bWJVhfblZ9g==
X-ME-Sender: <xms:_seCZR6v_W-ablTHrxdYPKnfvoKgswcH7vOfsYBh6pPV8HGzARlZpw>
    <xme:_seCZe6f9lXJoPI1pjDql8kwn9Ew5-NGqsittsYcY0xNerV-p25hW9rQtdoMQkwwe
    sp58NCaceLqydOj_g>
X-ME-Received: <xmr:_seCZYdEevgoxKuegNo_Qdfoiwry5J5mOJHI7LBydoSAu_sCzgSmdzbYSZRku3bdO2H3Ad7UULYtpODiY5PrUjR3QLm3GMhUu4m2b7TlgHqJgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_seCZaLj9ygyreoN7f_tjlYK7DyBN5WZ7Oweo4S0bN2olP7C-KDjZQ>
    <xmx:_seCZVI8q7m737jRnUrk6Z7xvhiIYnWtiq3-jeIfwv02T2I4Nmaa7A>
    <xmx:_seCZTz3mB6GSW10pXpdka2mib3LmsLW0Do-eyZZ4_ENXtjBlEe-0g>
    <xmx:_seCZYmiSaEl9bUzweS-ODDO2POyD2xoq_nqqGtAqjgcbCC1gk_s2Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 05:54:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 48e5cf3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 10:52:56 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:54:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/12] Introduce `refStorage` extension
Message-ID: <cover.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UmoOs7by5jytKn1z"
Content-Disposition: inline


--UmoOs7by5jytKn1z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series introduces a new `refStorage` extension and related
tooling. While there is only a single user-visible ref backend for now,
this extension will eventually allow us to determine which backend shall
be used for a repository. Furthermore, the series introduces tooling so
that the ref storage format becomes more accessible.

The series is structured as follows:

  - Patches 1 - 3: preliminary refactorings that prepare for the
    introduction of the ref storage format.

  - Patches 4 - 6: wire up the ref format when setting up the repository
    and creating a new one.

  - Patches 7 - 8: introduction of envvars to control the ref format
    globally.

  - Patches 9 - 11: amend our tooling to know how to access and set the
    ref storage format.

  - Patch 12: small patch for t9500 to make it handle ref storage
    extensions in the future.

I've been kind of torn regarding how to name this in the user-facing
parts. Even though the extension is called "refStorage", I rather opted
to use "ref format" in the user-facing parts, which is similar in nature
to the "object format". Changing the extension to be called "refFormat"
would cause issues for JGit though, so it's likely not an option to
change it now.

Anyway, I'd appreciate your thoughts and proposals and am happy to
rename the user-facing parts if we get to a preferable agreement.

This series depends on 18c9cb7524 (builtin/clone: create the refdb with
the correct object format, 2023-12-12) because it relies on the more
careful setup of the repository's refdb during clones.

Thanks!

Patrick

Patrick Steinhardt (12):
  t: introduce DEFAULT_REPO_FORMAT prereq
  worktree: skip reading HEAD when repairing worktrees
  refs: refactor logic to look up storage backends
  setup: start tracking ref storage format when
  setup: set repository's formats on init
  setup: introduce "extensions.refStorage" extension
  setup: introduce GIT_DEFAULT_REF_FORMAT envvar
  t: introduce GIT_TEST_DEFAULT_REF_FORMAT envvar
  builtin/rev-parse: introduce `--show-ref-format` flag
  builtin/init: introduce `--ref-format=3D` value flag
  builtin/clone: introduce `--ref-format=3D` value flag
  t9500: write "extensions.refstorage" into config

 Documentation/config/extensions.txt           | 11 +++
 Documentation/git-clone.txt                   |  6 ++
 Documentation/git-init.txt                    |  7 ++
 Documentation/git-rev-parse.txt               |  3 +
 Documentation/git.txt                         |  5 ++
 Documentation/ref-storage-format.txt          |  1 +
 .../technical/repository-version.txt          |  5 ++
 builtin/clone.c                               | 17 ++++-
 builtin/init-db.c                             | 15 +++-
 builtin/rev-parse.c                           |  4 ++
 refs.c                                        | 34 ++++++---
 refs.h                                        |  4 ++
 refs/debug.c                                  |  1 -
 refs/files-backend.c                          |  1 -
 refs/packed-backend.c                         |  1 -
 refs/refs-internal.h                          |  1 -
 repository.c                                  |  1 +
 repository.h                                  |  6 ++
 setup.c                                       | 63 +++++++++++++++--
 setup.h                                       |  9 ++-
 t/README                                      |  3 +
 t/t0001-init.sh                               | 70 +++++++++++++++++++
 t/t1500-rev-parse.sh                          | 17 +++++
 t/t3200-branch.sh                             |  2 +-
 t/t5601-clone.sh                              | 17 +++++
 t/t9500-gitweb-standalone-no-errors.sh        |  5 ++
 t/test-lib-functions.sh                       |  5 ++
 t/test-lib.sh                                 | 15 +++-
 worktree.c                                    | 24 ++++---
 29 files changed, 318 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/ref-storage-format.txt

--=20
2.43.GIT


--UmoOs7by5jytKn1z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCx/kACgkQVbJhu7ck
PpRVZRAAoZDKuSuEw7PErVIpU5A9H2BmMbm/4w03QRv2ZosMzEdCyf/r2/E4Y095
+KCheXFs0uVftGKNHYW17TrZIjYRROI/EKPUh48a2QT7BtxZlC7bDXdeuGtVWc73
apBIpjrhsGyWKyGe4Q6z9dxtDG6BF7534hkU86rup8waE6vocMzncVNmKi4r2Rcm
Ry7PUTabe2PvcWd82gxmXP2yRfSvseqKAy9ZeFpEvPRmZGKZitFsZXsx5JCh8zIU
GSHF5XZHTxlCFVut2ylr1qX2P+3w5PWrKgjzZfRF5o7xzwZbeXJsQ+ylMGz5XiB3
ZCTlZ2hjTgoNUlasjxSqTASVTlRgXqDJ9EhDcIXaKK+WZUB3wYbb1b4mwfCy9Iv1
o1rImPKqWpqmBlf7fjZUUHQxyEMr4DeCKTsei7yGZxEc4roCbZhSVGUGiLhei8KR
kmm+EMJEe/vhvKvwXnUbY3J9ShD950hy7P3VlV5dyVnAFa+aKdX1pe05TXrSyWKt
ENL0V87h77axZHNay7GA7EKBs/2Pj9e+cnvKbftcLh0bw88Go0VZu/BrmJ2oaDhD
FtTPGMkvQx6S3OT3ELBjynu3vSngDd0h5LY+hWQFojMmLOXD7MDS8lVaQbwC/ANW
sD9kw+1gjOYUVtGElR6DQo+uM3AKx6CLFdt1+dk6sXyBshbFMAA=
=btxs
-----END PGP SIGNATURE-----

--UmoOs7by5jytKn1z--
