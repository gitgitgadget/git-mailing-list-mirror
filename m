Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98324C433EF
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 06:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbiCSGUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Mar 2022 02:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242220AbiCSGUw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Mar 2022 02:20:52 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD5997299
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 23:19:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso12112413pjb.0
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 23:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gcg7esqTL8wuikvmNXGao5leDMsOjuIwZrmfcHapdrw=;
        b=UOrnLpPsQ0hlV6XHa6jb+2MN6HsbhvDBgH5i8i+d9ExNtTer9OaToaGsCUH+YMRIWW
         M3htcMsZmVCMLKSoaKYXuhYxq/A7+SM4yxlW8feJVqaSVeWXzyyvaaz06T33WRoTszZG
         tQtiWhF/ZKJY96BmA/j+ErPH7y8yxbGbGRA0dh5CSVKwpFlk2t8ZUSRgY/gWPFDPxzYG
         SeggWZebJsSj6QpoTcosXoNuASBVfaJN+K/WYI6wqxrQKn1B8NfEA250qeFRgw4DXmm7
         iYae1K87PLdDFyoG7shDcnFMj28BU2EZ/98ccr94iyqVAabv6fcOG46o16xWHSG2EH6c
         tzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gcg7esqTL8wuikvmNXGao5leDMsOjuIwZrmfcHapdrw=;
        b=EoLN6JU7KSGAJtr8JUzERa8EW1DUPgpM94s3U9DxtFjeRFVap3k+sj3p0U+2isgiAi
         7VNcLrM+e5d9NOJMi0pu+24BiAS1P1mykwTrupG999MRKkf25cwifYBu1GLQFckaql76
         wYwWESumQDM3S6IF/7UEAR02aO06lyxiDpkzj/JB+JJKuDEoFw5S1BEaVuLIRwW1zTvu
         MESXNGpXSANm8UE+XLAzbnmBeObRr1VInmWNNeDgn/HuLtF63RcK+bEhSDQv8PbxxnSa
         WUdL7N1HJ8uzb2nwzJaAasP0MGmT8/R7QjPrVp/ZTHzzW4mSRT6fFs0AOS11zxa1nSZJ
         kn8g==
X-Gm-Message-State: AOAM5323MTWEMFXexh0RgwIF5OO/lswwf9yhxzv3DPNfRA8IRjDZgFCU
        Z6deA1NEyYht603so9rgLXs=
X-Google-Smtp-Source: ABdhPJw+Vn1RU1ef9/qFCJWBjnwOGfIlLSiD5mFPXzDze3auxrbRssSGpPUimedL1qe4kdfE2QycrQ==
X-Received: by 2002:a17:90a:4306:b0:1b9:80b3:7a3d with SMTP id q6-20020a17090a430600b001b980b37a3dmr25509013pjg.66.1647670769560;
        Fri, 18 Mar 2022 23:19:29 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.152.89])
        by smtp.gmail.com with ESMTPSA id b2-20020a639302000000b003808dc4e133sm9235950pge.81.2022.03.18.23.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 23:19:29 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     gitster@pobox.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v5 2/4] Documentation/git-sparse-checkout.txt: move OPTIONS after COMMANDS
Date:   Sat, 19 Mar 2022 14:19:08 +0800
Message-Id: <20220319061910.786850-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220319061910.786850-1-shaoxuan.yuan02@gmail.com>
References: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
 <20220319061910.786850-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* move OPTIONS after COMMANDS
* add two sub-sections under option '--[no-]cone', one for command 'set' and
one for command 'reapply'
* change the command indicators from this style:

	Use with ['set'|'reapply'].

to this style:

	Use with the `set` and `reapply` commands.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 121 ++++++++++++++------------
 1 file changed, 63 insertions(+), 58 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 5db5c0ab47..b8f3b89b74 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -35,59 +35,6 @@ COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN
 THE FUTURE.
 
 
-OPTIONS
--------
-'--[no-]cone'::
-	Use with ['set'|'reapply'].
-	Specify using cone mode or not. The default is to use cone mode.
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
-
-'--[no-]sparse-index'::
-	Use with ['set'|'reapply'].
-	Specify using a sparse index or not. The default is to not use a
-	sparse index.
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
-
-'--stdin'::
-	Use with ['set'|'add'].
-+
-When the `--stdin` option is provided, the directories or patterns are
-read from standard in as a newline-delimited list instead of from the
-arguments.
-
-
 COMMANDS
 --------
 'list'::
@@ -124,11 +71,6 @@ file. See linkgit:git-worktree[1] and the documentation of
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
@@ -154,6 +96,69 @@ paths to pass to a subsequent 'set' or 'add' command.  However,
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

