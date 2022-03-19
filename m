Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAD0C433F5
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 06:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242190AbiCSGUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Mar 2022 02:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiCSGUs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Mar 2022 02:20:48 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2307697290
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 23:19:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id u17so11254285pfk.11
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 23:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DxSXk5STCiKpYdqfI7Rzk35WBxeGplQYeTa7X1Lfpk4=;
        b=FwJ5/D262ZosXkrZYExdgtudMRDQ3pAR3sAInSnF36VdzCR4TUTz7hV6ivwfbS6YTZ
         1T0oeHNE+PJ1B757cWblL5MWX2JwimP/mjXykqm3O0JaqFsF1KcGvXkPQ+5WHmoM/Hfi
         lymK4TwyGtFmqtTW/W4bkid8nwYQ8eSzSQt/HTZX6oEv9T5ywNt4Fm1CPJQ771obbhL8
         Q8X2ZBY6AcV9+rwVLrl0CszCZkIqiQqaD7Njyc3kDmmFfvBZRYkAN19z0rzAkH1ttLBW
         6hapVeTEEo6NAoKPtPlHuefjqhSuovL3SYIJsRbmXJx3TqYVsw46n3QCfslV0tX83MGn
         qwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DxSXk5STCiKpYdqfI7Rzk35WBxeGplQYeTa7X1Lfpk4=;
        b=MXH+ghwlpHR8Nnz1CW3OyGYMcMinmMN9D792BPkJpfkX6FxQ/bz2FfEaFHnOshgyDY
         BTbL7M8GUKivHpuEpne8w2CHSOuBM9aEc0pcRBEx6h652oUZOjQBkPO3PT+AqmCfcPGi
         mDbymar+7Yqrk+XGWnZRevbTk2I0F5nbkPt+jGnD4j35t6QLuGy4EMvAtGd/lE4+TG2x
         hSaPk9jHiqUrjvcsDB2yFntFtpA3umLXx/vs7sm5ZU6f/QhvkMlJYZn9Tw13xjQY3rV1
         vVbw/pAZJubH2guC0ReiFCDzspmxgcg55NwfUY+0FDy3Ib5peXRLiP7IX0vpcm54O+2p
         gX7A==
X-Gm-Message-State: AOAM533yZPDNNz6PvLpgyLpi1IX8iSaKZPiL3iAhx4SfVhMOhhF/wS4b
        J1TJRTAsdHM2Lhh3g1+fPrA66Y6U3nc=
X-Google-Smtp-Source: ABdhPJx75z+cRm7Q6ltZwVsK02tzHzbix2TULAgPitXU0qKvw0HsbUGzYt/iY8Db2dC3MIKvISZg2w==
X-Received: by 2002:a63:5145:0:b0:381:4051:1f5a with SMTP id r5-20020a635145000000b0038140511f5amr10713997pgl.300.1647670767604;
        Fri, 18 Mar 2022 23:19:27 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.152.89])
        by smtp.gmail.com with ESMTPSA id b2-20020a639302000000b003808dc4e133sm9235950pge.81.2022.03.18.23.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 23:19:27 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     gitster@pobox.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v5 1/4] Documentation/git-sparse-checkout.txt: add an OPTIONS section
Date:   Sat, 19 Mar 2022 14:19:07 +0800
Message-Id: <20220319061910.786850-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220319061910.786850-1-shaoxuan.yuan02@gmail.com>
References: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
 <20220319061910.786850-1-shaoxuan.yuan02@gmail.com>
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
index e4a29a2baa..5db5c0ab47 100644
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

