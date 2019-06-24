Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB88B1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 13:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfFXNCw (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 09:02:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35701 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfFXNCv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 09:02:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so7108996pgl.2
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 06:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NxO18jhYr9BpexWn56R/qPBTMSoTD92+oXI5cx3c4bA=;
        b=Xia1ZcqUfnN12XrX75ePG/oaMI2Q14zO//MlSEiVG6v1uBAtmRoU10km1maO910QjT
         Rk8U3jhtpSZtfjqtmzsxnSFgf0rHaI7CowFHnFuaiSQ/9w/mN30+3c1JCz63XB9bgMhI
         iP4bb3iVRK0Bab3M+Ja1S0ueNRgg7V1QEG4sYrz5aXgE/lWbgHW80FQIflI17UaHBg4g
         PlBiii99X1CQTFBArLsFY1IgbRwN3yfUp7WOYhlKQSTu84zl+97eNh6D4hG0YpjhiyAz
         sL+UD4Ino97MnrQ+M7rAlJBayos98Y56Vi+Y8RvmvdLBXvFRj93AAQoftYpP26nWI4Rp
         zdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NxO18jhYr9BpexWn56R/qPBTMSoTD92+oXI5cx3c4bA=;
        b=SX4GhP+7E2qb5PkaA6UXzYcrQJO+2s9t2SzcVnTLjZhTF0FiCmgwy2nAZOv8+4Mwgb
         HEQdkme618FQiE+kMuWHj4VS/O8/z1REg6A8aePT1UXOAv+n3462s7Xn97FKY3fbOibj
         AqcRVGOBbmGiDVSKquy7gZ87wc9ZTwA4q+J+t3njzJgLOxKGZmuUe8kDb5lRGtenLFNW
         5Ef7rCMIbs9IkiEtg1TQ4AFyqz4NgnUPnhhtDTCiXDE+8TkrmT0O7NQ7oRYDew41bCXc
         yptrcv1D8ZzezFkY8WMvyahKN8qaWSVpK/5VgQuS8Iszk/gvWcA1espYJvAWOJM6C9ED
         kYHA==
X-Gm-Message-State: APjAAAVrocfZixDXdK5HmaekDyTIy2UZeWcHDn55kmbk1/cucvuo/RxX
        /yCs9EJ6pTnjTYf+JESsr/pRbMM2
X-Google-Smtp-Source: APXvYqxOf/ol2N/24RDkPCs89TQ2uJbBprudwxbJ8Wmm2Ru64IT18MjHQCMeJqosWqOYTn8yEx0y0Q==
X-Received: by 2002:a63:d0:: with SMTP id 199mr33044565pga.85.1561381369829;
        Mon, 24 Jun 2019 06:02:49 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id bo20sm12470311pjb.23.2019.06.24.06.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:02:49 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Jun 2019 20:02:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 01/10] ls-files: add --json to dump the index
Date:   Mon, 24 Jun 2019 20:02:17 +0700
Message-Id: <20190624130226.17293-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190624130226.17293-1-pclouds@gmail.com>
References: <20190624130226.17293-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So far we don't have a command to basically dump the index file out,
with all its glory details. Checking some info, for example, stat
time, usually involves either writing new code or firing up "xxd" and
decoding values by yourself.

This --json is supposed to help that. It dumps the index in a human
readable format but also easy to be processed with tools. And it will
print almost enough info to reconstruct the index later.

In this patch we only dump the main part, not extensions. But at the
end of the series, the entire index is dumped. The end result could be
very verbose even on a small repository such as git.git.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-ls-files.txt    |  5 +++
 builtin/ls-files.c                | 38 +++++++++++++---
 cache.h                           |  2 +
 json-writer.c                     | 22 ++++++++++
 json-writer.h                     | 23 ++++++++++
 read-cache.c                      | 72 ++++++++++++++++++++++++++++++-
 t/t3011-ls-files-json.sh (new +x) | 44 +++++++++++++++++++
 t/t3011/basic (new)               | 67 ++++++++++++++++++++++++++++
 8 files changed, 265 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 8461c0e83e..fec5cb7170 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -162,6 +162,11 @@ a space) at the start of each line:
 	possible for manual inspection; the exact format may change at
 	any time.
 
+--debug-json::
+	Dump the entire index content in JSON format. This is for
+	debugging purposes. The JSON structure is subject to change.
+	Note that the strings are not always valid UTF-8.
+
 --eol::
 	Show <eolinfo> and <eolattr> of files.
 	<eolinfo> is the file content identification used by Git when
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7f83c9a6f2..b60cd9ab28 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "repository.h"
 #include "config.h"
+#include "json-writer.h"
 #include "quote.h"
 #include "dir.h"
 #include "builtin.h"
@@ -31,6 +32,7 @@ static int show_modified;
 static int show_killed;
 static int show_valid_bit;
 static int show_fsmonitor_bit;
+static int show_json;
 static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
@@ -577,6 +579,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			N_("pretend that paths removed since <tree-ish> are still present")),
 		OPT__ABBREV(&abbrev),
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
+		OPT_BOOL(0, "debug-json", &show_json,
+			N_("dump index content in JSON format")),
 		OPT_END()
 	};
 
@@ -632,7 +636,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		    "--error-unmatch");
 
 	parse_pathspec(&pathspec, 0,
-		       PATHSPEC_PREFER_CWD,
+		       show_json ? PATHSPEC_PREFER_FULL : PATHSPEC_PREFER_CWD,
 		       prefix, argv);
 
 	/*
@@ -660,8 +664,18 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 
 	/* With no flags, we default to showing the cached files */
 	if (!(show_stage || show_deleted || show_others || show_unmerged ||
-	      show_killed || show_modified || show_resolve_undo))
+	      show_killed || show_modified || show_resolve_undo || show_json))
 		show_cached = 1;
+	if (show_json && (show_stage || show_deleted || show_others ||
+			  show_unmerged || show_killed || show_modified ||
+			  show_cached || pathspec.nr))
+		die(_("--debug-json cannot be used with other file selection options"));
+	if (show_json && show_resolve_undo)
+		die(_("--debug-json cannot be used with %s"), "--resolve-undo");
+	if (show_json && with_tree)
+		die(_("--debug-json cannot be used with %s"), "--with-tree");
+	if (show_json && debug_mode)
+		die(_("--debug-json cannot be used with %s"), "--debug");
 
 	if (with_tree) {
 		/*
@@ -673,10 +687,22 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		overlay_tree_on_index(the_repository->index, with_tree, max_prefix);
 	}
 
-	show_files(the_repository, &dir);
-
-	if (show_resolve_undo)
-		show_ru_info(the_repository->index);
+	if (!show_json) {
+		show_files(the_repository, &dir);
+
+		if (show_resolve_undo)
+			show_ru_info(the_repository->index);
+	} else {
+		struct json_writer jw = JSON_WRITER_INIT;
+
+		discard_index(the_repository->index);
+		the_repository->index->jw = &jw;
+		if (repo_read_index(the_repository) < 0)
+			die("index file corrupt");
+		puts(jw.json.buf);
+		the_repository->index->jw = NULL;
+		jw_release(&jw);
+	}
 
 	if (ps_matched) {
 		int bad;
diff --git a/cache.h b/cache.h
index bf20337ef4..84d0aeed20 100644
--- a/cache.h
+++ b/cache.h
@@ -326,6 +326,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 #define UNTRACKED_CHANGED	(1 << 7)
 #define FSMONITOR_CHANGED	(1 << 8)
 
+struct json_writer;
 struct split_index;
 struct untracked_cache;
 
@@ -350,6 +351,7 @@ struct index_state {
 	uint64_t fsmonitor_last_update;
 	struct ewah_bitmap *fsmonitor_dirty;
 	struct mem_pool *ce_mem_pool;
+	struct json_writer *jw;
 };
 
 /* Name hashing */
diff --git a/json-writer.c b/json-writer.c
index aadb9dbddc..0608726512 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -202,6 +202,28 @@ void jw_object_null(struct json_writer *jw, const char *key)
 	strbuf_addstr(&jw->json, "null");
 }
 
+void jw_object_filemode(struct json_writer *jw, const char *key, mode_t mode)
+{
+	object_common(jw, key);
+	strbuf_addf(&jw->json, "\"%06o\"", mode);
+}
+
+void jw_object_stat_data(struct json_writer *jw, const char *name,
+			 const struct stat_data *sd)
+{
+	jw_object_inline_begin_object(jw, name);
+	jw_object_intmax(jw, "ctime_sec", sd->sd_ctime.sec);
+	jw_object_intmax(jw, "ctime_nsec", sd->sd_ctime.nsec);
+	jw_object_intmax(jw, "mtime_sec", sd->sd_mtime.sec);
+	jw_object_intmax(jw, "mtime_nsec", sd->sd_mtime.nsec);
+	jw_object_intmax(jw, "device", sd->sd_dev);
+	jw_object_intmax(jw, "inode", sd->sd_ino);
+	jw_object_intmax(jw, "uid", sd->sd_uid);
+	jw_object_intmax(jw, "gid", sd->sd_gid);
+	jw_object_intmax(jw, "size", sd->sd_size);
+	jw_end(jw);
+}
+
 static void increase_indent(struct strbuf *sb,
 			    const struct json_writer *jw,
 			    int indent)
diff --git a/json-writer.h b/json-writer.h
index 83906b09c1..c48c4cbf33 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -42,8 +42,11 @@
  * of the given strings.
  */
 
+#include "git-compat-util.h"
 #include "strbuf.h"
 
+struct stat_data;
+
 struct json_writer
 {
 	/*
@@ -81,6 +84,9 @@ void jw_object_true(struct json_writer *jw, const char *key);
 void jw_object_false(struct json_writer *jw, const char *key);
 void jw_object_bool(struct json_writer *jw, const char *key, int value);
 void jw_object_null(struct json_writer *jw, const char *key);
+void jw_object_filemode(struct json_writer *jw, const char *key, mode_t value);
+void jw_object_stat_data(struct json_writer *jw, const char *key,
+			 const struct stat_data *sd);
 void jw_object_sub_jw(struct json_writer *jw, const char *key,
 		      const struct json_writer *value);
 
@@ -104,4 +110,21 @@ void jw_array_inline_begin_array(struct json_writer *jw);
 int jw_is_terminated(const struct json_writer *jw);
 void jw_end(struct json_writer *jw);
 
+/*
+ * These _gently versions accept NULL json_writer to reduce too much
+ * branching at the call site.
+ */
+static inline void jw_object_inline_begin_array_gently(struct json_writer *jw,
+						       const char *name)
+{
+	if (jw)
+		jw_object_inline_begin_array(jw, name);
+}
+
+static inline void jw_end_gently(struct json_writer *jw)
+{
+	if (jw)
+		jw_end(jw);
+}
+
 #endif /* JSON_WRITER_H */
diff --git a/read-cache.c b/read-cache.c
index 4dd22f4f6e..db5147d088 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -25,6 +25,7 @@
 #include "fsmonitor.h"
 #include "thread-utils.h"
 #include "progress.h"
+#include "json-writer.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -1952,6 +1953,49 @@ static void *load_index_extensions(void *_data)
 	return NULL;
 }
 
+static void dump_cache_entry(struct index_state *istate,
+			     int index,
+			     unsigned long offset,
+			     const struct cache_entry *ce)
+{
+	struct json_writer *jw = istate->jw;
+
+	jw_array_inline_begin_object(jw);
+
+	/*
+	 * this is technically redundant, but it's for easier
+	 * navigation when there hundreds of entries
+	 */
+	jw_object_intmax(jw, "id", index);
+
+	jw_object_string(jw, "name", ce->name);
+
+	jw_object_filemode(jw, "mode", ce->ce_mode);
+
+	jw_object_intmax(jw, "flags", ce->ce_flags);
+	/*
+	 * again redundant info, just so you don't have to decode
+	 * flags values manually
+	 */
+	if (ce->ce_flags & CE_EXTENDED)
+		jw_object_true(jw, "extended_flags");
+	if (ce->ce_flags & CE_VALID)
+		jw_object_true(jw, "assume_unchanged");
+	if (ce->ce_flags & CE_INTENT_TO_ADD)
+		jw_object_true(jw, "intent_to_add");
+	if (ce->ce_flags & CE_SKIP_WORKTREE)
+		jw_object_true(jw, "skip_worktree");
+	if (ce_stage(ce))
+		jw_object_intmax(jw, "stage", ce_stage(ce));
+
+	jw_object_string(jw, "oid", oid_to_hex(&ce->oid));
+
+	jw_object_stat_data(jw, "stat", &ce->ce_stat_data);
+	jw_object_intmax(jw, "file_offset", offset);
+
+	jw_end(jw);
+}
+
 /*
  * A helper function that will load the specified range of cache entries
  * from the memory mapped file and add them to the given index.
@@ -1972,6 +2016,9 @@ static unsigned long load_cache_entry_block(struct index_state *istate,
 		ce = create_from_disk(ce_mem_pool, istate->version, disk_ce, &consumed, previous_ce);
 		set_index_entry(istate, i, ce);
 
+		if (istate->jw)
+			dump_cache_entry(istate, i, src_offset, ce);
+
 		src_offset += consumed;
 		previous_ce = ce;
 	}
@@ -1983,6 +2030,8 @@ static unsigned long load_all_cache_entries(struct index_state *istate,
 {
 	unsigned long consumed;
 
+	jw_object_inline_begin_array_gently(istate->jw, "entries");
+
 	if (istate->version == 4) {
 		mem_pool_init(&istate->ce_mem_pool,
 				estimate_cache_size_from_compressed(istate->cache_nr));
@@ -1993,6 +2042,8 @@ static unsigned long load_all_cache_entries(struct index_state *istate,
 
 	consumed = load_cache_entry_block(istate, istate->ce_mem_pool,
 					0, istate->cache_nr, mmap, src_offset, NULL);
+
+	jw_end_gently(istate->jw);
 	return consumed;
 }
 
@@ -2120,6 +2171,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	size_t extension_offset = 0;
 	int nr_threads, cpus;
 	struct index_entry_offset_table *ieot = NULL;
+	int jw_pretty = 1;
 
 	if (istate->initialized)
 		return istate->cache_nr;
@@ -2154,6 +2206,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	istate->cache_nr = ntohl(hdr->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
 	istate->cache = xcalloc(istate->cache_alloc, sizeof(*istate->cache));
+	istate->timestamp.sec = st.st_mtime;
+	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 	istate->initialized = 1;
 
 	p.istate = istate;
@@ -2176,6 +2230,20 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	if (!HAVE_THREADS)
 		nr_threads = 1;
 
+	if (istate->jw) {
+		jw_object_begin(istate->jw, jw_pretty);
+		jw_object_intmax(istate->jw, "version", istate->version);
+		jw_object_string(istate->jw, "oid", oid_to_hex(&istate->oid));
+		jw_object_intmax(istate->jw, "mtime_sec", istate->timestamp.sec);
+		jw_object_intmax(istate->jw, "mtime_nsec", istate->timestamp.nsec);
+
+		/*
+		 * Threading may mess up json writing. This is for
+		 * debugging only, so performance is not a concern.
+		 */
+		nr_threads = 1;
+	}
+
 	if (nr_threads > 1) {
 		extension_offset = read_eoie_extension(mmap, mmap_size);
 		if (extension_offset) {
@@ -2204,8 +2272,6 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
 	}
 
-	istate->timestamp.sec = st.st_mtime;
-	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
 	/* if we created a thread, join it otherwise load the extensions on the primary thread */
 	if (extension_offset) {
@@ -2216,6 +2282,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		p.src_offset = src_offset;
 		load_index_extensions(&p);
 	}
+	jw_end_gently(istate->jw);
+
 	munmap((void *)mmap, mmap_size);
 
 	/*
diff --git a/t/t3011-ls-files-json.sh b/t/t3011-ls-files-json.sh
new file mode 100755
index 0000000000..97bcd814be
--- /dev/null
+++ b/t/t3011-ls-files-json.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description='ls-files dumping json'
+
+. ./test-lib.sh
+
+strip_number() {
+	for name; do
+		echo 's/\("'$name'":\) [0-9]\+/\1 <number>/' >>filter.sed
+	done
+}
+
+strip_string() {
+	for name; do
+		echo 's/\("'$name'":\) ".*"/\1 <string>/' >>filter.sed
+	done
+}
+
+compare_json() {
+	git ls-files --debug-json >json &&
+	sed -f filter.sed json >filtered &&
+	test_cmp "$TEST_DIRECTORY"/t3011/"$1" filtered
+}
+
+test_expect_success 'setup' '
+	mkdir sub &&
+	echo one >one &&
+	git add one &&
+	echo 2 >sub/two &&
+	git add sub/two &&
+
+	echo intent-to-add >ita &&
+	git add -N ita &&
+
+	strip_number ctime_sec ctime_nsec mtime_sec mtime_nsec &&
+	strip_number device inode uid gid file_offset ext_size &&
+	strip_string oid ident
+'
+
+test_expect_success 'ls-files --json, main entries' '
+	compare_json basic
+'
+
+test_done
diff --git a/t/t3011/basic b/t/t3011/basic
new file mode 100644
index 0000000000..9436445d90
--- /dev/null
+++ b/t/t3011/basic
@@ -0,0 +1,67 @@
+{
+  "version": 3,
+  "oid": <string>,
+  "mtime_sec": <number>,
+  "mtime_nsec": <number>,
+  "entries": [
+    {
+      "id": 0,
+      "name": "ita",
+      "mode": "100644",
+      "flags": 536887296,
+      "extended_flags": true,
+      "intent_to_add": true,
+      "oid": <string>,
+      "stat": {
+        "ctime_sec": <number>,
+        "ctime_nsec": <number>,
+        "mtime_sec": <number>,
+        "mtime_nsec": <number>,
+        "device": <number>,
+        "inode": <number>,
+        "uid": <number>,
+        "gid": <number>,
+        "size": 0
+      },
+      "file_offset": <number>
+    },
+    {
+      "id": 1,
+      "name": "one",
+      "mode": "100644",
+      "flags": 0,
+      "oid": <string>,
+      "stat": {
+        "ctime_sec": <number>,
+        "ctime_nsec": <number>,
+        "mtime_sec": <number>,
+        "mtime_nsec": <number>,
+        "device": <number>,
+        "inode": <number>,
+        "uid": <number>,
+        "gid": <number>,
+        "size": 4
+      },
+      "file_offset": <number>
+    },
+    {
+      "id": 2,
+      "name": "sub/two",
+      "mode": "100644",
+      "flags": 0,
+      "oid": <string>,
+      "stat": {
+        "ctime_sec": <number>,
+        "ctime_nsec": <number>,
+        "mtime_sec": <number>,
+        "mtime_nsec": <number>,
+        "device": <number>,
+        "inode": <number>,
+        "uid": <number>,
+        "gid": <number>,
+        "size": 2
+      },
+      "file_offset": <number>
+    }
+  ]
+}
-- 
2.22.0.rc0.322.g2b0371e29a

