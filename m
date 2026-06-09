Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BD43E3DA6
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995074; cv=none; b=h4P4VZC1nOl6K7iIQkBy4LCo/6WjovNWfe4YFfjj5BjHx2vHpB49hWmhntnF8g/eX8ge0uco5rNuSmhcqQ7uUCV1VgJ4l244ProplmFBlASweVxAz3YURrVfrI9Pqz8sF2s9nJv9LLMtLCejq5Al0ffyYDMrKUJeiKBFAAg+pms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995074; c=relaxed/simple;
	bh=Kw+iNwMpyuH3wkcw6VpRJDqJYDBMn/rLFPmRtRaJOtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bck2e384rnBptiVqIiRsV0YPfBDMcSQ7CVLdxuWnu3KAUYVD1TxKykZRQYeFq8Dr23k2e/qfDV3kgUNgSmwJVxzsoIzkCvBz1AGTMAQ2mKLnwy+Zfg659G1FtohM9sOmh5Tifk8vaJzwd/ZOxb+fWW8FBQG2xXPJ8fmNOy2l9ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lx9a2GKb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ldQDUVbW; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lx9a2GKb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ldQDUVbW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 611B21D00189;
	Tue,  9 Jun 2026 04:51:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 09 Jun 2026 04:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780995071;
	 x=1781081471; bh=mywmJ98vvnSGt7ES64B+yNCPizDsPd36N/cAy23RitM=; b=
	lx9a2GKbNN6fCP/cfKSLXC5swez5HltZJ+hVM1ddv4O/RVy/L+ltDxJc/R2ELuZh
	wQK5FWhkKbZyp3fhQgfdh/lxO1b/tFT53cf67+Djv/O/npBT4RX4iot7cCmmAnhy
	aUF+EC6VDASWJbt6zCx1QdyIvth6D5F7JiDe/uBpAm0+p93PIPZliFuz8g+GTRj5
	r7X/zFmMVGDyyGska2Po7W148RDG7VmkGV8+SIfHaBDLW/LFePndqRkUKqlHlNt2
	qSwIim/uRtha6ocup2s+OKVBQoJzATlYZP7R6tDPsOSkxaU1ltlVLZZDzG7SqFdr
	SMoxJtwSDi2EV0mE4PCMOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780995071; x=
	1781081471; bh=mywmJ98vvnSGt7ES64B+yNCPizDsPd36N/cAy23RitM=; b=l
	dQDUVbW/NjdpAUTGsrO6Tl8T9qu4cqEAM94rnPUTyl2cYx7JbtDsTsAZZLPFVQ0Z
	/aCrlSqk7KawJnh5JcDWS0rg07+TY1KfTq55TMF5vlCRbe00c41TGgkJhu28pcZW
	LqhPzIpQDj4kTTgsg1wWwNRzAwUxHshMhPP5UbisJKw2efB2rufvqzdD32CVyMpH
	Hv+72VGaAjK/7jyp+PE6Aez1cXqQywUI1cCUDWTYDstLi71blv8PI6BIuDLrIcHM
	LsxS3qbqPZ0LjNsaGFN1KPVc9aRz37aZSA3TSPvHU+PHrzOXOmCM4vHVx9Fl2p/h
	K2nZk9zRv7y7LScDt1UkQ==
X-ME-Sender: <xms:_9MnagG9Vi-K8PFYbXbenzIwbOCMoJ1C_RnoETPtYoe4QuNUnLqIRA>
    <xme:_9MnavX-PAkL-pRJVldImXGKODs7nQJhrCC19nSeO84zCeTq4MMemEcmN43ATbB33
    OgY-sBcSm4MY720hT_OCZhbRwUVcdZHzrAjfQdFVf7ViGlK8-EMUQ>
X-ME-Received: <xmr:_9MnanyiLXDfwqqrZiaw3GOLO7mLQPHUl6T3LnRjFT4NJ3M2BtPipbgERSncdPo5aCQjShraXtWFZGuOW6PxIigcTpCMps8SOYkhm6DcUgE>
X-ME-Proxy-Cause: dmFkZTFScmXmBNtXOl4rqVqM8DAc19fyHinqrfJGsNjV/CE2oHckwvnGyvDfLnNUuwKybL
    TXXNE7zDSLzm9sqK7QnFjZefXQ77hB0yUpUORZINqHtbw80x5HeASQHzHrphN1o87wLUDo
    o+b2Dx90Cc3HLmwbZsks1v5Qe3wgVjPUMwX4Epw71mRv/T8ItHrE8RkWZrv81HY9CRlc3Z
    /OiNXFOpQwrN765XqADbyILD80acXbo1GJdpcquKP94bmw57TBOmknCC1tOk25qwSfgaav
    egwmPIOD8ZPaE7+A6cnzDiyYUxaYdFHC73rr/JrclTuz03BNq0lnxnglgQ3GRx5+ugY1FZ
    TP9SfXKve5gD3qC4Fc1J70fZEoQQ3BVS5A6X7mf9MXLEtut3Ol84o0PwrvS7zuWl32lsUF
    TFiACzVGBQNTtKxPWE2SzEy5px2MmjLxqNpDu6hFUGELu+k1DYtUu0jj1ju2axBwHZF87B
    oFBJ9bMqhkRb0o/DvNzmDo1R9A49MLngwvwtyK6rYnxTO8OivmnT+gG0qyeGvNqbCLEuX1
    Y+ZbBkMuKT983uXrjHC4glCAn3vKPPsIz/bIBamGNBZSvIo0vLzyaWRyHVO1sd4OAYg5bL
    giQSC0R1HCJu35qPtl3mPSqw1afcgyzwKvb7ZF7jdjs0QWQEw+0kzGV5NVjw
X-ME-Proxy: <xmx:_9MnatPfkz0mxjByJ7CPopSgFLZf1ZFXxE19Lx6vlgzhVEHk0kUrRA>
    <xmx:_9Mnao5cWE1_Yjr2ixqW13nGqlSO5v_X2yU9TXlrlbZAmELfRDt6mQ>
    <xmx:_9MnauPnRmaF0En3T3XwOFXrEVINmZeCmcD89MPxtpomNiFWfzNR5Q>
    <xmx:_9MnamlgX7tSp61lvwZDD8ZM6_t0QfrN5gG6e8OLWKoqAddgp6rw-Q>
    <xmx:_9Mnag3gWSmWxYYk-COIn6DhUPUrUilDKNwvSAVln0PZQBJwHyWjRU14>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:51:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 39143bb4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 08:51:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Jun 2026 10:50:54 +0200
Subject: [PATCH v2 01/17] packfile: rename `struct packfile_store` to
 `odb_source_packed`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-pks-odb-source-packed-v2-1-839089132c8b@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
In-Reply-To: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Not too long ago, we have introduced the packfile store in b7983adb51
(packfile: introduce a new `struct packfile_store`, 2025-09-23). This
struct is responsible for managing all of our access to packfiles and is
used as one of the two sources of objects for the "files" source.

Back when I introduced this structure I didn't have the clear vision yet
that it will eventually also turn into a proper object database source,
and how exactly that infrastructure will look like. Now though it's
becoming increasingly clear that it does make sense to treat it just the
same as any of our other ODB sources.

The consequence is that the naming is now a bit out-of-date: it's just
another source and will be turned into a proper `struct odb_source` over
the next couple of commits, but it's not named accordingly.

Rename the structure to `odb_source_packed` to align it with this goal
and to bring it in line with the other sources we already have.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.h |  4 ++--
 packfile.c         | 56 +++++++++++++++++++++++++++---------------------------
 packfile.h         | 32 +++++++++++++++----------------
 3 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/odb/source-files.h b/odb/source-files.h
index 23a3b4e04b..d7ac3c1c81 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -4,7 +4,7 @@
 #include "odb/source.h"
 
 struct odb_source_loose;
-struct packfile_store;
+struct odb_source_packed;
 
 /*
  * The files object database source uses a combination of loose objects and
@@ -13,7 +13,7 @@ struct packfile_store;
 struct odb_source_files {
 	struct odb_source base;
 	struct odb_source_loose *loose;
-	struct packfile_store *packed;
+	struct odb_source_packed *packed;
 };
 
 /* Allocate and initialize a new object source. */
diff --git a/packfile.c b/packfile.c
index 89366abfe3..a2d768d0ae 100644
--- a/packfile.c
+++ b/packfile.c
@@ -859,7 +859,7 @@ struct packed_git *add_packed_git(struct repository *r, const char *path,
 	return p;
 }
 
-void packfile_store_add_pack(struct packfile_store *store,
+void packfile_store_add_pack(struct odb_source_packed *store,
 			     struct packed_git *pack)
 {
 	if (pack->pack_fd != -1)
@@ -869,7 +869,7 @@ void packfile_store_add_pack(struct packfile_store *store,
 	strmap_put(&store->packs_by_path, pack->pack_name, pack);
 }
 
-struct packed_git *packfile_store_load_pack(struct packfile_store *store,
+struct packed_git *packfile_store_load_pack(struct odb_source_packed *store,
 					    const char *idx_path, int local)
 {
 	struct strbuf key = STRBUF_INIT;
@@ -1068,7 +1068,7 @@ static int sort_pack(const struct packfile_list_entry *a,
 	return -1;
 }
 
-void packfile_store_prepare(struct packfile_store *store)
+void packfile_store_prepare(struct odb_source_packed *store)
 {
 	if (store->initialized)
 		return;
@@ -1084,13 +1084,13 @@ void packfile_store_prepare(struct packfile_store *store)
 	store->initialized = true;
 }
 
-void packfile_store_reprepare(struct packfile_store *store)
+void packfile_store_reprepare(struct odb_source_packed *store)
 {
 	store->initialized = false;
 	packfile_store_prepare(store);
 }
 
-struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *store)
+struct packfile_list_entry *packfile_store_get_packs(struct odb_source_packed *store)
 {
 	packfile_store_prepare(store);
 
@@ -1103,7 +1103,7 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
 	return store->packs.head;
 }
 
-int packfile_store_count_objects(struct packfile_store *store,
+int packfile_store_count_objects(struct odb_source_packed *store,
 				 enum odb_count_objects_flags flags UNUSED,
 				 unsigned long *out)
 {
@@ -2160,7 +2160,7 @@ static int fill_pack_entry(const struct object_id *oid,
 	return 1;
 }
 
-static int find_pack_entry(struct packfile_store *store,
+static int find_pack_entry(struct odb_source_packed *store,
 			   const struct object_id *oid,
 			   struct pack_entry *e)
 {
@@ -2183,7 +2183,7 @@ static int find_pack_entry(struct packfile_store *store,
 	return 0;
 }
 
-int packfile_store_freshen_object(struct packfile_store *store,
+int packfile_store_freshen_object(struct odb_source_packed *store,
 				  const struct object_id *oid)
 {
 	struct pack_entry e;
@@ -2199,7 +2199,7 @@ int packfile_store_freshen_object(struct packfile_store *store,
 	return 1;
 }
 
-int packfile_store_read_object_info(struct packfile_store *store,
+int packfile_store_read_object_info(struct odb_source_packed *store,
 				    const struct object_id *oid,
 				    struct object_info *oi,
 				    enum object_info_flags flags)
@@ -2234,7 +2234,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	return 0;
 }
 
-static void maybe_invalidate_kept_pack_cache(struct packfile_store *store,
+static void maybe_invalidate_kept_pack_cache(struct odb_source_packed *store,
 					     unsigned flags)
 {
 	if (!store->kept_cache.packs)
@@ -2245,7 +2245,7 @@ static void maybe_invalidate_kept_pack_cache(struct packfile_store *store,
 	store->kept_cache.flags = 0;
 }
 
-struct packed_git **packfile_store_get_kept_pack_cache(struct packfile_store *store,
+struct packed_git **packfile_store_get_kept_pack_cache(struct odb_source_packed *store,
 						       unsigned flags)
 {
 	maybe_invalidate_kept_pack_cache(store, flags);
@@ -2365,8 +2365,8 @@ int for_each_object_in_pack(struct packed_git *p,
 	return r;
 }
 
-struct packfile_store_for_each_object_wrapper_data {
-	struct packfile_store *store;
+struct odb_source_packed_for_each_object_wrapper_data {
+	struct odb_source_packed *store;
 	const struct object_info *request;
 	odb_for_each_object_cb cb;
 	void *cb_data;
@@ -2377,7 +2377,7 @@ static int packfile_store_for_each_object_wrapper(const struct object_id *oid,
 						  uint32_t index_pos,
 						  void *cb_data)
 {
-	struct packfile_store_for_each_object_wrapper_data *data = cb_data;
+	struct odb_source_packed_for_each_object_wrapper_data *data = cb_data;
 
 	if (data->request) {
 		off_t offset = nth_packed_object_offset(pack, index_pos);
@@ -2411,10 +2411,10 @@ static int match_hash(unsigned len, const unsigned char *a, const unsigned char
 }
 
 static int for_each_prefixed_object_in_midx(
-	struct packfile_store *store,
+	struct odb_source_packed *store,
 	struct multi_pack_index *m,
 	const struct odb_for_each_object_options *opts,
-	struct packfile_store_for_each_object_wrapper_data *data)
+	struct odb_source_packed_for_each_object_wrapper_data *data)
 {
 	int ret;
 
@@ -2470,10 +2470,10 @@ static int for_each_prefixed_object_in_midx(
 }
 
 static int for_each_prefixed_object_in_pack(
-	struct packfile_store *store,
+	struct odb_source_packed *store,
 	struct packed_git *p,
 	const struct odb_for_each_object_options *opts,
-	struct packfile_store_for_each_object_wrapper_data *data)
+	struct odb_source_packed_for_each_object_wrapper_data *data)
 {
 	uint32_t num, i, first = 0;
 	int len = opts->prefix_hex_len > p->repo->hash_algo->hexsz ?
@@ -2519,9 +2519,9 @@ static int for_each_prefixed_object_in_pack(
 }
 
 static int packfile_store_for_each_prefixed_object(
-	struct packfile_store *store,
+	struct odb_source_packed *store,
 	const struct odb_for_each_object_options *opts,
-	struct packfile_store_for_each_object_wrapper_data *data)
+	struct odb_source_packed_for_each_object_wrapper_data *data)
 {
 	struct packfile_list_entry *e;
 	struct multi_pack_index *m;
@@ -2566,13 +2566,13 @@ static int packfile_store_for_each_prefixed_object(
 	return ret;
 }
 
-int packfile_store_for_each_object(struct packfile_store *store,
+int packfile_store_for_each_object(struct odb_source_packed *store,
 				   const struct object_info *request,
 				   odb_for_each_object_cb cb,
 				   void *cb_data,
 				   const struct odb_for_each_object_options *opts)
 {
-	struct packfile_store_for_each_object_wrapper_data data = {
+	struct odb_source_packed_for_each_object_wrapper_data data = {
 		.store = store,
 		.request = request,
 		.cb = cb,
@@ -2707,7 +2707,7 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 	*out = len;
 }
 
-int packfile_store_find_abbrev_len(struct packfile_store *store,
+int packfile_store_find_abbrev_len(struct odb_source_packed *store,
 				   const struct object_id *oid,
 				   unsigned min_len,
 				   unsigned *out)
@@ -2832,16 +2832,16 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
 	return 0;
 }
 
-struct packfile_store *packfile_store_new(struct odb_source *source)
+struct odb_source_packed *packfile_store_new(struct odb_source *source)
 {
-	struct packfile_store *store;
+	struct odb_source_packed *store;
 	CALLOC_ARRAY(store, 1);
 	store->source = source;
 	strmap_init(&store->packs_by_path);
 	return store;
 }
 
-void packfile_store_free(struct packfile_store *store)
+void packfile_store_free(struct odb_source_packed *store)
 {
 	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
 		free(e->pack);
@@ -2851,7 +2851,7 @@ void packfile_store_free(struct packfile_store *store)
 	free(store);
 }
 
-void packfile_store_close(struct packfile_store *store)
+void packfile_store_close(struct odb_source_packed *store)
 {
 	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next) {
 		if (e->pack->do_not_close)
@@ -2988,7 +2988,7 @@ int packfile_read_object_stream(struct odb_read_stream **out,
 }
 
 int packfile_store_read_object_stream(struct odb_read_stream **out,
-				      struct packfile_store *store,
+				      struct odb_source_packed *store,
 				      const struct object_id *oid)
 {
 	struct pack_entry e;
diff --git a/packfile.h b/packfile.h
index 49d6bdecf6..9cec15bc50 100644
--- a/packfile.h
+++ b/packfile.h
@@ -79,7 +79,7 @@ struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
 /*
  * A store that manages packfiles for a given object database.
  */
-struct packfile_store {
+struct odb_source_packed {
 	struct odb_source *source;
 
 	/*
@@ -138,19 +138,19 @@ struct packfile_store {
  * Allocate and initialize a new empty packfile store for the given object
  * database source.
  */
-struct packfile_store *packfile_store_new(struct odb_source *source);
+struct odb_source_packed *packfile_store_new(struct odb_source *source);
 
 /*
  * Free the packfile store and all its associated state. All packfiles
  * tracked by the store will be closed.
  */
-void packfile_store_free(struct packfile_store *store);
+void packfile_store_free(struct odb_source_packed *store);
 
 /*
  * Close all packfiles associated with this store. The packfiles won't be
  * free'd, so they can be re-opened at a later point in time.
  */
-void packfile_store_close(struct packfile_store *store);
+void packfile_store_close(struct odb_source_packed *store);
 
 /*
  * Prepare the packfile store by loading packfiles and multi-pack indices for
@@ -159,7 +159,7 @@ void packfile_store_close(struct packfile_store *store);
  * It shouldn't typically be necessary to call this function directly, as
  * functions that access the store know to prepare it.
  */
-void packfile_store_prepare(struct packfile_store *store);
+void packfile_store_prepare(struct odb_source_packed *store);
 
 /*
  * Clear the packfile caches and try to look up any new packfiles that have
@@ -167,20 +167,20 @@ void packfile_store_prepare(struct packfile_store *store);
  *
  * This function must be called under the `odb_read_lock()`.
  */
-void packfile_store_reprepare(struct packfile_store *store);
+void packfile_store_reprepare(struct odb_source_packed *store);
 
 /*
  * Add the pack to the store so that contained objects become accessible via
  * the store. This moves ownership into the store.
  */
-void packfile_store_add_pack(struct packfile_store *store,
+void packfile_store_add_pack(struct odb_source_packed *store,
 			     struct packed_git *pack);
 
 /*
  * Get all packs managed by the given store, including packfiles that are
  * referenced by multi-pack indices.
  */
-struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *store);
+struct packfile_list_entry *packfile_store_get_packs(struct odb_source_packed *store);
 
 struct repo_for_each_pack_data {
 	struct odb_source *source;
@@ -239,7 +239,7 @@ static inline void repo_for_each_pack_data_next(struct repo_for_each_pack_data *
 	     repo_for_each_pack_data_next(&eack_pack_data))
 
 int packfile_store_read_object_stream(struct odb_read_stream **out,
-				      struct packfile_store *store,
+				      struct odb_source_packed *store,
 				      const struct object_id *oid);
 
 /*
@@ -248,7 +248,7 @@ int packfile_store_read_object_stream(struct odb_read_stream **out,
  * not found, 0 if it was and read successfully, and a negative error code in
  * case the object was corrupted.
  */
-int packfile_store_read_object_info(struct packfile_store *store,
+int packfile_store_read_object_info(struct odb_source_packed *store,
 				    const struct object_id *oid,
 				    struct object_info *oi,
 				    enum object_info_flags flags);
@@ -258,10 +258,10 @@ int packfile_store_read_object_info(struct packfile_store *store,
  * either the newly opened packfile or the preexisting packfile. Returns a
  * `NULL` pointer in case the packfile could not be opened.
  */
-struct packed_git *packfile_store_load_pack(struct packfile_store *store,
+struct packed_git *packfile_store_load_pack(struct odb_source_packed *store,
 					    const char *idx_path, int local);
 
-int packfile_store_freshen_object(struct packfile_store *store,
+int packfile_store_freshen_object(struct odb_source_packed *store,
 				  const struct object_id *oid);
 
 enum kept_pack_type {
@@ -276,7 +276,7 @@ enum kept_pack_type {
  *
  * Return 0 on success, a negative error code otherwise.
  */
-int packfile_store_count_objects(struct packfile_store *store,
+int packfile_store_count_objects(struct odb_source_packed *store,
 				 enum odb_count_objects_flags flags,
 				 unsigned long *out);
 
@@ -285,7 +285,7 @@ int packfile_store_count_objects(struct packfile_store *store,
  * combination of `kept_pack_type` flags. The cache is computed on demand and
  * will be recomputed whenever the flags change.
  */
-struct packed_git **packfile_store_get_kept_pack_cache(struct packfile_store *store,
+struct packed_git **packfile_store_get_kept_pack_cache(struct odb_source_packed *store,
 						       unsigned flags);
 
 struct pack_window {
@@ -365,13 +365,13 @@ int for_each_object_in_pack(struct packed_git *p,
  *
  * The flags parameter is a combination of `odb_for_each_object_flags`.
  */
-int packfile_store_for_each_object(struct packfile_store *store,
+int packfile_store_for_each_object(struct odb_source_packed *store,
 				   const struct object_info *request,
 				   odb_for_each_object_cb cb,
 				   void *cb_data,
 				   const struct odb_for_each_object_options *opts);
 
-int packfile_store_find_abbrev_len(struct packfile_store *store,
+int packfile_store_find_abbrev_len(struct odb_source_packed *store,
 				   const struct object_id *oid,
 				   unsigned min_len,
 				   unsigned *out);

-- 
2.54.0.1136.gdb2ca164c4.dirty

