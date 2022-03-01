Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E10C433FE
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 20:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbiCAU07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238385AbiCAU0a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 15:26:30 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481858D69B
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 12:24:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r65so562593wma.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 12:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g1HUFkbhfUBZN6xi/xbSLkpwawNhxPTM9wfs8BMBgzo=;
        b=FTXfpHjlbMg4dYNgOVzaLYKzG79eoQztJ6tXpFp5llgFBNWhpRsbkvl2qTDPs6pdnI
         YBGljoJBL/qP1Ix4PQYHmKEDpYpGyKXwb4mPJxmJh+7zIfGWfH7ArFmiPJjG9Dl3+cUE
         QG55d8/cUr2AAsssoj8/eS483y6nLo1Xz0G7o3A8Yc/YmEKWa4FufgBelg7yh0xto6Mx
         o7VtasY7lsthIIh1hr5tuyBXAwe1e8as2SGRNjvRPHyZoJJP9EC//S0dkPEkTA5GfHoA
         Ir2KZlQu/LzzNDp+k43Oew5/1X4p/uLRq9Fe8DDy012Mj8w2v24IXXHIg+Gu9hnyfJhx
         dugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g1HUFkbhfUBZN6xi/xbSLkpwawNhxPTM9wfs8BMBgzo=;
        b=jxw1TUflcMQpvkTwpC7SCMob1fUHoMuxzH0Uvyt2+ow8EshxEzhsNMxxvgE6azMmNU
         jgMqawSPW3+bHnoE1xND7ml7pJJK13kSgs9pjQt+0oUq94gKigaQPtH8rIIdnCoPJW9T
         PQUJI/V99h/CBugPrBVUv6GAY7vdRLHmzySwCgGYirSEQcecCzbs8WyLNULISqeZWl0p
         kFMBWVI9wEGuS3Am23NWp24Qbc/wiGJ/Yr+hgvZCF7hdF0KHQEWvfA1Zq8g2fg1LTNf6
         N5LayQtI8mElcEL5vgOjBCbMgVDF2YsuG7vbTCG55ec3A9AiMLjaxwG0rH0Er49fuQ04
         qJ/A==
X-Gm-Message-State: AOAM530uUWx/3P9d7gp423S5+q1/AzBGx7zYm85FJ3GMFMKoFap+3Whh
        puzFairbffb5SW9DdANb8ywfsVZxOb8=
X-Google-Smtp-Source: ABdhPJz9SVJPgUO/FEX3heYmvgrKOmg1U/MQ0Z4uv1AHzFMySXnPk/H9FiuOCD6bhhFXYL4EE8GFuw==
X-Received: by 2002:a05:600c:3d99:b0:381:546c:8195 with SMTP id bi25-20020a05600c3d9900b00381546c8195mr10668012wmb.112.1646166274181;
        Tue, 01 Mar 2022 12:24:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d6908000000b001e3169cc6afsm14804348wru.94.2022.03.01.12.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 12:24:33 -0800 (PST)
Message-Id: <26f4d30bd9546cf940ddd6827ddfc271c99b6665.1646166271.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
References: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
        <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 20:24:25 +0000
Subject: [PATCH v3 2/8] status: fix nested sparse directory diff in sparse
 index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Enable the 'recursive' diff option for the diff executed as part of 'git
status'. Without the 'recursive' enabled, 'git status' reports index
changes incorrectly when the following conditions were met:

* sparse index is enabled
* there is a difference between the index and HEAD in a file inside a
  *subdirectory* of a sparse directory
* the sparse directory index entry is *not* expanded in-core

Because it is not recursive by default, the diff in 'git status' reports
changes only at the level of files and directories that are immediate
children of a sparse directory, rather than recursing into directories with
changes to identify the modified file(s). As a result, 'git status' reports
the immediate subdirectory itself as "modified".

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

Enabling the 'recursive' diff option in 'wt_status_collect_changes_index'
corrects this issue by allowing the diff to recurse into subdirectories of
sparse directories to find modified files. Given the same repository setup
as the example above, the corrected result of `git status` is:

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
index 335e723a71e..7da8bbe261a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -651,6 +651,15 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
 	rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
+
+	/*
+	 * The `recursive` option must be enabled to allow the diff to recurse
+	 * into subdirectories of sparse directory index entries. If it is not
+	 * enabled, a subdirectory containing file(s) with changes is reported
+	 * as "modified", rather than the modified files themselves.
+	 */
+	rev.diffopt.flags.recursive = 1;
+
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_index(&rev, 1);
 	object_array_clear(&rev.pending);
-- 
gitgitgadget

