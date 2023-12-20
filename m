Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107A1219FE
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TTzn9Qgh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DJW5YEaw"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 629FF5C01DB
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 20 Dec 2023 05:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703069740; x=1703156140; bh=Ym98eHZLxx
	3xt98XHC2LIvE0+J3Xemu6myp0myEGudA=; b=TTzn9QghLtyKVi83YyLdVpe4He
	AhjMujm4liomjnzIxtTfvONZMlu+dU+X3dChb7IGxErlNmbADVvAaAxllMA3TMAs
	kDzK+ReHdg8L1C9BVyVyPfgK06zeT4uETCsR+IeFfvOiGltphnnqsrkkbpZz7R7q
	FMG4BoVgIkVpDFRVvCNWFDmynKA5OuTCHh1FiJiB8wqxedwZF+YdJivgD6wH8Sy3
	pYgE2zMVZevJq6nwCDAzHKCpMjJm16ySEmer5//4K6k+0sGNnoWqutFTjTqLd+cZ
	LA9+6s0FMYlFewmlmS2cpFBeGSPqe38IO4JOAeboZLYfQT/QnPy/Sgbkmrmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703069740; x=1703156140; bh=Ym98eHZLxx3xt98XHC2LIvE0+J3X
	emu6myp0myEGudA=; b=DJW5YEawf1wN7wYKfXa9qg2u+4iWW+0JoJd3JUiJXGhX
	78EeGm9fc8QAeNw+2dOZX3Cmb6P2HQcgE+mcNR8wG+H+hD4oC4aJS2ejRiHcnViV
	/pqnbSxddnn8VLBGCefX7P1CuGrFRpKHSofpmf0M8ujaO87TGtoCuXX8UI3fYot5
	qN1mXSTXwoHwsodWwdKLeEVdHw10aQeFOnUjfdyzz5gqG6WjFzX22h6q9dOr38eV
	6Vuz8XH3o9C1ZL/yu4ItiKyJzbjZQD9EETUtCFP8Z54C+Os8dlXYbeyfCvlMPVn5
	0NE4DqisB2+8V1HMvlin4OB6DS4M+zJCp09A9DBbOg==
X-ME-Sender: <xms:LMiCZTdoRGHTGZXAuV9gdpgvCGyCGBFDytyo6Sz8rPmB8wqPuqMvfg>
    <xme:LMiCZZPla-ys4CmEkpgnAC2svHDgmdtVPl7OdZoqubAiyyVrlNV8CpU6SgrGiYcEp
    l2a2ZYVp_XjZhN5Sw>
X-ME-Received: <xmr:LMiCZcgpF6_HCqazTF9-oc3PC40_ROX1OCBHcR2Z3vi85fCYEkncL3yq9vH_-yd6nOZv_uumpxXoYtgd_tz2SVwRMeBXddCQsOCF4ggX6I50xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:LMiCZU_mqZWFJC-sNv6--VrBdesrdr5uG_xJo96_PFUdcfl_8b4rZA>
    <xmx:LMiCZfvNWW2Zck_J_O--Nt5T-3_yuMHXDJezc__0vhgTub9mpWhIOw>
    <xmx:LMiCZTHSlkxvM2AblLzdKkkIWi4cRjSTcGUES0k5YDSal8z3sDEXMQ>
    <xmx:LMiCZc4XgmiEBOyqHQ-286r7AH43BHi59gjkAV8cAE23ib5BLeYWZA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 35c0f9fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 10:53:44 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:55:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 11/12] builtin/clone: introduce `--ref-format=` value flag
Message-ID: <71cf0ce82711189d8370ac47880f9e6cba0e06fd.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CeW5uLHo40M8eR7J"
Content-Disposition: inline
In-Reply-To: <cover.1703067989.git.ps@pks.im>


--CeW5uLHo40M8eR7J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new `--ref-format` value flag for git-clone(1) that allows
the user to specify the ref format that is to be used for a newly
initialized repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-clone.txt |  6 ++++++
 builtin/clone.c             | 12 +++++++++++-
 t/t5601-clone.sh            | 17 +++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index c37c4a37f7..6e43eb9c20 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -311,6 +311,12 @@ or `--mirror` is given)
 	The result is Git repository can be separated from working
 	tree.
=20
+--ref-format=3D<ref-format::
+
+Specify the given ref storage format for the repository. The valid values =
are:
++
+include::ref-storage-format.txt[]
+
 -j <n>::
 --jobs <n>::
 	The number of submodules fetched at the same time.
diff --git a/builtin/clone.c b/builtin/clone.c
index 20c161e94a..b635bbcb43 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -72,6 +72,7 @@ static char *remote_name =3D NULL;
 static char *option_branch =3D NULL;
 static struct string_list option_not =3D STRING_LIST_INIT_NODUP;
 static const char *real_git_dir;
+static const char *ref_format;
 static char *option_upload_pack =3D "git-upload-pack";
 static int option_verbosity;
 static int option_progress =3D -1;
@@ -157,6 +158,8 @@ static struct option builtin_clone_options[] =3D {
 		    N_("any cloned submodules will be shallow")),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 		   N_("separate git dir from working tree")),
+	OPT_STRING(0, "ref-format", &ref_format, N_("format"),
+		   N_("specify the reference format to use")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=3Dvalue"),
 			N_("set config inside the new repository")),
 	OPT_STRING_LIST(0, "server-option", &server_options,
@@ -930,6 +933,7 @@ int cmd_clone(int argc, const char **argv, const char *=
prefix)
 	int submodule_progress;
 	int filter_submodules =3D 0;
 	int hash_algo;
+	int ref_storage_format =3D REF_STORAGE_FORMAT_UNKNOWN;
 	const int do_not_override_repo_unix_permissions =3D -1;
=20
 	struct transport_ls_refs_options transport_ls_refs_options =3D
@@ -955,6 +959,12 @@ int cmd_clone(int argc, const char **argv, const char =
*prefix)
 	if (option_single_branch =3D=3D -1)
 		option_single_branch =3D deepen ? 1 : 0;
=20
+	if (ref_format) {
+		ref_storage_format =3D ref_storage_format_by_name(ref_format);
+		if (ref_storage_format =3D=3D REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format '%s'"), ref_format);
+	}
+
 	if (option_mirror)
 		option_bare =3D 1;
=20
@@ -1106,7 +1116,7 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 	 * their on-disk data structures.
 	 */
 	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN,
-		REF_STORAGE_FORMAT_UNKNOWN, NULL,
+		ref_storage_format, NULL,
 		do_not_override_repo_unix_permissions, INIT_DB_QUIET | INIT_DB_SKIP_REFD=
B);
=20
 	if (real_git_dir) {
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 47eae641f0..fb1b9c686d 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -157,6 +157,23 @@ test_expect_success 'clone --mirror does not repeat ta=
gs' '
=20
 '
=20
+test_expect_success 'clone with files ref format' '
+	test_when_finished "rm -rf ref-storage" &&
+	git clone --ref-format=3Dfiles --mirror src ref-storage &&
+	echo files >expect &&
+	git -C ref-storage rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone with garbage ref format' '
+	cat >expect <<-EOF &&
+	fatal: unknown ref storage format ${SQ}garbage${SQ}
+	EOF
+	test_must_fail git clone --ref-format=3Dgarbage --mirror src ref-storage =
2>err &&
+	test_cmp expect err &&
+	test_path_is_missing ref-storage
+'
+
 test_expect_success 'clone to destination with trailing /' '
=20
 	git clone src target-1/ &&
--=20
2.43.GIT


--CeW5uLHo40M8eR7J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCyCkACgkQVbJhu7ck
PpQf2hAAg49PNrhVOnn3TgJrbBajx/F5JOmMbmMd/H/pLtprybxrQT1M73EXxigl
O2LFtcJSH+TfccPwqU76o9PcK55Gg3+cH9I0s92wrhBhFMQgF2pFGDfR6lHIuFod
89VlUj/ZNqnPEoC+PsnkKxXbFVtqVyRQsLmyekoar/2uh3oxgjeW9wQhbLB5qxPv
HugB0C96i44fxO8ZLUoBegbI84FdJfnZmJp10OyGbVEdJMwpue92/uXiwESkN70T
vqteXWbSRpMcEqsth2D6iOoP3B9pgumtr0jnKYQ2iTt8hGbLd8/4lV74os4ewLrH
w1zpYGnpxpjCfkJr3gu/tt1vTgDUx6Iw7Z7OHv8ch6k0ufZizQ9iN6fPWfPzxIq1
++/QgfPE9iwv/Y8vNSeQzYpFfvZBZ+jK4wju1jXn7i7c6cYN+6EITFNdwPKJcgkE
P0A666eSOQqklCZIpZRd5CE6GG0QHFD34NgMpqYf2v95/vmLYfkjNGzOmiuUmIs9
9zbdGEH/tgAPY1FTiNERC+CnNYJFz+uNwKnEBN+wRmwVL4zD1XFcN31YfrVHS7YE
MkDpC+2jJsVvMTKnvjSAF8PMQomUN6vTXDVQu1vtXInvjTchY5zRToyiaC2zYhnj
yJL8Pom47V1JfIUrBe+p907D1XuDQQb1HEy7wrt/ebUNqGkzd+Q=
=sxnk
-----END PGP SIGNATURE-----

--CeW5uLHo40M8eR7J--
