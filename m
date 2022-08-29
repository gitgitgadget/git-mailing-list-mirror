Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56984C0502C
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 20:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiH2Uya (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 16:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiH2UyY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 16:54:24 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231E3861D5
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 13:54:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c7so4984389wrp.11
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 13:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=qmsYLljht0Usq3r7uS3Jei7wDsWb5bwYrAKGSGWUZVA=;
        b=Lu8WtaHpM8dCvSPuhoAKeio5DenOYppdCWSe8uyDWDjtsA30OzgiwU+ZIMa10wYHCM
         4/dXgEZfHl57pGz8eLclIIMUBycp7UcRlydcIb61Y0W+MTEROtqKoyaOHV7kMQdoxzku
         p3Sjx67YzfF1UsoCq2wd7wbO1nhfbeNdOINn2r09b271F46/wA3h4asRNPzkLnm5Homr
         lw7gl0ytI0YTYaCwImrck1pTm/kkQVp/ZXeRk9tMvHQoavS+DyW2Cbtnga/2qXuUICsV
         e3YRt7SDAiffJj97osjIVOtf1G+i29JxjbzfYkJA7OhugeJ+cHHlQ3qT+9fy4cH7Tnwk
         mKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=qmsYLljht0Usq3r7uS3Jei7wDsWb5bwYrAKGSGWUZVA=;
        b=yXbX8qQ2hpCGUmveglL3r9c/ON0RBTsIi7ckFL5/gHl3ee0wdsvRyRZRGtvRmUIS5p
         Ad7Tm0B2F6w8dJgjuzVfhRQLaYpeHiTLArpkfKTqMgS1Pe+aqOBTArwM8nTwTG9LGWOJ
         iXdGtfDBKEOzQ877ZqWjDIiSGTmdTR5iGXZ35eMgY04x5jbQcf3Akv/LFoPPsOOCqfwR
         WgBjWZGsRpM2rlcc4pp4/K8iAZx7xMSzBVhw/f6JK0xPp56tko7E1u4ukpUPW39euwkU
         3RIRz29GZrn92QIQIrJLnKcwwWW6lc2C85m9Lr+bXgpoJtI3M1ARMvamJtMDaKPZOA8y
         wRQA==
X-Gm-Message-State: ACgBeo2jysyk/G1L21MdIoEQewlyY9n0Q3Ylr9Lgrb46qEDjp5lADpb2
        od1p0dY/1QdwnJ9jJqzHg6tmuuvZow4=
X-Google-Smtp-Source: AA6agR63H8Yt6tlE/uJHDGPjWSIBbRm8fvL5AHYHuJ+inVq5fxdYSlNwMkzfvPMh/wwA6r1h5DOpsQ==
X-Received: by 2002:a5d:64e2:0:b0:225:79d3:d6c4 with SMTP id g2-20020a5d64e2000000b0022579d3d6c4mr7315777wri.464.1661806461311;
        Mon, 29 Aug 2022 13:54:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d4452000000b00225307f43fbsm7764007wrr.44.2022.08.29.13.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 13:54:20 -0700 (PDT)
Message-Id: <eab40dcb296fd6a6ea14d13107cdc3ca6e64e311.1661806456.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Aug 2022 20:54:14 +0000
Subject: [PATCH 4/6] submodule: return target of submodule symref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

resolve_gitlink_ref() can tell us which oid the submodule ref is
pointing to, but in a future commit, we would also like to know the
symbolic ref target if we are checking a symbolic ref. Teach
resolve_gitlink_ref() to "return" the symbolic ref's target via an "out"
parameter.

This changes resolve_gitlink_ref()'s signature so that new callers
trying to use the old signature will be stopped by the compiler. If we
returned the target instead (just like refs_resolve_ref_unsafe()), we
would be more consistent with refs_resolve_ref_unsafe(), but callers
expecting the old signature will get the opposite return value from what
they expect (since exit code 0 means success, but NULL pointer means
failure). We should do this refactor once we think that nobody will try
to use the old signature.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c |  8 +++++---
 builtin/update-index.c      |  4 ++--
 combine-diff.c              |  3 ++-
 diff-lib.c                  |  2 +-
 dir.c                       |  2 +-
 object-file.c               |  2 +-
 read-cache.c                |  4 ++--
 refs.c                      | 10 ++++++----
 refs.h                      |  5 ++++-
 unpack-trees.c              |  3 ++-
 10 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b63f420ecef..dd00a0db522 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2466,7 +2466,8 @@ static int update_submodule(struct update_data *update_data)
 
 	if (update_data->just_cloned)
 		oidcpy(&update_data->suboid, null_oid());
-	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
+	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD",
+				     &update_data->suboid, NULL))
 		die(_("Unable to find current revision in submodule path '%s'"),
 			update_data->displaypath);
 
@@ -2482,7 +2483,8 @@ static int update_submodule(struct update_data *update_data)
 				    update_data->sm_path);
 		}
 
-		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_data->oid))
+		if (resolve_gitlink_ref(update_data->sm_path, remote_ref,
+					&update_data->oid, NULL))
 			die(_("Unable to find %s revision in submodule path '%s'"),
 			    remote_ref, update_data->sm_path);
 
@@ -3231,7 +3233,7 @@ static void die_on_repo_without_commits(const char *path)
 	strbuf_addstr(&sb, path);
 	if (is_nonbare_repository_dir(&sb)) {
 		struct object_id oid;
-		if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
+		if (resolve_gitlink_ref(path, "HEAD", &oid, NULL) < 0)
 			die(_("'%s' does not have a commit checked out"), path);
 	}
 	strbuf_release(&sb);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index b62249905f1..19a21a4586c 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -339,7 +339,7 @@ static int process_directory(const char *path, int len, struct stat *st)
 		if (S_ISGITLINK(ce->ce_mode)) {
 
 			/* Do nothing to the index if there is no HEAD! */
-			if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
+			if (resolve_gitlink_ref(path, "HEAD", &oid, NULL) < 0)
 				return 0;
 
 			return add_one_path(ce, path, len, st);
@@ -365,7 +365,7 @@ static int process_directory(const char *path, int len, struct stat *st)
 	}
 
 	/* No match - should we add it as a gitlink? */
-	if (!resolve_gitlink_ref(path, "HEAD", &oid))
+	if (!resolve_gitlink_ref(path, "HEAD", &oid, NULL))
 		return add_one_path(NULL, path, len, st);
 
 	/* Error out. */
diff --git a/combine-diff.c b/combine-diff.c
index b0ece954808..88efcaeefa7 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1060,7 +1060,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			elem->mode = canon_mode(st.st_mode);
 		} else if (S_ISDIR(st.st_mode)) {
 			struct object_id oid;
-			if (resolve_gitlink_ref(elem->path, "HEAD", &oid) < 0)
+			if (resolve_gitlink_ref(elem->path, "HEAD", &oid,
+						NULL) < 0)
 				result = grab_blob(opt->repo, &elem->oid,
 						   elem->mode, &result_size,
 						   NULL, NULL);
diff --git a/diff-lib.c b/diff-lib.c
index 7eb66a417aa..0c1f76d5fe9 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -53,7 +53,7 @@ static int check_removed(const struct index_state *istate, const struct cache_en
 		 * a directory --- the blob was removed!
 		 */
 		if (!S_ISGITLINK(ce->ce_mode) &&
-		    resolve_gitlink_ref(ce->name, "HEAD", &sub))
+		    resolve_gitlink_ref(ce->name, "HEAD", &sub, NULL))
 			return 1;
 	}
 	return 0;
diff --git a/dir.c b/dir.c
index d7cfb08e441..33368b399e2 100644
--- a/dir.c
+++ b/dir.c
@@ -3255,7 +3255,7 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	struct object_id submodule_head;
 
 	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
-	    !resolve_gitlink_ref(path->buf, "HEAD", &submodule_head)) {
+	    !resolve_gitlink_ref(path->buf, "HEAD", &submodule_head, NULL)) {
 		/* Do not descend and nuke a nested git work tree. */
 		if (kept_up)
 			*kept_up = 1;
diff --git a/object-file.c b/object-file.c
index 5b270f046dd..a10a49d7a2a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2526,7 +2526,7 @@ int index_path(struct index_state *istate, struct object_id *oid,
 		strbuf_release(&sb);
 		break;
 	case S_IFDIR:
-		return resolve_gitlink_ref(path, "HEAD", oid);
+		return resolve_gitlink_ref(path, "HEAD", oid, NULL);
 	default:
 		return error(_("%s: unsupported file type"), path);
 	}
diff --git a/read-cache.c b/read-cache.c
index 4de207752dc..4b68bd0c9a6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -285,7 +285,7 @@ static int ce_compare_gitlink(const struct cache_entry *ce)
 	 *
 	 * If so, we consider it always to match.
 	 */
-	if (resolve_gitlink_ref(ce->name, "HEAD", &oid) < 0)
+	if (resolve_gitlink_ref(ce->name, "HEAD", &oid, NULL) < 0)
 		return 0;
 	return !oideq(&oid, &ce->oid);
 }
@@ -776,7 +776,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 
 	namelen = strlen(path);
 	if (S_ISDIR(st_mode)) {
-		if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
+		if (resolve_gitlink_ref(path, "HEAD", &oid, NULL) < 0)
 			return error(_("'%s' does not have a commit checked out"), path);
 		while (namelen && path[namelen-1] == '/')
 			namelen--;
diff --git a/refs.c b/refs.c
index 90bcb271687..d72015c95e9 100644
--- a/refs.c
+++ b/refs.c
@@ -1784,19 +1784,21 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 }
 
 int resolve_gitlink_ref(const char *submodule, const char *refname,
-			struct object_id *oid)
+			struct object_id *oid, const char **referent_out)
 {
 	struct ref_store *refs;
 	int flags;
+	const char *referent;
 
 	refs = get_submodule_ref_store(submodule);
 
 	if (!refs)
 		return -1;
-
-	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags) ||
-	    is_null_oid(oid))
+	referent = refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags);
+	if (!referent || is_null_oid(oid))
 		return -1;
+	if (referent_out)
+		*referent_out = referent;
 	return 0;
 }
 
diff --git a/refs.h b/refs.h
index 47cb9edbaa8..c5ae76654c5 100644
--- a/refs.h
+++ b/refs.h
@@ -136,9 +136,12 @@ int peel_iterated_oid(const struct object_id *base, struct object_id *peeled);
  * submodule (which must be non-NULL). If the resolution is
  * successful, return 0 and set oid to the name of the object;
  * otherwise, return a non-zero value.
+ *
+ * FIXME: Return "referent" just like refs_resolve_ref_unsafe(). This will be
+ * safe to do once we merge resolve_gitlink_ref() into master.
  */
 int resolve_gitlink_ref(const char *submodule, const char *refname,
-			struct object_id *oid);
+			struct object_id *oid, const char **referent);
 
 /*
  * Return true iff abbrev_name is a possible abbreviation for
diff --git a/unpack-trees.c b/unpack-trees.c
index 8a454e03bff..43a1a056a19 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2202,7 +2202,8 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 
 	if (S_ISGITLINK(ce->ce_mode)) {
 		struct object_id oid;
-		int sub_head = resolve_gitlink_ref(ce->name, "HEAD", &oid);
+		int sub_head =
+			resolve_gitlink_ref(ce->name, "HEAD", &oid, NULL);
 		/*
 		 * If we are not going to update the submodule, then
 		 * we don't care.
-- 
gitgitgadget

