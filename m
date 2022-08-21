Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98319C32774
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 04:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiHUEik (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 00:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiHUEif (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 00:38:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDC0E0D7
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 21:38:33 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u14so9430426wrq.9
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 21:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=X0II+Ol8/Sk6L+GKhipKwRFR7Ybf9+yL/dwYpVt3Z40=;
        b=eC7hd2b131AukPMwkPCvMJUbUQnLuLsRp/qekbw1na/bl0pmY7tFkeiRacHXz4GfHk
         tczyrK/xXzJNkJkQJ+Qy3l6F06DHhcNGW5vGLZcORKfrgAppJZ0DVpLyj8bV6nbVbtwa
         FqHO5LkXGOrXMPs1qKFM2LrPMO3kXy9HNpGaJVCCHcWtmXOXHo9uX4raAZdrN1bkZQfs
         m0TmJR6Pfjsjq/cdzik+mizsiSWDXEmECfusiFu/NjA3r8DlgZ4ifDy7MzfCTWylg2YJ
         /nBVp0+rf3cMNDf8Hc3rEsoGImt/My1s2AA3M6JxYLkwaI3eZ99kGxieM1eyy+I9RKga
         08WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=X0II+Ol8/Sk6L+GKhipKwRFR7Ybf9+yL/dwYpVt3Z40=;
        b=rpoGoLy0Qu9bvwiyPsDTUlrKWxPhc0MpkLlMDfd0uVdvcpUEpggGHBKxSw/TGpIKf5
         b01DJ+OVvmkaEzLDuRPQjXwSdQ/Wu5EliTUtM7FDqvpYQzHrtPblh9KcbRz87u/pUfBN
         zho+iZTx/EIsgl3wsuyV2XyXpSx7U7B2aeGxgddc8/GNtTvo/HPt/qyqUdN3lfHfBbyD
         WkgQeJFfnp/PLwnHl0jwi4WO5nDL0qrULu7jAS3mB3gaJgSUHvv9kUzlIQo413QhqyxO
         sl/S4hLvhLEUcU68Ghe8EHcmfrXgEwCnmUzCJaRFACyTXr2zcw6DOdsuEbuO8mPw0HO1
         fh5A==
X-Gm-Message-State: ACgBeo3RH6n+IlTMCZ9pW2ptMmAFakYUtzxFre+L7U9AtvAA+F3gJOCt
        yc1SxPoKiSpYxyryD+Sx9moAxGiiTAs=
X-Google-Smtp-Source: AA6agR6visLtHoOAxAT/61omDaXvP+AzGttej+mth3vFTk9nSj/orZDO5VTStzAX5IU0E5K4oE6E0w==
X-Received: by 2002:a5d:5889:0:b0:225:58c7:e9b2 with SMTP id n9-20020a5d5889000000b0022558c7e9b2mr5672wrf.227.1661056711579;
        Sat, 20 Aug 2022 21:38:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c228f00b003a327b98c0asm9998724wmf.22.2022.08.20.21.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 21:38:31 -0700 (PDT)
Message-Id: <92840bf63782ca302e9d48a12faf7d4f5b3cc2d5.1661056709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1331.git.1661056709.gitgitgadget@gmail.com>
References: <pull.1331.git.1661056709.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Aug 2022 04:38:28 +0000
Subject: [PATCH 1/2] merge: only apply autostash when appropriate
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

If a merge failed and we are leaving conflicts in the working directory
for the user to resolve, we should not attempt to apply any autostash.

Further, if we fail to apply the autostash (because either the merge
failed, or the user requested --no-commit), then we should instruct the
user how to apply it later.

Add a testcase verifying we have corrected this behavior.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c  | 5 ++++-
 t/t7600-merge.sh | 9 +++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index f7c92c0e64f..b4253710d19 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -503,7 +503,8 @@ static void finish(struct commit *head_commit,
 	/* Run a post-merge hook */
 	run_hooks_l("post-merge", squash ? "1" : "0", NULL);
 
-	apply_autostash(git_path_merge_autostash(the_repository));
+	if (new_head)
+		apply_autostash(git_path_merge_autostash(the_repository));
 	strbuf_release(&reflog_message);
 }
 
@@ -1781,6 +1782,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			"stopped before committing as requested\n"));
 	else
 		ret = suggest_conflicts();
+	if (autostash)
+		printf(_("When finished, apply stashed changes with `git stash pop`\n"));
 
 done:
 	if (!automerge_was_ok) {
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index f0f6fda150b..6a39bc72122 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -255,6 +255,15 @@ test_expect_success 'merge --squash c3 with c7' '
 	test_cmp expect actual
 '
 
+test_expect_success 'merge --squash --autostash conflict does not attempt to play autostash' '
+	git reset --hard c3 &&
+	>unrelated &&
+	git add unrelated &&
+	test_must_fail git merge --squash c7 --autostash >out 2>err &&
+	! grep "Applying autostash resulted in conflicts." err &&
+	grep "When finished, apply stashed changes with \`git stash pop\`" out
+'
+
 test_expect_success 'merge c3 with c7 with commit.cleanup = scissors' '
 	git config commit.cleanup scissors &&
 	git reset --hard c3 &&
-- 
gitgitgadget

