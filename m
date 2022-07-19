Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B32DC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbiGSSeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239712AbiGSSeD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:34:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD595D593
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:34:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h17so22951679wrx.0
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6hrat/jW19G/2h96a4zwXbC4NuHToQ5PdMlR+xh9Vx8=;
        b=Z8Y+RM81AKPjsxGB06wDeubfWR13IzhkaQIwREhk5Dcf431BgcR7BSwpH3OhA7KnrI
         PU/9TRPkpDzuUfFKnUVkMIyDll8OMgoXBfVJdN4DHwh9mzPB7uFG43xTFcwv0PQ1lvzc
         0FQCnbREk8YgUMXPjUo0yVtFLhpfFaTcd+q4y7Q+T71oyY1uqpPIZmiPEHQDkgL9SAdo
         F0UJw+UsRIQRz99iYowcwBHo0sjTHCabfepu5mEiB3Ws8Hw6RGb+x60e+yGuuKyvQn2/
         gC9QFxILqqVYbSTTSO7CSBc9Perk9kTQ+LVnv6JezRdSNRL1sg5mWZY9BqMs5cgRvRbe
         BZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6hrat/jW19G/2h96a4zwXbC4NuHToQ5PdMlR+xh9Vx8=;
        b=4xAgyYhbv8LJOT4X0fzzkR/+mXg5sOWxl6XXV5izLIQQfnv0krUS7TuUgNkkdpYjvY
         DeUsrR0WUjB5dPl0bx281Wto04jT4DxpgI+ganBNin7no8ZxyGqcwqrtEIBbb0pE9mFD
         omolLCSORcbJrjlzdHyAWNcxMNFiW+U0ZGT7jjaxGMvEE4W5M0hGWLi2/IrExQm2rOww
         rpVX7VmX7n1NxJ26kOPn24+szS7lGDtmxYFlgfH7nLvNdJPQTm3eHvXBtAJdMv+XtTVt
         Zmt1irGSy++GQs9tdic+BV+2+5dG1D3BFXDbfhYuDSRfzMbJzwxX9/UOB4Ub8gwoj5Sg
         x2KQ==
X-Gm-Message-State: AJIora83fXwg9+Rwag4Ux/4BUOCErRunhLRi/gqGT/CSAJ6mz+e3d2Wn
        N5VqTeNYqtntFzju2Dc0lvGhO90qoDs=
X-Google-Smtp-Source: AGRyM1vgKiZs65jCM8T0M2zf599ssArjZV+yTxw5iefA9ppWpfstwdIAt0altT1O6EAFnlusPaCR8Q==
X-Received: by 2002:adf:fd42:0:b0:21e:4357:3f38 with SMTP id h2-20020adffd42000000b0021e43573f38mr2119550wrs.620.1658255639929;
        Tue, 19 Jul 2022 11:33:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2-20020adff482000000b0021b9585276dsm14034721wro.101.2022.07.19.11.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:33:59 -0700 (PDT)
Message-Id: <a73b02568f3aa35c6db219b01040379c4d120067.1658255624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
References: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
        <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:33:42 +0000
Subject: [PATCH v5 10/12] rebase: add rebase.updateRefs config option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change added the --update-refs command-line option.  For
users who always want this mode, create the rebase.updateRefs config
option which behaves the same way as rebase.autoSquash does with the
--autosquash option.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/rebase.txt |  3 +++
 Documentation/git-rebase.txt    |  3 +++
 builtin/rebase.c                |  5 +++++
 t/t3404-rebase-interactive.sh   | 14 ++++++++++++++
 4 files changed, 25 insertions(+)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index 8c979cb20f2..f19bd0e0407 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -21,6 +21,9 @@ rebase.autoStash::
 	`--autostash` options of linkgit:git-rebase[1].
 	Defaults to false.
 
+rebase.updateRefs::
+	If set to true enable `--update-refs` option by default.
+
 rebase.missingCommitsCheck::
 	If set to "warn", git rebase -i will print a warning if some
 	commits are removed (e.g. a line was deleted), however the
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index dfd847d6615..305255f1e15 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -614,6 +614,9 @@ start would be overridden by the presence of
 	Automatically force-update any branches that point to commits that
 	are being rebased. Any branches that are checked out in a worktree
 	are not updated in this way.
++
+If the configuration variable `rebase.updateRefs` is set, then this option
+can be used to override and disable this setting.
 
 INCOMPATIBLE OPTIONS
 --------------------
diff --git a/builtin/rebase.c b/builtin/rebase.c
index fd64897132a..dbb91895687 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -802,6 +802,11 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.updaterefs")) {
+		opts->update_refs = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "rebase.reschedulefailedexec")) {
 		opts->reschedule_failed_exec = git_config_bool(var, value);
 		return 0;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index bebf9b4def7..1a27bb0626d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1772,6 +1772,12 @@ test_expect_success '--update-refs adds label and update-ref commands' '
 		EOF
 
 		test_must_fail git rebase -i --autosquash --update-refs primary >todo &&
+		test_cmp expect todo &&
+
+		test_must_fail git -c rebase.autosquash=true \
+				   -c rebase.updaterefs=true \
+				   rebase -i primary >todo &&
+
 		test_cmp expect todo
 	)
 '
@@ -1813,6 +1819,14 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
 				   --rebase-merges=rebase-cousins \
 				   --update-refs primary >todo &&
 
+		test_cmp expect todo &&
+
+		test_must_fail git -c rebase.autosquash=true \
+				   -c rebase.updaterefs=true \
+				   rebase -i \
+				   --rebase-merges=rebase-cousins \
+				   primary >todo &&
+
 		test_cmp expect todo
 	)
 '
-- 
gitgitgadget

