Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D5C71F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754496AbcIDQMV (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:12:21 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55308 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754326AbcIDQLu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:11:50 -0400
X-AuditID: 12074414-c8fff70000000931-42-57cc4749a547
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id F8.9A.02353.9474CC75; Sun,  4 Sep 2016 12:09:45 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5o026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:44 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 28/38] lock_ref_sha1_basic(): add a files_ref_store argument
Date:   Sun,  4 Sep 2016 18:08:34 +0200
Message-Id: <d32ff64a4c27afe0e238cdef82dc1e1268f63057.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqOvlfibcYLWeRdeVbiaLht4rzBa3
        V8xntljy8DWzRfeUt4wWP1p6mC1mXrW2OPOmkdGBw+Pv+w9MHjtn3WX36Go/wubxrHcPo8fF
        S8oe+5duY/NY/MDL4/MmuQCOKC6blNSczLLUIn27BK6MPS/uMRc0yFY8WraVtYFxgngXIyeH
        hICJxOntExi7GLk4hAS2Mkq0X7jEBuGcZJI41n+fFaSKTUBXYlFPMxOILSKgJjGx7RALSBEz
        SNGsiTPZQRLCAv4Sy04cZgOxWQRUJTY3rAdr5hWIkvh/5x47xDo5iUvbvjCD2JwCFhJnds8F
        sjmAtplLtL/InsDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRroVebmaJXmpK6SZGSMCJ
        7GA8clLuEKMAB6MSD6+F9plwIdbEsuLK3EOMkhxMSqK8sw6eDBfiS8pPqcxILM6ILyrNSS0+
        xCjBwawkwqvtAlTOm5JYWZValA+TkuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PBoSTBe90V
        qFGwKDU9tSItM6cEIc3EwQkynAdo+E2QGt7igsTc4sx0iPwpRkUpcd6XIAkBkERGaR5cLywh
        vGIUB3pFmDfBDaiKB5hM4LpfAQ1mAhq8bvdpkMEliQgpqQZG7yRb8+aFzOf3xRx7p3/ILITj
        nnzksdC3jmlrzq/aYlJ2eZKY3RRptacdtysWL9lxwVJTwv1onn5NzM6mTflHLSr361jX6a9x
        Wqf6/PXlVSx2khYWhyKmLrm43iVfkolJ6pzBNhXz4xu0yg7/1z+e8NlXxEXeefK7fou+O5uV
        DN7XybHtWPFViaU4I9FQi7moOBEAZ1IZ8uMCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2f8eb54..ab2c1de 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1983,15 +1983,14 @@ static int remove_empty_directories(struct strbuf *path)
  * Locks a ref returning the lock on success and NULL on failure.
  * On failure errno is set to something meaningful.
  */
-static struct ref_lock *lock_ref_sha1_basic(const char *refname,
+static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
+					    const char *refname,
 					    const unsigned char *old_sha1,
 					    const struct string_list *extras,
 					    const struct string_list *skip,
 					    unsigned int flags, int *type,
 					    struct strbuf *err)
 {
-	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "lock_ref_sha1_basic");
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
 	int last_errno = 0;
@@ -2001,6 +2000,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int attempts_remaining = 3;
 	int resolved;
 
+	assert_main_repository(&refs->base, "lock_ref_sha1_basic");
 	assert(err);
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
@@ -2644,8 +2644,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, REF_NODEREF,
-				   NULL, &err);
+	lock = lock_ref_sha1_basic(refs, newrefname, NULL, NULL, NULL,
+				   REF_NODEREF, NULL, &err);
 	if (!lock) {
 		error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
 		strbuf_release(&err);
@@ -2663,8 +2663,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, REF_NODEREF,
-				   NULL, &err);
+	lock = lock_ref_sha1_basic(refs, oldrefname, NULL, NULL, NULL,
+				   REF_NODEREF, NULL, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -3020,13 +3020,14 @@ static int files_create_symref(struct ref_store *ref_store,
 			       const char *refname, const char *target,
 			       const char *logmsg)
 {
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "create_symref");
 	struct strbuf err = STRBUF_INIT;
 	struct ref_lock *lock;
 	int ret;
 
-	files_downcast(ref_store, 0, "create_symref");
-
-	lock = lock_ref_sha1_basic(refname, NULL, NULL, NULL, REF_NODEREF, NULL,
+	lock = lock_ref_sha1_basic(refs, refname, NULL,
+				   NULL, NULL, REF_NODEREF, NULL,
 				   &err);
 	if (!lock) {
 		error("%s", err.buf);
@@ -3939,6 +3940,8 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		 reflog_expiry_cleanup_fn cleanup_fn,
 		 void *policy_cb_data)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "reflog_expire");
 	static struct lock_file reflog_lock;
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
@@ -3957,7 +3960,8 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, REF_NODEREF,
+	lock = lock_ref_sha1_basic(refs, refname, sha1,
+				   NULL, NULL, REF_NODEREF,
 				   &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
-- 
2.9.3

