Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A0C120401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbdFOOsO (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:48:14 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51694 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752628AbdFOOsN (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:48:13 -0400
X-AuditID: 1207440f-33bff7000000102d-93-59429e2cdb3a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 1D.F5.04141.C2E92495; Thu, 15 Jun 2017 10:48:12 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbR8014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:48:10 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/28] repack_without_refs(): take a `packed_ref_store *` parameter
Date:   Thu, 15 Jun 2017 16:47:19 +0200
Message-Id: <ce5f2c68da927408a49a76c51b18d3378958ea76.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqKszzynSoPOskMXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8XtFfOZLZY8fM1s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8Fm0o9
        utqPsHk8693D6HHxkrLH501yAexRXDYpqTmZZalF+nYJXBlL3jxnLlgvXnHjyH6mBsapwl2M
        nBwSAiYSa69/Y+ti5OIQEtjBJHFj8kImCOckk0TjnN+MIFVsAroSi3qamUBsEQE1iYlth1hA
        ipgFJjFLvL22ECwhLBAssfz3ZWYQm0VAVWLKmVNANgcHr0CUxPvGWIht8hK72i6ygticAhYS
        s7+sAysREjCXOLZcYwIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuiZ6uZkleqkppZsY
        ISHHv4Oxa73MIUYBDkYlHl6FBqdIIdbEsuLK3EOMkhxMSqK8/HJAIb6k/JTKjMTijPii0pzU
        4kOMEhzMSiK8U+cA5XhTEiurUovyYVLSHCxK4rzqS9T9hATSE0tSs1NTC1KLYLIyHBxKErzb
        QBoFi1LTUyvSMnNKENJMHJwgw3mAhs+eDjK8uCAxtzgzHSJ/ilFRSpzXA6RZACSRUZoH1wtL
        Ca8YxYFeEeb9AlLFA0wncN2vgAYzAQ0OuuAAMrgkESEl1cDIqzDh3/trr6RvWfn5Nphc2ZOt
        0fwm+nnzE6b3C9a6B/yYpjql+4TYo7UmexfoPHG/fNpijRhT+JFFr6tVA0pvcJ3QWPinTFdD
        efnmT9pyZ3uYGXex3ReUW/dV+sfNCQusuX8uyLz7bLlfeYq2cW/S4y1zOWoDamOeLni59M+N
        xBfXwnXTvv+VVWIpzkg01GIuKk4EAJRY76/kAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2b9d93d3b6..c206791b91 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1621,19 +1621,19 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
  *
  * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
  */
-static int repack_without_refs(struct files_ref_store *refs,
+static int repack_without_refs(struct packed_ref_store *refs,
 			       struct string_list *refnames, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list_item *refname;
 	int ret, needs_repacking = 0, removed = 0;
 
-	files_assert_main_repository(refs, "repack_without_refs");
+	packed_assert_main_repository(refs, "repack_without_refs");
 	assert(err);
 
 	/* Look for a packed ref */
 	for_each_string_list_item(refname, refnames) {
-		if (get_packed_ref(refs->packed_ref_store, refname->string)) {
+		if (get_packed_ref(refs, refname->string)) {
 			needs_repacking = 1;
 			break;
 		}
@@ -1643,11 +1643,11 @@ static int repack_without_refs(struct files_ref_store *refs,
 	if (!needs_repacking)
 		return 0; /* no refname exists in packed refs */
 
-	if (lock_packed_refs(refs->packed_ref_store, 0)) {
-		unable_to_lock_message(refs->packed_ref_store->path, errno, err);
+	if (lock_packed_refs(refs, 0)) {
+		unable_to_lock_message(refs->path, errno, err);
 		return -1;
 	}
-	packed = get_packed_refs(refs->packed_ref_store);
+	packed = get_packed_refs(refs);
 
 	/* Remove refnames from the cache */
 	for_each_string_list_item(refname, refnames)
@@ -1658,12 +1658,12 @@ static int repack_without_refs(struct files_ref_store *refs,
 		 * All packed entries disappeared while we were
 		 * acquiring the lock.
 		 */
-		rollback_packed_refs(refs->packed_ref_store);
+		rollback_packed_refs(refs);
 		return 0;
 	}
 
 	/* Write what remains */
-	ret = commit_packed_refs(refs->packed_ref_store);
+	ret = commit_packed_refs(refs);
 	if (ret)
 		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
 			    strerror(errno));
@@ -1681,7 +1681,7 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 	if (!refnames->nr)
 		return 0;
 
-	result = repack_without_refs(refs, refnames, &err);
+	result = repack_without_refs(refs->packed_ref_store, refnames, &err);
 	if (result) {
 		/*
 		 * If we failed to rewrite the packed-refs file, then
@@ -3101,7 +3101,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		}
 	}
 
-	if (repack_without_refs(refs, &refs_to_delete, err)) {
+	if (repack_without_refs(refs->packed_ref_store, &refs_to_delete, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
-- 
2.11.0

