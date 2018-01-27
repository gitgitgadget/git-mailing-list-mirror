Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D31A1F404
	for <e@80x24.org>; Sat, 27 Jan 2018 01:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeA0BkL (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 20:40:11 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36983 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeA0BkK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 20:40:10 -0500
Received: by mail-pf0-f196.google.com with SMTP id p1so1389552pfh.4
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 17:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=thUYifaAgcMTmNiJnRVhQaVUHG9X5DkWVXv3LgMZH3k=;
        b=HZxJkBveP/pa16/ipLek5YiFI8wU/0atus8IjMds6+1CnfcrcteuzD8cMd0Hrlcf6d
         cpQWKVAIBcEIPTgtMDq22Xro7RMyNuEz2ZxjJpysrUdh40ao103qxLjrE0IMUx5+lrnK
         mc+PTIW3PRQ4ZU21Gncr6hKK8IHdXqtO2DsSiNQYol8d7RILDMDdhV66MNnQuYnU8Dx7
         UCM3wlY4ZKoPUlxUi3L1rHtVHZigC8Ob4ntTYvv2Kc50WJA2hT3fyhnYRgMrx/M0n4w1
         QMVcA06v1f5rmHqYaUvAIGOUf4gKqhSnFdxRZlTgPAJfzt6z/Sybj4iv53Vwh/f8pSLG
         th5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thUYifaAgcMTmNiJnRVhQaVUHG9X5DkWVXv3LgMZH3k=;
        b=TAhhziu9Vo8aGNmnsSDmPY9TsNijUnoanaugEH6KdqEQw4TW8iCto3FZZsaj4n/cmu
         0EwcitwRDsBb+U+4Hyi5h65G4FxZWACHKzJ6cVoUpymcGkiIPBrfdjbD27kZ6+xtnsZO
         G4c7fwBeDUdZMb+W5GTYQRQApg5W87kk2LPptv2iGDfAXiZNEbBoq/32sNumE9DQErbq
         oCtl0+j99+sg3ExTMbzhqNjt5MErhfoBNjmuQTb7j6ONZkEmQM/6ieW5ic81izY9tXau
         05jcOpCe4teEhnMwE3fZhshK4O73qLxTlljZFZcJjmaYlAcmCq8XKxauvVT0MAezcGeC
         4zYQ==
X-Gm-Message-State: AKwxytctmypyjAE5tMXIphb88fzDKyB46k6+lxqvS8d2WNeSZyZCHo4C
        Xeujulqt3ISD1HNlBimUkDC65w==
X-Google-Smtp-Source: AH8x226qNja22R3b/bV4kkg6Kfh29lvRStYAq7uVuuP9xlZMSTLIpfTAJsEMRV//sUdkbDLXvhOwGA==
X-Received: by 10.98.211.21 with SMTP id q21mr20307046pfg.89.1517017208751;
        Fri, 26 Jan 2018 17:40:08 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id y1sm10099443pge.78.2018.01.26.17.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2018 17:40:08 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 27 Jan 2018 08:40:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, benpeart@microsoft.com, alexmv@dropbox.com,
        christian.couder@gmail.com, dturner@twopensource.com,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] trace: measure where the time is spent in the index-heavy operations
Date:   Sat, 27 Jan 2018 08:39:56 +0700
Message-Id: <20180127013956.21420-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <CACsJy8BpO0s6facg+zcKC9icijpefkipM326n6xOArjn=ZW6+w@mail.gmail.com>
References: <CACsJy8BpO0s6facg+zcKC9icijpefkipM326n6xOArjn=ZW6+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All the known heavy code blocks are measured (except object database
access). This should help identify if an optimization is effective or
not. An unoptimized git-status would give something like below (92% of
time is accounted).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 This was in my old index-helper series. The series was replaced by
 fsmonitor but perhaps some measurements like this still helps.

 In my old version I measured packed-refs read time too. But
 packed-refs is mmap'd now, no need to worry about it (or at least its
 initial cost).

 diff-lib.c      |  4 ++++
 dir.c           |  2 ++
 name-hash.c     |  3 +++
 preload-index.c |  2 ++
 read-cache.c    | 11 +++++++++++
 5 files changed, 22 insertions(+)

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
index 2eb81a66b9..1f00aee6a2 100644
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
 
@@ -1877,12 +1879,15 @@ int read_index_from(struct index_state *istate, const char *path)
 	int ret;
 	char *base_sha1_hex;
 	const char *base_path;
+	uint64_t start;
 
 	/* istate->initialized covers both .git/index and .git/sharedindex.xxx */
 	if (istate->initialized)
 		return istate->cache_nr;
 
+	start = getnanotime();
 	ret = do_read_index(istate, path, 0);
+	trace_performance_since(start, "read cache %s", path);
 
 	split_index = istate->split_index;
 	if (!split_index || is_null_sha1(split_index->base_sha1)) {
@@ -1897,6 +1902,7 @@ int read_index_from(struct index_state *istate, const char *path)
 
 	base_sha1_hex = sha1_to_hex(split_index->base_sha1);
 	base_path = git_path("sharedindex.%s", base_sha1_hex);
+	start = getnanotime();
 	ret = do_read_index(split_index->base, base_path, 1);
 	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
 		die("broken index, expect %s in %s, got %s",
@@ -1906,6 +1912,9 @@ int read_index_from(struct index_state *istate, const char *path)
 	freshen_shared_index(base_sha1_hex, 0);
 	merge_base_index(istate);
 	post_read_index_from(istate);
+	trace_performance_since(start, "read cache %s",
+				git_path("sharedindex.%s",
+					 sha1_to_hex(split_index->base_sha1)));
 	return ret;
 }
 
@@ -2244,6 +2253,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	struct ondisk_cache_entry_extended ondisk;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 	int drop_cache_tree = 0;
+	uint64_t start = getnanotime();
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -2374,6 +2384,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		return -1;
 	istate->timestamp.sec = (unsigned int)st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
+	trace_performance_since(start, "write index, changed mask = %x", istate->cache_changed);
 	return 0;
 }
 
-- 
2.16.1.205.g271f633410

