Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820B9C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiKGShk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiKGShE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:37:04 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F8424953
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:27 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g12so17517830wrs.10
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y95nN9gSVOv1U3X11AiaCeJzCGdcu0mcG5NIL8+Q140=;
        b=BL9a7sgu8N3GSYfAbE1chxjA1oKGxS9rdph4Dv72DMGRp8M3CLZyD7SEPoGBfS0ec+
         24vtfekTRB4FuDaDhQPMXFHgGPbvszVlZHWNDpTdWDqdiqJS33Z3LFwvBOOBjh2s7AOE
         u7+Xai1GJG1j6dQYTpaRjM3E2M1AKFEwvyt9pMgV7gCURUUhp9hqwvhwlb1N303Mfcvv
         JdiSabzWDnoxR6ghqZtGx0cpWJeaQyZefbt+V7Q2Z9UznArjGCM6c/NHiugkBWulVBvF
         YnqNgYUw3nN5K3DmthkDGQpSVsdYbzj71smBTDZWqk8iiVQedDs7k3xxoojVuIWlb+zL
         cxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y95nN9gSVOv1U3X11AiaCeJzCGdcu0mcG5NIL8+Q140=;
        b=Tz4nXdPnWm/gMsDxGvr4E+j6ExlqwKWgcth7Sfk2Dd/Rkv0K/FezZ1qYedoJciBvc0
         73wEPtbk0dGBi2U1oOPGWDc2mqB5cRuudFIW89RFrvoW0jQMDipoN7vLZjH74URbdDL8
         4hBsYCbPQswSLh1O+QYXAhKlxQUkG4fD9lE2LQ4sG5BaupUpVUviaLYCEadvzNTyl+/6
         NdM0VJ0VbGnAsjwhc0xgAV0iOcbGrhje5Z1q8b5owK+yuktBmqY7kl8SBD0PMguGI56d
         Lr92E/0NZZLvNek7JMlm/GBAHx9A6sIvAmnbfSaGQgoUdEcXfdKDKZDGgV9VaAgXc8nB
         ry0A==
X-Gm-Message-State: ACrzQf3RHqmbKJjYf2bndL2/BTfgNZXp3aJCTLHPCVlylATJV51y2IRQ
        oaVqC0zzKr7XCQzltABBu6ZoddNjD2g=
X-Google-Smtp-Source: AMsMyM5otmtJ4cDc4gg60ZDEg85sElCELPVfmJpfUpifJOfhuag6KvDdhrmVCZc+L3BN9W+/W4v0zw==
X-Received: by 2002:a5d:590d:0:b0:236:4ddd:1869 with SMTP id v13-20020a5d590d000000b002364ddd1869mr31385949wrd.709.1667846185508;
        Mon, 07 Nov 2022 10:36:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2-20020a7bcb42000000b003cf4ec90938sm8885100wmj.21.2022.11.07.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:25 -0800 (PST)
Message-Id: <701c5ad22e7787cfd27628ff613b7849e24fc675.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:53 +0000
Subject: [PATCH 19/30] packed-refs: read file format v2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 refs/packed-backend.c   | 129 ++++++++++++++++---------
 refs/packed-backend.h   |  72 ++++++++++++--
 refs/packed-format-v2.c | 209 ++++++++++++++++++++++++++++++++++++++++
 t/t3212-ref-formats.sh  |  17 +++-
 4 files changed, 372 insertions(+), 55 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 3429e63620a..549cce1f84a 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -66,7 +66,7 @@ void clear_snapshot_buffer(struct snapshot *snapshot)
  * Decrease the reference count of `*snapshot`. If it goes to zero,
  * free `*snapshot` and return true; otherwise return false.
  */
-static int release_snapshot(struct snapshot *snapshot)
+int release_snapshot(struct snapshot *snapshot)
 {
 	if (!--snapshot->referrers) {
 		stat_validity_clear(&snapshot->validity);
@@ -142,7 +142,6 @@ static int load_contents(struct snapshot *snapshot)
 {
 	int fd;
 	struct stat st;
-	size_t size;
 	ssize_t bytes_read;
 
 	if (!packed_refs_enabled(snapshot->refs->store_flags))
@@ -168,25 +167,25 @@ static int load_contents(struct snapshot *snapshot)
 
 	if (fstat(fd, &st) < 0)
 		die_errno("couldn't stat %s", snapshot->refs->path);
-	size = xsize_t(st.st_size);
+	snapshot->buflen = xsize_t(st.st_size);
 
-	if (!size) {
+	if (!snapshot->buflen) {
 		close(fd);
 		return 0;
-	} else if (mmap_strategy == MMAP_NONE || size <= SMALL_FILE_SIZE) {
-		snapshot->buf = xmalloc(size);
-		bytes_read = read_in_full(fd, snapshot->buf, size);
-		if (bytes_read < 0 || bytes_read != size)
+	} else if (mmap_strategy == MMAP_NONE || snapshot->buflen <= SMALL_FILE_SIZE) {
+		snapshot->buf = xmalloc(snapshot->buflen);
+		bytes_read = read_in_full(fd, snapshot->buf, snapshot->buflen);
+		if (bytes_read < 0 || bytes_read != snapshot->buflen)
 			die_errno("couldn't read %s", snapshot->refs->path);
 		snapshot->mmapped = 0;
 	} else {
-		snapshot->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+		snapshot->buf = xmmap(NULL, snapshot->buflen, PROT_READ, MAP_PRIVATE, fd, 0);
 		snapshot->mmapped = 1;
 	}
 	close(fd);
 
 	snapshot->start = snapshot->buf;
-	snapshot->eof = snapshot->buf + size;
+	snapshot->eof = snapshot->buf + snapshot->buflen;
 
 	return 1;
 }
@@ -232,46 +231,52 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 	snapshot->refs = refs;
 	acquire_snapshot(snapshot);
 	snapshot->peeled = PEELED_NONE;
+	snapshot->version = 1;
 
 	if (!load_contents(snapshot))
 		return snapshot;
 
-	/*
-	 * If this is a v1 file format, but we don't have v1 enabled,
-	 * then ignore it the same way we would as if we didn't
-	 * understand it.
-	 */
-	if (parse_packed_format_v1_header(refs, snapshot, &sorted) ||
-	    !(refs->store_flags & REF_STORE_FORMAT_PACKED)) {
-		clear_snapshot(refs);
-		return NULL;
-	}
+	if ((refs->store_flags & REF_STORE_FORMAT_PACKED) &&
+	    !detect_packed_format_v2_header(refs, snapshot)) {
+		parse_packed_format_v1_header(refs, snapshot, &sorted);
+		snapshot->version = 1;
+		verify_buffer_safe_v1(snapshot);
 
-	verify_buffer_safe_v1(snapshot);
+		if (!sorted) {
+			sort_snapshot_v1(snapshot);
 
-	if (!sorted) {
-		sort_snapshot_v1(snapshot);
+			/*
+			* Reordering the records might have moved a short one
+			* to the end of the buffer, so verify the buffer's
+			* safety again:
+			*/
+			verify_buffer_safe_v1(snapshot);
+		}
 
-		/*
-		 * Reordering the records might have moved a short one
-		 * to the end of the buffer, so verify the buffer's
-		 * safety again:
-		 */
-		verify_buffer_safe_v1(snapshot);
+		if (mmap_strategy != MMAP_OK && snapshot->mmapped) {
+			/*
+			* We don't want to leave the file mmapped, so we are
+			* forced to make a copy now:
+			*/
+			char *buf_copy = xmalloc(snapshot->buflen);
+
+			memcpy(buf_copy, snapshot->start, snapshot->buflen);
+			clear_snapshot_buffer(snapshot);
+			snapshot->buf = snapshot->start = buf_copy;
+			snapshot->eof = buf_copy + snapshot->buflen;
+		}
+
+		return snapshot;
 	}
 
-	if (mmap_strategy != MMAP_OK && snapshot->mmapped) {
+	if (refs->store_flags & REF_STORE_FORMAT_PACKED_V2) {
 		/*
-		 * We don't want to leave the file mmapped, so we are
-		 * forced to make a copy now:
+		 * Assume we are in v2 format mode, now.
+		 *
+		 * fill_snapshot_v2() will die() if parsing fails.
 		 */
-		size_t size = snapshot->eof - snapshot->start;
-		char *buf_copy = xmalloc(size);
-
-		memcpy(buf_copy, snapshot->start, size);
-		clear_snapshot_buffer(snapshot);
-		snapshot->buf = snapshot->start = buf_copy;
-		snapshot->eof = buf_copy + size;
+		fill_snapshot_v2(snapshot);
+		snapshot->version = 2;
 	}
 
 	return snapshot;
@@ -322,8 +327,18 @@ static int packed_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		return -1;
 	}
 
-	return packed_read_raw_ref_v1(refs, snapshot, refname,
-				      oid, type, failure_errno);
+	switch (snapshot->version) {
+	case 1:
+		return packed_read_raw_ref_v1(refs, snapshot, refname,
+					      oid, type, failure_errno);
+
+	case 2:
+		return packed_read_raw_ref_v2(refs, snapshot, refname,
+					      oid, type, failure_errno);
+
+	default:
+		return -1;
+	}
 }
 
 /*
@@ -335,7 +350,16 @@ static int packed_read_raw_ref(struct ref_store *ref_store, const char *refname,
  */
 static int next_record(struct packed_ref_iterator *iter)
 {
-	return next_record_v1(iter);
+	switch (iter->version) {
+	case 1:
+		return next_record_v1(iter);
+
+	case 2:
+		return next_record_v2(iter);
+
+	default:
+		return -1;
+	}
 }
 
 static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
@@ -410,6 +434,7 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	struct packed_ref_iterator *iter;
 	struct ref_iterator *ref_iterator;
 	unsigned int required_flags = REF_STORE_READ;
+	size_t v2_row = 0;
 
 	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN))
 		required_flags |= REF_STORE_ODB;
@@ -422,13 +447,21 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	 */
 	snapshot = get_snapshot(refs);
 
-	if (!snapshot)
+	if (!snapshot || snapshot->version < 0 || snapshot->version > 2)
 		return empty_ref_iterator_begin();
 
-	if (prefix && *prefix)
-		start = find_reference_location_v1(snapshot, prefix, 0);
-	else
-		start = snapshot->start;
+	if (prefix && *prefix) {
+		if (snapshot->version == 1)
+			start = find_reference_location_v1(snapshot, prefix, 0);
+		else
+			start = find_reference_location_v2(snapshot, prefix, 0,
+							   &v2_row);
+	} else {
+		if (snapshot->version == 1)
+			start = snapshot->start;
+		else
+			start = snapshot->refs_chunk;
+	}
 
 	if (start == snapshot->eof)
 		return empty_ref_iterator_begin();
@@ -439,6 +472,8 @@ static struct ref_iterator *packed_ref_iterator_begin(
 
 	iter->snapshot = snapshot;
 	acquire_snapshot(snapshot);
+	iter->version = snapshot->version;
+	iter->row = v2_row;
 
 	iter->pos = start;
 	iter->eof = snapshot->eof;
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index e76f26bfc46..3a8649857f1 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -72,6 +72,9 @@ struct snapshot {
 	/* Is the `packed-refs` file currently mmapped? */
 	int mmapped;
 
+	/* which file format version is this file? */
+	int version;
+
 	/*
 	 * The contents of the `packed-refs` file:
 	 *
@@ -96,6 +99,14 @@ struct snapshot {
 	 */
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled;
 
+	/*************************
+	 * packed-refs v2 values *
+	 *************************/
+	size_t nr;
+	size_t buflen;
+	const unsigned char *offset_chunk;
+	const char *refs_chunk;
+
 	/*
 	 * Count of references to this instance, including the pointer
 	 * from `packed_ref_store::snapshot`, if any. The instance
@@ -112,6 +123,8 @@ struct snapshot {
 	struct stat_validity validity;
 };
 
+int release_snapshot(struct snapshot *snapshot);
+
 /*
  * If the buffer in `snapshot` is active, then either munmap the
  * memory and close the file, or free the memory. Then set the buffer
@@ -175,21 +188,30 @@ struct packed_ref_store {
  */
 struct packed_ref_iterator {
 	struct ref_iterator base;
-
 	struct snapshot *snapshot;
+	struct repository *repo;
+	unsigned int flags;
+	int version;
+
+	/* Scratch space for current values: */
+	struct object_id oid, peeled;
+	struct strbuf refname_buf;
 
 	/* The current position in the snapshot's buffer: */
 	const char *pos;
 
+	/***********************************
+	 * packed-refs v1 iterator values. *
+	 ***********************************/
+
 	/* The end of the part of the buffer that will be iterated over: */
 	const char *eof;
 
-	/* Scratch space for current values: */
-	struct object_id oid, peeled;
-	struct strbuf refname_buf;
-
-	struct repository *repo;
-	unsigned int flags;
+	/***********************************
+	 * packed-refs v2 iterator values. *
+	 ***********************************/
+	size_t nr;
+	size_t row;
 };
 
 typedef int (*write_ref_fn)(const char *refname,
@@ -243,6 +265,42 @@ int write_packed_entry_v1(const char *refname,
 			  const struct object_id *peeled,
 			  void *write_data);
 
+/**
+ * Parse the buffer at the given snapshot to verify that it is a
+ * packed-refs file in version 1 format. Update the snapshot->peeled
+ * value according to the header information. Update the given
+ * 'sorted' value with whether or not the packed-refs file is sorted.
+ */
+int parse_packed_format_v1_header(struct packed_ref_store *refs,
+				  struct snapshot *snapshot,
+				  int *sorted);
+
+int detect_packed_format_v2_header(struct packed_ref_store *refs,
+				   struct snapshot *snapshot);
+/*
+ * Find the place in `snapshot->buf` where the start of the record for
+ * `refname` starts. If `mustexist` is true and the reference doesn't
+ * exist, then return NULL. If `mustexist` is false and the reference
+ * doesn't exist, then return the point where that reference would be
+ * inserted, or `snapshot->eof` (which might be NULL) if it would be
+ * inserted at the end of the file. In the latter mode, `refname`
+ * doesn't have to be a proper reference name; for example, one could
+ * search for "refs/replace/" to find the start of any replace
+ * references.
+ *
+ * The record is sought using a binary search, so `snapshot->buf` must
+ * be sorted.
+ */
+const char *find_reference_location_v2(struct snapshot *snapshot,
+				       const char *refname, int mustexist,
+				       size_t *pos);
+
+int packed_read_raw_ref_v2(struct packed_ref_store *refs, struct snapshot *snapshot,
+			   const char *refname, struct object_id *oid,
+			   unsigned int *type, int *failure_errno);
+int next_record_v2(struct packed_ref_iterator *iter);
+void fill_snapshot_v2(struct snapshot *snapshot);
+
 struct write_packed_refs_v2_context;
 struct write_packed_refs_v2_context *create_v2_context(struct packed_ref_store *refs,
 						       struct string_list *updates,
diff --git a/refs/packed-format-v2.c b/refs/packed-format-v2.c
index 044cc9f629a..d75df9545ec 100644
--- a/refs/packed-format-v2.c
+++ b/refs/packed-format-v2.c
@@ -15,6 +15,215 @@
 #define CHREFS_CHUNKID_OFFSETS         0x524F4646 /* "ROFF" */
 #define CHREFS_CHUNKID_REFS            0x52454653 /* "REFS" */
 
+int detect_packed_format_v2_header(struct packed_ref_store *refs,
+				   struct snapshot *snapshot)
+{
+	/*
+	 * packed-refs v1 might not have a header, so check instead
+	 * that the v2 signature is not present.
+	 */
+	return get_be32(snapshot->buf) == PACKED_REFS_SIGNATURE;
+}
+
+static const char *get_nth_ref(struct snapshot *snapshot,
+			       size_t n)
+{
+	uint64_t offset;
+
+	if (n >= snapshot->nr)
+		BUG("asking for position %"PRIu64" outside of bounds (%"PRIu64")",
+		    (uint64_t)n, (uint64_t)snapshot->nr);
+
+	if (n)
+		offset = get_be64(snapshot->offset_chunk + (n-1) * sizeof(uint64_t))
+				  & ~OFFSET_IS_PEELED;
+	else
+		offset = 0;
+
+	return snapshot->refs_chunk + offset;
+}
+
+/*
+ * Find the place in `snapshot->buf` where the start of the record for
+ * `refname` starts. If `mustexist` is true and the reference doesn't
+ * exist, then return NULL. If `mustexist` is false and the reference
+ * doesn't exist, then return the point where that reference would be
+ * inserted, or `snapshot->eof` (which might be NULL) if it would be
+ * inserted at the end of the file. In the latter mode, `refname`
+ * doesn't have to be a proper reference name; for example, one could
+ * search for "refs/replace/" to find the start of any replace
+ * references.
+ *
+ * The record is sought using a binary search, so `snapshot->buf` must
+ * be sorted.
+ */
+const char *find_reference_location_v2(struct snapshot *snapshot,
+				       const char *refname, int mustexist,
+				       size_t *pos)
+{
+	size_t lo = 0, hi = snapshot->nr;
+
+	while (lo != hi) {
+		const char *rec;
+		int cmp;
+		size_t mid = lo + (hi - lo) / 2;
+
+		rec = get_nth_ref(snapshot, mid);
+		cmp = strcmp(rec, refname);
+		if (cmp < 0) {
+			lo = mid + 1;
+		} else if (cmp > 0) {
+			hi = mid;
+		} else {
+			if (pos)
+				*pos = mid;
+			return rec;
+		}
+	}
+
+	if (mustexist) {
+		return NULL;
+	} else {
+		const char *ret;
+		/*
+		 * We are likely doing a prefix match, so use the current
+		 * 'lo' position as the indicator.
+		 */
+		if (pos)
+			*pos = lo;
+		if (lo >= snapshot->nr)
+			return NULL;
+
+		ret = get_nth_ref(snapshot, lo);
+		return ret;
+	}
+}
+
+int packed_read_raw_ref_v2(struct packed_ref_store *refs, struct snapshot *snapshot,
+			   const char *refname, struct object_id *oid,
+			   unsigned int *type, int *failure_errno)
+{
+	const char *rec;
+
+	*type = 0;
+
+	rec = find_reference_location_v2(snapshot, refname, 1, NULL);
+
+	if (!rec) {
+		/* refname is not a packed reference. */
+		*failure_errno = ENOENT;
+		return -1;
+	}
+
+	hashcpy(oid->hash, (const unsigned char *)rec + strlen(rec) + 1);
+	oid->algo = hash_algo_by_ptr(the_hash_algo);
+
+	*type = REF_ISPACKED;
+	return 0;
+}
+
+static int packed_refs_read_offsets(const unsigned char *chunk_start,
+				     size_t chunk_size, void *data)
+{
+	struct snapshot *snapshot = data;
+
+	snapshot->offset_chunk = chunk_start;
+	snapshot->nr = chunk_size / sizeof(uint64_t);
+	return 0;
+}
+
+void fill_snapshot_v2(struct snapshot *snapshot)
+{
+	uint32_t file_signature, file_version, hash_version;
+	struct chunkfile *cf;
+
+	file_signature = get_be32(snapshot->buf);
+	if (file_signature != PACKED_REFS_SIGNATURE)
+		die(_("%s file signature %X does not match signature %X"),
+		    "packed-ref", file_signature, PACKED_REFS_SIGNATURE);
+
+	file_version = get_be32(snapshot->buf + sizeof(uint32_t));
+	if (file_version != 2)
+		die(_("format version %u does not match expected file version %u"),
+		    file_version, 2);
+
+	hash_version = get_be32(snapshot->buf + 2 * sizeof(uint32_t));
+	if (hash_version != the_hash_algo->format_id)
+		die(_("hash version %X does not match expected hash version %X"),
+		    hash_version, the_hash_algo->format_id);
+
+	cf = init_chunkfile(NULL);
+
+	if (read_trailing_table_of_contents(cf, (const unsigned char *)snapshot->buf, snapshot->buflen)) {
+		release_snapshot(snapshot);
+		snapshot = NULL;
+		goto cleanup;
+	}
+
+	read_chunk(cf, CHREFS_CHUNKID_OFFSETS, packed_refs_read_offsets, snapshot);
+	pair_chunk(cf, CHREFS_CHUNKID_REFS, (const unsigned char**)&snapshot->refs_chunk);
+
+	/* TODO: add error checks for invalid chunk combinations. */
+
+cleanup:
+	free_chunkfile(cf);
+}
+
+/*
+ * Move the iterator to the next record in the snapshot, without
+ * respect for whether the record is actually required by the current
+ * iteration. Adjust the fields in `iter` and return `ITER_OK` or
+ * `ITER_DONE`. This function does not free the iterator in the case
+ * of `ITER_DONE`.
+ */
+int next_record_v2(struct packed_ref_iterator *iter)
+{
+	uint64_t offset;
+	const char *pos = iter->pos;
+	strbuf_reset(&iter->refname_buf);
+
+	if (iter->row == iter->snapshot->nr)
+		return ITER_DONE;
+
+	iter->base.flags = REF_ISPACKED;
+
+	strbuf_addstr(&iter->refname_buf, pos);
+	iter->base.refname = iter->refname_buf.buf;
+	pos += strlen(pos) + 1;
+
+	hashcpy(iter->oid.hash, (const unsigned char *)pos);
+	iter->oid.algo = hash_algo_by_ptr(the_hash_algo);
+	pos += the_hash_algo->rawsz;
+
+	if (check_refname_format(iter->base.refname, REFNAME_ALLOW_ONELEVEL)) {
+		if (!refname_is_safe(iter->base.refname))
+			die("packed refname is dangerous: %s",
+			    iter->base.refname);
+		oidclr(&iter->oid);
+		iter->base.flags |= REF_BAD_NAME | REF_ISBROKEN;
+	}
+
+	/* We always know the peeled value! */
+	iter->base.flags |= REF_KNOWS_PEELED;
+
+	offset = get_be64(iter->snapshot->offset_chunk + sizeof(uint64_t) * iter->row);
+	if (offset & OFFSET_IS_PEELED) {
+		hashcpy(iter->peeled.hash, (const unsigned char *)pos);
+		iter->peeled.algo = hash_algo_by_ptr(the_hash_algo);
+	} else {
+		oidclr(&iter->peeled);
+	}
+
+	/* TODO: somehow all tags are getting OFFSET_IS_PEELED even though
+	 * some are not annotated tags.
+	 */
+	iter->pos = iter->snapshot->refs_chunk + (offset & (~OFFSET_IS_PEELED));
+
+	iter->row++;
+
+	return ITER_OK;
+}
+
 struct write_packed_refs_v2_context {
 	struct packed_ref_store *refs;
 	struct string_list *updates;
diff --git a/t/t3212-ref-formats.sh b/t/t3212-ref-formats.sh
index 03c713ac4f6..571ba518ef1 100755
--- a/t/t3212-ref-formats.sh
+++ b/t/t3212-ref-formats.sh
@@ -73,9 +73,24 @@ test_expect_success 'extensions.refFormat=files,packed-v2' '
 		test_must_fail git rev-parse refs/tags/Q &&
 		rm -f .git/packed-refs &&
 
+		git for-each-ref --format="%(refname) %(objectname)" >expect-all &&
+		git for-each-ref --format="%(refname) %(objectname)" \
+			refs/tags/* >expect-tags &&
+
 		# Create a v2 packed-refs file
 		git pack-refs --all &&
-		test_path_exists .git/packed-refs
+		test_path_exists .git/packed-refs &&
+		for t in A B
+		do
+			test_path_is_missing .git/refs/tags/$t &&
+			git rev-parse refs/tags/$t || return 1
+		done &&
+
+		git for-each-ref --format="%(refname) %(objectname)" >actual-all &&
+		test_cmp expect-all actual-all &&
+		git for-each-ref --format="%(refname) %(objectname)" \
+			refs/tags/* >actual-tags &&
+		test_cmp expect-tags actual-tags
 	)
 '
 
-- 
gitgitgadget

