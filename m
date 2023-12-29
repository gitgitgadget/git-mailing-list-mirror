Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B908F59
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B5u4cFHu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V4sVipYK"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 90F895C0170;
	Fri, 29 Dec 2023 02:26:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 29 Dec 2023 02:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703834810; x=1703921210; bh=o8cMWsPtNg
	wKO9lF7H9GvVJUP3uJaKddu4q2qaUCN7Y=; b=B5u4cFHuqq82OUfNpYi7vjK7tj
	od0nUFoUhl5cXjZ24MryEJl2ahuc/CXb57Bp9RYWCisjg6K0xc4D/hbbi+b4xb1h
	OY3fLA3Hjxu5UU/YoJNDpA3u2EKyeQlhkPferGYWA7qeWI99Z1JWga1dgben3NnR
	JH2vXQ6T8DMVj9zJQjqYy18L0GR1sF80EWddV9YJc6I3ECCx0TDmHs8Fhkq6NjOv
	nu6RIs72EIMlJExUfPyZYEjnsRw7lQHHCFX7YkMl4E+b+7QmmaH3BAWeB1/kPi3Q
	GCTx9NoL/eaolfsP8bDZiQ2c6jrFpkD3a1GxXlwx4yafhU6eFamHCmhc0iSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703834810; x=1703921210; bh=o8cMWsPtNgwKO9lF7H9GvVJUP3uJ
	aKddu4q2qaUCN7Y=; b=V4sVipYKA4Yz7dOIMByXrJzOnvFu12xziet4L9kLASAD
	gE1ntrEV/Wy7KO6lKiq02Ddvn7ZgT29SMk+1CHTuWXL4bR1Z7HmxNe5BFSqyMILj
	qx8sEIWEesgJFYEnkBsgK6o4Vf0MxX+NKto8bcfJGMkl8bMWPfOP65cn1rRl6Yty
	032x/B0hufFgpqwcH7P3Si/2CoaRwdCt1vzyHtGjc1ZRKRS+4lrpy5A4Lru9OlSo
	vk4W1RVr4U8Rt7BbfjcW6RH1icbBHl0ogthzUzeJEkFfAjQr0tJ4RBd7Bm5KoQDR
	wz2WrJiBfY5GQZSXWi57KTHwuJVAK0YRovGZlKeayg==
X-ME-Sender: <xms:unSOZU_Bo0UOuXJNmlxbpoUOltxvDlg6geMhMt62dbI8K2m4Ck5jAQ>
    <xme:unSOZctkMMUGtKzS1nmT4QzNa6FrLeFiPK8GSkNZjQ24z01sVfgs99UZJW_0GqILd
    DMQiWfXtDFYKeYcfw>
X-ME-Received: <xmr:unSOZaCkrVyttPYCEnxDlPEjNVT0BJ8-owDilLuDt3bCxDCXgosWJ4NPeoVhqokpi3m315nlHt19TR0HLQ31ml1ec6MwkvhW6CueLSBIxVgTykz5mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:unSOZUdEOkBJ08zSC24WbUuNsk1pwUMM6-d2NXAYIHnageuIRoi2Bg>
    <xmx:unSOZZOg3nF3I1kIUa2N4m39D1mzqFaJDnucXzzCcuPco5_-XK-z8Q>
    <xmx:unSOZekMeYKqQS1Qfd8hZ0Hp9etxV-TpKQ5OuGpPdCyzRsDxpiQVZw>
    <xmx:unSOZSYNeDIC_X76UWBkuNHuHMLchUVdYVJjnDX8fVaPMEuUSeJf2A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Dec 2023 02:26:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cc43ae1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 29 Dec 2023 07:24:33 +0000 (UTC)
Date: Fri, 29 Dec 2023 08:26:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 06/12] setup: introduce "extensions.refStorage" extension
Message-ID: <a1e03e4392d77113f5a8b82f68956b71d37cdd26.1703833819.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703833818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fwZvK2CcBXFEWs8F"
Content-Disposition: inline
In-Reply-To: <cover.1703833818.git.ps@pks.im>


--fwZvK2CcBXFEWs8F
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
 setup.c                                       | 24 ++++++++++++++---
 setup.h                                       |  4 ++-
 t/t0001-init.sh                               | 26 +++++++++++++++++++
 t/test-lib.sh                                 |  2 +-
 8 files changed, 69 insertions(+), 6 deletions(-)
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
index 49570e6b3a..fb1413cabd 100644
--- a/setup.c
+++ b/setup.c
@@ -592,6 +592,17 @@ static enum extension_result handle_extension(const ch=
ar *var,
 				     "extensions.objectformat", value);
 		data->hash_algo =3D format;
 		return EXTENSION_OK;
+	} else if (!strcmp(ext, "refstorage")) {
+		unsigned int format;
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
@@ -1871,12 +1882,15 @@ static int needs_work_tree_config(const char *git_d=
ir, const char *work_tree)
 	return 1;
 }
=20
-void initialize_repository_version(int hash_algo, int reinit)
+void initialize_repository_version(int hash_algo,
+				   unsigned int ref_storage_format,
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
@@ -1889,6 +1903,10 @@ void initialize_repository_version(int hash_algo, in=
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
@@ -2030,7 +2048,7 @@ static int create_default_files(const char *template_=
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
index 3d3eda7967..3599aec93c 100644
--- a/setup.h
+++ b/setup.h
@@ -180,7 +180,9 @@ int init_db(const char *git_dir, const char *real_git_d=
ir,
 	    unsigned int ref_storage_format,
 	    const char *initial_branch, int init_shared_repository,
 	    unsigned int flags);
-void initialize_repository_version(int hash_algo, int reinit);
+void initialize_repository_version(int hash_algo,
+				   unsigned int ref_storage_format,
+				   int reinit);
 void create_reference_database(unsigned int ref_storage_format,
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


--fwZvK2CcBXFEWs8F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWOdLYACgkQVbJhu7ck
PpSocg/6AjxdY7bUXNse1gJV0WGH1T3CE3MCe9ktENYEkhhS8Cz45Akq5/dVzjJe
ewIhGLD3GdeCviW0HN12ps078QjQWComMdLJddRomBHbzMFC3IvjSbHD92z0Gvcu
hsSgURDXsDe/om3raVIpYgixhs6FnTnXeKicagi65DkHucQ+IpGKkVmBW6bh/PaY
8zolMtntLDCcgpwWbg4DPbHoJr+ERIlCF3IejFL1Xj373bpURJZhxf26CHyGhfC4
otrxRXIm8oYIFJY6GuOxEffIG7xNt6PHIl+nfDJ87skJXEy5Eo6xIs5e1oXKmCfM
BiMH7PJS7WWQ/+sxTRDkFDqXZ3lqhJEgmOg+3vEGmyHHDJxJ0IW9E/RLx8m1b5Dh
MfTrBotx+rnJpg40ufor1WzhAOoA/oyGJICO2UwOboyTlLQAY6LiSEy3WktgWgd5
g/04iwPWhK93+9kzzxFnUCBrhtxNOhiNZ+MbZUnMtsqliSCW6peDPuLGDSKALsLH
q77ICId7ApR48EhfuL2xB8RGEXFX3ur0mxZv0kxAX3GsjuqzGfni+i0mDw5MhPTz
4C8gnaptgg99BwXeXi5yYEpmyZ3Dk+QC5YMpKwKAkvxkVhD+dr6Hg3l3maEqkXoA
8ON5b/VS+oo2sAP4xlfzrJaSa6o6MLlAdA/rNVAr07uk9w2h7w8=
=oGd8
-----END PGP SIGNATURE-----

--fwZvK2CcBXFEWs8F--
