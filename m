Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752B3C433F5
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 06:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242255AbiCSGU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Mar 2022 02:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242226AbiCSGUw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Mar 2022 02:20:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B5E972A9
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 23:19:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id e13so8725478plh.3
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 23:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+tkS3K/smcilCZUyYeDGdgmqmSXF/kDuOiacbcWSw0=;
        b=XZ372FulBhchREHfFrKj6q7oxqUENfYLLDar/eIpNUvcLdPwJI5R9kV5+rWXE8eKqX
         P15u4MElf8uYhchSkyH6H2ua6FZKwXVdZ8Z4Q70BdQ/nSwFfW7skD0tLC8TDtwWSAMNo
         wCwIAMcPQVkqtdE8n7z8+/pEAtUY6EKxlRwVlI8VWTIxlSeU/kv83prarBjg55+fMZbk
         Z9YVCo1JYEH8g/GIhCW6gpvnOs7d5aIVtvDwwb5HrV/UzfibsmwPTjF28kBj5EfyeXSW
         /NiArojQiXgnQCTL/XQOdJWNrYGFi65d0JnxMWP5Zwy++tqD4shkmUr7iTEqtSez1kRI
         a/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+tkS3K/smcilCZUyYeDGdgmqmSXF/kDuOiacbcWSw0=;
        b=Cm0rueP8QbfAhAtYAHu2HJ+EHaxURZF5gY2zqJdVo14vtSBXhovQjjTmF2koXayPED
         MxDb6OL1l66utsTCuObSYPSgjgvv+n/wXlA3v+g/zKB/Y7RjpPlXPDrqFpRGVe547pDh
         fYLpHLtVkpqZNQbaWSm6K4XFSN1APli2hA5/qDd2usSwq+7zbsU293gAuKki1j2KiXQd
         oF85IJVQUbHEbPntUhgs9OJGZy691D8t0m/JMpjnfPEXryXHu9MhYDVnUwkqp9Fp8uC/
         FWNPWqtbhIg0pCFRdftKydF0Bx8UqYgSQLVZeekQ8rLlGpvq7wMCPoIuhGpO1hsBs14M
         9NYQ==
X-Gm-Message-State: AOAM532SDaKh+/6uq3pcpx7FKFeOooemrFM4Ar/f/9U9q+z/JWQkEuRD
        bLUans0iqQKYkmm3lDUW1g4=
X-Google-Smtp-Source: ABdhPJzFfKOcU3hgtcz6YGVQVyWuG4mTkFaZCgZfbrSXg+lDMf9a+lGXt/aFPqwrp9uoOc0CZgwPNg==
X-Received: by 2002:a17:90b:2496:b0:1b9:a6dd:ae7 with SMTP id nt22-20020a17090b249600b001b9a6dd0ae7mr25529569pjb.35.1647670772112;
        Fri, 18 Mar 2022 23:19:32 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.152.89])
        by smtp.gmail.com with ESMTPSA id b2-20020a639302000000b003808dc4e133sm9235950pge.81.2022.03.18.23.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 23:19:31 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     gitster@pobox.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v5 3/4] Documentation/git-sparse-checkout.txt: some reword and modifications
Date:   Sat, 19 Mar 2022 14:19:09 +0800
Message-Id: <20220319061910.786850-4-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220319061910.786850-1-shaoxuan.yuan02@gmail.com>
References: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
 <20220319061910.786850-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some changes according to Derrick [1]

* added a paragraph that breifly touches on the input of 'set' command
* refer to the 'set' command when talking about 'add' command
* condense the '--[no-]cone' section
* remove 'For `reapply` command' section under '--[no-]cone' section

[1] https://lore.kernel.org/git/307ac60d-b0a1-ea90-8118-a4e02b809102@github.com/

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

