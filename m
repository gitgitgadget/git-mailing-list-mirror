Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3C9C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 13:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiGLNH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbiGLNHe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 09:07:34 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BA7B62A0
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z12so11093117wrq.7
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Lf6SgpdwYpYtmwknhfp5g1+YEgjcJq1jER6IP8K4sWE=;
        b=cjD89lNQ8jGCuFgdwzh2Q6vnJB3fYbCsDG0whNTmwCwuHBr5ubvRAOwOqezy5FrnfS
         KO5LhNx9gFeNGHBKC7DMBtHnuRFa2xs0zHS3sKwiyNCGyq74qOX39xLCh9TO6bylyox4
         20I0c9XdYa1f/Y4kQ0WoBbeuG+EFhQaCt5mG72ebX/XlnwtvGLEMkfIWh0Mq2YE2jWF3
         olZctKyHwRtYdneaggyTcGj3nrTffJBleEtrFt33awOvI9Gv9VoBD/UtA3ZGS5eSMhlt
         N1n+LJQuDkAWK2Y3644PIIdnMPc4ZhdSLDp2QrgsCfgpme4+bUBH63N3H/8LfTPBSEHc
         mpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Lf6SgpdwYpYtmwknhfp5g1+YEgjcJq1jER6IP8K4sWE=;
        b=vg/tfipzrfEXp6Eeq1EwKNrdEY5vl9B6heNow0HVzy2EGE/ovb6yxQVub8Yn6sq/vx
         g+zTnHEXBj9tKKhG1nPUg6w5UBxe1Toq6zpt2TvNOa95XVfrvRurLHJ5U/voDV29KteB
         eURqdC303RxPiO82bYZlisSyjtCUSQ6S3VCYv/34MUdpg3yu2Du8JVxmLQx7Xyq9atdi
         ckik+T/ufcCtQf3Zjgqr4eYn/dBKO8Vi81p3KsrmoYfuNQysYrD9ww93WluRAPyU45Fn
         /SUuqPJWCnWj8EuXk2h3p+6NjBBZ4W1YDY3HLn5NRByVJgzLiKQOr2P/57ThKVBW/qcZ
         K8ag==
X-Gm-Message-State: AJIora92pxBSxCjmgr43olkJBFncOtzNkVBk92CglLEueUxfCZb0jucu
        ih0rGf9lYwkO519WY0zjJITzf/Fr6PU=
X-Google-Smtp-Source: AGRyM1stAOv36GqfgjKw6QxsSinaqjAfCYmArG4Yoq7jSg+X91aC7acieiNbmNswL4ZsDW8pJ58s+A==
X-Received: by 2002:a5d:4986:0:b0:21d:776c:2f11 with SMTP id r6-20020a5d4986000000b0021d776c2f11mr21257828wrq.119.1657631244184;
        Tue, 12 Jul 2022 06:07:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay26-20020a05600c1e1a00b003a2e89d1fb5sm4851341wmb.42.2022.07.12.06.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:07:23 -0700 (PDT)
Message-Id: <c0022d075790da3d917381c4fa7128c972aa923d.1657631226.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jul 2022 13:07:03 +0000
Subject: [PATCH v4 10/12] rebase: add rebase.updateRefs config option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
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
index e7611b4089c..1249f9ed617 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -615,6 +615,9 @@ start would be overridden by the presence of
 	are being rebased. Any branches that are checked out in a worktree
 	or point to a `squash! ...` or `fixup! ...` commit are not updated
 	in this way.
++
+If the configuration variable `rebase.updateRefs` is set, then this option
+can be used to override and disable this setting.
 
 INCOMPATIBLE OPTIONS
 --------------------
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 56d82a52106..8ebc98ea505 100644
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
index 7bfbd405ab8..4b7b77a4123 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1768,6 +1768,12 @@ test_expect_success '--update-refs adds label and update-ref commands' '
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
@@ -1809,6 +1815,14 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
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

