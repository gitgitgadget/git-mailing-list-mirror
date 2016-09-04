Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0537020193
	for <e@80x24.org>; Sun,  4 Sep 2016 16:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754468AbcIDQML (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:12:11 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61504 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754332AbcIDQLu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:11:50 -0400
X-AuditID: 12074413-aa3ff70000000955-92-57cc473ea668
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 29.21.02389.E374CC75; Sun,  4 Sep 2016 12:09:34 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5i026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:33 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 22/38] refs: make create_symref() virtual
Date:   Sun,  4 Sep 2016 18:08:28 +0200
Message-Id: <b7399efde555f056c736bcc1c07a685290bc796e.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqGvnfibcYH63qUXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l9+hqP8Lm8ax3D6PH
        xUvKHvuXbmPzWPzAy+PzJrkAjigum5TUnMyy1CJ9uwSujM2v+1kK9ohUTGvZxtrAeEygi5GD
        Q0LAROLCrpAuRk4OIYGtjBIznmZ3MXIB2SeZJOYsbmIFSbAJ6Eos6mlmArFFBNQkJrYdYgEp
        YgYpmjVxJjtIQljARmLbrHVsIDaLgKrEgUt9LCA2r0CUxK8nS8FqJATkJC5t+8IMYnMKWEic
        2T2XGeQIIQFzifYX2RMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXXy80s0UtNKd3E
        CAk34R2Mu07KHWIU4GBU4uGdoHsmXIg1say4MvcQoyQHk5Io76yDJ8OF+JLyUyozEosz4otK
        c1KLDzFKcDArifBquwCV86YkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQk
        eK+7AjUKFqWmp1akZeaUIKSZODhBhvMADb8JUsNbXJCYW5yZDpE/xagoJc77EiQhAJLIKM2D
        64Wlg1eM4kCvCPMmuAFV8QBTCVz3K6DBTECD1+0+DTK4JBEhJdXAGFjsZmR6q9gpZHri0ket
        eUlmlgFBOkeW1r5yf3agP5zNQn0el6fT7aIZS98x+qnMN2PqTHrLsKz/T1DqX4VbOx4u1d+V
        JC1Y+/z6yeDVuyw2HOtIW31+W//yzY+KtTMPqPvxvVp+94bZdPMTtVG55Z4LdB8ac64/M6na
        Q25O0LXWYx0mfpYJSizFGYmGWsxFxYkAe4LGv+ICAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 9 +++++++++
 refs/files-backend.c | 7 ++++++-
 refs/refs-internal.h | 5 +++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 961927a..74874e5 100644
--- a/refs.c
+++ b/refs.c
@@ -1428,6 +1428,15 @@ int pack_refs(unsigned int flags)
 	return refs->be->pack_refs(refs, flags);
 }
 
+int create_symref(const char *ref_target, const char *refs_heads_master,
+		  const char *logmsg)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->create_symref(refs, ref_target, refs_heads_master,
+				       logmsg);
+}
+
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7ad8821..bf53670 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3011,12 +3011,16 @@ static int create_symref_locked(struct ref_lock *lock, const char *refname,
 	return 0;
 }
 
-int create_symref(const char *refname, const char *target, const char *logmsg)
+static int files_create_symref(struct ref_store *ref_store,
+			       const char *refname, const char *target,
+			       const char *logmsg)
 {
 	struct strbuf err = STRBUF_INIT;
 	struct ref_lock *lock;
 	int ret;
 
+	files_downcast(ref_store, 0, "create_symref");
+
 	lock = lock_ref_sha1_basic(refname, NULL, NULL, NULL, REF_NODEREF, NULL,
 				   &err);
 	if (!lock) {
@@ -4033,6 +4037,7 @@ struct ref_storage_be refs_be_files = {
 	files_transaction_commit,
 
 	files_pack_refs,
+	files_create_symref,
 
 	files_read_raw_ref,
 	files_verify_refname_available
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 256f7f5..bf96503 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -501,6 +501,10 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct strbuf *err);
 
 typedef int pack_refs_fn(struct ref_store *ref_store, unsigned int flags);
+typedef int create_symref_fn(struct ref_store *ref_store,
+			     const char *ref_target,
+			     const char *refs_heads_master,
+			     const char *logmsg);
 
 /*
  * Read a reference from the specified reference store, non-recursively.
@@ -557,6 +561,7 @@ struct ref_storage_be {
 	ref_transaction_commit_fn *transaction_commit;
 
 	pack_refs_fn *pack_refs;
+	create_symref_fn *create_symref;
 
 	read_raw_ref_fn *read_raw_ref;
 	verify_refname_available_fn *verify_refname_available;
-- 
2.9.3

