Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5BD23B8
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="acdFkoyD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mfU7JpZB"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 473825C0179;
	Fri, 29 Dec 2023 02:26:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 29 Dec 2023 02:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703834787; x=1703921187; bh=wIiW3U08/u
	o+aTaR4iDBqg59cg44Yw36SOTV8Kr8igQ=; b=acdFkoyDtnzAu6QUB/SO8tfV+H
	VdrXal9XFgcAlxqx4jvgWlGGzKI8eDFjnScBhPngEvNnHLdF/iy5RhGz+L1NNpoI
	tFVQ5CDexO/XWjxIZPZSZH4XOZqNnOBi/9HB1QghLvYtKcdnl9w6SjIcvsIKRQuL
	zGfa3Gs4k7jUKAQkNtoiNh15BLCcSHtLKt60mJh7DGux8kUS4eeEA1NY0Prgpel4
	kExf1FiwlHwlzhsqu6kEXQQVoSYhmMyXNJrEoC8CbyY/BvrBTPZICrL7TwzZCBrr
	A8MdUwL3hLAkcbCIjqYKnmwTotUMGw9dHoYo2NMDNDx0CRgh2tHR+bsmDqfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703834787; x=1703921187; bh=wIiW3U08/uo+aTaR4iDBqg59cg44
	Yw36SOTV8Kr8igQ=; b=mfU7JpZBNHWokGKIbS/ENaqToxr47yEWL6lRTZMfg9xk
	9yjQF3WroWEni1+GGvC5EMy8nsYXOOHcLakwYHPONy/JUtyw0/0JUgpuwAqoIBN/
	U8yj3nk5ovURrPUddX6bQLzSTPXOILg8Y59voKmeQ+pofqU1Z4Zxofs2wEV6yipl
	RPU/umu3RV/Jgvof5XhAguGNWH8IZe+ydiN0NLtSA8FFTZvgbbRXJGJZp2oa1Iy2
	zokFIip5kZqLIi9Ar69/1IPl/oBD/fRaRzMy1Iq44ycna2/iraWy5eMeTsdZIPnZ
	innMxnHAudHVpedeSPct9C0KuYCV+bUxliw+ctdkgg==
X-ME-Sender: <xms:onSOZXIaq7sXg9zbtmJAFEJwhWgo4GpF30xCdoowdCRW7vUYsDiElQ>
    <xme:onSOZbLKqib4mJhH-yHChgWUMmYdm_Ulfl6TcQKDJERy6NHWyOHg_0I-gF3MFNO_I
    oo7T_lD-6Dapnp9WA>
X-ME-Received: <xmr:onSOZfuRTBjHwLmXktxMGh2XgIrw80XapHTzrGtai_1xHPEUBb7LpG4Pod0ZSVihxuswOwKmP9csf0CrSSRKQ0KBatXL15gd8oRALgySPBBuLPeTcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:onSOZQYWCabNZ7CZTyFQ7R7oGBGZP0OltQlJdGwNw7GzD4ymaM4L8A>
    <xmx:onSOZeaIc5kND-lyX-_9r3KMLYr8_bpKVSpQ4iV7OUPzpdVyVfmOIQ>
    <xmx:onSOZUCKHkxLdngwZLmJUfEdnjP91Z-R_cmKBWBS-k02S1cCOV9Cew>
    <xmx:o3SOZdmM9OlWo_nFukK8tLpEUhW-02gj-37X1PyNGA3RIS10DYQetA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Dec 2023 02:26:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8acd201c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 29 Dec 2023 07:24:08 +0000 (UTC)
Date: Fri, 29 Dec 2023 08:26:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 00/12] Introduce `refStorage` extension
Message-ID: <cover.1703833818.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yq2X4lelZ9qehQ7p"
Content-Disposition: inline
In-Reply-To: <cover.1703067989.git.ps@pks.im>


--Yq2X4lelZ9qehQ7p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that introduces the new
`refStorage` extension. This extension will be used for the upcoming
reftable backend.

Changes compared to v3:

  - The `ref_storage_format` is now tracked as an `unsigned int`,
    proposed by Junio.

  - Reworded the commit message in patch 2, proposed by Eric.

  - Added a NEEDSWORK comment to `get_worktrees_internal()`, propose by
    Eric.

Thanks for your reviews!

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
 setup.c                                       | 66 +++++++++++++++--
 setup.h                                       | 10 ++-
 t/README                                      |  3 +
 t/t0001-init.sh                               | 70 +++++++++++++++++++
 t/t1500-rev-parse.sh                          | 17 +++++
 t/t3200-branch.sh                             |  2 +-
 t/t5601-clone.sh                              | 17 +++++
 t/t9500-gitweb-standalone-no-errors.sh        |  5 ++
 t/test-lib-functions.sh                       |  5 ++
 t/test-lib.sh                                 | 15 +++-
 worktree.c                                    | 31 +++++---
 29 files changed, 334 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/ref-storage-format.txt

Range-diff against v2:
 1:  3613439cb7 =3D  1:  578deaabcf t: introduce DEFAULT_REPO_FORMAT prereq
 2:  ecf4f1ddee !  2:  77c7213c66 worktree: skip reading HEAD when repairin=
g worktrees
    @@ Commit message
         is logic that we resolve their respective worktree HEADs, even tho=
ugh
         that information may not actually be needed in the end by all call=
ers.
    =20
    -    In the context of git-init(1) this is about to become a problem, b=
ecause
    -    we do not have a repository that was set up via `setup_git_directo=
ry()`
    -    or friends. Consequentially, it is not yet fully initialized at th=
e time
    -    of calling `repair_worktrees()`, and properly setting up all parts=
 of
    -    the repository in `init_db()` before we repair worktrees is not an=
 easy
    -    thing to do. While this is okay right now where we only have a sin=
gle
    -    reference backend in Git, once we gain a second one we would be tr=
ying
    -    to look up the worktree HEADs before we have figured out the refer=
ence
    -    format, which does not work.
    +    Although not a problem presently with the file-based reference bac=
kend,
    +    it will become a problem with the upcoming reftable backend. In the
    +    context of git-init(1) we do not have a fully-initialized reposito=
ry set
    +    up via `setup_git_directory()` or friends. Consequently, we do not=
 know
    +    about the repository format when `repair_worktrees()` is called, a=
nd
    +    properly setting up all parts of the repositroy in `init_db()` bef=
ore we
    +    try to repair worktrees is not an easy task. With the introduction=
 of
    +    the reftable backend, we would ultimately try to look up the workt=
ree
    +    HEADs before we have figured out the reference format, which does =
not
    +    work.
    =20
         We do not require the worktree HEADs at all to repair worktrees. So
         let's fix this issue by skipping over the step that reads them.
    @@ worktree.c: static void mark_current_worktree(struct worktree **work=
trees)
      }
     =20
     -struct worktree **get_worktrees(void)
    ++/*
    ++ * NEEDSWORK: This function exists so that we can look up metadata of=
 a
    ++ * worktree without trying to access any of its internals like the re=
fdb. It
    ++ * would be preferable to instead have a corruption-tolerant function=
 for
    ++ * retrieving worktree metadata that could be used when the worktree =
is known
    ++ * to not be in a healthy state, e.g. when creating or repairing it.
    ++ */
     +static struct worktree **get_worktrees_internal(int skip_reading_head)
      {
      	struct worktree **list =3D NULL;
 3:  12329b99b7 !  3:  47649570bf refs: refactor logic to look up storage b=
ackends
    @@ refs.c
     +};
     =20
     -static struct ref_storage_be *find_ref_storage_backend(const char *na=
me)
    -+static const struct ref_storage_be *find_ref_storage_backend(int ref_=
storage_format)
    ++static const struct ref_storage_be *find_ref_storage_backend(unsigned=
 int ref_storage_format)
      {
     -	struct ref_storage_be *be;
     -	for (be =3D refs_backends; be; be =3D be->next)
    @@ refs.c
      	return NULL;
      }
     =20
    -+int ref_storage_format_by_name(const char *name)
    ++unsigned int ref_storage_format_by_name(const char *name)
     +{
    -+	for (int i =3D 0; i < ARRAY_SIZE(refs_backends); i++)
    ++	for (unsigned int i =3D 0; i < ARRAY_SIZE(refs_backends); i++)
     +		if (refs_backends[i] && !strcmp(refs_backends[i]->name, name))
     +			return i;
     +	return REF_STORAGE_FORMAT_UNKNOWN;
     +}
     +
    -+const char *ref_storage_format_to_name(int ref_storage_format)
    ++const char *ref_storage_format_to_name(unsigned int ref_storage_forma=
t)
     +{
     +	const struct ref_storage_be *be =3D find_ref_storage_backend(ref_sto=
rage_format);
     +	if (!be)
    @@ refs.c: static struct ref_store *ref_store_init(struct repository *r=
epo,
      {
     -	const char *be_name =3D "files";
     -	struct ref_storage_be *be =3D find_ref_storage_backend(be_name);
    -+	int format =3D REF_STORAGE_FORMAT_FILES;
    ++	unsigned int format =3D REF_STORAGE_FORMAT_FILES;
     +	const struct ref_storage_be *be =3D find_ref_storage_backend(format);
      	struct ref_store *refs;
     =20
    @@ refs.h: struct string_list;
      struct string_list_item;
      struct worktree;
     =20
    -+int ref_storage_format_by_name(const char *name);
    -+const char *ref_storage_format_to_name(int ref_storage_format);
    ++unsigned int ref_storage_format_by_name(const char *name);
    ++const char *ref_storage_format_to_name(unsigned int ref_storage_forma=
t);
     +
      /*
       * Resolve a reference, recursively following symbolic refererences.
 4:  ddd099fbaf !  4:  837764d0b5 setup: start tracking ref storage format
    @@ refs.c: static struct ref_store *ref_store_init(struct repository *r=
epo,
      					const char *gitdir,
      					unsigned int flags)
      {
    --	int format =3D REF_STORAGE_FORMAT_FILES;
    +-	unsigned int format =3D REF_STORAGE_FORMAT_FILES;
     -	const struct ref_storage_be *be =3D find_ref_storage_backend(format);
     +	const struct ref_storage_be *be;
      	struct ref_store *refs;
    @@ repository.c: void repo_set_hash_algo(struct repository *repo, int h=
ash_algo)
      	repo->hash_algo =3D &hash_algos[hash_algo];
      }
     =20
    -+void repo_set_ref_storage_format(struct repository *repo, int format)
    ++void repo_set_ref_storage_format(struct repository *repo, unsigned in=
t format)
     +{
     +	repo->ref_storage_format =3D format;
     +}
    @@ repository.h: struct repository {
      	const struct git_hash_algo *hash_algo;
     =20
     +	/* Repository's reference storage format, as serialized on disk. */
    -+	int ref_storage_format;
    ++	unsigned int ref_storage_format;
     +
      	/* A unique-id for tracing purposes. */
      	int trace2_repo_id;
    @@ repository.h: void repo_set_gitdir(struct repository *repo, const ch=
ar *root,
      		     const struct set_gitdir_args *extra_args);
      void repo_set_worktree(struct repository *repo, const char *path);
      void repo_set_hash_algo(struct repository *repo, int algo);
    -+void repo_set_ref_storage_format(struct repository *repo, int format);
    ++void repo_set_ref_storage_format(struct repository *repo, unsigned in=
t format);
      void initialize_the_repository(void);
      RESULT_MUST_BE_USED
      int repo_init(struct repository *r, const char *gitdir, const char *w=
orktree);
    @@ setup.c: static int is_reinit(void)
      }
     =20
     -void create_reference_database(const char *initial_branch, int quiet)
    -+void create_reference_database(int ref_storage_format,
    ++void create_reference_database(unsigned int ref_storage_format,
     +			       const char *initial_branch, int quiet)
      {
      	struct strbuf err =3D STRBUF_INIT;
    @@ setup.c: static void validate_hash_algorithm(struct repository_forma=
t *repo_fmt,
      	}
      }
     =20
    -+static void validate_ref_storage_format(struct repository_format *rep=
o_fmt, int format)
    ++static void validate_ref_storage_format(struct repository_format *rep=
o_fmt,
    ++					unsigned int format)
     +{
     +	if (repo_fmt->version >=3D 0 &&
     +	    format !=3D REF_STORAGE_FORMAT_UNKNOWN &&
    @@ setup.c: static void validate_hash_algorithm(struct repository_forma=
t *repo_fmt,
      int init_db(const char *git_dir, const char *real_git_dir,
     -	    const char *template_dir, int hash, const char *initial_branch,
     +	    const char *template_dir, int hash,
    -+	    int ref_storage_format, const char *initial_branch,
    ++	    unsigned int ref_storage_format,
    ++	    const char *initial_branch,
      	    int init_shared_repository, unsigned int flags)
      {
      	int reinit;
    @@ setup.h: struct repository_format {
      	int worktree_config;
      	int is_bare;
      	int hash_algo;
    -+	int ref_storage_format;
    ++	unsigned int ref_storage_format;
      	int sparse_index;
      	char *work_tree;
      	struct string_list unknown_extensions;
    @@ setup.h: void check_repository_format(struct repository_format *fmt);
     =20
      int init_db(const char *git_dir, const char *real_git_dir,
      	    const char *template_dir, int hash_algo,
    -+	    int ref_storage_format,
    ++	    unsigned int ref_storage_format,
      	    const char *initial_branch, int init_shared_repository,
      	    unsigned int flags);
      void initialize_repository_version(int hash_algo, int reinit);
     -void create_reference_database(const char *initial_branch, int quiet);
    -+void create_reference_database(int ref_storage_format,
    ++void create_reference_database(unsigned int ref_storage_format,
     +			       const char *initial_branch, int quiet);
     =20
      /*
 5:  01a1e58a97 =3D  5:  a51da56d9b setup: set repository's formats on init
 6:  0a586fa648 !  6:  a1e03e4392 setup: introduce "extensions.refStorage" =
extension
    @@ setup.c: static enum extension_result handle_extension(const char *v=
ar,
      		data->hash_algo =3D format;
      		return EXTENSION_OK;
     +	} else if (!strcmp(ext, "refstorage")) {
    -+		int format;
    ++		unsigned int format;
     +
     +		if (!value)
     +			return config_error_nonbool(var);
    @@ setup.c: static int needs_work_tree_config(const char *git_dir, cons=
t char *work
      }
     =20
     -void initialize_repository_version(int hash_algo, int reinit)
    -+void initialize_repository_version(int hash_algo, int ref_storage_for=
mat,
    ++void initialize_repository_version(int hash_algo,
    ++				   unsigned int ref_storage_format,
     +				   int reinit)
      {
      	char repo_version_string[10];
    @@ setup.c: static int create_default_files(const char *template_path,
    =20
      ## setup.h ##
     @@ setup.h: int init_db(const char *git_dir, const char *real_git_dir,
    - 	    int ref_storage_format,
    + 	    unsigned int ref_storage_format,
      	    const char *initial_branch, int init_shared_repository,
      	    unsigned int flags);
     -void initialize_repository_version(int hash_algo, int reinit);
    -+void initialize_repository_version(int hash_algo, int ref_storage_for=
mat,
    ++void initialize_repository_version(int hash_algo,
    ++				   unsigned int ref_storage_format,
     +				   int reinit);
    - void create_reference_database(int ref_storage_format,
    + void create_reference_database(unsigned int ref_storage_format,
      			       const char *initial_branch, int quiet);
     =20
    =20
 7:  6d8754f73a !  7:  5ffc70e9be setup: introduce GIT_DEFAULT_REF_FORMAT e=
nvvar
    @@ Documentation/git.txt: double-quotes and respecting backslash escape=
s. E.g., the
    =20
      ## setup.c ##
     @@ setup.c: static void validate_hash_algorithm(struct repository_form=
at *repo_fmt, int hash
    -=20
    - static void validate_ref_storage_format(struct repository_format *rep=
o_fmt, int format)
    + static void validate_ref_storage_format(struct repository_format *rep=
o_fmt,
    + 					unsigned int format)
      {
     +	const char *name =3D getenv("GIT_DEFAULT_REF_FORMAT");
     +
 8:  c645932f3d =3D  8:  13c074acdf t: introduce GIT_TEST_DEFAULT_REF_FORMA=
T envvar
 9:  761d647770 =3D  9:  4ee3c9a2d1 builtin/rev-parse: introduce `--show-re=
f-format` flag
10:  e382b5bf08 ! 10:  25773e3560 builtin/init: introduce `--ref-format=3D`=
 value flag
    @@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, cons=
t char *pref
     +	const char *ref_format =3D NULL;
      	const char *initial_branch =3D NULL;
      	int hash_algo =3D GIT_HASH_UNKNOWN;
    -+	int ref_storage_format =3D REF_STORAGE_FORMAT_UNKNOWN;
    ++	unsigned int ref_storage_format =3D REF_STORAGE_FORMAT_UNKNOWN;
      	int init_shared_repository =3D -1;
      	const struct option init_db_options[] =3D {
      		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
11:  257233658d ! 11:  3f1cb6b9e5 builtin/clone: introduce `--ref-format=3D=
` value flag
    @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
      	int submodule_progress;
      	int filter_submodules =3D 0;
      	int hash_algo;
    -+	int ref_storage_format =3D REF_STORAGE_FORMAT_UNKNOWN;
    ++	unsigned int ref_storage_format =3D REF_STORAGE_FORMAT_UNKNOWN;
      	const int do_not_override_repo_unix_permissions =3D -1;
     =20
      	struct transport_ls_refs_options transport_ls_refs_options =3D
12:  b8cd06ec53 =3D 12:  2e7682b2f3 t9500: write "extensions.refstorage" in=
to config

base-commit: e79552d19784ee7f4bbce278fe25f93fbda196fa
--=20
2.43.GIT


--Yq2X4lelZ9qehQ7p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWOdJgACgkQVbJhu7ck
PpSjCg/+M7UY+p3yC12uh72EzBmVXnssBsMV2GEUMIyeY8k414+mP1dyzqvqeNbV
AdXdVR3CIqz/t9fe5GxEBiu5ebSnK9c/ap9wb7nD1s9hqNznRwkZsF1DssVNmhne
ECMm7dhtBgodBDOB/GSKSK+Mtu6+hJ7jECs1rvnVHP/1IvQ+s5Jg4i8ejL/hP4Af
zSQkENLn7A7q/eJ9IHxWidkkLS4GQe+WZ4eRacRId/ffAZYZqodbaqNeCD7NSWfY
fxN9BBfcRYMMlKHpoUVmzM+nX1p7rwLbM/cS4Z8MnfuoNrG27UEXG5/VFYu/GncT
hSFlMb7pTFuwZglmKvxt45SgXZytBQ7Fo41rQldOsLrQS253T2zbDNS4Crxye5Ry
8nJ7+nGTk4x+eEfyIAIv3f2lnbTijjCin5clK9tUFyPtT3hIkKqn8m1tLuAI5CeX
iBMDDbyCKt6K4InVAPJNFzh0swql27X86T1eJiQsJ+BpkcJT+NikzJVUKUnoNHR8
7JZ4L8wYuAqGY6y7AJydQVxoqk8eAwY1rbkOKh+eMEHiw5l9GnT4KOgf/EGiao67
uSB8OED3n81bAxHsvw8H6AFKCpPKdo42T1ljvM2sAC7m7DRU8a7rtUl0MeP3NFz3
ZdGrgkKpjJs+npbXgNnI7Oox9qurT20DGJ8wIVnqAxhWCHDZ92o=
=4DQ0
-----END PGP SIGNATURE-----

--Yq2X4lelZ9qehQ7p--
