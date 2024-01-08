Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85B14A90
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="anJwvVMR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2LKoM+hi"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 939E35C17BF;
	Mon,  8 Jan 2024 05:05:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 08 Jan 2024 05:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704708346; x=1704794746; bh=yS4bNgNyoO
	WJgSOZGpQCn0dV8NLN59V9hdpmjptq+hM=; b=anJwvVMRbdEafQ3K93HXpsEZf0
	KY6sxLzAQ0hPywTDRnwyBXWRa+h8PHZjaGZKSl/1ycxBuSmTuIcXpGzf1OAxndUR
	UDPh6s9UTszwBdjCzoWu1kpDp/q243/RFJKLAZGjB5Lvu3xxOeeehzwoCynVfTax
	W0NU1kMhXGmZMjvchS7xmBxoNDLxTbjHJ5vtuZsPXfYaYxbMRUis3DpVcY/pcR+W
	FebcEhBR2hwPY8F0biXEoikjS4NYzBUUpFaTWhDuPQFyz+woePWDaRBDIx2UyVCs
	ni1kV7iwpH5QSs8B4Zw5wAVMOtucE5F9KiIU5aHswAixkW6DQjt9iDGe+KWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704708346; x=1704794746; bh=yS4bNgNyoOWJgSOZGpQCn0dV8NLN
	59V9hdpmjptq+hM=; b=2LKoM+hi1FyDKxnXjP4WGNTWTP17qO4hFWFPgi1JFAw8
	WKKfNOqz9KBqXxwtf9F8eLoK4+Lkq7uT9kKkRL27KCYgHe2OvbOq3NXL1uymBE+S
	/W46WA1dw2c2tu/SfqeFMaheN+tkW9bZUKM7fN3LvzsmSY6Jfz7PrlLdmgAZpcoJ
	V8xmBgSijGWShyo4bGV4LiwAMz+8jhQv3cI1k8MNWj1D2j+7Q+2pLZPkoDP1Bv2+
	yyWJzvzgSx5hOnUvdSJLP+M2BX2Bid6JtYJbzomD1ynsODw3cuSmtI15pl2KjrMX
	/fONPh9b8wD89a+3LfxUvE8dPozbyrhCSUKLERw1hQ==
X-ME-Sender: <xms:-sibZR3c9lpEOsdMJ3EGLYpkTk0SiSGLpTXheXTcKbZrQRTEoUAGVw>
    <xme:-sibZYHij92dkt4h2n2xZAMBEKT4j7EtHlWcmTaXlY9UjlK9KhueDm0eU2rNM6Y5l
    rKzXWrO_UKRgfyvmA>
X-ME-Received: <xmr:-sibZR6vD0BemBlL-7P14ma-d4pKllDTQG209AlwQxlHw7A_TT9zAdIYambzgKZSFgE0fmeIcejO-RVf62Kt31b58_-C3XWeuVQNOwLwJNgsbi0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:-sibZe3vjRaWqSuLfzZLrebEOou3EFNxSMXw5thJYZ8QmyeYz5btBQ>
    <xmx:-sibZUHavRBBIybh8L4GErs4u-yZ3ZuR40FwXaNJilRjO0K-FiolYA>
    <xmx:-sibZf_vvsW3zNhB6xG1xY4vRBFKlcX1QBdt69hgGQAZlSUMqEJk9g>
    <xmx:-sibZZSON7ohjOoxQPlX-9mzNrWM8IrhgIYxO1uaskv1IFgCHj1maA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 05:05:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b088f2c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jan 2024 10:03:09 +0000 (UTC)
Date: Mon, 8 Jan 2024 11:05:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/6] worktree: expose interface to look up worktree by name
Message-ID: <5525a9f9c2dbc424ef5ba4f766eb6143185bfe5d.1704705733.git.ps@pks.im>
References: <cover.1703754513.git.ps@pks.im>
 <cover.1704705733.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q0W+/uCos0kKC1KM"
Content-Disposition: inline
In-Reply-To: <cover.1704705733.git.ps@pks.im>


--Q0W+/uCos0kKC1KM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Our worktree interfaces do not provide a way to look up a worktree by
its name. Expose `get_linked_worktree()` to allow for this usecase. As
callers are responsible for freeing this worktree, introduce a new
function `free_worktree()` that does so.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 worktree.c | 27 ++++++++++++++++-----------
 worktree.h | 12 ++++++++++++
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/worktree.c b/worktree.c
index cc34a3419b..5d5dd46609 100644
--- a/worktree.c
+++ b/worktree.c
@@ -12,18 +12,23 @@
 #include "wt-status.h"
 #include "config.h"
=20
+void free_worktree(struct worktree *worktree)
+{
+	if (!worktree)
+		return;
+	free(worktree->path);
+	free(worktree->id);
+	free(worktree->head_ref);
+	free(worktree->lock_reason);
+	free(worktree->prune_reason);
+	free(worktree);
+}
+
 void free_worktrees(struct worktree **worktrees)
 {
 	int i =3D 0;
-
-	for (i =3D 0; worktrees[i]; i++) {
-		free(worktrees[i]->path);
-		free(worktrees[i]->id);
-		free(worktrees[i]->head_ref);
-		free(worktrees[i]->lock_reason);
-		free(worktrees[i]->prune_reason);
-		free(worktrees[i]);
-	}
+	for (i =3D 0; worktrees[i]; i++)
+		free_worktree(worktrees[i]);
 	free (worktrees);
 }
=20
@@ -75,8 +80,8 @@ static struct worktree *get_main_worktree(int skip_readin=
g_head)
 	return worktree;
 }
=20
-static struct worktree *get_linked_worktree(const char *id,
-					    int skip_reading_head)
+struct worktree *get_linked_worktree(const char *id,
+				     int skip_reading_head)
 {
 	struct worktree *worktree =3D NULL;
 	struct strbuf path =3D STRBUF_INIT;
diff --git a/worktree.h b/worktree.h
index ce45b66de9..f14784a2ff 100644
--- a/worktree.h
+++ b/worktree.h
@@ -57,6 +57,13 @@ struct worktree *find_worktree(struct worktree **list,
 			       const char *prefix,
 			       const char *arg);
=20
+/*
+ * Look up the worktree corresponding to `id`, or NULL of no such worktree
+ * exists.
+ */
+struct worktree *get_linked_worktree(const char *id,
+				     int skip_reading_head);
+
 /*
  * Return the worktree corresponding to `path`, or NULL if no such worktree
  * exists.
@@ -134,6 +141,11 @@ void repair_worktrees(worktree_repair_fn, void *cb_dat=
a);
  */
 void repair_worktree_at_path(const char *, worktree_repair_fn, void *cb_da=
ta);
=20
+/*
+ * Free up the memory for a worktree.
+ */
+void free_worktree(struct worktree *);
+
 /*
  * Free up the memory for worktree(s)
  */
--=20
2.43.GIT


--Q0W+/uCos0kKC1KM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWbyPYACgkQVbJhu7ck
PpTgkRAAknbNTImzQwbXjCxhAbFdy4ZQNiVU35KIbBgqGqkr7JkJB7IZohHiviZK
deTB1E8aPM4f15NksKJ/0AWSfFICdrfsqwVDitAbWtPsMpuF4KFEhqFEO6VVdXuR
yib/s7ehf3CZvIMILExx58J+TX5HbKxoCYQHXW+y7hr9AAYxCMUB1ABqJbLp22Q7
I61BEZ8R1xDYv/mRxJ1UfSShCJDzF1uhRYXFUf3hPkaKDV/3D0my/TfGLmcy5JKC
LDVS69v2+KLY1jY0ciF7ihUfWkBFHP8guKYcMrXh8Qyl/EOk1orjma2eCvKQKX1c
sRai5aBeYjDlQip0lGd/KzuZz+k7RsmbqH6fwCr/mR9JdDoiJ7zof8lW9cPClCaa
MUXmLJza9tRI6UBAsJXEDPbHFL3AKKOPeYBG+WfEzKlHAmGcPl4nksZ2ZWLpzJsM
l0YV+/VtoQ+u/cClZdJ15ziGVV+ZZMMyKEsY6cj2pAJS/C8MlBUQ/0wAYtPDf+q4
WD2OujSM0A4mBwu+ZwZ7QXAamrFNG4/vWcbFvPjbkS7xp207hadOG0lAQl54Ya2N
HFXlpvNi2GoqZY4TexQaon8gg1AFyiLyd5Mvxbwtm+kD8Szxe8oReFhWpUXrGIsD
E5lzEJXHOVBPzG+J0BG0oDNMfN+GguXpPYnXWOx1d1k0cwWjXlQ=
=3C+w
-----END PGP SIGNATURE-----

--Q0W+/uCos0kKC1KM--
