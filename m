Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1174C1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752251AbeA2Wih (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:38:37 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:41310 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeA2Wif (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:35 -0500
Received: by mail-yw0-f202.google.com with SMTP id n200so6405649ywn.8
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=5ZGWCzDFYLs77Zz4sf1l1B08fXmm3HFSYwi2BCrjapM=;
        b=SlX0QLhumBFfMDWCQWDaDmjCg4DSPkdV3EobbtnkFT6qiPpKOOFL6EzN7E8XggEIXg
         s7cIO+4CsP6aS/SIjJftUtHy3LuHjOZGivT5Emml8hzfPUXzyxNUQQOSL6b09niXlBT5
         UyCjtCz19UQLoqyjEwcJPWAemhcnmahlzQvzYIfiueDoKnIkgIphmeQr82wXKPDRcnp0
         ITVwVdqH9wNbdlmt4t/HzgRukwUV1GJX/WsCPU+DGxNDHRQUoUnCZ4Rvbrcu8zkmHz0p
         VjRh19HVtacrigse7tnykTgec3R0gKfWEtCk5+8Wwi9rD+z/EXiHrhiAku9NKGOL5qXK
         LrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=5ZGWCzDFYLs77Zz4sf1l1B08fXmm3HFSYwi2BCrjapM=;
        b=DvooyF+cGvFCY2U+s3frNHyR0ihSPZfhsFLcghdrdQbq7Ghxfx+fcOsVc9+P7bzyI3
         6iltWOB1pAqmOT6k+VRTKfj7EXMYvAHw3+/SuUFKaRb/ZFjru/7PNQegmJ0piPI74cn9
         TSyXP7vlt9n5mX12943IZUNqvBsQZVaFBtQPuEyeYgcZyWQjLrUyuoIFrTfSD39RxS1a
         Wq55qLmyCPpQqbltfdD5OAr63LGHszl1DuLJithsABONOjxW/XHBkWtBjmZ14IhpFoQq
         CoUcKwsFSVFW/iQuWRubv2qTwY0qY3mRbQm1K/0UxDywX5J5M/njiq2Erf4cZPrEppur
         cV4w==
X-Gm-Message-State: AKwxytcL1tw+QpWPE64MeJAS6NLqIKSK0CfQfP6Pwx1uLh82CLdK6Vsd
        h2TcwRY7Gm5k1l3PS2V1r/+0Gy26rEAYPOhkIXhVr1bLychneH8rgUZDaDaZ563SfZLPNmAQ39h
        1TPVKeC7RJWTIieCGJfkus2se/R03ibIfUxvEEOYuU4mbJWuxZOxaRAKQtw==
X-Google-Smtp-Source: AH8x224rqbG2RhqKcNtU46CgAOpfdbVj/crrd5Ezkvz9WOSSEYjHOquYu/mOKVgg9EabP2gCzs4OtGtk6RI=
MIME-Version: 1.0
X-Received: by 10.13.212.147 with SMTP id w141mr11582985ywd.171.1517265514703;
 Mon, 29 Jan 2018 14:38:34 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:14 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-24-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 23/37] read-cache: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 read-cache.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 2eb81a66b..21b859087 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -70,20 +70,20 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
 
 void rename_index_entry_at(struct index_state *istate, int nr, const char *new_name)
 {
-	struct cache_entry *old = istate->cache[nr], *new;
+	struct cache_entry *old = istate->cache[nr], *new_entry;
 	int namelen = strlen(new_name);
 
-	new = xmalloc(cache_entry_size(namelen));
-	copy_cache_entry(new, old);
-	new->ce_flags &= ~CE_HASHED;
-	new->ce_namelen = namelen;
-	new->index = 0;
-	memcpy(new->name, new_name, namelen + 1);
+	new_entry = xmalloc(cache_entry_size(namelen));
+	copy_cache_entry(new_entry, old);
+	new_entry->ce_flags &= ~CE_HASHED;
+	new_entry->ce_namelen = namelen;
+	new_entry->index = 0;
+	memcpy(new_entry->name, new_name, namelen + 1);
 
 	cache_tree_invalidate_path(istate, old->name);
 	untracked_cache_remove_from_index(istate, old->name);
 	remove_index_entry_at(istate, nr);
-	add_index_entry(istate, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+	add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 }
 
 void fill_stat_data(struct stat_data *sd, struct stat *st)
@@ -615,18 +615,18 @@ static struct cache_entry *create_alias_ce(struct index_state *istate,
 					   struct cache_entry *alias)
 {
 	int len;
-	struct cache_entry *new;
+	struct cache_entry *new_entry;
 
 	if (alias->ce_flags & CE_ADDED)
 		die("Will not add file alias '%s' ('%s' already exists in index)", ce->name, alias->name);
 
 	/* Ok, create the new entry using the name of the existing alias */
 	len = ce_namelen(alias);
-	new = xcalloc(1, cache_entry_size(len));
-	memcpy(new->name, alias->name, len);
-	copy_cache_entry(new, ce);
+	new_entry = xcalloc(1, cache_entry_size(len));
+	memcpy(new_entry->name, alias->name, len);
+	copy_cache_entry(new_entry, ce);
 	save_or_free_index_entry(istate, ce);
-	return new;
+	return new_entry;
 }
 
 void set_object_name_for_intent_to_add_entry(struct cache_entry *ce)
@@ -1379,7 +1379,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	added_fmt = (in_porcelain ? "A\t%s\n" : "%s needs update\n");
 	unmerged_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
 	for (i = 0; i < istate->cache_nr; i++) {
-		struct cache_entry *ce, *new;
+		struct cache_entry *ce, *new_entry;
 		int cache_errno = 0;
 		int changed = 0;
 		int filtered = 0;
@@ -1408,10 +1408,10 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		if (filtered)
 			continue;
 
-		new = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
-		if (new == ce)
+		new_entry = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
+		if (new_entry == ce)
 			continue;
-		if (!new) {
+		if (!new_entry) {
 			const char *fmt;
 
 			if (really && cache_errno == EINVAL) {
@@ -1440,7 +1440,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 			continue;
 		}
 
-		replace_index_entry(istate, i, new);
+		replace_index_entry(istate, i, new_entry);
 	}
 	return has_errors;
 }
-- 
2.16.0.rc1.238.g530d649a79-goog

