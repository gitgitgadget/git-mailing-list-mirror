Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C9CC433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 12:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiCQMip (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 08:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiCQMio (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 08:38:44 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218DF1EB80F
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 05:37:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id rm8-20020a17090b3ec800b001c55791fdb1so5393175pjb.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 05:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQkuQ0GfjOuRUuj0oi0Z9slNus7Hq/Zm5dShjmfasHg=;
        b=luHnvOEZzJSomMAsfpRKKUioAeZXFs65wcY4BwE2Bu56wsGFmttlo5z4mAARruB8zJ
         8qWid0EBZuAgBnTIjzaZPh+5w9MZ032tcUGiR0tdRvNZ9mf6KRR82a3K9dZtjTv6px+7
         8wP6tlix/2qAi6OklhKykBCAcdx90WUsnEjY0DA9ffScGSmX/PQl78MzZySLehJ5q8c+
         j/2SPMqALDFUxpgBIa4rpnTag/nCMv2dmCsHx23Y2a2XJXO33My+vACEp1PFAxc7d+UJ
         Qq5/fffTgz9+DyZ3KBlDOMPalS3gSinu/6KyRzI7B4nfCEP6fbmuATeR5+CsUOXHRdT8
         u9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQkuQ0GfjOuRUuj0oi0Z9slNus7Hq/Zm5dShjmfasHg=;
        b=ALTF5ikxH84gd8+PPAhU6EB+UmiNpnmojTkBlmVfnOlxXt/sSW5fbhONi6ujCJyv3N
         74CFVH/1JzM73J8YUOcT0gW91A+mhQgOlEdTKIbkI43GGtR9yYJJv87mW5EvR/W9DXfl
         8St/svOucjNmC5rBjw4KidtATKGrFfo6fP77QqpBgtR+hnzwRaEuJp/im/bNojZ79pFr
         n2FCZUVKUF4FRlCMefM4bpg9iV6b3mxBR4T+/vhIsyIURTV/0PskaCOXu4UXLbhVbf0I
         vhL4hXDd1Df7l3SCWjpt1l3JM0yUhd66okxSciVG4g0BezWOIg2wctt1TpBzMIlHJS86
         Ap7A==
X-Gm-Message-State: AOAM531jsUMnz5sqPA16ZXIk/Hvxn9K+D9z10foeajQ6b6B1KSpJTflb
        S5rDUGXnp7on6Q/QNy9VOtkxt3kPM/M=
X-Google-Smtp-Source: ABdhPJyshO3PG04lzS6nhNq7n58OxAvZzQOao5FL6UhPtAmUSg5ynMjkzcob2AsM74Whz3Oh4WL1AQ==
X-Received: by 2002:a17:902:f612:b0:14c:e978:f99e with SMTP id n18-20020a170902f61200b0014ce978f99emr4822558plg.23.1647520647610;
        Thu, 17 Mar 2022 05:37:27 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.153.254])
        by smtp.gmail.com with ESMTPSA id m7-20020a056a00080700b004f6ff260c9dsm7249020pfk.154.2022.03.17.05.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:37:27 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     derrickstolee@github.com
Cc:     vdye@github.com, git@vger.kernel.org, newren@gmail.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v4 1/1] Documentation/git-sparse-checkout.txt: add an OPTIONS section
Date:   Thu, 17 Mar 2022 20:37:18 +0800
Message-Id: <20220317123718.480093-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317123718.480093-1-shaoxuan.yuan02@gmail.com>
References: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
 <20220317123718.480093-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an OPTIONS section to the manual and move the descriptions about
these options from COMMANDS to the section.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 44 +++++++++------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index b8f3b89b74..0178d63f56 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -48,6 +48,14 @@ COMMANDS
 	following the 'set' subcommand, and update the working directory to
 	match.
 +
+By default, the arguments to the `set` command are interpreted as a
+list of directories. The sparse-checkout patterns are set to match
+all files within those directories, recursively, as well as any file
+directly contained in a parent of those directories. See INTERNALS
+-- CONE PATTERN SET below for full details. If --no-cone is specified,
+then the arguments are interpreted as sparse-checkout patterns. See
+INTERNALS -- FULL PATTERN SET below for more information.
++
 To ensure that adjusting the sparse-checkout settings within a worktree
 does not alter the sparse-checkout settings in other worktrees, the 'set'
 subcommand will upgrade your repository config to use worktree-specific
@@ -59,8 +67,10 @@ file. See linkgit:git-worktree[1] and the documentation of
 'add'::
 	Update the sparse-checkout file to include additional directories
 	(in cone mode) or patterns (in non-cone mode).  By default, these
-	directories or patterns are read from the command-line arguments,
-	but they can be read from stdin using the `--stdin` option.
+	directories or patterns are read from the command-line arguments.
+  These directories or patterns are interpreted the same way as stated
+  above in `set` command, and they can be read from stdin using the
+  `--stdin` option.
 
 'reapply'::
 	Reapply the sparsity pattern rules to paths in the working tree.
@@ -103,33 +113,9 @@ OPTIONS
 	Use with the `set` and `reapply` commands.
 	Specify using cone mode or not. The default is to use cone mode.
 +
-For `set` command:
-+
-By default, the input list is considered a list of directories, matching
-the output of `git ls-tree -d --name-only`.  This includes interpreting
-pathnames that begin with a double quote (") as C-style quoted strings.
-Note that all files under the specified directories (at any depth) will
-be included in the sparse checkout, as well as files that are siblings
-of either the given directory or any of its ancestors (see 'CONE PATTERN
-SET' below for more details).  In the past, this was not the default,
-and `--cone` needed to be specified or `core.sparseCheckoutCone` needed
-to be enabled.
-+
-When `--no-cone` is passed, the input list is considered a list of
-patterns.  This mode is harder to use, and unless you can keep the
-number of patterns small, its design also scales poorly.  It used to be
-the default mode, but we do not recommend using it.  It does not work
-with the `--sparse-index` option, and will likely be incompatible with
-other new features as they are added.  See the "Non-cone Problems"
-section below and the "Sparse Checkout" section of
-linkgit:git-read-tree[1] for more details.
-+
-For `reapply` command:
-+
-The `reapply` command can also take `--[no-]cone` and `--[no-]sparse-index`
-flags, with the same meaning as the flags from the `set` command, in order
-to change which sparsity mode you are using without needing to also respecify
-all sparsity paths.
+For the `set` command, the option to use cone mode or not changes
+the interpretation of the remaining arguments to either be a list
+of directories or a list of patterns.
 
 '--[no-]sparse-index'::
 	Use with the `set` and `reapply` commands.
-- 
2.35.1

