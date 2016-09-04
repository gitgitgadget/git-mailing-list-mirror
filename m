Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81C911F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754604AbcIDQNW (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:13:22 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56096 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754522AbcIDQNC (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:13:02 -0400
X-AuditID: 1207440e-dc3ff70000000931-21-57cc473b0a9c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 0A.0B.02353.B374CC75; Sun,  4 Sep 2016 12:09:31 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5g026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:29 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 20/38] refs: make verify_refname_available() virtual
Date:   Sun,  4 Sep 2016 18:08:26 +0200
Message-Id: <016e25dc60b86d4b2312963a913ecd512e2e75b9.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqGvtfibcoPu6oEXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l9+hqP8Lm8ax3D6PH
        xUvKHvuXbmPzWPzAy+PzJrkAjigum5TUnMyy1CJ9uwSujAWznjIWdIpVbDqq2MD4Q7CLkZND
        QsBEonnBXtYuRi4OIYGtjBJnl01mg3BOMklMP3iUBaSKTUBXYlFPMxOILSKgJjGx7RALSBEz
        SNGsiTPZQRLCAu4SW368ABrFwcEioCpxY48FSJhXIEri1MnD7BDb5CQubfvCDGJzClhInNk9
        lxmkXEjAXKL9RfYERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9XIzS/RSU0o3MULC
        jW8HY/t6mUOMAhyMSjy8FtpnwoVYE8uKK3MPMUpyMCmJ8s46eDJciC8pP6UyI7E4I76oNCe1
        +BCjBAezkgivtgtQOW9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgve6
        K1CjYFFqempFWmZOCUKaiYMTZDgP0PCbIDW8xQWJucWZ6RD5U4yKUuK8L0ESAiCJjNI8uF5Y
        OnjFKA70ijCvohtQFQ8wlcB1vwIazAQ0eN3u0yCDSxIRUlINjHFns5iusC74PWHnsSreYwlX
        AidwnexfI78rPHtSeEuvscmMjZvlmTamJ24JFVkQaXdVwFWQ4cTkpTzL5L9yr752+FNhu+Ml
        +/nTDwroz9wc/P3drbMh2ll/jZx+PH61/crNS1nTzN7MbF4V8Omst2rjuVzHtr83l7ha6F6Z
        +0nbZHH4kW97Np5VYinOSDTUYi4qTgQA2cYdreICAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 10 ++++++++++
 refs/files-backend.c | 14 ++++++++------
 refs/refs-internal.h |  7 +++++++
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 7a7adeb..662c417 100644
--- a/refs.c
+++ b/refs.c
@@ -1428,3 +1428,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	return refs->be->transaction_commit(refs, transaction, err);
 }
+
+int verify_refname_available(const char *refname,
+			     const struct string_list *extra,
+			     const struct string_list *skip,
+			     struct strbuf *err)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->verify_refname_available(refs, refname, extra, skip, err);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index ff11a51..4e1d431 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2549,13 +2549,14 @@ static int rename_tmp_log(const char *newrefname)
 	return ret;
 }
 
-int verify_refname_available(const char *newname,
-			     const struct string_list *extras,
-			     const struct string_list *skip,
-			     struct strbuf *err)
+static int files_verify_refname_available(struct ref_store *ref_store,
+					  const char *newname,
+					  const struct string_list *extras,
+					  const struct string_list *skip,
+					  struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "verify_refname_available");
+		files_downcast(ref_store, 1, "verify_refname_available");
 	struct ref_dir *packed_refs = get_packed_refs(refs);
 	struct ref_dir *loose_refs = get_loose_refs(refs);
 
@@ -4031,5 +4032,6 @@ struct ref_storage_be refs_be_files = {
 	files_ref_store_create,
 	files_transaction_commit,
 
-	files_read_raw_ref
+	files_read_raw_ref,
+	files_verify_refname_available
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 19cb6e1..6c698f4 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -542,6 +542,12 @@ typedef int read_raw_ref_fn(struct ref_store *ref_store,
 			    const char *refname, unsigned char *sha1,
 			    struct strbuf *referent, unsigned int *type);
 
+typedef int verify_refname_available_fn(struct ref_store *ref_store,
+					const char *newname,
+					const struct string_list *extras,
+					const struct string_list *skip,
+					struct strbuf *err);
+
 struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
@@ -549,6 +555,7 @@ struct ref_storage_be {
 	ref_transaction_commit_fn *transaction_commit;
 
 	read_raw_ref_fn *read_raw_ref;
+	verify_refname_available_fn *verify_refname_available;
 };
 
 extern struct ref_storage_be refs_be_files;
-- 
2.9.3

