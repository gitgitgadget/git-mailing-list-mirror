Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6D6FAC
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sef1pxP2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jZlhvSZN"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id CF81C5C00A2
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 05:00:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 28 Dec 2023 05:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757602; x=1703844002; bh=iwvaUQHaTE
	LOPKhtFF6yxqrh7pyW71euzw/BNKYQj84=; b=Sef1pxP2xS1beEpKhY58rTlmiR
	hM+QYmsnp5mew1huCAxskcH9AE7Xzkx8fMu5IWKi1InqyzeLohT4rx6Wc4H37GyM
	o5LGrKTcQl0Fz1zwOFG0lIen9k8kw7sIB5L811dfdOUKoU/I7LJUjoqJwDPnM+L1
	eFCc+cqLx6a/DtKdAQMhfw3nFqCZ0hfp/jVWsN08a68qFZJZeeaIzCd+q7MaY+nE
	dQJN+Jxah/528q9sMXZNbcl4XQEyxnRJZIqubr6++TfY9jZBguS4/6Dv2rSIKe4h
	IIhIrkovHvZEALLkm2LrAktJdk6SkLFoabFeEelL+0LeEAk4nSmIHKzFHIZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757602; x=1703844002; bh=iwvaUQHaTELOPKhtFF6yxqrh7pyW
	71euzw/BNKYQj84=; b=jZlhvSZNxFQSsnflLeYeo6Cfy5D4Y7QCF87g5EIp3cFg
	YXCMt3+8ysGAffJUFzsfQY14QE18ARft8pOfFYJkXH9kg6cvxpGaI7BDSB012Sw4
	z4yRzkgD9olIapV2AqzkoI54RpOxfSZbaKUANRH/KNck9IfzNKp0GVh7HwPBkCm1
	ullRJ4y6N1Mevng+Oz9Pgbp/ZkzMjfWPqGJ2h2ZRA5IServd9/9ORL/lSG55IVy6
	BNZVGWogH/BnNcClKD+acPPsZDdyOMPWbKHxkd6SLKlALXtnFpjiug+lKk1VRS3k
	pZ95q9pBHcZZOlwOcKHLLKuuzV58fA4SLXa9OJXmQQ==
X-ME-Sender: <xms:IkeNZSduc-JATGTOqoQTrXRcskoTuDgK73IHztkvZ1JAyxi8-pfXDQ>
    <xme:IkeNZcMMB8YVyKpRXBmxUNIVjUyJ57CNbkcMWjnFnHKsIzuF_niAK2gOkoX4npRsV
    odeWUcqrwcEzD06Dw>
X-ME-Received: <xmr:IkeNZTj5m3tuj48EcFsS6kxK79Ah93urTdDnW_eEhSjkYP8MMa1Fk1G0lHELJEk_vWT_m7krIPhizPKuy0joixrco2EKS-EvIl33IRObAyBoKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:IkeNZf_Y1FdKK0jTnByCC8yt97MF5FWQv3rZ7g_x-5W3ctV-dudHxg>
    <xmx:IkeNZetC7QlyUtLZX71t8i4b42nXsualZfmWKwpTmcMWNzjeCtZwXg>
    <xmx:IkeNZWE8r19rKOqG0E95oG0U8YsQFVevTA2nI2JecetiOOiL1svgUA>
    <xmx:IkeNZf70yEzck0-QLRQXc_5nhP3iDuGdnUmQKrX-P9mb5eualwU87A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 28 Dec 2023 05:00:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 54f20a0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 28 Dec 2023 09:57:48 +0000 (UTC)
Date: Thu, 28 Dec 2023 11:00:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/6] refs/files: skip creation of "refs/{heads,tags}" for
 worktrees
Message-ID: <3cf6ceb274d20ce76d0be65e4362a33579627052.1703754513.git.ps@pks.im>
References: <cover.1703754513.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7kU9pX+ROEeVYNUt"
Content-Disposition: inline
In-Reply-To: <cover.1703754513.git.ps@pks.im>


--7kU9pX+ROEeVYNUt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The files ref backend will create both "refs/heads" and "refs/tags" in
the Git directory. While this logic makes sense for normal repositories,
it does not fo worktrees because those refs are "common" refs that would
always be contained in the main repository's ref database.

Introduce a new flag telling the backend that it is expected to create a
per-worktree ref database and skip creation of these dirs in the files
backend when the flag is set. No other backends (currently) need
worktree-specific logic, so this is the only required change to start
creating per-worktree ref databases via `refs_init_db()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.h               |  2 ++
 refs/files-backend.c | 22 ++++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/refs.h b/refs.h
index 6090e92578..8ed890841b 100644
--- a/refs.h
+++ b/refs.h
@@ -123,6 +123,8 @@ int should_autocreate_reflog(const char *refname);
=20
 int is_branch(const char *refname);
=20
+#define REFS_INIT_DB_IS_WORKTREE (1 << 0)
+
 int refs_init_db(struct ref_store *refs, int flags, struct strbuf *err);
=20
 /*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index ed47c5dc08..a82d6c453f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3221,7 +3221,7 @@ static int files_reflog_expire(struct ref_store *ref_=
store,
 }
=20
 static int files_init_db(struct ref_store *ref_store,
-			 int flags UNUSED,
+			 int flags,
 			 struct strbuf *err UNUSED)
 {
 	struct files_ref_store *refs =3D
@@ -3245,15 +3245,21 @@ static int files_init_db(struct ref_store *ref_stor=
e,
 	adjust_shared_perm(sb.buf);
=20
 	/*
-	 * Create .git/refs/{heads,tags}
+	 * There is no need to create directories for common refs when creating
+	 * a worktree ref store.
 	 */
-	strbuf_reset(&sb);
-	files_ref_path(refs, &sb, "refs/heads");
-	safe_create_dir(sb.buf, 1);
+	if (!(flags & REFS_INIT_DB_IS_WORKTREE)) {
+		/*
+		 * Create .git/refs/{heads,tags}
+		 */
+		strbuf_reset(&sb);
+		files_ref_path(refs, &sb, "refs/heads");
+		safe_create_dir(sb.buf, 1);
=20
-	strbuf_reset(&sb);
-	files_ref_path(refs, &sb, "refs/tags");
-	safe_create_dir(sb.buf, 1);
+		strbuf_reset(&sb);
+		files_ref_path(refs, &sb, "refs/tags");
+		safe_create_dir(sb.buf, 1);
+	}
=20
 	strbuf_release(&sb);
 	return 0;
--=20
2.43.GIT


--7kU9pX+ROEeVYNUt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRx8ACgkQVbJhu7ck
PpSAXw//de4bahSlOoxaNpcj03PEN4VDFLhIT53aq03I9m3+TgImPQM0smPD82j8
WDWXKNZG4nUOOl6JqcLNfhMtQB+ritWRJpAoEO2t7bkG5soQbU7jOV8BOozdseTw
lvpKi4RE0x7NQrKkMjBaZ65+V8Bu7YMQjnO/X5DemNVQ/PVRl+31SoDFYwGkUKuB
/wuIvYeyXbAKDPQeq6ssnVdSCXvrwVnrw3OeVJ5jCM4VZK0/rqH754C52G7to+9u
f8rYkeuYG+g5fK3zQpEbs8rGZBk6GXPcyGfGGvbYOaIs/yKZI1eBdU+grUnNi7HE
dB5ibvYIrptARzkYIA0y3DMGZn1TUnW7pX5dCM5RZ4XZ+6Uethda2bTL4KuSCZVM
E8+Y9osYNXufbcNkZXouCMDdiX7uduSnfEZ+jxKSG6DQoInlMYrY06Rdi8Gq5dQ0
yOBZo1lNNBNB0FOO7Hu9POwSKvn3TiwlGyk9LmlHiU/G6nvvWEW+FmDWB99ls68p
3ykSTGe2ORV5ZgnMAiT02t/NsCpDOUA7K8/9UO8/rmcrvj/gVFnigSuX+BIx5NJ+
HU+U6SwZld727yowb0OA1sbunXYDecMbiYoq77/y4DnWbjScYbxlbHYITlrKtqmK
EueOrS9CYu9296sfMIkR4PAMAYlO7EewSXgol9FP8Lw2K/gUjwE=
=ck5R
-----END PGP SIGNATURE-----

--7kU9pX+ROEeVYNUt--
