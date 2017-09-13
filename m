Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7184220A21
	for <e@80x24.org>; Wed, 13 Sep 2017 17:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbdIMRRN (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:17:13 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:56945 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751435AbdIMRRH (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 13:17:07 -0400
X-AuditID: 1207440f-a5bff70000007960-0c-59b96811de57
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 37.14.31072.11869B95; Wed, 13 Sep 2017 13:17:05 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC855.dip0.t-ipconnect.de [87.188.200.85])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8DHGIii001379
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 13 Sep 2017 13:17:03 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 20/20] packed-backend.c: rename a bunch of things and update comments
Date:   Wed, 13 Sep 2017 19:16:14 +0200
Message-Id: <8844c66d7b245dda7a2fa2794cb4051b5b2b35e2.1505319366.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505319366.git.mhagger@alum.mit.edu>
References: <cover.1505319366.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqCuYsTPSYNt+E4u1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj2e9exg9
        Ll5S9vi8SS6ALYrLJiU1J7MstUjfLoEr48KGOcwF814zVqzcd421gfHAbsYuRk4OCQETic/b
        njCB2EICO5gk5mySgLBPMklc/FAMYrMJ6Eos6mkGqxERUJOY2HaIpYuRi4NZ4CmTxM6Td1lB
        EsICoRI7N25jBrFZBFQlNuxeDbaAVyBK4tv6NlaIZfIS5x7cBqvhFLCQ2LjjCSPEMnOJxjk7
        oeoFJU7OfAK0gANogbrE+nlCIGFmoNbmrbOZJzDyz0JSNQuhahaSqgWMzKsY5RJzSnN1cxMz
        c4pTk3WLkxPz8lKLdE30cjNL9FJTSjcxQsKdfwdj13qZQ4wCHIxKPLwPLHdGCrEmlhVX5h5i
        lORgUhLl3asLFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCGxQFlONNSaysSi3Kh0lJc7AoifOq
        L1H3ExJITyxJzU5NLUgtgsnKcHAoSfA6pQM1ChalpqdWpGXmlCCkmTg4QYbzAA0XBKnhLS5I
        zC3OTIfIn2LU5ei4efcPkxBLXn5eqpQ4799UoCIBkKKM0jy4ObA09YpRHOgtYV57kFE8wBQH
        N+kV0BImoCVnTu8AWVKSiJCSamBMPh/adaze+t65AIu9C2dyZCTEFs7bvuE5b9dhnwPKM8PD
        zR8UXjulXnPTJ2Dp2d5bMr/Wh1q31+SWHnm8mrEzaYbGx3zZi1ypk4K2mL7d4nromOG2Ra8S
        fJmvNJRtcy5r7P+zLW2J86afmdza+3v0EwyYS7JKuF+8/BGSMNlly/MpenvjracosRRnJBpq
        MRcVJwIABSbN8S4DAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've made huge changes to this file, and some of the old names and
comments are no longer very fitting. So rename a bunch of things:

* `struct packed_ref_cache` → `struct snapshot`
* `acquire_packed_ref_cache()` → `acquire_snapshot()`
* `release_packed_ref_buffer()` → `clear_snapshot_buffer()`
* `release_packed_ref_cache()` → `release_snapshot()`
* `clear_packed_ref_cache()` → `clear_snapshot()`
* `struct packed_ref_entry` → `struct snapshot_record`
* `cmp_packed_ref_entries()` → `cmp_packed_ref_records()`
* `cmp_entry_to_refname()` → `cmp_record_to_refname()`
* `sort_packed_refs()` → `sort_snapshot()`
* `read_packed_refs()` → `create_snapshot()`
* `validate_packed_ref_cache()` → `validate_snapshot()`
* `get_packed_ref_cache()` → `get_snapshot()`
* Renamed local variables and struct members accordingly.

Also update a bunch of comments to reflect the renaming and the
accumulated changes that the code has undergone.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 392 ++++++++++++++++++++++++++++----------------------
 1 file changed, 217 insertions(+), 175 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a3f8a19b9b..8235ac8506 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -8,10 +8,30 @@
 
 struct packed_ref_store;
 
-struct packed_ref_cache {
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
 	/*
 	 * A back-pointer to the packed_ref_store with which this
-	 * cache is associated:
+	 * snapshot is associated:
 	 */
 	struct packed_ref_store *refs;
 
@@ -35,26 +55,42 @@ struct packed_ref_cache {
 	size_t header_len;
 
 	/*
-	 * What is the peeled state of this cache? (This is usually
-	 * determined from the header of the "packed-refs" file.)
+	 * What is the peeled state of the `packed-refs` file that
+	 * this snapshot represents? (This is usually determined from
+	 * the file's header.)
 	 */
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled;
 
 	/*
-	 * Count of references to the data structure in this instance,
-	 * including the pointer from files_ref_store::packed if any.
-	 * The data will not be freed as long as the reference count
-	 * is nonzero.
+	 * Count of references to this instance, including the pointer
+	 * from `packed_ref_store::snapshot`, if any. The instance
+	 * will not be freed as long as the reference count is
+	 * nonzero.
 	 */
 	unsigned int referrers;
 
-	/* The metadata from when this packed-refs cache was read */
+	/*
+	 * The metadata of the `packed-refs` file from which this
+	 * snapshot was created, used to tell if the file has been
+	 * replaced since we read it.
+	 */
 	struct stat_validity validity;
 };
 
 /*
- * A container for `packed-refs`-related data. It is not (yet) a
- * `ref_store`.
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
  */
 struct packed_ref_store {
 	struct ref_store base;
@@ -65,10 +101,10 @@ struct packed_ref_store {
 	char *path;
 
 	/*
-	 * A cache of the values read from the `packed-refs` file, if
-	 * it might still be current; otherwise, NULL.
+	 * A snapshot of the values read from the `packed-refs` file,
+	 * if it might still be current; otherwise, NULL.
 	 */
-	struct packed_ref_cache *cache;
+	struct snapshot *snapshot;
 
 	/*
 	 * Lock used for the "packed-refs" file. Note that this (and
@@ -85,44 +121,43 @@ struct packed_ref_store {
 };
 
 /*
- * Increment the reference count of *packed_refs.
+ * Increment the reference count of `*snapshot`.
  */
-static void acquire_packed_ref_cache(struct packed_ref_cache *packed_refs)
+static void acquire_snapshot(struct snapshot *snapshot)
 {
-	packed_refs->referrers++;
+	snapshot->referrers++;
 }
 
 /*
- * If the buffer in `packed_refs` is active, then either munmap the
+ * If the buffer in `snapshot` is active, then either munmap the
  * memory and close the file, or free the memory. Then set the buffer
  * pointers to NULL.
  */
-static void release_packed_ref_buffer(struct packed_ref_cache *packed_refs)
+static void clear_snapshot_buffer(struct snapshot *snapshot)
 {
-	if (packed_refs->fd >= 0) {
-		if (munmap(packed_refs->buf,
-			   packed_refs->eof - packed_refs->buf))
+	if (snapshot->fd >= 0) {
+		if (munmap(snapshot->buf, snapshot->eof - snapshot->buf))
 			die_errno("error ummapping packed-refs file %s",
-				  packed_refs->refs->path);
-		close(packed_refs->fd);
-		packed_refs->fd = -1;
+				  snapshot->refs->path);
+		close(snapshot->fd);
+		snapshot->fd = -1;
 	} else {
-		free(packed_refs->buf);
+		free(snapshot->buf);
 	}
-	packed_refs->buf = packed_refs->eof = NULL;
-	packed_refs->header_len = 0;
+	snapshot->buf = snapshot->eof = NULL;
+	snapshot->header_len = 0;
 }
 
 /*
- * Decrease the reference count of *packed_refs.  If it goes to zero,
- * free *packed_refs and return true; otherwise return false.
+ * Decrease the reference count of `*snapshot`. If it goes to zero,
+ * free `*snapshot` and return true; otherwise return false.
  */
-static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
+static int release_snapshot(struct snapshot *snapshot)
 {
-	if (!--packed_refs->referrers) {
-		stat_validity_clear(&packed_refs->validity);
-		release_packed_ref_buffer(packed_refs);
-		free(packed_refs);
+	if (!--snapshot->referrers) {
+		stat_validity_clear(&snapshot->validity);
+		clear_snapshot_buffer(snapshot);
+		free(snapshot);
 		return 1;
 	} else {
 		return 0;
@@ -167,13 +202,13 @@ static struct packed_ref_store *packed_downcast(struct ref_store *ref_store,
 	return refs;
 }
 
-static void clear_packed_ref_cache(struct packed_ref_store *refs)
+static void clear_snapshot(struct packed_ref_store *refs)
 {
-	if (refs->cache) {
-		struct packed_ref_cache *cache = refs->cache;
+	if (refs->snapshot) {
+		struct snapshot *snapshot = refs->snapshot;
 
-		refs->cache = NULL;
-		release_packed_ref_cache(cache);
+		refs->snapshot = NULL;
+		release_snapshot(snapshot);
 	}
 }
 
@@ -200,14 +235,14 @@ static NORETURN void die_invalid_line(const char *path,
 
 }
 
-struct packed_ref_entry {
+struct snapshot_record {
 	const char *start;
 	size_t len;
 };
 
-static int cmp_packed_ref_entries(const void *v1, const void *v2)
+static int cmp_packed_ref_records(const void *v1, const void *v2)
 {
-	const struct packed_ref_entry *e1 = v1, *e2 = v2;
+	const struct snapshot_record *e1 = v1, *e2 = v2;
 	const char *r1 = e1->start + GIT_SHA1_HEXSZ + 1;
 	const char *r2 = e2->start + GIT_SHA1_HEXSZ + 1;
 
@@ -226,10 +261,10 @@ static int cmp_packed_ref_entries(const void *v1, const void *v2)
 }
 
 /*
- * Compare a packed-refs record pointed to by `rec` to the specified
- * NUL-terminated refname.
+ * Compare a snapshot record at `rec` to the specified NUL-terminated
+ * refname.
  */
-static int cmp_entry_to_refname(const char *rec, const char *refname)
+static int cmp_record_to_refname(const char *rec, const char *refname)
 {
 	const char *r1 = rec + GIT_SHA1_HEXSZ + 1;
 	const char *r2 = refname;
@@ -247,31 +282,30 @@ static int cmp_entry_to_refname(const char *rec, const char *refname)
 }
 
 /*
- * `packed_refs->buf` is not known to be sorted. Check whether it is,
- * and if not, sort it into new memory and munmap/free the old
- * storage.
+ * `snapshot->buf` is not known to be sorted. Check whether it is, and
+ * if not, sort it into new memory and munmap/free the old storage.
  */
-static void sort_packed_refs(struct packed_ref_cache *packed_refs)
+static void sort_snapshot(struct snapshot *snapshot)
 {
-	struct packed_ref_entry *entries = NULL;
+	struct snapshot_record *records = NULL;
 	size_t alloc = 0, nr = 0;
 	int sorted = 1;
 	const char *pos, *eof, *eol;
 	size_t len, i;
 	char *new_buffer, *dst;
 
-	pos = packed_refs->buf + packed_refs->header_len;
-	eof = packed_refs->eof;
+	pos = snapshot->buf + snapshot->header_len;
+	eof = snapshot->eof;
 	len = eof - pos;
 
 	if (!len)
 		return;
 
 	/*
-	 * Initialize entries based on a crude estimate of the number
+	 * Initialize records based on a crude estimate of the number
 	 * of references in the file (we'll grow it below if needed):
 	 */
-	ALLOC_GROW(entries, len / 80 + 20, alloc);
+	ALLOC_GROW(records, len / 80 + 20, alloc);
 
 	while (pos < eof) {
 		eol = memchr(pos, '\n', eof - pos);
@@ -279,7 +313,7 @@ static void sort_packed_refs(struct packed_ref_cache *packed_refs)
 			/* The safety check should prevent this. */
 			BUG("unterminated line found in packed-refs");
 		if (eol - pos < GIT_SHA1_HEXSZ + 2)
-			die_invalid_line(packed_refs->refs->path,
+			die_invalid_line(snapshot->refs->path,
 					 pos, eof - pos);
 		eol++;
 		if (eol < eof && *eol == '^') {
@@ -296,15 +330,15 @@ static void sort_packed_refs(struct packed_ref_cache *packed_refs)
 			eol++;
 		}
 
-		ALLOC_GROW(entries, nr + 1, alloc);
-		entries[nr].start = pos;
-		entries[nr].len = eol - pos;
+		ALLOC_GROW(records, nr + 1, alloc);
+		records[nr].start = pos;
+		records[nr].len = eol - pos;
 		nr++;
 
 		if (sorted &&
 		    nr > 1 &&
-		    cmp_packed_ref_entries(&entries[nr - 2],
-					   &entries[nr - 1]) >= 0)
+		    cmp_packed_ref_records(&records[nr - 2],
+					   &records[nr - 1]) >= 0)
 			sorted = 0;
 
 		pos = eol;
@@ -313,31 +347,31 @@ static void sort_packed_refs(struct packed_ref_cache *packed_refs)
 	if (sorted)
 		goto cleanup;
 
-	/* We need to sort the memory. First we sort the entries array: */
-	QSORT(entries, nr, cmp_packed_ref_entries);
+	/* We need to sort the memory. First we sort the records array: */
+	QSORT(records, nr, cmp_packed_ref_records);
 
 	/*
 	 * Allocate a new chunk of memory, and copy the old memory to
-	 * the new in the order indicated by `entries` (not bothering
+	 * the new in the order indicated by `records` (not bothering
 	 * with the header line):
 	 */
 	new_buffer = xmalloc(len);
 	for (dst = new_buffer, i = 0; i < nr; i++) {
-		memcpy(dst, entries[i].start, entries[i].len);
-		dst += entries[i].len;
+		memcpy(dst, records[i].start, records[i].len);
+		dst += records[i].len;
 	}
 
 	/*
 	 * Now munmap the old buffer and use the sorted buffer in its
 	 * place:
 	 */
-	release_packed_ref_buffer(packed_refs);
-	packed_refs->buf = new_buffer;
-	packed_refs->eof = new_buffer + len;
-	packed_refs->header_len = 0;
+	clear_snapshot_buffer(snapshot);
+	snapshot->buf = new_buffer;
+	snapshot->eof = new_buffer + len;
+	snapshot->header_len = 0;
 
 cleanup:
-	free(entries);
+	free(records);
 }
 
 /*
@@ -381,10 +415,10 @@ static const char *find_end_of_record(const char *p, const char *end)
  * (GIT_SHA1_HEXSZ + 1) characters before the LF. Die if either of
  * these checks fails.
  */
-static void verify_buffer_safe(struct packed_ref_cache *packed_refs)
+static void verify_buffer_safe(struct snapshot *snapshot)
 {
-	const char *buf = packed_refs->buf + packed_refs->header_len;
-	const char *eof = packed_refs->eof;
+	const char *buf = snapshot->buf + snapshot->header_len;
+	const char *eof = snapshot->eof;
 	const char *last_line;
 
 	if (buf == eof)
@@ -392,12 +426,12 @@ static void verify_buffer_safe(struct packed_ref_cache *packed_refs)
 
 	last_line = find_start_of_record(buf, eof - 1);
 	if (*(eof - 1) != '\n' || eof - last_line < GIT_SHA1_HEXSZ + 2)
-		die_invalid_line(packed_refs->refs->path,
+		die_invalid_line(snapshot->refs->path,
 				 last_line, eof - last_line);
 }
 
 /*
- * Find the place in `cache->buf` where the start of the record for
+ * Find the place in `snapshot->buf` where the start of the record for
  * `refname` starts. If `mustexist` is true and the reference doesn't
  * exist, then return NULL. If `mustexist` is false and the reference
  * doesn't exist, then return the point where that reference would be
@@ -405,10 +439,10 @@ static void verify_buffer_safe(struct packed_ref_cache *packed_refs)
  * reference name; for example, one could search for "refs/replace/"
  * to find the start of any replace references.
  *
- * The record is sought using a binary search, so `cache->buf` must be
- * sorted.
+ * The record is sought using a binary search, so `snapshot->buf` must
+ * be sorted.
  */
-static const char *find_reference_location(struct packed_ref_cache *cache,
+static const char *find_reference_location(struct snapshot *snapshot,
 					   const char *refname, int mustexist)
 {
 	/*
@@ -425,13 +459,13 @@ static const char *find_reference_location(struct packed_ref_cache *cache,
 	 * preceding records all have reference names that come
 	 * *before* `refname`.
 	 */
-	const char *lo = cache->buf + cache->header_len;
+	const char *lo = snapshot->buf + snapshot->header_len;
 
 	/*
 	 * A pointer to a the first character of a record whose
 	 * reference name comes *after* `refname`.
 	 */
-	const char *hi = cache->eof;
+	const char *hi = snapshot->eof;
 
 	while (lo < hi) {
 		const char *mid, *rec;
@@ -439,7 +473,7 @@ static const char *find_reference_location(struct packed_ref_cache *cache,
 
 		mid = lo + (hi - lo) / 2;
 		rec = find_start_of_record(lo, mid);
-		cmp = cmp_entry_to_refname(rec, refname);
+		cmp = cmp_record_to_refname(rec, refname);
 		if (cmp < 0) {
 			lo = find_end_of_record(mid, hi);
 		} else if (cmp > 0) {
@@ -456,9 +490,9 @@ static const char *find_reference_location(struct packed_ref_cache *cache,
 }
 
 /*
- * Read from the `packed-refs` file into a newly-allocated
- * `packed_ref_cache` and return it. The return value will already
- * have its reference count incremented.
+ * Create a newly-allocated `snapshot` of the `packed-refs` file in
+ * its current state and return it. The return value will already have
+ * its reference count incremented.
  *
  * A comment line of the form "# pack-refs with: " may contain zero or
  * more traits. We interpret the traits as follows:
@@ -488,19 +522,19 @@ static const char *find_reference_location(struct packed_ref_cache *cache,
  *
  *      The references in this file are known to be sorted by refname.
  */
-static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
+static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 {
-	struct packed_ref_cache *packed_refs = xcalloc(1, sizeof(*packed_refs));
+	struct snapshot *snapshot = xcalloc(1, sizeof(*snapshot));
 	struct stat st;
 	size_t size;
 	int sorted = 0;
 
-	packed_refs->refs = refs;
-	acquire_packed_ref_cache(packed_refs);
-	packed_refs->peeled = PEELED_NONE;
+	snapshot->refs = refs;
+	acquire_snapshot(snapshot);
+	snapshot->peeled = PEELED_NONE;
 
-	packed_refs->fd = open(refs->path, O_RDONLY);
-	if (packed_refs->fd < 0) {
+	snapshot->fd = open(refs->path, O_RDONLY);
+	if (snapshot->fd < 0) {
 		if (errno == ENOENT) {
 			/*
 			 * This is OK; it just means that no
@@ -509,106 +543,106 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 			 * which is its state when initialized with
 			 * zeros.
 			 */
-			return packed_refs;
+			return snapshot;
 		} else {
 			die_errno("couldn't read %s", refs->path);
 		}
 	}
 
-	stat_validity_update(&packed_refs->validity, packed_refs->fd);
+	stat_validity_update(&snapshot->validity, snapshot->fd);
 
-	if (fstat(packed_refs->fd, &st) < 0)
+	if (fstat(snapshot->fd, &st) < 0)
 		die_errno("couldn't stat %s", refs->path);
 
 	size = xsize_t(st.st_size);
-	packed_refs->buf = xmmap(NULL, size,
-				 PROT_READ, MAP_PRIVATE,
-				 packed_refs->fd, 0);
-	packed_refs->eof = packed_refs->buf + size;
+	snapshot->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE,
+			      snapshot->fd, 0);
+	snapshot->eof = snapshot->buf + size;
 
 	/* If the file has a header line, process it: */
-	if (packed_refs->buf < packed_refs->eof && *packed_refs->buf == '#') {
+	if (snapshot->buf < snapshot->eof && *snapshot->buf == '#') {
 		struct strbuf tmp = STRBUF_INIT;
 		char *p;
 		const char *eol;
 		struct string_list traits = STRING_LIST_INIT_NODUP;
 
-		eol = memchr(packed_refs->buf, '\n',
-			     packed_refs->eof - packed_refs->buf);
+		eol = memchr(snapshot->buf, '\n',
+			     snapshot->eof - snapshot->buf);
 		if (!eol)
 			die_unterminated_line(refs->path,
-					      packed_refs->buf,
-					      packed_refs->eof - packed_refs->buf);
+					      snapshot->buf,
+					      snapshot->eof - snapshot->buf);
 
-		strbuf_add(&tmp, packed_refs->buf, eol - packed_refs->buf);
+		strbuf_add(&tmp, snapshot->buf, eol - snapshot->buf);
 
 		if (!skip_prefix(tmp.buf, "# pack-refs with:", (const char **)&p))
 			die_invalid_line(refs->path,
-					 packed_refs->buf,
-					 packed_refs->eof - packed_refs->buf);
+					 snapshot->buf,
+					 snapshot->eof - snapshot->buf);
 
 		string_list_split_in_place(&traits, p, ' ', -1);
 
 		if (unsorted_string_list_has_string(&traits, "fully-peeled"))
-			packed_refs->peeled = PEELED_FULLY;
+			snapshot->peeled = PEELED_FULLY;
 		else if (unsorted_string_list_has_string(&traits, "peeled"))
-			packed_refs->peeled = PEELED_TAGS;
+			snapshot->peeled = PEELED_TAGS;
 
 		sorted = unsorted_string_list_has_string(&traits, "sorted");
 
 		/* perhaps other traits later as well */
 
 		/* The "+ 1" is for the LF character. */
-		packed_refs->header_len = eol + 1 - packed_refs->buf;
+		snapshot->header_len = eol + 1 - snapshot->buf;
 
 		string_list_clear(&traits, 0);
 		strbuf_release(&tmp);
 	}
 
-	verify_buffer_safe(packed_refs);
+	verify_buffer_safe(snapshot);
 
 	if (!sorted) {
-		sort_packed_refs(packed_refs);
+		sort_snapshot(snapshot);
 
 		/*
 		 * Reordering the records might have moved a short one
 		 * to the end of the buffer, so verify the buffer's
 		 * safety again:
 		 */
-		verify_buffer_safe(packed_refs);
+		verify_buffer_safe(snapshot);
 	}
 
-	return packed_refs;
+	return snapshot;
 }
 
 /*
- * Check that the packed refs cache (if any) still reflects the
- * contents of the file. If not, clear the cache.
+ * Check that `refs->snapshot` (if present) still reflects the
+ * contents of the `packed-refs` file. If not, clear the snapshot.
  */
-static void validate_packed_ref_cache(struct packed_ref_store *refs)
+static void validate_snapshot(struct packed_ref_store *refs)
 {
-	if (refs->cache &&
-	    !stat_validity_check(&refs->cache->validity, refs->path))
-		clear_packed_ref_cache(refs);
+	if (refs->snapshot &&
+	    !stat_validity_check(&refs->snapshot->validity, refs->path))
+		clear_snapshot(refs);
 }
 
 /*
- * Get the packed_ref_cache for the specified packed_ref_store,
- * creating and populating it if it hasn't been read before or if the
- * file has been changed (according to its `validity` field) since it
- * was last read. On the other hand, if we hold the lock, then assume
- * that the file hasn't been changed out from under us, so skip the
- * extra `stat()` call in `stat_validity_check()`.
+ * Get the `snapshot` for the specified packed_ref_store, creating and
+ * populating it if it hasn't been read before or if the file has been
+ * changed (according to its `validity` field) since it was last read.
+ * On the other hand, if we hold the lock, then assume that the file
+ * hasn't been changed out from under us, so skip the extra `stat()`
+ * call in `stat_validity_check()`. This function does *not* increase
+ * the snapshot's reference count on behalf of the caller.
  */
-static struct packed_ref_cache *get_packed_ref_cache(struct packed_ref_store *refs)
+static struct snapshot *get_snapshot(struct packed_ref_store *refs)
 {
 	if (!is_lock_file_locked(&refs->lock))
-		validate_packed_ref_cache(refs);
+		validate_snapshot(refs);
 
-	if (!refs->cache)
-		refs->cache = read_packed_refs(refs);
+	if (!refs->snapshot)
+		refs->snapshot = create_snapshot(refs);
 
-	return refs->cache;
+	return refs->snapshot;
 }
 
 static int packed_read_raw_ref(struct ref_store *ref_store,
@@ -617,12 +651,12 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
 {
 	struct packed_ref_store *refs =
 		packed_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
-	struct packed_ref_cache *packed_refs = get_packed_ref_cache(refs);
+	struct snapshot *snapshot = get_snapshot(refs);
 	const char *rec;
 
 	*type = 0;
 
-	rec = find_reference_location(packed_refs, refname, 1);
+	rec = find_reference_location(snapshot, refname, 1);
 
 	if (!rec) {
 		/* refname is not a packed reference. */
@@ -631,7 +665,7 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
 	}
 
 	if (get_sha1_hex(rec, sha1))
-		die_invalid_line(refs->path, rec, packed_refs->eof - rec);
+		die_invalid_line(refs->path, rec, snapshot->eof - rec);
 
 	*type = REF_ISPACKED;
 	return 0;
@@ -646,26 +680,33 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
 #define REF_KNOWS_PEELED 0x40
 
 /*
- * An iterator over a packed-refs file that is currently mmapped.
+ * An iterator over a snapshot of a `packed-refs` file.
  */
 struct packed_ref_iterator {
 	struct ref_iterator base;
 
-	struct packed_ref_cache *packed_refs;
+	struct snapshot *snapshot;
 
-	/* The current position in the mmapped file: */
+	/* The current position in the snapshot's buffer: */
 	const char *pos;
 
-	/* The end of the mmapped file: */
+	/* The end of the part of the buffer that will be iterated over: */
 	const char *eof;
 
+	/* Scratch space for current values: */
 	struct object_id oid, peeled;
-
 	struct strbuf refname_buf;
 
 	unsigned int flags;
 };
 
+/*
+ * Move the iterator to the next record in the snapshot, without
+ * respect for whether the record is actually required by the current
+ * iteration. Adjust the fields in `iter` and return `ITER_OK` or
+ * `ITER_DONE`. This function does not free the iterator in the case
+ * of `ITER_DONE`.
+ */
 static int next_record(struct packed_ref_iterator *iter)
 {
 	const char *p = iter->pos, *eol;
@@ -680,12 +721,12 @@ static int next_record(struct packed_ref_iterator *iter)
 	if (iter->eof - p < GIT_SHA1_HEXSZ + 2 ||
 	    parse_oid_hex(p, &iter->oid, &p) ||
 	    !isspace(*p++))
-		die_invalid_line(iter->packed_refs->refs->path,
+		die_invalid_line(iter->snapshot->refs->path,
 				 iter->pos, iter->eof - iter->pos);
 
 	eol = memchr(p, '\n', iter->eof - p);
 	if (!eol)
-		die_unterminated_line(iter->packed_refs->refs->path,
+		die_unterminated_line(iter->snapshot->refs->path,
 				      iter->pos, iter->eof - iter->pos);
 
 	strbuf_add(&iter->refname_buf, p, eol - p);
@@ -698,8 +739,8 @@ static int next_record(struct packed_ref_iterator *iter)
 		oidclr(&iter->oid);
 		iter->base.flags |= REF_BAD_NAME | REF_ISBROKEN;
 	}
-	if (iter->packed_refs->peeled == PEELED_FULLY ||
-	    (iter->packed_refs->peeled == PEELED_TAGS &&
+	if (iter->snapshot->peeled == PEELED_FULLY ||
+	    (iter->snapshot->peeled == PEELED_TAGS &&
 	     starts_with(iter->base.refname, "refs/tags/")))
 		iter->base.flags |= REF_KNOWS_PEELED;
 
@@ -710,7 +751,7 @@ static int next_record(struct packed_ref_iterator *iter)
 		if (iter->eof - p < GIT_SHA1_HEXSZ + 1 ||
 		    parse_oid_hex(p, &iter->peeled, &p) ||
 		    *p++ != '\n')
-			die_invalid_line(iter->packed_refs->refs->path,
+			die_invalid_line(iter->snapshot->refs->path,
 					 iter->pos, iter->eof - iter->pos);
 		iter->pos = p;
 
@@ -780,7 +821,7 @@ static int packed_ref_iterator_abort(struct ref_iterator *ref_iterator)
 	int ok = ITER_DONE;
 
 	strbuf_release(&iter->refname_buf);
-	release_packed_ref_cache(iter->packed_refs);
+	release_snapshot(iter->snapshot);
 	base_ref_iterator_free(ref_iterator);
 	return ok;
 }
@@ -796,7 +837,7 @@ static struct ref_iterator *packed_ref_iterator_begin(
 		const char *prefix, unsigned int flags)
 {
 	struct packed_ref_store *refs;
-	struct packed_ref_cache *packed_refs;
+	struct snapshot *snapshot;
 	const char *start;
 	struct packed_ref_iterator *iter;
 	struct ref_iterator *ref_iterator;
@@ -806,30 +847,30 @@ static struct ref_iterator *packed_ref_iterator_begin(
 		required_flags |= REF_STORE_ODB;
 	refs = packed_downcast(ref_store, required_flags, "ref_iterator_begin");
 
-	packed_refs = get_packed_ref_cache(refs);
+	/*
+	 * Note that `get_snapshot()` internally checks whether the
+	 * snapshot is up to date with what is on disk, and re-reads
+	 * it if not.
+	 */
+	snapshot = get_snapshot(refs);
 
-	if (!packed_refs->buf)
+	if (!snapshot->buf)
 		return empty_ref_iterator_begin();
 
 	iter = xcalloc(1, sizeof(*iter));
 	ref_iterator = &iter->base;
 	base_ref_iterator_init(ref_iterator, &packed_ref_iterator_vtable, 1);
 
-	/*
-	 * Note that get_packed_ref_cache() internally checks whether
-	 * the packed-ref cache is up to date with what is on disk,
-	 * and re-reads it if not.
-	 */
-	iter->packed_refs = packed_refs;
-	acquire_packed_ref_cache(packed_refs);
+	iter->snapshot = snapshot;
+	acquire_snapshot(snapshot);
 
 	if (prefix && *prefix)
-		start = find_reference_location(packed_refs, prefix, 0);
+		start = find_reference_location(snapshot, prefix, 0);
 	else
-		start = packed_refs->buf + packed_refs->header_len;
+		start = snapshot->buf + snapshot->header_len;
 
 	iter->pos = start;
-	iter->eof = packed_refs->eof;
+	iter->eof = snapshot->eof;
 	strbuf_init(&iter->refname_buf, 0);
 
 	iter->base.oid = &iter->oid;
@@ -893,19 +934,19 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 
 	/*
 	 * Now that we hold the `packed-refs` lock, make sure that our
-	 * cache matches the current version of the file. Normally
-	 * `get_packed_ref_cache()` does that for us, but that
-	 * function assumes that when the file is locked, any existing
-	 * cache is still valid. We've just locked the file, but it
-	 * might have changed the moment *before* we locked it.
+	 * snapshot matches the current version of the file. Normally
+	 * `get_snapshot()` does that for us, but that function
+	 * assumes that when the file is locked, any existing snapshot
+	 * is still valid. We've just locked the file, but it might
+	 * have changed the moment *before* we locked it.
 	 */
-	validate_packed_ref_cache(refs);
+	validate_snapshot(refs);
 
 	/*
 	 * Now make sure that the packed-refs file as it exists in the
-	 * locked state is loaded into the cache:
+	 * locked state is loaded into the snapshot:
 	 */
-	get_packed_ref_cache(refs);
+	get_snapshot(refs);
 	return 0;
 }
 
@@ -932,8 +973,8 @@ int packed_refs_is_locked(struct ref_store *ref_store)
 }
 
 /*
- * The packed-refs header line that we write out.  Perhaps other
- * traits will be added later.
+ * The packed-refs header line that we write out. Perhaps other traits
+ * will be added later.
  *
  * Note that earlier versions of Git used to parse these traits by
  * looking for " trait " in the line. For this reason, the space after
@@ -949,9 +990,9 @@ static int packed_init_db(struct ref_store *ref_store, struct strbuf *err)
 }
 
 /*
- * Write the packed-refs from the cache to the packed-refs tempfile,
- * incorporating any changes from `updates`. `updates` must be a
- * sorted string list whose keys are the refnames and whose util
+ * Write the packed refs from the current snapshot to the packed-refs
+ * tempfile, incorporating any changes from `updates`. `updates` must
+ * be a sorted string list whose keys are the refnames and whose util
  * values are `struct ref_update *`. On error, rollback the tempfile,
  * write an error message to `err`, and return a nonzero value.
  *
@@ -1192,9 +1233,10 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 	/*
 	 * Note that we *don't* skip transactions with zero updates,
 	 * because such a transaction might be executed for the side
-	 * effect of ensuring that all of the references are peeled.
-	 * If the caller wants to optimize away empty transactions, it
-	 * should do so itself.
+	 * effect of ensuring that all of the references are peeled or
+	 * ensuring that the `packed-refs` file is sorted. If the
+	 * caller wants to optimize away empty transactions, it should
+	 * do so itself.
 	 */
 
 	data = xcalloc(1, sizeof(*data));
@@ -1267,7 +1309,7 @@ static int packed_transaction_finish(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	clear_packed_ref_cache(refs);
+	clear_snapshot(refs);
 	ret = 0;
 
 cleanup:
-- 
2.14.1

