Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1E1B1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 08:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfAXI37 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 03:29:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43919 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfAXI36 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 03:29:58 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so2339936pgk.10
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 00:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pq21x/J5KITm8ZYvGUYS0qVC+E3dqTdGNCxGWD+WY6o=;
        b=ICcKDp43uh1h+8zwuVKLjBWBrNMCfsDFVeuZMW9I5U+nZlhVZiTs47PaO02j4fQ3pg
         6GE0ikLw6mpWGMis1xzMIvTSaGW/pX97DtKp3aGTwYdzPdHGHzApH7vmP5NjkD+MjqDd
         xqzjTZ8CP1/e67wRs3D2SgLA+XW1DxSwh2D5cNJafZ7PxT9Tr+ywZzctzezovNydnpUM
         HnY/ALH0ZkkXEzWBSQpzyArZsDKv0DvhjMVK2QCFvNesVYMEZRJu9wHZVYDncSumtAYc
         L72YYIk0VU5IDQcFjtr8c1SoK7qC+B7M5ok0KTE6UPmAOzpi8FjVw3ALxHf3qb4wXsM6
         uYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pq21x/J5KITm8ZYvGUYS0qVC+E3dqTdGNCxGWD+WY6o=;
        b=PiDP4sRxV+oTKuUvB0uNsSM9EbD+1d/lTn/VkNqeVwq+DgZAGrmodgftR5a9A2oOy1
         JJPPTL8QMqcMHihdf8FT7qJD/9cyBT0v6Fl0nviQfz6woYcFmQeDt/hvWdyTVU1xPTN7
         4dRfhJnW4tDGkIDovDWleLNDUmysaxtkpkMY7r9GL4ILGbOys3WWFMuQ1CSKqh5fiGWy
         p+2velA3gJRgHXM7RbdIthJo4lNuuNoOPPlyfQSJfRyAfc7xIVuTSpCZu9Ul5Ou9Zw/G
         U1tmeEAci7H4a6K5PSybPUhMslfEiTwgGMNF8cVrALn6V/tCc+3ZmZm41PGH3Dbg3Ts2
         RuIg==
X-Gm-Message-State: AJcUukfzbkdoaK5j+yTzRjXzZR1Ezs7i7HwXR1oVABLK5moBNT6fC5QX
        kHx4rRDZCaF7Bjazefy1uDFDqL1SSrU=
X-Google-Smtp-Source: ALg8bN5ZcME9iFyJFerupgla7xGjLeh9TBhOqdFJanfGlUYiR9nL0UVk3tAhQMFerfXrTQ7c4o+JqQ==
X-Received: by 2002:a62:3541:: with SMTP id c62mr5510373pfa.19.1548318596713;
        Thu, 24 Jan 2019 00:29:56 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id m65sm49830264pfg.180.2019.01.24.00.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 00:29:55 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 24 Jan 2019 15:29:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/11] sha1-name.c: remove implicit dependency on the_index
Date:   Thu, 24 Jan 2019 15:29:08 +0700
Message-Id: <20190124082912.24401-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190124082912.24401-1-pclouds@gmail.com>
References: <20190124082912.24401-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This kills the_index dependency in get_oid_with_context() but for
get_oid() and friends, they still assume the_repository (which also
means the_index).

Unfortunately the widespread use of get_oid() will make it hard to
make the conversion now. We probably will add repo_get_oid() at some
point and limit the use of get_oid() in builtin/ instead of forcing
all get_oid() call sites to carry struct repository.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/cat-file.c            |  6 ++--
 builtin/grep.c                |  3 +-
 builtin/log.c                 |  3 +-
 builtin/rev-parse.c           |  3 +-
 cache.h                       |  4 ++-
 list-objects-filter-options.c |  2 +-
 revision.c                    |  8 +++---
 sha1-name.c                   | 54 +++++++++++++++++++++--------------
 8 files changed, 50 insertions(+), 33 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2ca56fd086..7622c502f0 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -73,7 +73,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	if (unknown_type)
 		flags |= OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
-	if (get_oid_with_context(obj_name, GET_OID_RECORD_PATH,
+	if (get_oid_with_context(the_repository, obj_name,
+				 GET_OID_RECORD_PATH,
 				 &oid, &obj_context))
 		die("Not a valid object name %s", obj_name);
 
@@ -382,7 +383,8 @@ static void batch_one_object(const char *obj_name,
 	int flags = opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0;
 	enum follow_symlinks_result result;
 
-	result = get_oid_with_context(obj_name, flags, &data->oid, &ctx);
+	result = get_oid_with_context(the_repository, obj_name,
+				      flags, &data->oid, &ctx);
 	if (result != FOUND) {
 		switch (result) {
 		case MISSING_OBJECT:
diff --git a/builtin/grep.c b/builtin/grep.c
index 0cc671f7d6..fc7a9a9283 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1021,7 +1021,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			break;
 		}
 
-		if (get_oid_with_context(arg, GET_OID_RECORD_PATH,
+		if (get_oid_with_context(the_repository, arg,
+					 GET_OID_RECORD_PATH,
 					 &oid, &oc)) {
 			if (seen_dashdash)
 				die(_("unable to resolve revision: %s"), arg);
diff --git a/builtin/log.c b/builtin/log.c
index e8e51068bd..dbfb4e31ad 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -508,7 +508,8 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 	    !rev->diffopt.flags.allow_textconv)
 		return stream_blob_to_fd(1, oid, NULL, 0);
 
-	if (get_oid_with_context(obj_name, GET_OID_RECORD_PATH,
+	if (get_oid_with_context(the_repository, obj_name,
+				 GET_OID_RECORD_PATH,
 				 &oidc, &obj_context))
 		die(_("Not a valid object name %s"), obj_name);
 	if (!obj_context.path ||
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 10d4dab894..910a71ed8b 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -933,7 +933,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			name++;
 			type = REVERSED;
 		}
-		if (!get_oid_with_context(name, flags, &oid, &unused)) {
+		if (!get_oid_with_context(the_repository, name,
+					  flags, &oid, &unused)) {
 			if (verify)
 				revs_count++;
 			else
diff --git a/cache.h b/cache.h
index 702c5bfbb3..fdcd69bfb0 100644
--- a/cache.h
+++ b/cache.h
@@ -1328,7 +1328,9 @@ extern int get_oid_tree(const char *str, struct object_id *oid);
 extern int get_oid_treeish(const char *str, struct object_id *oid);
 extern int get_oid_blob(const char *str, struct object_id *oid);
 extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
-extern int get_oid_with_context(const char *str, unsigned flags, struct object_id *oid, struct object_context *oc);
+extern int get_oid_with_context(struct repository *repo, const char *str,
+				unsigned flags, struct object_id *oid,
+				struct object_context *oc);
 
 
 typedef int each_abbrev_fn(const struct object_id *oid, void *);
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index e8da2e8581..8443184e22 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -71,7 +71,7 @@ static int gently_parse_list_objects_filter(
 		 * command, but DO NOT complain if we don't have the blob or
 		 * ref locally.
 		 */
-		if (!get_oid_with_context(v0, GET_OID_BLOB,
+		if (!get_oid_with_context(the_repository, v0, GET_OID_BLOB,
 					  &sparse_oid, &oc))
 			filter_options->sparse_oid_value = oiddup(&sparse_oid);
 		filter_options->choice = LOFC_SPARSE_OID;
diff --git a/revision.c b/revision.c
index c51ea6a052..4a723efe9a 100644
--- a/revision.c
+++ b/revision.c
@@ -1589,8 +1589,8 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 	if (!*b_name)
 		b_name = "HEAD";
 
-	if (get_oid_with_context(a_name, oc_flags, &a_oid, a_oc) ||
-	    get_oid_with_context(b_name, oc_flags, &b_oid, b_oc))
+	if (get_oid_with_context(revs->repo, a_name, oc_flags, &a_oid, a_oc) ||
+	    get_oid_with_context(revs->repo, b_name, oc_flags, &b_oid, b_oc))
 		return -1;
 
 	if (!cant_be_filename) {
@@ -1724,7 +1724,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	if (revarg_opt & REVARG_COMMITTISH)
 		get_sha1_flags |= GET_OID_COMMITTISH;
 
-	if (get_oid_with_context(arg, get_sha1_flags, &oid, &oc))
+	if (get_oid_with_context(revs->repo, arg, get_sha1_flags, &oid, &oc))
 		return revs->ignore_missing ? 0 : -1;
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
@@ -2453,7 +2453,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		struct object_id oid;
 		struct object *object;
 		struct object_context oc;
-		if (get_oid_with_context(revs->def, 0, &oid, &oc))
+		if (get_oid_with_context(revs->repo, revs->def, 0, &oid, &oc))
 			diagnose_missing_default(revs->def);
 		object = get_reference(revs, revs->def, &oid, 0);
 		add_pending_object_with_mode(revs, object, revs->def, oc.mode);
diff --git a/sha1-name.c b/sha1-name.c
index a0fc1008ec..d8cab7b5a6 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1513,7 +1513,7 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 int get_oid(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, 0, oid, &unused);
+	return get_oid_with_context(the_repository, name, 0, oid, &unused);
 }
 
 
@@ -1530,35 +1530,40 @@ int get_oid(const char *name, struct object_id *oid)
 int get_oid_committish(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, GET_OID_COMMITTISH,
+	return get_oid_with_context(the_repository,
+				    name, GET_OID_COMMITTISH,
 				    oid, &unused);
 }
 
 int get_oid_treeish(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, GET_OID_TREEISH,
+	return get_oid_with_context(the_repository,
+				    name, GET_OID_TREEISH,
 				    oid, &unused);
 }
 
 int get_oid_commit(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, GET_OID_COMMIT,
+	return get_oid_with_context(the_repository,
+				    name, GET_OID_COMMIT,
 				    oid, &unused);
 }
 
 int get_oid_tree(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, GET_OID_TREE,
+	return get_oid_with_context(the_repository,
+				    name, GET_OID_TREE,
 				    oid, &unused);
 }
 
 int get_oid_blob(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, GET_OID_BLOB,
+	return get_oid_with_context(the_repository,
+				    name, GET_OID_BLOB,
 				    oid, &unused);
 }
 
@@ -1597,7 +1602,8 @@ static void diagnose_invalid_oid_path(const char *prefix,
 }
 
 /* Must be called only when :stage:filename doesn't exist. */
-static void diagnose_invalid_index_path(int stage,
+static void diagnose_invalid_index_path(struct index_state *istate,
+					int stage,
 					const char *prefix,
 					const char *filename)
 {
@@ -1610,11 +1616,11 @@ static void diagnose_invalid_index_path(int stage,
 		prefix = "";
 
 	/* Wrong stage number? */
-	pos = cache_name_pos(filename, namelen);
+	pos = index_name_pos(istate, filename, namelen);
 	if (pos < 0)
 		pos = -pos - 1;
-	if (pos < active_nr) {
-		ce = active_cache[pos];
+	if (pos < istate->cache_nr) {
+		ce = istate->cache[pos];
 		if (ce_namelen(ce) == namelen &&
 		    !memcmp(ce->name, filename, namelen))
 			die("Path '%s' is in the index, but not at stage %d.\n"
@@ -1626,11 +1632,11 @@ static void diagnose_invalid_index_path(int stage,
 	/* Confusion between relative and absolute filenames? */
 	strbuf_addstr(&fullname, prefix);
 	strbuf_addstr(&fullname, filename);
-	pos = cache_name_pos(fullname.buf, fullname.len);
+	pos = index_name_pos(istate, fullname.buf, fullname.len);
 	if (pos < 0)
 		pos = -pos - 1;
-	if (pos < active_nr) {
-		ce = active_cache[pos];
+	if (pos < istate->cache_nr) {
+		ce = istate->cache[pos];
 		if (ce_namelen(ce) == fullname.len &&
 		    !memcmp(ce->name, fullname.buf, fullname.len))
 			die("Path '%s' is in the index, but not '%s'.\n"
@@ -1664,7 +1670,8 @@ static char *resolve_relative_path(const char *rel)
 			   rel);
 }
 
-static int get_oid_with_context_1(const char *name,
+static int get_oid_with_context_1(struct repository *repo,
+				  const char *name,
 				  unsigned flags,
 				  const char *prefix,
 				  struct object_id *oid,
@@ -1723,13 +1730,13 @@ static int get_oid_with_context_1(const char *name,
 		if (flags & GET_OID_RECORD_PATH)
 			oc->path = xstrdup(cp);
 
-		if (!the_index.cache)
+		if (!repo->index->cache)
 			repo_read_index(the_repository);
-		pos = index_name_pos(&the_index, cp, namelen);
+		pos = index_name_pos(repo->index, cp, namelen);
 		if (pos < 0)
 			pos = -pos - 1;
-		while (pos < active_nr) {
-			ce = active_cache[pos];
+		while (pos < repo->index->cache_nr) {
+			ce = repo->index->cache[pos];
 			if (ce_namelen(ce) != namelen ||
 			    memcmp(ce->name, cp, namelen))
 				break;
@@ -1742,7 +1749,7 @@ static int get_oid_with_context_1(const char *name,
 			pos++;
 		}
 		if (only_to_die && name[1] && name[1] != '/')
-			diagnose_invalid_index_path(stage, prefix, cp);
+			diagnose_invalid_index_path(repo->index, stage, prefix, cp);
 		free(new_path);
 		return -1;
 	}
@@ -1807,12 +1814,15 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
 {
 	struct object_context oc;
 	struct object_id oid;
-	get_oid_with_context_1(name, GET_OID_ONLY_TO_DIE, prefix, &oid, &oc);
+	get_oid_with_context_1(the_repository, name, GET_OID_ONLY_TO_DIE,
+			       prefix, &oid, &oc);
 }
 
-int get_oid_with_context(const char *str, unsigned flags, struct object_id *oid, struct object_context *oc)
+int get_oid_with_context(struct repository *repo, const char *str,
+			 unsigned flags, struct object_id *oid,
+			 struct object_context *oc)
 {
 	if (flags & GET_OID_FOLLOW_SYMLINKS && flags & GET_OID_ONLY_TO_DIE)
 		BUG("incompatible flags for get_sha1_with_context");
-	return get_oid_with_context_1(str, flags, NULL, oid, oc);
+	return get_oid_with_context_1(repo, str, flags, NULL, oid, oc);
 }
-- 
2.20.1.560.g70ca8b83ee

