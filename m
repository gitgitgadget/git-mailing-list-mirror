Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D816C860
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847087; cv=none; b=YgAeDg0NGSSbhdkU+RFcBSNO0dKb9ru5HZu70wMuHL19qpmywi/R/3qSOcI7AgIABjmT6pqlm2GZfWcXe0yXlAE8FBDx710MQOqs1k8WyeKuItXXhUznWQkPbPJ1EwM6JVAslzdqN1nigclnQ6IcfpNHPXjwOjlY8NrxyS7BW24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847087; c=relaxed/simple;
	bh=HjxRamwIBVDBrJTCPShcqSfW/l9ZybOknzzMbo8NvQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDarlLyzWJGAL2u2iPHG3Y26dy50LHIPxMPzd8dQo2yUWjA4aWCUER1hINXDCgIJa5uPrQZqmwy9u0EuzoK8KLKQ26ZB6DFP5Pz/unalgyqtRNQF5/foVsSVS4p+/3YO9BWOB8e7HbWgeQLLCq2Ewnd2m3HSagikJuwXsxSKYNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frZyZ0Xx; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frZyZ0Xx"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-72c03d2926eso1652419a12.2
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719847084; x=1720451884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KB31NTTQHNW1UpY1yrRGZGvafu+mlGx18fdC0Two3Xo=;
        b=frZyZ0Xx5ul2zDJQrOiBcWWt2jL7xjT0ZWM9+GlsNDyR0ZALo2IKfGzsoVokJWmxIP
         73LUvxKt8pXCGpDK69fTuDVK6GVXe+KR3kDONU/MltWw06FYQXP7Ji2FuaBMxqITB6R0
         XVbV3xhYOIL13thuiJYfhTt24F50RKY8p6Flj4MXZSTkbbnnwIg+gLuj6zPdBUKqPaFb
         l2oaSU9Z5DXZ0D0RCBGFPT6EWY+F8t88Gwm4nurIbWII/6lZzXZ762sOaNAr0jCveXqX
         jxMriPJ7YU2OSqzNl34/dyXbJSWNqsxSlXJqRGZpwqyim69XgXnsJAeNqWbrlLdXZRXO
         9CYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847084; x=1720451884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KB31NTTQHNW1UpY1yrRGZGvafu+mlGx18fdC0Two3Xo=;
        b=eI/PCIbeuE/XW0eQsteEccRsSiXbrhz9uxNzDoaBb8jfDDIHAiqnoFoMei75caluxX
         8jugRaVP77Dka4XLdAvdar9h2PKu7AvQvkZEHAGO/4mmfQI6DQR1UTZKtZr6hgrmk9L0
         xvO8/1ZcLX5pqPLTJId1j7sUX72Pc8ymcvgoEkXHp6Ythd30e7w41Ic3J0L+9MEkhUiv
         b4jsy/XA2To22SLFMzUYoY3kWOfZ5t4TN2ROc1a9zN2npk+yT47GNFkPzE8BGKpWskLG
         l6U3iQGv324g0c22U54gpNSaVVLvCWyAyycUbBy62KGCX0Jgi3PLAcXjx4Y2kIE4w444
         Xs4A==
X-Gm-Message-State: AOJu0YwWJqNEheH+CkDFgN60c0MdvFTMURcyriIlIteWEy5H8ywGinda
	p5JNTwlqYXLhnQhrmjKEnhYDblJWEFH7xCVv6YeA+J7DVKwfUg77co0HMA==
X-Google-Smtp-Source: AGHT+IG/jMmSgBgE1vQsEeuvXbpdfneFxoUseo3OPjC+sB23LtSwCRzU8BJ5JmNNOAwK9+qU/G6tLA==
X-Received: by 2002:a17:90a:1089:b0:2c8:f3b4:421 with SMTP id 98e67ed59e1d1-2c93d6edaffmr2757459a91.4.1719847083599;
        Mon, 01 Jul 2024 08:18:03 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3eed7csm6873716a91.55.2024.07.01.08.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:18:02 -0700 (PDT)
Date: Mon, 1 Jul 2024 23:18:00 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 01/11] fsck: add "fsck_objects_options" to hold
 objects-related options
Message-ID: <ZoLIqOB_X01zdTVi@ArchLinux>
References: <ZoLHtmOKTfxMSxvw@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoLHtmOKTfxMSxvw@ArchLinux>

The git-fsck(1) focuses on object database consistency check. It relies
on the "fsck_options" to interact with fsck error levels. However,
"fsck_options" aims at checking the object database which contains a lot
of fields only related to object database.

In order to add ref operations, remove the options related to objects in
"fsck_options" to "fsck_objects_options" and let the "fsck_options"
incorporate "fsck_objects_options". Change the macros and influenced
code to adapt into the above design.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c           | 12 +++++-----
 builtin/index-pack.c     |  4 ++--
 builtin/mktag.c          |  2 +-
 builtin/unpack-objects.c |  4 ++--
 fetch-pack.c             | 10 ++++----
 fsck.c                   | 51 +++++++++++++++++++++------------------
 fsck.h                   | 52 ++++++++++++++++++++++++----------------
 object-file.c            |  2 +-
 8 files changed, 77 insertions(+), 60 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d13a226c2e..13b64f723f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -42,8 +42,8 @@ static int check_full = 1;
 static int connectivity_only;
 static int check_strict;
 static int keep_cache_objects;
-static struct fsck_options fsck_walk_options = FSCK_OPTIONS_DEFAULT;
-static struct fsck_options fsck_obj_options = FSCK_OPTIONS_DEFAULT;
+static struct fsck_options fsck_walk_options = FSCK_OBJECTS_OPTIONS_DEFAULT;
+static struct fsck_options fsck_obj_options = FSCK_OBJECTS_OPTIONS_DEFAULT;
 static int errors_found;
 static int write_lost_and_found;
 static int verbose;
@@ -214,7 +214,7 @@ static int mark_used(struct object *obj, enum object_type type UNUSED,
 
 static void mark_unreachable_referents(const struct object_id *oid)
 {
-	struct fsck_options options = FSCK_OPTIONS_DEFAULT;
+	struct fsck_options options = FSCK_OBJECTS_OPTIONS_DEFAULT;
 	struct object *obj = lookup_object(the_repository, oid);
 
 	if (!obj || !(obj->flags & HAS_OBJ))
@@ -233,7 +233,7 @@ static void mark_unreachable_referents(const struct object_id *oid)
 			object_as_type(obj, type, 0);
 	}
 
-	options.walk = mark_used;
+	options.objects_options.walk = mark_used;
 	fsck_walk(obj, NULL, &options);
 	if (obj->type == OBJ_TREE)
 		free_tree_buffer((struct tree *)obj);
@@ -936,8 +936,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
 
-	fsck_walk_options.walk = mark_object;
-	fsck_obj_options.walk = mark_used;
+	fsck_walk_options.objects_options.walk = mark_object;
+	fsck_obj_options.objects_options.walk = mark_used;
 	fsck_obj_options.error_func = fsck_error_func;
 	if (check_strict)
 		fsck_obj_options.strict = 1;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 856428fef9..59eb8c0355 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -127,7 +127,7 @@ static int nr_threads;
 static int from_stdin;
 static int strict;
 static int do_fsck_object;
-static struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
+static struct fsck_options fsck_options = FSCK_OBJECTS_OPTIONS_MISSING_GITMODULES;
 static int verbose;
 static const char *progress_title;
 static int show_resolving_progress;
@@ -1746,7 +1746,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		usage(index_pack_usage);
 
 	disable_replace_refs();
-	fsck_options.walk = mark_link;
+	fsck_options.objects_options.walk = mark_link;
 
 	reset_pack_idx_option(&opts);
 	opts.flags |= WRITE_REV;
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 4767f1a97e..c6fbeb58d4 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -15,7 +15,7 @@ static char const * const builtin_mktag_usage[] = {
 };
 static int option_strict = 1;
 
-static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
+static struct fsck_options fsck_options = FSCK_OBJECTS_OPTIONS_STRICT;
 
 static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
 				 const struct object_id *oid UNUSED,
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f1c85a00ae..53cff0a91c 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -25,7 +25,7 @@ static unsigned int offset, len;
 static off_t consumed_bytes;
 static off_t max_input_size;
 static git_hash_ctx ctx;
-static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
+static struct fsck_options fsck_options = FSCK_OBJECTS_OPTIONS_STRICT;
 static struct progress *progress;
 
 /*
@@ -239,7 +239,7 @@ static int check_object(struct object *obj, enum object_type type,
 		die("Whoops! Cannot find object '%s'", oid_to_hex(&obj->oid));
 	if (fsck_object(obj, obj_buf->buffer, obj_buf->size, &fsck_options))
 		die("fsck error in packed object");
-	fsck_options.walk = check_object;
+	fsck_options.objects_options.walk = check_object;
 	if (fsck_walk(obj, NULL, &fsck_options))
 		die("Error on reachable objects of %s", oid_to_hex(&obj->oid));
 	write_cached_object(obj, obj_buf);
diff --git a/fetch-pack.c b/fetch-pack.c
index 42f48fbc31..adce10fb4c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -46,7 +46,7 @@ static int server_supports_filtering;
 static int advertise_sid;
 static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
-static struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
+static struct fsck_options fsck_options = FSCK_OBJECTS_OPTIONS_MISSING_GITMODULES;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
 static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 
@@ -1222,7 +1222,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	} else
 		alternate_shallow_file = NULL;
 	if (get_pack(args, fd, pack_lockfiles, NULL, sought, nr_sought,
-		     &fsck_options.gitmodules_found))
+		     &fsck_options.objects_options.gitmodules_found))
 		die(_("git fetch-pack: fetch failed."));
 	if (fsck_finish(&fsck_options))
 		die("fsck failed");
@@ -1782,7 +1782,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 			if (get_pack(args, fd, pack_lockfiles,
 				     packfile_uris.nr ? &index_pack_args : NULL,
-				     sought, nr_sought, &fsck_options.gitmodules_found))
+				     sought, nr_sought,
+				     &fsck_options.objects_options.gitmodules_found))
 				die(_("git fetch-pack: fetch failed."));
 			do_check_stateless_delimiter(args->stateless_rpc, &reader);
 
@@ -1825,7 +1826,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 		packname[the_hash_algo->hexsz] = '\0';
 
-		parse_gitmodules_oids(cmd.out, &fsck_options.gitmodules_found);
+		parse_gitmodules_oids(cmd.out,
+				      &fsck_options.objects_options.gitmodules_found);
 
 		close(cmd.out);
 
diff --git a/fsck.c b/fsck.c
index e193930ae7..e9848f2678 100644
--- a/fsck.c
+++ b/fsck.c
@@ -259,20 +259,20 @@ static int report(struct fsck_options *options,
 
 void fsck_enable_object_names(struct fsck_options *options)
 {
-	if (!options->object_names)
-		options->object_names = kh_init_oid_map();
+	if (!options->objects_options.object_names)
+		options->objects_options.object_names = kh_init_oid_map();
 }
 
 const char *fsck_get_object_name(struct fsck_options *options,
 				 const struct object_id *oid)
 {
 	khiter_t pos;
-	if (!options->object_names)
+	if (!options->objects_options.object_names)
 		return NULL;
-	pos = kh_get_oid_map(options->object_names, *oid);
-	if (pos >= kh_end(options->object_names))
+	pos = kh_get_oid_map(options->objects_options.object_names, *oid);
+	if (pos >= kh_end(options->objects_options.object_names))
 		return NULL;
-	return kh_value(options->object_names, pos);
+	return kh_value(options->objects_options.object_names, pos);
 }
 
 void fsck_put_object_name(struct fsck_options *options,
@@ -284,15 +284,16 @@ void fsck_put_object_name(struct fsck_options *options,
 	khiter_t pos;
 	int hashret;
 
-	if (!options->object_names)
+	if (!options->objects_options.object_names)
 		return;
 
-	pos = kh_put_oid_map(options->object_names, *oid, &hashret);
+	pos = kh_put_oid_map(options->objects_options.object_names,
+			     *oid, &hashret);
 	if (!hashret)
 		return;
 	va_start(ap, fmt);
 	strbuf_vaddf(&buf, fmt, ap);
-	kh_value(options->object_names, pos) = strbuf_detach(&buf, NULL);
+	kh_value(options->objects_options.object_names, pos) = strbuf_detach(&buf, NULL);
 	va_end(ap);
 }
 
@@ -342,14 +343,14 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 			if (name && obj)
 				fsck_put_object_name(options, &entry.oid, "%s%s/",
 						     name, entry.path);
-			result = options->walk(obj, OBJ_TREE, data, options);
+			result = options->objects_options.walk(obj, OBJ_TREE, data, options);
 		}
 		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
 			obj = (struct object *)lookup_blob(the_repository, &entry.oid);
 			if (name && obj)
 				fsck_put_object_name(options, &entry.oid, "%s%s",
 						     name, entry.path);
-			result = options->walk(obj, OBJ_BLOB, data, options);
+			result = options->objects_options.walk(obj, OBJ_BLOB, data, options);
 		}
 		else {
 			result = error("in tree %s: entry %s has bad mode %.6o",
@@ -380,7 +381,7 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 		fsck_put_object_name(options, get_commit_tree_oid(commit),
 				     "%s:", name);
 
-	result = options->walk((struct object *) repo_get_commit_tree(the_repository, commit),
+	result = options->objects_options.walk((struct object *) repo_get_commit_tree(the_repository, commit),
 			       OBJ_TREE, data, options);
 	if (result < 0)
 		return result;
@@ -423,7 +424,7 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 			else
 				fsck_put_object_name(options, oid, "%s^", name);
 		}
-		result = options->walk((struct object *)parents->item, OBJ_COMMIT, data, options);
+		result = options->objects_options.walk((struct object *)parents->item, OBJ_COMMIT, data, options);
 		if (result < 0)
 			return result;
 		if (!res)
@@ -441,7 +442,7 @@ static int fsck_walk_tag(struct tag *tag, void *data, struct fsck_options *optio
 		return -1;
 	if (name)
 		fsck_put_object_name(options, &tag->tagged->oid, "%s", name);
-	return options->walk(tag->tagged, OBJ_ANY, data, options);
+	return options->objects_options.walk(tag->tagged, OBJ_ANY, data, options);
 }
 
 int fsck_walk(struct object *obj, void *data, struct fsck_options *options)
@@ -598,6 +599,7 @@ static int fsck_tree(const struct object_id *tree_oid,
 	unsigned o_mode;
 	const char *o_name;
 	struct name_stack df_dup_candidates = { NULL };
+	struct fsck_objects_options *objects_options = &options->objects_options;
 
 	if (init_tree_desc_gently(&desc, tree_oid, buffer, size,
 				  TREE_DESC_RAW_MODES)) {
@@ -628,7 +630,7 @@ static int fsck_tree(const struct object_id *tree_oid,
 
 		if (is_hfs_dotgitmodules(name) || is_ntfs_dotgitmodules(name)) {
 			if (!S_ISLNK(mode))
-				oidset_insert(&options->gitmodules_found,
+				oidset_insert(&objects_options->gitmodules_found,
 					      entry_oid);
 			else
 				retval += report(options,
@@ -639,7 +641,7 @@ static int fsck_tree(const struct object_id *tree_oid,
 
 		if (is_hfs_dotgitattributes(name) || is_ntfs_dotgitattributes(name)) {
 			if (!S_ISLNK(mode))
-				oidset_insert(&options->gitattributes_found,
+				oidset_insert(&objects_options->gitattributes_found,
 					      entry_oid);
 			else
 				retval += report(options, tree_oid, OBJ_TREE,
@@ -666,7 +668,7 @@ static int fsck_tree(const struct object_id *tree_oid,
 				has_dotgit |= is_ntfs_dotgit(backslash);
 				if (is_ntfs_dotgitmodules(backslash)) {
 					if (!S_ISLNK(mode))
-						oidset_insert(&options->gitmodules_found,
+						oidset_insert(&objects_options->gitmodules_found,
 							      entry_oid);
 					else
 						retval += report(options, tree_oid, OBJ_TREE,
@@ -1107,11 +1109,11 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 	if (object_on_skiplist(options, oid))
 		return 0;
 
-	if (oidset_contains(&options->gitmodules_found, oid)) {
+	if (oidset_contains(&options->objects_options.gitmodules_found, oid)) {
 		struct config_options config_opts = { 0 };
 		struct fsck_gitmodules_data data;
 
-		oidset_insert(&options->gitmodules_done, oid);
+		oidset_insert(&options->objects_options.gitmodules_done, oid);
 
 		if (!buf) {
 			/*
@@ -1137,10 +1139,10 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 		ret |= data.ret;
 	}
 
-	if (oidset_contains(&options->gitattributes_found, oid)) {
+	if (oidset_contains(&options->objects_options.gitattributes_found, oid)) {
 		const char *ptr;
 
-		oidset_insert(&options->gitattributes_done, oid);
+		oidset_insert(&options->objects_options.gitattributes_done, oid);
 
 		if (!buf || size > ATTR_MAX_FILE_SIZE) {
 			/*
@@ -1255,12 +1257,15 @@ static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 
 int fsck_finish(struct fsck_options *options)
 {
+	struct fsck_objects_options *objects_options = &options->objects_options;
 	int ret = 0;
 
-	ret |= fsck_blobs(&options->gitmodules_found, &options->gitmodules_done,
+	ret |= fsck_blobs(&objects_options->gitmodules_found,
+			  &objects_options->gitmodules_done,
 			  FSCK_MSG_GITMODULES_MISSING, FSCK_MSG_GITMODULES_BLOB,
 			  options, ".gitmodules");
-	ret |= fsck_blobs(&options->gitattributes_found, &options->gitattributes_done,
+	ret |= fsck_blobs(&objects_options->gitattributes_found,
+			  &objects_options->gitattributes_done,
 			  FSCK_MSG_GITATTRIBUTES_MISSING, FSCK_MSG_GITATTRIBUTES_BLOB,
 			  options, ".gitattributes");
 
diff --git a/fsck.h b/fsck.h
index 6085a384f6..37b6f6676f 100644
--- a/fsck.h
+++ b/fsck.h
@@ -131,12 +131,8 @@ int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
 					   enum fsck_msg_id msg_id,
 					   const char *message);
 
-struct fsck_options {
+struct fsck_objects_options {
 	fsck_walk_func walk;
-	fsck_error error_func;
-	unsigned strict:1;
-	enum fsck_msg_type *msg_type;
-	struct oidset skiplist;
 	struct oidset gitmodules_found;
 	struct oidset gitmodules_done;
 	struct oidset gitattributes_found;
@@ -144,29 +140,43 @@ struct fsck_options {
 	kh_oid_map_t *object_names;
 };
 
-#define FSCK_OPTIONS_DEFAULT { \
+struct fsck_options {
+	unsigned strict:1;
+	enum fsck_msg_type *msg_type;
+	struct oidset skiplist;
+	fsck_error error_func;
+	struct fsck_objects_options objects_options;
+};
+
+#define FSCK_OBJECTS_OPTIONS_DEFAULT { \
 	.skiplist = OIDSET_INIT, \
-	.gitmodules_found = OIDSET_INIT, \
-	.gitmodules_done = OIDSET_INIT, \
-	.gitattributes_found = OIDSET_INIT, \
-	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function \
+	.error_func = fsck_error_function, \
+	.objects_options = { \
+		.gitmodules_found = OIDSET_INIT, \
+		.gitmodules_done = OIDSET_INIT, \
+		.gitattributes_found = OIDSET_INIT, \
+		.gitattributes_done = OIDSET_INIT, \
+	} \
 }
-#define FSCK_OPTIONS_STRICT { \
+#define FSCK_OBJECTS_OPTIONS_STRICT { \
 	.strict = 1, \
-	.gitmodules_found = OIDSET_INIT, \
-	.gitmodules_done = OIDSET_INIT, \
-	.gitattributes_found = OIDSET_INIT, \
-	.gitattributes_done = OIDSET_INIT, \
 	.error_func = fsck_error_function, \
+	.objects_options = { \
+		.gitmodules_found = OIDSET_INIT, \
+		.gitmodules_done = OIDSET_INIT, \
+		.gitattributes_found = OIDSET_INIT, \
+		.gitattributes_done = OIDSET_INIT, \
+	} \
 }
-#define FSCK_OPTIONS_MISSING_GITMODULES { \
+#define FSCK_OBJECTS_OPTIONS_MISSING_GITMODULES { \
 	.strict = 1, \
-	.gitmodules_found = OIDSET_INIT, \
-	.gitmodules_done = OIDSET_INIT, \
-	.gitattributes_found = OIDSET_INIT, \
-	.gitattributes_done = OIDSET_INIT, \
 	.error_func = fsck_error_cb_print_missing_gitmodules, \
+	.objects_options = { \
+		.gitmodules_found = OIDSET_INIT, \
+		.gitmodules_done = OIDSET_INIT, \
+		.gitattributes_found = OIDSET_INIT, \
+		.gitattributes_done = OIDSET_INIT, \
+	} \
 }
 
 /* descend in all linked child objects
diff --git a/object-file.c b/object-file.c
index d3cf4b8b2e..4e10dd9804 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2507,7 +2507,7 @@ static int index_mem(struct index_state *istate,
 		}
 	}
 	if (flags & HASH_FORMAT_CHECK) {
-		struct fsck_options opts = FSCK_OPTIONS_DEFAULT;
+		struct fsck_options opts = FSCK_OBJECTS_OPTIONS_DEFAULT;
 
 		opts.strict = 1;
 		opts.error_func = hash_format_check_report;
-- 
2.45.2

