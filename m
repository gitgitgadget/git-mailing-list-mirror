Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89FE2F505
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAvgLWLL"
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D6C189
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:34:04 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso56273245e9.2
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700058842; x=1700663642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJ1KHOi4XTx8OsKdmk51H2m4FbYVMHOhT7aCL4Dis80=;
        b=aAvgLWLLTe9Y3Lsvy6BUN17ZzjzVAIrsGNdy9k7gm7IjPK1S1mR/8NEKdiPNc4EyAP
         vHLAXEwe+iidvuj/1aatmegAXfsFNB0JeyCj4Fc54lF6jjwuAOhQHfS0k09jCWWcfVK7
         TYIzcEadYr+lcWUiBhOcaO3s7rD+Dya8Z+K6vgQXCObfGvoOlbIhdeCl0OqoeNUejoHu
         G1S7ab4oASzJpozI5sua8C/hTHcf/VQZvv46O+YBdWl7cijBAO4YdxVNEqv60MQ7hY6/
         PMihI25ekeJ3QQXi2wx8DgwQUbG3WJ3Rpkb/VHvfTUxJjjqOX/C+7k6729kbTy5DQWEh
         485g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058842; x=1700663642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJ1KHOi4XTx8OsKdmk51H2m4FbYVMHOhT7aCL4Dis80=;
        b=aWPtb2HWZyYb+80QbYv88GLIV4qUGtXTrcQULmt+oEVboV6ugsPbP6PgtAkpIz6JsI
         xpQMTRnmqAYX7xvP9cUg+1EZNj6kKe8gMiUleOYc4ZUt9RkixSUxNDgG9wcWe0Gj7xxm
         NYhffjC/oFev+k/g5kqhd2ONfG3rmwDoGSgKb6W2c86ixAjc7PfeTDRL71doE/8yTaCE
         lh1brL4m6hxyJGNngyadsT6d+imL7P0dWVkNugzXiO+bWc8IKml7bbu9qMB11bjHPbvi
         NmjqxR3o4xuSiQBXBYC2T6bTD/c+LSbc5QWxkZZ3MP1jCcKsD5xRzTvE9fQIBVHo2R6y
         I5+A==
X-Gm-Message-State: AOJu0YzPFTX+uTjBGTMld/mjITHeHfcnu9Tl1MSDyPTzUn3bnKJID+Jk
	4UR7vMKr/8F275WDEZTpP4t0u9rbwcw=
X-Google-Smtp-Source: AGHT+IGQ9cZy14yw1nIV6nMzvNKTNPuxCrD2YC6uAorA4rhi4a7oYo3oqXKxyzOnRNY2gFUNdch2Qg==
X-Received: by 2002:a05:600c:893:b0:40a:437e:30fd with SMTP id l19-20020a05600c089300b0040a437e30fdmr9344241wmp.9.1700058841758;
        Wed, 15 Nov 2023 06:34:01 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:a40b:e654:dd4c:2f5f])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b004060f0a0fd5sm15207643wmo.13.2023.11.15.06.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:34:00 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 11/14] replay: use standard revision ranges
Date: Wed, 15 Nov 2023 15:33:24 +0100
Message-ID: <20231115143327.2441397-12-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.15.g29556bcc86
In-Reply-To: <20231115143327.2441397-1-christian.couder@gmail.com>
References: <20231102135151.843758-1-christian.couder@gmail.com>
 <20231115143327.2441397-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

Instead of the fixed "<oldbase> <branch>" arguments, the replay
command now accepts "<revision-range>..." arguments in a similar
way as many other Git commands. This makes its interface more
standard and more flexible.

This also enables many revision related options accepted and
eaten by setup_revisions(). If the replay command was a high level
one or had a high level mode, it would make sense to restrict some
of the possible options, like those generating non-contiguous
history, as they could be confusing for most users.

Also as the interface of the command is now mostly finalized,
we can add more documentation and more testcases to make sure
the command will continue to work as designed in the future.

We only document the rev-list related options among all the
revision related options that are now accepted, as the rev-list
related ones are probably the most useful for now.

Helped-by: Dragan Simic <dsimic@manjaro.org>
Helped-by: Linus Arver <linusa@google.com>
Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replay.txt             | 58 ++++++++++++++++++++++--
 builtin/replay.c                         | 21 ++-------
 t/t3650-replay-basics.sh                 | 12 ++++-
 t/t6429-merge-sequence-rename-caching.sh | 18 ++++----
 4 files changed, 77 insertions(+), 32 deletions(-)

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
index 87a85a7f57..fab4ea0178 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.txt
@@ -9,16 +9,16 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 SYNOPSIS
 --------
 [verse]
-'git replay' --onto <newbase> <oldbase> <branch> # EXPERIMENTAL
+'git replay' --onto <newbase> <revision-range>... # EXPERIMENTAL
 
 DESCRIPTION
 -----------
 
-Takes a range of commits, specified by <oldbase> and <branch>, and
-replays them onto a new location (see `--onto` option below). Leaves
+Takes ranges of commits and replays them onto a new location. Leaves
 the working tree and the index untouched, and updates no references.
 The output of this command is meant to be used as input to
-`git update-ref --stdin`, which would update the relevant branches.
+`git update-ref --stdin`, which would update the relevant branches
+(see the OUTPUT section below).
 
 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
@@ -28,6 +28,30 @@ OPTIONS
 --onto <newbase>::
 	Starting point at which to create the new commits.  May be any
 	valid commit, and not just an existing branch name.
++
+The update-ref command(s) in the output will update the branch(es) in
+the revision range to point at the new commits, similar to the way how
+`git rebase --update-refs` updates multiple branches in the affected
+range.
+
+<revision-range>::
+	Range of commits to replay; see "Specifying Ranges" in
+	linkgit:git-rev-parse and the "Commit Limiting" options below.
+
+include::rev-list-options.txt[]
+
+OUTPUT
+------
+
+When there are no conflicts, the output of this command is usable as
+input to `git update-ref --stdin`.  It is of the form:
+
+	update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
+	update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
+	update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
+
+where the number of refs updated depends on the arguments passed and
+the shape of the history being replayed.
 
 EXIT STATUS
 -----------
@@ -37,6 +61,32 @@ the replay has conflicts, the exit status is 1.  If the replay is not
 able to complete (or start) due to some kind of error, the exit status
 is something other than 0 or 1.
 
+EXAMPLES
+--------
+
+To simply rebase `mybranch` onto `target`:
+
+------------
+$ git replay --onto target origin/main..mybranch
+update refs/heads/mybranch ${NEW_mybranch_HASH} ${OLD_mybranch_HASH}
+------------
+
+When calling `git replay`, one does not need to specify a range of
+commits to replay using the syntax `A..B`; any range expression will
+do:
+
+------------
+$ git replay --onto origin/main ^base branch1 branch2 branch3
+update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
+update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
+update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
+------------
+
+This will simultaneously rebase `branch1`, `branch2`, and `branch3`,
+all commits they have since `base`, playing them on top of
+`origin/main`. These three branches may have commits on top of `base`
+that they have in common, but that does not need to be the case.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/replay.c b/builtin/replay.c
index 73a25e9e85..7a660020d1 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -14,7 +14,6 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "revision.h"
-#include "strvec.h"
 #include <oidset.h>
 #include <tree.h>
 
@@ -118,16 +117,14 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct commit *onto;
 	const char *onto_name = NULL;
 	struct commit *last_commit = NULL;
-	struct strvec rev_walk_args = STRVEC_INIT;
 	struct rev_info revs;
 	struct commit *commit;
 	struct merge_options merge_opt;
 	struct merge_result result;
-	struct strbuf branch_name = STRBUF_INIT;
 	int ret = 0;
 
 	const char * const replay_usage[] = {
-		N_("git replay --onto <newbase> <oldbase> <branch> # EXPERIMENTAL"),
+		N_("git replay --onto <newbase> <revision-range>... # EXPERIMENTAL"),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -145,18 +142,10 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		usage_with_options(replay_usage, replay_options);
 	}
 
-	if (argc != 3) {
-		error(_("bad number of arguments"));
-		usage_with_options(replay_usage, replay_options);
-	}
-
 	onto = peel_committish(onto_name);
-	strbuf_addf(&branch_name, "refs/heads/%s", argv[2]);
 
 	repo_init_revisions(the_repository, &revs, prefix);
 
-	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
-
 	/*
 	 * Set desired values for rev walking options here. If they
 	 * are changed by some user specified option in setup_revisions()
@@ -171,8 +160,9 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	revs.topo_order = 1;
 	revs.simplify_history = 0;
 
-	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
-		ret = error(_("unhandled options"));
+	argc = setup_revisions(argc, argv, &revs, NULL);
+	if (argc > 1) {
+		ret = error(_("unrecognized argument: %s"), argv[1]);
 		goto cleanup;
 	}
 
@@ -205,8 +195,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		revs.simplify_history = 0;
 	}
 
-	strvec_clear(&rev_walk_args);
-
 	if (prepare_revision_walk(&revs) < 0) {
 		ret = error(_("error preparing revisions"));
 		goto cleanup;
@@ -248,7 +236,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	ret = result.clean;
 
 cleanup:
-	strbuf_release(&branch_name);
 	release_revisions(&revs);
 
 	/* Return */
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 3567c98362..a1da4f9ef9 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -52,7 +52,7 @@ test_expect_success 'setup bare' '
 '
 
 test_expect_success 'using replay to rebase two branches, one on top of other' '
-	git replay --onto main topic1 topic2 >result &&
+	git replay --onto main topic1..topic2 >result &&
 
 	test_line_count = 1 result &&
 
@@ -68,8 +68,16 @@ test_expect_success 'using replay to rebase two branches, one on top of other' '
 '
 
 test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
-	git -C bare replay --onto main topic1 topic2 >result-bare &&
+	git -C bare replay --onto main topic1..topic2 >result-bare &&
 	test_cmp expect result-bare
 '
 
+test_expect_success 'using replay to rebase with a conflict' '
+	test_expect_code 1 git replay --onto topic1 B..conflict
+'
+
+test_expect_success 'using replay on bare repo to rebase with a conflict' '
+	test_expect_code 1 git -C bare replay --onto topic1 B..conflict
+'
+
 test_done
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index 099aefeffc..0f39ed0d08 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -71,7 +71,7 @@ test_expect_success 'caching renames does not preclude finding new ones' '
 
 		git switch upstream &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
@@ -141,7 +141,7 @@ test_expect_success 'cherry-pick both a commit and its immediate revert' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
@@ -201,7 +201,7 @@ test_expect_success 'rename same file identically, then reintroduce it' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
@@ -279,7 +279,7 @@ test_expect_success 'rename same file identically, then add file to old dir' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
@@ -357,7 +357,7 @@ test_expect_success 'cached dir rename does not prevent noticing later conflict'
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test_must_fail git replay --onto HEAD upstream~1 topic >output &&
+		test_must_fail git replay --onto HEAD upstream~1..topic >output &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 2 calls
@@ -456,7 +456,7 @@ test_expect_success 'dir rename unneeded, then add new file to old dir' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
@@ -523,7 +523,7 @@ test_expect_success 'dir rename unneeded, then rename existing file into old dir
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
@@ -626,7 +626,7 @@ test_expect_success 'caching renames only on upstream side, part 1' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
@@ -685,7 +685,7 @@ test_expect_success 'caching renames only on upstream side, part 2' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
-- 
2.43.0.rc1.15.g29556bcc86

