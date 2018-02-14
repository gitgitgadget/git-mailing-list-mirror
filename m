Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67DF71F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162496AbeBNTAv (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:00:51 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:41690 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162210AbeBNTAs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:00:48 -0500
Received: by mail-oi0-f74.google.com with SMTP id 1so11257088oiq.8
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=KqyS6OIQBOlVBNshWPHkKyvX1bmU9M4W2CAS5WxrVgc=;
        b=uu0lmDHXISAkoyvuq+P+Ni8lCcnywINrkjwrBw+HPEcGr4I4a6PYNqMyHp4THw7M6Z
         Uoi65zz/vj2TzOeo4Ofx32hCtbvEqgMzRJDra7cxgq3JvcuR8t4dM2DQEyTxJvyAIkjb
         ZpVSWPuh/sOWvUkjP1wvEnpm9PE4+RtNO9m/N7CJicdBf0JqeK8ZnLm3JY87c8yObH2B
         EE83TZleMIa2RvUb4AASC/hb9K46q2wOAOXKiiJaHHcwpFO8mRqxJSoY+T8euPmwKHoa
         RJy0vXJ+kotcIqU0NtU6qggF7hy+ZV6D4/tpNFCOeHo/HkOFRGKCJ8WINdZfB/YYwywb
         D1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=KqyS6OIQBOlVBNshWPHkKyvX1bmU9M4W2CAS5WxrVgc=;
        b=OEsbZouVEGRBpPspz9wPmHzJM4QCW8le81KRZlKuq+18BUSkJUgxZbb5DyoctwMXjt
         h8wxxKIp7NHFRNlzyb3W2/kIpH8fx916iDbw/YDS3XUxWaxPy2hX9QY2aZ3rbt9aJN/t
         5J5BYy9HfzGJgjHwihgrptUn1qv39y6tD/VXOZ1pykyv8sy8snw/nXYMFzV61w5mGQRY
         JzQePNDxa2ps7y9uwMm2U7dk6nRv5PWRu8ghffua6AiflPpJ4pbjdYd7Q+WnXn/r36tb
         Oe2UFfwLUlI7SwWhsbcgV3Kd0iNDX9sgH0SX6A+467fuYqws+2IyPxv24ekyK/1BvqFT
         QLYw==
X-Gm-Message-State: APf1xPBkqWkYG6yH5gPDeVPEpMsrShWhvNi243UwChsq2BBxz9kYDjc0
        szI/w94IyZy4qLORFIVb3jX12QWQeb6Ra5peUMJXHb8Q1PSCVYQxZze0Fr+2wtHZ/EuryuADCcl
        t6C6WjXhfHwG0VkBjyzLL5jxX3LVyRPjRPOGwqlQRs8CGlzFnqZH9tBQ7Tw==
X-Google-Smtp-Source: AH8x224wIrXMnDrQ4RqDXsaw1xza35gzv8QrX3Kh2vWKQ5fD2p4jU8fpaJo8EKimyxe4JbgTEV3C5+vCCgw=
MIME-Version: 1.0
X-Received: by 10.157.56.53 with SMTP id i50mr8085otc.107.1518634847675; Wed,
 14 Feb 2018 11:00:47 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:24 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-3-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 02/37] object: rename function 'typename' to 'type_name'
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
 builtin/cat-file.c                     |  2 +-
 builtin/diff-tree.c                    |  2 +-
 builtin/fast-export.c                  |  8 ++++----
 builtin/fsck.c                         |  4 ++--
 builtin/grep.c                         |  2 +-
 builtin/index-pack.c                   | 12 ++++++------
 builtin/merge.c                        |  2 +-
 builtin/mktree.c                       |  4 ++--
 builtin/prune.c                        |  2 +-
 builtin/replace.c                      | 12 ++++++------
 builtin/tag.c                          |  2 +-
 builtin/unpack-objects.c               | 10 +++++-----
 builtin/verify-commit.c                |  2 +-
 bulk-checkin.c                         |  2 +-
 commit.c                               |  2 +-
 contrib/examples/builtin-fetch--tool.c |  2 +-
 fast-import.c                          | 16 ++++++++--------
 fsck.c                                 |  2 +-
 http-push.c                            |  2 +-
 log-tree.c                             |  2 +-
 object.c                               |  6 +++---
 object.h                               |  2 +-
 pack-check.c                           |  2 +-
 packfile.c                             |  2 +-
 reachable.c                            |  2 +-
 ref-filter.c                           |  4 ++--
 sequencer.c                            |  2 +-
 sha1_file.c                            | 20 ++++++++++----------
 sha1_name.c                            |  6 +++---
 submodule.c                            |  2 +-
 tag.c                                  |  2 +-
 walker.c                               |  4 ++--
 32 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d06c66c77..c6b3b1bfb 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -229,7 +229,7 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 		if (data->mark_query)
 			data->info.typep = &data->type;
 		else
-			strbuf_addstr(sb, typename(data->type));
+			strbuf_addstr(sb, type_name(data->type));
 	} else if (is_atom("objectsize", atom, len)) {
 		if (data->mark_query)
 			data->info.sizep = &data->size;
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index b775a7564..473615117 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -76,7 +76,7 @@ static int diff_tree_stdin(char *line)
 	if (obj->type == OBJ_TREE)
 		return stdin_diff_trees((struct tree *)obj, p);
 	error("Object %s is a %s, not a commit or tree",
-	      oid_to_hex(&oid), typename(obj->type));
+	      oid_to_hex(&oid), type_name(obj->type));
 	return -1;
 }
 
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 796d0cd66..27b2cc138 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -240,7 +240,7 @@ static void export_blob(const struct object_id *oid)
 		buf = read_sha1_file(oid->hash, &type, &size);
 		if (!buf)
 			die ("Could not read blob %s", oid_to_hex(oid));
-		if (check_sha1_signature(oid->hash, buf, size, typename(type)) < 0)
+		if (check_sha1_signature(oid->hash, buf, size, type_name(type)) < 0)
 			die("sha1 mismatch in blob %s", oid_to_hex(oid));
 		object = parse_object_buffer(oid, type, size, buf, &eaten);
 	}
@@ -757,7 +757,7 @@ static void handle_tag(const char *name, struct tag *tag)
 			if (tagged->type != OBJ_COMMIT) {
 				die ("Tag %s tags unexported %s!",
 				     oid_to_hex(&tag->object.oid),
-				     typename(tagged->type));
+				     type_name(tagged->type));
 			}
 			p = (struct commit *)tagged;
 			for (;;) {
@@ -839,7 +839,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 		if (!commit) {
 			warning("%s: Unexpected object of type %s, skipping.",
 				e->name,
-				typename(e->item->type));
+				type_name(e->item->type));
 			continue;
 		}
 
@@ -851,7 +851,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 			continue;
 		default: /* OBJ_TAG (nested tags) is already handled */
 			warning("Tag points to object of unexpected type %s, skipping.",
-				typename(commit->object.type));
+				type_name(commit->object.type));
 			continue;
 		}
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 04846d46f..246237e81 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -70,7 +70,7 @@ static const char *printable_type(struct object *obj)
 			object_as_type(obj, type, 0);
 	}
 
-	ret = typename(obj->type);
+	ret = type_name(obj->type);
 	if (!ret)
 		ret = "unknown";
 
@@ -137,7 +137,7 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 		printf("broken link from %7s %s\n",
 			   printable_type(parent), describe_object(parent));
 		printf("broken link from %7s %s\n",
-			   (type == OBJ_ANY ? "unknown" : typename(type)), "unknown");
+			   (type == OBJ_ANY ? "unknown" : type_name(type)), "unknown");
 		errors_found |= ERROR_REACHABLE;
 		return 1;
 	}
diff --git a/builtin/grep.c b/builtin/grep.c
index 3ca4ac80d..eb1207095 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -627,7 +627,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		free(data);
 		return hit;
 	}
-	die(_("unable to grep from object of type %s"), typename(obj->type));
+	die(_("unable to grep from object of type %s"), type_name(obj->type));
 }
 
 static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4c51aec81..8b87090e2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -228,7 +228,7 @@ static unsigned check_object(struct object *obj)
 		if (type != obj->type)
 			die(_("object %s: expected type %s, found %s"),
 			    oid_to_hex(&obj->oid),
-			    typename(obj->type), typename(type));
+			    type_name(obj->type), type_name(type));
 		obj->flags |= FLAG_CHECKED;
 		return 1;
 	}
@@ -448,7 +448,7 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 	int hdrlen;
 
 	if (!is_delta_type(type)) {
-		hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), size) + 1;
+		hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", type_name(type), size) + 1;
 		git_SHA1_Init(&c);
 		git_SHA1_Update(&c, hdr, hdrlen);
 	} else
@@ -849,7 +849,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			obj = parse_object_buffer(oid, type, size, buf,
 						  &eaten);
 			if (!obj)
-				die(_("invalid %s"), typename(type));
+				die(_("invalid %s"), type_name(type));
 			if (do_fsck_object &&
 			    fsck_object(obj, buf, size, &fsck_options))
 				die(_("Error in object"));
@@ -959,7 +959,7 @@ static void resolve_delta(struct object_entry *delta_obj,
 	if (!result->data)
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
 	hash_sha1_file(result->data, result->size,
-		       typename(delta_obj->real_type),
+		       type_name(delta_obj->real_type),
 		       delta_obj->idx.oid.hash);
 	sha1_object(result->data, NULL, result->size, delta_obj->real_type,
 		    &delta_obj->idx.oid);
@@ -1379,7 +1379,7 @@ static void fix_unresolved_deltas(struct sha1file *f)
 			continue;
 
 		if (check_sha1_signature(d->sha1, base_obj->data,
-				base_obj->size, typename(type)))
+				base_obj->size, type_name(type)))
 			die(_("local object %s is corrupt"), sha1_to_hex(d->sha1));
 		base_obj->obj = append_obj_to_pack(f, d->sha1,
 					base_obj->data, base_obj->size, type);
@@ -1588,7 +1588,7 @@ static void show_pack_info(int stat_only)
 			continue;
 		printf("%s %-6s %lu %lu %"PRIuMAX,
 		       oid_to_hex(&obj->idx.oid),
-		       typename(obj->real_type), obj->size,
+		       type_name(obj->real_type), obj->size,
 		       (unsigned long)(obj[1].idx.offset - obj->idx.offset),
 		       (uintmax_t)obj->idx.offset);
 		if (is_delta_type(obj->type)) {
diff --git a/builtin/merge.c b/builtin/merge.c
index 30264cfd7..9dec14096 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -520,7 +520,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		if (desc && desc->obj && desc->obj->type == OBJ_TAG) {
 			strbuf_addf(msg, "%s\t\t%s '%s'\n",
 				    oid_to_hex(&desc->obj->oid),
-				    typename(desc->obj->type),
+				    type_name(desc->obj->type),
 				    remote);
 			goto cleanup;
 		}
diff --git a/builtin/mktree.c b/builtin/mktree.c
index da0fd8cd7..b7b1cb51f 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -112,7 +112,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 	mode_type = object_type(mode);
 	if (mode_type != type_from_string(ptr)) {
 		die("entry '%s' object type (%s) doesn't match mode type (%s)",
-			path, ptr, typename(mode_type));
+			path, ptr, type_name(mode_type));
 	}
 
 	/* Check the type of object identified by sha1 */
@@ -131,7 +131,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 			 * because the new tree entry will never be correct.
 			 */
 			die("entry '%s' object %s is a %s but specified type was (%s)",
-				path, sha1_to_hex(sha1), typename(obj_type), typename(mode_type));
+				path, sha1_to_hex(sha1), type_name(obj_type), type_name(mode_type));
 		}
 	}
 
diff --git a/builtin/prune.c b/builtin/prune.c
index d2fdae680..c175f154e 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -52,7 +52,7 @@ static int prune_object(const struct object_id *oid, const char *fullpath,
 	if (show_only || verbose) {
 		enum object_type type = sha1_object_info(oid->hash, NULL);
 		printf("%s %s\n", oid_to_hex(oid),
-		       (type > 0) ? typename(type) : "unknown");
+		       (type > 0) ? type_name(type) : "unknown");
 	}
 	if (!show_only)
 		unlink_or_warn(fullpath);
diff --git a/builtin/replace.c b/builtin/replace.c
index 10078ae37..42cf4f62a 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -56,8 +56,8 @@ static int show_reference(const char *refname, const struct object_id *oid,
 			obj_type = sha1_object_info(object.hash, NULL);
 			repl_type = sha1_object_info(oid->hash, NULL);
 
-			printf("%s (%s) -> %s (%s)\n", refname, typename(obj_type),
-			       oid_to_hex(oid), typename(repl_type));
+			printf("%s (%s) -> %s (%s)\n", refname, type_name(obj_type),
+			       oid_to_hex(oid), type_name(repl_type));
 		}
 	}
 
@@ -168,8 +168,8 @@ static int replace_object_oid(const char *object_ref,
 		die("Objects must be of the same type.\n"
 		    "'%s' points to a replaced object of type '%s'\n"
 		    "while '%s' points to a replacement object of type '%s'.",
-		    object_ref, typename(obj_type),
-		    replace_ref, typename(repl_type));
+		    object_ref, type_name(obj_type),
+		    replace_ref, type_name(repl_type));
 
 	check_ref_valid(object, &prev, &ref, force);
 
@@ -215,7 +215,7 @@ static void export_object(const struct object_id *oid, enum object_type type,
 	argv_array_push(&cmd.args, "--no-replace-objects");
 	argv_array_push(&cmd.args, "cat-file");
 	if (raw)
-		argv_array_push(&cmd.args, typename(type));
+		argv_array_push(&cmd.args, type_name(type));
 	else
 		argv_array_push(&cmd.args, "-p");
 	argv_array_push(&cmd.args, oid_to_hex(oid));
@@ -355,7 +355,7 @@ static void check_one_mergetag(struct commit *commit,
 	struct tag *tag;
 	int i;
 
-	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), tag_oid.hash);
+	hash_sha1_file(extra->value, extra->len, type_name(OBJ_TAG), tag_oid.hash);
 	tag = lookup_tag(&tag_oid);
 	if (!tag)
 		die(_("bad mergetag in commit '%s'"), ref);
diff --git a/builtin/tag.c b/builtin/tag.c
index a7e6a5b0f..7e0881fba 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -220,7 +220,7 @@ static void create_tag(const struct object_id *object, const char *tag,
 		    "tag %s\n"
 		    "tagger %s\n\n",
 		    oid_to_hex(object),
-		    typename(type),
+		    type_name(type),
 		    tag,
 		    git_committer_info(IDENT_STRICT));
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 62ea264c4..e93079070 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -172,7 +172,7 @@ static void write_cached_object(struct object *obj, struct obj_buffer *obj_buf)
 {
 	struct object_id oid;
 
-	if (write_sha1_file(obj_buf->buffer, obj_buf->size, typename(obj->type), oid.hash) < 0)
+	if (write_sha1_file(obj_buf->buffer, obj_buf->size, type_name(obj->type), oid.hash) < 0)
 		die("failed to write object %s", oid_to_hex(&obj->oid));
 	obj->flags |= FLAG_WRITTEN;
 }
@@ -237,14 +237,14 @@ static void write_object(unsigned nr, enum object_type type,
 			 void *buf, unsigned long size)
 {
 	if (!strict) {
-		if (write_sha1_file(buf, size, typename(type), obj_list[nr].oid.hash) < 0)
+		if (write_sha1_file(buf, size, type_name(type), obj_list[nr].oid.hash) < 0)
 			die("failed to write object");
 		added_object(nr, type, buf, size);
 		free(buf);
 		obj_list[nr].obj = NULL;
 	} else if (type == OBJ_BLOB) {
 		struct blob *blob;
-		if (write_sha1_file(buf, size, typename(type), obj_list[nr].oid.hash) < 0)
+		if (write_sha1_file(buf, size, type_name(type), obj_list[nr].oid.hash) < 0)
 			die("failed to write object");
 		added_object(nr, type, buf, size);
 		free(buf);
@@ -258,12 +258,12 @@ static void write_object(unsigned nr, enum object_type type,
 	} else {
 		struct object *obj;
 		int eaten;
-		hash_sha1_file(buf, size, typename(type), obj_list[nr].oid.hash);
+		hash_sha1_file(buf, size, type_name(type), obj_list[nr].oid.hash);
 		added_object(nr, type, buf, size);
 		obj = parse_object_buffer(&obj_list[nr].oid, type, size, buf,
 					  &eaten);
 		if (!obj)
-			die("invalid %s", typename(type));
+			die("invalid %s", type_name(type));
 		add_object_buffer(obj, buf, size);
 		obj->flags |= FLAG_OPEN;
 		obj_list[nr].obj = obj;
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index ba38ac9b1..05315ea7c 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -49,7 +49,7 @@ static int verify_commit(const char *name, unsigned flags)
 		return error("%s: unable to read file.", name);
 	if (type != OBJ_COMMIT)
 		return error("%s: cannot verify a non-commit object of type %s.",
-				name, typename(type));
+				name, type_name(type));
 
 	ret = run_gpg_verify(&oid, buf, size, flags);
 
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 3310fd210..bb788494f 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -203,7 +203,7 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 		return error("cannot find the current offset");
 
 	header_len = xsnprintf((char *)obuf, sizeof(obuf), "%s %" PRIuMAX,
-			       typename(type), (uintmax_t)size) + 1;
+			       type_name(type), (uintmax_t)size) + 1;
 	git_SHA1_Init(&ctx);
 	git_SHA1_Update(&ctx, obuf, header_len);
 
diff --git a/commit.c b/commit.c
index ff51c9f34..cd9ace105 100644
--- a/commit.c
+++ b/commit.c
@@ -274,7 +274,7 @@ const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
 			    oid_to_hex(&commit->object.oid));
 		if (type != OBJ_COMMIT)
 			die("expected commit for %s, got %s",
-			    oid_to_hex(&commit->object.oid), typename(type));
+			    oid_to_hex(&commit->object.oid), type_name(type));
 		if (sizep)
 			*sizep = size;
 	}
diff --git a/contrib/examples/builtin-fetch--tool.c b/contrib/examples/builtin-fetch--tool.c
index a3eb19de0..22648c3af 100644
--- a/contrib/examples/builtin-fetch--tool.c
+++ b/contrib/examples/builtin-fetch--tool.c
@@ -15,7 +15,7 @@ static char *get_stdin(void)
 
 static void show_new(enum object_type type, unsigned char *sha1_new)
 {
-	fprintf(stderr, "  %s: %s\n", typename(type),
+	fprintf(stderr, "  %s: %s\n", type_name(type),
 		find_unique_abbrev(sha1_new, DEFAULT_ABBREV));
 }
 
diff --git a/fast-import.c b/fast-import.c
index b70ac025e..92b89d191 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1096,7 +1096,7 @@ static int store_object(
 	git_zstream s;
 
 	hdrlen = xsnprintf((char *)hdr, sizeof(hdr), "%s %lu",
-			   typename(type), (unsigned long)dat->len) + 1;
+			   type_name(type), (unsigned long)dat->len) + 1;
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, hdrlen);
 	git_SHA1_Update(&c, dat->buf, dat->len);
@@ -2421,7 +2421,7 @@ static void file_change_m(const char *p, struct branch *b)
 		else if (oe) {
 			if (oe->type != OBJ_COMMIT)
 				die("Not a commit (actually a %s): %s",
-					typename(oe->type), command_buf.buf);
+					type_name(oe->type), command_buf.buf);
 		}
 		/*
 		 * Accept the sha1 without checking; it expected to be in
@@ -2448,7 +2448,7 @@ static void file_change_m(const char *p, struct branch *b)
 					command_buf.buf);
 		if (type != expected)
 			die("Not a %s (actually a %s): %s",
-				typename(expected), typename(type),
+				type_name(expected), type_name(type),
 				command_buf.buf);
 	}
 
@@ -2599,14 +2599,14 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 	} else if (oe) {
 		if (oe->type != OBJ_BLOB)
 			die("Not a blob (actually a %s): %s",
-				typename(oe->type), command_buf.buf);
+				type_name(oe->type), command_buf.buf);
 	} else if (!is_null_oid(&oid)) {
 		enum object_type type = sha1_object_info(oid.hash, NULL);
 		if (type < 0)
 			die("Blob not found: %s", command_buf.buf);
 		if (type != OBJ_BLOB)
 			die("Not a blob (actually a %s): %s",
-			    typename(type), command_buf.buf);
+			    type_name(type), command_buf.buf);
 	}
 
 	construct_path_with_fanout(oid_to_hex(&commit_oid), *old_fanout, path);
@@ -2914,7 +2914,7 @@ static void parse_new_tag(const char *arg)
 		    "object %s\n"
 		    "type %s\n"
 		    "tag %s\n",
-		    oid_to_hex(&oid), typename(type), t->name);
+		    oid_to_hex(&oid), type_name(type), t->name);
 	if (tagger)
 		strbuf_addf(&new_data,
 			    "tagger %s\n", tagger);
@@ -2985,10 +2985,10 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 		die("Can't read object %s", oid_to_hex(oid));
 	if (type != OBJ_BLOB)
 		die("Object %s is a %s but a blob was expected.",
-		    oid_to_hex(oid), typename(type));
+		    oid_to_hex(oid), type_name(type));
 	strbuf_reset(&line);
 	strbuf_addf(&line, "%s %s %lu\n", oid_to_hex(oid),
-						typename(type), size);
+						type_name(type), size);
 	cat_blob_write(line.buf, line.len);
 	strbuf_release(&line);
 	cat_blob_write(buf, size);
diff --git a/fsck.c b/fsck.c
index 032699e9a..5c8c12dde 100644
--- a/fsck.c
+++ b/fsck.c
@@ -821,7 +821,7 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 			ret = report(options, &tag->object,
 				FSCK_MSG_TAG_OBJECT_NOT_TAG,
 				"expected tag got %s",
-			    typename(type));
+			    type_name(type));
 			goto done;
 		}
 	}
diff --git a/http-push.c b/http-push.c
index 14435ab65..8814aa12e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -362,7 +362,7 @@ static void start_put(struct transfer_request *request)
 	git_zstream stream;
 
 	unpacked = read_sha1_file(request->obj->oid.hash, &type, &len);
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", type_name(type), len) + 1;
 
 	/* Set it up */
 	git_deflate_init(&stream, zlib_compression_level);
diff --git a/log-tree.c b/log-tree.c
index fca29d479..2eeddbeb3 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -499,7 +499,7 @@ static void show_one_mergetag(struct commit *commit,
 	int status, nth;
 	size_t payload_size, gpg_message_offset;
 
-	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), oid.hash);
+	hash_sha1_file(extra->value, extra->len, type_name(OBJ_TAG), oid.hash);
 	tag = lookup_tag(&oid);
 	if (!tag)
 		return; /* error message already given */
diff --git a/object.c b/object.c
index 0afdfd19b..0db33b26b 100644
--- a/object.c
+++ b/object.c
@@ -26,7 +26,7 @@ static const char *object_type_strings[] = {
 	"tag",		/* OBJ_TAG = 4 */
 };
 
-const char *typename(unsigned int type)
+const char *type_name(unsigned int type)
 {
 	if (type >= ARRAY_SIZE(object_type_strings))
 		return NULL;
@@ -166,7 +166,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 		if (!quiet)
 			error("object %s is a %s, not a %s",
 			      oid_to_hex(&obj->oid),
-			      typename(obj->type), typename(type));
+			      type_name(obj->type), type_name(type));
 		return NULL;
 	}
 }
@@ -265,7 +265,7 @@ struct object *parse_object(const struct object_id *oid)
 
 	buffer = read_sha1_file(oid->hash, &type, &size);
 	if (buffer) {
-		if (check_sha1_signature(repl, buffer, size, typename(type)) < 0) {
+		if (check_sha1_signature(repl, buffer, size, type_name(type)) < 0) {
 			free(buffer);
 			error("sha1 mismatch %s", sha1_to_hex(repl));
 			return NULL;
diff --git a/object.h b/object.h
index 87563d905..a5eb26380 100644
--- a/object.h
+++ b/object.h
@@ -53,7 +53,7 @@ struct object {
 	struct object_id oid;
 };
 
-extern const char *typename(unsigned int type);
+extern const char *type_name(unsigned int type);
 extern int type_from_string_gently(const char *str, ssize_t, int gentle);
 #define type_from_string(str) type_from_string_gently(str, -1, 0)
 
diff --git a/pack-check.c b/pack-check.c
index 073c1fbd4..bd348592f 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -141,7 +141,7 @@ static int verify_packfile(struct packed_git *p,
 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
 				    oid_to_hex(entries[i].oid.oid), p->pack_name,
 				    (uintmax_t)entries[i].offset);
-		else if (check_sha1_signature(entries[i].oid.hash, data, size, typename(type)))
+		else if (check_sha1_signature(entries[i].oid.hash, data, size, type_name(type)))
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(entries[i].oid.oid), p->pack_name);
 		else if (fn) {
diff --git a/packfile.c b/packfile.c
index 6657a0a49..0532a371b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1357,7 +1357,7 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 		if (oi->typep)
 			*oi->typep = ptot;
 		if (oi->type_name) {
-			const char *tn = typename(ptot);
+			const char *tn = type_name(ptot);
 			if (tn)
 				strbuf_addstr(oi->type_name, tn);
 		}
diff --git a/reachable.c b/reachable.c
index 88d7d679d..191ebe3e6 100644
--- a/reachable.c
+++ b/reachable.c
@@ -94,7 +94,7 @@ static void add_recent_object(const struct object_id *oid,
 		break;
 	default:
 		die("unknown object type for %s: %s",
-		    oid_to_hex(oid), typename(type));
+		    oid_to_hex(oid), type_name(type));
 	}
 
 	if (!obj)
diff --git a/ref-filter.c b/ref-filter.c
index f9e25aea7..9dae6cfe3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -769,7 +769,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 		if (deref)
 			name++;
 		if (!strcmp(name, "objecttype"))
-			v->s = typename(obj->type);
+			v->s = type_name(obj->type);
 		else if (!strcmp(name, "objectsize")) {
 			v->value = sz;
 			v->s = xstrfmt("%lu", sz);
@@ -795,7 +795,7 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 		if (!strcmp(name, "tag"))
 			v->s = tag->tag;
 		else if (!strcmp(name, "type") && tag->tagged)
-			v->s = typename(tag->tagged->type);
+			v->s = type_name(tag->tagged->type);
 		else if (!strcmp(name, "object") && tag->tagged)
 			v->s = xstrdup(oid_to_hex(&tag->tagged->oid));
 	}
diff --git a/sequencer.c b/sequencer.c
index 4d3f60594..f6b77e6bd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2348,7 +2348,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 			if (!lookup_commit_reference_gently(&oid, 1)) {
 				enum object_type type = sha1_object_info(oid.hash, NULL);
 				return error(_("%s: can't cherry-pick a %s"),
-					name, typename(type));
+					name, type_name(type));
 			}
 		} else
 			return error(_("%s: bad revision"), name);
diff --git a/sha1_file.c b/sha1_file.c
index 2c03458ea..2288bb75c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -805,7 +805,7 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 		return -1;
 
 	/* Generate the header */
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(obj_type), size) + 1;
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", type_name(obj_type), size) + 1;
 
 	/* Sha1.. */
 	git_SHA1_Init(&c);
@@ -1240,7 +1240,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 			if (oi->delta_base_sha1)
 				hashclr(oi->delta_base_sha1);
 			if (oi->type_name)
-				strbuf_addstr(oi->type_name, typename(co->type));
+				strbuf_addstr(oi->type_name, type_name(co->type));
 			if (oi->contentp)
 				*oi->contentp = xmemdupz(co->buf, co->size);
 			oi->whence = OI_CACHED;
@@ -1317,7 +1317,7 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 {
 	struct cached_object *co;
 
-	hash_sha1_file(buf, len, typename(type), sha1);
+	hash_sha1_file(buf, len, type_name(type), sha1);
 	if (has_sha1_file(sha1) || find_cached_object(sha1))
 		return 0;
 	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
@@ -1683,7 +1683,7 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 	buf = read_object(sha1, &type, &len);
 	if (!buf)
 		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", type_name(type), len) + 1;
 	ret = write_loose_object(sha1, hdr, hdrlen, buf, len, mtime);
 	free(buf);
 
@@ -1767,9 +1767,9 @@ static int index_mem(struct object_id *oid, void *buf, size_t size,
 	}
 
 	if (write_object)
-		ret = write_sha1_file(buf, size, typename(type), oid->hash);
+		ret = write_sha1_file(buf, size, type_name(type), oid->hash);
 	else
-		ret = hash_sha1_file(buf, size, typename(type), oid->hash);
+		ret = hash_sha1_file(buf, size, type_name(type), oid->hash);
 	if (re_allocated)
 		free(buf);
 	return ret;
@@ -1789,10 +1789,10 @@ static int index_stream_convert_blob(struct object_id *oid, int fd,
 				 get_safe_crlf(flags));
 
 	if (write_object)
-		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
+		ret = write_sha1_file(sbuf.buf, sbuf.len, type_name(OBJ_BLOB),
 				      oid->hash);
 	else
-		ret = hash_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
+		ret = hash_sha1_file(sbuf.buf, sbuf.len, type_name(OBJ_BLOB),
 				     oid->hash);
 	strbuf_release(&sbuf);
 	return ret;
@@ -1942,7 +1942,7 @@ void assert_sha1_type(const unsigned char *sha1, enum object_type expect)
 		die("%s is not a valid object", sha1_to_hex(sha1));
 	if (type != expect)
 		die("%s is not a valid '%s' object", sha1_to_hex(sha1),
-		    typename(expect));
+		    type_name(expect));
 }
 
 int for_each_file_in_obj_subdir(unsigned int subdir_nr,
@@ -2187,7 +2187,7 @@ int read_loose_object(const char *path,
 			goto out;
 		}
 		if (check_sha1_signature(expected_sha1, *contents,
-					 *size, typename(*type))) {
+					 *size, type_name(*type))) {
 			error("sha1 mismatch for %s (expected %s)", path,
 			      sha1_to_hex(expected_sha1));
 			free(*contents);
diff --git a/sha1_name.c b/sha1_name.c
index 611c7d24d..e7c18ffc2 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -381,7 +381,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 
 	advise("  %s %s%s",
 	       find_unique_abbrev(oid->hash, DEFAULT_ABBREV),
-	       typename(type) ? typename(type) : "unknown type",
+	       type_name(type) ? type_name(type) : "unknown type",
 	       desc.buf);
 
 	strbuf_release(&desc);
@@ -901,8 +901,8 @@ struct object *peel_to_type(const char *name, int namelen,
 			if (name)
 				error("%.*s: expected %s type, but the object "
 				      "dereferences to %s type",
-				      namelen, name, typename(expected_type),
-				      typename(o->type));
+				      namelen, name, type_name(expected_type),
+				      type_name(o->type));
 			return NULL;
 		}
 	}
diff --git a/submodule.c b/submodule.c
index 47ddc9b27..cd18400e8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -831,7 +831,7 @@ static int check_has_commit(const struct object_id *oid, void *data)
 		return 0;
 	default:
 		die(_("submodule entry '%s' (%s) is a %s, not a commit"),
-		    cb->path, oid_to_hex(oid), typename(type));
+		    cb->path, oid_to_hex(oid), type_name(type));
 	}
 }
 
diff --git a/tag.c b/tag.c
index fcbe012f7..66210fd47 100644
--- a/tag.c
+++ b/tag.c
@@ -47,7 +47,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 				name_to_report ?
 				name_to_report :
 				find_unique_abbrev(oid->hash, DEFAULT_ABBREV),
-				typename(type));
+				type_name(type));
 
 	buf = read_sha1_file(oid->hash, &type, &size);
 	if (!buf)
diff --git a/walker.c b/walker.c
index 5d4d3733f..dffb9c8e3 100644
--- a/walker.c
+++ b/walker.c
@@ -22,7 +22,7 @@ void walker_say(struct walker *walker, const char *fmt, ...)
 static void report_missing(const struct object *obj)
 {
 	fprintf(stderr, "Cannot obtain needed %s %s\n",
-		obj->type ? typename(obj->type): "object",
+		obj->type ? type_name(obj->type): "object",
 		oid_to_hex(&obj->oid));
 	if (!is_null_oid(&current_commit_oid))
 		fprintf(stderr, "while processing commit %s.\n",
@@ -134,7 +134,7 @@ static int process_object(struct walker *walker, struct object *obj)
 	}
 	return error("Unable to determine requirements "
 		     "of type %s for %s",
-		     typename(obj->type), oid_to_hex(&obj->oid));
+		     type_name(obj->type), oid_to_hex(&obj->oid));
 }
 
 static int process(struct walker *walker, struct object *obj)
-- 
2.16.1.291.g4437f3f132-goog

