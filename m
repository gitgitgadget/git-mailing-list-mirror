Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C021B6AA2
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p7WnTrYl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vqb8rIFr"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id DA7205C0089;
	Thu, 28 Dec 2023 04:57:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 28 Dec 2023 04:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757458; x=1703843858; bh=wgmWzHXUNE
	sMqAgViqXe+mlFAT4T1MC0+tcWR0vphXU=; b=p7WnTrYl95qaURqhH83HGuuftS
	Yn0Iaubox65R2wTT0iQwZ5BN4RIvbI9LCzPxyKNMlapat/Kk2PRaBhFqC/g7iw1C
	IOuD4isJfesHzIyHv7pCas7yNmThqRyR8z/67ZvoJhLZVyXBT9SymqpXU2AEK1fn
	MJnZC2zIIN/J5dYFDsvy9iXgkTbdx3tHnpBGbL266zqxM7eBuPB+IKIM3kMNDHON
	l75HHBCCYvdkuQTWVsl7/aGUytUN4lNXEZmfxojNqV5EYnEGkkwDOb0+LCZNdYtu
	F568Zj24KwxQQpxHFQF0WLnQP+oT+9GLCeajWauG337kypE1C9oTb3lrnnFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757458; x=1703843858; bh=wgmWzHXUNEsMqAgViqXe+mlFAT4T
	1MC0+tcWR0vphXU=; b=vqb8rIFrcviFHqPzfGmz/VIHmNHRYhrERVawUED//EjS
	IedQScF8YFd25ThTZd45y2Q+MvEY2DsDRJA5S42tNDeKLiAmYRm1Aq4fhHoEiPaK
	HOmNRhei7oW+3tvhAGjgudpmWForKRNK2a5PSNOw4UJwKDN6wt9GHqn9O31lNOwx
	chNub/IVpfkrUnrYoQAqe5a8IYoYjuSU0iHnWotUOxltlUjU5TL0ET1rCyzf+3Bo
	YIOeBDFnF60ZjJ3DQnlCi1z4vbgeUQ69vIrf9BDrEqR10h5NhPRPFXpdN5O2FLfC
	8bQwwYfgOoV1nQ4fdJB3ESEB/gFWRx+ifFkwlHFgZw==
X-ME-Sender: <xms:kkaNZZqAjJWN8kK1QMR4hzV98RhkuptXzgOqJwswH-fL55IE0ujB0Q>
    <xme:kkaNZbo5S0oTXcphxFJ5nbmNYXLLiJxtl8uPY0PvQwstakoA6NzYohQuNqdm_6Z3Q
    tzKeXVJ-YDxhd4Dxg>
X-ME-Received: <xmr:kkaNZWMIvbIwgz6lVNrRZ3tQy_YsVZhGV4SqsiIjBql_2wTX44WlCG7KH2aIzmDFmnGibQwoUxLmpPoaTmeEVWDY6f__FCCCq0B2qrt3WtQFlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:kkaNZU7wLMo5zfW_gosT5y9fDStgUX6fv0GsEB4jwIdUx2bQ-xVU_g>
    <xmx:kkaNZY4pNN1kIjzFC_bonV0qIS9yPtY12pOIT_2zoHPwi_HpNZXt8Q>
    <xmx:kkaNZcjhWQBDan_kBcYkLByY_pOLleMxh_zfeeRJQDOJhdvsqt48QA>
    <xmx:kkaNZWR3qEG3kucMUTmx9Lm66sutStVZlARJR8H7SA8G90LCVRWJbA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 04:57:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 948ee963 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 09:55:19 +0000 (UTC)
Date: Thu, 28 Dec 2023 10:57:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/12] worktree: skip reading HEAD when repairing worktrees
Message-ID: <ecf4f1ddee36643f0ff7e3d40b9aa7c7e6e6ce43.1703753910.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703753910.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bTE8NvNMyTHFYG/M"
Content-Disposition: inline
In-Reply-To: <cover.1703753910.git.ps@pks.im>


--bTE8NvNMyTHFYG/M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When calling `git init --separate-git-dir=3D<new-path>` on a preexisting
repository, we move the Git directory of that repository to the new path
specified by the user. If there are worktrees present in the repository,
we need to repair the worktrees so that their gitlinks point to the new
location of the repository.

This repair logic will load repositories via `get_worktrees()`, which
will enumerate up and initialize all worktrees. Part of initialization
is logic that we resolve their respective worktree HEADs, even though
that information may not actually be needed in the end by all callers.

In the context of git-init(1) this is about to become a problem, because
we do not have a repository that was set up via `setup_git_directory()`
or friends. Consequentially, it is not yet fully initialized at the time
of calling `repair_worktrees()`, and properly setting up all parts of
the repository in `init_db()` before we repair worktrees is not an easy
thing to do. While this is okay right now where we only have a single
reference backend in Git, once we gain a second one we would be trying
to look up the worktree HEADs before we have figured out the reference
format, which does not work.

We do not require the worktree HEADs at all to repair worktrees. So
let's fix this issue by skipping over the step that reads them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 worktree.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/worktree.c b/worktree.c
index a56a6c2a3d..9702ed0308 100644
--- a/worktree.c
+++ b/worktree.c
@@ -51,7 +51,7 @@ static void add_head_info(struct worktree *wt)
 /**
  * get the main worktree
  */
-static struct worktree *get_main_worktree(void)
+static struct worktree *get_main_worktree(int skip_reading_head)
 {
 	struct worktree *worktree =3D NULL;
 	struct strbuf worktree_path =3D STRBUF_INIT;
@@ -70,11 +70,13 @@ static struct worktree *get_main_worktree(void)
 	 */
 	worktree->is_bare =3D (is_bare_repository_cfg =3D=3D 1) ||
 		is_bare_repository();
-	add_head_info(worktree);
+	if (!skip_reading_head)
+		add_head_info(worktree);
 	return worktree;
 }
=20
-static struct worktree *get_linked_worktree(const char *id)
+static struct worktree *get_linked_worktree(const char *id,
+					    int skip_reading_head)
 {
 	struct worktree *worktree =3D NULL;
 	struct strbuf path =3D STRBUF_INIT;
@@ -93,7 +95,8 @@ static struct worktree *get_linked_worktree(const char *i=
d)
 	CALLOC_ARRAY(worktree, 1);
 	worktree->path =3D strbuf_detach(&worktree_path, NULL);
 	worktree->id =3D xstrdup(id);
-	add_head_info(worktree);
+	if (!skip_reading_head)
+		add_head_info(worktree);
=20
 done:
 	strbuf_release(&path);
@@ -118,7 +121,7 @@ static void mark_current_worktree(struct worktree **wor=
ktrees)
 	free(git_dir);
 }
=20
-struct worktree **get_worktrees(void)
+static struct worktree **get_worktrees_internal(int skip_reading_head)
 {
 	struct worktree **list =3D NULL;
 	struct strbuf path =3D STRBUF_INIT;
@@ -128,7 +131,7 @@ struct worktree **get_worktrees(void)
=20
 	ALLOC_ARRAY(list, alloc);
=20
-	list[counter++] =3D get_main_worktree();
+	list[counter++] =3D get_main_worktree(skip_reading_head);
=20
 	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
 	dir =3D opendir(path.buf);
@@ -137,7 +140,7 @@ struct worktree **get_worktrees(void)
 		while ((d =3D readdir_skip_dot_and_dotdot(dir)) !=3D NULL) {
 			struct worktree *linked =3D NULL;
=20
-			if ((linked =3D get_linked_worktree(d->d_name))) {
+			if ((linked =3D get_linked_worktree(d->d_name, skip_reading_head))) {
 				ALLOC_GROW(list, counter + 1, alloc);
 				list[counter++] =3D linked;
 			}
@@ -151,6 +154,11 @@ struct worktree **get_worktrees(void)
 	return list;
 }
=20
+struct worktree **get_worktrees(void)
+{
+	return get_worktrees_internal(0);
+}
+
 const char *get_worktree_git_dir(const struct worktree *wt)
 {
 	if (!wt)
@@ -591,7 +599,7 @@ static void repair_noop(int iserr UNUSED,
=20
 void repair_worktrees(worktree_repair_fn fn, void *cb_data)
 {
-	struct worktree **worktrees =3D get_worktrees();
+	struct worktree **worktrees =3D get_worktrees_internal(1);
 	struct worktree **wt =3D worktrees + 1; /* +1 skips main worktree */
=20
 	if (!fn)
--=20
2.43.GIT


--bTE8NvNMyTHFYG/M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRooACgkQVbJhu7ck
PpTJkhAAkZ7PDuXdQtx1bDZtVVsvUyUhWjf5J7A1P1psPS14qOpmS5l1StdJE1pJ
qkmmKEdVeP49n1pJ/dDesNl8JwRe44CFQzOZM2nF/QU5Dn3lrtSGyLg2KgC/gif6
l6VLPAqNkHlvox6xlPWvSYhzt+IzZh/4v7/QQq5JLAWfqWGbERevs3u/TPZ63Wxp
NenuFv4HbHmzDfh5GY3hyVD55qP7BkRa+kyb4OXKDxrr74Txnood60TD9bTg6UmG
u1P/15ZGtjo/HBklvh463MHr5BGjf+kW9JUaM1QIvMaW2tUT2+C40lAE5jTUSqSR
bri84LYU4IuiMgUhgJq974DjwVHlfjvg2AD0ULSMi9m27u+zOMEGOSIffdmF9Et0
QclPG/ray1mfAU11Bcqii/jQfjQag8PPVXR4vYU7ILV4xFnnAQmKKYP4qyyocltr
TFQ9+DeLcU2HV1xOdT9za9iywulXh4TjO20Wuo2yoKDNDXTuqhCxTI9pwMAZuQ1G
YA/7aMUcOgaxxM5IgXW3v8HakaR/4ZIlA5cIDTTzdDHUHe0Ys9btIqKr7SkpV2d+
8idTOZlXvT64VAQCCdQP7Flfa/2kR+KLFCsCSAxsYLP/db4boFeb/prH4Q0R9iQ7
fKRIJXe1l+4XTmvE9IrI17xdnXcIB0EYLZ+pKOosY3/PYbySypI=
=xcW1
-----END PGP SIGNATURE-----

--bTE8NvNMyTHFYG/M--
