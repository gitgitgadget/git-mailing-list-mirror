Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD40F1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162533AbeBNTB3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:29 -0500
Received: from mail-vk0-f73.google.com ([209.85.213.73]:41865 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162515AbeBNTB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:26 -0500
Received: by mail-vk0-f73.google.com with SMTP id b195so13507194vkf.8
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=PV80UhM/vl67TihZYI1dHBQq9DHXk+iar/Bdi6dHn7g=;
        b=gQS/3s9Dejpal0lMlohao7UQqrYfFD9qs5z/ETUOAZy5/83eqmAQ7luzkXUn81s5k5
         +Ma862g5gPE3WWq3098FabYsRuOxo7CXD1PGERrapYP4FnYY+XaGJt5M+42txYSF2Sk0
         byvA3LiWpfXT0xpzxcVzKEsSSkWEeCF3v2EqdaCb/hfJQ0Ex7RCVJbKwJ/5px+Dy0Gv1
         KD7oRl8qWXnaBTDWVvTqpgdvmUCbm015r3pUBXBo08diLWcZ58okTmh5/9uwc8yUmuXU
         j6Qzglku/+fwqYvPeDKrhBG+GS/1bRwf6NX8ps6CKmPx2NKB9CHFGRVpN/Nz3snqpMHA
         tTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=PV80UhM/vl67TihZYI1dHBQq9DHXk+iar/Bdi6dHn7g=;
        b=LK8HB87jjceQGlKM2QMl1DWplHDb+B6NQOpbdiZ9iB/N98uQQkgdUjB9k8C/0RFDZ2
         O5WHQ5H6P5AO5eItGhq9GQHsvI42Hg4sqkEgY8wd1BwwYN8Nmgzzy4N0aJmB5Qaxu4Om
         qKgYDumSgKkNzctpa1tjFk8f8Wk4vSR8G7TNCmGs89O05Xc29fNHk7qBnG+abAMSXb2D
         3oQ7l6NFoH6QWX/t8JBA2/K7Mi5hfMV1EKs+e23n0lMXesugBkrDqVtjnpStOR1vNP9k
         WQsmg2b88Bjq8tT/jyFSbGFJFMHEucgppKV8797BFfdVgqqDPjBRCBY8ZksH0/I/nvBC
         95SA==
X-Gm-Message-State: APf1xPDILJHBjbaNWjZE8o6R46aEvZ8mC5VYOtjfYEhlZrUfzcqrqEeQ
        4oyjBXddYgxCM5GPe2g79ufufBR8Rr5h2LaWnW3AkhyECAqUxL2G39STt+pm3ggMthrzGnkxJuU
        jPp6064g+SSwEB5bbeJmtPG6RZqNus54tkAgSrD44xo6ZPGH+OMHvJHDhYA==
X-Google-Smtp-Source: AH8x226KawJVxjOWeTJ0U7/CeDMdqG4FwPrtLdFfgrtZGH5vRBsrWyu4JaogHwMmzQ0zRVMq+uW9zJpPb0c=
MIME-Version: 1.0
X-Received: by 10.31.158.137 with SMTP id h131mr2842481vke.94.1518634885343;
 Wed, 14 Feb 2018 11:01:25 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:38 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-17-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 16/37] diff-lib: rename 'new' variable
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff-lib.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 8104603a3..261ce13d6 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -302,7 +302,7 @@ static int get_stat_data(const struct cache_entry *ce,
 }
 
 static void show_new_file(struct rev_info *revs,
-			  const struct cache_entry *new,
+			  const struct cache_entry *new_file,
 			  int cached, int match_missing)
 {
 	const struct object_id *oid;
@@ -313,16 +313,16 @@ static void show_new_file(struct rev_info *revs,
 	 * New file in the index: it might actually be different in
 	 * the working tree.
 	 */
-	if (get_stat_data(new, &oid, &mode, cached, match_missing,
+	if (get_stat_data(new_file, &oid, &mode, cached, match_missing,
 	    &dirty_submodule, &revs->diffopt) < 0)
 		return;
 
-	diff_index_show_file(revs, "+", new, oid, !is_null_oid(oid), mode, dirty_submodule);
+	diff_index_show_file(revs, "+", new_file, oid, !is_null_oid(oid), mode, dirty_submodule);
 }
 
 static int show_modified(struct rev_info *revs,
-			 const struct cache_entry *old,
-			 const struct cache_entry *new,
+			 const struct cache_entry *old_entry,
+			 const struct cache_entry *new_entry,
 			 int report_missing,
 			 int cached, int match_missing)
 {
@@ -330,47 +330,47 @@ static int show_modified(struct rev_info *revs,
 	const struct object_id *oid;
 	unsigned dirty_submodule = 0;
 
-	if (get_stat_data(new, &oid, &mode, cached, match_missing,
+	if (get_stat_data(new_entry, &oid, &mode, cached, match_missing,
 			  &dirty_submodule, &revs->diffopt) < 0) {
 		if (report_missing)
-			diff_index_show_file(revs, "-", old,
-					     &old->oid, 1, old->ce_mode,
+			diff_index_show_file(revs, "-", old_entry,
+					     &old_entry->oid, 1, old_entry->ce_mode,
 					     0);
 		return -1;
 	}
 
 	if (revs->combine_merges && !cached &&
-	    (oidcmp(oid, &old->oid) || oidcmp(&old->oid, &new->oid))) {
+	    (oidcmp(oid, &old_entry->oid) || oidcmp(&old_entry->oid, &new_entry->oid))) {
 		struct combine_diff_path *p;
-		int pathlen = ce_namelen(new);
+		int pathlen = ce_namelen(new_entry);
 
 		p = xmalloc(combine_diff_path_size(2, pathlen));
 		p->path = (char *) &p->parent[2];
 		p->next = NULL;
-		memcpy(p->path, new->name, pathlen);
+		memcpy(p->path, new_entry->name, pathlen);
 		p->path[pathlen] = 0;
 		p->mode = mode;
 		oidclr(&p->oid);
 		memset(p->parent, 0, 2 * sizeof(struct combine_diff_parent));
 		p->parent[0].status = DIFF_STATUS_MODIFIED;
-		p->parent[0].mode = new->ce_mode;
-		oidcpy(&p->parent[0].oid, &new->oid);
+		p->parent[0].mode = new_entry->ce_mode;
+		oidcpy(&p->parent[0].oid, &new_entry->oid);
 		p->parent[1].status = DIFF_STATUS_MODIFIED;
-		p->parent[1].mode = old->ce_mode;
-		oidcpy(&p->parent[1].oid, &old->oid);
+		p->parent[1].mode = old_entry->ce_mode;
+		oidcpy(&p->parent[1].oid, &old_entry->oid);
 		show_combined_diff(p, 2, revs->dense_combined_merges, revs);
 		free(p);
 		return 0;
 	}
 
-	oldmode = old->ce_mode;
-	if (mode == oldmode && !oidcmp(oid, &old->oid) && !dirty_submodule &&
+	oldmode = old_entry->ce_mode;
+	if (mode == oldmode && !oidcmp(oid, &old_entry->oid) && !dirty_submodule &&
 	    !revs->diffopt.flags.find_copies_harder)
 		return 0;
 
 	diff_change(&revs->diffopt, oldmode, mode,
-		    &old->oid, oid, 1, !is_null_oid(oid),
-		    old->name, 0, dirty_submodule);
+		    &old_entry->oid, oid, 1, !is_null_oid(oid),
+		    old_entry->name, 0, dirty_submodule);
 	return 0;
 }
 
-- 
2.16.1.291.g4437f3f132-goog

