Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848DDC433FE
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 13:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348882AbiCKNX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 08:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242502AbiCKNX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 08:23:29 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6092F1C2F7E
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 05:22:25 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id mv5-20020a17090b198500b001bf2a039831so11045085pjb.5
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 05:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=APXlmUv8SM2+zU/RaESHmWB1snfAbTpDSULPZoX63xI=;
        b=QCrJWMqrWIw+sFaCWDk0k36gt/t4J3prWivuUlW6zABHUOsrcUuYy+k7XlOYXWmRGG
         WtyLzw19apXHAEA718BIxVwoYD3Gq7og7fxADN4nzG0ffLoaH03hqnV75Bob8gJSK3qm
         w5vyd0YQNs9DKYy9JXCkrU71uc4Ks8d0EDg2K0kvYPaJb4AEAGsPW3wSgpIchJwg8k9Y
         RfMU7l8wNeaRJLhFRzcBT9FqHS2+CqA2/0/rXcNnJU/xyV/a5z15lNI9C/AdKDgRMaQH
         5S62IiWMVMxYkOy07VQYe/V3ApJLgCLfDeM+vKFRDy17V3ROKd8Qu0p455u06MAHNhOM
         iTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=APXlmUv8SM2+zU/RaESHmWB1snfAbTpDSULPZoX63xI=;
        b=l8tr/f7ATd8lO+f3XpXFcrb3+vo3VpDP8bzAYzv2mTtSEyEAXWAW4awP98xdLQ7bua
         P68pcQWBQX5EOPfjDC61L1yjl8vdclfIJu0Yil7067E6Hk4tYhOdIQsxxx8Om8nJjfm5
         7ePrVjQeS0cfpWHatV/+WJvxkZ51HV28xphvjwGQ/IjjQpZePYYGb5UQOmKGvzAnkSt5
         iJD33x1LEI+0IdpSLC/+R0VjyaZBgAW5QtIlIN2d7nxUqBSDThAt99lDYcrS06by2sg3
         3qqbx7zBIz4Qb7r/UTf/YNZw2wwJRFJihilwHo4JnR9GReYP/uqoJLRDIa4u/2dJnByA
         6Ezg==
X-Gm-Message-State: AOAM5329hEPUYyaX4Vymut8814LeTtuNKN4+MdSttlMsPVBX4RI2PGhg
        YlkLMBIFEPEYFVe8bARhOrJDngzYaPU=
X-Google-Smtp-Source: ABdhPJzonL8a6krJ+L+MYB0wUQaTG3eMrrWGlSa4275esa6s/9hWqHdWwjv/5bV0RgAtbMXqr0u3Hw==
X-Received: by 2002:a17:903:2286:b0:153:3f61:a245 with SMTP id b6-20020a170903228600b001533f61a245mr1191782plh.95.1647004944587;
        Fri, 11 Mar 2022 05:22:24 -0800 (PST)
Received: from ffyuanda.localdomain ([119.131.143.198])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b004c55d0dcbd1sm10496882pfu.120.2022.03.11.05.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 05:22:24 -0800 (PST)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, newren@gmail.com,
        bagasdotme@gmail.com, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [RFC PATCH 1/1] Documentation/git-sparse-checkout.txt: add an OPTIONS section
Date:   Fri, 11 Mar 2022 21:21:41 +0800
Message-Id: <20220311132141.1817-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
References: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an OPTIONS section to the manual and move the descriptions about
these options from COMMANDS to the section.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 63 +++++++++++++++++----------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 06f23660f6..0bc742cb3a 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -35,30 +35,11 @@ COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN
 THE FUTURE.
 
 
-COMMANDS
---------
-'list'::
-	Describe the directories or patterns in the sparse-checkout file.
-
-'set'::
-	Enable the necessary sparse-checkout config settings
-	(`core.sparseCheckout`, `core.sparseCheckoutCone`, and
-	`index.sparse`) if they are not already set to the desired values,
-	populate the sparse-checkout file from the list of arguments
-	following the 'set' subcommand, and update the working directory to
-	match.
-+
-To ensure that adjusting the sparse-checkout settings within a worktree
-does not alter the sparse-checkout settings in other worktrees, the 'set'
-subcommand will upgrade your repository config to use worktree-specific
-config if not already present. The sparsity defined by the arguments to
-the 'set' subcommand are stored in the worktree-specific sparse-checkout
-file. See linkgit:git-worktree[1] and the documentation of
-`extensions.worktreeConfig` in linkgit:git-config[1] for more details.
-+
-When the `--stdin` option is provided, the directories or patterns are
-read from standard in as a newline-delimited list instead of from the
-arguments.
+OPTIONS
+-------
+'--[no-]cone'::
+	Use with ['set'|'reapply'].
+	Specify using cone mode or not. The default is to use cone mode.
 +
 By default, the input list is considered a list of directories, matching
 the output of `git ls-tree -d --name-only`.  This includes interpreting
@@ -78,6 +59,11 @@ with the `--sparse-index` option, and will likely be incompatible with
 other new features as they are added.  See the "Non-cone Problems"
 section below and the "Sparse Checkout" section of
 linkgit:git-read-tree[1] for more details.
+
+'--[no-]sparse-index'::
+	Use with ['set'|'reapply'].
+	Specify using a sparse index or not. The default is to not use a 
+	sparse index.
 +
 Use the `--[no-]sparse-index` option to use a sparse index (the
 default is to not use it).  A sparse index reduces the size of the
@@ -94,6 +80,35 @@ to rewrite your index to not be sparse. Older versions of Git will not
 understand the sparse directory entries index extension and may fail to
 interact with your repository until it is disabled.
 
+'--stdin'::
+	Use with ['set'|'add'].
++
+When the `--stdin` option is provided, the directories or patterns are
+read from standard in as a newline-delimited list instead of from the
+arguments.
+
+
+COMMANDS
+--------
+'list'::
+	Describe the directories or patterns in the sparse-checkout file.
+
+'set'::
+	Enable the necessary sparse-checkout config settings
+	(`core.sparseCheckout`, `core.sparseCheckoutCone`, and
+	`index.sparse`) if they are not already set to the desired values,
+	populate the sparse-checkout file from the list of arguments
+	following the 'set' subcommand, and update the working directory to
+	match.
++
+To ensure that adjusting the sparse-checkout settings within a worktree
+does not alter the sparse-checkout settings in other worktrees, the 'set'
+subcommand will upgrade your repository config to use worktree-specific
+config if not already present. The sparsity defined by the arguments to
+the 'set' subcommand are stored in the worktree-specific sparse-checkout
+file. See linkgit:git-worktree[1] and the documentation of
+`extensions.worktreeConfig` in linkgit:git-config[1] for more details.
+
 'add'::
 	Update the sparse-checkout file to include additional directories
 	(in cone mode) or patterns (in non-cone mode).  By default, these
-- 
2.35.1

