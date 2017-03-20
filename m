Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F9D82095B
	for <e@80x24.org>; Mon, 20 Mar 2017 16:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755600AbdCTQeH (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:34:07 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48517 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755583AbdCTQeF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:34:05 -0400
X-AuditID: 1207440d-029ff70000003721-76-58d00476dc25
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 06.2E.14113.67400D85; Mon, 20 Mar 2017 12:33:59 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9O010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:33:57 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/20] do_for_each_entry_in_dir(): eliminate `offset` argument
Date:   Mon, 20 Mar 2017 17:33:19 +0100
Message-Id: <469369dee7c1907efc4cd35c5ecb579be4eeb46c.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsUixO6iqFvOciHCYM0nFouuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHl3tR9g8nvXuYfS4eEnZ4/MmuQC2
        KC6blNSczLLUIn27BK6MrgdNjAUTJCq+rDrJ2sD4RLiLkZNDQsBE4u6faUxdjFwcQgI7mCQ+
        L33KCuGcYpL4fe4gE0gVm4CuxKKeZjBbREBNYmLbIRaQImaBR4wSV+ffZQdJCAv4SZx/fokN
        xGYRUJXoeNMGFucViJKYsP00E8Q6eYldbRdZQWxOAQuJL/cbWUBsIQFzic4FvewTGHkWMDKs
        YpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10svNLNFLTSndxAgJKN4djP/XyRxiFOBgVOLhXXHl
        fIQQa2JZcWXuIUZJDiYlUd6nt4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHirXgLleFMSK6tS
        i/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvKJMFyKEBItS01Mr0jJzShDSTByc
        IMN5gIbXgdTwFhck5hZnpkPkTzEqSonzfv8PtFUAJJFRmgfXC4v4V4ziQK8I8+b9BqriASYL
        uO5XQIOZgAYvu3EGZHBJIkJKqoGR44t+TOq0dUuMuIxY6owebl9e7HZ2Sly+i0jM+50nVrFc
        CJUXvtKa0Njh94NX5YJ80sRdS7037TzS/mqK92TNMkeXiYHdn553TtfYneRtfi0rIWGzKPc2
        nca8iMIPnLeFJy3Xnnd77YoSB9XsrEKnuSbL3p7w4U8J/NDvLCRieMLE/wL7iXwlluKMREMt
        5qLiRADu7AFb0wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was never used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c |  4 ++--
 refs/ref-cache.c     |  6 +++---
 refs/ref-cache.h     | 11 +++++------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7b5f5c1240..0ff5df6b46 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1390,7 +1390,7 @@ static int commit_packed_refs(struct files_ref_store *refs)
 
 	fprintf_or_die(out, "%s", PACKED_REFS_HEADER);
 	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
-				 0, write_packed_entry_fn, out);
+				 write_packed_entry_fn, out);
 
 	if (commit_lock_file(packed_ref_cache->lock)) {
 		save_errno = errno;
@@ -1584,7 +1584,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	lock_packed_refs(refs, LOCK_DIE_ON_ERROR);
 	cbdata.packed_refs = get_packed_refs(refs);
 
-	do_for_each_entry_in_dir(get_loose_refs(refs), 0,
+	do_for_each_entry_in_dir(get_loose_refs(refs),
 				 pack_if_possible_fn, &cbdata);
 
 	if (commit_packed_refs(refs))
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 44440e0c13..38d4c31985 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -307,18 +307,18 @@ static void sort_ref_dir(struct ref_dir *dir)
 	dir->sorted = dir->nr = i;
 }
 
-int do_for_each_entry_in_dir(struct ref_dir *dir, int offset,
+int do_for_each_entry_in_dir(struct ref_dir *dir,
 			     each_ref_entry_fn fn, void *cb_data)
 {
 	int i;
 	assert(dir->sorted == dir->nr);
-	for (i = offset; i < dir->nr; i++) {
+	for (i = 0; i < dir->nr; i++) {
 		struct ref_entry *entry = dir->entries[i];
 		int retval;
 		if (entry->flag & REF_DIR) {
 			struct ref_dir *subdir = get_ref_dir(entry);
 			sort_ref_dir(subdir);
-			retval = do_for_each_entry_in_dir(subdir, 0, fn, cb_data);
+			retval = do_for_each_entry_in_dir(subdir, fn, cb_data);
 		} else {
 			retval = fn(entry, cb_data);
 		}
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index ed51e80d88..6eecdf4276 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -258,13 +258,12 @@ struct ref_iterator *cache_ref_iterator_begin(struct ref_dir *dir);
 typedef int each_ref_entry_fn(struct ref_entry *entry, void *cb_data);
 
 /*
- * Call fn for each reference in dir that has index in the range
- * offset <= index < dir->nr.  Recurse into subdirectories that are in
- * that index range, sorting them before iterating.  This function
- * does not sort dir itself; it should be sorted beforehand.  fn is
- * called for all references, including broken ones.
+ * Call `fn` for each reference in `dir`. Recurse into subdirectories,
+ * sorting them before iterating. This function does not sort `dir`
+ * itself; it should be sorted beforehand. `fn` is called for all
+ * references, including broken ones.
  */
-int do_for_each_entry_in_dir(struct ref_dir *dir, int offset,
+int do_for_each_entry_in_dir(struct ref_dir *dir,
 			     each_ref_entry_fn fn, void *cb_data);
 
 /*
-- 
2.11.0

