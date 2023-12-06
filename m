Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HPeS6G19";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G+6FJ5Ga"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209FC181
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 04:39:52 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 2F3365C0296
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 07:39:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 06 Dec 2023 07:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701866391; x=1701952791; bh=mD
	WPZ/dPwJZR775DsjlLpFpvUIiKFd5MWq2ju+gi9bY=; b=HPeS6G193lQ5muDar0
	jWedj5hgvGaBb5xmhaAvi5F3jLGSwIVyZ2autyNNHdHGroQdFvONGDJUap+Eh50L
	NoxQnMb27VsNM8rfHLNSNTW6yKYEIeKwD+a+qbEXKsNlgAmT0oW2Nc5RRX8yAcAM
	LiKlrlH0pahZwN7IYlW2uVfJS5vuuBMOJ1TPOwy0D8uXCu7m3pyUGC6NrlUQxXGt
	XDGFmXib7eCDyHymKf8UbPutcyNjn8Z9nET0HaRosI0Lu57qImG+j1UDQ9mC+sGw
	YpaifYypzr5Fc04JVqUWxgLwfy6cLgxTBBl3MmL7yhnGctk6O3LczUBaOy3ZOGjf
	h+ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701866391; x=1701952791; bh=mDWPZ/dPwJZR7
	75DsjlLpFpvUIiKFd5MWq2ju+gi9bY=; b=G+6FJ5GaGK65mlISOtsUZyWiK5fPj
	Fi69427q+sDR/db0BN1YXrUUMHw4dM+Pl+MWzd+bLkvGTnc+IcApxecoQ9U+lexS
	/PzjVKQVZZ5NXrP334/4cYxys3Lx/6DHsgaiaJ32w6KCIjvCD+xBa8suXkDwHdEN
	omQArWKbKDRbrpme8IoYcrMjQ/0nP4NoeHys9t/mFCwNvu+NI5hz2S2SgIctUgDy
	nfO4FYxAz+jq1OpJ0qZCg6eskdPB0wKjhvHUcKN45ucP9BPYNqsPrAKfqaLQg+Uk
	uOeCrj6q2R0RC/vSHiHWb0K/y2gMNDzvgWrEnvG3aEWnHqkumAbLgT6rQ==
X-ME-Sender: <xms:lmtwZUww4kj7ZF4EComw3woJXlRHb_4XzaInmqeSfOmHRkbP54vBPg>
    <xme:lmtwZYT0uPVQfejf1aRZHoICuOlAMCh6vke0bM8_GKL71Vv05rBCE4A-7FrditxWA
    zNQgEOAkpV9xV1ppQ>
X-ME-Received: <xmr:lmtwZWUMf6TeynGoURy4ua6ANWFWD6iPVVrw-r8v7wOI-sP64y31YPx8r5GnR2jKKz3s3GHBxSB4mQ5xgDe1AlOyltoADUpdbArjLzJu4bhxot8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:l2twZShxOnd-8WBBh_sSx26E9pcmc1f0l5VWE01-d2H9y9sUYe6Gtg>
    <xmx:l2twZWDir4JmNQikDYCyuLZVxhnfxegQ4O1aukyb2Kb0lT1HF0-vaw>
    <xmx:l2twZTI_rBtJ9yr83e5DDg18JcvKckPl-AsIL3wcK_6gNVN6Kqa0Fg>
    <xmx:l2twZd-zjU9D9ZDlwO4i8_Wkn3XjhH5fv8QCO55z-GDGJ3R0Kud0yw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Dec 2023 07:39:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9cbcade1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Dec 2023 12:38:24 +0000 (UTC)
Date: Wed, 6 Dec 2023 13:39:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/7] setup: extract function to create the refdb
Message-ID: <b69c57d27269c9b40c9e4394861dffd8a8b9860c.1701863960.git.ps@pks.im>
References: <cover.1701863960.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A7PtXxPuwBq8s3fE"
Content-Disposition: inline
In-Reply-To: <cover.1701863960.git.ps@pks.im>


--A7PtXxPuwBq8s3fE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to let callers skip creation of the reference database when
calling `init_db()`. Extract the logic into a standalone function so
that it becomes easier to do this refactoring.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 95 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 38 deletions(-)

diff --git a/setup.c b/setup.c
index fc592dc6dd..9fcb64159f 100644
--- a/setup.c
+++ b/setup.c
@@ -1885,6 +1885,60 @@ void initialize_repository_version(int hash_algo, in=
t reinit)
 		git_config_set_gently("extensions.objectformat", NULL);
 }
=20
+static int is_reinit(void)
+{
+	struct strbuf buf =3D STRBUF_INIT;
+	char junk[2];
+	int ret;
+
+	git_path_buf(&buf, "HEAD");
+	ret =3D !access(buf.buf, R_OK) || readlink(buf.buf, junk, sizeof(junk) - =
1) !=3D -1;
+	strbuf_release(&buf);
+	return ret;
+}
+
+static void create_reference_database(const char *initial_branch, int quie=
t)
+{
+	struct strbuf err =3D STRBUF_INIT;
+	int reinit =3D is_reinit();
+
+	/*
+	 * We need to create a "refs" dir in any case so that older
+	 * versions of git can tell that this is a repository.
+	 */
+	safe_create_dir(git_path("refs"), 1);
+	adjust_shared_perm(git_path("refs"));
+
+	if (refs_init_db(&err))
+		die("failed to set up refs db: %s", err.buf);
+
+	/*
+	 * Point the HEAD symref to the initial branch with if HEAD does
+	 * not yet exist.
+	 */
+	if (!reinit) {
+		char *ref;
+
+		if (!initial_branch)
+			initial_branch =3D git_default_branch_name(quiet);
+
+		ref =3D xstrfmt("refs/heads/%s", initial_branch);
+		if (check_refname_format(ref, 0) < 0)
+			die(_("invalid initial branch name: '%s'"),
+			    initial_branch);
+
+		if (create_symref("HEAD", ref, NULL) < 0)
+			exit(1);
+		free(ref);
+	}
+
+	if (reinit && initial_branch)
+		warning(_("re-init: ignored --initial-branch=3D%s"),
+			initial_branch);
+
+	strbuf_release(&err);
+}
+
 static int create_default_files(const char *template_path,
 				const char *original_git_dir,
 				const char *initial_branch,
@@ -1896,10 +1950,8 @@ static int create_default_files(const char *template=
_path,
 	struct stat st1;
 	struct strbuf buf =3D STRBUF_INIT;
 	char *path;
-	char junk[2];
 	int reinit;
 	int filemode;
-	struct strbuf err =3D STRBUF_INIT;
 	const char *init_template_dir =3D NULL;
 	const char *work_tree =3D get_git_work_tree();
=20
@@ -1919,6 +1971,8 @@ static int create_default_files(const char *template_=
path,
 	reset_shared_repository();
 	git_config(git_default_config, NULL);
=20
+	reinit =3D is_reinit();
+
 	/*
 	 * We must make sure command-line options continue to override any
 	 * values we might have just re-read from the config.
@@ -1962,39 +2016,7 @@ static int create_default_files(const char *template=
_path,
 		adjust_shared_perm(get_git_dir());
 	}
=20
-	/*
-	 * We need to create a "refs" dir in any case so that older
-	 * versions of git can tell that this is a repository.
-	 */
-	safe_create_dir(git_path("refs"), 1);
-	adjust_shared_perm(git_path("refs"));
-
-	if (refs_init_db(&err))
-		die("failed to set up refs db: %s", err.buf);
-
-	/*
-	 * Point the HEAD symref to the initial branch with if HEAD does
-	 * not yet exist.
-	 */
-	path =3D git_path_buf(&buf, "HEAD");
-	reinit =3D (!access(path, R_OK)
-		  || readlink(path, junk, sizeof(junk)-1) !=3D -1);
-	if (!reinit) {
-		char *ref;
-
-		if (!initial_branch)
-			initial_branch =3D git_default_branch_name(quiet);
-
-		ref =3D xstrfmt("refs/heads/%s", initial_branch);
-		if (check_refname_format(ref, 0) < 0)
-			die(_("invalid initial branch name: '%s'"),
-			    initial_branch);
-
-		if (create_symref("HEAD", ref, NULL) < 0)
-			exit(1);
-		free(ref);
-	}
-
+	create_reference_database(initial_branch, quiet);
 	initialize_repository_version(fmt->hash_algo, 0);
=20
 	/* Check filemode trustability */
@@ -2158,9 +2180,6 @@ int init_db(const char *git_dir, const char *real_git=
_dir,
 				      prev_bare_repository,
 				      init_shared_repository,
 				      flags & INIT_DB_QUIET);
-	if (reinit && initial_branch)
-		warning(_("re-init: ignored --initial-branch=3D%s"),
-			initial_branch);
=20
 	create_object_directory();
=20
--=20
2.43.0


--A7PtXxPuwBq8s3fE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVwa5MACgkQVbJhu7ck
PpTIlQ//cvY9kQNAjw4pDRi0BzsviXljt3muWaIBzHFNccwNrGQ1kti1yKn5UYph
BZx0w9VFRHs/CpQ2aCK/DlBMhCUKW0nfIvF40Z3mkgGUrvenBJetCuBlLPUC9utp
2UGk0U59ZSvZysjf0oXUuXkvqHWBotWWgoV6IRQRey/rEXNJSVi7QMtLwFlnqWBf
3Fhc5/Jwfy9ccthulLZw+BJtAk1EAkvkEcB3ycyIZeakJxlGys7oxKb/t5P2PI8Q
mSrOjNb7Aa+6pBXuOGrf+eKYp5HVtCBWE5y085mvCuLMg2BIasSQZmQUNaK2XqHM
RevySc2elua3lYMvyR+lhwzNH+C7Pt1TrEKXtEqQT/WMbo+WkuT6uw8qm7wArYdy
6agBS37JUQEA9OLSjhOOIw+khhKqeInWijWbwRuiMlpJ/fpX+E26dEI8xnRmlgAC
PrlzISbUwwoBMPk08Xpvj0HL3cvSm+ENBLip9PoBPkzYdWA4pbJI70W0g5fSXVNm
Dl88/87WcI5UK9CDjCqRMAEVTPjMqZeh78CA5bIvV4fcF2/B0Xn34fKkhsT15a6B
mIGTQrUaK0CiCHe3YJ9Rmv/cHnseYx+zqN/H8sDmm6iqej4k13QC3HyhIlUz0MHK
yMelZMec0UVfkr/xEYYQmWlYv1xnb1qJmB5TtLFZ8GRwOznGqnQ=
=B6US
-----END PGP SIGNATURE-----

--A7PtXxPuwBq8s3fE--
