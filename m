Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3233C433FE
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 01:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344307AbiCOBvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 21:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiCOBu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 21:50:59 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C31140CE
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:49:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r4-20020a1c4404000000b0038a12987e21so572583wma.4
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=khn7ErIy9kZJToPTZjqCZeka4sIae8cQ3dxGq3E+IF8=;
        b=YljWvAAWu69eSVmMxltfh+dUHrs12XX1tiv2jPz9EWMNGhVKAqPy/LUKD6X7i207JG
         xQHjoLtr6lWlq6bdum9O07FyfD2XcHGPsUJEUu92tSLjBSMD2TMmD0yquxITsCfKdWqb
         +YmcenCCxK1vQbWVo/ciqjruCyY/1FTeNSBqjBbogAMWQiv9ftERP+TSl06Hxx9M+Ow2
         7tIH1GlEP9ZFyKkGd1ttjJZj2s5DGXkc3QJAaMtY++OPVAf1v0L6dUZm58Wt4jBgGTAZ
         oNGO8KA5MkUrrzVJMEy1kMVCw4kam6e2xSqt5jec2LAoC78axjkYsl1hia9n9UmDId+T
         /p8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=khn7ErIy9kZJToPTZjqCZeka4sIae8cQ3dxGq3E+IF8=;
        b=fPY9vHM/4SCGW1XfNTSi+1DPyIAiPCb2/whWkn2otiu7fOFs97jLFqlyq5dD4FI/k3
         DQi75uMAPoB1rzg8Z57aFMWgSIKEK3owbinbL+vdhogMqFkrDPustGCXcw01dZlLk1HS
         fRLipcYGj4AzOcZ9QfuSk7VEz1n0w455QWY1jFIH9nxYRAfYT+UCVp5SE3GNxH6t2pQm
         3bpgUXy4yWzWi3mpmf+cw8ZCVRGvGwGigskSDx5q5Rwl2yOokyvlmKBpX0SHbcumWP3G
         bx5JzQqh0BITPjAfFeBNLPjaTB3ZdF/8YiV+btBBtI4MNug1Ceo5lBuHl3W56PMGCToI
         DJQw==
X-Gm-Message-State: AOAM530P/e3vRYDx8xsa6DhQWma4sjh0AKN7rVX1ygNYiPLhyYKb/huO
        e2KZKU2oukcJpRzSsPvJAgbDQUwxE28=
X-Google-Smtp-Source: ABdhPJwwIjq7JBMyaQ3Ul7EW3mkVMcalFTR1OjPTf8hG6eLjxJ9fNygIjHHx+JLoLu9JjGaNO+SODA==
X-Received: by 2002:a05:600c:3203:b0:381:b544:7970 with SMTP id r3-20020a05600c320300b00381b5447970mr1366651wmp.144.1647308987503;
        Mon, 14 Mar 2022 18:49:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m128-20020a1ca386000000b003898b148bf0sm884229wme.20.2022.03.14.18.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 18:49:47 -0700 (PDT)
Message-Id: <4c45351a0c4b8b955a9101ed9445a763750ca3c3.1647308982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1170.v3.git.1647308982.gitgitgadget@gmail.com>
References: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
        <pull.1170.v3.git.1647308982.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 01:49:42 +0000
Subject: [PATCH v3 5/5] stash: make internal resets quiet and refresh index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add the options '-q' and '--refresh' to the 'git reset' executed in
'reset_head()', and '--refresh' to the 'git reset -q' executed in
'do_push_stash(...)'.

'stash' is implemented such that git commands invoked  as part of it (e.g.,
'clean', 'read-tree', 'reset', etc.) have their informational output
silenced. However, the 'reset' in 'reset_head()' is *not* called with '-q',
leading to the potential for a misleading printout from 'git stash apply
--index' if the stash included a removed file:

Unstaged changes after reset: D      <deleted file>

Not only is this confusing in its own right (since, after the reset, 'git
stash' execution would stage the deletion in the index), it would be printed
even when the stash was applied with the '-q' option. As a result, the
messaging is removed entirely by calling 'git status' with '-q'.

Additionally, because the default behavior of 'git reset -q' is to skip
refreshing the index, but later operations in 'git stash' subcommands expect
a non-stale index, enable '--refresh' as well.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/stash.c  |  5 +++--
 t/t3903-stash.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 3e8af210fde..91407d9bbe0 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -310,7 +310,7 @@ static int reset_head(void)
 	 * API for resetting.
 	 */
 	cp.git_cmd = 1;
-	strvec_push(&cp.args, "reset");
+	strvec_pushl(&cp.args, "reset", "--quiet", "--refresh", NULL);
 
 	return run_command(&cp);
 }
@@ -1633,7 +1633,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			cp.git_cmd = 1;
-			strvec_pushl(&cp.args, "reset", "-q", "--", NULL);
+			strvec_pushl(&cp.args, "reset", "-q", "--refresh", "--",
+				     NULL);
 			add_pathspecs(&cp.args, ps);
 			if (run_command(&cp)) {
 				ret = -1;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index f36e121210e..1a5c1bd3109 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -261,6 +261,18 @@ test_expect_success 'apply -q is quiet' '
 	test_must_be_empty output.out
 '
 
+test_expect_success 'apply --index -q is quiet' '
+	# Added file, deleted file, modified file all staged for commit
+	echo foo >new-file &&
+	echo test >file &&
+	git add new-file file &&
+	git rm other-file &&
+
+	git stash &&
+	git stash apply --index -q >output.out 2>&1 &&
+	test_must_be_empty output.out
+'
+
 test_expect_success 'save -q is quiet' '
 	git stash save --quiet >output.out 2>&1 &&
 	test_must_be_empty output.out
@@ -291,6 +303,27 @@ test_expect_success 'drop -q is quiet' '
 	test_must_be_empty output.out
 '
 
+test_expect_success 'stash push -q --staged refreshes the index' '
+	git reset --hard &&
+	echo test >file &&
+	git add file &&
+	git stash push -q --staged &&
+	git diff-files >output.out &&
+	test_must_be_empty output.out
+'
+
+test_expect_success 'stash apply -q --index refreshes the index' '
+	echo test >other-file &&
+	git add other-file &&
+	echo another-change >other-file &&
+	git diff-files >expect &&
+	git stash &&
+
+	git stash apply -q --index &&
+	git diff-files >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'stash -k' '
 	echo bar3 >file &&
 	echo bar4 >file2 &&
-- 
gitgitgadget
