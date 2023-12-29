Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24AF8801
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 07:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KncCYnTX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KU07BdlS"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id DA4AE5C0170;
	Fri, 29 Dec 2023 02:26:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 29 Dec 2023 02:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703834801; x=1703921201; bh=RHA6e4bfyT
	CLx2gRjXKhoGvMR1n7PynZ6X0qbwDfkFs=; b=KncCYnTXksBFrMHJivqUB7lvjn
	5Z8QMolVGe0CeItDpLUX4yF4MNWyEq0TMjhDtoG/XGvXw0IGLxbA7JVNfSOZw7z2
	cw41bVmHMfZj72O/bAnCrpb31Y/xda/omdG21H2O7tH/uXZXAwalvsGrEyxVer3o
	ZuEiOsH899lF5hoFudX1K5HHo3Vg8BFiXg/k4zJ93QNQkiu6GEm9sUYyXW2ciXA0
	dVsDflLFHc1LNNtfz7Amt1X/pdfl1y5d7EKJPClY3uXWolonQcPD/we0RyvrXgqK
	8KgPT5jngX4MMB/7AMQ2fkDL+bT7543G/jznWvSGLYLx5KeH8hZ+hkpwLtbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703834801; x=1703921201; bh=RHA6e4bfyTCLx2gRjXKhoGvMR1n7
	PynZ6X0qbwDfkFs=; b=KU07BdlSQjdohKaRX4hK9hiw2QfKp2/8A9vzqNrITPuk
	5u8z6eoSh85yDAJm2PP/R7mFBVshgvncO929OUCUhHoHOj9USJDxsL6O+xAZ1zCq
	jI/ThDro6bps7id1EXXQ1Vqv3tTm41tvZR6bfOrpASWtE1oWVzfRNRU5qQGFvf5f
	uUqyyUNJ63GcyCu6DtmdEHXQCzyfpQ4ZbxeQB4eMbljpANvZfWaHk5p9PqnoZ04d
	JcEZt3DtBN1myUuYMG4sl3rr0Ldq1Z7EEsOdDp9wv8IcF/4BVYIoow0wi4GxGMQB
	ZwM2fOrjjLZgNoA8r76o1vS9FZNlB6CWT/7FIhnMKw==
X-ME-Sender: <xms:sXSOZcwU2hBtXCZDWIodw4kQogtnwUfyIg1LbWqz17BfmVYXrXfk5Q>
    <xme:sXSOZQQ_kHfseIne6ofYKLQGft5kB85hSyqLKNKP4dzrTtc2acmqE73VIoLv_r6ex
    YRyxEall4nWVHP4kw>
X-ME-Received: <xmr:sXSOZeXEGAgClw0k_aYTA72Dg7GtDs5iv-VJidgV0A4oPhqOrpzvhxrXzEgPtEycUpGkQTV677L35SWGHFtw9dZQiYuXekXn0YpOlFLfV5pTs-LUsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:sXSOZaj_cBFklpagdFYGWo5ax3qTLV7xtZhNOJGMSgiKYzfPj152WA>
    <xmx:sXSOZeCO8Y2EfMMyp_BxCJcYauBlxKe5YqVfAMmE5iFA3vYENaSwXA>
    <xmx:sXSOZbKxne0rGeZAG2v4cpUufMuUjbr2pfJyz7-ggrURxg4-X4ugYQ>
    <xmx:sXSOZROYC9dKXujKKlwXeCqL4fY82RnFQfi5htPgULx_i0xGa35SwA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Dec 2023 02:26:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 29ceefd4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 29 Dec 2023 07:24:25 +0000 (UTC)
Date: Fri, 29 Dec 2023 08:26:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 04/12] setup: start tracking ref storage format
Message-ID: <837764d0b5ff1236f2a8ab263e7eb622be46f1a7.1703833819.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703833818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bmXzGl8uDOXiM6NB"
Content-Disposition: inline
In-Reply-To: <cover.1703833818.git.ps@pks.im>


--bmXzGl8uDOXiM6NB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to discern which ref storage format a repository is supposed to
use we need to start setting up and/or discovering the format. This
needs to happen in two separate code paths.

  - The first path is when we create a repository via `init_db()`. When
    we are re-initializing a preexisting repository we need to retain
    the previously used ref storage format -- if the user asked for a
    different format then this indicates an error and we error out.
    Otherwise we either initialize the repository with the format asked
    for by the user or the default format, which currently is the
    "files" backend.

  - The second path is when discovering repositories, where we need to
    read the config of that repository. There is not yet any way to
    configure something other than the "files" backend, so we can just
    blindly set the ref storage format to this backend.

Wire up this logic so that we have the ref storage format always readily
available when needed. As there is only a single backend and because it
is not configurable we cannot yet verify that this tracking works as
expected via tests, but tests will be added in subsequent commits. To
countermand this ommission now though, raise a BUG() in case the ref
storage format is not set up properly in `ref_store_init()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c   |  5 +++--
 builtin/init-db.c |  4 +++-
 refs.c            |  4 ++--
 repository.c      |  6 ++++++
 repository.h      |  4 ++++
 setup.c           | 28 +++++++++++++++++++++++++---
 setup.h           |  6 +++++-
 7 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 343f536cf8..48aeb1b90b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1107,7 +1107,8 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 	 * repository, and reference backends may persist that information into
 	 * their on-disk data structures.
 	 */
-	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NULL,
+	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN,
+		REF_STORAGE_FORMAT_UNKNOWN, NULL,
 		do_not_override_repo_unix_permissions, INIT_DB_QUIET | INIT_DB_SKIP_REFD=
B);
=20
 	if (real_git_dir) {
@@ -1292,7 +1293,7 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 	hash_algo =3D hash_algo_by_ptr(transport_get_hash_algo(transport));
 	initialize_repository_version(hash_algo, 1);
 	repo_set_hash_algo(the_repository, hash_algo);
-	create_reference_database(NULL, 1);
+	create_reference_database(the_repository->ref_storage_format, NULL, 1);
=20
 	/*
 	 * Before fetching from the remote, download and install bundle
diff --git a/builtin/init-db.c b/builtin/init-db.c
index cb727c826f..b6e80feab6 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -11,6 +11,7 @@
 #include "object-file.h"
 #include "parse-options.h"
 #include "path.h"
+#include "refs.h"
 #include "setup.h"
 #include "strbuf.h"
=20
@@ -236,5 +237,6 @@ int cmd_init_db(int argc, const char **argv, const char=
 *prefix)
=20
 	flags |=3D INIT_DB_EXIST_OK;
 	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
-		       initial_branch, init_shared_repository, flags);
+		       REF_STORAGE_FORMAT_UNKNOWN, initial_branch,
+		       init_shared_repository, flags);
 }
diff --git a/refs.c b/refs.c
index dea3d5c9a0..fdbf5f4cb1 100644
--- a/refs.c
+++ b/refs.c
@@ -2045,10 +2045,10 @@ static struct ref_store *ref_store_init(struct repo=
sitory *repo,
 					const char *gitdir,
 					unsigned int flags)
 {
-	unsigned int format =3D REF_STORAGE_FORMAT_FILES;
-	const struct ref_storage_be *be =3D find_ref_storage_backend(format);
+	const struct ref_storage_be *be;
 	struct ref_store *refs;
=20
+	be =3D find_ref_storage_backend(repo->ref_storage_format);
 	if (!be)
 		BUG("reference backend is unknown");
=20
diff --git a/repository.c b/repository.c
index a7679ceeaa..d7d24d416a 100644
--- a/repository.c
+++ b/repository.c
@@ -104,6 +104,11 @@ void repo_set_hash_algo(struct repository *repo, int h=
ash_algo)
 	repo->hash_algo =3D &hash_algos[hash_algo];
 }
=20
+void repo_set_ref_storage_format(struct repository *repo, unsigned int for=
mat)
+{
+	repo->ref_storage_format =3D format;
+}
+
 /*
  * Attempt to resolve and set the provided 'gitdir' for repository 'repo'.
  * Return 0 upon success and a non-zero value upon failure.
@@ -184,6 +189,7 @@ int repo_init(struct repository *repo,
 		goto error;
=20
 	repo_set_hash_algo(repo, format.hash_algo);
+	repo_set_ref_storage_format(repo, format.ref_storage_format);
 	repo->repository_format_worktree_config =3D format.worktree_config;
=20
 	/* take ownership of format.partial_clone */
diff --git a/repository.h b/repository.h
index ea4c488b81..f5269b3730 100644
--- a/repository.h
+++ b/repository.h
@@ -163,6 +163,9 @@ struct repository {
 	/* Repository's current hash algorithm, as serialized on disk. */
 	const struct git_hash_algo *hash_algo;
=20
+	/* Repository's reference storage format, as serialized on disk. */
+	unsigned int ref_storage_format;
+
 	/* A unique-id for tracing purposes. */
 	int trace2_repo_id;
=20
@@ -202,6 +205,7 @@ void repo_set_gitdir(struct repository *repo, const cha=
r *root,
 		     const struct set_gitdir_args *extra_args);
 void repo_set_worktree(struct repository *repo, const char *path);
 void repo_set_hash_algo(struct repository *repo, int algo);
+void repo_set_ref_storage_format(struct repository *repo, unsigned int for=
mat);
 void initialize_the_repository(void);
 RESULT_MUST_BE_USED
 int repo_init(struct repository *r, const char *gitdir, const char *worktr=
ee);
diff --git a/setup.c b/setup.c
index bc90bbd033..9c9a167f52 100644
--- a/setup.c
+++ b/setup.c
@@ -1566,6 +1566,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 		if (startup_info->have_repository) {
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+			repo_set_ref_storage_format(the_repository,
+						    repo_fmt.ref_storage_format);
 			the_repository->repository_format_worktree_config =3D
 				repo_fmt.worktree_config;
 			/* take ownership of repo_fmt.partial_clone */
@@ -1659,6 +1661,8 @@ void check_repository_format(struct repository_format=
 *fmt)
 	check_repository_format_gently(get_git_dir(), fmt, NULL);
 	startup_info->have_repository =3D 1;
 	repo_set_hash_algo(the_repository, fmt->hash_algo);
+	repo_set_ref_storage_format(the_repository,
+				    fmt->ref_storage_format);
 	the_repository->repository_format_worktree_config =3D
 		fmt->worktree_config;
 	the_repository->repository_format_partial_clone =3D
@@ -1899,7 +1903,8 @@ static int is_reinit(void)
 	return ret;
 }
=20
-void create_reference_database(const char *initial_branch, int quiet)
+void create_reference_database(unsigned int ref_storage_format,
+			       const char *initial_branch, int quiet)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	int reinit =3D is_reinit();
@@ -1919,6 +1924,7 @@ void create_reference_database(const char *initial_br=
anch, int quiet)
 	safe_create_dir(git_path("refs"), 1);
 	adjust_shared_perm(git_path("refs"));
=20
+	repo_set_ref_storage_format(the_repository, ref_storage_format);
 	if (refs_init_db(&err))
 		die("failed to set up refs db: %s", err.buf);
=20
@@ -2137,8 +2143,22 @@ static void validate_hash_algorithm(struct repositor=
y_format *repo_fmt, int hash
 	}
 }
=20
+static void validate_ref_storage_format(struct repository_format *repo_fmt,
+					unsigned int format)
+{
+	if (repo_fmt->version >=3D 0 &&
+	    format !=3D REF_STORAGE_FORMAT_UNKNOWN &&
+	    format !=3D repo_fmt->ref_storage_format) {
+		die(_("attempt to reinitialize repository with different reference stora=
ge format"));
+	} else if (format !=3D REF_STORAGE_FORMAT_UNKNOWN) {
+		repo_fmt->ref_storage_format =3D format;
+	}
+}
+
 int init_db(const char *git_dir, const char *real_git_dir,
-	    const char *template_dir, int hash, const char *initial_branch,
+	    const char *template_dir, int hash,
+	    unsigned int ref_storage_format,
+	    const char *initial_branch,
 	    int init_shared_repository, unsigned int flags)
 {
 	int reinit;
@@ -2181,13 +2201,15 @@ int init_db(const char *git_dir, const char *real_g=
it_dir,
 	check_repository_format(&repo_fmt);
=20
 	validate_hash_algorithm(&repo_fmt, hash);
+	validate_ref_storage_format(&repo_fmt, ref_storage_format);
=20
 	reinit =3D create_default_files(template_dir, original_git_dir,
 				      &repo_fmt, prev_bare_repository,
 				      init_shared_repository);
=20
 	if (!(flags & INIT_DB_SKIP_REFDB))
-		create_reference_database(initial_branch, flags & INIT_DB_QUIET);
+		create_reference_database(repo_fmt.ref_storage_format,
+					  initial_branch, flags & INIT_DB_QUIET);
 	create_object_directory();
=20
 	if (get_shared_repository()) {
diff --git a/setup.h b/setup.h
index 3f0f17c351..3d3eda7967 100644
--- a/setup.h
+++ b/setup.h
@@ -115,6 +115,7 @@ struct repository_format {
 	int worktree_config;
 	int is_bare;
 	int hash_algo;
+	unsigned int ref_storage_format;
 	int sparse_index;
 	char *work_tree;
 	struct string_list unknown_extensions;
@@ -131,6 +132,7 @@ struct repository_format {
 	.version =3D -1, \
 	.is_bare =3D -1, \
 	.hash_algo =3D GIT_HASH_SHA1, \
+	.ref_storage_format =3D REF_STORAGE_FORMAT_FILES, \
 	.unknown_extensions =3D STRING_LIST_INIT_DUP, \
 	.v1_only_extensions =3D STRING_LIST_INIT_DUP, \
 }
@@ -175,10 +177,12 @@ void check_repository_format(struct repository_format=
 *fmt);
=20
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash_algo,
+	    unsigned int ref_storage_format,
 	    const char *initial_branch, int init_shared_repository,
 	    unsigned int flags);
 void initialize_repository_version(int hash_algo, int reinit);
-void create_reference_database(const char *initial_branch, int quiet);
+void create_reference_database(unsigned int ref_storage_format,
+			       const char *initial_branch, int quiet);
=20
 /*
  * NOTE NOTE NOTE!!
--=20
2.43.GIT


--bmXzGl8uDOXiM6NB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWOdK4ACgkQVbJhu7ck
PpSibg/+ILVHyTLQs/IBirkTn9wOHn8Q/hQ3Az3CLAcY4GBf9TieheHJfOr3yJvn
SRohN4Lo8UKfeWs/Reu5z3TxHNBLXWFefB0aVO7O7wey9nILn4eqwNMCE97LJn5f
DKeHHLl+r8MmTnhL4SBDG1qJ8HlqaqcK16Bn36vw0OztUPv1kLmhLuC/Kh6UQngJ
dhlkf6Gk9tDUsDt1PRLJaO6IYR1ae8ddmQLn/8z2gfWuu0Ab6dBD1zzXDx1MT6QO
z4gWRhUyRR5wnW5KpiKy27mLc1AiLPRHnoo7N1xeWXNjVzAcLbgi7ZmliYVD0u1L
Ddktiywl2wbH8ckJ7oQ+uqz8GFU13y4UOk8uZNn0kRbegmsUxGPEHpft8OZSBEnp
XeY5iAHla9v7DyHKK6OIBeUijTRW2qfy0YAtndeINODg6ShLk/2kOZyubDwTO8Fu
IC1GAY4dV73iOHu/sczTUhqLbIFor4j18vYdJAl+WgKEwvxEGDy66Eg8tFgjI6mE
32UBrUE2B2LfVkoqq37Grz7g2QzdrjM6uGMCxSYZUyGVg8rOtuSNeZ5mCJlDehsf
hybmZn1wL4y48Sohj2y55Hqr42SAhxNchBlaECga0ScLaU1QdhhjyfAiGQQusaWt
yn68GbS70fsLPvqvmQn5XJ155+Hn1+M05OIHc7Oy/N95tP04sDE=
=gEyX
-----END PGP SIGNATURE-----

--bmXzGl8uDOXiM6NB--
