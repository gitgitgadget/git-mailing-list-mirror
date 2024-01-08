Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C4210F2
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gkeKAhtc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S1qSJJOK"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id E893C5C17C3;
	Mon,  8 Jan 2024 05:05:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 08 Jan 2024 05:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704708350; x=1704794750; bh=gX7stEsAK4
	V1XFenI/L6h4u3PJkj3hggP8LgwP3VYis=; b=gkeKAhtcdS8eLoMXqzZVHgRWOQ
	KkgRVYjmLm6GPR5YrEz/XAAZUFb2nvS9mPmSjMlSdxXVYFCKlVrUTDOOmr+4mtUJ
	AuT269txnkqPAK6VAes9ZRXus8YklZaYtIHOibCduy3wkQQg+Xswec+YINPAE7Pd
	JPjLwts5M6Y7aUTyDnfco4HyFgD9E5dUAHwVI3n7XigR7HYiAJMy6xczp3wsJUUT
	PzJehN6YsmU4oEA44p7xqru+dW6rN+Ek9An4iiyItLuDbKIVrsd6juyyyj96zUc+
	6ZPG4iT5a4mIlACZhfG5bUhk8LnCF0iCYceDPhAM9YXS/86Bggsjfg0DpSlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704708350; x=1704794750; bh=gX7stEsAK4V1XFenI/L6h4u3PJkj
	3hggP8LgwP3VYis=; b=S1qSJJOKXZmUo9c9K14Ouchyzu6XqrQ0HIP0QzjyPjYy
	2obzRrYjrSq2wD38CTdKl34hP1l/WcYz1lnlf9UJ0az92C2qFK6WCEVy0ruB18aU
	84JC8Za/ISVzUr7LT6JWSmCZTIu9HtL77EiegKXEe48UMLiwpHn6uDxuGbRS/uq+
	q1NoKo0Vovh6q4Jzpi/Ah9/3leht5Qbbd4XPKQJGBq25gU6LfGTNrjCG1apYYXr5
	aj/lCuYXii5dfF8mkutQfNjF3fzsGxabS/scrXdkMIB8UaekKwcrRD3A5kq6QJDz
	ffKhM5MdLoCAkui9crPeqLPUmwCjzuQeksj98n34Mw==
X-ME-Sender: <xms:_sibZeyFrQfjqFmJhnjNVYgp9Gbz8pxQLwCEPNloiHJ-tl-X2WI-og>
    <xme:_sibZaQpupDfS0_DLCJzFXxI8OnTBLEo_bq2AeG-NHVPf_x_RIDtsLM6mU-kmZxxy
    Y59Qn5VeKPtZzxy4Q>
X-ME-Received: <xmr:_sibZQVrPXMGCXamAnrLS8ClnfYV3b8utSIQRUrUbpTxZ2-GxHIrO1rwo71B_QjIsuV6p_BDzYsYPUYVrAphF6sDSo4AsnbfslqgD6GhS4ith-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:_sibZUh7zILbCbe54fh4bLrdqzd_FUohB0rJSUJpjlmAnKXa3CnWPg>
    <xmx:_sibZQDydrpG5OOPZ-V6UBkogLpYkyZOFt0vtMcxGjxEO5KZocRkEw>
    <xmx:_sibZVKm99re-uVfMg6z6EfPCjbIGYjJ02OHsxO7MGTUgQ7RH1cjIw>
    <xmx:_sibZTM_bqCFw0EeW74IwcDzygk6Z936ax9dxCpzqVlW0QtFxGcVjQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 05:05:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d370fb0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jan 2024 10:03:13 +0000 (UTC)
Date: Mon, 8 Jan 2024 11:05:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 6/6] builtin/worktree: create refdb via ref backend
Message-ID: <240dc40de18a79c45192466289c4e1d85d90e901.1704705733.git.ps@pks.im>
References: <cover.1703754513.git.ps@pks.im>
 <cover.1704705733.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0fj1QZGH5qDy06IY"
Content-Disposition: inline
In-Reply-To: <cover.1704705733.git.ps@pks.im>


--0fj1QZGH5qDy06IY
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
index 58937a2a68..dd10446d81 100644
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
+	wt =3D get_linked_worktree(name, 1);
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


--0fj1QZGH5qDy06IY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWbyPoACgkQVbJhu7ck
PpQ3CRAAjEDIqy49Bq7B4YqMw7lvkxFAgKhFHtDavsUO1vh29TN/ZRbtC9BVueDI
eRF6bUT2390yprVm0ToSrJJ5sMn02NB3WlTRk7Q22Z0zseWCcHJggWeD0/L9Tru1
/1GSHvrxY1YZQwrn0PLDQcR6AbIWvIelJurOrTRzpPBHBsbp2RpW3pmIdvsEP/Du
mxfhEe7SpBlim/mjkNmN7hVj6PPJLHmVkZcdAp5FXeCWZqtfM/7YEPSuAKhr1vep
j+yxPVlOvUcc0fCz0za0ByBYXD83J1fRpXUxdnbpJJr4faXxbdMZFOgxNfBrWtVh
szOWGUuS6Xb5Woe6QWM92HJWjq2VnCxDYQlgYURfFs33VIm6q7hBVInzE/IEDzOU
D1UAldKPcvZyDn8FxpNYahU6QARFnHdWT4ln0J9q1vV7OTRvzioVetPh+3SirUeU
yYznKFGpCOqZJaDXj1ypeFX1k59tASWwxCsVrch4BUJ4RCBkRKQ2KurStfvQPQRn
9yLXuKQA/rFfqBrG+e8RAOi0N1gp0zN1itTlgc9JMbr9U8ezI+GENaqt1w0HkYSQ
A3NW1GYNxfoYkeJvbxQ/icEfAV8ep/KM3z0tZYR7QN3DJrLLO3aadYCr+C7a/PIS
9gxqH5GhJty5sepjCX0DMUuVDJ0odibAqAOF5zdcwX35Q9PowQI=
=oalR
-----END PGP SIGNATURE-----

--0fj1QZGH5qDy06IY--
