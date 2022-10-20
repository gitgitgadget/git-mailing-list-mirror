Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938ECC43217
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 20:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJTUVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJTUUv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 16:20:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B681F041F
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:20:49 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id e18so777506wmq.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=509B6hLh+GFBVnreBIuyCPrTI9ul8YARq/8O+F03Gjs=;
        b=I1trWHw5ty/i6IB4E36qiJtiSCYYTBkm7X2qK1+aQrUIchZNyLI59YpaxlM4EwA+9W
         eDW+IHi1bvbhJ2o5c4XQCa/bPaiMJ1lQA47lSCQRnWAzTD7Zhe8jkIT5daOwymtnJODz
         ILi05aBom34mIsuoE/N1moAOQkQot586mooLnQ12S471wtmFoGIvd619iWKKiqLe3S80
         8iqI7l0lX1jndv5wTA1IUrxKaOKegNWDLzjsS+bSyxkxuYyyqHwR2lRyrMbiQnUpp1pd
         +lMr+U5zTRkn2RgKWK6SWPlxdqv8XHdAjQTvcvRkr5pL+S9ev1o+D1CfAEF5PG8bUkR8
         WKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=509B6hLh+GFBVnreBIuyCPrTI9ul8YARq/8O+F03Gjs=;
        b=ALxwv7ptq/vpymV5k+UyVO+YatVWITmh3yVvi5DPExuAh1ChtSqAwMS0RmDUl3vni1
         gYAp2gptmlVm8wFeV2khLlQsR2nNYe3upOEntMbw6BhSnLx0g1TXd89GL/YhHXpL7/S3
         62cT8eFmLE6zuCjSlbPdHeMIX9qLU5KxMIl7e5wqfEmctard390DxFceOjJwZI8j+cQK
         6oIYLEj00Y4T20C+MJRWtDxbEKyu/MnhijY+hJvtF5GUblh7qWRAWbvebTl14lxBlV2e
         Edg2yigd3++QwgGl8kDayXGuuxPGXQ4NCVp78XICmZu5UbfZvU9v72kpw/UsWWnaLs5e
         6L5g==
X-Gm-Message-State: ACrzQf3HIMMK+1tN/fW5tmM1KNbGpJY3Cf0aAY1/DeHIh8ryd7IbWAU+
        irRCVQjd8iOXgs1MRdTQ5RzOnNoSv4I=
X-Google-Smtp-Source: AMsMyM7xwRUQEGc4D+4LlxpnxuhlJS3nx26ejnM0PfWaVsN/A6KI4BTciBOMa0iugkx3lDje2BKJAw==
X-Received: by 2002:a05:600c:5122:b0:3c6:fcce:e4e2 with SMTP id o34-20020a05600c512200b003c6fccee4e2mr11474182wms.65.1666297247449;
        Thu, 20 Oct 2022 13:20:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3-20020adfe583000000b002205a5de337sm17068367wrm.102.2022.10.20.13.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 13:20:46 -0700 (PDT)
Message-Id: <6f769cb80ad0bd7df98b8c7d207922f8631133f2.1666297239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
        <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 20:20:36 +0000
Subject: [PATCH v2 5/7] submodule: return target of submodule symref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
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
index 1ce3458a29c..138b133790f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2531,7 +2531,8 @@ static int update_submodule(struct update_data *update_data)
 
 	if (update_data->just_cloned)
 		oidcpy(&update_data->suboid, null_oid());
-	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
+	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD",
+				     &update_data->suboid, NULL))
 		return die_message(_("Unable to find current revision in submodule path '%s'"),
 				   update_data->displaypath);
 
@@ -2558,7 +2559,8 @@ static int update_submodule(struct update_data *update_data)
 						   update_data->sm_path);
 		}
 
-		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_data->oid))
+		if (resolve_gitlink_ref(update_data->sm_path, remote_ref,
+					&update_data->oid, NULL))
 			return die_message(_("Unable to find %s revision in submodule path '%s'"),
 					   remote_ref, update_data->sm_path);
 
@@ -3303,7 +3305,7 @@ static void die_on_repo_without_commits(const char *path)
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
index 2edea41a234..ac94b6234ca 100644
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
index d604d1bab98..81d232424c1 100644
--- a/dir.c
+++ b/dir.c
@@ -3251,7 +3251,7 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	struct object_id submodule_head;
 
 	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
-	    !resolve_gitlink_ref(path->buf, "HEAD", &submodule_head)) {
+	    !resolve_gitlink_ref(path->buf, "HEAD", &submodule_head, NULL)) {
 		/* Do not descend and nuke a nested git work tree. */
 		if (kept_up)
 			*kept_up = 1;
diff --git a/object-file.c b/object-file.c
index 5e309602346..a3c6580c16e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2522,7 +2522,7 @@ int index_path(struct index_state *istate, struct object_id *oid,
 		strbuf_release(&sb);
 		break;
 	case S_IFDIR:
-		return resolve_gitlink_ref(path, "HEAD", oid);
+		return resolve_gitlink_ref(path, "HEAD", oid, NULL);
 	default:
 		return error(_("%s: unsupported file type"), path);
 	}
diff --git a/read-cache.c b/read-cache.c
index 32024029274..4c1bf33ef48 100644
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
@@ -781,7 +781,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 
 	namelen = strlen(path);
 	if (S_ISDIR(st_mode)) {
-		if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
+		if (resolve_gitlink_ref(path, "HEAD", &oid, NULL) < 0)
 			return error(_("'%s' does not have a commit checked out"), path);
 		while (namelen && path[namelen-1] == '/')
 			namelen--;
diff --git a/refs.c b/refs.c
index 1491ae937eb..a32a25ccb69 100644
--- a/refs.c
+++ b/refs.c
@@ -1904,19 +1904,21 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 }
 
 int resolve_gitlink_ref(const char *submodule, const char *refname,
-			struct object_id *oid)
+			struct object_id *oid, const char **target_out)
 {
 	struct ref_store *refs;
 	int flags;
+	const char *target;
 
 	refs = get_submodule_ref_store(submodule);
 
 	if (!refs)
 		return -1;
-
-	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags) ||
-	    is_null_oid(oid))
+	target = refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags);
+	if (!target || is_null_oid(oid))
 		return -1;
+	if (target_out)
+		*target_out = target;
 	return 0;
 }
 
diff --git a/refs.h b/refs.h
index 8958717a17d..d5c32fac000 100644
--- a/refs.h
+++ b/refs.h
@@ -137,9 +137,12 @@ int peel_iterated_oid(const struct object_id *base, struct object_id *peeled);
  * submodule (which must be non-NULL). If the resolution is
  * successful, return 0 and set oid to the name of the object;
  * otherwise, return a non-zero value.
+ *
+ * FIXME: Return "target" just like refs_resolve_ref_unsafe(). This will be
+ * safe to do once we merge resolve_gitlink_ref() into master.
  */
 int resolve_gitlink_ref(const char *submodule, const char *refname,
-			struct object_id *oid);
+			struct object_id *oid, const char **target);
 
 /*
  * Return true iff abbrev_name is a possible abbreviation for
diff --git a/unpack-trees.c b/unpack-trees.c
index bae812156c4..db12bfcaffd 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2288,7 +2288,8 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 
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

