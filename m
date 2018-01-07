Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC761F404
	for <e@80x24.org>; Sun,  7 Jan 2018 22:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754735AbeAGW2a (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 17:28:30 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40971 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754722AbeAGW22 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 17:28:28 -0500
Received: by mail-wr0-f196.google.com with SMTP id o7so6219342wro.8
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 14:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VzvdGS19n1zXzGxnXD5GkITE/kYworj/7os7RV8DhtE=;
        b=UyilubI3Ma29NpGoKRr1E4VGQr5PC+qudCj3nX2L/uIzgKfYdi3gyz7AlqVueOrnoZ
         CcI+NoA346Xo//c5bepyUfuoumPfc4paKtko1CilkRY9pgtX1zfJl9yWeaIkfr+Zfl7b
         hytW6hhPUgjG6BfRDId9Zf5Oba9fAuNl6kGkXOqLtVxGLEm1myLp52ccsaqMedoysnGi
         Q6LPE1RG4iJ6nBdfEKuYO7/4zqDaV7vtId7LR8Ad9ncAms0f4zHWUP/BBVaxsV/yCO1e
         qZ7fdD0LtqobTKT1LARTuIyR/+wkiumVwpNjXtjZvz8+9UQXuKQt1zBiaYGrP18Xwd+p
         TcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VzvdGS19n1zXzGxnXD5GkITE/kYworj/7os7RV8DhtE=;
        b=nEIUJbA8nY3spk4oo85DHwoTW2sgHGtmk04rNB0LFJWST4qxiEhpDYmzkT3ya+REKm
         p89ei3kP8bxdzTjfTm+j809cOZlcGOSt1+cVYHIGd0qNzviv/iTUBxTCDC7LoGwdo6Vm
         xIjy55XCDke4chwNXDd7icYujprqQ6TBWBangUN2Rs5MuVQ4YhiKC0o3S8zqDWax5eb3
         9lmQXmH58sbbCXGcBu1fzE4Q+a+3hYDoOakQ2J3tLUqKDWguLESPOAu2QkiJ6YcBvSpq
         mynPmQeLITVvgoL8QMfdNf+foGgY9IlQnSI+TSLpo0YYL9HjrtkYk59fAS7DSjrJzVFL
         Cm5g==
X-Gm-Message-State: AKGB3mLd42UW+Q8gl2bSHGEjx7L2HvEO4o9YEoj+y1MNXFkuXctQgUAf
        bPy6gcWibu0FLlnPf8hz2GYj9rno
X-Google-Smtp-Source: ACJfBosBWFqQemp10qT98D1I+4D2NgZeZ5lRt0oGYHiB/OjUYZMVsEMThQAYbCJcWKLvrzxlE/wM7g==
X-Received: by 10.223.162.195 with SMTP id t3mr8166754wra.237.1515364107324;
        Sun, 07 Jan 2018 14:28:27 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id o16sm11232057wmi.29.2018.01.07.14.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jan 2018 14:28:26 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 1/3] read-cache: fix reading the shared index for other repos
Date:   Sun,  7 Jan 2018 22:30:13 +0000
Message-Id: <20180107223015.17720-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79
In-Reply-To: <20180107223015.17720-1-t.gummerer@gmail.com>
References: <20171217225122.28941-1-t.gummerer@gmail.com>
 <20180107223015.17720-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

read_index_from() takes a path argument for the location of the index
file.  For reading the shared index in split index mode however it just
ignores that path argument, and reads it from the gitdir of the current
repository.

This works as long as an index in the_repository is read.  Once that
changes, such as when we read the index of a submodule, or of a
different working tree than the current one, the gitdir of
the_repository will no longer contain the appropriate shared index,
and git will fail to read it.

For example t3007-ls-files-recurse-submodules.sh was broken with
GIT_TEST_SPLIT_INDEX set in 188dce131f ("ls-files: use repository
object", 2017-06-22), and t7814-grep-recurse-submodules.sh was also
broken in a similar manner, probably by introducing struct repository
there, although I didn't track down the exact commit for that.

be489d02d2 ("revision.c: --indexed-objects add objects from all
worktrees", 2017-08-23) breaks with split index mode in a similar
manner, not erroring out when it can't read the index, but instead
carrying on with pruning, without taking the index of the worktree into
account.

Fix this by passing an additional gitdir parameter to read_index_from,
to indicate where it should look for and read the shared index from.

read_cache_from() defaults to using the gitdir of the_repository.  As it
is mostly a convenience macro, having to pass get_git_dir() for every
call seems overkill, and if necessary users can have more control by
using read_index_from().

Helped-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache-tree.c |  2 +-
 cache.h      |  5 +++--
 read-cache.c | 23 +++++++++++++----------
 repository.c |  2 +-
 revision.c   |  3 ++-
 5 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index e03e72c34a..0dd6292a94 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -608,7 +608,7 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 
 	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
 
-	entries = read_index_from(index_state, index_path);
+	entries = read_index_from(index_state, index_path, get_git_dir());
 	if (entries < 0) {
 		ret = WRITE_TREE_UNREADABLE_INDEX;
 		goto out;
diff --git a/cache.h b/cache.h
index d8b975a571..d5a7d1d7f1 100644
--- a/cache.h
+++ b/cache.h
@@ -371,7 +371,7 @@ extern void free_name_hash(struct index_state *istate);
 #define active_cache_tree (the_index.cache_tree)
 
 #define read_cache() read_index(&the_index)
-#define read_cache_from(path) read_index_from(&the_index, (path))
+#define read_cache_from(path) read_index_from(&the_index, (path), (get_git_dir()))
 #define read_cache_preload(pathspec) read_index_preload(&the_index, (pathspec))
 #define is_cache_unborn() is_index_unborn(&the_index)
 #define read_cache_unmerged() read_index_unmerged(&the_index)
@@ -616,7 +616,8 @@ extern int read_index(struct index_state *);
 extern int read_index_preload(struct index_state *, const struct pathspec *pathspec);
 extern int do_read_index(struct index_state *istate, const char *path,
 			 int must_exist); /* for testting only! */
-extern int read_index_from(struct index_state *, const char *path);
+extern int read_index_from(struct index_state *, const char *path,
+			   const char *gitdir);
 extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
 
diff --git a/read-cache.c b/read-cache.c
index 2eb81a66b9..3f5b4afa36 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1603,7 +1603,7 @@ int hold_locked_index(struct lock_file *lk, int lock_flags)
 
 int read_index(struct index_state *istate)
 {
-	return read_index_from(istate, get_index_file());
+	return read_index_from(istate, get_index_file(), get_git_dir());
 }
 
 static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *ondisk,
@@ -1863,20 +1863,19 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
  * This way, shared index can be removed if they have not been used
  * for some time.
  */
-static void freshen_shared_index(char *base_sha1_hex, int warn)
+static void freshen_shared_index(const char *shared_index, int warn)
 {
-	char *shared_index = git_pathdup("sharedindex.%s", base_sha1_hex);
 	if (!check_and_freshen_file(shared_index, 1) && warn)
 		warning("could not freshen shared index '%s'", shared_index);
-	free(shared_index);
 }
 
-int read_index_from(struct index_state *istate, const char *path)
+int read_index_from(struct index_state *istate, const char *path,
+		    const char *gitdir)
 {
 	struct split_index *split_index;
 	int ret;
 	char *base_sha1_hex;
-	const char *base_path;
+	char *base_path;
 
 	/* istate->initialized covers both .git/index and .git/sharedindex.xxx */
 	if (istate->initialized)
@@ -1896,16 +1895,17 @@ int read_index_from(struct index_state *istate, const char *path)
 		split_index->base = xcalloc(1, sizeof(*split_index->base));
 
 	base_sha1_hex = sha1_to_hex(split_index->base_sha1);
-	base_path = git_path("sharedindex.%s", base_sha1_hex);
+	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_sha1_hex);
 	ret = do_read_index(split_index->base, base_path, 1);
 	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
 		die("broken index, expect %s in %s, got %s",
 		    base_sha1_hex, base_path,
 		    sha1_to_hex(split_index->base->sha1));
 
-	freshen_shared_index(base_sha1_hex, 0);
+	freshen_shared_index(base_path, 0);
 	merge_base_index(istate);
 	post_read_index_from(istate);
+	free(base_path);
 	return ret;
 }
 
@@ -2573,8 +2573,11 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	ret = write_split_index(istate, lock, flags);
 
 	/* Freshen the shared index only if the split-index was written */
-	if (!ret && !new_shared_index)
-		freshen_shared_index(sha1_to_hex(si->base_sha1), 1);
+	if (!ret && !new_shared_index) {
+		const char *shared_index = git_path("sharedindex.%s",
+						    sha1_to_hex(si->base_sha1));
+		freshen_shared_index(shared_index, 1);
+	}
 
 out:
 	if (flags & COMMIT_LOCK)
diff --git a/repository.c b/repository.c
index 998413b8bb..0d715f4fdb 100644
--- a/repository.c
+++ b/repository.c
@@ -236,5 +236,5 @@ int repo_read_index(struct repository *repo)
 	if (!repo->index)
 		repo->index = xcalloc(1, sizeof(*repo->index));
 
-	return read_index_from(repo->index, repo->index_file);
+	return read_index_from(repo->index, repo->index_file, repo->gitdir);
 }
diff --git a/revision.c b/revision.c
index 72f2b4572e..76d6d125b3 100644
--- a/revision.c
+++ b/revision.c
@@ -1352,7 +1352,8 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 			continue; /* current index already taken care of */
 
 		if (read_index_from(&istate,
-				    worktree_git_path(wt, "index")) > 0)
+				    worktree_git_path(wt, "index"),
+				    get_worktree_git_dir(wt)) > 0)
 			do_add_index_objects_to_pending(revs, &istate);
 		discard_index(&istate);
 	}
-- 
2.16.0.rc1.238.g530d649a79

