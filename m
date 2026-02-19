Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EB13271F0
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511210; cv=none; b=awiz+CUY/zeAYvWxoC3yWrm4vmzbcQHDX08G5w+dXWgu8buXuvrTGM3i7RhiguTjOUjHIvobH/gJVXa3lAizjHqWAGbUqaSgpb4JimhbLsqRhQtS1kWzqcxQttXOFz5dDuKWw5GIyXZF+GCuML3q6v0KtRBOoMm/KDBlf8lUSig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511210; c=relaxed/simple;
	bh=Pap8IUQEJRRXs4g6LroycC1QKqaJuF5yaSxaR4AYOA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DK/f/jSPdT8gwkS0x/E7mgowHBE5BWP79Amfr7F3iM57GrVNinuIMzYg0hd/DU73s7wfeHSR4+AWGEmEXQFSstCoWAz9zNl93YUQyTYRJXcBwpoUdpgRtSxB5h/DN0nKT8KzRSim1+Dzt5TFS9NPaY6tyXjs0GziP/3pFMv7BGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTh8375X; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTh8375X"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-482f454be5bso19742455e9.0
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 06:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771511207; x=1772116007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ns3stR3EzAJPKooGRxXqI6Ws0J/KqD6FLlOAd7YbIFY=;
        b=jTh8375XMIP7CFNXllmxfYRJSTGF8EG0NHtTCkwbXbJ4Yj7GxvmGP8JD2v+QNZxQqR
         LXNdPTvFAdva0a0KvqNlwmpHxvQDhSgYvB+rp8b0xBh2AWnqCxPNud6cTzLJ/pVM550v
         QLmblzd87Y/4qwLA0Ik6zrj5c/zOWvRMDjlb+5ZGardNAGcd43H7BC1fHyLKSHMAp74r
         3uPzuNITCfh1qmWadYsacJvQrQTyspRWRxA+XLTM/oEtORzj076z2W4NgBIwOps4JpKq
         drrIzzjGhViHgkXF+vC5Fao1X3P8VPC16b2fK2YhyyqayQT23FVBXJNDmDsQkR0oQNRT
         G24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771511207; x=1772116007;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ns3stR3EzAJPKooGRxXqI6Ws0J/KqD6FLlOAd7YbIFY=;
        b=kMBhGpuiWOs8nKvJZ7ku4fZmatfa1qTDRihnwl01QgNGlzbKmG3wd/Pdpt5xFHAn9w
         /1MNBL1tiIbFaaJIFgwmbZCC15uMVYKcwZD9kolcKmF7WpTP9Q5JhgD192O/jU3I8rGP
         QG3YnBbN0BuhX8WdgEhU9dHitfdXrhBui9nmnNcDm4eiRlJckZLZbkw8dNrTnlp4EhYm
         K18DN0GiG6hVfv/BmObJysEa7/NCL7FNz82YU0bmkjLouyXFCqIvqkf/EdGb48ekiOOq
         Er4BTQx41w66xTkfKE0KtewSK8sHPkTaCeF/ZmYJXDsKZL41HyFmtE8kjRzBoC6sZkXq
         lnrg==
X-Gm-Message-State: AOJu0YxFifKMzfKb2nANtkSbTR64an8LnE3EapWrkd/fxTlKf+J4gaEJ
	CTKAgvR7DFV9bcu3vvtByOexWWjYqrzwH7iu4TEcJBzULakK/S7NHBK49R1XgfVA
X-Gm-Gg: AZuq6aKMgSipECxActwtVt5izo1stheVDOv9+2Zq14tAbsxFS2PiKddqeMEW2mnERpO
	Gs3WI/wdZNhAxGJlupZpWduR3eSSOebixjVIPCI2QidxqfDT7lazXHQjlbjIA0hPOccCRW4Gas7
	u7fbyWvodRMNAc49i1H2hw4iH9YXigdlTQe4JeTJ/dkvWMD97GJnBkhe3V9qAr+S12LwdYGgbzi
	/Kfo1FDke57mu29TKA10iYiJcDJuG1LxqyWAsk5W1G1yTiRy1tgpwrmjAbYGUPPfTysVte7V12L
	nbKGqxwRhN33bzdrtAyb+5MJwhkR18oROvPWaPeG22gCUJ//nGl5eWSbV/6fWuOdnd6L6DhgJ1a
	pQyNRELUb7ghofTpIetd59S9ZHmkiBk+tPWPdLZ2f5ufvxT7EvB/eUGUL+dwG/jtX3JAycvLUWp
	/r5jNnDO57y3cTChsTd0XYu4mEeSG3wF4muE1YhA==
X-Received: by 2002:a05:600c:3b22:b0:477:9a61:fd06 with SMTP id 5b1f17b1804b1-4839fe97501mr31575545e9.8.1771511206806;
        Thu, 19 Feb 2026 06:26:46 -0800 (PST)
Received: from berwick ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839f99275esm21611135e9.32.2026.02.19.06.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 06:26:46 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/2] wt-status: avoid passing NULL worktree
Date: Thu, 19 Feb 2026 14:26:32 +0000
Message-ID: <902295b87146e5cb5358cebab51f8d66701290a8.1771511192.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1771511192.git.phillip.wood@dunelm.org.uk>
References: <cover.1771258688.git.phillip.wood@dunelm.org.uk> <cover.1771511192.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

In preparation for removing the repository argument from
worktree_git_path() add a function to construct a "struct worktree"
from a "struct repository" using its "gitdir" and "worktree"
members. This function is then used to avoid passing a NULL worktree to
wt_status_check_bisect() and wt_status_check_rebase(). In general the
"struct worktree" returned may not correspond to the "current" worktree
defined by is_current_worktree() as that function uses "the_repository"
rather than "wt->repo" when deciding which worktree is "current". In
practice the "struct repository" we pass corresponds to "the_repository"
as we only ever operate on a single repository at the moment.

wt_status_check_bisect() and wt_status_check_rebase() have the following
callers:

 - branch.c:prepare_checked_out_branches() which loops over all
   worktrees.

 - worktree.c:is_worktree_being_rebased() which is called from
   builtin/branch.c:reject_rebase_or_bisect_branch() that loops over all
   worktrees and worktree.c:is_shared_symref() which dereferences wt
   earlier in the function.

 - wt-status:wt_status_get_state() which is updated to avoid passing a
   NULL worktree by this patch.

This updates the only callers that pass a NULL worktree to
worktree_git_path(). A new test is added to check that "git status"
detects a rebase in a linked worktree.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t7512-status-help.sh |  9 +++++++++
 worktree.c             | 20 ++++++++++++++++++++
 worktree.h             |  6 ++++++
 wt-status.c            | 15 ++++++++++++---
 4 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 25e8e9711f8..08e82f79140 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -594,6 +594,15 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'rebase in a linked worktree' '
+	test_might_fail git rebase --abort &&
+	git worktree add wt &&
+	test_when_finished "test_might_fail git -C wt rebase --abort;
+				git worktree remove wt" &&
+	GIT_SEQUENCE_EDITOR="echo break >" git -C wt rebase -i HEAD &&
+	git -C wt status >actual &&
+	test_grep "interactive rebase in progress" actual
+'
 
 test_expect_success 'prepare am_session' '
 	git reset --hard main &&
diff --git a/worktree.c b/worktree.c
index 9308389cb6f..218c332a66d 100644
--- a/worktree.c
+++ b/worktree.c
@@ -66,6 +66,26 @@ static int is_current_worktree(struct worktree *wt)
 	return is_current;
 }
 
+struct worktree *get_worktree_from_repository(struct repository *repo)
+{
+	struct worktree *wt = xcalloc(1, sizeof(*wt));
+	char *gitdir = absolute_pathdup(repo->gitdir);
+	char *commondir = absolute_pathdup(repo->commondir);
+
+	wt->repo = repo;
+	wt->path = absolute_pathdup(repo->worktree ? repo->worktree
+						   : repo->gitdir);
+	wt->is_bare = !repo->worktree;
+	if (fspathcmp(gitdir, commondir))
+		wt->id = xstrdup(find_last_dir_sep(gitdir) + 1);
+	wt->is_current = is_current_worktree(wt);
+	add_head_info(wt);
+
+	free(gitdir);
+	free(commondir);
+	return wt;
+}
+
 /*
 * When in a secondary worktree, and when extensions.worktreeConfig
 * is true, only $commondir/config and $commondir/worktrees/<id>/
diff --git a/worktree.h b/worktree.h
index e4bcccdc0ae..06efe26b835 100644
--- a/worktree.h
+++ b/worktree.h
@@ -38,6 +38,12 @@ struct worktree **get_worktrees(void);
  */
 struct worktree **get_worktrees_without_reading_head(void);
 
+/*
+ * Construct a struct worktree corresponding to repo->gitdir and
+ * repo->worktree.
+ */
+struct worktree *get_worktree_from_repository(struct repository *repo);
+
 /*
  * Returns 1 if linked worktrees exist, 0 otherwise.
  */
diff --git a/wt-status.c b/wt-status.c
index 95942399f8c..2debda534c1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1747,6 +1747,9 @@ int wt_status_check_rebase(const struct worktree *wt,
 {
 	struct stat st;
 
+	if (!wt)
+		BUG("wt_status_check_rebase() called with NULL worktree");
+
 	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
 		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
 			state->am_in_progress = 1;
@@ -1774,6 +1777,9 @@ int wt_status_check_bisect(const struct worktree *wt,
 {
 	struct stat st;
 
+	if (!wt)
+		BUG("wt_status_check_bisect() called with NULL worktree");
+
 	if (!stat(worktree_git_path(the_repository, wt, "BISECT_LOG"), &st)) {
 		state->bisect_in_progress = 1;
 		state->bisecting_from = get_branch(wt, "BISECT_START");
@@ -1819,18 +1825,19 @@ void wt_status_get_state(struct repository *r,
 	struct stat st;
 	struct object_id oid;
 	enum replay_action action;
+	struct worktree *wt = get_worktree_from_repository(r);
 
 	if (!stat(git_path_merge_head(r), &st)) {
-		wt_status_check_rebase(NULL, state);
+		wt_status_check_rebase(wt, state);
 		state->merge_in_progress = 1;
-	} else if (wt_status_check_rebase(NULL, state)) {
+	} else if (wt_status_check_rebase(wt, state)) {
 		;		/* all set */
 	} else if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
 		   !repo_get_oid(r, "CHERRY_PICK_HEAD", &oid)) {
 		state->cherry_pick_in_progress = 1;
 		oidcpy(&state->cherry_pick_head_oid, &oid);
 	}
-	wt_status_check_bisect(NULL, state);
+	wt_status_check_bisect(wt, state);
 	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") &&
 	    !repo_get_oid(r, "REVERT_HEAD", &oid)) {
 		state->revert_in_progress = 1;
@@ -1848,6 +1855,8 @@ void wt_status_get_state(struct repository *r,
 	if (get_detached_from)
 		wt_status_get_detached_from(r, state);
 	wt_status_check_sparse_checkout(r, state);
+
+	free_worktree(wt);
 }
 
 static void wt_longstatus_print_state(struct wt_status *s)
-- 
2.52.0.362.g884e03848a9

