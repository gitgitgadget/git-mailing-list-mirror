Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045111F6667
	for <git@vger.kernel.org>; Wed, 14 May 2025 05:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199558; cv=none; b=u0N8N25VRyUbwB632BGO7dWPatjBZLDgJv5uyh4lXoMiFd1g8y6zkPXbTwEolJaBqWnpeezRLTFvpIw6AkgLEFMjkhzfP4IdB3YvhJfoMpNAtoe2VxTpXKeoJLKeaVeiXuP38ehG5eyEuuP7IfHYix02y9uhVQySrfGJdqeP4hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199558; c=relaxed/simple;
	bh=kIC2RwGlLQwB8GUVz/bi5eRFbiDqHaJ6P2z/75QcERk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s5318r/NC8rciS5hqwQsqwCXAUPgAplUG7jflDJpRPViAGuhqwH0k6PFRUwZQb2i+QLjizZ6MNj4iOvR6mToG2Oc4umfGUPayJkTj54L4+Y9zxAT4X7JvU5C2qZbQwZUIzcSkPtbtwUuOKuCY9ruw6MRX5KVzpqSjhPkasb9TCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AJ8u32jQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cFIEdf3s; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AJ8u32jQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cFIEdf3s"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0732A11400E7;
	Wed, 14 May 2025 01:12:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 01:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747199556;
	 x=1747285956; bh=yU1vPIIib7RB7DcILqSWnIYn8i9A1yjiXAYxzys4OFU=; b=
	AJ8u32jQS6qZhhnE3CeTjOF1XPt6jM+vU3M4+Lh05SAtghb/0vq/YnwvNOoZQ+/H
	F3tBO/ptzpL1vLqdb0SIzEB++GPbC1wbWA2fYyD+W+KWV1WLdsFAbbZtLmkYknJ4
	nql7mDyMqTHrAP6xgz+l0u9Wso3g1v6qWCwzy5Y5c7zTTE02E9oXSCDmAZi3lS+/
	/JR5UxvBfsBY1iK4ucLATE+51QyaCcu/BBeNB5ZnFMy8M8sXyiihADUWONwQPQkH
	UuFwq8ZAkCLZK6CSLa+X50e7chLjghEbqE9x0M/IL3vR4XUpiKdL6KS7pEvD8ImS
	1F77WM+hoSOYkr+GEYJjkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747199556; x=
	1747285956; bh=yU1vPIIib7RB7DcILqSWnIYn8i9A1yjiXAYxzys4OFU=; b=c
	FIEdf3sZhSx/ygRKaEosn3g/2VShToREFDfmML+kU83Bf62FIdKrV+9fGL2OVp8b
	xAbsEDJbDQ0MM3rRFUDJE66Tqem23cgc0nWCO2/5DXreS/t5FnhAngXt1VFIDspR
	Za2pHQLR8NM8/iCLsV6qXRx9/6f27gpDJtsROZJ8ayxnpdItrJms6IO1T3D9Zv1u
	T7WyhBD6DpHvl1N5HBF2qvPg9UPQJhrjxNnEK/Vgbm0h5l9udofNtxVTKx8ZSvL1
	HqwQFuj5kghmOO6mQquTnnygCle1Y1YLj2hMYkmtoAWL5PLqD5DRJzqG6Qwj5K0P
	fiHSIcXZqYEnZAevIadvA==
X-ME-Sender: <xms:QyYkaJyZnlMEIH_OgUqPU7cXbYTLncyRcm383LlxPW2Pctl-7rwwJA>
    <xme:QyYkaJSrT0Sxql5uqMmVV6iAbRbwYX7nX0m1fUFQSv65cdyYM3u7V9vWZgTB6dNDG
    kSm8jiuf5YmYQ9Qig>
X-ME-Received: <xmr:QyYkaDVe4yW88Vlupv_RrxuOsd9UgDRtc38BBGdKDBw8mjcWEOCGGabJill5BbsSWkHoj0Rr6zzPCulExtaXcACR2iijsM5oc7lQy3zH-l8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeiudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhn
    sehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:QyYkaLgmMnxsQ4Qfxod0jzK_MRttfskbJU93bslUtfy65klnmbzoMA>
    <xmx:QyYkaLCQB25Snq14n4NcXuhUxnQTJUcyfUvPHvfxJMUbpmTC15p4rg>
    <xmx:QyYkaEJXXSigD3FzQv0bJF5mJtVMenFJ3GoliTu8gf8C0jY9qJL85g>
    <xmx:QyYkaKAEmSv2ugaQ0-FRynkuJVcnItSirCTXCf_P38YbOHfva5ZADQ>
    <xmx:QyYkaDHZc89RrT0Qd4M9_3M4q94lScVZkAQ2Tmx3IC7NT5IfHxGPs8lZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 01:12:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0579c117 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 05:12:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 May 2025 07:12:30 +0200
Subject: [PATCH v3 07/17] odb: get rid of `the_repository` in
 `odb_mkstemp()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-pks-object-store-wo-the-repository-v3-7-47df1d4ead22@pks.im>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
In-Reply-To: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>
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
index e38a46a05c9..eb46eb60edd 100644
--- a/odb.h
+++ b/odb.h
@@ -194,12 +194,13 @@ void odb_clear(struct object_database *o);
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
2.49.0.1141.g47af616452.dirty

