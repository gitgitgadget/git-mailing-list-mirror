Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFF2E1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754475AbcIDQMO (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:12:14 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56049 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754333AbcIDQLu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:11:50 -0400
X-AuditID: 1207440e-dc3ff70000000931-34-57cc474872ac
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 9B.0B.02353.8474CC75; Sun,  4 Sep 2016 12:09:44 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5n026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:42 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 27/38] lock_ref_for_update(): add a files_ref_store argument
Date:   Sun,  4 Sep 2016 18:08:33 +0200
Message-Id: <4083413a38a52f9f8db6b9fb009dd522ad75a8df.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqOvhfibcYP9NLouuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8fnTXIBHFFcNimpOZllqUX6dglcGb/mzGMruM9bsfLlMaYGxnbuLkZO
        DgkBE4kF51+wdDFycQgJbGWUWLepgR3COckk0fL3NgtIFZuArsSinmYmEFtEQE1iYtshsA5m
        kKJZE2cCdXBwCAv4SyyfLQdisgioSvx7yAhSzisQJfFs7S5GiGVyEpe2fWEGsTkFLCTO7J7L
        DFIuJGAu0f4iewIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFusZ6uZkleqkppZsYIeHG
        t4Oxfb3MIUYBDkYlHl4L7TPhQqyJZcWVuYcYJTmYlER5Zx08GS7El5SfUpmRWJwRX1Sak1p8
        iFGCg1lJhFfbBaicNyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBG+UG
        1ChYlJqeWpGWmVOCkGbi4AQZzgM0PBSkhre4IDG3ODMdIn+KUVFKnPelK1BCACSRUZoH1wtL
        B68YxYFeEeZNAGnnAaYSuO5XQIOZgAav230aZHBJIkJKqoHRSWLf6sLIg1Zvw8535vyZz7Va
        LNDsopa230mrF6sYlu2dE7vquOvX07qZHL+er3RL1ZVWVtokIvnD6MF/z0OWPnV9f5I7Nr4S
        9oy/1f5jRkXZY9mNIarbNuxl+fpG/pyStNeKHjfZ9VujSoo2V7vVP/rQ9XSmrVsYh9zfVUeP
        s+yKvMvxR6lGiaU4I9FQi7moOBEAzN7XnOICAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 001b8ef..2f8eb54 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3514,20 +3514,21 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
  * - If it is an update of head_ref, add a corresponding REF_LOG_ONLY
  *   update of HEAD.
  */
-static int lock_ref_for_update(struct ref_update *update,
+static int lock_ref_for_update(struct files_ref_store *refs,
+			       struct ref_update *update,
 			       struct ref_transaction *transaction,
 			       const char *head_ref,
 			       struct string_list *affected_refnames,
 			       struct strbuf *err)
 {
-	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "lock_ref_for_update");
 	struct strbuf referent = STRBUF_INIT;
 	int mustexist = (update->flags & REF_HAVE_OLD) &&
 		!is_null_sha1(update->old_sha1);
 	int ret;
 	struct ref_lock *lock;
 
+	assert_main_repository(&refs->base, "lock_ref_for_update");
+
 	if ((update->flags & REF_HAVE_NEW) && is_null_sha1(update->new_sha1))
 		update->flags |= REF_DELETING;
 
@@ -3730,8 +3731,8 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
-		ret = lock_ref_for_update(update, transaction, head_ref,
-					  &affected_refnames, err);
+		ret = lock_ref_for_update(refs, update, transaction,
+					  head_ref, &affected_refnames, err);
 		if (ret)
 			goto cleanup;
 	}
-- 
2.9.3

