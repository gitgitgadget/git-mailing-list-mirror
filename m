Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0378D20B3F
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jao6oad2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SsyAs9i0"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 1A2E85C0136
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 20 Dec 2023 05:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703069705; x=1703156105; bh=aw1pzX0Z8K
	DD1ldYkIjhO8PHjXnGLceyAefUz//lcsw=; b=Jao6oad2SMHYXwQcEf9HvLCApW
	qLpm+gT1FxxyexX/Y+54bUuLz8KpxrkLC1BXp5SCqFUFQyqABynNpKb6wA5kO09J
	3JSiEVMRbs25Dv3rTxByk1js2WQN3kZJ9Ojr/RWV57onwrvSCh1W1Ou+Fcpj04h1
	pcjIWs2SyTdqagsRbH/eAwtg9fcp4PeHFtEsiFRNdS+C6wfBB2iS55yb6dwtbr2l
	co0BgEQV9pDOVDXE6f0JLMAO1zXqdJiDQtVBUCyIdfXEbAg03dcz2YojKzRKYyao
	i4RRe7vaHAn+7vY7eiuYwQ4u0Q1l1L8Lap9PYsjgV+24vZkWSHgCXsGKGVkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703069705; x=1703156105; bh=aw1pzX0Z8KDD1ldYkIjhO8PHjXnG
	LceyAefUz//lcsw=; b=SsyAs9i0PVG9VYnMcQRYQiPzXXtYEJnLZWcRfjpT2GQz
	V3oJuhmloMYC+UHLPQ74A3LVK5eHufKFTqCmnV9GAWFHDvhhMbb3v4T8eYWRdKCt
	zQoWqrOEx4zjXWskmIViYzf7w1KvygLWfYkKMpFddu2gLwKzAjrPp61gY/VEC3dQ
	GcgL6GTCrlVCoC6X5hyJ95TyMXuLeocIPMu0Kv/oSFykSopQGccgXQR0baqz2erA
	df4aK0hc5NbZ3MsOfJ5VfkFSig6fpGTU8p5aueSCIfA6MbTW3KyGzm6345aqPOfd
	mlMhC/y73FzwIVKjr9sCptnUWKvS69fpNaC0G2lc/w==
X-ME-Sender: <xms:CciCZW1hTnVlMptbvsr8CB6bXgY4VGTxXp-bxAK4-0O7uIM17EnC9w>
    <xme:CciCZZGFWfySkIoIJEoEGnGAsGirX-BGwOFVKUpkvIx8omaI787B1BOrke6kiz3Yq
    xpHddk2HKlOLGW8ow>
X-ME-Received: <xmr:CciCZe58KrdygBIDhqFdfhzc3gwW8BQ6FCyeO0e5fJOeSFi1K1fUHvJj3o1wau3GGWDwg44IvqfwNr7iXCT3PfMZ7fiu-y2HYPBqz6L49r_zcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:CciCZX1xoP1zdk9DkVSqk15R-ALyyBGdj2WOcDCcDPhVBHB8Kas2HQ>
    <xmx:CciCZZFkxmQfTFgpJR86nYUZ-75_C1T5UupsMex7fXjHdYSy2Fw-4A>
    <xmx:CciCZQ-0ZRs_PD90JO4nkFDbITw9q6YP6TwKdaF3-W0gqTKQI25f4g>
    <xmx:CciCZYx5OO6kGuwr9lGYrsh0Io-aoJ89D8PRWdokVWjNH_uSD_ahZg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dc9eba43 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 10:53:05 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:54:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/12] worktree: skip reading HEAD when repairing worktrees
Message-ID: <e895091025e6786e0a831e4fb9b092eb74bd4379.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dkeFiGFQ9i4MLojY"
Content-Disposition: inline
In-Reply-To: <cover.1703067989.git.ps@pks.im>


--dkeFiGFQ9i4MLojY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When calling `git init --separate-git-dir=3D<new-path>` on a preexisting
repository, then we move the Git directory of that repository to the new
path specified by the user. If there are worktrees present in the Git
repository, we need to repair the worktrees so that their gitlinks point
to the new location of the repository.

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
let's fix issue this by skipping over the step that reads them.

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


--dkeFiGFQ9i4MLojY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCyAEACgkQVbJhu7ck
PpQWhhAArIIsl/GWUwLZtHe1Ru2qSoZBzj29BHdRWSkVzEJtuNAI733lk44yZmJA
kE62xzksNfJ8xJkenXl+UYzvYDk8pQFAi4gw/M0yIYfVQ32QkH5BFwNgTMVRbK+D
bPzlnhQKYpnoaKgzx5JS7xGkTi9XH/Twt7SRfQLSEMQfY60Td6yyEFlbM1ZTELl/
dfkBUzPWvQX0v9dxBkPOTSMT76+b7NUkIrOsASwSmeH3ht3iQQN7ol9FpUhlhhAO
NCz9/XDfce5AP6HvHaBMLccnrvvTO4I0B2qC83HRZ1CwQzMmpb9wMI53l9ZR3jNm
AcAHYYN+XdtEEQ2s1D4ermTxHIB9/mb51bKP0efkTzNhqBpHrOv6L84NWE288hDu
gqq5URA2jYYJ6O9bgZaGTxNs9uKpozNXTkT6HzLKaT37lD0Dj4ZfNiJIC2CLQSnR
0cyPTzoPh2S9NFbmZisTxKsjLoIQYpPBi6KvMutRbhlt2u/OffbwhCXx/5hUz+mt
kzdKv5dWy3+feV78VzqotwLgNEtJ7pUAOa7v7aQTCktsS9srxQRtCkRVA8N78+HD
ZgNAXULITBqdcvkBy2wxlhv3AgtG9TgXeQ8ErVLOP5yY0jQcD6frlPHyD4+8YXjX
j4ZmdRmKHFMXg4K50IQ2dB/skCoy9+XISiUouCK8IabPwsGI4zQ=
=5zKy
-----END PGP SIGNATURE-----

--dkeFiGFQ9i4MLojY--
