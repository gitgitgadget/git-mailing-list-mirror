Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCD36FA2
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I3/D84z9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KY0astpN"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id B3CAD5C0080
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 05:00:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 28 Dec 2023 05:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757611; x=1703844011; bh=Uz+mJhMwGn
	z4Jebfyn7Np3s43vNh7O9hEbS1/8QDsUY=; b=I3/D84z9xVp55yc+E9yA+u2xWM
	WXfqy9OW0boukGQdYbi+2uUc2FVwTENaftgdok0bJN3JYYgB2BRxVHwNhohgARgO
	JM5TqwnvFIn5vq/48G5aQMvmrZ7tig4MuM/hxtIQRS5OSQMEE7Udw4FFrupHXrRG
	zsFjQqmNA8orrAMenvFvAQM7CtKzIrba/FVSR7bmVnQzYxX4i07IVqbmxjJP9ggK
	GG34jlfIl7n3f2x9wTYpw7zTWwHjZD1SzQR42P8Jy9NhDL6I5NL5bZbTvSq5q3Ix
	a6iazXVRGnkYadFFy6onucvQwPs3q1S27v9A0PiyQIygAMjUZlscoeSEAP9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757611; x=1703844011; bh=Uz+mJhMwGnz4Jebfyn7Np3s43vNh
	7O9hEbS1/8QDsUY=; b=KY0astpNYlw37aPvUvPI42qXoJGLawYK2rufxfbOh1vM
	SB4qCIvyh2vMim4j31hBfwTiSjYd3SzbdHwM3rqvjpOSiA4oHkIu9O0kkm3UEHkn
	vADCLogHhc60NvPNT+2ojBwmfvvJlho6Hggh4a+8cdT8+e991VKld0vJFxZHL41m
	N28RVvonz+sUZ/vJbV0Aym1MksezJuuS0p/0UMHwbV9vvutl8NMfUmFjMIlTxZTv
	+C8UPUKr75hIHgnVIs+tgIgxB6kY9ttKM4JfLTUWhBMWFynWqM4icGwfpJv3J1Gq
	ZvgCR+TTK/nJKJwNsLMYElfGjxIYuEp8M3WirnuODw==
X-ME-Sender: <xms:K0eNZcO5o1zza2cNbRWIQ-IFFZZL63y7u-4ZLbwQxaSeNdhVOyMEPA>
    <xme:K0eNZS9mVSxNmyHb2sYlZSq76HiEnO5WD_4hEMEpcV25oI-1FtUJxQjAwc9wnN9nr
    M3PUVlZAc45bpIwzg>
X-ME-Received: <xmr:K0eNZTQU34ZH3BfPB8ksGz37quzxRERzPwZ2A0-ZBYsZ1VA4V6eYpdm2IG1lx9b8mXkIrylIEi6Ws46V0Kd8VErhSuOD0vq5M7flMTGxR_6wEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:K0eNZUu-9dVA6_TQYTvwnS01LCdpNpKaUHZNuQ7KEslCujRgkv7iVw>
    <xmx:K0eNZUcsAZYEL5ZrsqTi5oookWUiKPyUlCLi5IyZZ8Guh8zK2nFoGg>
    <xmx:K0eNZY1AotB5xZ2LTl4FkIo7zKg9VwkNtipnTM3p_-jg4455ATrQ6g>
    <xmx:K0eNZeqPCCfF85NcnlyctypPZCRdoDc4Ztl-X6n9rZpCR6zxMIaLmA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 28 Dec 2023 05:00:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 96dadba1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 28 Dec 2023 09:57:56 +0000 (UTC)
Date: Thu, 28 Dec 2023 11:00:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/6] worktree: expose interface to look up worktree by name
Message-ID: <f344a915e98e9c7be6aaf535cf0acfd08fb06b7d.1703754513.git.ps@pks.im>
References: <cover.1703754513.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/kEn5tUTnRkxRMgq"
Content-Disposition: inline
In-Reply-To: <cover.1703754513.git.ps@pks.im>


--/kEn5tUTnRkxRMgq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Our worktree interfaces do not provide a way to look up a worktree by
its name. Expose `get_linked_worktree()` to allow for this usecase. As
callers are responsible for freeing this worktree, introduce a new
function `free_worktree()` that does so.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 worktree.c | 25 +++++++++++++++----------
 worktree.h | 11 +++++++++++
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/worktree.c b/worktree.c
index a56a6c2a3d..085f2cc41a 100644
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
@@ -74,7 +79,7 @@ static struct worktree *get_main_worktree(void)
 	return worktree;
 }
=20
-static struct worktree *get_linked_worktree(const char *id)
+struct worktree *get_linked_worktree(const char *id)
 {
 	struct worktree *worktree =3D NULL;
 	struct strbuf path =3D STRBUF_INIT;
diff --git a/worktree.h b/worktree.h
index ce45b66de9..8a75691eac 100644
--- a/worktree.h
+++ b/worktree.h
@@ -57,6 +57,12 @@ struct worktree *find_worktree(struct worktree **list,
 			       const char *prefix,
 			       const char *arg);
=20
+/*
+ * Look up the worktree corresponding to `id`, or NULL of no such worktree
+ * exists.
+ */
+struct worktree *get_linked_worktree(const char *id);
+
 /*
  * Return the worktree corresponding to `path`, or NULL if no such worktree
  * exists.
@@ -134,6 +140,11 @@ void repair_worktrees(worktree_repair_fn, void *cb_dat=
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


--/kEn5tUTnRkxRMgq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRygACgkQVbJhu7ck
PpRXwg//doyaXNbpMNTeBvQA4Mt685Qzz4pE1I7ImelpaapmYOXxxaJXr9a4tBS4
D1ywAjgfcQ/0xWkOeufvr5dATFUdP6PHPvVbch4WIDWssc2LqxW/tNijFZ3Wh+rt
DG9UjTgAyEq05EI9JW93ytJN020xL3BP7wX7SoMYc6oIEIZr59DzkLWg4+mh/5xd
bSJUdhwQjsWqdKo79xt3cYDM4/2JeiM4fuYhAkngxANBnD4iRXxv2HjHNaG3b0go
UIbsdCujLMQy7K15NlQXlQvJk0mGKbERXS9DsHJDTyKPHdDZhH2t6sOgHUs8m/0s
yUY+9Yo70LnF3WTPhOUUzjm7O9MxkUViL2oFcTRjNWl1RmHdh5pA31O+URb3RWzH
lptcfFpxLUsvymTBem6Acq2CxaduFq8YCx57ysK/q8xR+g+0MQdRTpGKcVSp6lv9
xcqKHcr1JOCxRz1kzV0kTRj4ckyeH1qfTo/NIsQqOO87U2trUofBqKZGjx9svUIu
GynogQOsG5qgJ6qX7mhGgMVwelMZNtcB+FxCGZp4f4l0gxOiolIL7qvZtNCPAX2D
XAoGcyURaXwqkCTURoP8eOTGf8n8V8ENtkD0rrLSf99gp9TjB+BGQby/kj5yEHx9
+F42NJNNawZciafZYZJYZWKOIupjfHjfXT5iOFBePPQOZZeJO08=
=V6ez
-----END PGP SIGNATURE-----

--/kEn5tUTnRkxRMgq--
