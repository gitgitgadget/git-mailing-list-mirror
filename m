Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A60F207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbdEBWYK (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:24:10 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33632 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbdEBWXj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:39 -0400
Received: by mail-pg0-f41.google.com with SMTP id y4so62826873pge.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dYmuPJfBI1MvQ6WnEyZAtMxKgnmlX0XC5xdtdy39oiU=;
        b=AVsEDs2pqn5kflGbc9utmCaeKL3hBH8bT3XlOrGX3b5MJm8uz8ulTX6U/GD71kvUoR
         0hPpjYIE0Dgs4pO7G7w9D8ePsIJRb1mXLXgEmkSBQcCNYDINmIgNYxu9nAWsMuthrSIw
         V5o36Ea4qGuEPa4i8u4CWe9euRbn4PSupPY4zwPNmRTSZdMBaIVfct+fL37g2btf0LEn
         3XgB0oOz7FgTx/hkgIQDL0X3pSZvj7h9dXH7lW+PGTgR5hoxJVYnslDoN1T7V1rfK2Cc
         Q2MLWe8fiKD6lwrSu34VdVvSGd9tPA93hfwyWpiaY/7rjZ+sPee99G9iEFeMPyZWNf0l
         ooLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dYmuPJfBI1MvQ6WnEyZAtMxKgnmlX0XC5xdtdy39oiU=;
        b=LFziFDWtmhaeAvj0jKJeNyT55lPllxIuxSA4KzEEm9+VfN+QMa3+LrmoDEAVooAJuw
         35zCdZ7qjqfBJBHxyEL3qNd44wp5X+ESUwphI4I8LKZLly2rl5xkSntrEv0FH+s/PzRn
         A+eXoonYv5Vn6d2lzNbijy5tPp6mUI2QQOM3xR6K++QIEWxL67HvQwouYXu/Tfju/egv
         0ScK0KDT5rYEld7m+miYuuFzIIon9TxFc6AlImIAxEl+jGvWAn6uR3niDCrirFhZLdBa
         auTyWJdId8rjqj9omzfwWhWFbqzsnXd2xli5k4fQi9G1lez7FKWyJ3J0esvyOpH7n5Hz
         DFTw==
X-Gm-Message-State: AN3rC/6Wom6pxn+SkQ76xE/0/sJW7AaeiihfjACHUdrGlASIkgLr+2Vc
        VkTdT1aucRRZzZJS
X-Received: by 10.84.253.15 with SMTP id z15mr29036515pll.186.1493763818843;
        Tue, 02 May 2017 15:23:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id y6sm45061299pgc.40.2017.05.02.15.23.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:38 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/24] cache.h: drop unmerge_cache[_entry_at]
Date:   Tue,  2 May 2017 15:23:06 -0700
Message-Id: <20170502222322.21055-9-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/update-index.c | 2 +-
 cache.h                | 2 --
 rerere.c               | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 8667c48446..b8458016f0 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -613,7 +613,7 @@ static int unresolve_one(const char *path)
 	pos = cache_name_pos(path, namelen);
 	if (0 <= pos) {
 		/* already merged */
-		pos = unmerge_cache_entry_at(pos);
+		pos = unmerge_index_entry_at(&the_index, pos);
 		if (pos < the_index.cache_nr) {
 			const struct cache_entry *ce = the_index.cache[pos];
 			if (ce_stage(ce) &&
diff --git a/cache.h b/cache.h
index d078e88c3f..8a2dc393dc 100644
--- a/cache.h
+++ b/cache.h
@@ -372,8 +372,6 @@ extern void free_name_hash(struct index_state *istate);
 #define cache_file_exists(name, namelen, igncase) index_file_exists(&the_index, (name), (namelen), (igncase))
 #define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
 #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
-#define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
-#define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
 #endif
 
 enum object_type {
diff --git a/rerere.c b/rerere.c
index b9b39a959e..03218166ab 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1116,7 +1116,7 @@ int rerere_forget(struct pathspec *pathspec)
 	 * recover the original conflicted state and then
 	 * find the conflicted paths.
 	 */
-	unmerge_cache(pathspec);
+	unmerge_index(&the_index, pathspec);
 	find_conflict(&conflict);
 	for (i = 0; i < conflict.nr; i++) {
 		struct string_list_item *it = &conflict.items[i];
-- 
2.13.0.rc1.39.ga6db8bfa24

