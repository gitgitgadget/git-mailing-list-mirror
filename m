Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E29020958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755630AbdCTQeT (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:34:19 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52957 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755632AbdCTQeL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:34:11 -0400
X-AuditID: 12074412-4a3ff70000000b04-28-58d00480559e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 1C.CA.02820.08400D85; Mon, 20 Mar 2017 12:34:08 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9U010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:34:07 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 20/20] do_for_each_entry_in_dir(): delete function
Date:   Mon, 20 Mar 2017 17:33:25 +0100
Message-Id: <3af807ae6f18cb0fb93bb96148bbed84a96ac7ab.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsUixO6iqNvAciHC4ON9G4uuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHl3tR9g8nvXuYfS4eEnZ4/MmuQC2
        KC6blNSczLLUIn27BK6MhvOhBVv5K2bens/awDiPp4uRk0NCwETiycIL7CC2kMAOJolJd9i6
        GLmA7FNMEvsnLWIGSbAJ6Eos6mlmArFFBNQkJrYdYgEpYhZ4xChxdf5dsG5hASeJrpYlrCA2
        i4CqxKr378EaeAWiJE5+nsUMsU1eYlfbRbAaTgELiS/3G1kgNptLdC7oZZ/AyLOAkWEVo1xi
        Tmmubm5iZk5xarJucXJiXl5qka6ZXm5miV5qSukmRkgwCe1gXH9S7hCjAAejEg/viivnI4RY
        E8uKK3MPMUpyMCmJ8j69DRTiS8pPqcxILM6ILyrNSS0+xCjBwawkwlv1EijHm5JYWZValA+T
        kuZgURLn/blY3U9IID2xJDU7NbUgtQgmK8PBoSTByw6MGiHBotT01Iq0zJwShDQTByfIcB6g
        4QogNbzFBYm5xZnpEPlTjIpS4rznmIASAiCJjNI8uF5YtL9iFAd6RZj3K0gVDzBRwHW/AhrM
        BDR42Y0zIINLEhFSUg2MfgcPu8/YVRAcX1w9cwaHpkS5r+jBrSelrS5vOvqvQTOT5UjfPONf
        fHX/KxdPW9j6IULBzXFNC9exPeZ/LTyYNNYYLxU5trs948vfwzUlR789kvquqSSqrBO63kvG
        Rj/uwpTSHrkrlfYbbJdcZFb3MAibvmTHqWa7F0rcaya+eyOw9vMrbrZ8JZbijERDLeai4kQA
        YJjoM9ECAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Its only remaining caller was itself.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/ref-cache.c | 21 ---------------------
 refs/ref-cache.h | 11 -----------
 2 files changed, 32 deletions(-)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index b3a30350d7..6059362f1d 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -316,27 +316,6 @@ static void sort_ref_dir(struct ref_dir *dir)
 	dir->sorted = dir->nr = i;
 }
 
-int do_for_each_entry_in_dir(struct ref_dir *dir,
-			     each_ref_entry_fn fn, void *cb_data)
-{
-	int i;
-	assert(dir->sorted == dir->nr);
-	for (i = 0; i < dir->nr; i++) {
-		struct ref_entry *entry = dir->entries[i];
-		int retval;
-		if (entry->flag & REF_DIR) {
-			struct ref_dir *subdir = get_ref_dir(entry);
-			sort_ref_dir(subdir);
-			retval = do_for_each_entry_in_dir(subdir, fn, cb_data);
-		} else {
-			retval = fn(entry, cb_data);
-		}
-		if (retval)
-			return retval;
-	}
-	return 0;
-}
-
 /*
  * Load all of the refs from `dir` (recursively) into our in-memory
  * cache.
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 5e7a918ac0..ffdc54f3f0 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -251,17 +251,6 @@ struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
 					      const char *prefix,
 					      int prime_dir);
 
-typedef int each_ref_entry_fn(struct ref_entry *entry, void *cb_data);
-
-/*
- * Call `fn` for each reference in `dir`. Recurse into subdirectories,
- * sorting them before iterating. This function does not sort `dir`
- * itself; it should be sorted beforehand. `fn` is called for all
- * references, including broken ones.
- */
-int do_for_each_entry_in_dir(struct ref_dir *dir,
-			     each_ref_entry_fn fn, void *cb_data);
-
 /*
  * Peel the entry (if possible) and return its new peel_status.  If
  * repeel is true, re-peel the entry even if there is an old peeled
-- 
2.11.0

