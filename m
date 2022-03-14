Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C83C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 06:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbiCNGfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 02:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbiCNGfw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 02:35:52 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64C41EACA
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 23:34:42 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id p8so13411791pfh.8
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 23:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jTnmZA5q3TeKqejMd3MAxabqpknBpgslmnv7AIY5iaM=;
        b=dIKpTQqaely4AcKBm5DPqt0kn7nscQMfhHgFqb+GVJoLhjyJAKrnDgCWRXrmjPN3iH
         qX+Jjah2Peru3zuVcdx1arQZfjI/i8Ac2G0+F8aoRE+8dS3e5S0um/HxH2BX8GWw/zhu
         GVq0yPTRzvHne/HZHNtiPsgYhWmkvlgLhnQ+Xr7oWE534hR+19OVoc7a93BY0THpSk5F
         tex7SrokJ+1I2fZecdb2hyojcVOe0/VF8QonlHu5WC2GmGWkFFadEDBBTJiMnO2mhwk6
         FHQGsODOBGKhPWC2FG8qQEuA4dV/utB31RF6aLB+XHXK24/9ny+3ot9tDZAPjXosBaWk
         A5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jTnmZA5q3TeKqejMd3MAxabqpknBpgslmnv7AIY5iaM=;
        b=5N5H2E4bDQTTUaHCV3jYwxqLleFYZ3GM8GM2+DG9MEG/dS8YuRjNElSFjvzvHz+T5U
         qfnbLGuMJFFN67jWj5i7vlo7GpwJd/FNZ/2JnOp5UCtRWWoG6BRzH0CkIbktbxMHsiYK
         OYnuHHyKqebxEILY+aF6PqDZ5qyr/WDW7SONv4KKwpQdbneqko/in7knx2sP7MYL+9h8
         wjtLuyIjwMyzJljHX4ERi/1KwXZkVR+gcjIrxHOrLyC8g1Dju+uIidx83SaXIGIfhtpW
         hQofiL50KIPY4BkIT38Bd1gfNeLkloYMLKbt4BROQJ4iJuZOEh3JTBYQTPjoBUdH5cRH
         sDLQ==
X-Gm-Message-State: AOAM530/5hI8DshwttpzZLOVW+e17UlrPA91VVQb/ejdslWsds/u8M5i
        MSxUKjd5Vyt3Am/oCKhXpGk=
X-Google-Smtp-Source: ABdhPJx3BXLTTk0UoXvQ/9xtd/kYpR3MVOUpWyCbeIQbDvclBtlZYPf6stg90Werc0l/UBtZZxNYrg==
X-Received: by 2002:a05:6a00:1584:b0:4f7:4647:6fdd with SMTP id u4-20020a056a00158400b004f746476fddmr22532574pfk.84.1647239682359;
        Sun, 13 Mar 2022 23:34:42 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.153.242])
        by smtp.gmail.com with ESMTPSA id kb10-20020a17090ae7ca00b001bfad03c750sm16466566pjb.26.2022.03.13.23.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 23:34:42 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     derrickstolee@github.com
Cc:     bagasdotme@gmail.com, git@vger.kernel.org, newren@gmail.com,
        vdye@github.com, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 1/1] Documentation/git-sparse-checkout.txt: add an OPTIONS section
Date:   Mon, 14 Mar 2022 14:34:34 +0800
Message-Id: <20220314063434.81895-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314063434.81895-1-shaoxuan.yuan02@gmail.com>
References: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
 <20220314063434.81895-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an OPTIONS section to the manual and move the descriptions about
these options from COMMANDS to the section.

Helped-by: Derick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 106 +++++++++++++++-----------
 1 file changed, 63 insertions(+), 43 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index e4a29a2baa..b8f3b89b74 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -55,44 +55,6 @@ config if not already present. The sparsity defined by the arguments to
 the 'set' subcommand are stored in the worktree-specific sparse-checkout
 file. See linkgit:git-worktree[1] and the documentation of
 `extensions.worktreeConfig` in linkgit:git-config[1] for more details.
-+
-When the `--stdin` option is provided, the directories or patterns are
-read from standard in as a newline-delimited list instead of from the
-arguments.
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
-Use the `--[no-]sparse-index` option to use a sparse index (the
-default is to not use it).  A sparse index reduces the size of the
-index to be more closely aligned with your sparse-checkout
-definition. This can have significant performance advantages for
-commands such as `git status` or `git add`.  This feature is still
-experimental. Some commands might be slower with a sparse index until
-they are properly integrated with the feature.
-+
-**WARNING:** Using a sparse index requires modifying the index in a way
-that is not completely understood by external tools. If you have trouble
-with this compatibility, then run `git sparse-checkout init --no-sparse-index`
-to rewrite your index to not be sparse. Older versions of Git will not
-understand the sparse directory entries index extension and may fail to
-interact with your repository until it is disabled.
 
 'add'::
 	Update the sparse-checkout file to include additional directories
@@ -109,11 +71,6 @@ interact with your repository until it is disabled.
 	cases, it can make sense to run `git sparse-checkout reapply` later
 	after cleaning up affected paths (e.g. resolving conflicts, undoing
 	or committing changes, etc.).
-+
-The `reapply` command can also take `--[no-]cone` and `--[no-]sparse-index`
-flags, with the same meaning as the flags from the `set` command, in order
-to change which sparsity mode you are using without needing to also respecify
-all sparsity paths.
 
 'disable'::
 	Disable the `core.sparseCheckout` config setting, and restore the
@@ -139,6 +96,69 @@ paths to pass to a subsequent 'set' or 'add' command.  However,
 the disable command, so the easy restore of calling a plain `init`
 decreased in utility.
 
+
+OPTIONS
+-------
+'--[no-]cone'::
+	Use with the `set` and `reapply` commands.
+	Specify using cone mode or not. The default is to use cone mode.
++
+For `set` command:
++
+By default, the input list is considered a list of directories, matching
+the output of `git ls-tree -d --name-only`.  This includes interpreting
+pathnames that begin with a double quote (") as C-style quoted strings.
+Note that all files under the specified directories (at any depth) will
+be included in the sparse checkout, as well as files that are siblings
+of either the given directory or any of its ancestors (see 'CONE PATTERN
+SET' below for more details).  In the past, this was not the default,
+and `--cone` needed to be specified or `core.sparseCheckoutCone` needed
+to be enabled.
++
+When `--no-cone` is passed, the input list is considered a list of
+patterns.  This mode is harder to use, and unless you can keep the
+number of patterns small, its design also scales poorly.  It used to be
+the default mode, but we do not recommend using it.  It does not work
+with the `--sparse-index` option, and will likely be incompatible with
+other new features as they are added.  See the "Non-cone Problems"
+section below and the "Sparse Checkout" section of
+linkgit:git-read-tree[1] for more details.
++
+For `reapply` command:
++
+The `reapply` command can also take `--[no-]cone` and `--[no-]sparse-index`
+flags, with the same meaning as the flags from the `set` command, in order
+to change which sparsity mode you are using without needing to also respecify
+all sparsity paths.
+
+'--[no-]sparse-index'::
+	Use with the `set` and `reapply` commands.
+	Specify using a sparse index or not. The default is to not use a
+	sparse index.
++
+Use the `--[no-]sparse-index` option to use a sparse index (the
+default is to not use it).  A sparse index reduces the size of the
+index to be more closely aligned with your sparse-checkout
+definition. This can have significant performance advantages for
+commands such as `git status` or `git add`.  This feature is still
+experimental. Some commands might be slower with a sparse index until
+they are properly integrated with the feature.
++
+**WARNING:** Using a sparse index requires modifying the index in a way
+that is not completely understood by external tools. If you have trouble
+with this compatibility, then run `git sparse-checkout init --no-sparse-index`
+to rewrite your index to not be sparse. Older versions of Git will not
+understand the sparse directory entries index extension and may fail to
+interact with your repository until it is disabled.
+
+'--stdin'::
+	Use with the `set` and `add` commands.
++
+When the `--stdin` option is provided, the directories or patterns are
+read from standard in as a newline-delimited list instead of from the
+arguments.
+
+
 EXAMPLES
 --------
 `git sparse-checkout set MY/DIR1 SUB/DIR2`::
-- 
2.35.1

