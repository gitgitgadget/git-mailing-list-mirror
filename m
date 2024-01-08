Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF83134A9
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LHyJZgp+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nqKRkicP"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A96775C17B9;
	Mon,  8 Jan 2024 05:05:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 08 Jan 2024 05:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704708326; x=1704794726; bh=hb9G6pY8Pi
	po1RRqxqBA080tuleGoV2TMKPsQtd07TU=; b=LHyJZgp+icLbAB3HKHjBaHIUN1
	9hWlIAe8P3FE2otGm8c3wXrAudqK3sJqZxkssviCiZYAt0Wyob9kB1zk6wN7K2hW
	slEpWK6eDcBzsrDz8cqMNPieBFUMD1pYIPoYfMkil5YykoqA7w+mcmedOmd6oTSt
	HlWLJeDjTxlU8pp5OL5Jv8yd+DBtHJ5xfxQDeQ54nwaMH8QLk+WW48iyujVTFj7O
	cixxbfkrSTRRIb7ZrGQF/Yw19QG/e6whTXdhsn5TLVS3dCHer5cibe3Gm1USS96L
	K0Vbs2WV4X8gJn6RA33/p7eLVzXquLzAbbgyxhtdiJMKggYXeVsoA4UURrXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704708326; x=1704794726; bh=hb9G6pY8Pipo1RRqxqBA080tuleG
	oV2TMKPsQtd07TU=; b=nqKRkicPanLHzFNK5teosiXts+vw1TFI+jaF828oi+xk
	GzFamgNgNvya4v5Z2vLN+2sLwkCXfWIuyr5XNjAjycw0HlKAwc6GlrrXVkNAkfLw
	sxyuB6u8PeCiL5F9VIAX11EL30/bxZo5gsPZ4v023rzyWs7+UBQqCWzcNDFD2oUs
	+HIRXtQ+GIEhJlx6Nr360g/ByxQnCdRKnKmrVj6SKq9BxXPltoyYwtWDc2m0JDPk
	MJFZuk/KolRJaF1Olh89LbBhoz+YYNeZogS+pC+aB6XyLmoqk6UGbXZMwEAw1Bs9
	zDiIdk3qfkutTiWFQEGPDKRZsPhhbMtMY0ml/Z8Qeg==
X-ME-Sender: <xms:5sibZeTMiiJ6xQi3g82HU4wLZKeJrYalVESJzhW-PtpvI4tXjOmdlA>
    <xme:5sibZTwxVEsq-kP7_jn-njD1DK-enppHhyEJ0ISW1Chg_Y_uw8wVoTdsPon9Pd_nE
    KfsbERR7_OT8GDOLQ>
X-ME-Received: <xmr:5sibZb02xRkwQA-pnR2O_aLvfJ2QxaZ9DE9p0IrFAJ2RoVmekN3TE_giF4xUuQAEyxOzzaLIoDVrJEMgktrho8Gr1YsJ2GXH60fROrjSMgqsUN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:5sibZaCIRcmRtXZFcUUBp3aRZGTDDOdvjC-D73DOMxgDjJvAP5GRKQ>
    <xmx:5sibZXiwHhucuL40RATsnduXdZw5Vc17LW4aKSl4mD6JMKsLge-GUg>
    <xmx:5sibZWqPI16AQPT4RVMCSz92Mrcm1hkXd7UVW_LG2qjUnuIuoF71jA>
    <xmx:5sibZatUslStxx9BEce4rdnTMe1Az-nJXoUIX7tQkwg2yPr2yooL_Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 05:05:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 49e53807 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jan 2024 10:02:47 +0000 (UTC)
Date: Mon, 8 Jan 2024 11:05:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/6] worktree: initialize refdb via ref backends
Message-ID: <cover.1704705733.git.ps@pks.im>
References: <cover.1703754513.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BdainDzP7VJ5G+on"
Content-Disposition: inline
In-Reply-To: <cover.1703754513.git.ps@pks.im>


--BdainDzP7VJ5G+on
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that refactors the
initialization of worktree refdbs to use the refs API.

Changes compared to v1:

  - Improved commit messages.

  - This series is now based on `ps/refstorage-extension`, 1b2234079b
    (t9500: write "extensions.refstorage" into config, 2023-12-29).
    While there is no functional dependency between those series,
    merging both topics causes a merge conflict.

Patrick

Patrick Steinhardt (6):
  refs: prepare `refs_init_db()` for initializing worktree refs
  setup: move creation of "refs/" into the files backend
  refs/files: skip creation of "refs/{heads,tags}" for worktrees
  builtin/worktree: move setup of commondir file earlier
  worktree: expose interface to look up worktree by name
  builtin/worktree: create refdb via ref backend

 builtin/worktree.c    | 53 ++++++++++++++++++++-----------------------
 refs.c                |  6 ++---
 refs.h                |  4 +++-
 refs/debug.c          |  4 ++--
 refs/files-backend.c  | 37 +++++++++++++++++++++++++-----
 refs/packed-backend.c |  1 +
 refs/refs-internal.h  |  4 +++-
 setup.c               | 17 +-------------
 worktree.c            | 27 +++++++++++++---------
 worktree.h            | 12 ++++++++++
 10 files changed, 96 insertions(+), 69 deletions(-)

Range-diff against v1:
1:  6cb4e0a99f ! 1:  a4894b3e15 refs: prepare `refs_init_db()` for initiali=
zing worktree refs
    @@ refs/refs-internal.h: typedef struct ref_store *ref_store_init_fn(st=
ruct reposit
      				       struct ref_transaction *transaction,
    =20
      ## setup.c ##
    -@@ setup.c: void create_reference_database(const char *initial_branch,=
 int quiet)
    - 	safe_create_dir(git_path("refs"), 1);
    +@@ setup.c: void create_reference_database(unsigned int ref_storage_fo=
rmat,
      	adjust_shared_perm(git_path("refs"));
     =20
    + 	repo_set_ref_storage_format(the_repository, ref_storage_format);
     -	if (refs_init_db(&err))
     +	if (refs_init_db(get_main_ref_store(the_repository), 0, &err))
      		die("failed to set up refs db: %s", err.buf);
2:  ae013eaa4a ! 2:  f500db51c2 setup: move creation of "refs/" into the fi=
les backend
    @@ Commit message
         seems a lot more sensible to have it this way round than to require
         callers to create the directory themselves.
    =20
    +    An alternative to this would be to create "refs/" in `refs_init_db=
()`
    +    directly. This feels conceptually unclean though as the creation o=
f the
    +    refdb is now cluttered across different callsites. Furthermore, bo=
th the
    +    "files" and the upcoming "reftable" backend write backend-specific=
 data
    +    into the "refs/" directory anyway, so splitting up this logic woul=
d only
    +    make it harder to reason about.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## refs/files-backend.c ##
    @@ refs/files-backend.c: static int files_init_db(struct ref_store *ref=
_store,
     =20
    =20
      ## setup.c ##
    -@@ setup.c: void create_reference_database(const char *initial_branch,=
 int quiet)
    +@@ setup.c: void create_reference_database(unsigned int ref_storage_fo=
rmat,
      	struct strbuf err =3D STRBUF_INIT;
      	int reinit =3D is_reinit();
     =20
    @@ setup.c: void create_reference_database(const char *initial_branch, =
int quiet)
     -	safe_create_dir(git_path("refs"), 1);
     -	adjust_shared_perm(git_path("refs"));
     -
    + 	repo_set_ref_storage_format(the_repository, ref_storage_format);
      	if (refs_init_db(get_main_ref_store(the_repository), 0, &err))
      		die("failed to set up refs db: %s", err.buf);
    -=20
3:  3cf6ceb274 ! 3:  9e99efeaa3 refs/files: skip creation of "refs/{heads,t=
ags}" for worktrees
    @@ Commit message
    =20
         The files ref backend will create both "refs/heads" and "refs/tags=
" in
         the Git directory. While this logic makes sense for normal reposit=
ories,
    -    it does not fo worktrees because those refs are "common" refs that=
 would
    -    always be contained in the main repository's ref database.
    +    it does not for worktrees because those refs are "common" refs that
    +    would always be contained in the main repository's ref database.
    =20
         Introduce a new flag telling the backend that it is expected to cr=
eate a
         per-worktree ref database and skip creation of these dirs in the f=
iles
4:  1a6337fc51 =3D 4:  f2eb020288 builtin/worktree: move setup of commondir=
 file earlier
5:  f344a915e9 ! 5:  5525a9f9c2 worktree: expose interface to look up workt=
ree by name
    @@ worktree.c
      	free (worktrees);
      }
     =20
    -@@ worktree.c: static struct worktree *get_main_worktree(void)
    +@@ worktree.c: static struct worktree *get_main_worktree(int skip_read=
ing_head)
      	return worktree;
      }
     =20
    --static struct worktree *get_linked_worktree(const char *id)
    -+struct worktree *get_linked_worktree(const char *id)
    +-static struct worktree *get_linked_worktree(const char *id,
    +-					    int skip_reading_head)
    ++struct worktree *get_linked_worktree(const char *id,
    ++				     int skip_reading_head)
      {
      	struct worktree *worktree =3D NULL;
      	struct strbuf path =3D STRBUF_INIT;
    @@ worktree.h: struct worktree *find_worktree(struct worktree **list,
     + * Look up the worktree corresponding to `id`, or NULL of no such wor=
ktree
     + * exists.
     + */
    -+struct worktree *get_linked_worktree(const char *id);
    ++struct worktree *get_linked_worktree(const char *id,
    ++				     int skip_reading_head);
     +
      /*
       * Return the worktree corresponding to `path`, or NULL if no such wo=
rktree
6:  aae969301f ! 6:  240dc40de1 builtin/worktree: create refdb via ref back=
end
    @@ builtin/worktree.c: static int add_worktree(const char *path, const =
char *refnam
     -	strbuf_reset(&sb);
     -	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
     -	write_file(sb.buf, "%s", oid_to_hex(null_oid()));
    -+	wt =3D get_linked_worktree(name);
    ++	wt =3D get_linked_worktree(name, 1);
     +	if (!wt) {
     +		ret =3D error(_("could not find created worktree '%s'"), name);
     +		goto done;

base-commit: 1b2234079b24da99dd78e4ce4bfe338a2a841aed
--=20
2.43.GIT


--BdainDzP7VJ5G+on
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWbyN0ACgkQVbJhu7ck
PpTCag//eRRzfL7ghFA1rWSXdFhKlkX+IVZ+AcyVSXwgGFOLGacXUDQ+oW1hFyQy
1c5rqIZrWO0+FViv0mqxN8RKo+bn2RgAK7KojsOnsOFIcjKWO0sxNfoB7JfigcDe
ZMmQ7iKyl3Y42qndcTjebyKpP6GYeQRCU1CEiSdXk4s78JCHUf/AwXHXOX6O3lpk
1OrZlnsi4AkKj6SrQ4GlSrVGqb78ubJfGRiFy5a+bq7647Z6UalM9APMNaYLeq2G
o7EL60UpcyqsG1oBNhSd8Bk2yDJoKF4QcMycMXTaHBRQbLlCVz4GtfBYniVw3n8f
yuQCS8g45pUI+IuJ3nqQyUEVh+2oqNNJMG1sHASDZmRhTKPbvIrBuqhHZ+TFraz5
cKSE7io7390Px6zGPshuGNKx71AZ6SYEsj6UadCeruwR0AoidbHeSxvetqHka7mg
o0Gy3jbdX6fNSHFeSpu5MLaX3T8iJJZRPHsXNpp/qs8QmJjZR8xQKygtz/rQOGcm
q92N5FZJeZ2TgV01YGhV0iGoqLT9lz3xawv0Iq/k8nSpeyXgRSQ6CHFjQv6hbJg7
blxq4GKxQqCHbYBj5EwhuGEQ/0jaJnTTjjVsfseeVV2s2Z52cdxI5brHS7Tv5RE8
t9JVmSUVRlwtA7x7PoHiIQam2W2R/Of282cpUiOHqUiMAJlBGWM=
=dcst
-----END PGP SIGNATURE-----

--BdainDzP7VJ5G+on--
