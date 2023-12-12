Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SuD/ujgI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UQFlQJKg"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A68BF
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 23:00:45 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 968E83200B0D
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 02:00:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 12 Dec 2023 02:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702364444; x=1702450844; bh=RVCFxbqxGG
	igBFmpRxUNARlaKsM2nm5sEe/v4bUe39I=; b=SuD/ujgIy1TLMqJJhHs6EEa/LR
	OB/X2OgGmTjg2NU/6O0exdanFE5qWJKs8BT/ok3u4s/ATfFJ+FiiZbysZjEGm4O/
	5Jye1k8JyaS0Kgj3Fh6iYOCVlu8XLhJxImiza/W56EIq8uhO7WE2a3FzoGIjn6ja
	UEIscx8uSLpCK/ZEAi1EaQeBEgY25UFZD57tF2GakpPybMSnjlP6EvD8aOuhkeFQ
	VhjmHgYVBpOyDg7K/WUZhwg/jpMr0pS4kmqJXx7qa9Ah2jvt2RQmTaaBeSKfwBVH
	Th7glpwBVnF60YCQZQcefyXhg78j6ljYN6XnT/vGY7SW3snVqNLqhqw5lHmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702364444; x=1702450844; bh=RVCFxbqxGGigBFmpRxUNARlaKsM2
	nm5sEe/v4bUe39I=; b=UQFlQJKgY/bwqk924Q9GqLpo8qstGGWdnaRNuft1dUTR
	WD1fQXf0+AYnmPrcSdxRIw4rEvnWkRqS57jgbRFkHnzx6nfYLdwwQ1NR7sSX+h80
	265DAhXFDhuK+TkxnrJGx7owH2bu9pJrRlaLENxw1agclGZvUFkShg/GX5Ro/pB7
	3mxhBxe/VTMEEp1hoqMG8UQAxR2j6oVJXOSgu6Qif7QMvlZl453ptkonebQG+vPt
	Oj2WcaCSYdCpkzEFOXhHFxW4UxwVVOsqY/A1NkT+FzgpjmVaZc4UCVJ+CX9QAyzo
	674k4KH4kTKIPRsPjqQFudyn+Mmxwm43IPt/9PEH8A==
X-ME-Sender: <xms:GwV4ZV_1C5_Zgi4bNndH46E7TlQ61rFo500pyIteNSXQZ8cBCk7USw>
    <xme:GwV4ZZvvFFT4SH23gu7VW4CoOBiH7u0aeEY9yvzOUR7BxwkWhIVek1duuALK4PWUA
    v50qs40s_NIsBfIBA>
X-ME-Received: <xmr:GwV4ZTCfc-DzepclgNBz72GOlRJAJysrCvCGVq0Glk3kJu2wmvxv4lYUnuEu1GqTpPSkggps2A_iqadC-rYaYQGgQk2mHcg8h6p9xyY7Ln96oWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:GwV4ZZdTYxcpe4z0E5F0tH9cH-BrMrM_RX9ZmSvyX4s4ApZq2OX6AA>
    <xmx:GwV4ZaMF3G9uCecyS5rl7FMscAc6v9QrKQ6vbu0VcylltyElZqtAGQ>
    <xmx:GwV4Zbl06VrZxCQ08JbtWEfLPM6oOujIp_kF6AZfAEq5DbgqsXfGTw>
    <xmx:HAV4ZdZary1BH5IEKa_-BsQHY5CL5Jm6ubQLQNyPrkguIdOAL5Hoyw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 12 Dec 2023 02:00:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 849dabb8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 12 Dec 2023 06:59:04 +0000 (UTC)
Date: Tue, 12 Dec 2023 08:00:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH v2 1/7] setup: extract function to create the refdb
Message-ID: <2f34daa0823ccb5cfee355758ee00da22bb17c03.1702361370.git.ps@pks.im>
References: <cover.1701863960.git.ps@pks.im>
 <cover.1702361370.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h8uuinG8oIvCLpJg"
Content-Disposition: inline
In-Reply-To: <cover.1702361370.git.ps@pks.im>


--h8uuinG8oIvCLpJg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to let callers skip creation of the reference database when
calling `init_db()`. Extract the logic into a standalone function so
that it becomes easier to do this refactoring.

While at it, expand the comment that explains why we always create the
"refs/" directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 103 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 65 insertions(+), 38 deletions(-)

diff --git a/setup.c b/setup.c
index fc592dc6dd..865cfe6743 100644
--- a/setup.c
+++ b/setup.c
@@ -1885,6 +1885,68 @@ void initialize_repository_version(int hash_algo, in=
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
+	 * We need to create a "refs" dir in any case so that older versions of
+	 * Git can tell that this is a repository. This serves two main purposes:
+	 *
+	 * - Clients will know to stop walking the parent-directory chain when
+	 *   detecting the Git repository. Otherwise they may end up detecting
+	 *   a Git repository in a parent directory instead.
+	 *
+	 * - Instead of failing to detect a repository with unknown reference
+	 *   format altogether, old clients will print an error saying that
+	 *   they do not understand the reference format extension.
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
@@ -1896,10 +1958,8 @@ static int create_default_files(const char *template=
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
@@ -1919,6 +1979,8 @@ static int create_default_files(const char *template_=
path,
 	reset_shared_repository();
 	git_config(git_default_config, NULL);
=20
+	reinit =3D is_reinit();
+
 	/*
 	 * We must make sure command-line options continue to override any
 	 * values we might have just re-read from the config.
@@ -1962,39 +2024,7 @@ static int create_default_files(const char *template=
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
@@ -2158,9 +2188,6 @@ int init_db(const char *git_dir, const char *real_git=
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
2.43.GIT


--h8uuinG8oIvCLpJg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV4BRgACgkQVbJhu7ck
PpRJ+g//SMNAn7IH3316yz0ldhy7fdM8olukN1NMICceTfB9h7+Vaz2X2rrLBfdZ
Ue3MKuvgXNbreVXU81Qs+Jbeb5Cs5MoRGo2qoh01ZlQnBpnjuCmZ07djrRBfQho5
7KZvJIJtd+sAQGIXPPqaPYrodAxNjvPPJkYsQeU96qb+rx0bFON3uGGsW0whdnOS
M3BN4OCcYUCsQcLPhB4/RXMNlZs7kPl/8je4b7e++hLFQiDugl3b+ixahe1sl0S/
Y3Qskohzz1sw3eDVIEeX01rixI4qONcQthIU50Ajt814Z/PscUTS8W+eDyDLqfAp
2iHxKXuh19Vi/wNEnc1RR9GPRWioTypImehhF7mXWkMt+xCE5HTxOg6i2+eLi1o1
O5UguiPTiJ905qDrSur9i2SJg37RZu1etguvsfLcvp2cerdlkfgILEogCM7k4kV2
qt29K5XIct99qF2zm1t3nBldryw1H63NmabTyxx+MEqYkZua+xfLcpgFVUtmadJP
3yNJ1TgTxyL6lQieMsFD8i54Miq9yPK4LdQ+uF3EXCHGwsQtbB4Ppd5d1bm99ZzY
hcRAb/NYw+yRobyDPZVXIHjtBNrNP0tmjQ9l3Qs8MlykXA08rzAwV47YM5R8q1IJ
62NaFx02hYdKR/VkHS/wffNkWsd1TgmOdYDwG/VVbarGwumTdC0=
=2Dxi
-----END PGP SIGNATURE-----

--h8uuinG8oIvCLpJg--
