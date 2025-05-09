Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE12D2957BF
	for <git@vger.kernel.org>; Fri,  9 May 2025 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799943; cv=none; b=UZNykTptpCPCvCr9rdHqq0QxkRK4Ih22Gjc2ss1ZJNhci27+GukLfd+ipCkgEfNKm6KSR2McNj1x8OmjyH4PnlIkKQASwO0ZykLNISjkMDxh9Ks/BTaJ4B9OORDY3mTRL/D9nNdrEtxDJJNRdCFAwSHnuWO+f8ilQkIXa5l4YnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799943; c=relaxed/simple;
	bh=QJ5HkRzSjROtKXQuWvmYWg4EQWWMmazRXHZpBMU9KZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h+K5GJf8TQ5EQu1EqlS5sa99LNC/S3oIwRKwbhxkPt50OLZy3T1bqaIUiZLQ8nVKdIRvzILiTgrKjObC6VkoL2/GiUBR+LBV1gnnuJrxm22PynHM6A9Fope9aAd+OT+YLeFJkeAn6rTQrpQz0QIsR7ujV/ck/64ETWjY9vr5TzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dnbWVsCQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fp7Oi7Qo; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dnbWVsCQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fp7Oi7Qo"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9BB46254013C;
	Fri,  9 May 2025 10:12:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 May 2025 10:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746799939;
	 x=1746886339; bh=VPThfSDVmP7Nj1K+MhJBU/LrKXCs1dwq0Hzir/sqWNI=; b=
	dnbWVsCQLlmtKoHs1giqmrIbqj9IsxRLu3qHFVubPz5xGbOK1jnGbp60AwMeDq96
	YHyPFwGjGB4FHVRN49cmm7x8GFH9rPhS5LHY/6a9FJr1GNGG1VZGPuE2+kYOFwOQ
	F9ovswq48SmrMK74MuL3GBSU3DcuifvAfQRrjjU/pnfb91TRpEweDX1lTv7/Fb7r
	kk1YwRsybuc2ZF8ug0OlDj6Pua+ITsdAqLbcJI3KN1Omxp32456ncwJBkBov9Lg9
	XSzdRoETdcVkyjq0TqzQqj1B0fSDB+OpECF+ezgI7HNBwz0oIor+S60TZHiNze/6
	/pynJnO/tJUXxkvK7WyFoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746799939; x=
	1746886339; bh=VPThfSDVmP7Nj1K+MhJBU/LrKXCs1dwq0Hzir/sqWNI=; b=f
	p7Oi7QoqcpZvKsR+lH7K8yxnVzwIRYtaG1TgBxD1oelxzwiIjRxR/vXI9TlN9Cor
	EgzafrC7Rs8VdKjZpE81tG/LWbKPS0fmYim0v0xBbKWvAjobBrIIFv/6jCjosNGU
	n+sjYh9HqsWnpDkTCu1A7RnQXQhk/l+1s+zvjNBW/WO0tLbcO1bp9rHbG3d4GNg2
	kxmnijRL9ivN5CER6YM582OXTVbLBvdUItTJb0R4MNQ5r5kC1SeWRTzlyOZX3zTq
	NzL1cFNprGWbcDKK2WWoWixOZZsYGXxs3aekccDePpn8Cw+3TD0WxZwLg9WpPH4b
	sr6hRPiRxYfrBRk6q4VhQ==
X-ME-Sender: <xms:Qw0eaLfLIN0_duDrVZzBwt-VMKPM4gjBrrf29N2e7471zTAc6m_oPw>
    <xme:Qw0eaBNDp2TOuqrren7pJLyEmLoSptyJtTEJSDhIVYdvf4I9Aob1qXQBkOGKD2S_V
    C1ZZY-NB77UENb_iw>
X-ME-Received: <xmr:Qw0eaEj5XmhF6fmFPTbrMcMpABvE9AnUzc2QkxuOM3nFDlS47Z0t_V9q63PQ4br0rglMhxB2YYJW9nyETIYWNmXpZXKxN7YTJJEMpEShXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Qw0eaM8_qkdzOmTxo2Rl_iitBNpmQalte7wk1ddFwnCX_a78n6dl2w>
    <xmx:Qw0eaHvp6AlPOoG2UxlNFubzUuz6NxcOdl1H01qP530f-zs1dCZIAA>
    <xmx:Qw0eaLGHOuIPk48xKQXKhghi4ZKJ11WAZRZW3I8nwkj7-QFgVLh5Qw>
    <xmx:Qw0eaONdnvA2DWNjvxhVeA61OOz9oMVE8rQuV838oUUZMOAgeeGXRw>
    <xmx:Qw0eaI4kCw4xRYZrNOnnFqFOF1lIMDzdCFhIIUbX1gl7zWmzEecSfapQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 10:12:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b0ff1438 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 14:12:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 16:12:07 +0200
Subject: [PATCH v2 07/17] odb: get rid of `the_repository` in
 `odb_mkstemp()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-object-store-wo-the-repository-v2-7-103f59bf8e28@pks.im>
References: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
In-Reply-To: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Get rid of our dependency on `the_repository` in `odb_mkstemp()` by
passing in the object database as a parameter and adjusting all callers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c |  3 ++-
 builtin/index-pack.c  |  2 +-
 bundle-uri.c          |  3 ++-
 odb.c                 |  9 +++++----
 odb.h                 |  7 ++++---
 pack-bitmap-write.c   |  3 ++-
 pack-write.c          | 10 ++++++----
 7 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 52c792488e1..413304db9b5 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -763,7 +763,8 @@ static void start_packfile(void)
 	struct packed_git *p;
 	int pack_fd;
 
-	pack_fd = odb_mkstemp(&tmp_file, "pack/tmp_pack_XXXXXX");
+	pack_fd = odb_mkstemp(the_repository->objects, &tmp_file,
+			      "pack/tmp_pack_XXXXXX");
 	FLEX_ALLOC_STR(p, pack_name, tmp_file.buf);
 	strbuf_release(&tmp_file);
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8ce446064e8..8e5acefde40 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -362,7 +362,7 @@ static const char *open_pack_file(const char *pack_name)
 		input_fd = 0;
 		if (!pack_name) {
 			struct strbuf tmp_file = STRBUF_INIT;
-			output_fd = odb_mkstemp(&tmp_file,
+			output_fd = odb_mkstemp(the_repository->objects, &tmp_file,
 						"pack/tmp_pack_XXXXXX");
 			pack_name = strbuf_detach(&tmp_file, NULL);
 		} else {
diff --git a/bundle-uri.c b/bundle-uri.c
index 993ac62c271..87a5ba50945 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -278,7 +278,8 @@ static char *find_temp_filename(void)
 	 * Find a temporary filename that is available. This is briefly
 	 * racy, but unlikely to collide.
 	 */
-	fd = odb_mkstemp(&name, "bundles/tmp_uri_XXXXXX");
+	fd = odb_mkstemp(the_repository->objects, &name,
+			 "bundles/tmp_uri_XXXXXX");
 	if (fd < 0) {
 		warning(_("failed to create temporary file"));
 		return NULL;
diff --git a/odb.c b/odb.c
index d09b8bf00cc..7ff614fb0c7 100644
--- a/odb.c
+++ b/odb.c
@@ -63,7 +63,8 @@ static const struct cached_object *find_cached_object(struct object_database *ob
 	return NULL;
 }
 
-int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
+int odb_mkstemp(struct object_database *odb,
+		struct strbuf *temp_filename, const char *pattern)
 {
 	int fd;
 	/*
@@ -71,15 +72,15 @@ int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
 	 * restrictive except to remove write permission.
 	 */
 	int mode = 0444;
-	repo_git_path_replace(the_repository, temp_filename, "objects/%s", pattern);
+	repo_git_path_replace(odb->repo, temp_filename, "objects/%s", pattern);
 	fd = git_mkstemp_mode(temp_filename->buf, mode);
 	if (0 <= fd)
 		return fd;
 
 	/* slow path */
 	/* some mkstemp implementations erase temp_filename on failure */
-	repo_git_path_replace(the_repository, temp_filename, "objects/%s", pattern);
-	safe_create_leading_directories(the_repository, temp_filename->buf);
+	repo_git_path_replace(odb->repo, temp_filename, "objects/%s", pattern);
+	safe_create_leading_directories(odb->repo, temp_filename->buf);
 	return xmkstemp_mode(temp_filename->buf, mode);
 }
 
diff --git a/odb.h b/odb.h
index 39d896ecd3f..3430089803b 100644
--- a/odb.h
+++ b/odb.h
@@ -191,12 +191,13 @@ void odb_clear(struct object_database *o);
 struct odb_alternate *odb_find_alternate(struct object_database *odb, const char *obj_dir);
 
 /*
- * Create a temporary file rooted in the object database directory, or
- * die on failure. The filename is taken from "pattern", which should have the
+ * Create a temporary file rooted in the primary alternate's directory, or die
+ * on failure. The filename is taken from "pattern", which should have the
  * usual "XXXXXX" trailer, and the resulting filename is written into the
  * "template" buffer. Returns the open descriptor.
  */
-int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
+int odb_mkstemp(struct object_database *odb,
+		struct strbuf *temp_filename, const char *pattern);
 
 void *repo_read_object_file(struct repository *r,
 			    const struct object_id *oid,
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 37648b57125..c847369eaaa 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1052,7 +1052,8 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 
 	struct bitmap_disk_header header;
 
-	int fd = odb_mkstemp(&tmp_file, "pack/tmp_bitmap_XXXXXX");
+	int fd = odb_mkstemp(writer->repo->objects, &tmp_file,
+			     "pack/tmp_bitmap_XXXXXX");
 
 	if (writer->pseudo_merges_nr)
 		options |= BITMAP_OPT_PSEUDO_MERGES;
diff --git a/pack-write.c b/pack-write.c
index 6b06315f80a..eccdc798e36 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -84,7 +84,8 @@ const char *write_idx_file(struct repository *repo,
 	} else {
 		if (!index_name) {
 			struct strbuf tmp_file = STRBUF_INIT;
-			fd = odb_mkstemp(&tmp_file, "pack/tmp_idx_XXXXXX");
+			fd = odb_mkstemp(repo->objects, &tmp_file,
+					 "pack/tmp_idx_XXXXXX");
 			index_name = strbuf_detach(&tmp_file, NULL);
 		} else {
 			unlink(index_name);
@@ -259,7 +260,8 @@ char *write_rev_file_order(struct repository *repo,
 	if (flags & WRITE_REV) {
 		if (!rev_name) {
 			struct strbuf tmp_file = STRBUF_INIT;
-			fd = odb_mkstemp(&tmp_file, "pack/tmp_rev_XXXXXX");
+			fd = odb_mkstemp(repo->objects, &tmp_file,
+					 "pack/tmp_rev_XXXXXX");
 			path = strbuf_detach(&tmp_file, NULL);
 		} else {
 			unlink(rev_name);
@@ -342,7 +344,7 @@ static char *write_mtimes_file(struct repository *repo,
 	if (!to_pack)
 		BUG("cannot call write_mtimes_file with NULL packing_data");
 
-	fd = odb_mkstemp(&tmp_file, "pack/tmp_mtimes_XXXXXX");
+	fd = odb_mkstemp(repo->objects, &tmp_file, "pack/tmp_mtimes_XXXXXX");
 	mtimes_name = strbuf_detach(&tmp_file, NULL);
 	f = hashfd(repo->hash_algo, fd, mtimes_name);
 
@@ -531,7 +533,7 @@ struct hashfile *create_tmp_packfile(struct repository *repo,
 	struct strbuf tmpname = STRBUF_INIT;
 	int fd;
 
-	fd = odb_mkstemp(&tmpname, "pack/tmp_pack_XXXXXX");
+	fd = odb_mkstemp(repo->objects, &tmpname, "pack/tmp_pack_XXXXXX");
 	*pack_tmp_name = strbuf_detach(&tmpname, NULL);
 	return hashfd(repo->hash_algo, fd, *pack_tmp_name);
 }

-- 
2.49.0.1077.gc0e912fd4c.dirty

