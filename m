Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C61C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 19:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbiFNT2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiFNT1o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 15:27:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517C313EBA
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 12:27:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n185so5189226wmn.4
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 12:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xivVobC5MZizYnrUWGjHH9ct5f/yTO+O0jOCbEvOrPM=;
        b=IF7pjFBdTqGZX22tjUK5UMU6pA01xMxAztnG9k7QN0yOYE3IIvVpcUlHsDfO5UOnRA
         J75A+szXwOyTBDLOqkFBo+AH6cFnDgHTX63yiVAlXdIt3CebYX4RO3SqAeOsRcf6X5n1
         WJ4IKl7vZ4NqqlyvltJtMS2Rik9Lo7KzVoEmOpxPT4YfhciqzTC4yDRT0+V35uvRLC8P
         pYlTY5b2j1w2sezvpvHH+vJZeYUS3y5n64HZio7KwhZ7P2GjxKQTWp6tAwHCj8ZcOXqu
         9wJ57Ntz5/7WyuIjhPMGmE0bbgv6vah70JPRPYk8U3RdU8Cmp0m85xjpQxfj0NpxZEQD
         46yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xivVobC5MZizYnrUWGjHH9ct5f/yTO+O0jOCbEvOrPM=;
        b=ann2zBgrrZV9DQMVRkx2NfuJzOHy0750lk354WZAg6FGaPcljJK3zSsoeVS2s7aAqd
         03y3Ctut8UxNoGYo8RifMMjc/mF5zYEM+2rthYNEAR3hpiCNkITr+p3MKGA1kK/iSnd0
         xDWjmi9hE2BupJEoooTQ546BK85Zge35k7U+P7MhmwJIH0vKvwTroRcwhJGpBD0/8PDr
         WLJGfuUaqZPJ3Lni5QkVzFu2xYswdaTfjHJOqqgsh/MPh/wO80mzeawHECSjNMUuh5tS
         GNmtgFBLmx6zmXeJ0+5OJwcvxIl7xobajTcZSv85WYdvsVof3Vn+vE+nIxUkYllgXspZ
         JnRA==
X-Gm-Message-State: AOAM532w3wm3fMOzBr3W8qS0jRv0pO1U7TazGhvPubyUFQcVmx/pIHRH
        S1d7H/Nx1+g0BFFRejHk36Attz6TIvW3ZA==
X-Google-Smtp-Source: ABdhPJz17mHLtBK3Z6Mlhz62ZaXgaTDje7dhNWQkKohQqGjZ7njSLXZbden343UjUChxh29tqmCRzg==
X-Received: by 2002:a1c:7703:0:b0:39c:521d:e9af with SMTP id t3-20020a1c7703000000b0039c521de9afmr5596024wmi.170.1655234861291;
        Tue, 14 Jun 2022 12:27:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0ac700b0039c4b518df4sm16772144wmr.5.2022.06.14.12.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:27:40 -0700 (PDT)
Message-Id: <0aa9478bc3815726a47ea99cac0fd333e95c1584.1655234853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1254.v2.git.1655234853.gitgitgadget@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
        <pull.1254.v2.git.1655234853.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jun 2022 19:27:33 +0000
Subject: [PATCH v2 5/5] branch: fix branch_checked_out() leaks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The branch_checked_out() method populates a strmap linking a refname to
a worktree that has that branch checked out. While unlikely, it is
possible that a bug or filesystem manipulation could create a scenario
where the same ref is checked out in multiple places. Further, there are
some states in an interactive rebase where HEAD and REBASE_HEAD point to
the same ref, leading to multiple insertions into the strmap. In either
case, the strmap_put() method returns the old value which is leaked.

Update branch_checked_out() to consume that pointer and free it.

Add a test in t2407 that checks this erroneous case. The test "checks
itself" by first confirming that the filesystem manipulations it makes
trigger the branch_checked_out() logic, and then sets up similar
manipulations to make it look like there are multiple worktrees pointing
to the same ref.

While TEST_PASSES_SANITIZE_LEAK would be helpful to demonstrate the
leakage and prevent it in the future, t2407 uses helpers such as 'git
clone' that cause the test to fail under that mode.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 branch.c                  | 25 +++++++++++++++----------
 t/t2407-worktree-heads.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/branch.c b/branch.c
index d4ddec6f4e5..6007ee7baeb 100644
--- a/branch.c
+++ b/branch.c
@@ -385,25 +385,29 @@ static void prepare_checked_out_branches(void)
 	worktrees = get_worktrees();
 
 	while (worktrees[i]) {
+		char *old;
 		struct wt_status_state state = { 0 };
 		struct worktree *wt = worktrees[i++];
 
 		if (wt->is_bare)
 			continue;
 
-		if (wt->head_ref)
-			strmap_put(&current_checked_out_branches,
-				   wt->head_ref,
-				   xstrdup(wt->path));
+		if (wt->head_ref) {
+			old = strmap_put(&current_checked_out_branches,
+					 wt->head_ref,
+					 xstrdup(wt->path));
+			free(old);
+		}
 
 		if (wt_status_check_rebase(wt, &state) &&
 		    (state.rebase_in_progress || state.rebase_interactive_in_progress) &&
 		    state.branch) {
 			struct strbuf ref = STRBUF_INIT;
 			strbuf_addf(&ref, "refs/heads/%s", state.branch);
-			strmap_put(&current_checked_out_branches,
-				   ref.buf,
-				   xstrdup(wt->path));
+			old = strmap_put(&current_checked_out_branches,
+					 ref.buf,
+					 xstrdup(wt->path));
+			free(old);
 			strbuf_release(&ref);
 		}
 		wt_status_state_free_buffers(&state);
@@ -412,9 +416,10 @@ static void prepare_checked_out_branches(void)
 		    state.branch) {
 			struct strbuf ref = STRBUF_INIT;
 			strbuf_addf(&ref, "refs/heads/%s", state.branch);
-			strmap_put(&current_checked_out_branches,
-				   ref.buf,
-				   xstrdup(wt->path));
+			old = strmap_put(&current_checked_out_branches,
+					 ref.buf,
+					 xstrdup(wt->path));
+			free(old);
 			strbuf_release(&ref);
 		}
 		wt_status_state_free_buffers(&state);
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index a5aec1486c5..b6be42f74a2 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -98,4 +98,32 @@ test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: worktree in rebase
 	grep "refusing to fetch into branch" err
 '
 
+test_expect_success 'refuse to overwrite when in error states' '
+	test_when_finished rm -rf .git/worktrees/wt-*/rebase-merge &&
+	test_when_finished rm -rf .git/worktrees/wt-*/BISECT_* &&
+
+	# Both branches are currently under rebase.
+	mkdir -p .git/worktrees/wt-3/rebase-merge &&
+	touch .git/worktrees/wt-3/rebase-merge/interactive &&
+	echo refs/heads/fake-1 >.git/worktrees/wt-3/rebase-merge/head-name &&
+	echo refs/heads/fake-2 >.git/worktrees/wt-3/rebase-merge/onto &&
+	mkdir -p .git/worktrees/wt-4/rebase-merge &&
+	touch .git/worktrees/wt-4/rebase-merge/interactive &&
+	echo refs/heads/fake-2 >.git/worktrees/wt-4/rebase-merge/head-name &&
+	echo refs/heads/fake-1 >.git/worktrees/wt-4/rebase-merge/onto &&
+
+	# Both branches are currently under bisect.
+	touch .git/worktrees/wt-4/BISECT_LOG &&
+	echo refs/heads/fake-2 >.git/worktrees/wt-4/BISECT_START &&
+	touch .git/worktrees/wt-1/BISECT_LOG &&
+	echo refs/heads/fake-1 >.git/worktrees/wt-1/BISECT_START &&
+
+	for i in 1 2
+	do
+		test_must_fail git branch -f fake-$i HEAD 2>err &&
+		grep "cannot force update the branch '\''fake-$i'\'' checked out at" err ||
+			return 1
+	done
+'
+
 test_done
-- 
gitgitgadget
