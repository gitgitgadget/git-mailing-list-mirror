Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A806C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 11:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJMLgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 07:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiJMLgK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 07:36:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B0012741C
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 04:36:06 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f11so2365110wrm.6
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 04:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRbv52C45V7OP2HvSk7SXAB8BqB4lUqfNoN7ynfML6Y=;
        b=R72uh5ympPCB4Wh3l6vXpf1SJjMaIuDcPl5CFubvBzMYoisSYOObaNRN17s+htObzS
         eux6RfYad8x8tqLadkijUuEEiHvgSINMYxolVLPhrzBbWHbt8n3mRnNi6VYIBfP8fxlT
         bQnveGa0gIaj14d/SESpP13PHK5ennUXXrE44NJAr3oT8qV3Z8KGoBuXICfo2QSOH0u8
         yszQU4Gmrl3FF+1XWobLQev0EmgVH+255mxhjX59/olQe5wb6IsnR00JtJWlYf/CpkQU
         eRrobdmXOOdSG9vYZoqtvIPoM6nEqC9R+TfGKw4o/gxv1JknVZN6aPU1V+IbdSQcv5nn
         m6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRbv52C45V7OP2HvSk7SXAB8BqB4lUqfNoN7ynfML6Y=;
        b=wMFESNINdWN04/JcLcHSTleov7OzRE/7fkcrk7P7id8WzBFEo0mwCvcss95DbkRSOu
         7mAd3CuEIM6FUvHdlFbNr5Jg1/J1mCm5zblEnbJ4B7YSeB4GU5FCAd/ojkD+qWvSmRXt
         ZODsHqVug8i9s2fFTx5gKC+a2lOEHM9R0FP3Zx3gGLJY8pzxLpFTzE9UGClzOQYeBKMF
         h29Ckx1gKa65QbOxAHao3vgohBXk1xbxJzw2l/P0PBVsFvP7nh2enKw2m6TfSum3EKGx
         wjOAM/ZLdHXxWMS6GKDrB2j4bNt0x+yXCijZZnWEEay0pAA099kDGswI6JXt+Ylt3g+q
         +7og==
X-Gm-Message-State: ACrzQf1OtVsfqLYCm2SfTPf/T8jkks3EN0f0uoHzaJaQcYNUEQdjMhJd
        3/MeTziOI0Do++ilc6+YUF+SaN11c8s=
X-Google-Smtp-Source: AMsMyM4TufmT18BHv2HhAyhFO4sGpKXXRiBxXeKQb/5SLUtcBYSH0lkwRozugUBLSCaBU5ME1Q49Tw==
X-Received: by 2002:adf:f5c5:0:b0:22e:264b:2179 with SMTP id k5-20020adff5c5000000b0022e264b2179mr20299955wrp.386.1665660964767;
        Thu, 13 Oct 2022 04:36:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bz3-20020a056000090300b0022cdeba3f83sm1819731wrb.84.2022.10.13.04.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 04:36:03 -0700 (PDT)
Message-Id: <41664a59029e2492079bef3d3da10f44d315064b.1665660960.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
References: <pull.1359.git.git.1665597148042.gitgitgadget@gmail.com>
        <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
From:   "Alphadelta14 via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 11:35:59 +0000
Subject: [PATCH v2 1/2] archive: add --recurse-submodules to git-archive
 command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heather Lapointe <alpha@alphaservcomputing.solutions>,
        Alphadelta14 <alpha@alphaservcomputing.solutions>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alphadelta14 <alpha@alphaservcomputing.solutions>

This makes it possible to include submodule contents in an archive command.

This required updating the general read_tree callbacks to support sub-repos
by not using the_repository global references where possible.

archive: update streaming to use target repo
archive: add test cases for git archive --recurse-submodules

Signed-off-by: Heather Lapointe <alpha@alphaservcomputing.solutions>
---
 archive-tar.c                 | 14 +++--
 archive-zip.c                 | 14 ++---
 archive.c                     | 99 ++++++++++++++++++++++++-----------
 archive.h                     |  8 +--
 builtin/checkout.c            |  2 +-
 builtin/log.c                 |  2 +-
 builtin/ls-files.c            | 10 ++--
 builtin/ls-tree.c             | 16 +++---
 list-objects.c                |  2 +-
 merge-recursive.c             |  2 +-
 revision.c                    |  4 +-
 sparse-index.c                |  2 +-
 t/t5005-archive-submodules.sh | 84 +++++++++++++++++++++++++++++
 tree.c                        | 64 ++++++++++++++--------
 tree.h                        | 11 ++--
 wt-status.c                   |  2 +-
 16 files changed, 246 insertions(+), 90 deletions(-)
 create mode 100755 t/t5005-archive-submodules.sh

diff --git a/archive-tar.c b/archive-tar.c
index 3e4822b6840..331fc10bca9 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -18,6 +18,7 @@ static unsigned long offset;
 static int tar_umask = 002;
 
 static int write_tar_filter_archive(const struct archiver *ar,
+				    struct repository *repo,
 				    struct archiver_args *args);
 
 /*
@@ -246,7 +247,8 @@ static void write_extended_header(struct archiver_args *args,
 	write_blocked(buffer, size);
 }
 
-static int write_tar_entry(struct archiver_args *args,
+static int write_tar_entry(struct repository *repo,
+			   struct archiver_args *args,
 			   const struct object_id *oid,
 			   const char *path, size_t pathlen,
 			   unsigned int mode,
@@ -316,7 +318,7 @@ static int write_tar_entry(struct archiver_args *args,
 		if (buffer)
 			write_blocked(buffer, size);
 		else
-			err = stream_blocked(args->repo, oid);
+			err = stream_blocked(repo, oid);
 	}
 	return err;
 }
@@ -422,12 +424,13 @@ static int git_tar_config(const char *var, const char *value, void *cb)
 }
 
 static int write_tar_archive(const struct archiver *ar UNUSED,
+			     struct repository *repo,
 			     struct archiver_args *args)
 {
 	int err = 0;
 
 	write_global_extended_header(args);
-	err = write_archive_entries(args, write_tar_entry);
+	err = write_archive_entries(repo, args, write_tar_entry);
 	if (!err)
 		write_trailer();
 	return err;
@@ -462,6 +465,7 @@ static void tgz_write_block(const void *data)
 static const char internal_gzip_command[] = "git archive gzip";
 
 static int write_tar_filter_archive(const struct archiver *ar,
+				    struct repository *repo,
 				    struct archiver_args *args)
 {
 #if ZLIB_VERNUM >= 0x1221
@@ -484,7 +488,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
 		gzstream.next_out = outbuf;
 		gzstream.avail_out = sizeof(outbuf);
 
-		r = write_tar_archive(ar, args);
+		r = write_tar_archive(ar, repo, args);
 
 		tgz_deflate(Z_FINISH);
 		git_deflate_end(&gzstream);
@@ -506,7 +510,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
 		die_errno(_("unable to redirect descriptor"));
 	close(filter.in);
 
-	r = write_tar_archive(ar, args);
+	r = write_tar_archive(ar, repo, args);
 
 	close(1);
 	if (finish_command(&filter) != 0)
diff --git a/archive-zip.c b/archive-zip.c
index 0456f1ebf15..6b27d004b5d 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -283,7 +283,8 @@ static int entry_is_binary(struct index_state *istate, const char *path,
 
 #define STREAM_BUFFER_SIZE (1024 * 16)
 
-static int write_zip_entry(struct archiver_args *args,
+static int write_zip_entry(struct repository *repo,
+			   struct archiver_args *args,
 			   const struct object_id *oid,
 			   const char *path, size_t pathlen,
 			   unsigned int mode,
@@ -340,7 +341,7 @@ static int write_zip_entry(struct archiver_args *args,
 
 		if (!buffer) {
 			enum object_type type;
-			stream = open_istream(args->repo, oid, &type, &size,
+			stream = open_istream(repo, oid, &type, &size,
 					      NULL);
 			if (!stream)
 				return error(_("cannot stream blob %s"),
@@ -349,7 +350,7 @@ static int write_zip_entry(struct archiver_args *args,
 			out = NULL;
 		} else {
 			crc = crc32(crc, buffer, size);
-			is_binary = entry_is_binary(args->repo->index,
+			is_binary = entry_is_binary(repo->index,
 						    path_without_prefix,
 						    buffer, size);
 			out = buffer;
@@ -426,7 +427,7 @@ static int write_zip_entry(struct archiver_args *args,
 				break;
 			crc = crc32(crc, buf, readlen);
 			if (is_binary == -1)
-				is_binary = entry_is_binary(args->repo->index,
+				is_binary = entry_is_binary(repo->index,
 							    path_without_prefix,
 							    buf, readlen);
 			write_or_die(1, buf, readlen);
@@ -459,7 +460,7 @@ static int write_zip_entry(struct archiver_args *args,
 				break;
 			crc = crc32(crc, buf, readlen);
 			if (is_binary == -1)
-				is_binary = entry_is_binary(args->repo->index,
+				is_binary = entry_is_binary(repo->index,
 							    path_without_prefix,
 							    buf, readlen);
 
@@ -619,6 +620,7 @@ static int archive_zip_config(const char *var, const char *value,
 }
 
 static int write_zip_archive(const struct archiver *ar UNUSED,
+			     struct repository *repo,
 			     struct archiver_args *args)
 {
 	int err;
@@ -629,7 +631,7 @@ static int write_zip_archive(const struct archiver *ar UNUSED,
 
 	strbuf_init(&zip_dir, 0);
 
-	err = write_archive_entries(args, write_zip_entry);
+	err = write_archive_entries(repo, args, write_zip_entry);
 	if (!err)
 		write_zip_trailer(args->commit_oid);
 
diff --git a/archive.c b/archive.c
index 61a79e4a227..2ee7205679d 100644
--- a/archive.c
+++ b/archive.c
@@ -10,6 +10,7 @@
 #include "unpack-trees.h"
 #include "dir.h"
 #include "quote.h"
+#include "submodule.h"
 
 static char const * const archive_usage[] = {
 	N_("git archive [<options>] <tree-ish> [<path>...]"),
@@ -69,6 +70,7 @@ static void format_subst(const struct commit *commit,
 }
 
 static void *object_file_to_archive(const struct archiver_args *args,
+				    struct repository *repo,
 				    const char *path,
 				    const struct object_id *oid,
 				    unsigned int mode,
@@ -84,13 +86,13 @@ static void *object_file_to_archive(const struct archiver_args *args,
 			       (args->tree ? &args->tree->object.oid : NULL), oid);
 
 	path += args->baselen;
-	buffer = read_object_file(oid, type, sizep);
+	buffer = repo_read_object_file(repo, oid, type, sizep);
 	if (buffer && S_ISREG(mode)) {
 		struct strbuf buf = STRBUF_INIT;
 		size_t size = 0;
 
 		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
-		convert_to_working_tree(args->repo->index, path, buf.buf, buf.len, &buf, &meta);
+		convert_to_working_tree(repo->index, path, buf.buf, buf.len, &buf, &meta);
 		if (commit)
 			format_subst(commit, buf.buf, buf.len, &buf, args->pretty_ctx);
 		buffer = strbuf_detach(&buf, &size);
@@ -134,7 +136,7 @@ static int check_attr_export_subst(const struct attr_check *check)
 	return check && ATTR_TRUE(check->items[1].value);
 }
 
-static int write_archive_entry(const struct object_id *oid, const char *base,
+static int write_archive_entry(struct repository *repo, const struct object_id *oid, const char *base,
 		int baselen, const char *filename, unsigned mode,
 		void *context)
 {
@@ -160,7 +162,7 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
 
 	if (!S_ISDIR(mode)) {
 		const struct attr_check *check;
-		check = get_archive_attrs(args->repo->index, path_without_prefix);
+		check = get_archive_attrs(repo->index, path_without_prefix);
 		if (check_attr_export_ignore(check))
 			return 0;
 		args->convert = check_attr_export_subst(check);
@@ -169,10 +171,10 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
-		err = write_entry(args, oid, path.buf, path.len, mode, NULL, 0);
+		err = write_entry(repo, args, oid, path.buf, path.len, mode, NULL, 0);
 		if (err)
 			return err;
-		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
+		return READ_TREE_RECURSIVE;
 	}
 
 	if (args->verbose)
@@ -180,14 +182,19 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
 
 	/* Stream it? */
 	if (S_ISREG(mode) && !args->convert &&
-	    oid_object_info(args->repo, oid, &size) == OBJ_BLOB &&
-	    size > big_file_threshold)
-		return write_entry(args, oid, path.buf, path.len, mode, NULL, size);
+	    oid_object_info(repo, oid, &size) == OBJ_BLOB &&
+	    size > big_file_threshold) {
+			err = write_entry(repo, args, oid, path.buf, path.len, mode, NULL, size);
+			if (err) {
+				die("Failed to write file %.*s", (int)path.len, path.buf);
+			}
+			return err;
+		}
 
-	buffer = object_file_to_archive(args, path.buf, oid, mode, &type, &size);
+	buffer = object_file_to_archive(args, repo, path.buf, oid, mode, &type, &size);
 	if (!buffer)
 		return error(_("cannot read '%s'"), oid_to_hex(oid));
-	err = write_entry(args, oid, path.buf, path.len, mode, buffer, size);
+	err = write_entry(repo, args, oid, path.buf, path.len, mode, buffer, size);
 	free(buffer);
 	return err;
 }
@@ -207,7 +214,25 @@ static void queue_directory(const struct object_id *oid,
 	oidcpy(&d->oid, oid);
 }
 
-static int write_directory(struct archiver_context *c)
+static void queue_submodule(struct repository *superproject,
+		const struct object_id *oid,
+		struct strbuf *base, const char *filename,
+		unsigned mode, struct archiver_context *c)
+{
+	struct repository subrepo;
+
+	if (repo_submodule_init(&subrepo, superproject, filename, null_oid()))
+		return;
+
+	if (repo_read_index(&subrepo) < 0)
+		die("index file corrupt");
+
+    queue_directory(oid, base, filename, mode, c);
+
+	repo_clear(&subrepo);
+}
+
+static int write_directory(struct repository *repo, struct archiver_context *c)
 {
 	struct directory *d = c->bottom;
 	int ret;
@@ -217,15 +242,18 @@ static int write_directory(struct archiver_context *c)
 	c->bottom = d->up;
 	d->path[d->len - 1] = '\0'; /* no trailing slash */
 	ret =
-		write_directory(c) ||
-		write_archive_entry(&d->oid, d->path, d->baselen,
+		write_directory(repo, c) ||
+		write_archive_entry(repo, &d->oid, d->path, d->baselen,
 				    d->path + d->baselen, d->mode,
-				    c) != READ_TREE_RECURSIVE;
+				    c);
 	free(d);
-	return ret ? -1 : 0;
+	if (ret == READ_TREE_RECURSIVE)
+		return 0;
+	return ret;
 }
 
-static int queue_or_write_archive_entry(const struct object_id *oid,
+static int queue_or_write_archive_entry(
+		struct repository *repo, const struct object_id *oid,
 		struct strbuf *base, const char *filename,
 		unsigned mode, void *context)
 {
@@ -246,18 +274,23 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
 		/* Borrow base, but restore its original value when done. */
 		strbuf_addstr(base, filename);
 		strbuf_addch(base, '/');
-		check = get_archive_attrs(c->args->repo->index, base->buf);
+		check = get_archive_attrs(repo->index, base->buf);
 		strbuf_setlen(base, baselen);
 
 		if (check_attr_export_ignore(check))
 			return 0;
 		queue_directory(oid, base, filename, mode, c);
 		return READ_TREE_RECURSIVE;
+	} else if (c->args->recurse_submodules && S_ISGITLINK(mode)) {
+		if (is_submodule_active(repo, filename)) {
+			queue_submodule(repo, oid, base, filename, mode, c);
+			return READ_TREE_RECURSIVE;
+		}
 	}
 
-	if (write_directory(c))
+	if (write_directory(repo, c))
 		return -1;
-	return write_archive_entry(oid, base->buf, base->len, filename, mode,
+	return write_archive_entry(repo, oid, base->buf, base->len, filename, mode,
 				   context);
 }
 
@@ -267,7 +300,8 @@ struct extra_file_info {
 	void *content;
 };
 
-int write_archive_entries(struct archiver_args *args,
+int write_archive_entries(struct repository *repo,
+		struct archiver_args *args,
 		write_archive_entry_fn_t write_entry)
 {
 	struct archiver_context context;
@@ -288,7 +322,7 @@ int write_archive_entries(struct archiver_args *args,
 			len--;
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)len, args->base);
-		err = write_entry(args, &args->tree->object.oid, args->base,
+		err = write_entry(repo, args, &args->tree->object.oid, args->base,
 				  len, 040777, NULL, 0);
 		if (err)
 			return err;
@@ -305,8 +339,8 @@ int write_archive_entries(struct archiver_args *args,
 		memset(&opts, 0, sizeof(opts));
 		opts.index_only = 1;
 		opts.head_idx = -1;
-		opts.src_index = args->repo->index;
-		opts.dst_index = args->repo->index;
+		opts.src_index = repo->index;
+		opts.dst_index = repo->index;
 		opts.fn = oneway_merge;
 		init_tree_desc(&t, args->tree->buffer, args->tree->size);
 		if (unpack_trees(1, &t, &opts))
@@ -314,7 +348,7 @@ int write_archive_entries(struct archiver_args *args,
 		git_attr_set_direction(GIT_ATTR_INDEX);
 	}
 
-	err = read_tree(args->repo, args->tree,
+	err = read_tree(repo, args->tree,
 			&args->pathspec,
 			queue_or_write_archive_entry,
 			&context);
@@ -343,12 +377,12 @@ int write_archive_entries(struct archiver_args *args,
 			if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
 				err = error_errno(_("cannot read '%s'"), path);
 			else
-				err = write_entry(args, &fake_oid, path_in_archive.buf,
+				err = write_entry(repo, args, &fake_oid, path_in_archive.buf,
 						  path_in_archive.len,
 						  canon_mode(info->stat.st_mode),
 						  content.buf, content.len);
 		} else {
-			err = write_entry(args, &fake_oid,
+			err = write_entry(repo, args, &fake_oid,
 					  path, strlen(path),
 					  canon_mode(info->stat.st_mode),
 					  info->content, info->stat.st_size);
@@ -382,7 +416,7 @@ struct path_exists_context {
 	struct archiver_args *args;
 };
 
-static int reject_entry(const struct object_id *oid UNUSED,
+static int reject_entry(struct repository *repo, const struct object_id *oid UNUSED,
 			struct strbuf *base,
 			const char *filename, unsigned mode,
 			void *context)
@@ -394,7 +428,7 @@ static int reject_entry(const struct object_id *oid UNUSED,
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addbuf(&sb, base);
 		strbuf_addstr(&sb, filename);
-		if (!match_pathspec(ctx->args->repo->index,
+		if (!match_pathspec(repo->index,
 				    &ctx->pathspec,
 				    sb.buf, sb.len, 0, NULL, 1))
 			ret = READ_TREE_RECURSIVE;
@@ -431,6 +465,7 @@ static void parse_pathspec_arg(const char **pathspec,
 		       PATHSPEC_PREFER_FULL,
 		       "", pathspec);
 	ar_args->pathspec.recursive = 1;
+	ar_args->pathspec.recurse_submodules = ar_args->recurse_submodules;
 	if (pathspec) {
 		while (*pathspec) {
 			if (**pathspec && !path_exists(ar_args, *pathspec))
@@ -592,6 +627,7 @@ static int parse_archive_args(int argc, const char **argv,
 	int verbose = 0;
 	int i;
 	int list = 0;
+	int recurse_submodules = 0;
 	int worktree_attributes = 0;
 	struct option opts[] = {
 		OPT_GROUP(""),
@@ -606,6 +642,8 @@ static int parse_archive_args(int argc, const char **argv,
 		  add_file_cb, (intptr_t)&base },
 		OPT_STRING('o', "output", &output, N_("file"),
 			N_("write the archive to this file")),
+		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
+			N_("include submodules in archive")),
 		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
 			N_("read .gitattributes in working directory")),
 		OPT__VERBOSE(&verbose, N_("report archived files on stderr")),
@@ -670,6 +708,7 @@ static int parse_archive_args(int argc, const char **argv,
 	args->base = base;
 	args->baselen = strlen(base);
 	args->worktree_attributes = worktree_attributes;
+	args->recurse_submodules = recurse_submodules;
 
 	return argc;
 }
@@ -708,7 +747,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	parse_treeish_arg(argv, &args, prefix, remote);
 	parse_pathspec_arg(argv + 1, &args);
 
-	rc = ar->write_archive(ar, &args);
+	rc = ar->write_archive(ar, repo, &args);
 
 	string_list_clear_func(&args.extra_files, extra_file_info_clear);
 	free(args.refname);
diff --git a/archive.h b/archive.h
index 08bed3ed3af..91b318f9ad8 100644
--- a/archive.h
+++ b/archive.h
@@ -19,6 +19,7 @@ struct archiver_args {
 	timestamp_t time;
 	struct pathspec pathspec;
 	unsigned int verbose : 1;
+	unsigned int recurse_submodules : 1;
 	unsigned int worktree_attributes : 1;
 	unsigned int convert : 1;
 	int compression_level;
@@ -41,7 +42,7 @@ const char *archive_format_from_filename(const char *filename);
 #define ARCHIVER_HIGH_COMPRESSION_LEVELS 4
 struct archiver {
 	const char *name;
-	int (*write_archive)(const struct archiver *, struct archiver_args *);
+	int (*write_archive)(const struct archiver *, struct repository *repo, struct archiver_args *);
 	unsigned flags;
 	char *filter_command;
 };
@@ -51,12 +52,13 @@ void init_tar_archiver(void);
 void init_zip_archiver(void);
 void init_archivers(void);
 
-typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
+typedef int (*write_archive_entry_fn_t)(struct repository *repo,
+					struct archiver_args *args,
 					const struct object_id *oid,
 					const char *path, size_t pathlen,
 					unsigned int mode,
 					void *buffer, unsigned long size);
 
-int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
+int write_archive_entries(struct repository *repo, struct archiver_args *args, write_archive_entry_fn_t write_entry);
 
 #endif	/* ARCHIVE_H */
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2a132392fbe..1238774b245 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -124,7 +124,7 @@ static int post_checkout_hook(struct commit *old_commit, struct commit *new_comm
 
 }
 
-static int update_some(const struct object_id *oid, struct strbuf *base,
+static int update_some(struct repository *repo UNUSED, const struct object_id *oid, struct strbuf *base,
 		       const char *pathname, unsigned mode, void *context UNUSED)
 {
 	int len;
diff --git a/builtin/log.c b/builtin/log.c
index ee19dc5d450..da73bbef836 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -698,7 +698,7 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 	return 0;
 }
 
-static int show_tree_object(const struct object_id *oid UNUSED,
+static int show_tree_object(struct repository *repo UNUSED, const struct object_id *oid UNUSED,
 			    struct strbuf *base UNUSED,
 			    const char *pathname, unsigned mode,
 			    void *context)
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 4cf8a236483..a08768dbd2a 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -509,7 +509,7 @@ static int get_common_prefix_len(const char *common_prefix)
 	return common_prefix_len;
 }
 
-static int read_one_entry_opt(struct index_state *istate,
+static int read_one_entry_opt(struct repository *repo UNUSED, struct index_state *istate,
 			      const struct object_id *oid,
 			      struct strbuf *base,
 			      const char *pathname,
@@ -533,12 +533,12 @@ static int read_one_entry_opt(struct index_state *istate,
 	return add_index_entry(istate, ce, opt);
 }
 
-static int read_one_entry(const struct object_id *oid, struct strbuf *base,
+static int read_one_entry(struct repository *repo, const struct object_id *oid, struct strbuf *base,
 			  const char *pathname, unsigned mode,
 			  void *context)
 {
 	struct index_state *istate = context;
-	return read_one_entry_opt(istate, oid, base, pathname,
+	return read_one_entry_opt(repo, istate, oid, base, pathname,
 				  mode,
 				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
 }
@@ -547,12 +547,12 @@ static int read_one_entry(const struct object_id *oid, struct strbuf *base,
  * This is used when the caller knows there is no existing entries at
  * the stage that will conflict with the entry being added.
  */
-static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base,
+static int read_one_entry_quick(struct repository *repo, const struct object_id *oid, struct strbuf *base,
 				const char *pathname, unsigned mode,
 				void *context)
 {
 	struct index_state *istate = context;
-	return read_one_entry_opt(istate, oid, base, pathname,
+	return read_one_entry_opt(repo, istate, oid, base, pathname,
 				  mode, ADD_CACHE_JUST_APPEND);
 }
 
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index c3ea09281af..c8d6ff95ac0 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -141,7 +141,7 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 	return 0;
 }
 
-static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
+static int show_tree_fmt(struct repository *repo UNUSED, const struct object_id *oid, struct strbuf *base,
 			 const char *pathname, unsigned mode, void *context UNUSED)
 {
 	size_t baselen;
@@ -211,7 +211,7 @@ static void show_tree_common_default_long(struct strbuf *base,
 	strbuf_setlen(base, baselen);
 }
 
-static int show_tree_default(const struct object_id *oid, struct strbuf *base,
+static int show_tree_default(struct repository *repo UNUSED, const struct object_id *oid, struct strbuf *base,
 			     const char *pathname, unsigned mode,
 			     void *context UNUSED)
 {
@@ -229,7 +229,7 @@ static int show_tree_default(const struct object_id *oid, struct strbuf *base,
 	return recurse;
 }
 
-static int show_tree_long(const struct object_id *oid, struct strbuf *base,
+static int show_tree_long(struct repository *repo, const struct object_id *oid, struct strbuf *base,
 			  const char *pathname, unsigned mode,
 			  void *context UNUSED)
 {
@@ -244,7 +244,7 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 
 	if (data.type == OBJ_BLOB) {
 		unsigned long size;
-		if (oid_object_info(the_repository, data.oid, &size) == OBJ_BAD)
+		if (oid_object_info(repo, data.oid, &size) == OBJ_BAD)
 			xsnprintf(size_text, sizeof(size_text), "BAD");
 		else
 			xsnprintf(size_text, sizeof(size_text),
@@ -254,12 +254,12 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 	}
 
 	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
-	       find_unique_abbrev(data.oid, abbrev), size_text);
+	       repo_find_unique_abbrev(repo, data.oid, abbrev), size_text);
 	show_tree_common_default_long(base, pathname, data.base->len);
 	return recurse;
 }
 
-static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
+static int show_tree_name_only(struct repository *repo UNUSED, const struct object_id *oid, struct strbuf *base,
 			       const char *pathname, unsigned mode,
 			       void *context UNUSED)
 {
@@ -280,7 +280,7 @@ static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
 	return recurse;
 }
 
-static int show_tree_object(const struct object_id *oid, struct strbuf *base,
+static int show_tree_object(struct repository *repo, const struct object_id *oid, struct strbuf *base,
 			    const char *pathname, unsigned mode,
 			    void *context UNUSED)
 {
@@ -292,7 +292,7 @@ static int show_tree_object(const struct object_id *oid, struct strbuf *base,
 	if (early >= 0)
 		return early;
 
-	printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
+	printf("%s%c", repo_find_unique_abbrev(repo, oid, abbrev), line_termination);
 	return recurse;
 }
 
diff --git a/list-objects.c b/list-objects.c
index 250d9de41cb..4f463ae32ad 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -185,7 +185,7 @@ static void process_tree(struct traversal_context *ctx,
 	    !revs->include_check_obj(&tree->object, revs->include_check_data))
 		return;
 
-	failed_parse = parse_tree_gently(tree, 1);
+	failed_parse = parse_tree_gently(revs->repo, tree, 1);
 	if (failed_parse) {
 		if (revs->ignore_missing_links)
 			return;
diff --git a/merge-recursive.c b/merge-recursive.c
index 4ddd3adea00..119e86090f9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -456,7 +456,7 @@ static void unpack_trees_finish(struct merge_options *opt)
 	clear_unpack_trees_porcelain(&opt->priv->unpack_opts);
 }
 
-static int save_files_dirs(const struct object_id *oid UNUSED,
+static int save_files_dirs(struct repository *repo UNUSED, const struct object_id *oid UNUSED,
 			   struct strbuf *base, const char *path,
 			   unsigned int mode, void *context)
 {
diff --git a/revision.c b/revision.c
index 36e31942cee..39e023a19ea 100644
--- a/revision.c
+++ b/revision.c
@@ -74,7 +74,7 @@ static void mark_tree_contents_uninteresting(struct repository *r,
 	struct tree_desc desc;
 	struct name_entry entry;
 
-	if (parse_tree_gently(tree, 1) < 0)
+	if (parse_tree_gently(r, tree, 1) < 0)
 		return;
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
@@ -181,7 +181,7 @@ static void add_children_by_path(struct repository *r,
 	if (!tree)
 		return;
 
-	if (parse_tree_gently(tree, 1) < 0)
+	if (parse_tree_gently(r, tree, 1) < 0)
 		return;
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
diff --git a/sparse-index.c b/sparse-index.c
index e4a54ce1943..05ca8aec1fb 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -232,7 +232,7 @@ static void set_index_entry(struct index_state *istate, int nr, struct cache_ent
 	add_name_hash(istate, ce);
 }
 
-static int add_path_to_index(const struct object_id *oid,
+static int add_path_to_index(struct repository *repo UNUSED, const struct object_id *oid,
 			     struct strbuf *base, const char *path,
 			     unsigned int mode, void *context)
 {
diff --git a/t/t5005-archive-submodules.sh b/t/t5005-archive-submodules.sh
new file mode 100755
index 00000000000..49d5ff74ad5
--- /dev/null
+++ b/t/t5005-archive-submodules.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+
+test_description='git archive --recurse-submodules test'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-submodule-update.sh
+
+test_expect_success 'setup' '
+	create_lib_submodule_repo &&
+	git -C submodule_update_repo checkout valid_sub1 &&
+	git -C submodule_update_repo submodule update
+'
+
+check_tar() {
+	tarfile=$1.tar
+	listfile=$1.lst
+	dir=$1
+	dir_with_prefix=$dir/$2
+
+	test_expect_success ' extract tar archive' '
+		(mkdir $dir && cd $dir && "$TAR" xf -) <$tarfile
+	'
+}
+
+check_added() {
+	dir=$1
+	path_in_fs=$2
+	path_in_archive=$3
+
+	test_expect_success " validate extra file $path_in_archive" '
+		test -f $dir/$path_in_archive &&
+		diff -r $path_in_fs $dir/$path_in_archive
+	'
+}
+
+check_not_added() {
+	dir=$1
+	path_in_archive=$2
+
+	test_expect_success " validate unpresent file $path_in_archive" '
+		! test -f $dir/$path_in_archive &&
+		! test -d $dir/$path_in_archive
+	'
+}
+
+test_expect_success 'archive without recurse, non-init' '
+	reset_work_tree_to valid_sub1 &&
+	git -C submodule_update archive HEAD >b.tar
+'
+
+check_tar b
+check_added b submodule_update/file1 file1
+check_not_added b sub1/file1
+
+test_expect_success 'archive with recurse, non-init' '
+	reset_work_tree_to valid_sub1 &&
+	! git -C submodule_update archive --recurse-submodules HEAD >b2-err.tar
+'
+
+test_expect_success 'archive with recurse, init' '
+	reset_work_tree_to valid_sub1 &&
+	git -C submodule_update submodule update --init &&
+	git -C submodule_update ls-files --recurse-submodules &&
+	git -C submodule_update ls-tree HEAD &&
+	git -C submodule_update archive --recurse-submodules HEAD >b2.tar
+'
+
+check_tar b2
+check_added b2 submodule_update/sub1/file1 sub1/file1
+
+test_expect_success 'archive with recurse with big files' '
+	reset_work_tree_to valid_sub1 &&
+	test_config core.bigfilethreshold 1 &&
+	git -C submodule_update submodule update --init &&
+	git -C submodule_update ls-files --recurse-submodules &&
+	git -C submodule_update ls-tree HEAD &&
+	git -C submodule_update archive --recurse-submodules HEAD >b3.tar
+'
+
+check_tar b3
+check_added b3 submodule_update/sub1/file1 sub1/file1
+
+
+test_done
diff --git a/tree.c b/tree.c
index 410e3b477e5..c5b5a0ac08f 100644
--- a/tree.c
+++ b/tree.c
@@ -8,6 +8,7 @@
 #include "alloc.h"
 #include "tree-walk.h"
 #include "repository.h"
+#include "pathspec.h"
 
 const char *tree_type = "tree";
 
@@ -22,8 +23,8 @@ int read_tree_at(struct repository *r,
 	int len, oldlen = base->len;
 	enum interesting retval = entry_not_interesting;
 
-	if (parse_tree(tree))
-		return -1;
+	if (repo_parse_tree(r, tree))
+		die("Failed to parse tree");
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
 
@@ -37,7 +38,7 @@ int read_tree_at(struct repository *r,
 				continue;
 		}
 
-		switch (fn(&entry.oid, base,
+		switch (fn(r, &entry.oid, base,
 			   entry.path, entry.mode, context)) {
 		case 0:
 			continue;
@@ -47,36 +48,57 @@ int read_tree_at(struct repository *r,
 			return -1;
 		}
 
-		if (S_ISDIR(entry.mode))
+		if (S_ISDIR(entry.mode)) {
 			oidcpy(&oid, &entry.oid);
-		else if (S_ISGITLINK(entry.mode)) {
+			len = tree_entry_len(&entry);
+			strbuf_add(base, entry.path, len);
+			strbuf_addch(base, '/');
+			retval = read_tree_at(r, lookup_tree(r, &oid),
+						base, pathspec,
+						fn, context);
+			strbuf_setlen(base, oldlen);
+			if (retval)
+				return -1;
+		} else if (pathspec->recurse_submodules && S_ISGITLINK(entry.mode)) {
 			struct commit *commit;
+			struct repository subrepo;
+			struct repository* subrepo_p = &subrepo;
+			struct tree* submodule_tree;
 
-			commit = lookup_commit(r, &entry.oid);
+			if (repo_submodule_init(subrepo_p, r, entry.path, null_oid()))
+				die("couldn't init submodule %s%s", base->buf, entry.path);
+
+			if (repo_read_index(subrepo_p) < 0)
+				die("index file corrupt");
+
+			commit = lookup_commit(subrepo_p, &entry.oid);
 			if (!commit)
 				die("Commit %s in submodule path %s%s not found",
 				    oid_to_hex(&entry.oid),
 				    base->buf, entry.path);
 
-			if (parse_commit(commit))
+			if (repo_parse_commit(subrepo_p, commit))
 				die("Invalid commit %s in submodule path %s%s",
 				    oid_to_hex(&entry.oid),
 				    base->buf, entry.path);
 
-			oidcpy(&oid, get_commit_tree_oid(commit));
+			submodule_tree = repo_get_commit_tree(subrepo_p, commit);
+			oidcpy(&oid, submodule_tree ? &submodule_tree->object.oid : NULL);
+
+			len = tree_entry_len(&entry);
+			strbuf_add(base, entry.path, len);
+			strbuf_addch(base, '/');
+			retval = read_tree_at(subrepo_p, lookup_tree(subrepo_p, &oid),
+						base, pathspec,
+						fn, context);
+			if (retval) {
+			    die("failed to read tree for %s%s", base->buf, entry.path);
+			    return -1;
+			}
+			strbuf_setlen(base, oldlen);
+			repo_clear(subrepo_p);
 		}
-		else
-			continue;
 
-		len = tree_entry_len(&entry);
-		strbuf_add(base, entry.path, len);
-		strbuf_addch(base, '/');
-		retval = read_tree_at(r, lookup_tree(r, &oid),
-				      base, pathspec,
-				      fn, context);
-		strbuf_setlen(base, oldlen);
-		if (retval)
-			return -1;
 	}
 	return 0;
 }
@@ -121,7 +143,7 @@ int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
 	return 0;
 }
 
-int parse_tree_gently(struct tree *item, int quiet_on_missing)
+int parse_tree_gently(struct repository *r, struct tree *item, int quiet_on_missing)
 {
 	 enum object_type type;
 	 void *buffer;
@@ -129,7 +151,7 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
 
 	if (item->object.parsed)
 		return 0;
-	buffer = read_object_file(&item->object.oid, &type, &size);
+	buffer = repo_read_object_file(r, &item->object.oid, &type, &size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
diff --git a/tree.h b/tree.h
index 6efff003e21..3dc8f151760 100644
--- a/tree.h
+++ b/tree.h
@@ -18,11 +18,14 @@ struct tree *lookup_tree(struct repository *r, const struct object_id *oid);
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
 
-int parse_tree_gently(struct tree *tree, int quiet_on_missing);
-static inline int parse_tree(struct tree *tree)
+int parse_tree_gently(struct repository *r, struct tree *tree, int quiet_on_missing);
+static inline int repo_parse_tree(struct repository *r, struct tree *tree)
 {
-	return parse_tree_gently(tree, 0);
+	return parse_tree_gently(r, tree, 0);
 }
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define parse_tree(tree) repo_parse_tree(the_repository, tree)
+#endif
 void free_tree_buffer(struct tree *tree);
 
 /* Parses and returns the tree in the given ent, chasing tags and commits. */
@@ -31,7 +34,7 @@ struct tree *parse_tree_indirect(const struct object_id *oid);
 int cmp_cache_name_compare(const void *a_, const void *b_);
 
 #define READ_TREE_RECURSIVE 1
-typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, void *);
+typedef int (*read_tree_fn_t)(struct repository *, const struct object_id *, struct strbuf *, const char *, unsigned int, void *);
 
 int read_tree_at(struct repository *r,
 		 struct tree *tree, struct strbuf *base,
diff --git a/wt-status.c b/wt-status.c
index 5813174896c..fefe4c55e1b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -665,7 +665,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	release_revisions(&rev);
 }
 
-static int add_file_to_list(const struct object_id *oid,
+static int add_file_to_list(struct repository *repo UNUSED, const struct object_id *oid,
 			    struct strbuf *base, const char *path,
 			    unsigned int mode, void *context)
 {
-- 
gitgitgadget

