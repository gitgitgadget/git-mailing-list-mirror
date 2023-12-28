Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDBF63B1
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lTiQVCag";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mER9cv0u"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 95B635C0080;
	Thu, 28 Dec 2023 04:57:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 28 Dec 2023 04:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757447; x=1703843847; bh=B19MDGHCdz
	3g7oTy/4t5EtLlPwU9hnEETti4CfOhdyg=; b=lTiQVCagKX4cujgBrX+JKdKV7L
	OTKfD3YVVfHHVrcbB3iXsH0fj1ovcyXvqFUJ6iR1sSK5gj0aBADeRYXMsxsmsQrd
	iBmB0JgtjSVnR5iegx4Shd/eQN9DKuQNSx6PXn+BGVe8XPQgMik1kA421JFPj4h4
	pdIWLjdQYr3DP84nY8uQqmj2uHEZ6yeag0jui4NeLJj7FedOMAbxPD5leM+UqXO1
	tsTGRkb+KWg+zZJLJGuwYpGiPbFit02xIltelFENmiHtKDkdsuFtNlZQu6+CCGBw
	0qaLlPAQ9E/a5CsZR1ASpQ5MBieo5EIUHHnhgAl20neeUByV8lSWMoPB6Wiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757447; x=1703843847; bh=B19MDGHCdz3g7oTy/4t5EtLlPwU9
	hnEETti4CfOhdyg=; b=mER9cv0ux7cYz7D3h5aQHI2cypJoFCwnR7RSA5xCT/7m
	6xM5C2ua72O5cemB40TdVEQUwkuZSQ9fHoPBzri11C02hXqEVYTklJrBYmEgTE3H
	rmsGx8uhLZQ9XNl5X96V2AieXJYdouFnoz0fo2M1k780OV5Dg/wRAMEq7N1+NyOC
	a2z7JZN0MG5A6cpmXm13TwMtn5SzCzofQ+9u//3rYDRij+s/0QquLOd79lb4o/EH
	elevUWdiSsBzqrXKCUwnD6XdK1s/ltaokL2T5dHkckzsTPfx6UdwdXMQBipNCv9V
	EqA1D32BvIJl5DQEHIYz95hSGf4EDSulwCfGHve+Gg==
X-ME-Sender: <xms:h0aNZewOH-bTMYpG0_nGoD6msOAz2QQYgLH3C7Hc0HVG4s8uayeX1w>
    <xme:h0aNZaR-J5Qt-zomRFOyKJdZNztYoxiTASLp6Nyom2sS-gg9N05awexbeGYGu2O4I
    V8O64SDDZzXMuioPQ>
X-ME-Received: <xmr:h0aNZQWcKH9G_rq47mNQ0QaMpT5CtdNl9YWuBNV8jIkZZe4wokTMf3lKVxV0mfNXiH3F8J-7xJy9GmGm1hENyuMfMG2ytcccO_1ezVrcZ3CwrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:h0aNZUhY9g-ir82biuexk3bNRmj00AUXokJmJDOYCTiREQuzPUNi0g>
    <xmx:h0aNZQAL2C3NANCUwkCmmDpV943xQp7JTPVThas5qZWtALtvKJEVOQ>
    <xmx:h0aNZVJLxUMmCW9HkduLzq6Y7OPx4g9Hb14ToiM6gt3QVy93QhZCmw>
    <xmx:h0aNZZ4kVaUat03abJdPEz7UpP39wCrA0gPz-UBNeQ4rZu7eQm4Zdw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 04:57:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e6df7380 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 09:55:10 +0000 (UTC)
Date: Thu, 28 Dec 2023 10:57:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/12] Introduce `refStorage` extension
Message-ID: <cover.1703753910.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MiIXx3HeZOO/0Ign"
Content-Disposition: inline
In-Reply-To: <cover.1703067989.git.ps@pks.im>


--MiIXx3HeZOO/0Ign
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that introduces the new
`refStorage` extension. This extension will be used for the upcoming
reftable backend.

Changes compared to v2:

  - Fixed various typos in commit messages.

  - Fixed redundant information when the refstorage extension's value
    isn't understood.

  - Introduced `repo_set_ref_storage_format()`.

Thanks for the feedback so far!

Patrick

Patrick Steinhardt (12):
  t: introduce DEFAULT_REPO_FORMAT prereq
  worktree: skip reading HEAD when repairing worktrees
  refs: refactor logic to look up storage backends
  setup: start tracking ref storage format
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
 refs.h                                        |  3 +
 refs/debug.c                                  |  1 -
 refs/files-backend.c                          |  1 -
 refs/packed-backend.c                         |  1 -
 refs/refs-internal.h                          |  1 -
 repository.c                                  |  6 ++
 repository.h                                  |  7 ++
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
 29 files changed, 323 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/ref-storage-format.txt

Range-diff against v1:
 1:  239ca38efd !  1:  3613439cb7 t: introduce DEFAULT_REPO_FORMAT prereq
    @@ Commit message
         repository format or otherwise they would fail to run, e.g. becaus=
e they
         fail to detect the correct hash function. While the hash function =
is the
         only extension right now that creates problems like this, we are a=
bout
    -    to add a second extensions for the ref format.
    +    to add a second extension for the ref format.
    =20
         Introduce a new DEFAULT_REPO_FORMAT prereq that can easily be amen=
ded
         whenever we add new format extensions. Next to making any such cha=
nges
 2:  e895091025 !  2:  ecf4f1ddee worktree: skip reading HEAD when repairin=
g worktrees
    @@ Commit message
         worktree: skip reading HEAD when repairing worktrees
    =20
         When calling `git init --separate-git-dir=3D<new-path>` on a preex=
isting
    -    repository, then we move the Git directory of that repository to t=
he new
    -    path specified by the user. If there are worktrees present in the =
Git
    -    repository, we need to repair the worktrees so that their gitlinks=
 point
    -    to the new location of the repository.
    +    repository, we move the Git directory of that repository to the ne=
w path
    +    specified by the user. If there are worktrees present in the repos=
itory,
    +    we need to repair the worktrees so that their gitlinks point to th=
e new
    +    location of the repository.
    =20
         This repair logic will load repositories via `get_worktrees()`, wh=
ich
         will enumerate up and initialize all worktrees. Part of initializa=
tion
    @@ Commit message
         format, which does not work.
    =20
         We do not require the worktree HEADs at all to repair worktrees. So
    -    let's fix issue this by skipping over the step that reads them.
    +    let's fix this issue by skipping over the step that reads them.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
 3:  f712d5ef5b !  3:  12329b99b7 refs: refactor logic to look up storage b=
ackends
    @@ refs.c
     -	for (be =3D refs_backends; be; be =3D be->next)
     -		if (!strcmp(be->name, name))
     -			return be;
    -+	if (ref_storage_format && ref_storage_format < ARRAY_SIZE(refs_backe=
nds))
    ++	if (ref_storage_format < ARRAY_SIZE(refs_backends))
     +		return refs_backends[ref_storage_format];
      	return NULL;
      }
    @@ refs.c: static struct ref_store *ref_store_init(struct repository *r=
epo,
     =20
      	if (!be)
     -		BUG("reference backend %s is unknown", be_name);
    -+		BUG("reference backend %s is unknown", ref_storage_format_to_name(f=
ormat));
    ++		BUG("reference backend is unknown");
     =20
      	refs =3D be->init(repo, gitdir, flags);
      	return refs;
 4:  6564659d40 !  4:  ddd099fbaf setup: start tracking ref storage format =
when
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    setup: start tracking ref storage format when
    +    setup: start tracking ref storage format
    =20
         In order to discern which ref storage format a repository is suppo=
sed to
         use we need to start setting up and/or discovering the format. This
    @@ Commit message
           - The first path is when we create a repository via `init_db()`.=
 When
             we are re-initializing a preexisting repository we need to ret=
ain
             the previously used ref storage format -- if the user asked fo=
r a
    -        different format then this indicates an erorr and we error out.
    +        different format then this indicates an error and we error out.
             Otherwise we either initialize the repository with the format =
asked
             for by the user or the default format, which currently is the
             "files" backend.
    @@ refs.c: static struct ref_store *ref_store_init(struct repository *r=
epo,
     =20
     +	be =3D find_ref_storage_backend(repo->ref_storage_format);
      	if (!be)
    --		BUG("reference backend %s is unknown", ref_storage_format_to_name(f=
ormat));
    -+		BUG("reference backend is unknown");
    -=20
    - 	refs =3D be->init(repo, gitdir, flags);
    - 	return refs;
    -
    - ## refs.h ##
    -@@ refs.h: struct string_list;
    - struct string_list_item;
    - struct worktree;
    -=20
    -+int default_ref_storage_format(void);
    - int ref_storage_format_by_name(const char *name);
    - const char *ref_storage_format_to_name(int ref_storage_format);
    + 		BUG("reference backend is unknown");
     =20
    =20
      ## repository.c ##
    +@@ repository.c: void repo_set_hash_algo(struct repository *repo, int =
hash_algo)
    + 	repo->hash_algo =3D &hash_algos[hash_algo];
    + }
    +=20
    ++void repo_set_ref_storage_format(struct repository *repo, int format)
    ++{
    ++	repo->ref_storage_format =3D format;
    ++}
    ++
    + /*
    +  * Attempt to resolve and set the provided 'gitdir' for repository 'r=
epo'.
    +  * Return 0 upon success and a non-zero value upon failure.
     @@ repository.c: int repo_init(struct repository *repo,
      		goto error;
     =20
      	repo_set_hash_algo(repo, format.hash_algo);
    -+	repo->ref_storage_format =3D format.ref_storage_format;
    ++	repo_set_ref_storage_format(repo, format.ref_storage_format);
      	repo->repository_format_worktree_config =3D format.worktree_config;
     =20
      	/* take ownership of format.partial_clone */
    @@ repository.h: struct repository {
      	/* A unique-id for tracing purposes. */
      	int trace2_repo_id;
     =20
    +@@ repository.h: void repo_set_gitdir(struct repository *repo, const c=
har *root,
    + 		     const struct set_gitdir_args *extra_args);
    + void repo_set_worktree(struct repository *repo, const char *path);
    + void repo_set_hash_algo(struct repository *repo, int algo);
    ++void repo_set_ref_storage_format(struct repository *repo, int format);
    + void initialize_the_repository(void);
    + RESULT_MUST_BE_USED
    + int repo_init(struct repository *r, const char *gitdir, const char *w=
orktree);
    =20
      ## setup.c ##
     @@ setup.c: const char *setup_git_directory_gently(int *nongit_ok)
      		}
      		if (startup_info->have_repository) {
      			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
    -+			the_repository->ref_storage_format =3D
    -+				repo_fmt.ref_storage_format;
    ++			repo_set_ref_storage_format(the_repository,
    ++						    repo_fmt.ref_storage_format);
      			the_repository->repository_format_worktree_config =3D
      				repo_fmt.worktree_config;
      			/* take ownership of repo_fmt.partial_clone */
    @@ setup.c: void check_repository_format(struct repository_format *fmt)
      	check_repository_format_gently(get_git_dir(), fmt, NULL);
      	startup_info->have_repository =3D 1;
      	repo_set_hash_algo(the_repository, fmt->hash_algo);
    -+	the_repository->ref_storage_format =3D
    -+		fmt->ref_storage_format;
    ++	repo_set_ref_storage_format(the_repository,
    ++				    fmt->ref_storage_format);
      	the_repository->repository_format_worktree_config =3D
      		fmt->worktree_config;
      	the_repository->repository_format_partial_clone =3D
    @@ setup.c: void create_reference_database(const char *initial_branch, =
int quiet)
      	safe_create_dir(git_path("refs"), 1);
      	adjust_shared_perm(git_path("refs"));
     =20
    -+	the_repository->ref_storage_format =3D ref_storage_format;
    ++	repo_set_ref_storage_format(the_repository, ref_storage_format);
      	if (refs_init_db(&err))
      		die("failed to set up refs db: %s", err.buf);
     =20
 5:  f90a63d63c !  5:  01a1e58a97 setup: set repository's formats on init
    @@ setup.c: int init_db(const char *git_dir, const char *real_git_dir,
     +	 * Now that we have set up both the hash algorithm and the ref stora=
ge
     +	 * format we can update the repository's settings accordingly.
     +	 */
    -+	the_repository->hash_algo =3D &hash_algos[repo_fmt.hash_algo];
    -+	the_repository->ref_storage_format =3D repo_fmt.ref_storage_format;
    ++	repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
    ++	repo_set_ref_storage_format(the_repository, repo_fmt.ref_storage_for=
mat);
     +
      	if (!(flags & INIT_DB_SKIP_REFDB))
      		create_reference_database(repo_fmt.ref_storage_format,
 6:  beeb182f28 =3D  6:  0a586fa648 setup: introduce "extensions.refStorage=
" extension
 7:  dd91a75da4 =3D  7:  6d8754f73a setup: introduce GIT_DEFAULT_REF_FORMAT=
 envvar
 8:  ed3bf008cd =3D  8:  c645932f3d t: introduce GIT_TEST_DEFAULT_REF_FORMA=
T envvar
 9:  8a3d950d69 =3D  9:  761d647770 builtin/rev-parse: introduce `--show-re=
f-format` flag
10:  4d98b53553 =3D 10:  e382b5bf08 builtin/init: introduce `--ref-format=
=3D` value flag
11:  71cf0ce827 =3D 11:  257233658d builtin/clone: introduce `--ref-format=
=3D` value flag
12:  bbe2fbb154 ! 12:  b8cd06ec53 t9500: write "extensions.refstorage" into=
 config
    @@ Commit message
         t9500: write "extensions.refstorage" into config
    =20
         In t9500 we're writing a custom configuration that sets up gitweb.=
 This
    -    requires us manually ensure that the repository format is configur=
ed as
    -    required, including both the repository format version and extensi=
ons.
    -    With the introduction of the "extensions.refStorage" extension we =
need
    -    to update the test to also write this new one.
    +    requires us to manually ensure that the repository format is confi=
gured
    +    as required, including both the repository format version and
    +    extensions. With the introduction of the "extensions.refStorage"
    +    extension we need to update the test to also write this new one.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20

base-commit: e79552d19784ee7f4bbce278fe25f93fbda196fa
--=20
2.43.GIT


--MiIXx3HeZOO/0Ign
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRoIACgkQVbJhu7ck
PpStTw//Rv19yGaUrCkpUFGIIgy+9nT5IX2NppUaha/Ek48TTIAEslvbbRTWHbxg
ePAT7PPsc0yx9roShdbANCxUBcKQWKXm8JNeF8h6rRN28teOr2FCiE/FpxezllTK
9QODBtJR/3oHWTIqh5X0y4ACI9Uqpf7vBInMgkoA+ilbdBqMzmYk2PFsb8GI+AO4
83aO8TwZ55e/vn1n3AtJJsOJFu4L6BXQjkoetfvJEpuDGuVBlO7qAR1WHwJYE+5U
fqnLHPWDt4Hj43xm0WTI3JltP6U08te/Uzahu6FMp7XS5mpfQiAMbnkKhiZnc/iv
6prYULgF823JMxwsFEX+k63+sZdi8Py2QWRU078X4P6THePGGQilssRu3rItBYue
7VfFV6Mj3gvPYRl8isna7QJHGCszjkqKRU8eqmznNcZGhHFo94bQ6/xBwBEVWOOl
Wu/5vBnxCNEcrL1Hg5T3aHMYV+nkTcssft57/rJStUfeT42mfuvgZXSDDgBa7+EF
aXoSYzAhtPpvDdbjDm1Kds+mspuntggA9Lr6aeBW9qlGDNqiMZrwzqQg+g/oEFb7
jWOLaTQSoChq90pEUJBX+dnnf3bL8quDUnmMdifaFJ4k4vLcr12rhmxdz8UrdfSj
p99cqQBSgh6bmFTMipuecg1rZC+bWNIOqv6L44FQGU85Kax6O1o=
=6zpN
-----END PGP SIGNATURE-----

--MiIXx3HeZOO/0Ign--
