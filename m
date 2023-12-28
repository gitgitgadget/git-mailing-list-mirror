Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D727F6FAB
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TfAbnIVx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T68rvJZT"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id EBCC25C0085
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 04:59:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 28 Dec 2023 04:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757593; x=1703843993; bh=j8h3XSBNUC
	wJJsubKxBRsOxn9lll4c6gsTaFRb8eJb0=; b=TfAbnIVxkcJmQV98A1IdjqGPdg
	NYTRP6mjtloPkk1WsNGwSqG74MktpjYds6dyUlcLVAvyVy/IvDDZ43OLPtOpEL+2
	7XansR+vBs+7WxFYR2pqRFFAPeHO3O3evG0oS0bdTlSHYKT59ZFgx/rpa25VKqFa
	j1ujrb2sB4duCce/5M9nf4tUYS20SE5TgTbx7KkfT2ubEfv1CxyYFkZkZwsRj5dT
	/hrU6i8t0oWfLbJtMYvNLEW5y/76bwF8Wov0JYOPXGOsPovREENe6GyyDF3+0sCo
	hzZZQiImY96l/tkGkcIJuO4TtawowSwEKpMapLO8anisD1qYufYeuEtvBfYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757593; x=1703843993; bh=j8h3XSBNUCwJJsubKxBRsOxn9lll
	4c6gsTaFRb8eJb0=; b=T68rvJZThJ6TM5qRGYI8aD1mbRTO8VmdpoqrHZ2gmzFz
	CdNuKJfKeb/OTfqtKTcKoe0rySHkwFkXfI8fA3OH7PEqm1OYQgsf032qKyGyagFp
	2sG5+blz02kzzFMoViHC0wmGl7kqsRFbplbCZiLNwoWIWVHo9pSi5uMQ8XDapehS
	Ao4kMb/9h3m7Ve/zvFrgL/m4aqXgyWKNC8uLHe+sOIjV30T5Aqj5but5t8gx2pUr
	CJNdRRu7s37aKhOqo00D9opFG022zNd1xPhYmyHe8hGTG5xwUmZ4G1nply93X5Hk
	ey2yJ32sMlhYWfLRO0Uyt6OYUG5ZvoqoD1RkV/U+ug==
X-ME-Sender: <xms:GUeNZduuH_yNKxXvZyADsulhGuMr6rG1acrmlj418FGzLOwB17TwiQ>
    <xme:GUeNZWdRcDQ2Vbuw1VV_zE8KwmiWWE9ncP0-NWvavQtDgQ1RTMfpJ9XlPK1EDyUi1
    imR4YySIqilA2Admg>
X-ME-Received: <xmr:GUeNZQyLSZFx28U9ksCRkEQhOGxv70vTmt1iS5EJk3VO4YEV9eIh6BFDHx5rNzsenAGgJO6wcL_OBVqqKmiSalmjMD1UyYehF_2Ojmbbk_BVtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:GUeNZUNoMMv_gQZtHbh78yZzFolDSkmvljRzlCsU37i2LK_xa_RTEA>
    <xmx:GUeNZd9aUHUdrR77DDOWQYE18j5HQ9bJ7NiFkiP1UomQF-udZ-5Q7w>
    <xmx:GUeNZUWnVc1QNbQ5LlgaQ4Er1X4T6_hjA92W1_5bYVdsOf0TmokUsg>
    <xmx:GUeNZSKqsLF5fE887rEuIhIH_4JpUMDWV4RfubxtW4NlPN2gk8MTZA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 28 Dec 2023 04:59:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 96b02384 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 28 Dec 2023 09:57:39 +0000 (UTC)
Date: Thu, 28 Dec 2023 10:59:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/6] refs: prepare `refs_init_db()` for initializing worktree
 refs
Message-ID: <6cb4e0a99fff52c35ea293f855fd3a34bcba7ab1.1703754513.git.ps@pks.im>
References: <cover.1703754513.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/5tKt70wVHZu13m7"
Content-Disposition: inline
In-Reply-To: <cover.1703754513.git.ps@pks.im>


--/5tKt70wVHZu13m7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The purpose of `refs_init_db()` is to initialize the on-disk files of a
new ref database. The function is quite inflexible right now though, as
callers can neither specify the `struct ref_store` nor can they pass any
flags.

Refactor the interface to accept both of these. This will be required so
that we can start initializing per-worktree ref databases via the ref
backend instead of open-coding the initialization in "worktree.c".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                | 6 ++----
 refs.h                | 2 +-
 refs/debug.c          | 4 ++--
 refs/files-backend.c  | 4 +++-
 refs/packed-backend.c | 1 +
 refs/refs-internal.h  | 4 +++-
 setup.c               | 2 +-
 7 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 16bfa21df7..87e2659db7 100644
--- a/refs.c
+++ b/refs.c
@@ -1928,11 +1928,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store=
 *refs,
 }
=20
 /* backend functions */
-int refs_init_db(struct strbuf *err)
+int refs_init_db(struct ref_store *refs, int flags, struct strbuf *err)
 {
-	struct ref_store *refs =3D get_main_ref_store(the_repository);
-
-	return refs->be->init_db(refs, err);
+	return refs->be->init_db(refs, flags, err);
 }
=20
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
diff --git a/refs.h b/refs.h
index ff113bb12a..6090e92578 100644
--- a/refs.h
+++ b/refs.h
@@ -123,7 +123,7 @@ int should_autocreate_reflog(const char *refname);
=20
 int is_branch(const char *refname);
=20
-int refs_init_db(struct strbuf *err);
+int refs_init_db(struct ref_store *refs, int flags, struct strbuf *err);
=20
 /*
  * Return the peeled value of the oid currently being iterated via
diff --git a/refs/debug.c b/refs/debug.c
index 83b7a0ba65..c061def8b5 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -33,10 +33,10 @@ struct ref_store *maybe_debug_wrap_ref_store(const char=
 *gitdir, struct ref_stor
 	return (struct ref_store *)res;
 }
=20
-static int debug_init_db(struct ref_store *refs, struct strbuf *err)
+static int debug_init_db(struct ref_store *refs, int flags, struct strbuf =
*err)
 {
 	struct debug_ref_store *drefs =3D (struct debug_ref_store *)refs;
-	int res =3D drefs->refs->be->init_db(drefs->refs, err);
+	int res =3D drefs->refs->be->init_db(drefs->refs, flags, err);
 	trace_printf_key(&trace_refs, "init_db: %d\n", res);
 	return res;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index ad8b1d143f..387eeb5037 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3220,7 +3220,9 @@ static int files_reflog_expire(struct ref_store *ref_=
store,
 	return -1;
 }
=20
-static int files_init_db(struct ref_store *ref_store, struct strbuf *err U=
NUSED)
+static int files_init_db(struct ref_store *ref_store,
+			 int flags UNUSED,
+			 struct strbuf *err UNUSED)
 {
 	struct files_ref_store *refs =3D
 		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b9fa097a29..3f10bccf44 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1246,6 +1246,7 @@ static const char PACKED_REFS_HEADER[] =3D
 	"# pack-refs with: peeled fully-peeled sorted \n";
=20
 static int packed_init_db(struct ref_store *ref_store UNUSED,
+			  int flags UNUSED,
 			  struct strbuf *err UNUSED)
 {
 	/* Nothing to do. */
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 4af83bf9a5..a33b28c19d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -529,7 +529,9 @@ typedef struct ref_store *ref_store_init_fn(struct repo=
sitory *repo,
 					    const char *gitdir,
 					    unsigned int flags);
=20
-typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);
+typedef int ref_init_db_fn(struct ref_store *refs,
+			   int flags,
+			   struct strbuf *err);
=20
 typedef int ref_transaction_prepare_fn(struct ref_store *refs,
 				       struct ref_transaction *transaction,
diff --git a/setup.c b/setup.c
index bc90bbd033..a4eb2a38ac 100644
--- a/setup.c
+++ b/setup.c
@@ -1919,7 +1919,7 @@ void create_reference_database(const char *initial_br=
anch, int quiet)
 	safe_create_dir(git_path("refs"), 1);
 	adjust_shared_perm(git_path("refs"));
=20
-	if (refs_init_db(&err))
+	if (refs_init_db(get_main_ref_store(the_repository), 0, &err))
 		die("failed to set up refs db: %s", err.buf);
=20
 	/*
--=20
2.43.GIT


--/5tKt70wVHZu13m7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRxYACgkQVbJhu7ck
PpQ5bg/7Br+XRXm9pqTBugK1NHFZyYPK6sD2/ZW2WdUsqOSSSSaI5c5n1mdoWHBq
ySJtNylCWP086Su3ai0uF2mI0O4wSUKOJ8oByNA80UcubYJBQUXoY3VwFruaFE/2
q91o1bqRcUqVp4NuGgixDJfJklyihLbs3OHdgT69QDUizB8Tax+wRi33DSPLfzap
bHY6G+rwUs7PLEntytwXubg21sdLafbTbH6ZlHXehap3kop8nHREnvv7eXtNJCGb
VjCAfsIyGusMpBrvfWl/Wjsi5lNE+swz6AfurEOiZ1E+XxBPN0Z6G9zq45aR7p8n
8W2P/cI3JAuqsafDpuRgHs/iLSij1tJAotkD4bn2fZRg0F9NyaODGA84P2DchKFc
h6M5DPZ++wyvW+Levk1BWvi4waOTH+LGU6jhLjQQNSFD0nY3cphr99h8lbHuG87r
tSBN1PrRDGHMPTl0HuAAPN5ma4C7uiW0OmXik5yLbRg6/hWqB4x2HGWv9dfOgBzq
Wnbu1OmRn8b/BUXvjckvOs/BMrWwEWyEjoh8ytDO91RxhpEhhFBmaybN9DUt7SD9
BmnD29ctckEzslum6ksND+3aO5/wz2c6wGc+VSGovVx9+PGdm+zGpOQ/WK+jz1XT
4rRtqZyGXaRHvqrQXjx2ofcK/45X4uAu1FwZ9Wl7Rmm8lBbawsE=
=bYxp
-----END PGP SIGNATURE-----

--/5tKt70wVHZu13m7--
