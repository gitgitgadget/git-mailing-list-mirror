Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2467464
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rMjoeB1s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OyY3g92D"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 9D4805C0082
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 05:00:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 28 Dec 2023 05:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757615; x=1703844015; bh=WTL4I6GSGW
	6hOjVZXEDcxr8lvd9yVthR5I0I15Z4c3k=; b=rMjoeB1s4xkCL6KoIpWhCN5bwE
	/V7i4EXCBKUv2qMaqmZsJP9F375ISfza2tPQYHsmJWf2Axc6DJYr192FPfS3V2Pl
	+xbZgJzPNhHDHKulmORtgSywhlfRm2nvX0YniBIVhuVERycFd4wq3NtV2psCGxix
	oxUixfk65jINB/Y4d0KWrS3uH8qlcmqH9KiwWJt1ppBQf0HpmHTHyeMjJXLuhwTf
	ebgDP9GOdih3imRy7PDHrtrdiLzISljS50YW6DOJL8O0Uz9RbSuHd5join0EnV+w
	oGEU4I/B33U0jjmNhCkhWHFBiP+TXpb9dd1VZJb9LqAfQfO5grnHeh7WmkUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757615; x=1703844015; bh=WTL4I6GSGW6hOjVZXEDcxr8lvd9y
	VthR5I0I15Z4c3k=; b=OyY3g92DCJBAc/K5qgHVQkWiJGwAU7Ti1qrcDi81EuLs
	W0NTeaZ1Q1QUwLzu/t6q3cx2rQv/3kyDF67Osg0gljwIMyjxNANIhHialCSNh7WS
	e+MLmC/x/PBWLiVx9uxQWOuqBEaxlgGHKCnHD1hUsx6Na6mKf+NHRWC04luQ4g8X
	Sya/XF15Yzv6mT8U/XOQyEv+DArVR2tQy36hBBPa1QY6I8+AnwUP9sAatnUXafeL
	rSc7Aam4hpV1uuWZHNbsaWrl8tGLzf+NZ5Y52s2SY53Vp2Ec7tudJqjka+v9Fhy6
	Ey7T2zP8PthcE6/fPbGuForIHifwEg6QwWoe31Mwfg==
X-ME-Sender: <xms:L0eNZdbxKZ16RO8SRqVyFf9gbetERIet5By0GX_ar1aqbVdQEcaK-g>
    <xme:L0eNZUZYYGfxz3zdI3LmC1sKY4_PqP6d3FGA7DRpOIG1YFXciH_UBVX6_A-63POFL
    MJZ8l9KbXIqszw9Dg>
X-ME-Received: <xmr:L0eNZf_RPJ8d8zMtwdlGEKQColhthPr1JZXYDgqq7AQGbMVLJaOge1wp1skoKfdS9Gh3g6RtW0VdbVuNYwNPkNtwP10Lfl_9OKLgEA39DCI8SQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:L0eNZbrvh28RsR2-Yu4KYoYaRgjishvMDsE55SBkbHP_am4t_oD7bA>
    <xmx:L0eNZYry_SXKn27hbLuhvspZSdfR4jcciWaZgtBE1iC2aZQpCM9FqA>
    <xmx:L0eNZRTdJhmVOlYU7lNZiaYIXN4xAIF6GRChD3e3qCWEUl1dPgFldQ>
    <xmx:L0eNZeENIdbE4yJmPAQ3IPgxAunHwIIOuJCNR6pDC7UmUyMDtegV9w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 28 Dec 2023 05:00:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8ce601bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 28 Dec 2023 09:58:01 +0000 (UTC)
Date: Thu, 28 Dec 2023 11:00:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/6] builtin/worktree: create refdb via ref backend
Message-ID: <aae969301fa6792263d32362b36d071de4f6ed94.1703754513.git.ps@pks.im>
References: <cover.1703754513.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fPC7WaTvJ9DF1WJF"
Content-Disposition: inline
In-Reply-To: <cover.1703754513.git.ps@pks.im>


--fPC7WaTvJ9DF1WJF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When creating a worktree we create the worktree's ref database manually
by first writing a "HEAD" file so that the directory is recognized as a
Git repository by other commands, and then running git-update-ref(1) or
git-symbolic-ref(1) to write the actual value. But while this is fine
for the files backend, this logic simply assumes too much about how the
ref backend works and will leave behind an invalid ref database once any
other ref backend lands.

Refactor the code to instead use `refs_init_db()` to initialize the ref
database so that git-worktree(1) itself does not need to know about how
to initialize it. This will allow future ref backends to customize how
the per-worktree ref database is set up. Furthermore, as we now already
have a worktree ref store around, we can also avoid spawning external
commands to write the HEAD reference and instead use the refs API to do
so.

Note that we do not have an equivalent to passing the `--quiet` flag to
git-symbolic-ref(1) as we did before. This flag does not have an effect
anyway though, as git-symbolic-ref(1) only honors it when reading a
symref, but never when writing one.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/worktree.c | 48 +++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 58937a2a68..9d935bee84 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -416,7 +416,6 @@ static int add_worktree(const char *path, const char *r=
efname,
 	struct strbuf sb_git =3D STRBUF_INIT, sb_repo =3D STRBUF_INIT;
 	struct strbuf sb =3D STRBUF_INIT, realpath =3D STRBUF_INIT;
 	const char *name;
-	struct child_process cp =3D CHILD_PROCESS_INIT;
 	struct strvec child_env =3D STRVEC_INIT;
 	unsigned int counter =3D 0;
 	int len, ret;
@@ -424,7 +423,8 @@ static int add_worktree(const char *path, const char *r=
efname,
 	struct commit *commit =3D NULL;
 	int is_branch =3D 0;
 	struct strbuf sb_name =3D STRBUF_INIT;
-	struct worktree **worktrees;
+	struct worktree **worktrees, *wt =3D NULL;
+	struct ref_store *wt_refs;
=20
 	worktrees =3D get_worktrees();
 	check_candidate_path(path, opts->force, worktrees, "add");
@@ -500,15 +500,26 @@ static int add_worktree(const char *path, const char =
*refname,
 	write_file(sb.buf, "../..");
=20
 	/*
-	 * This is to keep resolve_ref() happy. We need a valid HEAD
-	 * or is_git_directory() will reject the directory. Any value which
-	 * looks like an object ID will do since it will be immediately
-	 * replaced by the symbolic-ref or update-ref invocation in the new
-	 * worktree.
+	 * Set up the ref store of the worktree and create the HEAD reference.
 	 */
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, "%s", oid_to_hex(null_oid()));
+	wt =3D get_linked_worktree(name);
+	if (!wt) {
+		ret =3D error(_("could not find created worktree '%s'"), name);
+		goto done;
+	}
+	wt_refs =3D get_worktree_ref_store(wt);
+
+	ret =3D refs_init_db(wt_refs, REFS_INIT_DB_IS_WORKTREE, &sb);
+	if (ret)
+		goto done;
+
+	if (!is_branch && commit)
+		ret =3D refs_update_ref(wt_refs, NULL, "HEAD", &commit->object.oid,
+				      NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+	else
+		ret =3D refs_create_symref(wt_refs, "HEAD", symref.buf, NULL);
+	if (ret)
+		goto done;
=20
 	/*
 	 * If the current worktree has sparse-checkout enabled, then copy
@@ -527,22 +538,6 @@ static int add_worktree(const char *path, const char *=
refname,
=20
 	strvec_pushf(&child_env, "%s=3D%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	strvec_pushf(&child_env, "%s=3D%s", GIT_WORK_TREE_ENVIRONMENT, path);
-	cp.git_cmd =3D 1;
-
-	if (!is_branch && commit) {
-		strvec_pushl(&cp.args, "update-ref", "HEAD",
-			     oid_to_hex(&commit->object.oid), NULL);
-	} else {
-		strvec_pushl(&cp.args, "symbolic-ref", "HEAD",
-			     symref.buf, NULL);
-		if (opts->quiet)
-			strvec_push(&cp.args, "--quiet");
-	}
-
-	strvec_pushv(&cp.env, child_env.v);
-	ret =3D run_command(&cp);
-	if (ret)
-		goto done;
=20
 	if (opts->orphan &&
 	    (ret =3D make_worktree_orphan(refname, opts, &child_env)))
@@ -588,6 +583,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 	strbuf_release(&sb_git);
 	strbuf_release(&sb_name);
 	strbuf_release(&realpath);
+	free_worktree(wt);
 	return ret;
 }
=20
--=20
2.43.GIT


--fPC7WaTvJ9DF1WJF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRywACgkQVbJhu7ck
PpSv8hAAngMmnVdcbth6RUG+INJVakH6PMKB6w9QhCJv3zOQashYogkPGigMHWAW
ejLzqmCRBgvOzxiDbm00OIQSsIHBlZex27pJLn0Km8eyftHd4ysO6/8vJk3LKRtm
9xbmWTMKOdrOpIzLyJLpvUkYC1pcK9sl/u+hL4Oh8q/KxIduwn7AMRtfCssb6s0v
Fu3Wj+hqmRfbwyhSE0cwJyhA+dRXX+fyYgTGiLAlWIJnkMjVVdfClGjJMrhIjsxN
N+ds63WmtMPHAbFjZ2NXzJGQntdJpjkrpuLGVM93m+8XEC3EcvZFMZOenr7CZlE/
kZY9Gya/YCbfNiUqMpyxfiY8uNIb9y3fzOWi0K5THqKo+rkTYukywXOXOSw77g9K
gx7fA/UeNIBmdvLBRCogY4VxFOr9csrIXbpakLxrK1z560XeXUgD4SLIIzVrnKs7
j692tH5tuJVzGUFZNwT77LS14PIx1ZhUtYLhiDZhB0zAbUchpIubecIauqy41TD+
NIp9vHBO4KHvzxawVmZI7WIry8nHewz69SIDiQcOPXOljAjIwEROuCGzYnogzf06
su3PUpGRfxMYmzs0W7lzx4kGW/lmGsGe3Xp1WMvZo1BvLgYcN1+eiFVGpPMBnd+3
JPA2FdebLtyquvGTmiJcTTwn7cVhCaflOi0nyjuAwaVy45Lkuvg=
=u6iw
-----END PGP SIGNATURE-----

--fPC7WaTvJ9DF1WJF--
