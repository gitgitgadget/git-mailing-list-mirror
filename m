Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 455A61F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeJSW7Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36311 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeJSW7X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:23 -0400
Received: by mail-lf1-f65.google.com with SMTP id l1-v6so5674994lfc.3
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gr2Q9WEgSs5sPeN+RXJPyeaXS7+OSR/dnPCGPR8+avk=;
        b=L0BNiXil2C0sRJVNwRlQkzKm5zDcRTj8iyUT/r7SBIwTu9pxrSj34XjI1Ot61M7pWL
         UVTzEBcuyOXxT7XJDyek/v4DPBTUOc73kYy72dicf5JcA632AyW+5jWmnGDvx8GlCAxj
         NRCwhjvgi7Eai1zN4+nn0pSGT1+v/keZxyw5ctOHDXeHhjR3m/YGLA+XTJgDgkrlsUkR
         BmorAze1x82eEe5tSgBkWzKGBqSBU6M+G9zR5/asweB/cpDPLOv+I+UckjMbSvX1uhtS
         rdgSZN7NjlWNTj+yYy4z8SWp3FE5LfkAEflmc5YHkcPrTZuth/SLY+VlR4nu1N66hIUf
         kXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gr2Q9WEgSs5sPeN+RXJPyeaXS7+OSR/dnPCGPR8+avk=;
        b=KimcaTnGu7QTtK5igBHEUdfbJ380/Xzg1hpyxgRrIILWo9Cg5fheAZGiFFkac7CLnW
         UTKS4Puk7UCIKd9fK9tBwWM6KNZtDx6C/KjaQ9KJkyzP/HmBLSSFogKKQMWgpyz8icmq
         szRLM7GhBVP+hT3X4d+tIaQI/Ibb0LhX2WrWJL11oLqm+S8+2xHKVFWhpmYG/V5fsapu
         YaRW+aB2JEq6UbrYOLqjjkj0j6zHHhzjFox0UaoITkjjkFBmVpuL0mC7rxO16VGXjX5x
         OVEMuYSgMFTrW00G998m0YxllsVccu/Q4fhCnMF/HlBWw/O1vptQ14iyi36/V4b3hy/6
         3iNA==
X-Gm-Message-State: ABuFfogXMhKZDih8ZAiRuXGNHGus00lj3VG1Gq8elafdXB8J4M2zlcHH
        sjfaCO1WixQbnPcrGUF377cXXTQd
X-Google-Smtp-Source: ACcGV61wxbcbZ5utE33E7fd+PCcGopngE/C4n+XunRuc7ucRtQb1wgYVPYJ9gCD4HnKb7B3XSNfwTw==
X-Received: by 2002:a19:9f8c:: with SMTP id i134-v6mr3170531lfe.52.1539960773141;
        Fri, 19 Oct 2018 07:52:53 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:52:52 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/19] repository.c: replace hold_locked_index() with repo_hold_locked_index()
Date:   Fri, 19 Oct 2018 16:52:27 +0200
Message-Id: <20181019145237.16079-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181019145237.16079-1-pclouds@gmail.com>
References: <20181019145237.16079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hold_locked_index() assumes the index path at $GIT_DIR/index. This is
not good for places that take an arbitrary index_state instead of
the_index, which is basically everywhere except builtin/.

Replace it with repo_hold_locked_index(). hold_locked_index() remains
as a wrapper around repo_hold_locked_index() to reduce changes in builtin/

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 apply.c           | 3 ++-
 builtin/clone.c   | 1 +
 cache.h           | 2 +-
 merge-recursive.c | 2 +-
 merge.c           | 2 +-
 read-cache.c      | 5 -----
 repository.c      | 8 ++++++++
 repository.h      | 4 ++++
 rerere.c          | 2 +-
 sequencer.c       | 8 ++++----
 wt-status.c       | 2 +-
 11 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/apply.c b/apply.c
index fdae1d423b..122e6ddf92 100644
--- a/apply.c
+++ b/apply.c
@@ -4710,7 +4710,8 @@ static int apply_patch(struct apply_state *state,
 						  state->index_file,
 						  LOCK_DIE_ON_ERROR);
 		else
-			hold_locked_index(&state->lock_file, LOCK_DIE_ON_ERROR);
+			repo_hold_locked_index(state->repo, &state->lock_file,
+					       LOCK_DIE_ON_ERROR);
 	}
 
 	if (state->check_index && read_apply_cache(state) < 0) {
diff --git a/builtin/clone.c b/builtin/clone.c
index 15b142d646..dfefe85770 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -8,6 +8,7 @@
  * Clone a repository into a different directory that does not yet exist.
  */
 
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/cache.h b/cache.h
index 59c8a93046..ef2483ce45 100644
--- a/cache.h
+++ b/cache.h
@@ -433,6 +433,7 @@ void validate_cache_entries(const struct index_state *istate);
 #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
 #define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
 #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(&the_index, (path), (sz))
+#define hold_locked_index(lock_file, flags) repo_hold_locked_index(the_repository, (lock_file), (flags))
 #endif
 
 #define TYPE_BITS 3
@@ -826,7 +827,6 @@ extern struct cache_entry *refresh_cache_entry(struct index_state *, struct cach
  */
 extern void update_index_if_able(struct index_state *, struct lock_file *);
 
-extern int hold_locked_index(struct lock_file *, int);
 extern void set_alternate_index_output(const char *);
 
 extern int verify_index_checksum;
diff --git a/merge-recursive.c b/merge-recursive.c
index c0fb83d285..c186812ff2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3510,7 +3510,7 @@ int merge_recursive_generic(struct merge_options *o,
 		}
 	}
 
-	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
 				result);
 	if (clean < 0) {
diff --git a/merge.c b/merge.c
index 91008f7602..dbbc9d9f80 100644
--- a/merge.c
+++ b/merge.c
@@ -58,7 +58,7 @@ int checkout_fast_forward(struct repository *r,
 
 	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
 
-	if (hold_locked_index(&lock_file, LOCK_REPORT_ON_ERROR) < 0)
+	if (repo_hold_locked_index(r, &lock_file, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
 	memset(&trees, 0, sizeof(trees));
diff --git a/read-cache.c b/read-cache.c
index 1df5c16dbc..7ad3330942 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1726,11 +1726,6 @@ static int read_index_extension(struct index_state *istate,
 	return 0;
 }
 
-int hold_locked_index(struct lock_file *lk, int lock_flags)
-{
-	return hold_lock_file_for_update(lk, get_index_file(), lock_flags);
-}
-
 int read_index(struct index_state *istate)
 {
 	return read_index_from(istate, get_index_file(), get_git_dir());
diff --git a/repository.c b/repository.c
index 5dd1486718..39b5a80d43 100644
--- a/repository.c
+++ b/repository.c
@@ -3,6 +3,7 @@
 #include "object-store.h"
 #include "config.h"
 #include "object.h"
+#include "lockfile.h"
 #include "submodule-config.h"
 
 /* The main repository */
@@ -257,3 +258,10 @@ int repo_read_index(struct repository *repo)
 
 	return read_index_from(repo->index, repo->index_file, repo->gitdir);
 }
+
+int repo_hold_locked_index(struct repository *repo,
+			   struct lock_file *lf,
+			   int flags)
+{
+	return hold_lock_file_for_update(lf, repo->index_file, flags);
+}
diff --git a/repository.h b/repository.h
index 9f16c42c1e..968330218f 100644
--- a/repository.h
+++ b/repository.h
@@ -6,6 +6,7 @@
 struct config_set;
 struct git_hash_algo;
 struct index_state;
+struct lock_file;
 struct raw_object_store;
 struct submodule_cache;
 
@@ -130,5 +131,8 @@ void repo_clear(struct repository *repo);
  * populated then the number of entries will simply be returned.
  */
 int repo_read_index(struct repository *repo);
+int repo_hold_locked_index(struct repository *repo,
+			   struct lock_file *lf,
+			   int flags);
 
 #endif /* REPOSITORY_H */
diff --git a/rerere.c b/rerere.c
index 887e26d45b..13927de7e0 100644
--- a/rerere.c
+++ b/rerere.c
@@ -702,7 +702,7 @@ static void update_paths(struct repository *r, struct string_list *update)
 	struct lock_file index_lock = LOCK_INIT;
 	int i;
 
-	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(r, &index_lock, LOCK_DIE_ON_ERROR);
 
 	for (i = 0; i < update->nr; i++) {
 		struct string_list_item *item = &update->items[i];
diff --git a/sequencer.c b/sequencer.c
index 2c2ea2b45d..ced05cd73d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -535,7 +535,7 @@ static int do_recursive_merge(struct repository *r,
 	char **xopt;
 	struct lock_file index_lock = LOCK_INIT;
 
-	if (hold_locked_index(&index_lock, LOCK_REPORT_ON_ERROR) < 0)
+	if (repo_hold_locked_index(r, &index_lock, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
 	read_index(r->index);
@@ -1935,7 +1935,7 @@ static int read_and_refresh_cache(struct repository *r,
 				  struct replay_opts *opts)
 {
 	struct lock_file index_lock = LOCK_INIT;
-	int index_fd = hold_locked_index(&index_lock, 0);
+	int index_fd = repo_hold_locked_index(r, &index_lock, 0);
 	if (read_index_preload(r->index, NULL, 0) < 0) {
 		rollback_lock_file(&index_lock);
 		return error(_("git %s: failed to read the index"),
@@ -2866,7 +2866,7 @@ static int do_reset(struct repository *r,
 	struct unpack_trees_options unpack_tree_opts;
 	int ret = 0, i;
 
-	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
+	if (repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
 	if (len == 10 && !strncmp("[new root]", name, len)) {
@@ -2981,7 +2981,7 @@ static int do_merge(struct repository *r,
 	static struct lock_file lock;
 	const char *p;
 
-	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
+	if (repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
 		goto leave_merge;
 	}
diff --git a/wt-status.c b/wt-status.c
index 3632276236..da28921772 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2371,7 +2371,7 @@ int require_clean_work_tree(struct repository *r,
 	struct lock_file lock_file = LOCK_INIT;
 	int err = 0, fd;
 
-	fd = hold_locked_index(&lock_file, 0);
+	fd = repo_hold_locked_index(r, &lock_file, 0);
 	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (0 <= fd)
 		update_index_if_able(r->index, &lock_file);
-- 
2.19.1.647.g708186aaf9

