Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6B76101
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 07:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xDgyQYi8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JrLYa0p/"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 35C6B5C0170;
	Fri, 29 Dec 2023 02:26:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 29 Dec 2023 02:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703834793; x=1703921193; bh=YX/fIJsulC
	GsHREQlwvCUA7knnuDAm0AEgJgd5BhRZg=; b=xDgyQYi89rZWCTug+iLYvRjgs6
	u+mRTSlXJa/M5Frz3oUBA6jLmtDgk81Hv0BMKcnB4KSAlFIvuOHxaIk9+/QtAQR0
	wBaJVmE//SKDU67fbxQJnCi2VQFSl/4fiU3YXUjyJNpu9gvFGmwFLcRw+R0hGY6o
	6sXcBSbPgjHaGJqpG5zn0iiIO/303wm2EX+CPZk8FBsuMMLv6pFf9tM012AAdbFm
	KYe2DIe+b1JcAVK/ReuuzBzwAXb4LQp/UdJBjIdQtMDdFejTY3VM5NRRmPwhWJ9C
	Q2iNK7Gaq4cXHwyWgS2Q9IICXHYHs4UnmB1HiaZq7dIx8AW3gyuaV0a2cfWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703834793; x=1703921193; bh=YX/fIJsulCGsHREQlwvCUA7knnuD
	Am0AEgJgd5BhRZg=; b=JrLYa0p/a1qAYFQgsWKqU2dfhcESFBmSQQmZ6efp79Rv
	c5GiQr5WRHTIfG5656CC+ckJA3abtjOLjSn+CU3+TFul2Pj5U84WzV0TxX4YPmX8
	MajSNGX14/p4+IH10N+H68jD+kkyA3a+KwkhJOIEQYZ+hB3DS8x5tRfI3CEP/sEV
	wJv/6op4t9oS4AfwFVgm+UlsEWR8xIZzfS57Z39TdinF9Hc5eeec5w4IEakO0V2r
	1gW0x+5tyhKaVheB4KfdWgupw7Kl+2GCdPQ9LSP6jPExcYxgLV/w9dBikHq9Qv+R
	vACoHrG2MsUcm8fx2I03ERDj/jY+Z1dbcHA9cxJkYA==
X-ME-Sender: <xms:qXSOZa2UtrUU-UCTqv3NI5qxEM3lSzs1d-wp5DWxaI5JiLK2VIKT2Q>
    <xme:qXSOZdHXwsX4QNKc-zAWT6BysT1DQgaM3MmD3-wiMew2QyKozxGDbrcyWcJ2FHyFM
    TOB4U7iYddldM_1Rg>
X-ME-Received: <xmr:qXSOZS4C6GvtFEkyVX2AXkJvanVmV00AebWDadG142I0euu9DpHvKfmVmjHOXz3juFKlwF2iVMyAml3TffQvXMQj0Yv6X26WS5XQQJYfWkcE-fG8ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:qXSOZb2tCY-ATemr6X0tZBi05BEW35QfsArZNkrUFQts3tYCJFkDJA>
    <xmx:qXSOZdGLtuVkjNuH_I8hJfGfjocJChm_4esi7mk4GqIGKq--FfB5jg>
    <xmx:qXSOZU_q6XNxz0bGKnWdd5GTGxmRa54TGsmOSpsWqRQme4Vs2m_s5w>
    <xmx:qXSOZSTiXr49dyHmRFMZa9vCJ1BvyQTo-PTgGUT04XYmqD6YkMqMFQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Dec 2023 02:26:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4e7b3a98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 29 Dec 2023 07:24:16 +0000 (UTC)
Date: Fri, 29 Dec 2023 08:26:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 02/12] worktree: skip reading HEAD when repairing worktrees
Message-ID: <77c7213c66d6b5caf2c24e17578d3e42f7b745a7.1703833819.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703833818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qKU/7vYuYPe6ALK6"
Content-Disposition: inline
In-Reply-To: <cover.1703833818.git.ps@pks.im>


--qKU/7vYuYPe6ALK6
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

Although not a problem presently with the file-based reference backend,
it will become a problem with the upcoming reftable backend. In the
context of git-init(1) we do not have a fully-initialized repository set
up via `setup_git_directory()` or friends. Consequently, we do not know
about the repository format when `repair_worktrees()` is called, and
properly setting up all parts of the repositroy in `init_db()` before we
try to repair worktrees is not an easy task. With the introduction of
the reftable backend, we would ultimately try to look up the worktree
HEADs before we have figured out the reference format, which does not
work.

We do not require the worktree HEADs at all to repair worktrees. So
let's fix this issue by skipping over the step that reads them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 worktree.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/worktree.c b/worktree.c
index a56a6c2a3d..cc34a3419b 100644
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
@@ -118,7 +121,14 @@ static void mark_current_worktree(struct worktree **wo=
rktrees)
 	free(git_dir);
 }
=20
-struct worktree **get_worktrees(void)
+/*
+ * NEEDSWORK: This function exists so that we can look up metadata of a
+ * worktree without trying to access any of its internals like the refdb. =
It
+ * would be preferable to instead have a corruption-tolerant function for
+ * retrieving worktree metadata that could be used when the worktree is kn=
own
+ * to not be in a healthy state, e.g. when creating or repairing it.
+ */
+static struct worktree **get_worktrees_internal(int skip_reading_head)
 {
 	struct worktree **list =3D NULL;
 	struct strbuf path =3D STRBUF_INIT;
@@ -128,7 +138,7 @@ struct worktree **get_worktrees(void)
=20
 	ALLOC_ARRAY(list, alloc);
=20
-	list[counter++] =3D get_main_worktree();
+	list[counter++] =3D get_main_worktree(skip_reading_head);
=20
 	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
 	dir =3D opendir(path.buf);
@@ -137,7 +147,7 @@ struct worktree **get_worktrees(void)
 		while ((d =3D readdir_skip_dot_and_dotdot(dir)) !=3D NULL) {
 			struct worktree *linked =3D NULL;
=20
-			if ((linked =3D get_linked_worktree(d->d_name))) {
+			if ((linked =3D get_linked_worktree(d->d_name, skip_reading_head))) {
 				ALLOC_GROW(list, counter + 1, alloc);
 				list[counter++] =3D linked;
 			}
@@ -151,6 +161,11 @@ struct worktree **get_worktrees(void)
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
@@ -591,7 +606,7 @@ static void repair_noop(int iserr UNUSED,
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


--qKU/7vYuYPe6ALK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWOdKUACgkQVbJhu7ck
PpTNThAAiCDYS5kqzigOGPgnx05+ZolYPtIz2LzK4mi2P/KGSbmjtEPoB2i98jN1
bApTOTFXMzhjTNgcpVy07ANQTX9TFvTi1xwnblEm9b7NDefcj5TmCSKkO8YaH+ME
Nr7sps0EMmcBfAwT3Mvxn8lnqWcJJ4XJhFRWEKvw6RAOJw/UZdI3P0T5Ii19dPvn
JX/0KH2zDINYsSVe+VZYbEI/Nlv/Uw+YaqYHs3Xbir09FoIJXW/D5gjxb57M4Wfj
Jae9kZ63baUQAQgltz94FfzX24NtU+FSxvJSpucpnZ7mu68A7ySItCTFfG/Tay5S
YP5T1igxRSasGvRqNR5gipTmY8R6h/SMnVT8TsuMz2vmGqtBQR0M50yjcYltcsle
HCujBt0E6PI2jZCuIHoF3J44/OHtUnO2Cpe2cT7W303J0ce3vdPAaZYI4TfcWAN3
NMYfFczaAV9B0i4Mhkd0q2BLfnk/wjU1MKdlW/jFy9R3hvnSWeDuoS8Um+A81RMk
5MQlZ/neUNKBC24YE3uKUuDiyXey9BGrd/IgDDCyDZIR0CGjl/LRSezPPoz6Sa9V
DO/apIi8X01f57vf6V1eWPex3HeKmL5pHUJEevmyt2/llh4Dc/TtrwGTXtCcoQDo
BUxIP+L8shLTLW/yBWzqecEJv1Vnn8wL2G5AayHITVCybyo/OFw=
=5NI8
-----END PGP SIGNATURE-----

--qKU/7vYuYPe6ALK6--
