Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40559C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CBB61166
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhJNR2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 13:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbhJNR2C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 13:28:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5276DC061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 10:25:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m22so21824372wrb.0
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 10:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wvE/mkUMUfFJD/DI31l6naRkXCYYRrMWURucntOZcCA=;
        b=kK7sbKDNWoOy2uT3UEjVuFBTU1GPjQYut3gNnUvQLyNIJMerldam2YffjW7lWFP6wy
         KkURQ8ZXiqHmZuWTjnEefdfZv/j3vjCamB5cvgN/opynVPgvbxqCtr71Fh40fgnbTy/0
         DwtpaEyEAs2VhFjQcCQ6AljmMxlQ1UpKVkjVpJWwKXXCXJ9UU3veIxsmoywoTi+Xa5MM
         61kxZg/aNZ+xWIxHMrTptQEOzPB86V0ssK7OmpsfLUnbhuVBc8IAhqU6d6f7DnVLBcQX
         taXScCcwEDuZY4uJv+GfTz9ehCCmXOd+MYOzbOgLW9LVi1nbe1SXqtmusfFpGmSjFm54
         FuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wvE/mkUMUfFJD/DI31l6naRkXCYYRrMWURucntOZcCA=;
        b=mIhCFOZeZGd7Tr4tG54hzuAggXEY3QDuDYC29g2FbN1jduOWy47woiEBqz93Ijqe++
         M0OmO/ORM5iJ1W5CwGYeikuShlKZAMhW7YP4v140+MfcOG7gOzbWEwh9pyGMXTbKB6CR
         7LNOu4Ibt8+sNYgkYRgtk/ABLHjzbv+L1qsSLhOGfTlcfg5IHZfR+oqFfcDMme94nZ2V
         Jtfj5/RI58QMxCWg3OC0vJUNUe1lbNpiv82p2Vy56b7FxWmmUaNjcLkM4T5uxAGDGFNK
         dC+2vw3XxXQS3vu+gGnAO2v1f5MI18F4eC5bHyndgCt3VN6P7y3+qG0SN7YDgl1zFfzH
         u2LA==
X-Gm-Message-State: AOAM533XQ61jlGhbwxKmvs/siI28hcgPESU+RqoAYHogRrArzAUaBEGY
        K61ElwwesZY0cd9g+58315836m4hvQ0=
X-Google-Smtp-Source: ABdhPJzJE5VGHyZkL/GGSdidkBQ/dgZHj96v/hnWLFH1egXVSGXHpdkRXTffM/2DuFDO66KGrWVoLw==
X-Received: by 2002:adf:a51e:: with SMTP id i30mr8491757wrb.206.1634232355908;
        Thu, 14 Oct 2021 10:25:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm2913361wrm.96.2021.10.14.10.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:25:55 -0700 (PDT)
Message-Id: <ddcee003c9292d1b4cdd64a97f9e1731a72faee8.1634232353.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.git.1634232352.gitgitgadget@gmail.com>
References: <pull.1050.git.1634232352.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 14 Oct 2021 17:25:52 +0000
Subject: [PATCH 2/2] blame: enable and test the sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Enable the sparse index for the 'git blame' command. The index was already
not expanded with this command, so the most interesting thing to do is to
add tests that verify that 'git blame' behaves correctly when the sparse
index is enabled and that its performance improves. More specifically, these
cases are:

1. The index is not expanded for 'blame' when given paths in the sparse
checkout cone at multiple levels.

2. Performance measurably improves for 'blame' with sparse index when given
paths in the sparse checkout cone at multiple levels.

The `p2000` tests demonstrate a ~60% execution time reduction when running
'blame' for a file two levels deep and and a ~30% execution time reduction
for a file three levels deep.

Test                                         before  after
----------------------------------------------------------------
2000.62: git blame f2/f4/a (full-v3)         0.31    0.32 +3.2%
2000.63: git blame f2/f4/a (full-v4)         0.29    0.31 +6.9%
2000.64: git blame f2/f4/a (sparse-v3)       0.55    0.23 -58.2%
2000.65: git blame f2/f4/a (sparse-v4)       0.57    0.23 -59.6%
2000.66: git blame f2/f4/f3/a (full-v3)      0.77    0.85 +10.4%
2000.67: git blame f2/f4/f3/a (full-v4)      0.78    0.81 +3.8%
2000.68: git blame f2/f4/f3/a (sparse-v3)    1.07    0.72 -32.7%
2000.99: git blame f2/f4/f3/a (sparse-v4)    1.05    0.73 -30.5%

We do not include paths outside the sparse checkout cone because blame
currently does not support blaming files outside of the sparse definition.
Attempting to do so fails with the following error:

fatal: no such path '<path outside sparse definition>' in HEAD

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 builtin/blame.c                          |  3 +++
 t/perf/p2000-sparse-operations.sh        |  2 ++
 t/t1092-sparse-checkout-compatibility.sh | 24 +++++++++++++++++-------
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 641523ff9af..af3d81e2bd4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -902,6 +902,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	long anchor;
 	const int hexsz = the_hash_algo->hexsz;
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	setup_default_color_by_age();
 	git_config(git_blame_config, &output_option);
 	repo_init_revisions(the_repository, &revs, NULL);
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index bff93f16e93..9ac76a049b8 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -115,5 +115,7 @@ test_perf_on_all git reset --hard
 test_perf_on_all git reset -- does-not-exist
 test_perf_on_all git diff
 test_perf_on_all git diff --staged
+test_perf_on_all git blame $SPARSE_CONE/a
+test_perf_on_all git blame $SPARSE_CONE/f3/a
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 1070bff1a83..54826e858a9 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -485,15 +485,16 @@ test_expect_success 'blame with pathspec inside sparse definition' '
 	test_all_match git blame deep/deeper1/deepest/a
 '
 
-# TODO: blame currently does not support blaming files outside of the
-# sparse definition. It complains that the file doesn't exist locally.
-test_expect_failure 'blame with pathspec outside sparse definition' '
+# Blame does not support blaming files outside of the sparse
+# definition, so we verify this scenario.
+test_expect_success 'blame with pathspec outside sparse definition' '
 	init_repos &&
 
-	test_all_match git blame folder1/a &&
-	test_all_match git blame folder2/a &&
-	test_all_match git blame deep/deeper2/a &&
-	test_all_match git blame deep/deeper2/deepest/a
+	test_sparse_match git sparse-checkout set &&
+	test_sparse_match test_must_fail git blame folder1/a &&
+	test_sparse_match test_must_fail git blame folder2/a &&
+	test_sparse_match test_must_fail git blame deep/deeper2/a &&
+	test_sparse_match test_must_fail git blame deep/deeper2/deepest/a
 '
 
 test_expect_success 'checkout and reset (mixed)' '
@@ -871,6 +872,15 @@ test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
 	)
 '
 
+test_expect_success 'sparse index is not expanded: blame' '
+	init_repos &&
+
+	ensure_not_expanded blame a &&
+	ensure_not_expanded blame deep/a &&
+	ensure_not_expanded blame deep/deeper1/a &&
+	ensure_not_expanded blame deep/deeper1/deepest/a
+'
+
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 # in this scenario, but it shouldn't.
 test_expect_success 'reset mixed and checkout orphan' '
-- 
gitgitgadget
