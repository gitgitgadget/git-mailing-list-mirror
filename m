Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3C1DC992
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181411; cv=none; b=NQJnqWDU0QFsAsSsJFudSr0Yr4FWcNR2pFTqPCjoGucpUC5BHyWr8QnVf1Xyh5veDZ7ptx3HCRw1TNHF4ojS5oWmi4zbw5HK7fN2NnlfLnvyyV8hHyQorJhBL9z6czqxkIcuwnzjBrEaQFQRh1LLKM+Warme/svnUhXO4pFBNCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181411; c=relaxed/simple;
	bh=iJSx2wq0GPH6xRCOqnCTnpruLLpQL218jvvUXKZBWBU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HMdFU0Vw1LbFz/UZxrMtcfRx9MANcColeIdnGddU2su6Dlk7N05RqgITB/NXi1Em94erpdtjf7N9NAABCZOte4k/UM41XhrWrfXraLP3rmfOPbYS8yrYm9VVSHw28pvnkcPsUxJoWBdBs4VU2lEAOR/ydOfvj+aI1EiaNAnw5yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yswl3OXR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yswl3OXR"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso17726435e9.0
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 10:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743181407; x=1743786207; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVcO5WNA5YawXE9sTKCupacfR231dbsLqQd8Hy8r0u8=;
        b=Yswl3OXRUmUUZsZEBHV1STDOIz+BeC3DakjYMXf+znnfBKbTpVK+PFBRllsP+6RDnL
         6c82WDnFQPp8bgcjrjeh/zwWJ5BBfEE/TJAXrQDQWGkxl9ADI9mErHx7ICv1e7/k1m1K
         cRbWg34t8ndeEXdEFZ2ej7NmVM5cRiw07N2thCqDXi3iNmGjEOXyu9Tgqy6TTSekJ5FC
         7RNXdfp1F0Oah1Cc+KmkYKdvU2vsUY1VZiUIvu0AbcoE3gZrBaEKowgIDMgCU18TLvzW
         7hN+nnGWYYKLrRc8a3J5urdG13z7OrGQVxHbePTDAVhYa6ZvHjWrN0wTG66a6hY79fSE
         eKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743181407; x=1743786207;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVcO5WNA5YawXE9sTKCupacfR231dbsLqQd8Hy8r0u8=;
        b=detZFJPYbqBmVg42jTx3xQn/aywJBvMYuzKCx+KF72kPqpn/yeEVW8ITGAbpqfLat4
         ID2GZRXr5A0o/8WMI+/3y74AfpBn0+NjuO03HNmT1k29k/FH2ONpn5yTKHyJIHqXlV+D
         F65mkncDaqqYsISGxbe39vsOG10okrgRYKpL52kvko+Yhf4t9g70xGz1ttUoAbWX898/
         OmPUY+CiCPOsOOWZIUuj568nKQHCtsja8Xy7NRxIP1EsfGtl/O2IL1RqtSFSU79G6nqe
         8vmjTiDOtrMm9bWR+bQgc6eLszVKZ/Ih5bgTWb7Tepb7PIeqRNdkPaPBhSAO3ZbG1kLJ
         fnhw==
X-Gm-Message-State: AOJu0Yz+kXMAIRXtoCecOGCE4U3GcORBWB5Pvg7yD3m9YS2X9pyaDCVJ
	c4nnRSQ+YsOwOwkuvKYV6/VOTudJwIGOH0vF3CCGP3Xgd+M/3+DiMW3jkQ==
X-Gm-Gg: ASbGnctJU8pnCdgl3UHe5VIUlAvy0BuLYr8s2U49c9fZ3e3ao2vk0Hp2MzdwNx96yQj
	pHBuPUu4bD+3EXVdEBHaRKqNUUD7ysZrwrTbJqtR51L7eKsmHz1ZNQDlri/RunpxECHyTud36jL
	3Zatdstjfwu7rDvEgDegSmUNLTpThTol1ih4UgE/X3zGP1Thx4s8kl+xc62gYbelgTpNL7T7wkq
	Fq3c1rVMeCgpTtnez8OxpFmRYW2dlbGHB73ceO7c2nhZSFJYRlm8vho0DTy6Bsf/8mYRlDcedgH
	xJ4hpCltMWG/GdtWTaCWFxZsJ79HTZa9TWumMQXEqmrHgw==
X-Google-Smtp-Source: AGHT+IF/eKKai+00Tt4YII5TltODHcvjQM/HumxVJ/aQrghuw7W8/fgtH6458m/im/oiueew0xImsw==
X-Received: by 2002:a05:600c:46d0:b0:43d:7588:667b with SMTP id 5b1f17b1804b1-43db62264d4mr2820155e9.10.1743181406698;
        Fri, 28 Mar 2025 10:03:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d900013afsm33505115e9.36.2025.03.28.10.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 10:03:26 -0700 (PDT)
Message-Id: <db01acdd062a17b1cca62428eba8c3ed62ca7c6a.1743181401.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.git.1743181401.gitgitgadget@gmail.com>
References: <pull.1897.git.1743181401.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Mar 2025 17:03:21 +0000
Subject: [PATCH 3/3] wt-status: suggest 'git rebase --continue' to conclude
 'merge' instruction
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Since 982288e9bd (status: rebase and merge can be in progress at the
same time, 2018-11-12), when a merge is in progress as part of a 'git
rebase -r' operation, 'wt_longstatus_print_state' shows information
about the in-progress rebase (via show_rebase_information), and then
calls 'show_merge_in_progress' to help the user conclude the merge. This
function suggests using 'git commit' to do so, but this throws away the
authorship information from the original merge, which is not ideal.
Using 'git rebase --continue' instead preserves the authorship
information, since we enter 'sequencer.c:run_git_commit' which calls
read_env_script to read the author-script file.

Note however that this only works when a merge was scheduled using a
'merge' instruction in the rebase todo list. Indeed, when using 'exec
git merge', the state files necessary for 'git rebase --continue' are
not present, and one must use 'git commit' (or 'git merge --continue')
in that case.

Be more helpful to the user by suggesting either 'git rebase
--continue', when the merge was scheduled using a 'merge' instruction,
and 'git commit' otherwise. As such, add a
'merge_during_rebase_in_progress' field to 'struct wt_status_state', and
detect this situation in wt_status_check_rebase by looking at the last
command done. Adjust wt_longstatus_print_state to check this field and
suggest 'git rebase --continue' if a merge came from a 'merge'
instruction, by calling show_rebase_in_progress directly.

Add two tests for the new behaviour, using 'merge' and 'exec git merge'
instructions.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/t7512-status-help.sh | 75 ++++++++++++++++++++++++++++++++++++++++++
 wt-status.c            | 18 +++++++---
 wt-status.h            |  1 +
 3 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 802f8f704c6..b37e99625b4 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -183,6 +183,81 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'status during rebase -ir after conflicted merge (exec git merge)' '
+	git reset --hard main &&
+	git checkout -b rebase_i_merge &&
+	test_commit unrelated &&
+	git checkout -b rebase_i_merge_side &&
+	test_commit side2 main.txt &&
+	git checkout rebase_i_merge &&
+	test_commit side1 main.txt &&
+	PICK=$(git rev-parse --short rebase_i_merge) &&
+	test_must_fail git merge rebase_i_merge_side &&
+	echo side1 >main.txt &&
+	git add main.txt &&
+	test_tick &&
+	git commit --no-edit &&
+	MERGE=$(git rev-parse --short rebase_i_merge) &&
+	ONTO=$(git rev-parse --short main) &&
+	test_when_finished "git rebase --abort" &&
+	FAKE_LINES="1 2 3 5 6 7 8 9 10 exec_git_merge_refs/rewritten/rebase-i-merge-side" &&
+	export FAKE_LINES &&
+	test_must_fail git rebase -ir main &&
+	cat >expect <<EOF &&
+interactive rebase in progress; onto $ONTO
+Last commands done (8 commands done):
+   pick $PICK side1
+   exec git merge refs/rewritten/rebase-i-merge-side
+  (see more in file .git/rebase-merge/done)
+No commands remaining.
+
+You have unmerged paths.
+  (fix conflicts and run "git commit")
+  (use "git merge --abort" to abort the merge)
+
+Unmerged paths:
+  (use "git add <file>..." to mark resolution)
+	both modified:   main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'status during rebase -ir after replaying conflicted merge (merge)' '
+	PICK=$(git rev-parse --short :/side1) &&
+	UNRELATED=$(git rev-parse --short :/unrelated) &&
+	MERGE=$(git rev-parse --short rebase_i_merge) &&
+	ONTO=$(git rev-parse --short main) &&
+	test_when_finished "git rebase --abort" &&
+	FAKE_LINES="1 2 3 5 6 7 8 9 10 11 4" &&
+	export FAKE_LINES &&
+	test_must_fail git rebase -ir main &&
+	cat >expect <<EOF &&
+interactive rebase in progress; onto $ONTO
+Last commands done (8 commands done):
+   pick $PICK side1
+   merge -C $MERGE rebase-i-merge-side # Merge branch '\''rebase_i_merge_side'\'' into rebase_i_merge
+  (see more in file .git/rebase-merge/done)
+Next command to do (1 remaining command):
+   pick $UNRELATED unrelated
+  (use "git rebase --edit-todo" to view and edit)
+You are currently rebasing branch '\''rebase_i_merge'\'' on '\''$ONTO'\''.
+  (fix conflicts and then run "git rebase --continue")
+  (use "git rebase --skip" to skip this patch)
+  (use "git rebase --abort" to check out the original branch)
+
+Unmerged paths:
+  (use "git add <file>..." to mark resolution)
+	both modified:   main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expect actual
+'
+
 
 test_expect_success 'status when rebasing -i in edit mode' '
 	git reset --hard main &&
diff --git a/wt-status.c b/wt-status.c
index d11d9f9f142..f15495039e3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1744,6 +1744,7 @@ int wt_status_check_rebase(const struct worktree *wt,
 			   struct wt_status_state *state)
 {
 	struct stat st;
+	struct string_list have_done = STRING_LIST_INIT_DUP;
 
 	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
 		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
@@ -1760,8 +1761,12 @@ int wt_status_check_rebase(const struct worktree *wt,
 			state->rebase_interactive_in_progress = 1;
 		else
 			state->rebase_in_progress = 1;
+		read_rebase_todolist("rebase-merge/done", &have_done);
+		if (have_done.nr > 0 && starts_with(have_done.items[have_done.nr - 1].string, "merge"))
+				state->merge_during_rebase_in_progress = 1;
 		state->branch = get_branch(wt, "rebase-merge/head-name");
 		state->onto = get_branch(wt, "rebase-merge/onto");
+		string_list_clear(&have_done, 0);
 	} else
 		return 0;
 	return 1;
@@ -1855,10 +1860,15 @@ static void wt_longstatus_print_state(struct wt_status *s)
 
 	if (state->merge_in_progress) {
 		if (state->rebase_interactive_in_progress) {
-			show_rebase_information(s, state_color);
-			fputs("\n", s->fp);
-		}
-		show_merge_in_progress(s, state_color);
+			if (state->merge_during_rebase_in_progress)
+				show_rebase_in_progress(s, state_color);
+			else {
+				show_rebase_information(s, state_color);
+				fputs("\n", s->fp);
+				show_merge_in_progress(s, state_color);
+			}
+		} else
+			show_merge_in_progress(s, state_color);
 	} else if (state->am_in_progress)
 		show_am_in_progress(s, state_color);
 	else if (state->rebase_in_progress || state->rebase_interactive_in_progress)
diff --git a/wt-status.h b/wt-status.h
index 4e377ce62b8..84bedfcd48f 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -87,6 +87,7 @@ struct wt_status_state {
 	int am_empty_patch;
 	int rebase_in_progress;
 	int rebase_interactive_in_progress;
+	int merge_during_rebase_in_progress;
 	int cherry_pick_in_progress;
 	int bisect_in_progress;
 	int revert_in_progress;
-- 
gitgitgadget
