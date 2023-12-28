Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A10C6FAE
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VBRKMSfg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wUW6zhLC"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 8ABC35C0080;
	Thu, 28 Dec 2023 04:57:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 28 Dec 2023 04:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757463; x=1703843863; bh=H0IqTM+tyU
	QOtcaOgjasBkKFMbzO3ffAo7k1Hlwdt9Q=; b=VBRKMSfgGwi2334pQEVb0Hudsp
	z4bXlOjS+qp1p/IpV1emNuru7Kt+I6SejmP9pfhyzTzlyXZjnMz7bhSjYLUa5C+b
	w2gy04fgkSvxRGIgtQ1RJlCu+J0lV8I9w534WWSP/GEs3vkImi+FIThcrm+dVUGC
	D9JSnBciIhkya/Ft5muedZMWUA1AkXLItSR4NmqXvythVNJAktwdypME51hK06KB
	iVBscRR8pradJiJxCTgc6G8+Qb4ydLUB+fDM71ijVgHcF0KjclqVYHc7AOYPnrpa
	ZIO4yw4hb5dXI+aqzn8AYd9NgSNluMuQsu7VJAwxCbcRBdhP7Kml6t19QB6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757463; x=1703843863; bh=H0IqTM+tyUQOtcaOgjasBkKFMbzO
	3ffAo7k1Hlwdt9Q=; b=wUW6zhLCi3tRg65Af1tgwXYlXWJDghd4ma1dcI04VNq5
	2z3VeGLeyz29Ow9TfsfI1vABNPvV46YlQN9FM5Blla6xtV98CYZPs0wUkloYq62C
	dh1EqXiYro+zDCciG8otES5YdoOFDYErpJqRVF4PTs9y24R2pUV3MO3ie2ek8B6Z
	4G1TZghCn9SKBM8Sl1QV88/ir9pEUw6J72pGYISodw39s7D+BDKhSHH1Arz+VxcS
	exuIKKW/S2EWwtPasBBXRRh3ZQUBnmd0BMpEkHTDPxYI1S3STx5P1jkZG5qku9Nz
	8oNsvsvLz9OFhO/K+mofnB4rBsrWlslwPswclQbDEA==
X-ME-Sender: <xms:l0aNZYlpJTJ4Gt5ZWJQJsUioHFwVr0Cbku7t8mt7XQTOhlMHJHRAiw>
    <xme:l0aNZX0hAVco-kSiGjutrLebNMQZuLXRR_ww_z4Jtsl1_slSyiTv5L9px6iluxuVb
    Woo3TjpTh_PkQt5oA>
X-ME-Received: <xmr:l0aNZWroLUyka4w-_-y2VIwUQbowCgUhB67SDC20-AMS42mNA8iCrbPFpDiLervvOdgHtIfZR84I1oBpHjPNUMM0Kqtq0ytq2Tshw5SZg5ndSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:l0aNZUmd9iCjU0qKVG1knJDom3qOnq1ddiklU7UBlq0sWMvpu6dfjQ>
    <xmx:l0aNZW1S4CNQm1KguSKHKcdnmrpYnivHQCgVa_Mf02-Mb2cHH8Fh1w>
    <xmx:l0aNZbui89PfzvSE_pqDSUbWI7u8N23yEK-jd_R9PnA3dsRSvjCAZA>
    <xmx:l0aNZb-oXpl9zY9sKMh8BYQK0Jyr3n_YoJ9XOQ8K1jVac8tKhDngkA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 04:57:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a85902da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 09:55:28 +0000 (UTC)
Date: Thu, 28 Dec 2023 10:57:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/12] setup: start tracking ref storage format
Message-ID: <ddd099fbaf3d8f4b6b6276048d0fcbc814f9e59c.1703753910.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703753910.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uegl1NB8pgVUjg0p"
Content-Disposition: inline
In-Reply-To: <cover.1703753910.git.ps@pks.im>


--uegl1NB8pgVUjg0p
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
 setup.c           | 26 +++++++++++++++++++++++---
 setup.h           |  6 +++++-
 7 files changed, 46 insertions(+), 9 deletions(-)

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
index ab14634731..be8fcabde0 100644
--- a/refs.c
+++ b/refs.c
@@ -2045,10 +2045,10 @@ static struct ref_store *ref_store_init(struct repo=
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
 		BUG("reference backend is unknown");
=20
diff --git a/repository.c b/repository.c
index a7679ceeaa..691cabf45b 100644
--- a/repository.c
+++ b/repository.c
@@ -104,6 +104,11 @@ void repo_set_hash_algo(struct repository *repo, int h=
ash_algo)
 	repo->hash_algo =3D &hash_algos[hash_algo];
 }
=20
+void repo_set_ref_storage_format(struct repository *repo, int format)
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
index ea4c488b81..d3a24da4d6 100644
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
@@ -202,6 +205,7 @@ void repo_set_gitdir(struct repository *repo, const cha=
r *root,
 		     const struct set_gitdir_args *extra_args);
 void repo_set_worktree(struct repository *repo, const char *path);
 void repo_set_hash_algo(struct repository *repo, int algo);
+void repo_set_ref_storage_format(struct repository *repo, int format);
 void initialize_the_repository(void);
 RESULT_MUST_BE_USED
 int repo_init(struct repository *r, const char *gitdir, const char *worktr=
ee);
diff --git a/setup.c b/setup.c
index bc90bbd033..e58ab7e786 100644
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
+void create_reference_database(int ref_storage_format,
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
@@ -2137,8 +2143,20 @@ static void validate_hash_algorithm(struct repositor=
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
@@ -2181,13 +2199,15 @@ int init_db(const char *git_dir, const char *real_g=
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


--uegl1NB8pgVUjg0p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRpMACgkQVbJhu7ck
PpT9qRAAglqX5KCcJN5eMGCSezr6TO5YLUsMIbmFmMn9me0SIinMWvW0ac+k5OIu
RyVyQku96SRtNChUknGikTmLs9WAJzLud6b+nwNHmHXyuqi2tUoY+jWMPGoLq2ZB
KdPokb2RstizYwIKs5TD8897yQD83bkBGGmBaKmctAArKsbE3OTabD3jH2UU34OC
qhu4Erz/gLlblU3ziuWGSAYQwI5+2WslaiADMY3A9S4SCFtiTM4MTlssQeKY6Xhj
jvwaXoJO2ZFJLql6aZSiGUOaijt2XxFvaou4SS1AsQWfD4B1s/8i1jtboXj7fZz4
zwt+8iT5xzSYdP45g4y8O69vR9pdvansLW+E9B/KhKpZzCd3whFhVqP74O1sz21N
HtQFnzARUzhiN1CTKnaVz/pj7KCWRhl3GUskScEBiuGbT/CTEqkJsLmpLDzTMheE
l/X4sN7X+b1gYLQx+Ka+hMUsLhYy8dPnFtfA33kz8gfa/R31u2BLQkdggvILt7kn
DX7sLfN/uxXaRd7aOej9KA+dD9ywsaPvqb3n93+Qzh/LmbzdRde/ZAd8asFjWThm
+E5E88WBKxhD7m2R4z8VckT1CMTZoegc1JlUBzOOgtvMikNE3ywMXtkOVnFR+lzF
FGINOCUP7CbD0HjOcnNjKbU6NTSBycPXqiwcle+zFWIiIGkxGn8=
=QIzq
-----END PGP SIGNATURE-----

--uegl1NB8pgVUjg0p--
