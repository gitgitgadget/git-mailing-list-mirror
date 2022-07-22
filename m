Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C8EC43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 05:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiGVFQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 01:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiGVFPz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 01:15:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473B82494E
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 22:15:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m17so4712171wrw.7
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 22:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9InglnYuYAH/AdHw7kf0W+m4eVbt4/lAXFozLEovVSQ=;
        b=jE1gPPvUY1P1MUXSbseaZPU+JIQkX17XDx/U+On37bGVektk9oyrnOeKCWul3JY8ab
         0Gown8Lwt9Ph5JSrcZB1DGHrRlJ33wKT6LybV95+/OQGnwaKduU6eIvLOQrA1cP30Kag
         RzAh0oaLER4gD0Kams/TUSPaSjjazbWDUaiMasDgIXSi5MSuYBtbykwu/kz9ZviJRRue
         YDnphQCHFZ8sRVVCp+NAYMELiGrP+uB6mmusKqVHUtKgSigxkg5bM7LDtvBguPXTCELB
         nFr/RnGNhOJwUHiZm9pXxXfQjnOinDXU9ZY2OdKUbXmCuYK5VitHOiZzSmvd+gx3nl3L
         ENeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9InglnYuYAH/AdHw7kf0W+m4eVbt4/lAXFozLEovVSQ=;
        b=nIWMz+jpHurGeB4y3fRxifbNbMKp0JGucnjMI6ymvgUOGomsownuaICnt92DSMFqY2
         dGHObZmhSNz2j0uHKpUdY+2Iig6JP1+YGXjo4sSWrKNkaS/9gFmw4193wGSlzNnjBziB
         YMLD4eTzpBSRGjIIy96qE24Mi5jAsdrE5pZmw2/qh7mCMgMVqUS9wW0vtIFEwnn4yVuJ
         4bUH01U2BEu4qYSfDkJggMtQ9jGBL7f+DilzDjy8PSGYSp1irl2g6FZ2xQizS8mxqm2N
         vPozgOT3l9DCwT0LOQDZ7xUaIHa9xDkg/auIwNTeODwh9JW7naj4r3A2C//d0gwKv5wz
         xgdQ==
X-Gm-Message-State: AJIora8AHUVD6NF7NjHfmfVqHRqsBFNlftJ1xq6j953w/LWXk5Rz47m9
        F9LimOMIBO/cpwb+lAc49MypaQ3FV40=
X-Google-Smtp-Source: AGRyM1tYxMAh50kSR3AwY3t44NncDYuThKrKvbWwZin7XzXr0hQWW+h34TCQrPourL9bZNeLhSKYVg==
X-Received: by 2002:a5d:588f:0:b0:21d:a516:f57b with SMTP id n15-20020a5d588f000000b0021da516f57bmr1085177wrf.685.1658466951512;
        Thu, 21 Jul 2022 22:15:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d5186000000b0021e571a99d5sm2964204wrv.17.2022.07.21.22.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 22:15:51 -0700 (PDT)
Message-Id: <6212d572604cd8ec5c57ab0c66da53bd95ed6005.1658466942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
References: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
        <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jul 2022 05:15:42 +0000
Subject: [PATCH v4 7/7] merge: do not exit restore_state() prematurely
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Previously, if the user:

* Had no local changes before starting the merge
* A merge strategy makes changes to the working tree/index but returns
  with exit status 2

Then we'd call restore_state() to clean up the changes and either let
the next merge strategy run (if there is one), or exit telling the user
that no merge strategy could handle the merge.  Unfortunately,
restore_state() did not clean up the changes as expected; that function
was a no-op if the stash was a null, and the stash would be null if
there were no local changes before starting the merge.  So, instead of
"Rewinding the tree to pristine..." as the code claimed, restore_state()
would leave garbage around in the index and working tree (possibly
including conflicts) for either the next merge strategy or for the user
after aborting the merge.  And in the case of aborting the merge, the
user would be unable to run "git merge --abort" to get rid of the
unintended leftover conflicts, because the merge control files were not
written as it was presumed that we had restored to a clean state
already.

Fix the main problem by making sure that restore_state() only skips the
stash application if the stash is null rather than skipping the whole
function.

However, there is a secondary problem -- since merge.c forks
subprocesses to do the cleanup, the in-memory index is left out-of-sync.
While there was a refresh_cache(REFRESH_QUIET) call that attempted to
correct that, that function would not handle cases where the previous
merge strategy added conflicted entries.  We need to drop the index and
re-read it to handle such cases.

(Alternatively, we could stop forking subprocesses and instead call some
appropriate function to do the work which would update the in-memory
index automatically.  For now, just do the simple fix.)

Also, add a testcase checking this, one for which the octopus strategy
fails on the first commit it attempts to merge, and thus which it
cannot handle at all and must completely bail on (as per the "exit 2"
code path of commit 98efc8f3d8 ("octopus: allow manual resolve on the
last round.", 2006-01-13)).

Reported-by: ZheNing Hu <adlternative@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c        | 10 ++++++----
 t/t7607-merge-state.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)
 create mode 100755 t/t7607-merge-state.sh

diff --git a/builtin/merge.c b/builtin/merge.c
index 11bb4bab0a1..7fb4414ebb7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -386,11 +386,11 @@ static void restore_state(const struct object_id *head,
 	const char *args[] = { "stash", "apply", "--index", "--quiet",
 			       NULL, NULL };
 
-	if (is_null_oid(stash))
-		return;
-
 	reset_hard(head, 1);
 
+	if (is_null_oid(stash))
+		goto refresh_cache;
+
 	args[4] = oid_to_hex(stash);
 
 	/*
@@ -399,7 +399,9 @@ static void restore_state(const struct object_id *head,
 	 */
 	run_command_v_opt(args, RUN_GIT_CMD);
 
-	refresh_cache(REFRESH_QUIET);
+refresh_cache:
+	if (discard_cache() < 0 || read_cache() < 0)
+		die(_("could not read index"));
 }
 
 /* This is called when no merge was necessary. */
diff --git a/t/t7607-merge-state.sh b/t/t7607-merge-state.sh
new file mode 100755
index 00000000000..fc33d57357b
--- /dev/null
+++ b/t/t7607-merge-state.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description="Test that merge state is as expected after failed merge"
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+. ./test-lib.sh
+
+test_expect_success 'set up custom strategy' '
+	test_commit --no-tag "Initial" base base &&
+
+	for b in branch1 branch2 branch3
+	do
+		git checkout -b $b main &&
+		test_commit --no-tag "Change on $b" base $b || return 1
+	done &&
+
+	git checkout branch1 &&
+	# This is a merge that octopus cannot handle.  Note, that it does not
+	# just hit conflicts, it completely fails and says that it cannot
+	# handle this type of merge.
+	test_expect_code 2 git merge branch2 branch3 >output 2>&1 &&
+	grep "fatal: merge program failed" output &&
+	grep "Should not be doing an octopus" output &&
+
+	# Make sure we did not leave stray changes around when no appropriate
+	# merge strategy was found
+	git diff --exit-code --name-status &&
+	test_path_is_missing .git/MERGE_HEAD
+'
+
+test_done
-- 
gitgitgadget
