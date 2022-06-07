Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6C2C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 02:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiFHCzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 22:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443699AbiFHCxM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 22:53:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF0C1F0A51
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:43:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id s1so2591741wra.9
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tj3V7DMRyQxu6EMFQcaweQWyPvHiWErKetBh7ujjEU8=;
        b=WYiWchu7h7mbjtNUBx8+6DxK+VUDJ5hLyS158ca0UARvpqAmL2WBphOGl5vnOqaGKB
         ac50+D2IGSJQcwgHxKLP3SPRy55skfLJZ872SK5XrusiY7A9hKV92GT0YMWoYRoAjVly
         JsIXRF4c659dlJd0NKJ3sIl8JHLiQIT9HszA0Ycmdkvez2eHASNYzOOn2IJaoy9PUxli
         7ZyBGv88RCEcOS2Bbbok6GmcVHoHBFv5n3zDC7OKUYsKDGiutX5egTQjsz6Q8KtwF04t
         ydCNcfbuntzxEw3hLRIYtqb0vnVTy/O6jzqEDd37JO7/7ku/le58yw7aenyLXxYOjjuW
         zQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tj3V7DMRyQxu6EMFQcaweQWyPvHiWErKetBh7ujjEU8=;
        b=pfaubSrP6PIi6mWXCPwd3i9DdN49O403AR+6QDajWBgAx4ZsuU1WQkjQ4xedhVnat1
         tcmZPSdNidxcNzNvlWfA6VRI1A1c+kEQ7MjtkVnt3ezNA1rytp9VQJSqXxmdlldD2Ydg
         LYd06GE5Mn0zLXxxmJRFRgRrIr5d0Y6GUfbH/VxhMWIgTgD55A1fFiNgowduGs6m12Pd
         aGp3s+HO5LcmpLAhZwZVhcFECnSFAM049FRPZsiRsik5JikesXRgoKDemKuIfcgBlWEx
         GQgjV9H/gpIMM4kg5NO8urPAPwynONlSqQmvqzF+nT7Rje/jkXxMOt9CFN6dyfJi+FKb
         gR5Q==
X-Gm-Message-State: AOAM532bwn/KbepwMt9EWh/5QaTplKY8SJDHGT8SGsAQvX/xyQdnOtFO
        uGbI4+zagVkTD2Pc5ef7b7Yn7mTavPoUf5WQ
X-Google-Smtp-Source: ABdhPJzJ6xy0aRCaPbK+xxMM1o3KVGEiCUY1g6rxQ54GNVuTc1SLmyEL7QXfi0NqRxrHassWv0T2Hg==
X-Received: by 2002:adf:ed41:0:b0:210:20a5:26c2 with SMTP id u1-20020adfed41000000b0021020a526c2mr29144499wro.603.1654634579262;
        Tue, 07 Jun 2022 13:42:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3-20020a7bcd83000000b0039747cf8354sm20823704wmj.39.2022.06.07.13.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:42:58 -0700 (PDT)
Message-Id: <3d7d3f656b4e93e8caa0d18d29c318ede956d1d7.1654634569.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
        <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 20:42:49 +0000
Subject: [PATCH v2 7/7] rebase: add rebase.updateRefs config option
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
 Documentation/git-rebase.txt    |  4 ++++
 builtin/rebase.c                |  5 +++++
 t/t3404-rebase-interactive.sh   | 14 ++++++++++++++
 4 files changed, 26 insertions(+)

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
index e7611b4089c..7a56dbb9bec 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -615,6 +615,10 @@ start would be overridden by the presence of
 	are being rebased. Any branches that are checked out in a worktree
 	or point to a `squash! ...` or `fixup! ...` commit are not updated
 	in this way.
++
+If the `--update-refs` option is enabled by default using the
+configuration variable `rebase.updateRefs`, this option can be
+used to override and disable this setting.
 
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
index 72711efec28..f580afd8723 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1769,6 +1769,12 @@ test_expect_success '--update-refs adds label and update-ref commands' '
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
@@ -1811,6 +1817,14 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
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
