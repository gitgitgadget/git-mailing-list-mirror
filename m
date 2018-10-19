Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 378DC1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeJSW73 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42904 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeJSW72 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id y71-v6so31082754lje.9
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pskg+QzzV4GVnpM2RFu+JFZIp5wxuQH/+d8VIQ80gp4=;
        b=dIsFEF7ThDzLXXMkPoDgH4LHg4YJV/w7P9ISRctRYNdrIv38oawEmycIxeS1U/r6JO
         S1WHD/+JUxQ/w1JVZxDEYM5/ylgt8veRxO6Z1Px8B5ybWV2OYWgJX6ReatYUOpt6+eDg
         6MX9TfDGvnGSaX2L1NRrWAm6K9DvegVpGN4SE0vyIWuXNpdFVsTIybJhctp7wevIuRjc
         +NdH5ckdPWW/3nlVY7BGaVdFu5gABIZyvOS3tIu/emjdG9sWbkI7+dKP3tg14CU5R37d
         L7pAwsVn7ec7iPhzAq/fcXwGJBZGaZiZypMb4RMvWyhNV4qxJJ98W79A8udom7vNTGrF
         uX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pskg+QzzV4GVnpM2RFu+JFZIp5wxuQH/+d8VIQ80gp4=;
        b=jWwS+7BI7wd1aimFYNyWqieuEFPPEfLn7d3Hp3s5PC+4wsZtzwF9RIIZvDVuyK32b4
         eyCswL1uIrxtRycFAsLWdycrv4yiGFqnJc9MU1pmaJp4QL8B2FZbfP24Oi9t4N2+M7Gg
         YETF1C2aUiX+wrKJTHwfotml0Qb0ZOqwpqhdKl6TI9RGUpm5k0fD1MDeGotpSfhHZlof
         leNTXsNh/M07NtjRgqKTwv5jbAXBqPzn4XS7dtFuDz94mdQe3hjf9QYXHVQREu+K2osL
         Dko2DzdfgOKC8jx2XeeX2BJg1We6/PdPRTlx+aRFc5usvAS992iTxkDdULTo5o537LCD
         EGXQ==
X-Gm-Message-State: ABuFfogXYuaHdWGSEs6JzrkUg17i2yZA9ch3VbocvktpfU5cVqZkEHB2
        eqLVp/aEV3VGdtpSLwYuwLMwL3+S
X-Google-Smtp-Source: ACcGV63k2IACT8vj5RLbxFvn2u7JOraRBFPSSB0Gn6d8Do7CqqYBNszwT3FBHXMgoVdAypZzVlQQuA==
X-Received: by 2002:a2e:5d16:: with SMTP id r22-v6mr25184192ljb.89.1539960778707;
        Fri, 19 Oct 2018 07:52:58 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:52:58 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/19] sha1-name.c: remove implicit dependency on the_index
Date:   Fri, 19 Oct 2018 16:52:32 +0200
Message-Id: <20181019145237.16079-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181019145237.16079-1-pclouds@gmail.com>
References: <20181019145237.16079-1-pclouds@gmail.com>
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
index 8d97c84725..17faea8846 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -66,7 +66,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	if (unknown_type)
 		flags |= OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
-	if (get_oid_with_context(obj_name, GET_OID_RECORD_PATH,
+	if (get_oid_with_context(the_repository, obj_name,
+				 GET_OID_RECORD_PATH,
 				 &oid, &obj_context))
 		die("Not a valid object name %s", obj_name);
 
@@ -374,7 +375,8 @@ static void batch_one_object(const char *obj_name,
 	int flags = opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0;
 	enum follow_symlinks_result result;
 
-	result = get_oid_with_context(obj_name, flags, &data->oid, &ctx);
+	result = get_oid_with_context(the_repository, obj_name,
+				      flags, &data->oid, &ctx);
 	if (result != FOUND) {
 		switch (result) {
 		case MISSING_OBJECT:
diff --git a/builtin/grep.c b/builtin/grep.c
index d8508ddf79..9d40b5c073 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1006,7 +1006,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			break;
 		}
 
-		if (get_oid_with_context(arg, GET_OID_RECORD_PATH,
+		if (get_oid_with_context(the_repository, arg,
+					 GET_OID_RECORD_PATH,
 					 &oid, &oc)) {
 			if (seen_dashdash)
 				die(_("unable to resolve revision: %s"), arg);
diff --git a/builtin/log.c b/builtin/log.c
index 061d4fd864..ed28e81a22 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -506,7 +506,8 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 	    !rev->diffopt.flags.allow_textconv)
 		return stream_blob_to_fd(1, oid, NULL, 0);
 
-	if (get_oid_with_context(obj_name, GET_OID_RECORD_PATH,
+	if (get_oid_with_context(the_repository, obj_name,
+				 GET_OID_RECORD_PATH,
 				 &oidc, &obj_context))
 		die(_("Not a valid object name %s"), obj_name);
 	if (!obj_context.path ||
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 455f62246d..38d7d8fd74 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -932,7 +932,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
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
index 73bf68d8a5..91c092cf76 100644
--- a/cache.h
+++ b/cache.h
@@ -1327,7 +1327,9 @@ extern int get_oid_tree(const char *str, struct object_id *oid);
 extern int get_oid_treeish(const char *str, struct object_id *oid);
 extern int get_oid_blob(const char *str, struct object_id *oid);
 extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
-extern int get_oid_with_context(const char *str, unsigned flags, struct object_id *oid, struct object_context *oc);
+extern int get_oid_with_context(struct repository *repo, const char *str,
+				unsigned flags, struct object_id *oid,
+				struct object_context *oc);
 
 
 typedef int each_abbrev_fn(const struct object_id *oid, void *);
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index c0e2bd6a06..a683a75a35 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -59,7 +59,7 @@ static int gently_parse_list_objects_filter(
 		 * command, but DO NOT complain if we don't have the blob or
 		 * ref locally.
 		 */
-		if (!get_oid_with_context(v0, GET_OID_BLOB,
+		if (!get_oid_with_context(the_repository, v0, GET_OID_BLOB,
 					  &sparse_oid, &oc))
 			filter_options->sparse_oid_value = oiddup(&sparse_oid);
 		filter_options->choice = LOFC_SPARSE_OID;
diff --git a/revision.c b/revision.c
index 3138c11ec5..ebbf382e3f 100644
--- a/revision.c
+++ b/revision.c
@@ -1577,8 +1577,8 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 	if (!*b_name)
 		b_name = "HEAD";
 
-	if (get_oid_with_context(a_name, oc_flags, &a_oid, a_oc) ||
-	    get_oid_with_context(b_name, oc_flags, &b_oid, b_oc))
+	if (get_oid_with_context(revs->repo, a_name, oc_flags, &a_oid, a_oc) ||
+	    get_oid_with_context(revs->repo, b_name, oc_flags, &b_oid, b_oc))
 		return -1;
 
 	if (!cant_be_filename) {
@@ -1712,7 +1712,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	if (revarg_opt & REVARG_COMMITTISH)
 		get_sha1_flags |= GET_OID_COMMITTISH;
 
-	if (get_oid_with_context(arg, get_sha1_flags, &oid, &oc))
+	if (get_oid_with_context(revs->repo, arg, get_sha1_flags, &oid, &oc))
 		return revs->ignore_missing ? 0 : -1;
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
@@ -2440,7 +2440,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		struct object_id oid;
 		struct object *object;
 		struct object_context oc;
-		if (get_oid_with_context(revs->def, 0, &oid, &oc))
+		if (get_oid_with_context(revs->repo, revs->def, 0, &oid, &oc))
 			diagnose_missing_default(revs->def);
 		object = get_reference(revs, revs->def, &oid, 0);
 		add_pending_object_with_mode(revs, object, revs->def, oc.mode);
diff --git a/sha1-name.c b/sha1-name.c
index 8669ad0b47..1465b9f1da 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1539,7 +1539,7 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 int get_oid(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, 0, oid, &unused);
+	return get_oid_with_context(the_repository, name, 0, oid, &unused);
 }
 
 
@@ -1556,35 +1556,40 @@ int get_oid(const char *name, struct object_id *oid)
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
 
@@ -1623,7 +1628,8 @@ static void diagnose_invalid_oid_path(const char *prefix,
 }
 
 /* Must be called only when :stage:filename doesn't exist. */
-static void diagnose_invalid_index_path(int stage,
+static void diagnose_invalid_index_path(struct index_state *istate,
+					int stage,
 					const char *prefix,
 					const char *filename)
 {
@@ -1636,11 +1642,11 @@ static void diagnose_invalid_index_path(int stage,
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
@@ -1652,11 +1658,11 @@ static void diagnose_invalid_index_path(int stage,
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
@@ -1690,7 +1696,8 @@ static char *resolve_relative_path(const char *rel)
 			   rel);
 }
 
-static int get_oid_with_context_1(const char *name,
+static int get_oid_with_context_1(struct repository *repo,
+				  const char *name,
 				  unsigned flags,
 				  const char *prefix,
 				  struct object_id *oid,
@@ -1749,13 +1756,13 @@ static int get_oid_with_context_1(const char *name,
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
@@ -1768,7 +1775,7 @@ static int get_oid_with_context_1(const char *name,
 			pos++;
 		}
 		if (only_to_die && name[1] && name[1] != '/')
-			diagnose_invalid_index_path(stage, prefix, cp);
+			diagnose_invalid_index_path(repo->index, stage, prefix, cp);
 		free(new_path);
 		return -1;
 	}
@@ -1833,12 +1840,15 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
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
2.19.1.647.g708186aaf9

