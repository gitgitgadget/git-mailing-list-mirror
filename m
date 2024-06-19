Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7392770E3
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782865; cv=none; b=DIiqXO7rmaDiswWTBw4zOkOUz0lWPN6FA67CTJYP8UrrKyJ6ubm2+dAdniG/lPl2VwyPniQoVGodvTssUczSmUQ5JBoDtZ2TDOGrlk/xXsjYAraaPEcv8goiXxc9cjhRZmLkA/B4Z6hOdFzB5LY2id4I7PSNxft+pMGkqSsfXyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782865; c=relaxed/simple;
	bh=wJkfH/C1KN0G7BCd/+y08gqtWsfwhEBqq7rC/njmvps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e51PDuPVDaJVgmu++D6T4Yr0SCStkX72UnORiLkpwHyIoATeV5UWCXXFPCIfG3WUrrWi6sriUf+3QdiU0UbV4jYTZysUmuFSH86taXL+7sWQgRM+kuLnaAR5se3NAuOBeLkAWR5jVEGCgdH1olm4RmFiUzj4hnQsJ1oU1xv4NJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vj22GGnt; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vj22GGnt"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-70a365a4532so2549998a12.1
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 00:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718782863; x=1719387663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0esFvY3+bJvpicREEbQly/0b4xz2ftYbnop5KSlM3Js=;
        b=Vj22GGntB2kMr7yeoiJ5hwl/YJnQrAEH1hf7Sveakaq+awdktEemS2TTRuc2zoczbp
         wpSb7tImdY9Sg6JByIFLvbwqfKN+AhJ5pFZv9Y0MdZHAIwjoEQgu134pLPfJgXOtQ342
         UEb4+haqvwPtHTGgwfnJzomfB53RulMW/vucF+XwtMvoOjUqUCZM7QDctNA+fLF8UDuV
         Qf9v7jlNFW574OqgnViwsaSU+xaOJVDavwEo1dPWPoh9WOrafib7JKxMZe8gLzz06tum
         WwvYNCRPhc5DY/7N2mDCeXepnOTrFU053likGNx48IwvjKIkAmNvxL/jZ7zmyfo8rqp4
         Zt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718782863; x=1719387663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0esFvY3+bJvpicREEbQly/0b4xz2ftYbnop5KSlM3Js=;
        b=C0+6C+k930txlTK3Di327Ruf8o5LC4PtGSLLjtv1mWTZXKBLqtrrQAt+7HVyifuQnx
         91QJj/r8h9npXiPmlJGc7ESbjBxWtFq4vpHQmDwW7LVDh5vcsnAcsEqelnoOMDMGJMkG
         yfBNk4bn29KaP8VqC/CI6Yq16jei2CYqvEHrVW5s9hXIWUUD880xbU+xYAzUiJyXYEUH
         84vUMZIKDIC8hjjJ4IRcoxoKg/YWt4qazUPbuScL+xiz24qRpcMyJkQNQA379UUUDH83
         kdUTZY3Si2D82pkbJyoGH03JJp6KtDuv3DN+LybFVnVte0NhrmoA9aPS6xZZbtHqcH4Q
         n0yg==
X-Gm-Message-State: AOJu0YxdwuddOFSBl3VrAHGWi6BNMlaRNF1WcS53Lt6oCw/sFar2cqfB
	VQFGWXBuMODVGiKbmj0/KFxeGah1770b9aR0Uc47fiZtaRXCXfpZNSFd/Q==
X-Google-Smtp-Source: AGHT+IH5eEVy1EXS+kMo5qi7CN95FFpT2Zq/PIEgFCGzQGYuLfxYMXCF6oG07gEWqQmpqgqS/k5dyQ==
X-Received: by 2002:a17:902:ec91:b0:1f6:da67:830b with SMTP id d9443c01a7336-1f9aa46c2a5mr20400825ad.59.1718782862498;
        Wed, 19 Jun 2024 00:41:02 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55eb0sm110458545ad.18.2024.06.19.00.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:41:02 -0700 (PDT)
Date: Wed, 19 Jun 2024 15:41:01 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v4 1/7] fsck: add refs check interfaces to interact
 with fsck error levels
Message-ID: <ZnKLja6bSNLukkTR@ArchLinux>
References: <ZnKKy52QFO2UhqM6@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKKy52QFO2UhqM6@ArchLinux>

The git-fsck(1) focuses on object database consistency check. It relies
on the "fsck_options" to interact with fsck error levels. However,
"fsck_options" aims at checking the object database which contains a lot
of fields only related to object database.

In order to add ref operations, create a new struct named
"fsck_refs_options" and a new struct named "fsck_objs_options". Remove
object-related fields from "fsck_options" to "fsck_objs_options". Change
the "fsck_options" with three parts of members:

1. The "fsck_refs_options".
2. The "fsck_objs_options".
3. The common settings both for refs and objects. Because we leave
   common settings in "fsck_options". The setup process could be fully
   reused without any code changing.

Also add related macros to align with the current code. Because we
remove some fields from "fsck_options" to "fsck_objs_options". Change
the influenced code to use the "fsck_options.objs_options" instead of
using "fsck_options" itself.

The static function "report" provided by "fsck.c" aims at reporting the
problems related to object database which cannot be reused for refs.
Provide "fsck_refs_report" function to integrate the fsck error levels
into reference consistency check.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c           |   8 +--
 builtin/index-pack.c     |   2 +-
 builtin/mktag.c          |   5 +-
 builtin/unpack-objects.c |   2 +-
 fetch-pack.c             |   8 +--
 fsck.c                   | 113 +++++++++++++++++++++++++++++----------
 fsck.h                   |  79 ++++++++++++++++++++-------
 object-file.c            |   2 +-
 8 files changed, 161 insertions(+), 58 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d13a226c2e..a5b82e228c 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -233,7 +233,7 @@ static void mark_unreachable_referents(const struct object_id *oid)
 			object_as_type(obj, type, 0);
 	}
 
-	options.walk = mark_used;
+	options.objs_options.walk = mark_used;
 	fsck_walk(obj, NULL, &options);
 	if (obj->type == OBJ_TREE)
 		free_tree_buffer((struct tree *)obj);
@@ -936,9 +936,9 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
 
-	fsck_walk_options.walk = mark_object;
-	fsck_obj_options.walk = mark_used;
-	fsck_obj_options.error_func = fsck_error_func;
+	fsck_walk_options.objs_options.walk = mark_object;
+	fsck_obj_options.objs_options.walk = mark_used;
+	fsck_obj_options.objs_options.error_func = fsck_error_func;
 	if (check_strict)
 		fsck_obj_options.strict = 1;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 856428fef9..8824d7b8a9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1746,7 +1746,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		usage(index_pack_usage);
 
 	disable_replace_refs();
-	fsck_options.walk = mark_link;
+	fsck_options.objs_options.walk = mark_link;
 
 	reset_pack_idx_option(&opts);
 	opts.flags |= WRITE_REV;
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 4767f1a97e..e88475f009 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -91,8 +91,9 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	if (strbuf_read(&buf, 0, 0) < 0)
 		die_errno(_("could not read from stdin"));
 
-	fsck_options.error_func = mktag_fsck_error_func;
-	fsck_set_msg_type_from_ids(&fsck_options, FSCK_MSG_EXTRA_HEADER_ENTRY,
+	fsck_options.objs_options.error_func = mktag_fsck_error_func;
+	fsck_set_msg_type_from_ids(&fsck_options,
+				   FSCK_MSG_EXTRA_HEADER_ENTRY,
 				   FSCK_WARN);
 	/* config might set fsck.extraHeaderEntry=* again */
 	git_config(git_fsck_config, &fsck_options);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f1c85a00ae..368810a2a1 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -239,7 +239,7 @@ static int check_object(struct object *obj, enum object_type type,
 		die("Whoops! Cannot find object '%s'", oid_to_hex(&obj->oid));
 	if (fsck_object(obj, obj_buf->buffer, obj_buf->size, &fsck_options))
 		die("fsck error in packed object");
-	fsck_options.walk = check_object;
+	fsck_options.objs_options.walk = check_object;
 	if (fsck_walk(obj, NULL, &fsck_options))
 		die("Error on reachable objects of %s", oid_to_hex(&obj->oid));
 	write_cached_object(obj, obj_buf);
diff --git a/fetch-pack.c b/fetch-pack.c
index eba9e420ea..148f9bd371 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1220,7 +1220,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	} else
 		alternate_shallow_file = NULL;
 	if (get_pack(args, fd, pack_lockfiles, NULL, sought, nr_sought,
-		     &fsck_options.gitmodules_found))
+		     &fsck_options.objs_options.gitmodules_found))
 		die(_("git fetch-pack: fetch failed."));
 	if (fsck_finish(&fsck_options))
 		die("fsck failed");
@@ -1780,7 +1780,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 			if (get_pack(args, fd, pack_lockfiles,
 				     packfile_uris.nr ? &index_pack_args : NULL,
-				     sought, nr_sought, &fsck_options.gitmodules_found))
+				     sought, nr_sought,
+				     &fsck_options.objs_options.gitmodules_found))
 				die(_("git fetch-pack: fetch failed."));
 			do_check_stateless_delimiter(args->stateless_rpc, &reader);
 
@@ -1823,7 +1824,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 		packname[the_hash_algo->hexsz] = '\0';
 
-		parse_gitmodules_oids(cmd.out, &fsck_options.gitmodules_found);
+		parse_gitmodules_oids(cmd.out,
+				      &fsck_options.objs_options.gitmodules_found);
 
 		close(cmd.out);
 
diff --git a/fsck.c b/fsck.c
index e193930ae7..4949d2e110 100644
--- a/fsck.c
+++ b/fsck.c
@@ -203,7 +203,8 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 		if (!strcmp(buf, "skiplist")) {
 			if (equal == len)
 				die("skiplist requires a path");
-			oidset_parse_file(&options->skiplist, buf + equal + 1);
+			oidset_parse_file(&options->objs_options.skiplist,
+					  buf + equal + 1);
 			buf += len + 1;
 			continue;
 		}
@@ -220,7 +221,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 static int object_on_skiplist(struct fsck_options *opts,
 			      const struct object_id *oid)
 {
-	return opts && oid && oidset_contains(&opts->skiplist, oid);
+	return opts && oid && oidset_contains(&opts->objs_options.skiplist, oid);
 }
 
 __attribute__((format (printf, 5, 6)))
@@ -249,8 +250,8 @@ static int report(struct fsck_options *options,
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-	result = options->error_func(options, oid, object_type,
-				     msg_type, msg_id, sb.buf);
+	result = options->objs_options.error_func(options, oid, object_type,
+						  msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
 
@@ -259,20 +260,20 @@ static int report(struct fsck_options *options,
 
 void fsck_enable_object_names(struct fsck_options *options)
 {
-	if (!options->object_names)
-		options->object_names = kh_init_oid_map();
+	if (!options->objs_options.object_names)
+		options->objs_options.object_names = kh_init_oid_map();
 }
 
 const char *fsck_get_object_name(struct fsck_options *options,
 				 const struct object_id *oid)
 {
 	khiter_t pos;
-	if (!options->object_names)
+	if (!options->objs_options.object_names)
 		return NULL;
-	pos = kh_get_oid_map(options->object_names, *oid);
-	if (pos >= kh_end(options->object_names))
+	pos = kh_get_oid_map(options->objs_options.object_names, *oid);
+	if (pos >= kh_end(options->objs_options.object_names))
 		return NULL;
-	return kh_value(options->object_names, pos);
+	return kh_value(options->objs_options.object_names, pos);
 }
 
 void fsck_put_object_name(struct fsck_options *options,
@@ -284,15 +285,17 @@ void fsck_put_object_name(struct fsck_options *options,
 	khiter_t pos;
 	int hashret;
 
-	if (!options->object_names)
+	if (!options->objs_options.object_names)
 		return;
 
-	pos = kh_put_oid_map(options->object_names, *oid, &hashret);
+	pos = kh_put_oid_map(options->objs_options.object_names,
+			     *oid, &hashret);
 	if (!hashret)
 		return;
 	va_start(ap, fmt);
 	strbuf_vaddf(&buf, fmt, ap);
-	kh_value(options->object_names, pos) = strbuf_detach(&buf, NULL);
+	kh_value(options->objs_options.object_names, pos) =
+		strbuf_detach(&buf, NULL);
 	va_end(ap);
 }
 
@@ -318,6 +321,7 @@ const char *fsck_describe_object(struct fsck_options *options,
 
 static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *options)
 {
+	struct fsck_objs_options *objs_options = &options->objs_options;
 	struct tree_desc desc;
 	struct name_entry entry;
 	int res = 0;
@@ -342,14 +346,14 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 			if (name && obj)
 				fsck_put_object_name(options, &entry.oid, "%s%s/",
 						     name, entry.path);
-			result = options->walk(obj, OBJ_TREE, data, options);
+			result = objs_options->walk(obj, OBJ_TREE, data, options);
 		}
 		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
 			obj = (struct object *)lookup_blob(the_repository, &entry.oid);
 			if (name && obj)
 				fsck_put_object_name(options, &entry.oid, "%s%s",
 						     name, entry.path);
-			result = options->walk(obj, OBJ_BLOB, data, options);
+			result = objs_options->walk(obj, OBJ_BLOB, data, options);
 		}
 		else {
 			result = error("in tree %s: entry %s has bad mode %.6o",
@@ -366,6 +370,7 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 
 static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_options *options)
 {
+	struct fsck_objs_options *objs_options = &options->objs_options;
 	int counter = 0, generation = 0, name_prefix_len = 0;
 	struct commit_list *parents;
 	int res;
@@ -380,8 +385,8 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 		fsck_put_object_name(options, get_commit_tree_oid(commit),
 				     "%s:", name);
 
-	result = options->walk((struct object *) repo_get_commit_tree(the_repository, commit),
-			       OBJ_TREE, data, options);
+	result = objs_options->walk((struct object *) repo_get_commit_tree(the_repository, commit),
+				    OBJ_TREE, data, options);
 	if (result < 0)
 		return result;
 	res = result;
@@ -423,7 +428,8 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 			else
 				fsck_put_object_name(options, oid, "%s^", name);
 		}
-		result = options->walk((struct object *)parents->item, OBJ_COMMIT, data, options);
+		result = objs_options->walk((struct object *)parents->item,
+					    OBJ_COMMIT, data, options);
 		if (result < 0)
 			return result;
 		if (!res)
@@ -436,12 +442,13 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 static int fsck_walk_tag(struct tag *tag, void *data, struct fsck_options *options)
 {
 	const char *name = fsck_get_object_name(options, &tag->object.oid);
+	struct fsck_objs_options *objs_options = &options->objs_options;
 
 	if (parse_tag(tag))
 		return -1;
 	if (name)
 		fsck_put_object_name(options, &tag->tagged->oid, "%s", name);
-	return options->walk(tag->tagged, OBJ_ANY, data, options);
+	return objs_options->walk(tag->tagged, OBJ_ANY, data, options);
 }
 
 int fsck_walk(struct object *obj, void *data, struct fsck_options *options)
@@ -598,6 +605,7 @@ static int fsck_tree(const struct object_id *tree_oid,
 	unsigned o_mode;
 	const char *o_name;
 	struct name_stack df_dup_candidates = { NULL };
+	struct fsck_objs_options *objs_options = &options->objs_options;
 
 	if (init_tree_desc_gently(&desc, tree_oid, buffer, size,
 				  TREE_DESC_RAW_MODES)) {
@@ -628,7 +636,7 @@ static int fsck_tree(const struct object_id *tree_oid,
 
 		if (is_hfs_dotgitmodules(name) || is_ntfs_dotgitmodules(name)) {
 			if (!S_ISLNK(mode))
-				oidset_insert(&options->gitmodules_found,
+				oidset_insert(&objs_options->gitmodules_found,
 					      entry_oid);
 			else
 				retval += report(options,
@@ -639,7 +647,7 @@ static int fsck_tree(const struct object_id *tree_oid,
 
 		if (is_hfs_dotgitattributes(name) || is_ntfs_dotgitattributes(name)) {
 			if (!S_ISLNK(mode))
-				oidset_insert(&options->gitattributes_found,
+				oidset_insert(&objs_options->gitattributes_found,
 					      entry_oid);
 			else
 				retval += report(options, tree_oid, OBJ_TREE,
@@ -666,7 +674,7 @@ static int fsck_tree(const struct object_id *tree_oid,
 				has_dotgit |= is_ntfs_dotgit(backslash);
 				if (is_ntfs_dotgitmodules(backslash)) {
 					if (!S_ISLNK(mode))
-						oidset_insert(&options->gitmodules_found,
+						oidset_insert(&objs_options->gitmodules_found,
 							      entry_oid);
 					else
 						retval += report(options, tree_oid, OBJ_TREE,
@@ -1102,16 +1110,17 @@ static int fsck_gitmodules_fn(const char *var, const char *value,
 static int fsck_blob(const struct object_id *oid, const char *buf,
 		     unsigned long size, struct fsck_options *options)
 {
+	struct fsck_objs_options *objs_options = &options->objs_options;
 	int ret = 0;
 
 	if (object_on_skiplist(options, oid))
 		return 0;
 
-	if (oidset_contains(&options->gitmodules_found, oid)) {
+	if (oidset_contains(&objs_options->gitmodules_found, oid)) {
 		struct config_options config_opts = { 0 };
 		struct fsck_gitmodules_data data;
 
-		oidset_insert(&options->gitmodules_done, oid);
+		oidset_insert(&objs_options->gitmodules_done, oid);
 
 		if (!buf) {
 			/*
@@ -1137,13 +1146,14 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 		ret |= data.ret;
 	}
 
-	if (oidset_contains(&options->gitattributes_found, oid)) {
+	if (oidset_contains(&objs_options->gitattributes_found, oid)) {
 		const char *ptr;
 
-		oidset_insert(&options->gitattributes_done, oid);
+		oidset_insert(&objs_options->gitattributes_done, oid);
 
 		if (!buf || size > ATTR_MAX_FILE_SIZE) {
 			/*
+
 			 * A missing buffer here is a sign that the caller found the
 			 * blob too gigantic to load into memory. Let's just consider
 			 * that an error.
@@ -1197,6 +1207,20 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 		      type);
 }
 
+int fsck_refs_error_function(struct fsck_options *o UNUSED,
+			     const char *name,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id UNUSED,
+			     const char *message)
+{
+	if (msg_type == FSCK_WARN) {
+		warning("%s: %s", name, message);
+		return 0;
+	}
+	error("%s: %s", name, message);
+	return 1;
+}
+
 int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid,
 			enum object_type object_type UNUSED,
@@ -1255,18 +1279,51 @@ static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 
 int fsck_finish(struct fsck_options *options)
 {
+	struct fsck_objs_options *objs_options = &options->objs_options;
 	int ret = 0;
 
-	ret |= fsck_blobs(&options->gitmodules_found, &options->gitmodules_done,
+	ret |= fsck_blobs(&objs_options->gitmodules_found,
+			  &objs_options->gitmodules_done,
 			  FSCK_MSG_GITMODULES_MISSING, FSCK_MSG_GITMODULES_BLOB,
 			  options, ".gitmodules");
-	ret |= fsck_blobs(&options->gitattributes_found, &options->gitattributes_done,
+	ret |= fsck_blobs(&objs_options->gitattributes_found,
+			  &objs_options->gitattributes_done,
 			  FSCK_MSG_GITATTRIBUTES_MISSING, FSCK_MSG_GITATTRIBUTES_BLOB,
 			  options, ".gitattributes");
 
 	return ret;
 }
 
+int fsck_refs_report(struct fsck_options *o,
+		     const char *name,
+		     enum fsck_msg_id msg_id,
+		     const char *fmt, ...)
+{
+	va_list ap;
+	struct strbuf sb = STRBUF_INIT;
+	enum fsck_msg_type msg_type = fsck_msg_type(msg_id, o);
+	int ret = 0;
+
+	if (msg_type == FSCK_IGNORE)
+		return 0;
+
+	if (msg_type == FSCK_FATAL)
+		msg_type = FSCK_ERROR;
+	else if (msg_type == FSCK_INFO)
+		msg_type = FSCK_WARN;
+
+	prepare_msg_ids();
+	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
+
+	va_start(ap, fmt);
+	strbuf_vaddf(&sb, fmt, ap);
+	ret = o->refs_options.error_func(o, name, msg_type, msg_id, sb.buf);
+	strbuf_release(&sb);
+	va_end(ap);
+
+	return ret;
+}
+
 int git_fsck_config(const char *var, const char *value,
 		    const struct config_context *ctx, void *cb)
 {
diff --git a/fsck.h b/fsck.h
index 6085a384f6..0391dffbb0 100644
--- a/fsck.h
+++ b/fsck.h
@@ -103,6 +103,21 @@ void fsck_set_msg_type(struct fsck_options *options,
 void fsck_set_msg_types(struct fsck_options *options, const char *values);
 int is_valid_msg_type(const char *msg_id, const char *msg_type);
 
+/*
+ * callback function for fsck refs and reflogs.
+ */
+typedef int (*fsck_refs_error)(struct fsck_options *o,
+			       const char *name,
+			       enum fsck_msg_type msg_type,
+			       enum fsck_msg_id msg_id,
+			       const char *message);
+
+int fsck_refs_error_function(struct fsck_options *o,
+			     const char *name,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id,
+			     const char *message);
+
 /*
  * callback function for fsck_walk
  * type is the expected type of the object or OBJ_ANY
@@ -115,10 +130,12 @@ typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
 			      void *data, struct fsck_options *options);
 
 /* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
-typedef int (*fsck_error)(struct fsck_options *o,
-			  const struct object_id *oid, enum object_type object_type,
-			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
-			  const char *message);
+typedef int (*fsck_obj_error)(struct fsck_options *o,
+			      const struct object_id *oid,
+			      enum object_type object_type,
+			      enum fsck_msg_type msg_type,
+			      enum fsck_msg_id msg_id,
+			      const char *message);
 
 int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid, enum object_type object_type,
@@ -131,11 +148,17 @@ int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
 					   enum fsck_msg_id msg_id,
 					   const char *message);
 
-struct fsck_options {
+struct fsck_refs_options {
+	fsck_refs_error error_func;
+};
+
+#define FSCK_REFS_OPTIONS_DEFAULT { \
+	.error_func = fsck_refs_error_function, \
+}
+
+struct fsck_objs_options {
 	fsck_walk_func walk;
-	fsck_error error_func;
-	unsigned strict:1;
-	enum fsck_msg_type *msg_type;
+	fsck_obj_error error_func;
 	struct oidset skiplist;
 	struct oidset gitmodules_found;
 	struct oidset gitmodules_done;
@@ -144,29 +167,43 @@ struct fsck_options {
 	kh_oid_map_t *object_names;
 };
 
-#define FSCK_OPTIONS_DEFAULT { \
+#define FSCK_OBJS_OPTIONS_DEFAULT { \
+	.error_func = fsck_error_function, \
 	.skiplist = OIDSET_INIT, \
 	.gitmodules_found = OIDSET_INIT, \
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function \
 }
-#define FSCK_OPTIONS_STRICT { \
-	.strict = 1, \
+#define FSCK_OBJS_OPTIONS_MISSING_GITMODULES { \
+	.error_func = fsck_error_cb_print_missing_gitmodules, \
 	.gitmodules_found = OIDSET_INIT, \
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function, \
+}
+
+struct fsck_options {
+	struct fsck_refs_options refs_options;
+	struct fsck_objs_options objs_options;
+	enum fsck_msg_type *msg_type;
+	unsigned strict:1,
+		 verbose:1;
+};
+
+#define FSCK_OPTIONS_DEFAULT { \
+	.refs_options = FSCK_REFS_OPTIONS_DEFAULT, \
+	.objs_options = FSCK_OBJS_OPTIONS_DEFAULT, \
+}
+#define FSCK_OPTIONS_STRICT { \
+	.refs_options = FSCK_REFS_OPTIONS_DEFAULT, \
+	.objs_options = FSCK_OBJS_OPTIONS_DEFAULT, \
+	.strict = 1, \
 }
 #define FSCK_OPTIONS_MISSING_GITMODULES { \
+	.refs_options = FSCK_REFS_OPTIONS_DEFAULT, \
+	.objs_options = FSCK_OBJS_OPTIONS_MISSING_GITMODULES, \
 	.strict = 1, \
-	.gitmodules_found = OIDSET_INIT, \
-	.gitmodules_done = OIDSET_INIT, \
-	.gitattributes_found = OIDSET_INIT, \
-	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_cb_print_missing_gitmodules, \
 }
 
 /* descend in all linked child objects
@@ -209,6 +246,12 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  */
 int fsck_finish(struct fsck_options *options);
 
+__attribute__((format (printf, 4, 5)))
+int fsck_refs_report(struct fsck_options *o,
+		     const char *name,
+		     enum fsck_msg_id msg_id,
+		     const char *fmt, ...);
+
 /*
  * Subsystem for storing human-readable names for each object.
  *
diff --git a/object-file.c b/object-file.c
index d3cf4b8b2e..b027d70725 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2510,7 +2510,7 @@ static int index_mem(struct index_state *istate,
 		struct fsck_options opts = FSCK_OPTIONS_DEFAULT;
 
 		opts.strict = 1;
-		opts.error_func = hash_format_check_report;
+		opts.objs_options.error_func = hash_format_check_report;
 		if (fsck_buffer(null_oid(), type, buf, size, &opts))
 			die(_("refusing to create malformed object"));
 		fsck_finish(&opts);
-- 
2.45.2

