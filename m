Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C98210EA
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jXoaS6Cm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="faJuVj/F"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 50C745C01B1
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 20 Dec 2023 05:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703069718; x=1703156118; bh=+TfR8nztU3
	CrYqXeSxfLMmB4yvmTd9gO897pDb2ctqQ=; b=jXoaS6CmwBKsYII3SllBeKTbyR
	oSkaSAOCFKa3sU+PnEXCF9fabuD6tlZ13eqvwdhUw8IplEZhmRl9+C8f1/grL0yw
	Ae13OKFkZaTMLrcTKdPLXN/L2CKLMlLwHFKc6tQ286yRESuBL3zt+jLQwLRe6/16
	64JwMM6Lyg8La9dsupEfKJU+pjmt1GCX7Cg8HoA2iI19JYXJdgzvW2BFCfX13ZYH
	1tDWybuytmlG2kS6y2/RPSCVD7uytObuyAaT7qjZTATVN9DZwxSten4ByhYQedWM
	g0DM0fQFp5oxOutyylR65EWTAsYPtdgrq3elme7/lkL2j4ikMs27l389W/Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703069718; x=1703156118; bh=+TfR8nztU3CrYqXeSxfLMmB4yvmT
	d9gO897pDb2ctqQ=; b=faJuVj/FlYAWIakMaHryaDLP9uh1AQ8jAhzPPMjdAEp/
	BG0aM6IGN68ASHyp5ujwmi/hOFvETS/IIb5urjzuBlwznvj1p6H8sWCjXl2yWolA
	GNq7+3F/355eFklLULYHgS7K1c4uNFjsfDQ/1WKKGpkFhhsdjrDHS+Z908uUAt2a
	DiLpiw81JGo56QRImMAb1HRKGIZdFjiR1IHovif0UAiSyYRAIh+ga46LnZu3MOOI
	NqLEzvyvQD6lPhkSSibXXWLKAZvmGVPl0s6m1PJ5/t07FvsHeyTb+2TSM8b1L9sD
	kV7sXTiqN1eMZYxB9XCktcKgOnHW294JeGS8SseB+A==
X-ME-Sender: <xms:FsiCZZ5TPiPeq-rgdLFM1qUIKP38URdfAQCJ4xVa8b9WOqZjfY20sA>
    <xme:FsiCZW6qR2K2jQM0YEFPivJeieLxbSNBP4-13FfHKYndy3iPHY6cZoMtTof41b3xo
    z6XPhS5oGmnU2YuTA>
X-ME-Received: <xmr:FsiCZQe9arSXzGrl_saECQq67sikCXbQVKo4ZuQMKbHgkOI2F7-XHgLnPmYGtP2UkUCG1W13-42O8La091i5e7YkOnSnnSqwD_7L8-Erl_rtAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:FsiCZSIynlB1BlmrMFe662UVmgsDmI-bgR6XTgDBhZX4KUIUVaZ1TQ>
    <xmx:FsiCZdKoAWRCLN0jhTiC1ka7z59h9Y2u6r01K85_t1MQfwVL920vkQ>
    <xmx:FsiCZbwp4FCI3z9CNd9cBXQp5RO7_tEwG2fiFWBXc78MoAUXV5jKIQ>
    <xmx:FsiCZQl9wZGJsM-U-mWLQIpFeFpsl0hktK60ROxFLxHTfImsWTFZ-w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0a1c34ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 10:53:22 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:55:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/12] setup: introduce "extensions.refStorage" extension
Message-ID: <beeb182f2844bd8a9e1f2a2767838282f705e0a2.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zTy7YmZoqThFtpoM"
Content-Disposition: inline
In-Reply-To: <cover.1703067989.git.ps@pks.im>


--zTy7YmZoqThFtpoM
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
index 6840064b59..20c161e94a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1289,7 +1289,7 @@ int cmd_clone(int argc, const char **argv, const char=
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
index 5dffea6e2f..7eb4ae8ea0 100644
--- a/setup.c
+++ b/setup.c
@@ -590,6 +590,17 @@ static enum extension_result handle_extension(const ch=
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
@@ -1869,12 +1880,14 @@ static int needs_work_tree_config(const char *git_d=
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
@@ -1887,6 +1900,10 @@ void initialize_repository_version(int hash_algo, in=
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
@@ -2028,7 +2045,7 @@ static int create_default_files(const char *template_=
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


--zTy7YmZoqThFtpoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCyBMACgkQVbJhu7ck
PpSTiA//Vks7IQW6bcH3sforU0FHcrwIzeYjd9e8oElhEU92n4M8cNHQjkxdkygp
SUt8oQ2pSM8fIaIEppFUpIHo39nlSsmjwxImVCTnfpHMehMNOPHXSeADGXIR+7XO
Lo/0Xire/zqDz2qKMInS3+vGBd+zo6y8WIMBSA3LHsNKZ77bIZBaY9FOCBvQ64qq
nRs6Tau3C3BPjh3bsnHB9L1jV9AG38NqLFH4qwCab8RZj+675dgM3rT6R6+cmGZ5
ju1APr+4Ig7HKjTL4Hb/r5aQ/VylUNoXI0GfFcrlMI6cU3qxRF4bCXtcqLmHFB/X
O+EzNVSNiT7PzU3payp+75Meu6wWxGeeUnU8nFDKUKVR8rIuXBSoOrg4I+oxgxnz
TJoNkutPeWeWRXErNK+HSgS/flTSA/K1mvEYGfNc8/iaUIskjCkP8cQOhbQ+amRm
hWCftekY/eQS8SfJQAzVgSNYUbRaqxySgpHeo3pr5KeldsYUP6uO8mChbJ3PPfgg
3zln5EQ6qfzu7XvmDBb383vF2BipI+KldUKjUiSe4ETvrlzZRXNsatVKF8gPDdg6
eaFzl23GEUXAw/PyZKInHpWSVqgzgN6s9tm19fbWatIWjNs+67CerL1TpXKTa3Eh
ejQ19qCJDc8U5d1drqtlnsHNehtgqTLaHEJNTsX7FCxd9/LGPeA=
=5J1i
-----END PGP SIGNATURE-----

--zTy7YmZoqThFtpoM--
