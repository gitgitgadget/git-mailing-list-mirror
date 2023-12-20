Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A933C21341
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rUgv5dNi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="snTBkICb"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id AD8FB5C01DB
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 20 Dec 2023 05:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703069710; x=1703156110; bh=+CTmKpbr79
	dJdYsWbTmhlumHjG6nT3KNvqCP5TecLgk=; b=rUgv5dNi1Kv52BJSxTvhqaCquW
	qVEUcSrH6ticJ68+cdNxQGz1eD83YG9cIbSp+DpMt1NOFAzGIoyCtxX/ohfXi314
	EjmSfbiR7WdXKEWQ6McFsrH+/2JsMCREZ9fgJGIIIY4mTAWRluTQbX/icTOH+qQj
	jfl9A5/5v3b9po2uIiJnanHkwFZvg1oEsFooMCzjhEEh1PvLUzntUMHeEkPGUcGD
	/SsaskAd7H93D0wHLm/tH5lAanoo734Q4wUSLDzLPgdjoehMC9+RXRfFC152X2Kp
	3wuj+W6VDMkH97N29RGGWWXs4UJvUFRbVllPD3Yhs+rIwOk7aKAfbDBeGFOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703069710; x=1703156110; bh=+CTmKpbr79dJdYsWbTmhlumHjG6n
	T3KNvqCP5TecLgk=; b=snTBkICblN01Vt8edVzXsmXK0wTmIbnwr9I5XvGd/QEj
	IbEYMrf63Tlt0d8zt94oamORVh/a5FOxFtF8PlDOJOavWblq1q9YN6JBrGWvIemw
	CVLFQwxKvOvK/ohresdG/weqRMmaUDD/ljAcb+QrZquN5WKBAcvy63F7u7kXXVQ4
	AE5WeBqIpiRxcjIq8TNh02T2moQSmDMrPIQ/A0GMFNwx8rBp7JzZ6ZKxXnmaL8GV
	RmPg4KtIkrUQhWSfulP3xXvaDqpLLkZRGWV8DFRACqyANdnhkK2oftVcxHRk7SNa
	kkAYhiNKTEsVWzObrlD1FbJ1iILs6rsd32IXWCRtmQ==
X-ME-Sender: <xms:DsiCZT4GrwXjrItFX9vWg2TMTRJtUpFlzvOSKhcAHZK5cx0LHMaeYA>
    <xme:DsiCZY54P3gK7QfU0iHV1-gK6TVkMAObyDUhWmBURBwwZ10p1oHKAJHDBOSyDqcB_
    JIE8PQH5dHGP-WC8Q>
X-ME-Received: <xmr:DsiCZadAnnefT9H3QLha9_rGxpY2P1nGy5OtQo5ZXhRI7rsnURWK8LhLasPNoR24MxBf4iJC17_b-9FjivWmhzppjoKBTEsYfD2vx19A01FCTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:DsiCZUL9Ts3us69xfZsESHfJfMEBGyqyUu2iNRvNqDlEyMQ-rKdy_g>
    <xmx:DsiCZXLlRlMK4ByCUrBbixSUoaDJsVTvJYZ7WvhO0fCim8b2iYU1Hg>
    <xmx:DsiCZdy5UgnZmm21eBOE7cLdXLk1Iyfism_HWr1oW7nl4NpZNUQqJQ>
    <xmx:DsiCZSnvWPoAyDj7Tl46Eii8LfEfA2x3rjMIVz3WWkmvNMCoPHo9hA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c3722f1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 10:53:14 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:55:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/12] setup: start tracking ref storage format when
Message-ID: <6564659d403de098799ddb8101b74c2803a655d4.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IH2DzKC5Bfq5vJQU"
Content-Disposition: inline
In-Reply-To: <cover.1703067989.git.ps@pks.im>


--IH2DzKC5Bfq5vJQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to discern which ref storage format a repository is supposed to
use we need to start setting up and/or discovering the format. This
needs to happen in two separate code paths.

  - The first path is when we create a repository via `init_db()`. When
    we are re-initializing a preexisting repository we need to retain
    the previously used ref storage format -- if the user asked for a
    different format then this indicates an erorr and we error out.
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
 refs.c            |  6 +++---
 refs.h            |  1 +
 repository.c      |  1 +
 repository.h      |  3 +++
 setup.c           | 26 +++++++++++++++++++++++---
 setup.h           |  6 +++++-
 8 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 339af10c10..6840064b59 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1105,7 +1105,8 @@ int cmd_clone(int argc, const char **argv, const char=
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
@@ -1290,7 +1291,7 @@ int cmd_clone(int argc, const char **argv, const char=
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
index e87c85897d..d289a5e175 100644
--- a/refs.c
+++ b/refs.c
@@ -2045,12 +2045,12 @@ static struct ref_store *ref_store_init(struct repo=
sitory *repo,
 					const char *gitdir,
 					unsigned int flags)
 {
-	int format =3D REF_STORAGE_FORMAT_FILES;
-	const struct ref_storage_be *be =3D find_ref_storage_backend(format);
+	const struct ref_storage_be *be;
 	struct ref_store *refs;
=20
+	be =3D find_ref_storage_backend(repo->ref_storage_format);
 	if (!be)
-		BUG("reference backend %s is unknown", ref_storage_format_to_name(format=
));
+		BUG("reference backend is unknown");
=20
 	refs =3D be->init(repo, gitdir, flags);
 	return refs;
diff --git a/refs.h b/refs.h
index c6571bcf6c..944a67ac1b 100644
--- a/refs.h
+++ b/refs.h
@@ -11,6 +11,7 @@ struct string_list;
 struct string_list_item;
 struct worktree;
=20
+int default_ref_storage_format(void);
 int ref_storage_format_by_name(const char *name);
 const char *ref_storage_format_to_name(int ref_storage_format);
=20
diff --git a/repository.c b/repository.c
index a7679ceeaa..a75c1598b0 100644
--- a/repository.c
+++ b/repository.c
@@ -184,6 +184,7 @@ int repo_init(struct repository *repo,
 		goto error;
=20
 	repo_set_hash_algo(repo, format.hash_algo);
+	repo->ref_storage_format =3D format.ref_storage_format;
 	repo->repository_format_worktree_config =3D format.worktree_config;
=20
 	/* take ownership of format.partial_clone */
diff --git a/repository.h b/repository.h
index ea4c488b81..22c30cdbc9 100644
--- a/repository.h
+++ b/repository.h
@@ -163,6 +163,9 @@ struct repository {
 	/* Repository's current hash algorithm, as serialized on disk. */
 	const struct git_hash_algo *hash_algo;
=20
+	/* Repository's reference storage format, as serialized on disk. */
+	int ref_storage_format;
+
 	/* A unique-id for tracing purposes. */
 	int trace2_repo_id;
=20
diff --git a/setup.c b/setup.c
index 155fe13f70..c1bf106379 100644
--- a/setup.c
+++ b/setup.c
@@ -1564,6 +1564,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 		if (startup_info->have_repository) {
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+			the_repository->ref_storage_format =3D
+				repo_fmt.ref_storage_format;
 			the_repository->repository_format_worktree_config =3D
 				repo_fmt.worktree_config;
 			/* take ownership of repo_fmt.partial_clone */
@@ -1657,6 +1659,8 @@ void check_repository_format(struct repository_format=
 *fmt)
 	check_repository_format_gently(get_git_dir(), fmt, NULL);
 	startup_info->have_repository =3D 1;
 	repo_set_hash_algo(the_repository, fmt->hash_algo);
+	the_repository->ref_storage_format =3D
+		fmt->ref_storage_format;
 	the_repository->repository_format_worktree_config =3D
 		fmt->worktree_config;
 	the_repository->repository_format_partial_clone =3D
@@ -1897,7 +1901,8 @@ static int is_reinit(void)
 	return ret;
 }
=20
-void create_reference_database(const char *initial_branch, int quiet)
+void create_reference_database(int ref_storage_format,
+			       const char *initial_branch, int quiet)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	int reinit =3D is_reinit();
@@ -1917,6 +1922,7 @@ void create_reference_database(const char *initial_br=
anch, int quiet)
 	safe_create_dir(git_path("refs"), 1);
 	adjust_shared_perm(git_path("refs"));
=20
+	the_repository->ref_storage_format =3D ref_storage_format;
 	if (refs_init_db(&err))
 		die("failed to set up refs db: %s", err.buf);
=20
@@ -2135,8 +2141,20 @@ static void validate_hash_algorithm(struct repositor=
y_format *repo_fmt, int hash
 	}
 }
=20
+static void validate_ref_storage_format(struct repository_format *repo_fmt=
, int format)
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
+	    int ref_storage_format, const char *initial_branch,
 	    int init_shared_repository, unsigned int flags)
 {
 	int reinit;
@@ -2179,13 +2197,15 @@ int init_db(const char *git_dir, const char *real_g=
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
index 3f0f17c351..4927abf2cf 100644
--- a/setup.h
+++ b/setup.h
@@ -115,6 +115,7 @@ struct repository_format {
 	int worktree_config;
 	int is_bare;
 	int hash_algo;
+	int ref_storage_format;
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
+	    int ref_storage_format,
 	    const char *initial_branch, int init_shared_repository,
 	    unsigned int flags);
 void initialize_repository_version(int hash_algo, int reinit);
-void create_reference_database(const char *initial_branch, int quiet);
+void create_reference_database(int ref_storage_format,
+			       const char *initial_branch, int quiet);
=20
 /*
  * NOTE NOTE NOTE!!
--=20
2.43.GIT


--IH2DzKC5Bfq5vJQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCyAoACgkQVbJhu7ck
PpRxLw//awLnEsI50ihx9wKpdm3AVFjb80WKzcsMr+BTPfZwYbJUpRhH1yzzT0Mz
MjWwM4D3VcKzSCuXL8xA75MRnV7Bq9pKCA8QCpJqOVE4pA6EAOXH25lm1yEOFspA
LpK8yZbHLUIhI4v+RcBletndXRRlBLQbkwH8E2XT/Rukr+2LU/qYrB1kt99qZUDN
qDFib/hRJJUkEPNMV8RqT68EcKMq02tF0ZGKD9q/Xk1znx/K8fL6ClvCRtMDwnKG
/BYXu7oMNV9+alm4BqgVVelWQjaCvVLVKd5svJ2N3E2lsTfnHhRYsKbX+3kBR2V8
+fnp0K73QC6KGTB/X78u6OCF5D8EhdknhoV4iG6qSby2uOXHNxtttHLqlLHMFfYq
g1avwwuSKxDu3CRsSzVzEvcLfaGgUnKrCm7dvOwh+HGw/JiFHMSv9uIsmBnDP81/
UArldhW3qiyjaJPdk6UpgkC9cM2g7lANfhQ21FN0wzwgYNzgvbkEunG7gDWri2ug
srG9a4cRnn8W9QWighjLCBEQERjtW6ebxTPNK29Vdapzicv73bscg61E2nN+iiMw
8g1/v0TjmTPc9cOmxEdgd4aHQKIpi8JhSM/sY6hfPNP7aefSAzBWME2Q5RbWOPZr
P1CpzvLY9Z1XoA3GIkrKUo18OzgyMuJutvFVqBkhRHiL5mZBeSo=
=1+8z
-----END PGP SIGNATURE-----

--IH2DzKC5Bfq5vJQU--
