Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E41032096B
	for <e@80x24.org>; Fri, 31 Mar 2017 14:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933315AbdCaOMW (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 10:12:22 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48983 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933261AbdCaOMK (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 10:12:10 -0400
X-AuditID: 1207440d-029ff70000003721-27-58de63b802f8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 3F.20.14113.8B36ED85; Fri, 31 Mar 2017 10:12:08 -0400 (EDT)
Received: from bagpipes.fritz.box (p4FEDFA60.dip0.t-ipconnect.de [79.237.250.96])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2VEBRC1010139
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 31 Mar 2017 10:12:06 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 20/20] do_for_each_entry_in_dir(): delete function
Date:   Fri, 31 Mar 2017 16:11:18 +0200
Message-Id: <6d22bdb112ab62e03701f6181ee05203da82f686.1490966385.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqLsj+V6EweeTYhZrn91hsui60s1k
        0dB7hdni9or5zBZLHr5mtuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHl3tR9g8
        nvXuYfS4eEnZ4/MmuQD2KC6blNSczLLUIn27BK6MhvOhBVv5K2bens/awDiPp4uRk0NCwETi
        yOznjF2MXBxCAjuYJG4/egzlnGSS+D3rKCtIFZuArsSinmYmEFtEQE1iYtshFpAiZoE3TBIH
        tvxiAUkIC7hKTL9+BqyBRUBVYu6RLnYQm1cgSuLDj51MEOvkJXa1XQSr4RSwkFg38xBYjZCA
        ucSCtRPYJjDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6SXm1mil5pSuokREmq8Oxj/
        r5M5xCjAwajEw3vC+16EEGtiWXFl7iFGSQ4mJVFe33CgEF9SfkplRmJxRnxRaU5q8SFGCQ5m
        JRFepjigHG9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgrciCahRsCg1
        PbUiLTOnBCHNxMEJMpwHaHgKSA1vcUFibnFmOkT+FKOilDgvK0hCACSRUZoH1wtLBa8YxYFe
        Eeb1AqniAaYRuO5XQIOZgAZbfL0LMrgkESEl1cCYfML7qumX2MsVVbM2nQz/Ga1iJ/5VaKOX
        a1CsjX/YLdXj/wT+z2hoObc6wUnypvgDmdsWUQ9KH88RKH+hzdag4J3yeY7C2sPsW2ujjmw7
        93LH5zam3Nrrdhui54Xvj+193mpTxLs8doPx+8acbWe9Xyxe8NFjsuYlPqv1nR3v9UPr/QXq
        2zOVWIozEg21mIuKEwFmfHjj4AIAAA==
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

