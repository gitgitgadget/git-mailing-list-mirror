Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4CAC20A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754900AbdDPGmg (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:42:36 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:60130 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753167AbdDPGmd (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:42:33 -0400
X-AuditID: 12074414-7efff70000002bfd-99-58f31258926c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C4.7D.11261.85213F85; Sun, 16 Apr 2017 02:42:32 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGN6025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:42:30 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 05/20] refs_verify_refname_available(): use function in more places
Date:   Sun, 16 Apr 2017 08:41:27 +0200
Message-Id: <1e3dec0a827da33c2d5064e0f25f4ded0f247c9b.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsUixO6iqBsh9DnCoOGtjMXaZ3eYLLqudDNZ
        NPReYba4vWI+s8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+6xYFOpR1f7ETaP
        Z717GD0uXlL2+LxJLoA9issmJTUnsyy1SN8ugStjyfNZTAUzbSrOXf3E2MC4UK+LkZNDQsBE
        YvvvXYxdjFwcQgI7mCQOTX8P5Zxgklj5pYcNpIpNQFdiUU8zE4gtIqAmMbHtEAtIEbPAYyaJ
        v8u6WUASwgJhEjteTGYHsVkEVCU2T90FFucViJK4N+MPE8Q6eYldbRdZQWxOAQuJKXc3gNUI
        CZhLbD9+lXkCI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRboWermZJXqpKaWbGCHBJrKD
        8chJuUOMAhyMSjy8Fv6fIoRYE8uKK3MPMUpyMCmJ8sr8BwrxJeWnVGYkFmfEF5XmpBYfYpTg
        YFYS4U1m+RwhxJuSWFmVWpQPk5LmYFES5/22WN1PSCA9sSQ1OzW1ILUIJivDwaEkwRstCNQo
        WJSanlqRlplTgpBm4uAEGc4DNHyrAMjw4oLE3OLMdIj8KUZFKXHeHyAJAZBERmkeXC8sGbxi
        FAd6RZiXGWQFDzCRwHW/AhrMBDSYYfIHkMEliQgpqQZGf413lQY2Xyf31CTLTvBIytENX8Gn
        sSZGbkLcw5nrXy54wMHp8HtN2AfRx/Nt9q/rOqejnfXyBRvHp4Dg5eXuc8S5NzV8fLltrfBF
        w7TPSatPNzokvcxWfcBQ9C1E4nHXf8nTHjkW29uCX6f5HaytsHk748wlQ9H2F29lNklu23u4
        Yv0mo2QrJZbijERDLeai4kQAPIZQU+ECAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change `lock_raw_ref()` and `lock_ref_sha1_basic()` to use
`refs_verify_refname_available()` instead of
`verify_refname_available_dir()`. This means that those callsites now
check for conflicts with all references rather than just packed refs,
but the performance cost shouldn't be significant (and will be
regained later).

These were the last callers of `verify_refname_available_dir()`, so
also delete that (very complicated) function.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 171 ++++-----------------------------------------------
 1 file changed, 11 insertions(+), 160 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4185025efa..cf1c18cffb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -738,152 +738,6 @@ static struct ref_iterator *cache_ref_iterator_begin(struct ref_dir *dir)
 	return ref_iterator;
 }
 
-struct nonmatching_ref_data {
-	const struct string_list *skip;
-	const char *conflicting_refname;
-};
-
-static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
-{
-	struct nonmatching_ref_data *data = vdata;
-
-	if (data->skip && string_list_has_string(data->skip, entry->name))
-		return 0;
-
-	data->conflicting_refname = entry->name;
-	return 1;
-}
-
-/*
- * Return 0 if a reference named refname could be created without
- * conflicting with the name of an existing reference in dir.
- * See verify_refname_available for more information.
- */
-static int verify_refname_available_dir(const char *refname,
-					const struct string_list *extras,
-					const struct string_list *skip,
-					struct ref_dir *dir,
-					struct strbuf *err)
-{
-	const char *slash;
-	const char *extra_refname;
-	int pos;
-	struct strbuf dirname = STRBUF_INIT;
-	int ret = -1;
-
-	/*
-	 * For the sake of comments in this function, suppose that
-	 * refname is "refs/foo/bar".
-	 */
-
-	assert(err);
-
-	strbuf_grow(&dirname, strlen(refname) + 1);
-	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
-		/* Expand dirname to the new prefix, not including the trailing slash: */
-		strbuf_add(&dirname, refname + dirname.len, slash - refname - dirname.len);
-
-		/*
-		 * We are still at a leading dir of the refname (e.g.,
-		 * "refs/foo"; if there is a reference with that name,
-		 * it is a conflict, *unless* it is in skip.
-		 */
-		if (dir) {
-			pos = search_ref_dir(dir, dirname.buf, dirname.len);
-			if (pos >= 0 &&
-			    (!skip || !string_list_has_string(skip, dirname.buf))) {
-				/*
-				 * We found a reference whose name is
-				 * a proper prefix of refname; e.g.,
-				 * "refs/foo", and is not in skip.
-				 */
-				strbuf_addf(err, "'%s' exists; cannot create '%s'",
-					    dirname.buf, refname);
-				goto cleanup;
-			}
-		}
-
-		if (extras && string_list_has_string(extras, dirname.buf) &&
-		    (!skip || !string_list_has_string(skip, dirname.buf))) {
-			strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
-				    refname, dirname.buf);
-			goto cleanup;
-		}
-
-		/*
-		 * Otherwise, we can try to continue our search with
-		 * the next component. So try to look up the
-		 * directory, e.g., "refs/foo/". If we come up empty,
-		 * we know there is nothing under this whole prefix,
-		 * but even in that case we still have to continue the
-		 * search for conflicts with extras.
-		 */
-		strbuf_addch(&dirname, '/');
-		if (dir) {
-			pos = search_ref_dir(dir, dirname.buf, dirname.len);
-			if (pos < 0) {
-				/*
-				 * There was no directory "refs/foo/",
-				 * so there is nothing under this
-				 * whole prefix. So there is no need
-				 * to continue looking for conflicting
-				 * references. But we need to continue
-				 * looking for conflicting extras.
-				 */
-				dir = NULL;
-			} else {
-				dir = get_ref_dir(dir->entries[pos]);
-			}
-		}
-	}
-
-	/*
-	 * We are at the leaf of our refname (e.g., "refs/foo/bar").
-	 * There is no point in searching for a reference with that
-	 * name, because a refname isn't considered to conflict with
-	 * itself. But we still need to check for references whose
-	 * names are in the "refs/foo/bar/" namespace, because they
-	 * *do* conflict.
-	 */
-	strbuf_addstr(&dirname, refname + dirname.len);
-	strbuf_addch(&dirname, '/');
-
-	if (dir) {
-		pos = search_ref_dir(dir, dirname.buf, dirname.len);
-
-		if (pos >= 0) {
-			/*
-			 * We found a directory named "$refname/"
-			 * (e.g., "refs/foo/bar/"). It is a problem
-			 * iff it contains any ref that is not in
-			 * "skip".
-			 */
-			struct nonmatching_ref_data data;
-
-			data.skip = skip;
-			data.conflicting_refname = NULL;
-			dir = get_ref_dir(dir->entries[pos]);
-			sort_ref_dir(dir);
-			if (do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data)) {
-				strbuf_addf(err, "'%s' exists; cannot create '%s'",
-					    data.conflicting_refname, refname);
-				goto cleanup;
-			}
-		}
-	}
-
-	extra_refname = find_descendant_ref(dirname.buf, extras, skip);
-	if (extra_refname)
-		strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
-			    refname, extra_refname);
-	else
-		ret = 0;
-
-cleanup:
-	strbuf_release(&dirname);
-	return ret;
-}
-
 struct packed_ref_cache {
 	struct ref_entry *root;
 
@@ -1562,7 +1416,7 @@ static void unlock_ref(struct ref_lock *lock)
  *
  * If the reference doesn't already exist, verify that refname doesn't
  * have a D/F conflict with any existing references. extras and skip
- * are passed to verify_refname_available_dir() for this check.
+ * are passed to refs_verify_refname_available() for this check.
  *
  * If mustexist is not set and the reference is not found or is
  * broken, lock the reference anyway but clear sha1.
@@ -1577,7 +1431,7 @@ static void unlock_ref(struct ref_lock *lock)
  *
  * but it includes a lot more code to
  * - Deal with possible races with other processes
- * - Avoid calling verify_refname_available_dir() when it can be
+ * - Avoid calling refs_verify_refname_available() when it can be
  *   avoided, namely if we were successfully able to read the ref
  * - Generate informative error messages in the case of failure
  */
@@ -1634,7 +1488,8 @@ static int lock_raw_ref(struct files_ref_store *refs,
 			} else {
 				/*
 				 * The error message set by
-				 * verify_refname_available_dir() is OK.
+				 * refs_verify_refname_available() is
+				 * OK.
 				 */
 				ret = TRANSACTION_NAME_CONFLICT;
 			}
@@ -1758,16 +1613,13 @@ static int lock_raw_ref(struct files_ref_store *refs,
 
 		/*
 		 * If the ref did not exist and we are creating it,
-		 * make sure there is no existing packed ref whose
-		 * name begins with our refname, nor a packed ref
-		 * whose name is a proper prefix of our refname.
+		 * make sure there is no existing ref that conflicts
+		 * with refname:
 		 */
-		if (verify_refname_available_dir(
-				    refname, extras, skip,
-				    get_packed_refs(refs),
-				    err)) {
+		if (refs_verify_refname_available(
+				    &refs->base, refname,
+				    extras, skip, err))
 			goto error_return;
-		}
 	}
 
 	ret = 0;
@@ -2122,9 +1974,8 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 	 * our refname.
 	 */
 	if (is_null_oid(&lock->old_oid) &&
-	    verify_refname_available_dir(refname, extras, skip,
-					 get_packed_refs(refs),
-					 err)) {
+	    refs_verify_refname_available(&refs->base, refname,
+					  extras, skip, err)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
-- 
2.11.0

