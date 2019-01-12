Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 499F8211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 02:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfALCOl (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 21:14:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39254 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfALCOl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 21:14:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so7769188pfc.6
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 18:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rCbUbTwOED+MvoKndioE86rcmfuMZfhcKYSFSrzJf1Y=;
        b=QngbHNLnh/O3wCMHFgpgnxgaL32MypAnzXCla37fCC886ZSIAo5RqPgTy8NWZXDq5p
         kmEpFRSp/sC9EGjKFTGSICkA05mlakcEvbACsdlMHJhzocn8AtGo+g+YqpM1fwjVA+SV
         17G/rUKcj7nn/0Xvqnf1CHlPdLmto/C0l8fcNx0nNlzq3826RRJXEldXtne/oeg7OpWV
         RZ4iEFp0V1gMj9hJq7+uab/RGoYXhJu8hLic8P2eThm6fHCTJM0Qp7SzpVppDzcjYBIB
         /M78K6PUGXoVBBMbkNM1CLmjCefvLPnJxzNY78iaUm/oiEIxmwDRYXRdyjW6pbSab30N
         cngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rCbUbTwOED+MvoKndioE86rcmfuMZfhcKYSFSrzJf1Y=;
        b=UHY8UOMogGOX9916WM6u08ntNBlrP5nxNFSOdQ1HrPCVDLeyfYUXC24CYtHRt+OTvI
         RPqBRCqMovcnF2sKyheqpNIJBFLZKDrCaCtD2NWDNkdreo7fuNahmF7dp/Lb1mlrWg9i
         eLQDBxDl5WEnNfLRxcnUmrhuzT4RQHdDBU+P4+Kk1RDKReSnjrl01zICnvNU0jTlCSGP
         2es1AMUSl2PR5B5I2JPmGeK/JXGUQr01FN3EyOHjJ+ox8dB8fDXvja5FmY8adNQd0pJ7
         a6UlQyVlz4SF/mpgQdHNABtAcVhy11SXjQf9GrFre4ey845JO8jwnPsA+TLpHXE0iqLX
         rTrQ==
X-Gm-Message-State: AJcUukcQhS+2WtnJZODsmD7/0aDJoVwe/SGUtaH2TzQPtKYio4QJomps
        kdKO+EGfiFrgtsihqiUrryzMDimA
X-Google-Smtp-Source: ALg8bN6DKuR2LyyC6H9q1f4os+074wj65tdKGkUFTPxPR7ue9zI5ENHi584Nxm0egkg1jYRehu9/Yg==
X-Received: by 2002:a63:8742:: with SMTP id i63mr15374876pge.298.1547259279677;
        Fri, 11 Jan 2019 18:14:39 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id u70sm136409897pfa.176.2019.01.11.18.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 18:14:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Jan 2019 09:14:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 07/11] sha1-name.c: remove implicit dependency on the_index
Date:   Sat, 12 Jan 2019 09:13:28 +0700
Message-Id: <20190112021332.11066-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190112021332.11066-1-pclouds@gmail.com>
References: <20190105055153.3256-1-pclouds@gmail.com>
 <20190112021332.11066-1-pclouds@gmail.com>
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
2.20.0.482.g66447595a7

