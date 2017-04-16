Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B43720A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755472AbdDPGnK (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:43:10 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:50274 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755523AbdDPGnH (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:43:07 -0400
X-AuditID: 1207440f-129ff70000003517-b1-58f3127a1314
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.A8.13591.A7213F85; Sun, 16 Apr 2017 02:43:06 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGNL025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:43:04 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 20/20] do_for_each_entry_in_dir(): delete function
Date:   Sun, 16 Apr 2017 08:41:42 +0200
Message-Id: <048f377ab2b755a1360f937120a698d5603349b3.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsUixO6iqFsl9DnCYO4KLYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAldGw/nQgq38FTNvz2dtYJzH08XIySEhYCJx
        rvUDSxcjF4eQwA4miXmXd0E5J5gkluzZyQ5SxSagK7Gop5kJxBYRUJOY2HYIrIhZ4DGTxN9l
        3UAOB4ewgKvE98nGIDUsAqoSbx7+YgGxeQWiJBZd28UIsU1eYlfbRVYQm1PAQmLK3Q1gNUIC
        5hLbj19lnsDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrolebmaJXmpK6SZGSKDx72Ds
        Wi9ziFGAg1GJh9fC/1OEEGtiWXFl7iFGSQ4mJVFemf9AIb6k/JTKjMTijPii0pzU4kOMEhzM
        SiK8ySyfI4R4UxIrq1KL8mFS0hwsSuK86kvU/YQE0hNLUrNTUwtSi2CyMhwcShK80YJAjYJF
        qempFWmZOSUIaSYOTpDhPEDDtwqADC8uSMwtzkyHyJ9iVJQS5/0BkhAASWSU5sH1whLBK0Zx
        oFeEeWtBVvAAkwhc9yugwUxAgxkmfwAZXJKIkJJqYKxy2P//SvyugNpSucP+Zr/8toTKiaUm
        cN7apvvHtb9l4f8Vb14eqdq2TG53Q3vwZy49D2tt5bUnNzmURemfefrTVluh+qqgjFCwsblk
        3ZSwoDsmlkvcVix89nyf+/fFLz+93f7MyYVF9ZQI06TyJjmWm8eXThFyucucy7ft4AXZOrFj
        3+xW8iuxFGckGmoxFxUnAgDUFeQ43wIAAA==
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

