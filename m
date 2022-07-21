Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F008C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 08:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiGUIQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 04:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiGUIQn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 04:16:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FEC7D78C
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 01:16:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h8so1154075wrw.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 01:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xRjx3GHengqE4lF7ebtLjKNtoNDHdxoCL7MPpYxY6xg=;
        b=mh6+MtQSKvTJW5Q4VMc952EXx6KZC64bCMozDoyEnJ3BEq1LeTekylG/g9G9aOiw9U
         Ob+zrOLzOdKSqcXCddoZ5Xaq3oirTEw2jOc+OvZBRqr5Yz8t+Oxq0QiAuxVJNq2bIQun
         aJYhvi8LmU5z36mLjhJC8eaYrFwWs5uPWxAdilmCBl53WpqBSqhaNpPrLXmAvviQ4+Ay
         oztsv1RuKFdsVXUy5Vb22qzKh0TxUiJ31SvWyTKN2myxqWIHtF+zyFlzK/YRdvrM9mH4
         uK3EqkK3U4CtQt8d2TTS2WJyg8FNvX0BICAton0QERcUDtXuphnQib5+fj85lHLIxVEA
         vzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xRjx3GHengqE4lF7ebtLjKNtoNDHdxoCL7MPpYxY6xg=;
        b=w3CGOGxACB5jM6olB6sYuj7KA03FGVIzArfxeURLl/KZLVrBvw+I4kKPVn/NNpnjOO
         VgtE1tzFsz8H0WE9E+cXNgh9R4xl1PnCkosUsyBtqX5IKzDRUwgM4luORSeWAdKwC62q
         RTaaGXd/G2nGqerELMgYmLzxgKUEc4wrVqWKYqCD31NesEx3WQCewQ16LGELXahawZWC
         3LenJ8+Qce1KDXpfv/nhqXy3XDeF0WW7ufXLX/TomMVY2Nh4NpgqFsuI4Q53xo0ohW7I
         mTBkVtBsbTKOCKDGQg1aBwYz5JnoqIpvQ1LP2NRm8iPsYq/mTeg9nRLQVdzc+vnJszpp
         4LmQ==
X-Gm-Message-State: AJIora8cLbY831RE4vTFc49+dwAyKeg2Uo/GExUs8gNlcMSLob1+2Qg/
        xWOVh0p5xFlvweeabjtJbj11rzK+7EA=
X-Google-Smtp-Source: AGRyM1suq1JM2iLna2VLRoRT0WfFflbFyxWmciSCIcP1oDvPYWoLmQXtBKJAlLQsvTzkfQy1fpJJBQ==
X-Received: by 2002:a5d:6e8d:0:b0:21e:48a4:b267 with SMTP id k13-20020a5d6e8d000000b0021e48a4b267mr5227239wrz.507.1658391400106;
        Thu, 21 Jul 2022 01:16:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z4-20020adfd0c4000000b0021d7b41255esm1100696wrh.98.2022.07.21.01.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 01:16:39 -0700 (PDT)
Message-Id: <64700338a28b04be93d8d4bc8b2c75cab75ab5cd.1658391391.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 08:16:28 +0000
Subject: [PATCH v3 4/7] merge: fix save_state() to work when there are
 stat-dirty files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When there are stat-dirty files, but no files are modified,
`git stash create` exits with unsuccessful status.  This causes merge
to fail.  Copy some code from sequencer.c's create_autostash to refresh
the index first to avoid this problem.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c                          |  8 ++++++++
 t/t6424-merge-unrelated-index-changes.sh | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index dec7375bf2a..4170c30317e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -313,8 +313,16 @@ static int save_state(struct object_id *stash)
 	int len;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buffer = STRBUF_INIT;
+	struct lock_file lock_file = LOCK_INIT;
+	int fd;
 	int rc = -1;
 
+	fd = repo_hold_locked_index(the_repository, &lock_file, 0);
+	refresh_cache(REFRESH_QUIET);
+	if (0 <= fd)
+		repo_update_index_if_able(the_repository, &lock_file);
+	rollback_lock_file(&lock_file);
+
 	strvec_pushl(&cp.args, "stash", "create", NULL);
 	cp.out = -1;
 	cp.git_cmd = 1;
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index 8b749e19083..3019d030e07 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -268,6 +268,17 @@ test_expect_success 'subtree' '
 	test_path_is_missing .git/MERGE_HEAD
 '
 
+test_expect_success 'avoid failure due to stat-dirty files' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	# Make "a" be stat-dirty
+	test-tool chmtime =+1 a &&
+
+	# stat-dirty file should not prevent stash creation in builtin/merge.c
+	git merge -s resolve -s recursive D^0
+'
+
 test_expect_success 'resolve && recursive && ort' '
 	git reset --hard &&
 	git checkout B^0 &&
-- 
gitgitgadget

