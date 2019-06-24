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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3303F1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 13:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfFXNCr (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 09:02:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43777 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfFXNCq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 09:02:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so7089553pgv.10
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 06:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MEQ3pjwV7l06ibllxlzL/sQ06nxe0vofPQPZwS8cTrU=;
        b=WTCDaWm95pEk3CiGmBc0iwow5ikBjrjWGYwebEBpQyb48rJK6bshhDWb2t1qAGRzgI
         oP4KVfuVXUKq1SP7C9jDOkM0HfgfKI01CFkdxoAH1mPiZgkmztIo3yYinB++ri5vKYSP
         9sPkyLPxYjNFYxbWMi9tFm2Qa0N/MjEx+WbyhB8VZ1i2iDs1A45jZsTLKNQtasrvQxBV
         HcD0rf38E4OTvxmtW4sBV75RYcxcv2UXyBGhNelNfRtO0yeEKfvanb8uu/0bDNmYdwTz
         2c4AVMDuQywaXZpHa7lelEQh9qaWD2bCcDW0gmXyL/XhVIwnwbD/G0XmAYsOPpBmz1fX
         Fy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MEQ3pjwV7l06ibllxlzL/sQ06nxe0vofPQPZwS8cTrU=;
        b=H+jPtLt/QEUSDho5sT1/rO1ZUPaad4UaqzikhseIvGTknEP7AMU1CUTk8ggUmAACUK
         MaBijIMaNzlm1UQfuFJGCQ9Vb/Nny1l+ASvIbPgpHcL8+qaZFxckqpLxvyyAllBJq8QG
         /tznulsfzcbNzhzI572UCvItNmh12mLBHy3zVPc1m1QsQjvyQP92wtwEuhMkMLrhezNi
         FwTH9eIbkKaPndAvTJ019ZVy2eWVzCf5kiWUx8TpMl+NAeG7fNG1j2+hTZNg6Peg86xC
         64EHPTjuNk2Cs3mSsyKFjy+DYd+Z3a2sWENicVC+hgrgluiVBhzjdJYfLJaSZ4J8YxCL
         AvvA==
X-Gm-Message-State: APjAAAUth1gQYvEnxvbLISN/cBe1MmhJnYejrA1ASvRXRypHwJ3l6uPS
        N90dsejhce+2RJuAUlK9ySjCdfZK
X-Google-Smtp-Source: APXvYqwZCIYG+ayMfDu0YUQ5ypMy10A70GR4P/onTNloi7fa4F9OVkJM1ptnpAV16XG0JX45h+FPNw==
X-Received: by 2002:a63:8d4c:: with SMTP id z73mr25645692pgd.95.1561381364313;
        Mon, 24 Jun 2019 06:02:44 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id n7sm12170860pff.59.2019.06.24.06.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:02:42 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Jun 2019 20:02:38 +0700
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
Subject: [PATCH v2 00/10] Add 'ls-files --debug-json' to dump the index in json
Date:   Mon, 24 Jun 2019 20:02:16 +0700
Message-Id: <20190624130226.17293-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 main changes:

- --json is renamed --debug-json
- json field names now use '_' instead of '.' to be friendlier to some
  languages. I stick to underscore_name instead of camelCase because
  the former is closer to what we use
- extension location is printed, in case you need to decode the
  extension by yourself (previously only the size is printed)
- all extensions are printed in the same order they appear in the file
  (previously eoie and ieot are printed first because that's how we
  parse)
- resolve undo extension is reorganized a bit to be easier to read
- tests added. Example json files are in t/t3011

Interdiff

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 54011c8f65..fec5cb7170 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -60,11 +60,6 @@ OPTIONS
 --stage::
 	Show staged contents' mode bits, object name and stage number in the output.
 
---json::
-	Dump the entire index content in JSON format. This is for
-	debugging purposes and the JSON structure may change from time
-	to time.
-
 --directory::
 	If a whole directory is classified as "other", show just its
 	name (with a trailing slash) and not its whole contents.
@@ -167,6 +162,11 @@ a space) at the start of each line:
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
index d00f6d3074..b60cd9ab28 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -545,8 +545,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			N_("show staged contents' object name in the output")),
 		OPT_BOOL('k', "killed", &show_killed,
 			N_("show files on the filesystem that need to be removed")),
-		OPT_BOOL(0, "json", &show_json,
-			N_("dump index content in json format")),
 		OPT_BIT(0, "directory", &dir.flags,
 			N_("show 'other' directories' names only"),
 			DIR_SHOW_OTHER_DIRECTORIES),
@@ -581,6 +579,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			N_("pretend that paths removed since <tree-ish> are still present")),
 		OPT__ABBREV(&abbrev),
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
+		OPT_BOOL(0, "debug-json", &show_json,
+			N_("dump index content in JSON format")),
 		OPT_END()
 	};
 
@@ -636,7 +636,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		    "--error-unmatch");
 
 	parse_pathspec(&pathspec, 0,
-		       PATHSPEC_PREFER_CWD,
+		       show_json ? PATHSPEC_PREFER_FULL : PATHSPEC_PREFER_CWD,
 		       prefix, argv);
 
 	/*
@@ -668,8 +668,14 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		show_cached = 1;
 	if (show_json && (show_stage || show_deleted || show_others ||
 			  show_unmerged || show_killed || show_modified ||
-			  show_cached || show_resolve_undo || with_tree))
-		die(_("--show-json cannot be used with other --show- options, or --with-tree"));
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
diff --git a/cache-tree.c b/cache-tree.c
index fc44016fe8..b6a233307e 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -599,18 +599,13 @@ struct cache_tree *cache_tree_read(const char *buffer, unsigned long size,
 	struct cache_tree *ret;
 
 	if (jw) {
-		jw_object_inline_begin_object(jw, "cache-tree");
-		jw_object_intmax(jw, "ext-size", size);
 		jw_object_inline_begin_object(jw, "root");
 	}
 	if (buffer[0])
 		ret = NULL; /* not the whole tree */
 	else
 		ret = read_one(&buffer, &size, jw);
-	if (jw) {
-		jw_end(jw);	/* root */
-		jw_end(jw);	/* cache-tree */
-	}
+	jw_end_gently(jw);
 	return ret;
 }
 
diff --git a/dir.c b/dir.c
index f389eee24a..8808577ea3 100644
--- a/dir.c
+++ b/dir.c
@@ -2902,13 +2902,15 @@ struct untracked_cache *read_untracked_extension(const void *data,
 	uc->exclude_per_dir = xstrdup(exclude_per_dir);
 
 	if (jw) {
-		jw_object_inline_begin_object(jw, "untracked-cache");
-		jw_object_intmax(jw, "ext-size", sz);
 		jw_object_string(jw, "ident", ident);
-		jw_object_oid_stat(jw, "info/exclude", &uc->ss_info_exclude);
-		jw_object_oid_stat(jw, "excludes-file", &uc->ss_excludes_file);
+		jw_object_oid_stat(jw, "info_exclude", &uc->ss_info_exclude);
+		jw_object_oid_stat(jw, "excludes_file", &uc->ss_excludes_file);
 		jw_object_intmax(jw, "flags", uc->dir_flags);
-		jw_object_string(jw, "excludes-per-dir", uc->exclude_per_dir);
+		if (uc->dir_flags & DIR_SHOW_OTHER_DIRECTORIES)
+			jw_object_bool(jw, "show_other_directories", 1);
+		if (uc->dir_flags & DIR_HIDE_EMPTY_DIRECTORIES)
+			jw_object_bool(jw, "hide_empty_directories", 1);
+		jw_object_string(jw, "excludes_per_dir", uc->exclude_per_dir);
 	}
 
 	/* NUL after exclude_per_dir is covered by sizeof(*ouc) */
@@ -2968,7 +2970,6 @@ struct untracked_cache *read_untracked_extension(const void *data,
 		free_untracked_cache(uc);
 		uc = NULL;
 	}
-	jw_end_gently(jw);
 	return uc;
 }
 
diff --git a/fsmonitor.c b/fsmonitor.c
index f6ba437255..5ed55ad176 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -52,12 +52,9 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 	istate->fsmonitor_dirty = fsmonitor_dirty;
 
 	if (istate->jw) {
-		jw_object_inline_begin_object(istate->jw, "fsmonitor");
 		jw_object_intmax(istate->jw, "version", hdr_version);
-		jw_object_intmax(istate->jw, "last-update", istate->fsmonitor_last_update);
+		jw_object_intmax(istate->jw, "last_update", istate->fsmonitor_last_update);
 		jw_object_ewah(istate->jw, "dirty", fsmonitor_dirty);
-		jw_object_intmax(istate->jw, "ext-size", sz);
-		jw_end(istate->jw);
 	}
 	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
 	return 0;
diff --git a/json-writer.c b/json-writer.c
index 70403580ca..c0bd302e4e 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -203,19 +203,25 @@ void jw_object_null(struct json_writer *jw, const char *key)
 	strbuf_addstr(&jw->json, "null");
 }
 
+void jw_object_filemode(struct json_writer *jw, const char *key, mode_t mode)
+{
+	object_common(jw, key);
+	strbuf_addf(&jw->json, "\"%06o\"", mode);
+}
+
 void jw_object_stat_data(struct json_writer *jw, const char *name,
 			 const struct stat_data *sd)
 {
 	jw_object_inline_begin_object(jw, name);
-	jw_object_intmax(jw, "st_ctime.sec", sd->sd_ctime.sec);
-	jw_object_intmax(jw, "st_ctime.nsec", sd->sd_ctime.nsec);
-	jw_object_intmax(jw, "st_mtime.sec", sd->sd_mtime.sec);
-	jw_object_intmax(jw, "st_mtime.nsec", sd->sd_mtime.nsec);
-	jw_object_intmax(jw, "st_dev", sd->sd_dev);
-	jw_object_intmax(jw, "st_ino", sd->sd_ino);
-	jw_object_intmax(jw, "st_uid", sd->sd_uid);
-	jw_object_intmax(jw, "st_gid", sd->sd_gid);
-	jw_object_intmax(jw, "st_size", sd->sd_size);
+	jw_object_intmax(jw, "ctime_sec", sd->sd_ctime.sec);
+	jw_object_intmax(jw, "ctime_nsec", sd->sd_ctime.nsec);
+	jw_object_intmax(jw, "mtime_sec", sd->sd_mtime.sec);
+	jw_object_intmax(jw, "mtime_nsec", sd->sd_mtime.nsec);
+	jw_object_intmax(jw, "device", sd->sd_dev);
+	jw_object_intmax(jw, "inode", sd->sd_ino);
+	jw_object_intmax(jw, "uid", sd->sd_uid);
+	jw_object_intmax(jw, "gid", sd->sd_gid);
+	jw_object_intmax(jw, "size", sd->sd_size);
 	jw_end(jw);
 }
 
diff --git a/json-writer.h b/json-writer.h
index f778e019a2..07d841d52a 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -42,8 +42,10 @@
  * of the given strings.
  */
 
+#include "git-compat-util.h"
 #include "strbuf.h"
 
+struct ewah_bitmap;
 struct stat_data;
 
 struct json_writer
@@ -83,6 +85,7 @@ void jw_object_true(struct json_writer *jw, const char *key);
 void jw_object_false(struct json_writer *jw, const char *key);
 void jw_object_bool(struct json_writer *jw, const char *key, int value);
 void jw_object_null(struct json_writer *jw, const char *key);
+void jw_object_filemode(struct json_writer *jw, const char *key, mode_t value);
 void jw_object_stat_data(struct json_writer *jw, const char *key,
 			 const struct stat_data *sd);
 void jw_object_ewah(struct json_writer *jw, const char *key,
diff --git a/read-cache.c b/read-cache.c
index d7d9ce7260..c26edcc9d9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1693,9 +1693,28 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 	return 0;
 }
 
+static struct index_entry_offset_table *do_read_ieot_extension(struct index_state *, const char *, uint32_t);
 static int read_index_extension(struct index_state *istate,
-				const char *ext, const char *data, unsigned long sz)
+				const char *map,
+				unsigned long *offset)
 {
+	int ret = 0;
+	const char *ext = map + *offset;
+	uint32_t sz = get_be32(ext + 4);
+	const char *data = ext + 8;
+
+	if (istate->jw) {
+		char buf[5];
+
+		memcpy(buf, ext, 4);
+		buf[4] = '\0';
+		jw_object_inline_begin_object(istate->jw, buf);
+
+		jw_object_intmax(istate->jw, "file_offset", *offset);
+		jw_object_intmax(istate->jw, "ext_size", sz);
+	}
+	*offset += sz + 8;
+
 	switch (CACHE_EXT(ext)) {
 	case CACHE_EXT_TREE:
 		istate->cache_tree = cache_tree_read(data, sz, istate->jw);
@@ -1704,8 +1723,7 @@ static int read_index_extension(struct index_state *istate,
 		istate->resolve_undo = resolve_undo_read(data, sz, istate->jw);
 		break;
 	case CACHE_EXT_LINK:
-		if (read_link_extension(istate, data, sz))
-			return -1;
+		ret = read_link_extension(istate, data, sz);
 		break;
 	case CACHE_EXT_UNTRACKED:
 		istate->untracked = read_untracked_extension(data, sz, istate->jw);
@@ -1714,17 +1732,31 @@ static int read_index_extension(struct index_state *istate,
 		read_fsmonitor_extension(istate, data, sz);
 		break;
 	case CACHE_EXT_ENDOFINDEXENTRIES:
-	case CACHE_EXT_INDEXENTRYOFFSETTABLE:
+		if (istate->jw) {
+			/* must be synchronized with read_eoie_extension() */
+			jw_object_intmax(istate->jw, "offset", get_be32(data));
+			jw_object_string(istate->jw, "oid",
+					 hash_to_hex((const unsigned char*)data + sizeof(uint32_t)));
+		}
 		/* already handled in do_read_index() */
 		break;
+	case CACHE_EXT_INDEXENTRYOFFSETTABLE:
+		if (istate->jw) {
+			free(do_read_ieot_extension(istate, data, sz));
+		} else {
+			/* already handled in do_read_index() */
+		}
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
-			return error(_("index uses %.4s extension, which we do not understand"),
+			ret = error(_("index uses %.4s extension, which we do not understand"),
 				     ext);
-		fprintf_ln(stderr, _("ignoring %.4s extension"), ext);
+		else
+			  fprintf_ln(stderr, _("ignoring %.4s extension"), ext);
 		break;
 	}
-	return 0;
+	jw_end_gently(istate->jw);
+	return ret;
 }
 
 static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
@@ -1911,10 +1943,10 @@ struct index_entry_offset_table
 	struct index_entry_offset entries[FLEX_ARRAY];
 };
 
-static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset, struct json_writer *jw);
+static struct index_entry_offset_table *read_ieot_extension(struct index_state *istate, const char *mmap, size_t mmap_size, size_t offset);
 static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_table *ieot);
 
-static size_t read_eoie_extension(const char *mmap, size_t mmap_size, struct json_writer *jw);
+static size_t read_eoie_extension(const char *mmap, size_t mmap_size);
 static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, size_t offset);
 
 struct load_index_extensions
@@ -1930,25 +1962,27 @@ static void *load_index_extensions(void *_data)
 {
 	struct load_index_extensions *p = _data;
 	unsigned long src_offset = p->src_offset;
+	int dump_json = 0;
 
 	while (src_offset <= p->mmap_size - the_hash_algo->rawsz - 8) {
-		/* After an array of active_nr index entries,
+		if (p->istate->jw && !dump_json) {
+			jw_object_inline_begin_object(p->istate->jw, "extensions");
+			dump_json = 1;
+		}
+		/*
+		 * After an array of active_nr index entries,
 		 * there can be arbitrary number of extended
 		 * sections, each of which is prefixed with
 		 * extension name (4-byte) and section length
 		 * in 4-byte network byte order.
 		 */
-		uint32_t extsize = get_be32(p->mmap + src_offset + 4);
-		if (read_index_extension(p->istate,
-					 p->mmap + src_offset,
-					 p->mmap + src_offset + 8,
-					 extsize) < 0) {
+		if (read_index_extension(p->istate, p->mmap, &src_offset) < 0) {
 			munmap((void *)p->mmap, p->mmap_size);
 			die(_("index file corrupt"));
 		}
-		src_offset += 8;
-		src_offset += extsize;
 	}
+	if (dump_json)
+		jw_end(p->istate->jw);
 
 	return NULL;
 }
@@ -1958,7 +1992,6 @@ static void dump_cache_entry(struct index_state *istate,
 			     unsigned long offset,
 			     const struct cache_entry *ce)
 {
-	struct strbuf sb = STRBUF_INIT;
 	struct json_writer *jw = istate->jw;
 
 	jw_array_inline_begin_object(jw);
@@ -1971,28 +2004,28 @@ static void dump_cache_entry(struct index_state *istate,
 
 	jw_object_string(jw, "name", ce->name);
 
-	strbuf_addf(&sb, "%06o", ce->ce_mode);
-	jw_object_string(jw, "mode", sb.buf);
-	strbuf_release(&sb);
+	jw_object_filemode(jw, "mode", ce->ce_mode);
 
 	jw_object_intmax(jw, "flags", ce->ce_flags);
 	/*
 	 * again redundant info, just so you don't have to decode
 	 * flags values manually
 	 */
+	if (ce->ce_flags & CE_EXTENDED)
+		jw_object_true(jw, "extended_flags");
 	if (ce->ce_flags & CE_VALID)
-		jw_object_true(jw, "assume-unchanged");
+		jw_object_true(jw, "assume_unchanged");
 	if (ce->ce_flags & CE_INTENT_TO_ADD)
-		jw_object_true(jw, "intent-to-add");
+		jw_object_true(jw, "intent_to_add");
 	if (ce->ce_flags & CE_SKIP_WORKTREE)
-		jw_object_true(jw, "skip-worktree");
+		jw_object_true(jw, "skip_worktree");
 	if (ce_stage(ce))
 		jw_object_intmax(jw, "stage", ce_stage(ce));
 
 	jw_object_string(jw, "oid", oid_to_hex(&ce->oid));
 
 	jw_object_stat_data(jw, "stat", &ce->ce_stat_data);
-	jw_object_intmax(jw, "file-offset", offset);
+	jw_object_intmax(jw, "file_offset", offset);
 
 	jw_end(jw);
 }
@@ -2232,28 +2265,21 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		nr_threads = 1;
 
 	if (istate->jw) {
-		size_t off;
-
 		jw_object_begin(istate->jw, jw_pretty);
 		jw_object_intmax(istate->jw, "version", istate->version);
 		jw_object_string(istate->jw, "oid", oid_to_hex(&istate->oid));
-		jw_object_intmax(istate->jw, "st_mtime.sec", istate->timestamp.sec);
-		jw_object_intmax(istate->jw, "st_mtime.nsec", istate->timestamp.nsec);
+		jw_object_intmax(istate->jw, "mtime_sec", istate->timestamp.sec);
+		jw_object_intmax(istate->jw, "mtime_nsec", istate->timestamp.nsec);
 
 		/*
 		 * Threading may mess up json writing. This is for
 		 * debugging only, so performance is not a concern.
 		 */
 		nr_threads = 1;
-		/* and dump EOIE/IOET extensions even with threading off */
-		off = read_eoie_extension(mmap, mmap_size, istate->jw);
-		if (off)
-			free(read_ieot_extension(mmap, mmap_size,
-						 off, istate->jw));
 	}
 
 	if (nr_threads > 1) {
-		extension_offset = read_eoie_extension(mmap, mmap_size, NULL);
+		extension_offset = read_eoie_extension(mmap, mmap_size);
 		if (extension_offset) {
 			int err;
 
@@ -2271,7 +2297,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	 * to multi-thread the reading of the cache entries.
 	 */
 	if (extension_offset && nr_threads > 1)
-		ieot = read_ieot_extension(mmap, mmap_size, extension_offset, NULL);
+		ieot = read_ieot_extension(istate, mmap, mmap_size, extension_offset);
 
 	if (ieot) {
 		src_offset += load_cache_entries_threaded(istate, mmap, mmap_size, nr_threads, ieot);
@@ -3511,8 +3537,7 @@ int should_validate_cache_entries(void)
 #define EOIE_SIZE (4 + GIT_SHA1_RAWSZ) /* <4-byte offset> + <20-byte hash> */
 #define EOIE_SIZE_WITH_HEADER (4 + 4 + EOIE_SIZE) /* <4-byte signature> + <4-byte length> + EOIE_SIZE */
 
-static size_t read_eoie_extension(const char *mmap, size_t mmap_size,
-				  struct json_writer *jw)
+static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
 {
 	/*
 	 * The end of index entries (EOIE) extension is guaranteed to be last
@@ -3556,12 +3581,6 @@ static size_t read_eoie_extension(const char *mmap, size_t mmap_size,
 		return 0;
 	index += sizeof(uint32_t);
 
-	if (jw) {
-		jw_object_inline_begin_object(jw, "end-of-index");
-		jw_object_intmax(jw, "offset", offset);
-		jw_object_intmax(jw, "ext-size", extsize);
-		jw_object_inline_begin_array(jw, "extensions");
-	}
 	/*
 	 * The hash is computed over extension types and their sizes (but not
 	 * their contents).  E.g. if we have "TREE" extension that is N-bytes
@@ -3590,24 +3609,9 @@ static size_t read_eoie_extension(const char *mmap, size_t mmap_size,
 
 		the_hash_algo->update_fn(&c, mmap + src_offset, 8);
 
-		if (jw) {
-			char name[5];
-
-			jw_array_inline_begin_object(jw);
-			memcpy(name, mmap + src_offset, 4);
-			name[4] = '\0';
-			jw_object_string(jw, "name",  name);
-			jw_object_intmax(jw, "size", extsize);
-			jw_end(jw);
-		}
-
 		src_offset += 8;
 		src_offset += extsize;
 	}
-	if (jw) {
-		jw_end(jw);	/* extensions */
-		jw_end(jw);	/* end-of-index */
-	}
 	the_hash_algo->final_fn(hash, &c);
 	if (!hasheq(hash, (const unsigned char *)index))
 		return 0;
@@ -3636,13 +3640,12 @@ static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context,
 #define IEOT_VERSION	(1)
 
 static struct index_entry_offset_table *read_ieot_extension(
-	const char *mmap, size_t mmap_size,
-	size_t offset, struct json_writer *jw)
+		struct index_state *istate,
+		const char *mmap, size_t mmap_size,
+		size_t offset)
 {
 	const char *index = NULL;
-	uint32_t extsize, ext_version;
-	struct index_entry_offset_table *ieot;
-	int i, nr;
+	uint32_t extsize;
 
 	/* find the IEOT extension */
 	if (!offset)
@@ -3658,6 +3661,17 @@ static struct index_entry_offset_table *read_ieot_extension(
 	}
 	if (!index)
 		return NULL;
+	return do_read_ieot_extension(istate, index, extsize);
+}
+
+static struct index_entry_offset_table *do_read_ieot_extension(
+		struct index_state *istate,
+		const char *index,
+		uint32_t extsize)
+{
+	uint32_t ext_version;
+	struct index_entry_offset_table *ieot;
+	int i, nr;
 
 	/* validate the version is IEOT_VERSION */
 	ext_version = get_be32(index);
@@ -3673,11 +3687,9 @@ static struct index_entry_offset_table *read_ieot_extension(
 		error("invalid number of IEOT entries %d", nr);
 		return NULL;
 	}
-	if (jw) {
-		jw_object_inline_begin_object(jw, "index-entry-offsets");
-		jw_object_intmax(jw, "version", ext_version);
-		jw_object_intmax(jw, "ext-size", extsize);
-		jw_object_inline_begin_array(jw, "entries");
+	if (istate->jw) {
+		jw_object_intmax(istate->jw, "version", ext_version);
+		jw_object_inline_begin_array(istate->jw, "entries");
 	}
 	ieot = xmalloc(sizeof(struct index_entry_offset_table)
 		       + (nr * sizeof(struct index_entry_offset)));
@@ -3688,17 +3700,14 @@ static struct index_entry_offset_table *read_ieot_extension(
 		ieot->entries[i].nr = get_be32(index);
 		index += sizeof(uint32_t);
 
-		if (jw) {
-			jw_array_inline_begin_object(jw);
-			jw_object_intmax(jw, "offset", ieot->entries[i].offset);
-			jw_object_intmax(jw, "count", ieot->entries[i].nr);
-			jw_end(jw);
+		if (istate->jw) {
+			jw_array_inline_begin_object(istate->jw);
+			jw_object_intmax(istate->jw, "offset", ieot->entries[i].offset);
+			jw_object_intmax(istate->jw, "count", ieot->entries[i].nr);
+			jw_end(istate->jw);
 		}
 	}
-	if (jw) {
-		jw_end(jw);	/* entries */
-		jw_end(jw);	/* index-entry-offsets */
-	}
+	jw_end_gently(istate->jw);
 
 	return ieot;
 }
diff --git a/resolve-undo.c b/resolve-undo.c
index 999020bc40..68921e3dfe 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -50,6 +50,28 @@ void resolve_undo_write(struct strbuf *sb, struct string_list *resolve_undo)
 	}
 }
 
+static void dump_resolve_undo(struct json_writer *jw,
+			      const char *path,
+			      const struct resolve_undo_info *ui)
+{
+	int i;
+
+	if (!jw)
+		return;
+
+	jw_array_inline_begin_object(jw);
+	jw_object_string(jw, "path", path);
+
+	jw_object_inline_begin_array(jw, "stages");
+	for (i = 0; i < 3; i++) {
+		jw_array_inline_begin_object(jw);
+		jw_object_filemode(jw, "mode", ui->mode[i]);
+		jw_object_string(jw, "oid", oid_to_hex(&ui->oid[i]));
+		jw_end(jw);
+	}
+	jw_end(jw);
+}
+
 struct string_list *resolve_undo_read(const char *data, unsigned long size,
 				      struct json_writer *jw)
 {
@@ -61,11 +83,7 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size,
 
 	resolve_undo = xcalloc(1, sizeof(*resolve_undo));
 	resolve_undo->strdup_strings = 1;
-	if (jw) {
-		jw_object_inline_begin_object(jw, "resolve-undo");
-		jw_object_intmax(jw, "ext-size", size);
-		jw_object_inline_begin_array(jw, "entries");
-	}
+	jw_object_inline_begin_array_gently(jw, "entries");
 
 	while (size) {
 		struct string_list_item *lost;
@@ -102,33 +120,9 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size,
 			data += rawsz;
 		}
 
-		if (jw) {
-			struct strbuf sb = STRBUF_INIT;
-
-			jw_array_inline_begin_object(jw);
-			jw_object_string(jw, "path", lost->string);
-
-			jw_object_inline_begin_array(jw, "mode");
-			for (i = 0; i < 3; i++) {
-				strbuf_addf(&sb, "%06o", ui->mode[i]);
-				jw_array_string(jw, sb.buf);
-				strbuf_reset(&sb);
-			}
-			jw_end(jw);
-
-			jw_object_inline_begin_array(jw, "oid");
-			for (i = 0; i < 3; i++)
-				jw_array_string(jw, oid_to_hex(&ui->oid[i]));
-			jw_end(jw);
-
-			jw_end(jw);
-			strbuf_release(&sb);
-		}
-	}
-	if (jw) {
-		jw_end(jw);	/* entries */
-		jw_end(jw);	/* resolve-undo */
+		dump_resolve_undo(jw, lost->string, ui);
 	}
+	jw_end_gently(jw);
 	return resolve_undo;
 
 error:
diff --git a/split-index.c b/split-index.c
index d7b4420c92..41552bf771 100644
--- a/split-index.c
+++ b/split-index.c
@@ -17,7 +17,6 @@ int read_link_extension(struct index_state *istate,
 {
 	const unsigned char *data = data_;
 	struct split_index *si;
-	unsigned long original_sz = sz;
 	int ret;
 
 	if (sz < the_hash_algo->rawsz)
@@ -42,12 +41,9 @@ int read_link_extension(struct index_state *istate,
 		return error("garbage at the end of link extension");
 done:
 	if (istate->jw) {
-		jw_object_inline_begin_object(istate->jw, "split-index");
 		jw_object_string(istate->jw, "oid", oid_to_hex(&si->base_oid));
-		jw_object_ewah(istate->jw, "delete-bitmap", si->delete_bitmap);
-		jw_object_ewah(istate->jw, "replace-bitmap", si->replace_bitmap);
-		jw_object_intmax(istate->jw, "ext-size", original_sz);
-		jw_end(istate->jw);
+		jw_object_ewah(istate->jw, "delete_bitmap", si->delete_bitmap);
+		jw_object_ewah(istate->jw, "replace_bitmap", si->replace_bitmap);
 	}
 	return 0;
 }
diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-lazy-init-name-hash.sh
index 64f047332b..7f918c05f6 100755
--- a/t/t3008-ls-files-lazy-init-name-hash.sh
+++ b/t/t3008-ls-files-lazy-init-name-hash.sh
@@ -4,15 +4,9 @@ test_description='Test the lazy init name hash with various folder structures'
 
 . ./test-lib.sh
 
-if test 1 -eq $($GIT_BUILD_DIR/t/helper/test-tool online-cpus)
-then
-	skip_all='skipping lazy-init tests, single cpu'
-	test_done
-fi
-
 LAZY_THREAD_COST=2000
 
-test_expect_success 'no buffer overflow in lazy_init_name_hash' '
+test_expect_success !SINGLE_CPU 'no buffer overflow in lazy_init_name_hash' '
 	(
 	    test_seq $LAZY_THREAD_COST | sed "s/^/a_/" &&
 	    echo b/b/b &&
diff --git a/t/t3011-ls-files-json.sh b/t/t3011-ls-files-json.sh
new file mode 100755
index 0000000000..9f4ad4c9cf
--- /dev/null
+++ b/t/t3011-ls-files-json.sh
@@ -0,0 +1,106 @@
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
+	git commit -m first &&
+	git update-index --untracked-cache &&
+
+	echo intent-to-add >ita &&
+	git add -N ita &&
+
+	strip_number ctime_sec ctime_nsec mtime_sec mtime_nsec &&
+	strip_number device inode uid gid file_offset ext_size last_update &&
+	strip_string oid ident
+'
+
+test_expect_success 'ls-files --json, main entries, UNTR and TREE' '
+	compare_json basic
+'
+
+test_expect_success 'ls-files --json, split index' '
+	git init split &&
+	(
+		cd split &&
+		echo one >one &&
+		git add one &&
+		git update-index --split-index &&
+		echo updated >>one &&
+		test_must_fail git -c splitIndex.maxPercentChange=100 update-index --refresh &&
+		cp ../filter.sed . &&
+		compare_json split-index
+	)
+'
+
+test_expect_success 'ls-files --json, fsmonitor extension ' '
+	git init fsmonitor &&
+	(
+		cd fsmonitor &&
+		echo one >one &&
+		git add one &&
+		git update-index --fsmonitor &&
+		cp ../filter.sed . &&
+		compare_json fsmonitor
+	)
+'
+
+test_expect_success 'ls-files --json, rerere extension' '
+	git init rerere &&
+	(
+		cd rerere &&
+		mkdir fi &&
+		test_commit initial fi/le first &&
+		git branch side &&
+		test_commit second fi/le second &&
+		git checkout side &&
+		test_commit third fi/le third &&
+		git checkout master &&
+		git config rerere.enabled true &&
+		test_must_fail git merge side &&
+		echo resolved >fi/le &&
+		git add fi/le &&
+		cp ../filter.sed . &&
+		compare_json rerere
+	)
+'
+
+test_expect_success !SINGLE_CPU 'ls-files --json and multicore extensions' '
+	git init eoie &&
+	(
+		cd eoie &&
+		git config index.threads 2 &&
+		touch one two three four &&
+		git add . &&
+		cp ../filter.sed . &&
+		strip_number offset &&
+		compare_json eoie
+	)
+'
+
+test_done
diff --git a/t/t3011/basic b/t/t3011/basic
new file mode 100644
index 0000000000..8e049f5350
--- /dev/null
+++ b/t/t3011/basic
@@ -0,0 +1,124 @@
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
+  ],
+  "extensions": {
+    "TREE": {
+      "file_offset": <number>,
+      "ext_size": <number>,
+      "root": {
+        "oid": null,
+        "subdirs": [
+          {
+            "name": "sub",
+            "oid": <string>,
+            "entry_count": 1,
+            "subdirs": [
+            ]
+          }
+        ]
+      }
+    },
+    "UNTR": {
+      "file_offset": <number>,
+      "ext_size": <number>,
+      "ident": <string>,
+      "info_exclude": {
+        "valid": true,
+        "oid": <string>,
+        "stat": {
+          "ctime_sec": <number>,
+          "ctime_nsec": <number>,
+          "mtime_sec": <number>,
+          "mtime_nsec": <number>,
+          "device": <number>,
+          "inode": <number>,
+          "uid": <number>,
+          "gid": <number>,
+          "size": 0
+        }
+      },
+      "excludes_file": {
+        "valid": true,
+        "oid": <string>,
+        "stat": {
+          "ctime_sec": <number>,
+          "ctime_nsec": <number>,
+          "mtime_sec": <number>,
+          "mtime_nsec": <number>,
+          "device": <number>,
+          "inode": <number>,
+          "uid": <number>,
+          "gid": <number>,
+          "size": 0
+        }
+      },
+      "flags": 6,
+      "show_other_directories": true,
+      "hide_empty_directories": true,
+      "excludes_per_dir": ".gitignore"
+    }
+  }
+}
diff --git a/t/t3011/eoie b/t/t3011/eoie
new file mode 100644
index 0000000000..66a0feb3b6
--- /dev/null
+++ b/t/t3011/eoie
@@ -0,0 +1,107 @@
+{
+  "version": 2,
+  "oid": <string>,
+  "mtime_sec": <number>,
+  "mtime_nsec": <number>,
+  "entries": [
+    {
+      "id": 0,
+      "name": "four",
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
+        "size": 0
+      },
+      "file_offset": <number>
+    },
+    {
+      "id": 2,
+      "name": "three",
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
+        "size": 0
+      },
+      "file_offset": <number>
+    },
+    {
+      "id": 3,
+      "name": "two",
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
+        "size": 0
+      },
+      "file_offset": <number>
+    }
+  ],
+  "extensions": {
+    "IEOT": {
+      "file_offset": <number>,
+      "ext_size": <number>,
+      "version": 1,
+      "entries": [
+        {
+          "offset": <number>,
+          "count": 2
+        },
+        {
+          "offset": <number>,
+          "count": 2
+        }
+      ]
+    },
+    "EOIE": {
+      "file_offset": <number>,
+      "ext_size": <number>,
+      "offset": <number>,
+      "oid": <string>
+    }
+  }
+}
diff --git a/t/t3011/fsmonitor b/t/t3011/fsmonitor
new file mode 100644
index 0000000000..17f2d4a664
--- /dev/null
+++ b/t/t3011/fsmonitor
@@ -0,0 +1,38 @@
+{
+  "version": 2,
+  "oid": <string>,
+  "mtime_sec": <number>,
+  "mtime_nsec": <number>,
+  "entries": [
+    {
+      "id": 0,
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
+    }
+  ],
+  "extensions": {
+    "FSMN": {
+      "file_offset": <number>,
+      "ext_size": <number>,
+      "version": 1,
+      "last_update": <number>,
+      "dirty": [
+        0
+      ]
+    }
+  }
+}
diff --git a/t/t3011/rerere b/t/t3011/rerere
new file mode 100644
index 0000000000..a8ec4b16ee
--- /dev/null
+++ b/t/t3011/rerere
@@ -0,0 +1,66 @@
+{
+  "version": 2,
+  "oid": <string>,
+  "mtime_sec": <number>,
+  "mtime_nsec": <number>,
+  "entries": [
+    {
+      "id": 0,
+      "name": "fi/le",
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
+        "size": 9
+      },
+      "file_offset": <number>
+    }
+  ],
+  "extensions": {
+    "TREE": {
+      "file_offset": <number>,
+      "ext_size": <number>,
+      "root": {
+        "oid": null,
+        "subdirs": [
+          {
+            "name": "fi",
+            "oid": null,
+            "subdirs": [
+            ]
+          }
+        ]
+      }
+    },
+    "REUC": {
+      "file_offset": <number>,
+      "ext_size": <number>,
+      "entries": [
+        {
+          "path": "fi/le",
+          "stages": [
+            {
+              "mode": "100644",
+              "oid": <string>
+            },
+            {
+              "mode": "100644",
+              "oid": <string>
+            },
+            {
+              "mode": "100644",
+              "oid": <string>
+            }
+          ]
+        }
+      ]
+    }
+  }
diff --git a/t/t3011/split-index b/t/t3011/split-index
new file mode 100644
index 0000000000..cdcc4ddded
--- /dev/null
+++ b/t/t3011/split-index
@@ -0,0 +1,39 @@
+{
+  "version": 2,
+  "oid": <string>,
+  "mtime_sec": <number>,
+  "mtime_nsec": <number>,
+  "entries": [
+    {
+      "id": 0,
+      "name": "",
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
+    }
+  ],
+  "extensions": {
+    "link": {
+      "file_offset": <number>,
+      "ext_size": <number>,
+      "oid": <string>,
+      "delete_bitmap": [
+      ],
+      "replace_bitmap": [
+        0
+      ]
+    }
+  }
+}
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4b346467df..9d5b273b40 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1611,3 +1611,7 @@ test_lazy_prereq REBASE_P '
 test_lazy_prereq FAIL_PREREQS '
 	test -n "$GIT_TEST_FAIL_PREREQS"
 '
+
+test_lazy_prereq SINGLE_CPU '
+	test "$(test-tool online-cpus)" -eq 1
+'

Nguyễn Thái Ngọc Duy (10):
  ls-files: add --json to dump the index
  read-cache.c: dump common extension info in json
  cache-tree.c: dump "TREE" extension as json
  dir.c: dump "UNTR" extension as json
  split-index.c: dump "link" extension as json
  fsmonitor.c: dump "FSMN" extension as json
  resolve-undo.c: dump "REUC" extension as json
  read-cache.c: dump "EOIE" extension as json
  read-cache.c: dump "IEOT" extension as json
  t3008: use the new SINGLE_CPU prereq

 Documentation/git-ls-files.txt          |   5 +
 builtin/ls-files.c                      |  38 ++++-
 cache-tree.c                            |  36 ++++-
 cache-tree.h                            |   5 +-
 cache.h                                 |   2 +
 dir.c                                   |  57 +++++++-
 dir.h                                   |   4 +-
 fsmonitor.c                             |   6 +
 json-writer.c                           |  36 +++++
 json-writer.h                           |  32 +++++
 read-cache.c                            | 178 ++++++++++++++++++++----
 resolve-undo.c                          |  30 +++-
 resolve-undo.h                          |   4 +-
 split-index.c                           |   9 +-
 t/t3008-ls-files-lazy-init-name-hash.sh |   8 +-
 t/t3011-ls-files-json.sh (new +x)       | 106 ++++++++++++++
 t/t3011/basic (new)                     | 124 +++++++++++++++++
 t/t3011/eoie (new)                      | 107 ++++++++++++++
 t/t3011/fsmonitor (new)                 |  38 +++++
 t/t3011/rerere (new)                    |  66 +++++++++
 t/t3011/split-index (new)               |  39 ++++++
 t/test-lib.sh                           |   4 +
 22 files changed, 884 insertions(+), 50 deletions(-)
 create mode 100755 t/t3011-ls-files-json.sh
 create mode 100644 t/t3011/basic
 create mode 100644 t/t3011/eoie
 create mode 100644 t/t3011/fsmonitor
 create mode 100644 t/t3011/rerere
 create mode 100644 t/t3011/split-index

-- 
2.22.0.rc0.322.g2b0371e29a

