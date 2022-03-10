Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14053C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 22:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344418AbiCJWof (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239006AbiCJWoe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 17:44:34 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88D1C683F
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:43:31 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so4334489wmb.3
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pOhylVgFye2yLzOGLZc3HYCA4zW3pMSMK67FqSTH73U=;
        b=Ts0d9X03S+gjFFNe8FvMJ2J8tq0zJ8XnbUsABIIgebrIDyLmJIGdlUUPtlaSCqZ5yn
         NIKscWxoaRq2Bi+/vwbTg4e/sdXgdiM2drAV6mcG3AqIsFWob59KkmZ4xNyIH9PO1Hbc
         E8Ma0nvScAHUMbMzkgVtRF8rOhy8PXSPf5ExhM5vpOB3lKXO12bYizIP2y9622EG712z
         njPAG2S40tshNpeuYLVIDBLs136fR4aHkpczDYCX98CFxMx2YCMpt1DV/syOwVAcIlY9
         ehB0dz8qWcgUPoms1LxmbtUdp8Svznmq4fnaycBgrwtpeDgip0tsUVknJg3GndDk1nUU
         1rUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pOhylVgFye2yLzOGLZc3HYCA4zW3pMSMK67FqSTH73U=;
        b=u2hIM/wSCP4ULlK37uj+KyK4hhKFqzME5GZ9zvWK1jSQJhcnw144HKbpTL2S6LdFsI
         +GNA570FX6Zsi9JmkDQKQSddCF2rT02aef7O+yJUUrAxB4uoRP1MakTP/5umfrVDLXz2
         Nq8Z8i7TMHrRzq76dJHynruByAfewVrtue/jlS0QJ+wKhObUPTIvjUjxUF8JGGP7L+Om
         Ln5uj9ywddDz5F4Ci9XwfoIxVULUYVFAyTVlIC95kcJghyC0binQ7oor2NFcqimBbV8G
         2egUq+HmFsCyk/xFTc0sLtXSysJCYgr921T6uKfhXGJ9gNQnAxH6NI39/R61nEb4tUsx
         qutQ==
X-Gm-Message-State: AOAM5315debfnv4GOsEEhuRNWdO8o3bkS1Ne62NsGBE4ZPeMhuqvQjY7
        4CfcemhfHiQdgqYU/oyt85Y3bEeKVT4=
X-Google-Smtp-Source: ABdhPJx0S67EZ4SOC9cqrOqBpK7pvfh0rV17Ts38flZXDHwapwJudluUyZ3II99Y6T0OVD1NwtBIkg==
X-Received: by 2002:a1c:f009:0:b0:387:6fea:8ebc with SMTP id a9-20020a1cf009000000b003876fea8ebcmr13301144wmb.84.1646952209966;
        Thu, 10 Mar 2022 14:43:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2-20020adfe7c2000000b001f04d622e7fsm5039204wrn.39.2022.03.10.14.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:43:29 -0800 (PST)
Message-Id: <64e2bdcdfd92ba643cee52605155c21d116710a7.1646952205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
        <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Mar 2022 22:43:21 +0000
Subject: [PATCH v6 3/6] core.fsync: introduce granular fsync control
 infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

This commit introduces the infrastructure for the core.fsync
configuration knob. The repository components we want to sync
are identified by flags so that we can turn on or off syncing
for specific components.

If core.fsyncObjectFiles is set and the core.fsync configuration
also includes FSYNC_COMPONENT_LOOSE_OBJECT, we will fsync any
loose objects. This picks the strictest data integrity behavior
if core.fsync and core.fsyncObjectFiles are set to conflicting values.

This change introduces the currently unused fsync_component
helper, which will be used by a later patch that adds fsyncing to
the refs backend.

Actual configuration and documentation of the fsync components
list are in other patches in the series to separate review of
the underlying mechanism from the policy of how it's configured.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/fast-import.c  |  2 +-
 builtin/index-pack.c   |  4 ++--
 builtin/pack-objects.c | 24 +++++++++++++++++-------
 bulk-checkin.c         |  5 +++--
 cache.h                | 23 +++++++++++++++++++++++
 commit-graph.c         |  3 ++-
 csum-file.c            |  5 +++--
 csum-file.h            |  3 ++-
 environment.c          |  1 +
 midx.c                 |  3 ++-
 object-file.c          | 13 +++++++++----
 pack-bitmap-write.c    |  3 ++-
 pack-write.c           | 13 +++++++------
 read-cache.c           |  2 +-
 write-or-die.c         | 26 ++++++++++++++++++++++----
 15 files changed, 97 insertions(+), 33 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index b7105fcad9b..f2c036a8955 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -865,7 +865,7 @@ static void end_packfile(void)
 		struct tag *t;
 
 		close_pack_windows(pack_data);
-		finalize_hashfile(pack_file, cur_pack_oid.hash, 0);
+		finalize_hashfile(pack_file, cur_pack_oid.hash, FSYNC_COMPONENT_PACK, 0);
 		fixup_pack_header_footer(pack_data->pack_fd, pack_data->hash,
 					 pack_data->pack_name, object_count,
 					 cur_pack_oid.hash, pack_size);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c45273de3b1..c5f12f14df5 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1290,7 +1290,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 			    nr_objects - nr_objects_initial);
 		stop_progress_msg(&progress, msg.buf);
 		strbuf_release(&msg);
-		finalize_hashfile(f, tail_hash, 0);
+		finalize_hashfile(f, tail_hash, FSYNC_COMPONENT_PACK, 0);
 		hashcpy(read_hash, pack_hash);
 		fixup_pack_header_footer(output_fd, pack_hash,
 					 curr_pack, nr_objects,
@@ -1512,7 +1512,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	if (!from_stdin) {
 		close(input_fd);
 	} else {
-		fsync_or_die(output_fd, curr_pack_name);
+		fsync_component_or_die(FSYNC_COMPONENT_PACK, output_fd, curr_pack_name);
 		err = close(output_fd);
 		if (err)
 			die_errno(_("error while closing pack file"));
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 178e611f09d..c14fee8e99f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1199,16 +1199,26 @@ static void write_pack_file(void)
 			display_progress(progress_state, written);
 		}
 
-		/*
-		 * Did we write the wrong # entries in the header?
-		 * If so, rewrite it like in fast-import
-		 */
 		if (pack_to_stdout) {
-			finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM | CSUM_CLOSE);
+			/*
+			 * We never fsync when writing to stdout since we may
+			 * not be writing to an actual pack file. For instance,
+			 * the upload-pack code passes a pipe here. Calling
+			 * fsync on a pipe results in unnecessary
+			 * synchronization with the reader on some platforms.
+			 */
+			finalize_hashfile(f, hash, FSYNC_COMPONENT_NONE,
+					  CSUM_HASH_IN_STREAM | CSUM_CLOSE);
 		} else if (nr_written == nr_remaining) {
-			finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
+			finalize_hashfile(f, hash, FSYNC_COMPONENT_PACK,
+					  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 		} else {
-			int fd = finalize_hashfile(f, hash, 0);
+			/*
+			 * If we wrote the wrong number of entries in the
+			 * header, rewrite it like in fast-import.
+			 */
+
+			int fd = finalize_hashfile(f, hash, FSYNC_COMPONENT_PACK, 0);
 			fixup_pack_header_footer(fd, hash, pack_tmp_name,
 						 nr_written, hash, offset);
 			close(fd);
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 8785b2ac806..a2cf9dcbc8d 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -53,9 +53,10 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 		unlink(state->pack_tmp_name);
 		goto clear_exit;
 	} else if (state->nr_written == 1) {
-		finalize_hashfile(state->f, hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
+		finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK,
+				  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 	} else {
-		int fd = finalize_hashfile(state->f, hash, 0);
+		int fd = finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK, 0);
 		fixup_pack_header_footer(fd, hash, state->pack_tmp_name,
 					 state->nr_written, hash,
 					 state->offset);
diff --git a/cache.h b/cache.h
index 82f0194a3dd..7ac1959258d 100644
--- a/cache.h
+++ b/cache.h
@@ -993,6 +993,27 @@ void reset_shared_repository(void);
 extern int read_replace_refs;
 extern char *git_replace_ref_base;
 
+/*
+ * These values are used to help identify parts of a repository to fsync.
+ * FSYNC_COMPONENT_NONE identifies data that will not be a persistent part of the
+ * repository and so shouldn't be fsynced.
+ */
+enum fsync_component {
+	FSYNC_COMPONENT_NONE,
+	FSYNC_COMPONENT_LOOSE_OBJECT		= 1 << 0,
+	FSYNC_COMPONENT_PACK			= 1 << 1,
+	FSYNC_COMPONENT_PACK_METADATA		= 1 << 2,
+	FSYNC_COMPONENT_COMMIT_GRAPH		= 1 << 3,
+};
+
+#define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENT_PACK | \
+				  FSYNC_COMPONENT_PACK_METADATA | \
+				  FSYNC_COMPONENT_COMMIT_GRAPH)
+
+/*
+ * A bitmask indicating which components of the repo should be fsynced.
+ */
+extern enum fsync_component fsync_components;
 extern int fsync_object_files;
 extern int use_fsync;
 
@@ -1707,6 +1728,8 @@ int copy_file_with_time(const char *dst, const char *src, int mode);
 
 void write_or_die(int fd, const void *buf, size_t count);
 void fsync_or_die(int fd, const char *);
+int fsync_component(enum fsync_component component, int fd);
+void fsync_component_or_die(enum fsync_component component, int fd, const char *msg);
 
 ssize_t read_in_full(int fd, void *buf, size_t count);
 ssize_t write_in_full(int fd, const void *buf, size_t count);
diff --git a/commit-graph.c b/commit-graph.c
index 265c010122e..64897f57d9f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1942,7 +1942,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 
 	close_commit_graph(ctx->r->objects);
-	finalize_hashfile(f, file_hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
+	finalize_hashfile(f, file_hash, FSYNC_COMPONENT_COMMIT_GRAPH,
+			  CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	free_chunkfile(cf);
 
 	if (ctx->split) {
diff --git a/csum-file.c b/csum-file.c
index 26e8a6df44e..59ef3398ca2 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -58,7 +58,8 @@ static void free_hashfile(struct hashfile *f)
 	free(f);
 }
 
-int finalize_hashfile(struct hashfile *f, unsigned char *result, unsigned int flags)
+int finalize_hashfile(struct hashfile *f, unsigned char *result,
+		      enum fsync_component component, unsigned int flags)
 {
 	int fd;
 
@@ -69,7 +70,7 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result, unsigned int fl
 	if (flags & CSUM_HASH_IN_STREAM)
 		flush(f, f->buffer, the_hash_algo->rawsz);
 	if (flags & CSUM_FSYNC)
-		fsync_or_die(f->fd, f->name);
+		fsync_component_or_die(component, f->fd, f->name);
 	if (flags & CSUM_CLOSE) {
 		if (close(f->fd))
 			die_errno("%s: sha1 file error on close", f->name);
diff --git a/csum-file.h b/csum-file.h
index 291215b34eb..0d29f528fbc 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -1,6 +1,7 @@
 #ifndef CSUM_FILE_H
 #define CSUM_FILE_H
 
+#include "cache.h"
 #include "hash.h"
 
 struct progress;
@@ -38,7 +39,7 @@ int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
 struct hashfile *hashfd(int fd, const char *name);
 struct hashfile *hashfd_check(const char *name);
 struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp);
-int finalize_hashfile(struct hashfile *, unsigned char *, unsigned int);
+int finalize_hashfile(struct hashfile *, unsigned char *, enum fsync_component, unsigned int);
 void hashwrite(struct hashfile *, const void *, unsigned int);
 void hashflush(struct hashfile *f);
 void crc32_begin(struct hashfile *);
diff --git a/environment.c b/environment.c
index 3e3620d759f..36ca5fb2e77 100644
--- a/environment.c
+++ b/environment.c
@@ -45,6 +45,7 @@ int pack_compression_level = Z_DEFAULT_COMPRESSION;
 int fsync_object_files;
 int use_fsync = -1;
 enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
+enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
diff --git a/midx.c b/midx.c
index 865170bad05..107365d2114 100644
--- a/midx.c
+++ b/midx.c
@@ -1438,7 +1438,8 @@ static int write_midx_internal(const char *object_dir,
 	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
 	write_chunkfile(cf, &ctx);
 
-	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
+	finalize_hashfile(f, midx_hash, FSYNC_COMPONENT_PACK_METADATA,
+			  CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	free_chunkfile(cf);
 
 	if (flags & MIDX_WRITE_REV_INDEX &&
diff --git a/object-file.c b/object-file.c
index 03bd6a3baf3..e3f0bf27ff1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1849,11 +1849,16 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 /* Finalize a file on disk, and close it. */
 static void close_loose_object(int fd)
 {
-	if (!the_repository->objects->odb->will_destroy) {
-		if (fsync_object_files)
-			fsync_or_die(fd, "loose object file");
-	}
+	if (the_repository->objects->odb->will_destroy)
+		goto out;
 
+	if (fsync_object_files > 0)
+		fsync_or_die(fd, "loose object file");
+	else
+		fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd,
+				       "loose object file");
+
+out:
 	if (close(fd) != 0)
 		die_errno(_("error when closing loose object file"));
 }
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index cab3eaa2acd..cf681547f2e 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -719,7 +719,8 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
 
-	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
+	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
+			  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 
 	if (adjust_shared_perm(tmp_file.buf))
 		die_errno("unable to make temporary bitmap file readable");
diff --git a/pack-write.c b/pack-write.c
index a5846f3a346..51812cb1299 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -159,9 +159,9 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	}
 
 	hashwrite(f, sha1, the_hash_algo->rawsz);
-	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_CLOSE |
-				    ((opts->flags & WRITE_IDX_VERIFY)
-				    ? 0 : CSUM_FSYNC));
+	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
+			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
+			  ((opts->flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
 	return index_name;
 }
 
@@ -281,8 +281,9 @@ const char *write_rev_file_order(const char *rev_name,
 	if (rev_name && adjust_shared_perm(rev_name) < 0)
 		die(_("failed to make %s readable"), rev_name);
 
-	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_CLOSE |
-				    ((flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
+	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
+			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
+			  ((flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
 
 	return rev_name;
 }
@@ -390,7 +391,7 @@ void fixup_pack_header_footer(int pack_fd,
 		the_hash_algo->final_fn(partial_pack_hash, &old_hash_ctx);
 	the_hash_algo->final_fn(new_pack_hash, &new_hash_ctx);
 	write_or_die(pack_fd, new_pack_hash, the_hash_algo->rawsz);
-	fsync_or_die(pack_fd, pack_name);
+	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
 }
 
 char *index_pack_lockfile(int ip_out, int *is_well_formed)
diff --git a/read-cache.c b/read-cache.c
index 79b9b99ebf7..df869691fd4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3089,7 +3089,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			return -1;
 	}
 
-	finalize_hashfile(f, istate->oid.hash, CSUM_HASH_IN_STREAM);
+	finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_NONE, CSUM_HASH_IN_STREAM);
 	if (close_tempfile_gently(tempfile)) {
 		error(_("could not close '%s'"), get_tempfile_path(tempfile));
 		return -1;
diff --git a/write-or-die.c b/write-or-die.c
index 9faa5f9f563..c4fd91b5b43 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -56,21 +56,39 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
 	}
 }
 
-void fsync_or_die(int fd, const char *msg)
+static int maybe_fsync(int fd)
 {
 	if (use_fsync < 0)
 		use_fsync = git_env_bool("GIT_TEST_FSYNC", 1);
 	if (!use_fsync)
-		return;
+		return 0;
 
 	if (fsync_method == FSYNC_METHOD_WRITEOUT_ONLY &&
 	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0)
-		return;
+		return 0;
+
+	return git_fsync(fd, FSYNC_HARDWARE_FLUSH);
+}
 
-	if (git_fsync(fd, FSYNC_HARDWARE_FLUSH) < 0)
+void fsync_or_die(int fd, const char *msg)
+{
+	if (maybe_fsync(fd) < 0)
 		die_errno("fsync error on '%s'", msg);
 }
 
+int fsync_component(enum fsync_component component, int fd)
+{
+	if (fsync_components & component)
+		return maybe_fsync(fd);
+	return 0;
+}
+
+void fsync_component_or_die(enum fsync_component component, int fd, const char *msg)
+{
+	if (fsync_components & component)
+		fsync_or_die(fd, msg);
+}
+
 void write_or_die(int fd, const void *buf, size_t count)
 {
 	if (write_in_full(fd, buf, count) < 0) {
-- 
gitgitgadget

