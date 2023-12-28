Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE167461
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hf0UYGu3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UQTbiRzi"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id B30A65C0080;
	Thu, 28 Dec 2023 04:57:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 28 Dec 2023 04:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757471; x=1703843871; bh=eqMeRGsQ7z
	fl3ewK+aivXu+c6z2fjFxbjh/biwL+XLI=; b=hf0UYGu3HtkOqKWebVqVrAyHDC
	xi+EV9LJcpU8MqUzns6at87BZPe20gIab6o+zXsuSrFU1BkOVUqfnfYv4xgpXCwi
	ecSIBOxiz/AUHkIdC+xx2aedUC7Y7VtKNe8pWynD4G68IrahJI5A3fPkK93SSGDt
	zLlVLSEIaDa2V8ECD9/GD6892GnISGv2oqOKtHi544XnbKFZOLkPvnY0Bmky8Izd
	4dXxtocC3/fcrPydRMOmweNP2KIXr41q/hmvA2+5HZ64uC+PnynQRW6ZyEOJYKxh
	YjLp497WO//np2oO4fYDDvdZ9ny/tRJ+/KN+00DU2CGfGcbrm5DgNuHua80A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757471; x=1703843871; bh=eqMeRGsQ7zfl3ewK+aivXu+c6z2f
	jFxbjh/biwL+XLI=; b=UQTbiRzi4lxs0T8g/70/iqTKisQJlFdD78dqZBHH3050
	V2QMjw5tr1BIIH28R35mcZlxoe8unwAT73+xjbKv3dwZ2iZ1yCJhTFoQ7+RC2WXQ
	XBPJiohedx5WnuF0iFQ9GF0VwIOs+gxnAORjch2Fi9pLbe7+5NiSwikqBmkyzweV
	ISEl1pglAJcUa5ZclfWzHTvEn5ZMvWdnfafGu1EQVdb/3i5qZcjZyiI2hNEpCr7k
	vgzja3WHauoahZd5XyNsgtw0Tae9smt9+lIx+O6RdLqntIGTkX+UaNshQl55wrgX
	GYVCmoKwa4Y9S2CYUSuxbH4y0N5NqK6KSv90eloo4Q==
X-ME-Sender: <xms:n0aNZZxYjwRqtY-VI5fuWAJIsejPqFvuXOLbmDv8xjrRl65dnsiAYA>
    <xme:n0aNZZT-avryGplqUtvkLBu4UEKxB3BH5-g7d8pQzeH-frxyHRtiZIc7RbirM5si7
    oncMPLnuLcBtD6mhg>
X-ME-Received: <xmr:n0aNZTW1F8Am08nnCdW280NXY6xFv7lwwpbQDkzKsgiHhNLv8RjwY1FdRZQZj9qV5RlO2QZUBlVdwQYY92xfofLtbQaTnHoUhAdBkR_1HbKFNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:n0aNZbgxpV7Hdt-3g2N-Zdmjo8RYM1v6EuFqFmHUQ83Bk256_6ImZg>
    <xmx:n0aNZbA_5Vjp9qmr50SXNIRsgTrSehJeHgOocp4MMMt6gD-i7s8oEQ>
    <xmx:n0aNZULa-qcSfsJvVuliNeKsUxwCgxCkcBsCH3OAnCjbVc_paOFptQ>
    <xmx:n0aNZQ68G2Byb5sh7QRHL75nTVuNfFIk18IUmD5NTaeIKPQgFzrqfg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 04:57:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a28088e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 09:55:37 +0000 (UTC)
Date: Thu, 28 Dec 2023 10:57:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/12] setup: introduce "extensions.refStorage" extension
Message-ID: <0a586fa648ba618de394d0006d13a117574a260a.1703753910.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703753910.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vYO936M3KdpiF/UR"
Content-Disposition: inline
In-Reply-To: <cover.1703753910.git.ps@pks.im>


--vYO936M3KdpiF/UR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new "extensions.refStorage" extension that allows us to
specify the ref storage format used by a repository. For now, the only
supported format is the "files" format, but this list will likely soon
be extended to also support the upcoming "reftable" format.

There have been discussions on the Git mailing list in the past around
how exactly this extension should look like. One alternative [1] that
was discussed was whether it would make sense to model the extension in
such a way that backends are arbitrarily stackable. This would allow for
a combined value of e.g. "loose,packed-refs" or "loose,reftable", which
indicates that new refs would be written via "loose" files backend and
compressed into "packed-refs" or "reftable" backends, respectively.

It is arguable though whether this flexibility and the complexity that
it brings with it is really required for now. It is not foreseeable that
there will be a proliferation of backends in the near-term future, and
the current set of existing formats and formats which are on the horizon
can easily be configured with the much simpler proposal where we have a
single value, only.

Furthermore, if we ever see that we indeed want to gain the ability to
arbitrarily stack the ref formats, then we can adapt the current
extension rather easily. Given that Git clients will refuse any unknown
value for the "extensions.refStorage" extension they would also know to
ignore a stacked "loose,packed-refs" in the future.

So let's stick with the easy proposal for the time being and wire up the
extension.

[1]: <pull.1408.git.1667846164.gitgitgadget@gmail.com>

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/extensions.txt           | 11 ++++++++
 Documentation/ref-storage-format.txt          |  1 +
 .../technical/repository-version.txt          |  5 ++++
 builtin/clone.c                               |  2 +-
 setup.c                                       | 23 +++++++++++++---
 setup.h                                       |  3 ++-
 t/t0001-init.sh                               | 26 +++++++++++++++++++
 t/test-lib.sh                                 |  2 +-
 8 files changed, 67 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ref-storage-format.txt

diff --git a/Documentation/config/extensions.txt b/Documentation/config/ext=
ensions.txt
index bccaec7a96..66db0e15da 100644
--- a/Documentation/config/extensions.txt
+++ b/Documentation/config/extensions.txt
@@ -7,6 +7,17 @@ Note that this setting should only be set by linkgit:git-i=
nit[1] or
 linkgit:git-clone[1].  Trying to change it after initialization will not
 work and will produce hard-to-diagnose issues.
=20
+extensions.refStorage::
+	Specify the ref storage format to use. The acceptable values are:
++
+include::../ref-storage-format.txt[]
++
+It is an error to specify this key unless `core.repositoryFormatVersion` i=
s 1.
++
+Note that this setting should only be set by linkgit:git-init[1] or
+linkgit:git-clone[1]. Trying to change it after initialization will not
+work and will produce hard-to-diagnose issues.
+
 extensions.worktreeConfig::
 	If enabled, then worktrees will load config settings from the
 	`$GIT_DIR/config.worktree` file in addition to the
diff --git a/Documentation/ref-storage-format.txt b/Documentation/ref-stora=
ge-format.txt
new file mode 100644
index 0000000000..1a65cac468
--- /dev/null
+++ b/Documentation/ref-storage-format.txt
@@ -0,0 +1 @@
+* `files` for loose files with packed-refs. This is the default.
diff --git a/Documentation/technical/repository-version.txt b/Documentation=
/technical/repository-version.txt
index 045a76756f..27be3741e6 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -100,3 +100,8 @@ If set, by default "git config" reads from both "config=
" and
 multiple working directory mode, "config" file is shared while
 "config.worktree" is per-working directory (i.e., it's in
 GIT_COMMON_DIR/worktrees/<id>/config.worktree)
+
+=3D=3D=3D=3D `refStorage`
+
+Specifies the file format for the ref database. The only valid value
+is `files` (loose references with a packed-refs file).
diff --git a/builtin/clone.c b/builtin/clone.c
index 48aeb1b90b..0fb3816d0c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1291,7 +1291,7 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 	 * ours to the same thing.
 	 */
 	hash_algo =3D hash_algo_by_ptr(transport_get_hash_algo(transport));
-	initialize_repository_version(hash_algo, 1);
+	initialize_repository_version(hash_algo, the_repository->ref_storage_form=
at, 1);
 	repo_set_hash_algo(the_repository, hash_algo);
 	create_reference_database(the_repository->ref_storage_format, NULL, 1);
=20
diff --git a/setup.c b/setup.c
index 3d980814bc..3aac8c01cd 100644
--- a/setup.c
+++ b/setup.c
@@ -592,6 +592,17 @@ static enum extension_result handle_extension(const ch=
ar *var,
 				     "extensions.objectformat", value);
 		data->hash_algo =3D format;
 		return EXTENSION_OK;
+	} else if (!strcmp(ext, "refstorage")) {
+		int format;
+
+		if (!value)
+			return config_error_nonbool(var);
+		format =3D ref_storage_format_by_name(value);
+		if (format =3D=3D REF_STORAGE_FORMAT_UNKNOWN)
+			return error(_("invalid value for '%s': '%s'"),
+				     "extensions.refstorage", value);
+		data->ref_storage_format =3D format;
+		return EXTENSION_OK;
 	}
 	return EXTENSION_UNKNOWN;
 }
@@ -1871,12 +1882,14 @@ static int needs_work_tree_config(const char *git_d=
ir, const char *work_tree)
 	return 1;
 }
=20
-void initialize_repository_version(int hash_algo, int reinit)
+void initialize_repository_version(int hash_algo, int ref_storage_format,
+				   int reinit)
 {
 	char repo_version_string[10];
 	int repo_version =3D GIT_REPO_VERSION;
=20
-	if (hash_algo !=3D GIT_HASH_SHA1)
+	if (hash_algo !=3D GIT_HASH_SHA1 ||
+	    ref_storage_format !=3D REF_STORAGE_FORMAT_FILES)
 		repo_version =3D GIT_REPO_VERSION_READ;
=20
 	/* This forces creation of new config file */
@@ -1889,6 +1902,10 @@ void initialize_repository_version(int hash_algo, in=
t reinit)
 			       hash_algos[hash_algo].name);
 	else if (reinit)
 		git_config_set_gently("extensions.objectformat", NULL);
+
+	if (ref_storage_format !=3D REF_STORAGE_FORMAT_FILES)
+		git_config_set("extensions.refstorage",
+			       ref_storage_format_to_name(ref_storage_format));
 }
=20
 static int is_reinit(void)
@@ -2030,7 +2047,7 @@ static int create_default_files(const char *template_=
path,
 		adjust_shared_perm(get_git_dir());
 	}
=20
-	initialize_repository_version(fmt->hash_algo, 0);
+	initialize_repository_version(fmt->hash_algo, fmt->ref_storage_format, 0);
=20
 	/* Check filemode trustability */
 	path =3D git_path_buf(&buf, "config");
diff --git a/setup.h b/setup.h
index 4927abf2cf..89033ae1d9 100644
--- a/setup.h
+++ b/setup.h
@@ -180,7 +180,8 @@ int init_db(const char *git_dir, const char *real_git_d=
ir,
 	    int ref_storage_format,
 	    const char *initial_branch, int init_shared_repository,
 	    unsigned int flags);
-void initialize_repository_version(int hash_algo, int reinit);
+void initialize_repository_version(int hash_algo, int ref_storage_format,
+				   int reinit);
 void create_reference_database(int ref_storage_format,
 			       const char *initial_branch, int quiet);
=20
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 2b78e3be47..38b3e4c39e 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -532,6 +532,32 @@ test_expect_success 'init rejects attempts to initiali=
ze with different hash' '
 	test_must_fail git -C sha256 init --object-format=3Dsha1
 '
=20
+test_expect_success DEFAULT_REPO_FORMAT 'extensions.refStorage is not allo=
wed with repo version 0' '
+	test_when_finished "rm -rf refstorage" &&
+	git init refstorage &&
+	git -C refstorage config extensions.refStorage files &&
+	test_must_fail git -C refstorage rev-parse 2>err &&
+	grep "repo version is 0, but v1-only extension found" err
+'
+
+test_expect_success DEFAULT_REPO_FORMAT 'extensions.refStorage with files =
backend' '
+	test_when_finished "rm -rf refstorage" &&
+	git init refstorage &&
+	git -C refstorage config core.repositoryformatversion 1 &&
+	git -C refstorage config extensions.refStorage files &&
+	test_commit -C refstorage A &&
+	git -C refstorage rev-parse --verify HEAD
+'
+
+test_expect_success DEFAULT_REPO_FORMAT 'extensions.refStorage with unknow=
n backend' '
+	test_when_finished "rm -rf refstorage" &&
+	git init refstorage &&
+	git -C refstorage config core.repositoryformatversion 1 &&
+	git -C refstorage config extensions.refStorage garbage &&
+	test_must_fail git -C refstorage rev-parse 2>err &&
+	grep "invalid value for ${SQ}extensions.refstorage${SQ}: ${SQ}garbage${SQ=
}" err
+'
+
 test_expect_success MINGW 'core.hidedotfiles =3D false' '
 	git config --global core.hidedotfiles false &&
 	rm -rf newdir &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index dc03f06b8e..4685cc3d48 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1937,7 +1937,7 @@ test_lazy_prereq SHA1 '
 '
=20
 test_lazy_prereq DEFAULT_REPO_FORMAT '
-	test_have_prereq SHA1
+	test_have_prereq SHA1,REFFILES
 '
=20
 # Ensure that no test accidentally triggers a Git command
--=20
2.43.GIT


--vYO936M3KdpiF/UR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRpwACgkQVbJhu7ck
PpReCw/7BhCNVXWRxPxTECIRdp2cY4vGbJtqgoyuZmqmmcsMzqnvOCirH3Mzf/A5
7dE2A6tY5MO/b1rUW77/RvHBjWULTtlCT+Vdc4yN0mW9jrUula0ANtqkq04FYGJG
pBuBBhQjXCnhz8E9OWspqhkj/US9+kMmE9TQU47/jLaabP1K/CWWB+fa1+ZLz39Q
Bz76/AXAVLVyHRSBtCWkI7d3w+k4k3HvOuiPXWcJ88CIxG2ywYoNYnYCZnBoOVC6
mGBHzmhcsnzlXR7+rxkkT7NpZYYg3t1388Lgf8ypC1j8GrDW/X7FCOwW6Rql+5A1
otb6yndCkemHrwab+OwB82QfA25prAnYhsMsKh38ANyBsSd3fLmQhfISJr2my41R
okjzprrNsV3m6UshK8DORFhdC9BNhpTTB+1yo8ZhfXlWvPPF1e4asZOGbkFM36A7
GXa6cb0LYTPEgXIMBEZqRBFEn8Wnw+vjSUX5+EpVF44f6jDfgTUZw7mU8WOHDaCe
vPU6JplhCgTad5Eoweq5PtyRqq8Mck4nTnflgHn3IpJS3uLoGsfjlDSnNIG3fMJ5
hubDYxGcc4LmcM+Dh9O4m/idDreSAvup5VCzVY18WqRzzSAtqxEQ7X11D52JnE92
GcydNTxFkAKL9NVejVXi3jcy6/zVtqTPZ8xUSDulBFiGmBSWtN8=
=HcGD
-----END PGP SIGNATURE-----

--vYO936M3KdpiF/UR--
