Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E8FC28D13
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 02:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbiHWCm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 22:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238943AbiHWCm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 22:42:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45BF5C361
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 19:42:25 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u14so15332897wrq.9
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 19:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=xcO+M11/E8EZNiTZNC/88RYJ4wa54MLl8eX6KNLonHY=;
        b=YcZfvChOGZckXz6L4svlc9GuNCr0Ls4BKEffaY1JbXw4/XKMJh9SxfNeIydEzgAHZf
         Uyq8nEwCdmAnFJweRqN7ZYuJ6KoKSuUCrP1AdJSDIOKnhoYF2vImueTjULawc2SCZ8L3
         bOkWcvxgGoe4n1tCcHovyUmMJGUd7NuvMBlUDnsp3VGurz5mJvh7s4+AelSJEIwUazV3
         iiM5rKuNdWQ9UKZhi/8KeetWvlGtAveRx8VqI4sDQJ7JX9mg/KJg27Uf2mQxinyi8VUd
         /9/Wgf49r8sxR+tcFsPmH/iw0Ih6ke1XeoUiNtrcQE3H7ZGm/ectclNqiaPsh3A3+XBz
         nT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=xcO+M11/E8EZNiTZNC/88RYJ4wa54MLl8eX6KNLonHY=;
        b=NvNpIYgtmwAX63K4r9dL9eF9Ys3otKjgqXHJ6V2PDaEL3c+fxjVy+17YaHkK5bZla4
         dmpFMuUzkPPVcXHZ3P993SZMcgsiO4Osrz03EIi89BYaF2Xu9dEbnJCHEXAtXE507as8
         C7i0OAj5LCA9BB1ecfaen3xuJj3J+cSHcQYFziLLICAgOKIH/YtLV/KoZTguCm11BQ+a
         ADDokT+7tlPBqQrT+jk93AUQRkxcKLmAN9S5EolZMobeMo7G6onBhFUrkS8D9/OPkhjR
         QLrrzTB12st7HZW3lov+M12yBm7doKe+/y5gUE7x5hhsIz8FAsxhXP68o2Bu8MJK/NFD
         xoXw==
X-Gm-Message-State: ACgBeo1bcwEuu73hYEDYDL7QfD9SqCs7La1GVeIQQkCdLizeYzwCRh9l
        /ePH0YdSz47rBVoI3Ym70e4hoZ4r1do=
X-Google-Smtp-Source: AA6agR5BEaXvAkRaTXXJ5hcD86BpKDChXOh6ZtvSPqzUHhBp65QOJgBe7rBg3TrQEKYoEbZlZTjrrA==
X-Received: by 2002:a05:6000:144e:b0:225:36c6:50a5 with SMTP id v14-20020a056000144e00b0022536c650a5mr9649259wrx.543.1661222544080;
        Mon, 22 Aug 2022 19:42:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b003a5f3de6fddsm20451733wms.25.2022.08.22.19.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 19:42:23 -0700 (PDT)
Message-Id: <610b8d089db97bf1a37dbf230f51ecafe3086254.1661222541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1331.v2.git.1661222541.gitgitgadget@gmail.com>
References: <pull.1331.git.1661056709.gitgitgadget@gmail.com>
        <pull.1331.v2.git.1661222541.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 02:42:19 +0000
Subject: [PATCH v2 1/3] merge: only apply autostash when appropriate
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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
index f0f6fda150b..7c3f6ed9943 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -255,6 +255,15 @@ test_expect_success 'merge --squash c3 with c7' '
 	test_cmp expect actual
 '
 
+test_expect_success 'merge --squash --autostash conflict does not attempt to apply autostash' '
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

