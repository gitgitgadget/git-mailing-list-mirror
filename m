Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60DFC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 22:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbiBXWfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbiBXWfL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 17:35:11 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA491E0170
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:34:38 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d17so1781255wrc.9
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mKHL2nL51eB+mDp6PJ2T49JTazVcHNXbFerl3otKkM4=;
        b=XlYZzCdLQvLIxS4h1c9LsZDGu2yHgN2+C5Dq3KLIZlJfFePKTyJw9OWWMW0G+nJ4S2
         J+sMIksTNk4QRxIoyg8UIWJCBjCRgJ0sWRgqYjLXjvvyiEQd6LlYyuY45ORlloBrMr7z
         K6/Bo1IaOTt8ujfVs+qD0+gNAWf53UIvCcPbh+V9ptUpr2XVCJEQd+/3nejnl1D6RcU7
         BvLo0O6TdYA2DM0okr9bvcxaAGtR2ET+yGjscdMSev0nV8iUntshd89ZBL2yMkAI3eZv
         jxWkIrRypDpIomhtiOhslo7ViH4OIVGfPH8EaXpeNYgACvi8w6Y3Xep/JGwMlpXKI1Pu
         cw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mKHL2nL51eB+mDp6PJ2T49JTazVcHNXbFerl3otKkM4=;
        b=vkKHiZ7wuaYhxQWbGKfL05tpSbpm8sO6dbRkzTUxyEnHGlFimzu7ZfFjvjPe1hHvQP
         y/+Wdhig2G2XHL3UH/MLrs38e1H0UD/DJCtlHRPH6MFtqZjnCIo5/SpcKrFiTWopKDXX
         0TRwyKJ/6MwXVriwrTvgze83uwoI/eNR8tAfwxSoXNqnNyUnHeZ34GWFaqBdbuyKAWZF
         ZGim6SvcL3cqzU+G2bTKA8M4OqFYB+LU60KMkd82jmziSQoxIqFY6WHld5ogi01A3Uub
         sWUlRsR3oWJ0C5EWNiZ2dyjjcz0YB8d4iQ3+xKVETGXdsh5o/wMWZuJZOLJFSIsHaQIm
         I3nQ==
X-Gm-Message-State: AOAM5305IcPmuc40Yks8/PIYJThkk4yr+olENc+Q030x29cvFGsQRYUW
        HcYsywhmABDlvjGipqR56TFdq2QCrss=
X-Google-Smtp-Source: ABdhPJw6kaNDhFSS7iXga+SPxQTT7zIWuc+RxLU4qDEFGaWUhzcu2rvi3ybp8KqJs6d0imryO5Otwg==
X-Received: by 2002:a05:6000:1541:b0:1e8:30f7:b3f0 with SMTP id 1-20020a056000154100b001e830f7b3f0mr3743204wry.578.1645742076553;
        Thu, 24 Feb 2022 14:34:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5-20020adfdf85000000b001e713f774d3sm555634wrl.61.2022.02.24.14.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:34:36 -0800 (PST)
Message-Id: <f0cff03b95d574dff414a63325a0f1c6d2d1ff96.1645742073.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
        <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 22:34:28 +0000
Subject: [PATCH v2 2/7] status: fix nested sparse directory diff in sparse
 index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add the 'recursive' flag to 'wt_status_collect_changes_index(...)'. Without
the 'recursive' flag, 'git status' could report index changes incorrectly
when the following conditions were met:

* sparse index is enabled
* there is a difference between the index and HEAD in a file inside a
  *subdirectory* of a sparse directory
* the sparse directory index entry is *not* expanded in-core

In this scenario, 'git status' would not recurse into the sparse directory's
subdirectories to identify which file contained the difference between the
index and HEAD. Instead, it would report the immediate subdirectory itself
as "modified".

Example:

$ git init
$ mkdir -p sparse/sub
$ echo test >sparse/sub/foo
$ git add .
$ git commit -m "commit 1"
$ echo somethingelse >sparse/sub/foo
$ git add .
$ git commit -a -m "commit 2"
$ git sparse-checkout set --cone --sparse-index 'sparse'
$ git reset --soft HEAD~1
$ git status
On branch master
You are in a sparse checkout.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   sparse/sub

The 'recursive' diff option in 'wt_status_collect_changes_index' corrects
this by indicating that 'git status' should recurse into sparse directories
to find modified files. Given the same repository setup as the example
above, the corrected result of `git status` is:

$ git status
On branch master
You are in a sparse checkout.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   sparse/sub/foo

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 7 +++++++
 wt-status.c                              | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 9ef7cd80885..b1dcaa0e642 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -278,6 +278,13 @@ test_expect_success 'status with options' '
 	test_all_match git status --porcelain=v2 -uno
 '
 
+test_expect_success 'status with diff in unexpanded sparse directory' '
+	init_repos &&
+	test_all_match git checkout rename-base &&
+	test_all_match git reset --soft rename-out-to-out &&
+	test_all_match git status --porcelain=v2
+'
+
 test_expect_success 'status reports sparse-checkout' '
 	init_repos &&
 	git -C sparse-checkout status >full &&
diff --git a/wt-status.c b/wt-status.c
index 335e723a71e..4a5b9beeca1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -651,6 +651,15 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
 	rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
+
+	/*
+	 * The `recursive` option must be enabled to show differences in files
+	 * *more than* one level deep in a sparse directory index entry (e.g., given
+	 * sparse directory 'sparse-dir/', reporting a difference in the file
+	 * 'sparse-dir/another-dir/my-file').
+	 */
+	rev.diffopt.flags.recursive = 1;
+
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_index(&rev, 1);
 	object_array_clear(&rev.pending);
-- 
gitgitgadget

