Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6101F2882D7
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040932; cv=none; b=RWWYdLzaJefbBRRF7m2zoNj/hqadLT81VSh7tJtYkpp3loE1heIurLSTjLGz5NB1qQexY2YInyIQlwCDHeRKEFQXOLs8hZ1T2mswKTRRCitlfD8eMRXlemYqAUdOQT+eFtnxZXunCdmOaUN1QaZzLN4LLsGWwnNQFNS0vhsnxV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040932; c=relaxed/simple;
	bh=bBW5Ras0rJyLTuUmzBdENkPqOJLrDuwf9c2J+6PWMZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d4JR095Wmo5hNGxhk6qnv/MDe+ge8MnTS0nKI3Pc3uRmoJEHwFWqm4GipUhYKbbsRn0ApOKzGkPdEfTpewSQyRH06MvHDc5wpB1h+sNz0Ih0Cn90ikPC9cwKGCIg1KB2qfOrFqbhkgybGlIpPbR8unAkLVSRGZmAVGnkbCAgDuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fZ7C+ZEB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YefYwFjf; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fZ7C+ZEB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YefYwFjf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 915C77A016A;
	Thu, 18 Dec 2025 01:55:29 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 18 Dec 2025 01:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766040929;
	 x=1766127329; bh=G7/lqDzH0LI+RwQ6hWLOrNx89kKtW3QD27ZWO5RGKvA=; b=
	fZ7C+ZEBPUic+pY9Y/LphY1xvTuTdoMP67LJURQtBTYDAHY6oXYtJu7g8Oqw+qm2
	9Zel3tJnh5tpa32d/uxhcIKdB7cfCcVaKmIuzPcoxYA3Kv8PNWfu5FKT0zQ8I5Wm
	pLD0NdMRTexxcj3VRxlKPwQGWYUgiaz9UQWZj+uQvMpxqPLGDxedHmcOloJDMj85
	2wasxCX0SAXqSu/2zYX2WDMWwGG6U+Eqvo37OLGh2tTQPxuQXSu9akJ1zOCJ1zl6
	4QtIRBDbN9dkxRJwy1Q/13aDdX/9ibgOofcyEmz7Htrli3aHQPwgi5CSrUrrX/Ui
	fcI0fkqfr+pIeB00Ln0fMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766040929; x=
	1766127329; bh=G7/lqDzH0LI+RwQ6hWLOrNx89kKtW3QD27ZWO5RGKvA=; b=Y
	efYwFjfDDPOloT53G3OXKICGt54PpGvufIesWwJ3fePxWHtWvhGZdHuui4meUde2
	CCnxks85tTppimKFGLDIZpoOjgUM9srr8mF1w2ELl6FUFkU4L6NUwMPLVVLskkj+
	GrzpfLtDueI2AK3hDf4wkLU5wGzN0CN9sIZWXxhVG7LmLLwS/VqKMPtqVhMBp5cC
	djg1P//Zd2V5oLo+bEwnL95sdFH+52VwYTMKoiVQT88N5QUd2Da8RSkK7nI5gp/y
	rcUQzcFlOdfKaq5avr9mdmpVYjs537+p7SbWRb3Kfe08anqpmOtB5a5RHcyPg+Xr
	YrExYVqpNDYOMgVlokCoQ==
X-ME-Sender: <xms:YaVDaYWRTDafF0MZ0Dk3fnkypftthepxV-BvbGNpV4iU5V1_Ww2Ndw>
    <xme:YaVDaSkThz4CCQB0o2ey-eE7jtezDMZTiXck2kvAVR38x1wOqsA6Dsh5AxPogFCYn
    dbmmRUR7_LoFs1D87jw-bNDdkm30qxPA5ObaP5RDz31LNMnmSqChQ>
X-ME-Received: <xmr:YaVDaaD0zmZiuuydm22m15_4MrAQIhq5EFpvF6M_MeUiw2idOp4EenbOx0YDifRkqxE5cqNeimg-hENPGV4Lks2CXjeNfxkoFsBQ50HvTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epkeeiveevgeeiveeiueevfeehffegueehteehgeffffekieejtdeufeelffdvveelnecu
    ffhomhgrihhnpehprggtkhgvugdrihhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:YaVDaScxQCEJdHfYmvfBaKe-Ew4i8n5vw1CEvkMkvs85yHFV7AlfaA>
    <xmx:YaVDaVJ1OOCQzrHd2-tthXsexJqNfVTDw8FnG-3Gqa_PxLp6cUwMpA>
    <xmx:YaVDaVeLoRLY2o2gkHDvL8IR7uQisQinl2yB_b35veR3WkYkO-Rd1w>
    <xmx:YaVDac0wwdOlHopAMuKfiS316q6_2M6_Y-yCzruoyGQuhIB1-eJAKw>
    <xmx:YaVDadFc2gY5b3BboCJ5GfoFOdCDOF-JNk4ZoK3GKpLO3SYRUrVil0K7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:55:28 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2790f8e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:55:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 07:55:20 +0100
Subject: [PATCH v2 01/10] packfile: create store via its owning source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-pack-store-via-source-v2-1-62849007ce21@pks.im>
References: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
In-Reply-To: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

In subsequent patches we're about to move the packfile store from the
object database layer into the object database source layer. Once done,
we'll have one packfile store per source, where the source is owning the
store.

Prepare for this future and refactor `packfile_store_new()` to be
initialized via an object database source instead of via the object
database itself.

This refactoring leads to a weird in-between state where the store is
owned by the object database but created via the source. But this makes
subsequent refactorings easier because we can now start to access the
owning source of a given store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c      |  2 +-
 packfile.c | 20 ++++++++++----------
 packfile.h |  6 +++---
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/odb.c b/odb.c
index 45b6600800..94144a69f5 100644
--- a/odb.c
+++ b/odb.c
@@ -1056,7 +1056,6 @@ struct object_database *odb_new(struct repository *repo,
 
 	memset(o, 0, sizeof(*o));
 	o->repo = repo;
-	o->packfiles = packfile_store_new(o);
 	pthread_mutex_init(&o->replace_mutex, NULL);
 	string_list_init_dup(&o->submodule_source_paths);
 
@@ -1065,6 +1064,7 @@ struct object_database *odb_new(struct repository *repo,
 	o->sources = odb_source_new(o, primary_source, true);
 	o->sources_tail = &o->sources->next;
 	o->alternate_db = xstrdup_or_null(secondary_sources);
+	o->packfiles = packfile_store_new(o->sources);
 
 	free(to_free);
 
diff --git a/packfile.c b/packfile.c
index c88bd92619..0a05a10daa 100644
--- a/packfile.c
+++ b/packfile.c
@@ -876,7 +876,7 @@ struct packed_git *packfile_store_load_pack(struct packfile_store *store,
 
 	p = strmap_get(&store->packs_by_path, key.buf);
 	if (!p) {
-		p = add_packed_git(store->odb->repo, idx_path,
+		p = add_packed_git(store->source->odb->repo, idx_path,
 				   strlen(idx_path), local);
 		if (p)
 			packfile_store_add_pack(store, p);
@@ -1068,8 +1068,8 @@ void packfile_store_prepare(struct packfile_store *store)
 	if (store->initialized)
 		return;
 
-	odb_prepare_alternates(store->odb);
-	for (source = store->odb->sources; source; source = source->next) {
+	odb_prepare_alternates(store->source->odb);
+	for (source = store->source->odb->sources; source; source = source->next) {
 		prepare_multi_pack_index_one(source);
 		prepare_packed_git_one(source);
 	}
@@ -1092,7 +1092,7 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
 {
 	packfile_store_prepare(store);
 
-	for (struct odb_source *source = store->odb->sources; source; source = source->next) {
+	for (struct odb_source *source = store->source->odb->sources; source; source = source->next) {
 		struct multi_pack_index *m = source->midx;
 		if (!m)
 			continue;
@@ -2121,7 +2121,7 @@ int packfile_store_freshen_object(struct packfile_store *store,
 				  const struct object_id *oid)
 {
 	struct pack_entry e;
-	if (!find_pack_entry(store->odb->repo, oid, &e))
+	if (!find_pack_entry(store->source->odb->repo, oid, &e))
 		return 0;
 	if (e.p->is_cruft)
 		return 0;
@@ -2142,7 +2142,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	struct pack_entry e;
 	int rtype;
 
-	if (!find_pack_entry(store->odb->repo, oid, &e))
+	if (!find_pack_entry(store->source->odb->repo, oid, &e))
 		return 1;
 
 	/*
@@ -2152,7 +2152,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	if (oi == &blank_oi)
 		return 0;
 
-	rtype = packed_object_info(store->odb->repo, e.p, e.offset, oi);
+	rtype = packed_object_info(store->source->odb->repo, e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, oid);
 		return -1;
@@ -2411,11 +2411,11 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
 	return 0;
 }
 
-struct packfile_store *packfile_store_new(struct object_database *odb)
+struct packfile_store *packfile_store_new(struct odb_source *source)
 {
 	struct packfile_store *store;
 	CALLOC_ARRAY(store, 1);
-	store->odb = odb;
+	store->source = source;
 	strmap_init(&store->packs_by_path);
 	return store;
 }
@@ -2534,7 +2534,7 @@ int packfile_store_read_object_stream(struct odb_read_stream **out,
 
 	if (packfile_store_read_object_info(store, oid, &oi, 0) ||
 	    oi.u.packed.is_delta ||
-	    repo_settings_get_big_file_threshold(store->odb->repo) >= size)
+	    repo_settings_get_big_file_threshold(store->source->odb->repo) >= size)
 		return -1;
 
 	in_pack_type = unpack_object_header(oi.u.packed.pack,
diff --git a/packfile.h b/packfile.h
index 59d162a3f4..33cc1c1654 100644
--- a/packfile.h
+++ b/packfile.h
@@ -77,7 +77,7 @@ struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
  * A store that manages packfiles for a given object database.
  */
 struct packfile_store {
-	struct object_database *odb;
+	struct odb_source *source;
 
 	/*
 	 * The list of packfiles in the order in which they have been most
@@ -129,9 +129,9 @@ struct packfile_store {
 
 /*
  * Allocate and initialize a new empty packfile store for the given object
- * database.
+ * database source.
  */
-struct packfile_store *packfile_store_new(struct object_database *odb);
+struct packfile_store *packfile_store_new(struct odb_source *source);
 
 /*
  * Free the packfile store and all its associated state. All packfiles

-- 
2.52.0.351.gbe84eed79e.dirty

