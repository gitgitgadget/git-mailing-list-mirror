Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33BEC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiKGShJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbiKGSg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:29 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E71226AEC
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:20 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z14so17565468wrn.7
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTGeBfiVeJkj0ZQM6LquExSKUyR4SxzhZe2yP2FrgMY=;
        b=K6TnEnhjHnQ6c0hukeGZz5ZxX37e1C7uSqsFlQUU9YbV1ggVctuyNfuI1omaG+7cWy
         nKA6o+UQxdv8Pg6UAyIjSWNTbkBMyopx+6rKou+zO1HGxd1065UN58wjCbne4xgsUpwF
         P29wcrkNGFaA1nKQyGOnW+3ZximEMe1YXWkiA/3XMSiBfPtgcp/0D3J96mmhzkSnFg0I
         KUG3WxDCl7CWrsKW0Fb9V0P8IA6clT0eiaOHkAyPS3nxmKr+lCURjwmuWlJMvYDWVBw9
         HnCz2vMQRhy/hD/ZCE38TC5Y1kBORMZO9jytcef1uDhMjVcuKmZ7tkSCp/0LhAZT718a
         j/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTGeBfiVeJkj0ZQM6LquExSKUyR4SxzhZe2yP2FrgMY=;
        b=og2oSdcObl08c3nrmMJvNGg/PeLRNKlS1wvRLREioQQHMF31Ym9RiJGBPEhpTKm5+W
         GGAEW/aYoNxYxuoWNrcYFTyZ1eqILUGO2quuAgwlfhABaEkGeics0mic/DX/WG4waTXP
         o0LLCT077OXnnCKfdQFO6dC4ampjArqSbzz5geZ5TB4c4y1nuGTbph82PosrIED1XynT
         5/2lJmIt6UhQr660ILwAB7MXmlZIsZVo7CGaj7nCKqt2rvENugFAU53f4kJXOKfkDc3A
         1a+sLk4JXyvr9GIv+IrpNRAWt3Suh+BCzcth5BR5a15E9+1RFRfZPR0/Qvzx4bCstfFp
         SjyQ==
X-Gm-Message-State: ACrzQf3vecWJjfu8g0ZroWkOfALHj1TuGgFCydmjQU/ZqArAnh2ASdLE
        CFQb7RzadQ6WNEGP9rc6Hc0TLEO3NGY=
X-Google-Smtp-Source: AMsMyM6at7FEZPeO2fAZ0s2QpIQjtEdgnhSoHT6US7nxeQKDmG6fRfM0D0w5r8Sf2cIUBaWqPlKIeg==
X-Received: by 2002:a5d:56ce:0:b0:237:9917:45f5 with SMTP id m14-20020a5d56ce000000b00237991745f5mr16794693wrw.363.1667846178300;
        Mon, 07 Nov 2022 10:36:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17-20020a5d6611000000b002383edcde09sm8071426wru.59.2022.11.07.10.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:17 -0800 (PST)
Message-Id: <a171a84da65b777d9da4d0c1c841901712aca026.1667846164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:46 +0000
Subject: [PATCH 12/30] refs: extract packfile format to new file
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

In preparation for adding a new packed-refs file format, extract all
code from refs/packed-backend.c that involves knowledge of the plaintext
file format. This includes any parsing logic that cares about the
header, plaintext lines of the form "<oid> <ref>" or "^<peeled>", and
the error messages when there is an issue in the file. This also
includes the writing logic that writes the header or the individual
references.

Future changes will perform more refactoring to abstract away more of
the writing process to be more generic, but this is enough of a chunk of
code movement.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Makefile                |   1 +
 refs/packed-backend.c   | 595 ++--------------------------------------
 refs/packed-backend.h   | 195 +++++++++++++
 refs/packed-format-v1.c | 453 ++++++++++++++++++++++++++++++
 4 files changed, 667 insertions(+), 577 deletions(-)
 create mode 100644 refs/packed-format-v1.c

diff --git a/Makefile b/Makefile
index 4927379184c..3dc887941d4 100644
--- a/Makefile
+++ b/Makefile
@@ -1057,6 +1057,7 @@ LIB_OBJS += refs/debug.o
 LIB_OBJS += refs/files-backend.o
 LIB_OBJS += refs/iterator.o
 LIB_OBJS += refs/packed-backend.o
+LIB_OBJS += refs/packed-format-v1.o
 LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += refspec.o
 LIB_OBJS += remote.o
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a4371b711b9..afaf6f53233 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -36,121 +36,6 @@ static enum mmap_strategy mmap_strategy = MMAP_TEMPORARY;
 static enum mmap_strategy mmap_strategy = MMAP_OK;
 #endif
 
-struct packed_ref_store;
-
-/*
- * A `snapshot` represents one snapshot of a `packed-refs` file.
- *
- * Normally, this will be a mmapped view of the contents of the
- * `packed-refs` file at the time the snapshot was created. However,
- * if the `packed-refs` file was not sorted, this might point at heap
- * memory holding the contents of the `packed-refs` file with its
- * records sorted by refname.
- *
- * `snapshot` instances are reference counted (via
- * `acquire_snapshot()` and `release_snapshot()`). This is to prevent
- * an instance from disappearing while an iterator is still iterating
- * over it. Instances are garbage collected when their `referrers`
- * count goes to zero.
- *
- * The most recent `snapshot`, if available, is referenced by the
- * `packed_ref_store`. Its freshness is checked whenever
- * `get_snapshot()` is called; if the existing snapshot is obsolete, a
- * new snapshot is taken.
- */
-struct snapshot {
-	/*
-	 * A back-pointer to the packed_ref_store with which this
-	 * snapshot is associated:
-	 */
-	struct packed_ref_store *refs;
-
-	/* Is the `packed-refs` file currently mmapped? */
-	int mmapped;
-
-	/*
-	 * The contents of the `packed-refs` file:
-	 *
-	 * - buf -- a pointer to the start of the memory
-	 * - start -- a pointer to the first byte of actual references
-	 *   (i.e., after the header line, if one is present)
-	 * - eof -- a pointer just past the end of the reference
-	 *   contents
-	 *
-	 * If the `packed-refs` file was already sorted, `buf` points
-	 * at the mmapped contents of the file. If not, it points at
-	 * heap-allocated memory containing the contents, sorted. If
-	 * there were no contents (e.g., because the file didn't
-	 * exist), `buf`, `start`, and `eof` are all NULL.
-	 */
-	char *buf, *start, *eof;
-
-	/*
-	 * What is the peeled state of the `packed-refs` file that
-	 * this snapshot represents? (This is usually determined from
-	 * the file's header.)
-	 */
-	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled;
-
-	/*
-	 * Count of references to this instance, including the pointer
-	 * from `packed_ref_store::snapshot`, if any. The instance
-	 * will not be freed as long as the reference count is
-	 * nonzero.
-	 */
-	unsigned int referrers;
-
-	/*
-	 * The metadata of the `packed-refs` file from which this
-	 * snapshot was created, used to tell if the file has been
-	 * replaced since we read it.
-	 */
-	struct stat_validity validity;
-};
-
-/*
- * A `ref_store` representing references stored in a `packed-refs`
- * file. It implements the `ref_store` interface, though it has some
- * limitations:
- *
- * - It cannot store symbolic references.
- *
- * - It cannot store reflogs.
- *
- * - It does not support reference renaming (though it could).
- *
- * On the other hand, it can be locked outside of a reference
- * transaction. In that case, it remains locked even after the
- * transaction is done and the new `packed-refs` file is activated.
- */
-struct packed_ref_store {
-	struct ref_store base;
-
-	unsigned int store_flags;
-
-	/* The path of the "packed-refs" file: */
-	char *path;
-
-	/*
-	 * A snapshot of the values read from the `packed-refs` file,
-	 * if it might still be current; otherwise, NULL.
-	 */
-	struct snapshot *snapshot;
-
-	/*
-	 * Lock used for the "packed-refs" file. Note that this (and
-	 * thus the enclosing `packed_ref_store`) must not be freed.
-	 */
-	struct lock_file lock;
-
-	/*
-	 * Temporary file used when rewriting new contents to the
-	 * "packed-refs" file. Note that this (and thus the enclosing
-	 * `packed_ref_store`) must not be freed.
-	 */
-	struct tempfile *tempfile;
-};
-
 /*
  * Increment the reference count of `*snapshot`.
  */
@@ -164,7 +49,7 @@ static void acquire_snapshot(struct snapshot *snapshot)
  * memory and close the file, or free the memory. Then set the buffer
  * pointers to NULL.
  */
-static void clear_snapshot_buffer(struct snapshot *snapshot)
+void clear_snapshot_buffer(struct snapshot *snapshot)
 {
 	if (snapshot->mmapped) {
 		if (munmap(snapshot->buf, snapshot->eof - snapshot->buf))
@@ -245,224 +130,6 @@ static void clear_snapshot(struct packed_ref_store *refs)
 	}
 }
 
-static NORETURN void die_unterminated_line(const char *path,
-					   const char *p, size_t len)
-{
-	if (len < 80)
-		die("unterminated line in %s: %.*s", path, (int)len, p);
-	else
-		die("unterminated line in %s: %.75s...", path, p);
-}
-
-static NORETURN void die_invalid_line(const char *path,
-				      const char *p, size_t len)
-{
-	const char *eol = memchr(p, '\n', len);
-
-	if (!eol)
-		die_unterminated_line(path, p, len);
-	else if (eol - p < 80)
-		die("unexpected line in %s: %.*s", path, (int)(eol - p), p);
-	else
-		die("unexpected line in %s: %.75s...", path, p);
-
-}
-
-struct snapshot_record {
-	const char *start;
-	size_t len;
-};
-
-static int cmp_packed_ref_records(const void *v1, const void *v2)
-{
-	const struct snapshot_record *e1 = v1, *e2 = v2;
-	const char *r1 = e1->start + the_hash_algo->hexsz + 1;
-	const char *r2 = e2->start + the_hash_algo->hexsz + 1;
-
-	while (1) {
-		if (*r1 == '\n')
-			return *r2 == '\n' ? 0 : -1;
-		if (*r1 != *r2) {
-			if (*r2 == '\n')
-				return 1;
-			else
-				return (unsigned char)*r1 < (unsigned char)*r2 ? -1 : +1;
-		}
-		r1++;
-		r2++;
-	}
-}
-
-/*
- * Compare a snapshot record at `rec` to the specified NUL-terminated
- * refname.
- */
-static int cmp_record_to_refname(const char *rec, const char *refname)
-{
-	const char *r1 = rec + the_hash_algo->hexsz + 1;
-	const char *r2 = refname;
-
-	while (1) {
-		if (*r1 == '\n')
-			return *r2 ? -1 : 0;
-		if (!*r2)
-			return 1;
-		if (*r1 != *r2)
-			return (unsigned char)*r1 < (unsigned char)*r2 ? -1 : +1;
-		r1++;
-		r2++;
-	}
-}
-
-/*
- * `snapshot->buf` is not known to be sorted. Check whether it is, and
- * if not, sort it into new memory and munmap/free the old storage.
- */
-static void sort_snapshot(struct snapshot *snapshot)
-{
-	struct snapshot_record *records = NULL;
-	size_t alloc = 0, nr = 0;
-	int sorted = 1;
-	const char *pos, *eof, *eol;
-	size_t len, i;
-	char *new_buffer, *dst;
-
-	pos = snapshot->start;
-	eof = snapshot->eof;
-
-	if (pos == eof)
-		return;
-
-	len = eof - pos;
-
-	/*
-	 * Initialize records based on a crude estimate of the number
-	 * of references in the file (we'll grow it below if needed):
-	 */
-	ALLOC_GROW(records, len / 80 + 20, alloc);
-
-	while (pos < eof) {
-		eol = memchr(pos, '\n', eof - pos);
-		if (!eol)
-			/* The safety check should prevent this. */
-			BUG("unterminated line found in packed-refs");
-		if (eol - pos < the_hash_algo->hexsz + 2)
-			die_invalid_line(snapshot->refs->path,
-					 pos, eof - pos);
-		eol++;
-		if (eol < eof && *eol == '^') {
-			/*
-			 * Keep any peeled line together with its
-			 * reference:
-			 */
-			const char *peeled_start = eol;
-
-			eol = memchr(peeled_start, '\n', eof - peeled_start);
-			if (!eol)
-				/* The safety check should prevent this. */
-				BUG("unterminated peeled line found in packed-refs");
-			eol++;
-		}
-
-		ALLOC_GROW(records, nr + 1, alloc);
-		records[nr].start = pos;
-		records[nr].len = eol - pos;
-		nr++;
-
-		if (sorted &&
-		    nr > 1 &&
-		    cmp_packed_ref_records(&records[nr - 2],
-					   &records[nr - 1]) >= 0)
-			sorted = 0;
-
-		pos = eol;
-	}
-
-	if (sorted)
-		goto cleanup;
-
-	/* We need to sort the memory. First we sort the records array: */
-	QSORT(records, nr, cmp_packed_ref_records);
-
-	/*
-	 * Allocate a new chunk of memory, and copy the old memory to
-	 * the new in the order indicated by `records` (not bothering
-	 * with the header line):
-	 */
-	new_buffer = xmalloc(len);
-	for (dst = new_buffer, i = 0; i < nr; i++) {
-		memcpy(dst, records[i].start, records[i].len);
-		dst += records[i].len;
-	}
-
-	/*
-	 * Now munmap the old buffer and use the sorted buffer in its
-	 * place:
-	 */
-	clear_snapshot_buffer(snapshot);
-	snapshot->buf = snapshot->start = new_buffer;
-	snapshot->eof = new_buffer + len;
-
-cleanup:
-	free(records);
-}
-
-/*
- * Return a pointer to the start of the record that contains the
- * character `*p` (which must be within the buffer). If no other
- * record start is found, return `buf`.
- */
-static const char *find_start_of_record(const char *buf, const char *p)
-{
-	while (p > buf && (p[-1] != '\n' || p[0] == '^'))
-		p--;
-	return p;
-}
-
-/*
- * Return a pointer to the start of the record following the record
- * that contains `*p`. If none is found before `end`, return `end`.
- */
-static const char *find_end_of_record(const char *p, const char *end)
-{
-	while (++p < end && (p[-1] != '\n' || p[0] == '^'))
-		;
-	return p;
-}
-
-/*
- * We want to be able to compare mmapped reference records quickly,
- * without totally parsing them. We can do so because the records are
- * LF-terminated, and the refname should start exactly (GIT_SHA1_HEXSZ
- * + 1) bytes past the beginning of the record.
- *
- * But what if the `packed-refs` file contains garbage? We're willing
- * to tolerate not detecting the problem, as long as we don't produce
- * totally garbled output (we can't afford to check the integrity of
- * the whole file during every Git invocation). But we do want to be
- * sure that we never read past the end of the buffer in memory and
- * perform an illegal memory access.
- *
- * Guarantee that minimum level of safety by verifying that the last
- * record in the file is LF-terminated, and that it has at least
- * (GIT_SHA1_HEXSZ + 1) characters before the LF. Die if either of
- * these checks fails.
- */
-static void verify_buffer_safe(struct snapshot *snapshot)
-{
-	const char *start = snapshot->start;
-	const char *eof = snapshot->eof;
-	const char *last_line;
-
-	if (start == eof)
-		return;
-
-	last_line = find_start_of_record(start, eof - 1);
-	if (*(eof - 1) != '\n' || eof - last_line < the_hash_algo->hexsz + 2)
-		die_invalid_line(snapshot->refs->path,
-				 last_line, eof - last_line);
-}
-
 #define SMALL_FILE_SIZE (32*1024)
 
 /*
@@ -524,67 +191,6 @@ static int load_contents(struct snapshot *snapshot)
 	return 1;
 }
 
-/*
- * Find the place in `snapshot->buf` where the start of the record for
- * `refname` starts. If `mustexist` is true and the reference doesn't
- * exist, then return NULL. If `mustexist` is false and the reference
- * doesn't exist, then return the point where that reference would be
- * inserted, or `snapshot->eof` (which might be NULL) if it would be
- * inserted at the end of the file. In the latter mode, `refname`
- * doesn't have to be a proper reference name; for example, one could
- * search for "refs/replace/" to find the start of any replace
- * references.
- *
- * The record is sought using a binary search, so `snapshot->buf` must
- * be sorted.
- */
-static const char *find_reference_location(struct snapshot *snapshot,
-					   const char *refname, int mustexist)
-{
-	/*
-	 * This is not *quite* a garden-variety binary search, because
-	 * the data we're searching is made up of records, and we
-	 * always need to find the beginning of a record to do a
-	 * comparison. A "record" here is one line for the reference
-	 * itself and zero or one peel lines that start with '^'. Our
-	 * loop invariant is described in the next two comments.
-	 */
-
-	/*
-	 * A pointer to the character at the start of a record whose
-	 * preceding records all have reference names that come
-	 * *before* `refname`.
-	 */
-	const char *lo = snapshot->start;
-
-	/*
-	 * A pointer to a the first character of a record whose
-	 * reference name comes *after* `refname`.
-	 */
-	const char *hi = snapshot->eof;
-
-	while (lo != hi) {
-		const char *mid, *rec;
-		int cmp;
-
-		mid = lo + (hi - lo) / 2;
-		rec = find_start_of_record(lo, mid);
-		cmp = cmp_record_to_refname(rec, refname);
-		if (cmp < 0) {
-			lo = find_end_of_record(mid, hi);
-		} else if (cmp > 0) {
-			hi = rec;
-		} else {
-			return rec;
-		}
-	}
-
-	if (mustexist)
-		return NULL;
-	else
-		return lo;
-}
-
 /*
  * Create a newly-allocated `snapshot` of the `packed-refs` file in
  * its current state and return it. The return value will already have
@@ -630,54 +236,22 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 	if (!load_contents(snapshot))
 		return snapshot;
 
-	/* If the file has a header line, process it: */
-	if (snapshot->buf < snapshot->eof && *snapshot->buf == '#') {
-		char *tmp, *p, *eol;
-		struct string_list traits = STRING_LIST_INIT_NODUP;
-
-		eol = memchr(snapshot->buf, '\n',
-			     snapshot->eof - snapshot->buf);
-		if (!eol)
-			die_unterminated_line(refs->path,
-					      snapshot->buf,
-					      snapshot->eof - snapshot->buf);
-
-		tmp = xmemdupz(snapshot->buf, eol - snapshot->buf);
-
-		if (!skip_prefix(tmp, "# pack-refs with:", (const char **)&p))
-			die_invalid_line(refs->path,
-					 snapshot->buf,
-					 snapshot->eof - snapshot->buf);
-
-		string_list_split_in_place(&traits, p, ' ', -1);
-
-		if (unsorted_string_list_has_string(&traits, "fully-peeled"))
-			snapshot->peeled = PEELED_FULLY;
-		else if (unsorted_string_list_has_string(&traits, "peeled"))
-			snapshot->peeled = PEELED_TAGS;
-
-		sorted = unsorted_string_list_has_string(&traits, "sorted");
-
-		/* perhaps other traits later as well */
-
-		/* The "+ 1" is for the LF character. */
-		snapshot->start = eol + 1;
-
-		string_list_clear(&traits, 0);
-		free(tmp);
+	if (parse_packed_format_v1_header(refs, snapshot, &sorted)) {
+		clear_snapshot(refs);
+		return NULL;
 	}
 
-	verify_buffer_safe(snapshot);
+	verify_buffer_safe_v1(snapshot);
 
 	if (!sorted) {
-		sort_snapshot(snapshot);
+		sort_snapshot_v1(snapshot);
 
 		/*
 		 * Reordering the records might have moved a short one
 		 * to the end of the buffer, so verify the buffer's
 		 * safety again:
 		 */
-		verify_buffer_safe(snapshot);
+		verify_buffer_safe_v1(snapshot);
 	}
 
 	if (mmap_strategy != MMAP_OK && snapshot->mmapped) {
@@ -735,55 +309,11 @@ static int packed_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	struct packed_ref_store *refs =
 		packed_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
 	struct snapshot *snapshot = get_snapshot(refs);
-	const char *rec;
-
-	*type = 0;
 
-	rec = find_reference_location(snapshot, refname, 1);
-
-	if (!rec) {
-		/* refname is not a packed reference. */
-		*failure_errno = ENOENT;
-		return -1;
-	}
-
-	if (get_oid_hex(rec, oid))
-		die_invalid_line(refs->path, rec, snapshot->eof - rec);
-
-	*type = REF_ISPACKED;
-	return 0;
+	return packed_read_raw_ref_v1(refs, snapshot, refname,
+				      oid, type, failure_errno);
 }
 
-/*
- * This value is set in `base.flags` if the peeled value of the
- * current reference is known. In that case, `peeled` contains the
- * correct peeled value for the reference, which might be `null_oid`
- * if the reference is not a tag or if it is broken.
- */
-#define REF_KNOWS_PEELED 0x40
-
-/*
- * An iterator over a snapshot of a `packed-refs` file.
- */
-struct packed_ref_iterator {
-	struct ref_iterator base;
-
-	struct snapshot *snapshot;
-
-	/* The current position in the snapshot's buffer: */
-	const char *pos;
-
-	/* The end of the part of the buffer that will be iterated over: */
-	const char *eof;
-
-	/* Scratch space for current values: */
-	struct object_id oid, peeled;
-	struct strbuf refname_buf;
-
-	struct repository *repo;
-	unsigned int flags;
-};
-
 /*
  * Move the iterator to the next record in the snapshot, without
  * respect for whether the record is actually required by the current
@@ -793,68 +323,7 @@ struct packed_ref_iterator {
  */
 static int next_record(struct packed_ref_iterator *iter)
 {
-	const char *p = iter->pos, *eol;
-
-	strbuf_reset(&iter->refname_buf);
-
-	if (iter->pos == iter->eof)
-		return ITER_DONE;
-
-	iter->base.flags = REF_ISPACKED;
-
-	if (iter->eof - p < the_hash_algo->hexsz + 2 ||
-	    parse_oid_hex(p, &iter->oid, &p) ||
-	    !isspace(*p++))
-		die_invalid_line(iter->snapshot->refs->path,
-				 iter->pos, iter->eof - iter->pos);
-
-	eol = memchr(p, '\n', iter->eof - p);
-	if (!eol)
-		die_unterminated_line(iter->snapshot->refs->path,
-				      iter->pos, iter->eof - iter->pos);
-
-	strbuf_add(&iter->refname_buf, p, eol - p);
-	iter->base.refname = iter->refname_buf.buf;
-
-	if (check_refname_format(iter->base.refname, REFNAME_ALLOW_ONELEVEL)) {
-		if (!refname_is_safe(iter->base.refname))
-			die("packed refname is dangerous: %s",
-			    iter->base.refname);
-		oidclr(&iter->oid);
-		iter->base.flags |= REF_BAD_NAME | REF_ISBROKEN;
-	}
-	if (iter->snapshot->peeled == PEELED_FULLY ||
-	    (iter->snapshot->peeled == PEELED_TAGS &&
-	     starts_with(iter->base.refname, "refs/tags/")))
-		iter->base.flags |= REF_KNOWS_PEELED;
-
-	iter->pos = eol + 1;
-
-	if (iter->pos < iter->eof && *iter->pos == '^') {
-		p = iter->pos + 1;
-		if (iter->eof - p < the_hash_algo->hexsz + 1 ||
-		    parse_oid_hex(p, &iter->peeled, &p) ||
-		    *p++ != '\n')
-			die_invalid_line(iter->snapshot->refs->path,
-					 iter->pos, iter->eof - iter->pos);
-		iter->pos = p;
-
-		/*
-		 * Regardless of what the file header said, we
-		 * definitely know the value of *this* reference. But
-		 * we suppress it if the reference is broken:
-		 */
-		if ((iter->base.flags & REF_ISBROKEN)) {
-			oidclr(&iter->peeled);
-			iter->base.flags &= ~REF_KNOWS_PEELED;
-		} else {
-			iter->base.flags |= REF_KNOWS_PEELED;
-		}
-	} else {
-		oidclr(&iter->peeled);
-	}
-
-	return ITER_OK;
+	return next_record_v1(iter);
 }
 
 static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
@@ -942,7 +411,7 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	snapshot = get_snapshot(refs);
 
 	if (prefix && *prefix)
-		start = find_reference_location(snapshot, prefix, 0);
+		start = find_reference_location_v1(snapshot, prefix, 0);
 	else
 		start = snapshot->start;
 
@@ -972,23 +441,6 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	return ref_iterator;
 }
 
-/*
- * Write an entry to the packed-refs file for the specified refname.
- * If peeled is non-NULL, write it as the entry's peeled value. On
- * error, return a nonzero value and leave errno set at the value left
- * by the failing call to `fprintf()`.
- */
-static int write_packed_entry(FILE *fh, const char *refname,
-			      const struct object_id *oid,
-			      const struct object_id *peeled)
-{
-	if (fprintf(fh, "%s %s\n", oid_to_hex(oid), refname) < 0 ||
-	    (peeled && fprintf(fh, "^%s\n", oid_to_hex(peeled)) < 0))
-		return -1;
-
-	return 0;
-}
-
 int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 {
 	struct packed_ref_store *refs =
@@ -1070,17 +522,6 @@ int packed_refs_is_locked(struct ref_store *ref_store)
 	return is_lock_file_locked(&refs->lock);
 }
 
-/*
- * The packed-refs header line that we write out. Perhaps other traits
- * will be added later.
- *
- * Note that earlier versions of Git used to parse these traits by
- * looking for " trait " in the line. For this reason, the space after
- * the colon and the trailing space are required.
- */
-static const char PACKED_REFS_HEADER[] =
-	"# pack-refs with: peeled fully-peeled sorted \n";
-
 static int packed_init_db(struct ref_store *ref_store UNUSED,
 			  struct strbuf *err UNUSED)
 {
@@ -1136,7 +577,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 		goto error;
 	}
 
-	if (fprintf(out, "%s", PACKED_REFS_HEADER) < 0)
+	if (write_packed_file_header_v1(out) < 0)
 		goto write_error;
 
 	/*
@@ -1230,9 +671,9 @@ static int write_with_updates(struct packed_ref_store *refs,
 			struct object_id peeled;
 			int peel_error = ref_iterator_peel(iter, &peeled);
 
-			if (write_packed_entry(out, iter->refname,
-					       iter->oid,
-					       peel_error ? NULL : &peeled))
+			if (write_packed_entry_v1(out, iter->refname,
+						  iter->oid,
+						  peel_error ? NULL : &peeled))
 				goto write_error;
 
 			if ((ok = ref_iterator_advance(iter)) != ITER_OK)
@@ -1251,9 +692,9 @@ static int write_with_updates(struct packed_ref_store *refs,
 			int peel_error = peel_object(&update->new_oid,
 						     &peeled);
 
-			if (write_packed_entry(out, update->refname,
-					       &update->new_oid,
-					       peel_error ? NULL : &peeled))
+			if (write_packed_entry_v1(out, update->refname,
+						  &update->new_oid,
+						  peel_error ? NULL : &peeled))
 				goto write_error;
 
 			i++;
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 9dd8a344c34..143ed6d4f6c 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -1,6 +1,10 @@
 #ifndef REFS_PACKED_BACKEND_H
 #define REFS_PACKED_BACKEND_H
 
+#include "../cache.h"
+#include "refs-internal.h"
+#include "../lockfile.h"
+
 struct repository;
 struct ref_transaction;
 
@@ -36,4 +40,195 @@ int packed_refs_is_locked(struct ref_store *ref_store);
 int is_packed_transaction_needed(struct ref_store *ref_store,
 				 struct ref_transaction *transaction);
 
+struct packed_ref_store;
+
+/*
+ * A `snapshot` represents one snapshot of a `packed-refs` file.
+ *
+ * Normally, this will be a mmapped view of the contents of the
+ * `packed-refs` file at the time the snapshot was created. However,
+ * if the `packed-refs` file was not sorted, this might point at heap
+ * memory holding the contents of the `packed-refs` file with its
+ * records sorted by refname.
+ *
+ * `snapshot` instances are reference counted (via
+ * `acquire_snapshot()` and `release_snapshot()`). This is to prevent
+ * an instance from disappearing while an iterator is still iterating
+ * over it. Instances are garbage collected when their `referrers`
+ * count goes to zero.
+ *
+ * The most recent `snapshot`, if available, is referenced by the
+ * `packed_ref_store`. Its freshness is checked whenever
+ * `get_snapshot()` is called; if the existing snapshot is obsolete, a
+ * new snapshot is taken.
+ */
+struct snapshot {
+	/*
+	 * A back-pointer to the packed_ref_store with which this
+	 * snapshot is associated:
+	 */
+	struct packed_ref_store *refs;
+
+	/* Is the `packed-refs` file currently mmapped? */
+	int mmapped;
+
+	/*
+	 * The contents of the `packed-refs` file:
+	 *
+	 * - buf -- a pointer to the start of the memory
+	 * - start -- a pointer to the first byte of actual references
+	 *   (i.e., after the header line, if one is present)
+	 * - eof -- a pointer just past the end of the reference
+	 *   contents
+	 *
+	 * If the `packed-refs` file was already sorted, `buf` points
+	 * at the mmapped contents of the file. If not, it points at
+	 * heap-allocated memory containing the contents, sorted. If
+	 * there were no contents (e.g., because the file didn't
+	 * exist), `buf`, `start`, and `eof` are all NULL.
+	 */
+	char *buf, *start, *eof;
+
+	/*
+	 * What is the peeled state of the `packed-refs` file that
+	 * this snapshot represents? (This is usually determined from
+	 * the file's header.)
+	 */
+	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled;
+
+	/*
+	 * Count of references to this instance, including the pointer
+	 * from `packed_ref_store::snapshot`, if any. The instance
+	 * will not be freed as long as the reference count is
+	 * nonzero.
+	 */
+	unsigned int referrers;
+
+	/*
+	 * The metadata of the `packed-refs` file from which this
+	 * snapshot was created, used to tell if the file has been
+	 * replaced since we read it.
+	 */
+	struct stat_validity validity;
+};
+
+/*
+ * If the buffer in `snapshot` is active, then either munmap the
+ * memory and close the file, or free the memory. Then set the buffer
+ * pointers to NULL.
+ */
+void clear_snapshot_buffer(struct snapshot *snapshot);
+
+/*
+ * A `ref_store` representing references stored in a `packed-refs`
+ * file. It implements the `ref_store` interface, though it has some
+ * limitations:
+ *
+ * - It cannot store symbolic references.
+ *
+ * - It cannot store reflogs.
+ *
+ * - It does not support reference renaming (though it could).
+ *
+ * On the other hand, it can be locked outside of a reference
+ * transaction. In that case, it remains locked even after the
+ * transaction is done and the new `packed-refs` file is activated.
+ */
+struct packed_ref_store {
+	struct ref_store base;
+
+	unsigned int store_flags;
+
+	/* The path of the "packed-refs" file: */
+	char *path;
+
+	/*
+	 * A snapshot of the values read from the `packed-refs` file,
+	 * if it might still be current; otherwise, NULL.
+	 */
+	struct snapshot *snapshot;
+
+	/*
+	 * Lock used for the "packed-refs" file. Note that this (and
+	 * thus the enclosing `packed_ref_store`) must not be freed.
+	 */
+	struct lock_file lock;
+
+	/*
+	 * Temporary file used when rewriting new contents to the
+	 * "packed-refs" file. Note that this (and thus the enclosing
+	 * `packed_ref_store`) must not be freed.
+	 */
+	struct tempfile *tempfile;
+};
+
+/*
+ * This value is set in `base.flags` if the peeled value of the
+ * current reference is known. In that case, `peeled` contains the
+ * correct peeled value for the reference, which might be `null_oid`
+ * if the reference is not a tag or if it is broken.
+ */
+#define REF_KNOWS_PEELED 0x40
+
+/*
+ * An iterator over a snapshot of a `packed-refs` file.
+ */
+struct packed_ref_iterator {
+	struct ref_iterator base;
+
+	struct snapshot *snapshot;
+
+	/* The current position in the snapshot's buffer: */
+	const char *pos;
+
+	/* The end of the part of the buffer that will be iterated over: */
+	const char *eof;
+
+	/* Scratch space for current values: */
+	struct object_id oid, peeled;
+	struct strbuf refname_buf;
+
+	struct repository *repo;
+	unsigned int flags;
+};
+
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
+const char *find_reference_location_v1(struct snapshot *snapshot,
+				       const char *refname, int mustexist);
+
+int packed_read_raw_ref_v1(struct packed_ref_store *refs, struct snapshot *snapshot,
+			   const char *refname, struct object_id *oid,
+			   unsigned int *type, int *failure_errno);
+
+void verify_buffer_safe_v1(struct snapshot *snapshot);
+void sort_snapshot_v1(struct snapshot *snapshot);
+int write_packed_file_header_v1(FILE *out);
+int next_record_v1(struct packed_ref_iterator *iter);
+int write_packed_entry_v1(FILE *fh, const char *refname,
+			  const struct object_id *oid,
+			  const struct object_id *peeled);
+
 #endif /* REFS_PACKED_BACKEND_H */
diff --git a/refs/packed-format-v1.c b/refs/packed-format-v1.c
new file mode 100644
index 00000000000..ef9e6618c89
--- /dev/null
+++ b/refs/packed-format-v1.c
@@ -0,0 +1,453 @@
+#include "../cache.h"
+#include "../config.h"
+#include "../refs.h"
+#include "refs-internal.h"
+#include "packed-backend.h"
+#include "../iterator.h"
+#include "../lockfile.h"
+#include "../chdir-notify.h"
+
+static NORETURN void die_unterminated_line(const char *path,
+					   const char *p, size_t len)
+{
+	if (len < 80)
+		die("unterminated line in %s: %.*s", path, (int)len, p);
+	else
+		die("unterminated line in %s: %.75s...", path, p);
+}
+
+static NORETURN void die_invalid_line(const char *path,
+				      const char *p, size_t len)
+{
+	const char *eol = memchr(p, '\n', len);
+
+	if (!eol)
+		die_unterminated_line(path, p, len);
+	else if (eol - p < 80)
+		die("unexpected line in %s: %.*s", path, (int)(eol - p), p);
+	else
+		die("unexpected line in %s: %.75s...", path, p);
+}
+
+struct snapshot_record {
+	const char *start;
+	size_t len;
+};
+
+static int cmp_packed_ref_records(const void *v1, const void *v2)
+{
+	const struct snapshot_record *e1 = v1, *e2 = v2;
+	const char *r1 = e1->start + the_hash_algo->hexsz + 1;
+	const char *r2 = e2->start + the_hash_algo->hexsz + 1;
+
+	while (1) {
+		if (*r1 == '\n')
+			return *r2 == '\n' ? 0 : -1;
+		if (*r1 != *r2) {
+			if (*r2 == '\n')
+				return 1;
+			else
+				return (unsigned char)*r1 < (unsigned char)*r2 ? -1 : +1;
+		}
+		r1++;
+		r2++;
+	}
+}
+
+/*
+ * Compare a snapshot record at `rec` to the specified NUL-terminated
+ * refname.
+ */
+static int cmp_record_to_refname(const char *rec, const char *refname)
+{
+	const char *r1 = rec + the_hash_algo->hexsz + 1;
+	const char *r2 = refname;
+
+	while (1) {
+		if (*r1 == '\n')
+			return *r2 ? -1 : 0;
+		if (!*r2)
+			return 1;
+		if (*r1 != *r2)
+			return (unsigned char)*r1 < (unsigned char)*r2 ? -1 : +1;
+		r1++;
+		r2++;
+	}
+}
+
+/*
+ * `snapshot->buf` is not known to be sorted. Check whether it is, and
+ * if not, sort it into new memory and munmap/free the old storage.
+ */
+void sort_snapshot_v1(struct snapshot *snapshot)
+{
+	struct snapshot_record *records = NULL;
+	size_t alloc = 0, nr = 0;
+	int sorted = 1;
+	const char *pos, *eof, *eol;
+	size_t len, i;
+	char *new_buffer, *dst;
+
+	pos = snapshot->start;
+	eof = snapshot->eof;
+
+	if (pos == eof)
+		return;
+
+	len = eof - pos;
+
+	/*
+	 * Initialize records based on a crude estimate of the number
+	 * of references in the file (we'll grow it below if needed):
+	 */
+	ALLOC_GROW(records, len / 80 + 20, alloc);
+
+	while (pos < eof) {
+		eol = memchr(pos, '\n', eof - pos);
+		if (!eol)
+			/* The safety check should prevent this. */
+			BUG("unterminated line found in packed-refs");
+		if (eol - pos < the_hash_algo->hexsz + 2)
+			die_invalid_line(snapshot->refs->path,
+					 pos, eof - pos);
+		eol++;
+		if (eol < eof && *eol == '^') {
+			/*
+			 * Keep any peeled line together with its
+			 * reference:
+			 */
+			const char *peeled_start = eol;
+
+			eol = memchr(peeled_start, '\n', eof - peeled_start);
+			if (!eol)
+				/* The safety check should prevent this. */
+				BUG("unterminated peeled line found in packed-refs");
+			eol++;
+		}
+
+		ALLOC_GROW(records, nr + 1, alloc);
+		records[nr].start = pos;
+		records[nr].len = eol - pos;
+		nr++;
+
+		if (sorted &&
+		    nr > 1 &&
+		    cmp_packed_ref_records(&records[nr - 2],
+					   &records[nr - 1]) >= 0)
+			sorted = 0;
+
+		pos = eol;
+	}
+
+	if (sorted)
+		goto cleanup;
+
+	/* We need to sort the memory. First we sort the records array: */
+	QSORT(records, nr, cmp_packed_ref_records);
+
+	/*
+	 * Allocate a new chunk of memory, and copy the old memory to
+	 * the new in the order indicated by `records` (not bothering
+	 * with the header line):
+	 */
+	new_buffer = xmalloc(len);
+	for (dst = new_buffer, i = 0; i < nr; i++) {
+		memcpy(dst, records[i].start, records[i].len);
+		dst += records[i].len;
+	}
+
+	/*
+	 * Now munmap the old buffer and use the sorted buffer in its
+	 * place:
+	 */
+	clear_snapshot_buffer(snapshot);
+	snapshot->buf = snapshot->start = new_buffer;
+	snapshot->eof = new_buffer + len;
+
+cleanup:
+	free(records);
+}
+
+/*
+ * Return a pointer to the start of the record that contains the
+ * character `*p` (which must be within the buffer). If no other
+ * record start is found, return `buf`.
+ */
+static const char *find_start_of_record(const char *buf, const char *p)
+{
+	while (p > buf && (p[-1] != '\n' || p[0] == '^'))
+		p--;
+	return p;
+}
+
+/*
+ * Return a pointer to the start of the record following the record
+ * that contains `*p`. If none is found before `end`, return `end`.
+ */
+static const char *find_end_of_record(const char *p, const char *end)
+{
+	while (++p < end && (p[-1] != '\n' || p[0] == '^'))
+		;
+	return p;
+}
+
+/*
+ * We want to be able to compare mmapped reference records quickly,
+ * without totally parsing them. We can do so because the records are
+ * LF-terminated, and the refname should start exactly (GIT_SHA1_HEXSZ
+ * + 1) bytes past the beginning of the record.
+ *
+ * But what if the `packed-refs` file contains garbage? We're willing
+ * to tolerate not detecting the problem, as long as we don't produce
+ * totally garbled output (we can't afford to check the integrity of
+ * the whole file during every Git invocation). But we do want to be
+ * sure that we never read past the end of the buffer in memory and
+ * perform an illegal memory access.
+ *
+ * Guarantee that minimum level of safety by verifying that the last
+ * record in the file is LF-terminated, and that it has at least
+ * (GIT_SHA1_HEXSZ + 1) characters before the LF. Die if either of
+ * these checks fails.
+ */
+void verify_buffer_safe_v1(struct snapshot *snapshot)
+{
+	const char *start = snapshot->start;
+	const char *eof = snapshot->eof;
+	const char *last_line;
+
+	if (start == eof)
+		return;
+
+	last_line = find_start_of_record(start, eof - 1);
+	if (*(eof - 1) != '\n' || eof - last_line < the_hash_algo->hexsz + 2)
+		die_invalid_line(snapshot->refs->path,
+				 last_line, eof - last_line);
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
+const char *find_reference_location_v1(struct snapshot *snapshot,
+				       const char *refname, int mustexist)
+{
+	/*
+	 * This is not *quite* a garden-variety binary search, because
+	 * the data we're searching is made up of records, and we
+	 * always need to find the beginning of a record to do a
+	 * comparison. A "record" here is one line for the reference
+	 * itself and zero or one peel lines that start with '^'. Our
+	 * loop invariant is described in the next two comments.
+	 */
+
+	/*
+	 * A pointer to the character at the start of a record whose
+	 * preceding records all have reference names that come
+	 * *before* `refname`.
+	 */
+	const char *lo = snapshot->start;
+
+	/*
+	 * A pointer to a the first character of a record whose
+	 * reference name comes *after* `refname`.
+	 */
+	const char *hi = snapshot->eof;
+
+	while (lo != hi) {
+		const char *mid, *rec;
+		int cmp;
+
+		mid = lo + (hi - lo) / 2;
+		rec = find_start_of_record(lo, mid);
+		cmp = cmp_record_to_refname(rec, refname);
+		if (cmp < 0) {
+			lo = find_end_of_record(mid, hi);
+		} else if (cmp > 0) {
+			hi = rec;
+		} else {
+			return rec;
+		}
+	}
+
+	if (mustexist)
+		return NULL;
+	else
+		return lo;
+}
+
+int parse_packed_format_v1_header(struct packed_ref_store *refs,
+				  struct snapshot *snapshot,
+				  int *sorted)
+{
+	*sorted = 0;
+	/* If the file has a header line, process it: */
+	if (snapshot->buf < snapshot->eof && *snapshot->buf == '#') {
+		char *tmp, *p, *eol;
+		struct string_list traits = STRING_LIST_INIT_NODUP;
+
+		eol = memchr(snapshot->buf, '\n',
+			     snapshot->eof - snapshot->buf);
+		if (!eol)
+			die_unterminated_line(refs->path,
+					      snapshot->buf,
+					      snapshot->eof - snapshot->buf);
+
+		tmp = xmemdupz(snapshot->buf, eol - snapshot->buf);
+
+		if (!skip_prefix(tmp, "# pack-refs with:", (const char **)&p))
+			die_invalid_line(refs->path,
+					 snapshot->buf,
+					 snapshot->eof - snapshot->buf);
+
+		string_list_split_in_place(&traits, p, ' ', -1);
+
+		if (unsorted_string_list_has_string(&traits, "fully-peeled"))
+			snapshot->peeled = PEELED_FULLY;
+		else if (unsorted_string_list_has_string(&traits, "peeled"))
+			snapshot->peeled = PEELED_TAGS;
+
+		*sorted = unsorted_string_list_has_string(&traits, "sorted");
+
+		/* perhaps other traits later as well */
+
+		/* The "+ 1" is for the LF character. */
+		snapshot->start = eol + 1;
+
+		string_list_clear(&traits, 0);
+		free(tmp);
+	}
+
+	return 0;
+}
+
+int packed_read_raw_ref_v1(struct packed_ref_store *refs, struct snapshot *snapshot,
+			   const char *refname, struct object_id *oid,
+			   unsigned int *type, int *failure_errno)
+{
+	const char *rec;
+
+	*type = 0;
+
+	rec = find_reference_location_v1(snapshot, refname, 1);
+
+	if (!rec) {
+		/* refname is not a packed reference. */
+		*failure_errno = ENOENT;
+		return -1;
+	}
+
+	if (get_oid_hex(rec, oid))
+		die_invalid_line(refs->path, rec, snapshot->eof - rec);
+
+	*type = REF_ISPACKED;
+	return 0;
+}
+
+int next_record_v1(struct packed_ref_iterator *iter)
+{
+	const char *p = iter->pos, *eol;
+
+	strbuf_reset(&iter->refname_buf);
+
+	if (iter->pos == iter->eof)
+		return ITER_DONE;
+
+	iter->base.flags = REF_ISPACKED;
+
+	if (iter->eof - p < the_hash_algo->hexsz + 2 ||
+	    parse_oid_hex(p, &iter->oid, &p) ||
+	    !isspace(*p++))
+		die_invalid_line(iter->snapshot->refs->path,
+				 iter->pos, iter->eof - iter->pos);
+
+	eol = memchr(p, '\n', iter->eof - p);
+	if (!eol)
+		die_unterminated_line(iter->snapshot->refs->path,
+				      iter->pos, iter->eof - iter->pos);
+
+	strbuf_add(&iter->refname_buf, p, eol - p);
+	iter->base.refname = iter->refname_buf.buf;
+
+	if (check_refname_format(iter->base.refname, REFNAME_ALLOW_ONELEVEL)) {
+		if (!refname_is_safe(iter->base.refname))
+			die("packed refname is dangerous: %s",
+			    iter->base.refname);
+		oidclr(&iter->oid);
+		iter->base.flags |= REF_BAD_NAME | REF_ISBROKEN;
+	}
+	if (iter->snapshot->peeled == PEELED_FULLY ||
+	    (iter->snapshot->peeled == PEELED_TAGS &&
+	     starts_with(iter->base.refname, "refs/tags/")))
+		iter->base.flags |= REF_KNOWS_PEELED;
+
+	iter->pos = eol + 1;
+
+	if (iter->pos < iter->eof && *iter->pos == '^') {
+		p = iter->pos + 1;
+		if (iter->eof - p < the_hash_algo->hexsz + 1 ||
+		    parse_oid_hex(p, &iter->peeled, &p) ||
+		    *p++ != '\n')
+			die_invalid_line(iter->snapshot->refs->path,
+					 iter->pos, iter->eof - iter->pos);
+		iter->pos = p;
+
+		/*
+		 * Regardless of what the file header said, we
+		 * definitely know the value of *this* reference. But
+		 * we suppress it if the reference is broken:
+		 */
+		if ((iter->base.flags & REF_ISBROKEN)) {
+			oidclr(&iter->peeled);
+			iter->base.flags &= ~REF_KNOWS_PEELED;
+		} else {
+			iter->base.flags |= REF_KNOWS_PEELED;
+		}
+	} else {
+		oidclr(&iter->peeled);
+	}
+
+	return ITER_OK;
+}
+
+/*
+ * The packed-refs header line that we write out. Perhaps other traits
+ * will be added later.
+ *
+ * Note that earlier versions of Git used to parse these traits by
+ * looking for " trait " in the line. For this reason, the space after
+ * the colon and the trailing space are required.
+ */
+static const char PACKED_REFS_HEADER[] =
+	"# pack-refs with: peeled fully-peeled sorted \n";
+
+int write_packed_file_header_v1(FILE *out)
+{
+	return fprintf(out, "%s", PACKED_REFS_HEADER);
+}
+
+/*
+ * Write an entry to the packed-refs file for the specified refname.
+ * If peeled is non-NULL, write it as the entry's peeled value. On
+ * error, return a nonzero value and leave errno set at the value left
+ * by the failing call to `fprintf()`.
+ */
+int write_packed_entry_v1(FILE *fh, const char *refname,
+			  const struct object_id *oid,
+			  const struct object_id *peeled)
+{
+	if (fprintf(fh, "%s %s\n", oid_to_hex(oid), refname) < 0 ||
+	    (peeled && fprintf(fh, "^%s\n", oid_to_hex(peeled)) < 0))
+		return -1;
+
+	return 0;
+}
-- 
gitgitgadget

