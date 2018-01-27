Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 999161F404
	for <e@80x24.org>; Sat, 27 Jan 2018 12:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeA0M2R (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 07:28:17 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:38502 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbeA0M2P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 07:28:15 -0500
Received: by mail-pf0-f170.google.com with SMTP id k19so1790635pfj.5
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 04:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GWtFYnbrHgMPvTGZpbjNTqbUyZvk7IPZ16XsdsnbiYQ=;
        b=P9Liei5h+f1qq5WDHpVaJ4tIixrJjsA+SvrFneVsLM+n8yBnXw6fYpI4I6JX6Tzpjb
         JXWNdn2CBWlwSH049T17SvangcJaB35He33P6N9Rpr/mAGIwMOTLx1VOI/j5awcb7YbL
         SyUR5dKuW4ZmEVVHMlbVCfawjZLCJ5iPX9Rnh7w+IsaMxSpnfWhq+AY+yFXKgDVd5wCO
         fjJIE38MEsM1+dqXatErfoRYX7wtx71kfO7gIymWa1aYPc0XRD6PKuETMAukF8iJJaPq
         W1crqqGsBCegj7aZp6CumuiIUY8qCjcat4oF+GtdNubD8OOZeRAjXXUvjHGyys2C+ZBd
         u4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GWtFYnbrHgMPvTGZpbjNTqbUyZvk7IPZ16XsdsnbiYQ=;
        b=mEPYP7OaUV5TtYVrsATtNH4CDyZS0zZFFapoETt3MiPBTVdZ/23++NwUZel9HRuri+
         csoB1ZtYNzPGjLwFGxCk/LvuDkoqOqg9BQ1KBrGHQynDyC14/Lw7GlQyxVLk5NcGaJSQ
         HCkYloBmwX4wCZ+ycyaA+U35KSWB2knUxTE+t6VcD9w8TC/sc2VQIWOautOG98qM4HRT
         g2/wSsnbt45VCuDw3LDc6msotU2bxl0XqYv33mI/SxFFkyl6tQqBuMR4QxSITz48Rp/x
         QR4vwyGehMF6Wcdp6du32egcBZyRkyA/eynr+WWKtbyYxPyzvNQIQUI5aSegdwsOxRi3
         QK5g==
X-Gm-Message-State: AKwxyten46TqvblacpkhPah2KykauweCKF9NIof8TRVQMOg+XYVa5289
        sk1NEE5q0BYMWk+/MmDiob2Utw==
X-Google-Smtp-Source: AH8x227DVL1Y98bwSiiuyVvofURF+EGsxu4F6g+zH51L06KF5BelqqnD4na74UXMhtfpNklbFtG2vg==
X-Received: by 10.99.36.68 with SMTP id k65mr18099106pgk.345.1517056094769;
        Sat, 27 Jan 2018 04:28:14 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id y79sm21921781pfb.177.2018.01.27.04.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jan 2018 04:28:13 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 27 Jan 2018 19:28:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, benpeart@microsoft.com, alexmv@dropbox.com,
        christian.couder@gmail.com, t.gummerer@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] trace: measure where the time is spent in the index-heavy operations
Date:   Sat, 27 Jan 2018 19:27:56 +0700
Message-Id: <20180127122756.16971-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180127115811.GB2130@hank>
References: <20180127115811.GB2130@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All the known heavy code blocks are measured (except object database
access). This should help identify if an optimization is effective or
not. An unoptimized git-status would give something like below:

    0.001791141 s: read cache ...
    0.004011363 s: preload index
    0.000516161 s: refresh index
    0.003139257 s: git command: ... 'status' '--porcelain=2'
    0.006788129 s: diff-files
    0.002090267 s: diff-index
    0.001885735 s: initialize name hash
    0.032013138 s: read directory
    0.051781209 s: git command: './git' 'status'

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 > Would it be worth doing this on top of tg/split-index-fixes?  OTOH
 > this will only give a wrong output when tracing performance is on, and
 > it should be easy enough to figure out where the sharedindex actually
 > is.  So it might be better to keep this separate, and then just add a
 > patch on top for fixing the path later, which might be less work for
 > Junio.

 I updated the patch a bit to avoid git_path(). A merge on 'pu' still
 conflicts, but it's much easier to resolve by making sure free() is
 called after the trace_performance_since() line in read_index_from().

 It's technically dangerous to re-use base_path again this way, too
 far away from its assignment since 4 other git_path() calls may have
 been done and changed base_path value. But since tg/split-index-fixes
 should enter 'master' eventually and make it safe to re-use
 base_path, I think it's ok.

 diff-lib.c      | 4 ++++
 dir.c           | 2 ++
 name-hash.c     | 3 +++
 preload-index.c | 2 ++
 read-cache.c    | 7 +++++++
 5 files changed, 18 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index 8104603a3b..a228e1a219 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -92,6 +92,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 	int diff_unmerged_stage = revs->max_count;
 	unsigned ce_option = ((option & DIFF_RACY_IS_MODIFIED)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
+	uint64_t start = getnanotime();
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
@@ -246,6 +247,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 	}
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
+	trace_performance_since(start, "diff-files");
 	return 0;
 }
 
@@ -512,6 +514,7 @@ static int diff_cache(struct rev_info *revs,
 int run_diff_index(struct rev_info *revs, int cached)
 {
 	struct object_array_entry *ent;
+	uint64_t start = getnanotime();
 
 	ent = revs->pending.objects;
 	if (diff_cache(revs, &ent->item->oid, ent->name, cached))
@@ -521,6 +524,7 @@ int run_diff_index(struct rev_info *revs, int cached)
 	diffcore_fix_diff_index(&revs->diffopt);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
+	trace_performance_since(start, "diff-index");
 	return 0;
 }
 
diff --git a/dir.c b/dir.c
index 7c4b45e30e..4479a02a49 100644
--- a/dir.c
+++ b/dir.c
@@ -2248,6 +2248,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		   const char *path, int len, const struct pathspec *pathspec)
 {
 	struct untracked_cache_dir *untracked;
+	uint64_t start = getnanotime();
 
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
@@ -2286,6 +2287,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		dir->nr = i;
 	}
 
+	trace_performance_since(start, "read directory %.*s", len, path);
 	if (dir->untracked) {
 		static struct trace_key trace_untracked_stats = TRACE_KEY_INIT(UNTRACKED_STATS);
 		trace_printf_key(&trace_untracked_stats,
diff --git a/name-hash.c b/name-hash.c
index 45c98db0a0..ada66f066a 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -578,6 +578,8 @@ static void threaded_lazy_init_name_hash(
 
 static void lazy_init_name_hash(struct index_state *istate)
 {
+	uint64_t start = getnanotime();
+
 	if (istate->name_hash_initialized)
 		return;
 	hashmap_init(&istate->name_hash, cache_entry_cmp, NULL, istate->cache_nr);
@@ -600,6 +602,7 @@ static void lazy_init_name_hash(struct index_state *istate)
 	}
 
 	istate->name_hash_initialized = 1;
+	trace_performance_since(start, "initialize name hash");
 }
 
 /*
diff --git a/preload-index.c b/preload-index.c
index 2a83255e4e..4d08d44874 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -78,6 +78,7 @@ static void preload_index(struct index_state *index,
 {
 	int threads, i, work, offset;
 	struct thread_data data[MAX_PARALLEL];
+	uint64_t start = getnanotime();
 
 	if (!core_preload_index)
 		return;
@@ -108,6 +109,7 @@ static void preload_index(struct index_state *index,
 		if (pthread_join(p->pthread, NULL))
 			die("unable to join threaded lstat");
 	}
+	trace_performance_since(start, "preload index");
 }
 #endif
 
diff --git a/read-cache.c b/read-cache.c
index 2eb81a66b9..eac74bc9f1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1372,6 +1372,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	const char *typechange_fmt;
 	const char *added_fmt;
 	const char *unmerged_fmt;
+	uint64_t start = getnanotime();
 
 	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
 	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
@@ -1442,6 +1443,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 
 		replace_index_entry(istate, i, new);
 	}
+	trace_performance_since(start, "refresh index");
 	return has_errors;
 }
 
@@ -1873,6 +1875,7 @@ static void freshen_shared_index(char *base_sha1_hex, int warn)
 
 int read_index_from(struct index_state *istate, const char *path)
 {
+	uint64_t start = getnanotime();
 	struct split_index *split_index;
 	int ret;
 	char *base_sha1_hex;
@@ -1883,6 +1886,7 @@ int read_index_from(struct index_state *istate, const char *path)
 		return istate->cache_nr;
 
 	ret = do_read_index(istate, path, 0);
+	trace_performance_since(start, "read cache %s", path);
 
 	split_index = istate->split_index;
 	if (!split_index || is_null_sha1(split_index->base_sha1)) {
@@ -1906,6 +1910,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	freshen_shared_index(base_sha1_hex, 0);
 	merge_base_index(istate);
 	post_read_index_from(istate);
+	trace_performance_since(start, "read cache %s", base_path);
 	return ret;
 }
 
@@ -2234,6 +2239,7 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
 static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			  int strip_extensions)
 {
+	uint64_t start = getnanotime();
 	int newfd = tempfile->fd;
 	git_SHA_CTX c;
 	struct cache_header hdr;
@@ -2374,6 +2380,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		return -1;
 	istate->timestamp.sec = (unsigned int)st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
+	trace_performance_since(start, "write index, changed mask = %x", istate->cache_changed);
 	return 0;
 }
 
-- 
2.16.1.205.g271f633410

