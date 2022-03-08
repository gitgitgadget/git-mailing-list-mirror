Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74126C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 07:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344644AbiCHHkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 02:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344639AbiCHHku (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 02:40:50 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A3C3DDE5
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 23:39:54 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h15so2642933wrc.6
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 23:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g26RlMPpyFcmK3jXAO/KptnUTUYMnuE3CrJpnlUgMb8=;
        b=d9m4dk6qdvhyFVcNm3rVHpjozO8TtH5cS2RloK1mr7kPhyWI1oY2NcKoHqgBJxL2g9
         cyf4gxdvOBwPOboQdIcBT87+wI3YjRVvxiXdHqiiNWkJmvgiVg++Lub+ffMjORKsaIfd
         usVjPcqo5Yq/EKYaETZiyZgLaWP+UdxaBzkMtgqCpDei485NHHssdRLFtSpdx6cjtBnj
         pDnmjlli8QWAZH/oOe4bxI+L6gSSk8mJGc8/gakMyuLyFleHotv415LUQJvoNS6Iqiyy
         zw3BIAhEMFvkFYtesFXcdg6TLdXneuAm6+pR9bxKn25ZiRgP+ZMjx/exy8cb8ArhooOc
         Jl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g26RlMPpyFcmK3jXAO/KptnUTUYMnuE3CrJpnlUgMb8=;
        b=HquhlyP8AzRVmgXf/G5/Pcevb+4PQvV9Xg0QssTfgqhQ8Ug1+nAsN2BoEz6pvlN0rB
         AnbqbffDQfxr3thL8sPyeAJ31jA1+sfCRuAAWHZKZ3shDLD8KQ8b35JaC7Et2kPWeUim
         8pKxpftK59LcDh0ovrZwWKioSjAtDadoTtE6JbOQot3Qsl1SK6fzljbjRpmaJmWAL0zb
         ne5Vy+TMCMImuq+Zhl+DO8ilTycVaC3o2rq8HuTxLuYmv6ghWJFZkinylVu1lcTuoNKF
         JGV/Ry0Uak2WQC0riuwdT6DdRJJkjsq5dCuzoRNybsTH0VunhC00Qr2AdlMn1KnbrlJ8
         u9/A==
X-Gm-Message-State: AOAM5324oq/3gY4veoKG50J932dXESfrdyJ8I5aDxcDjv71Ii24yREcF
        BF1IOOc9B6c87vwYhZsSTvlvIr/vUmM=
X-Google-Smtp-Source: ABdhPJwfg+BUkvAKjduCAb3G9vPupfBapLGFRZQ/dH0X6bFGpf84RjFsefcuuk2ZlrVcgu1crV2w2Q==
X-Received: by 2002:a5d:64a9:0:b0:1f1:f6ea:f90 with SMTP id m9-20020a5d64a9000000b001f1f6ea0f90mr7248631wrp.145.1646725192888;
        Mon, 07 Mar 2022 23:39:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y10-20020adfee0a000000b001f0639001ffsm19985644wrn.9.2022.03.07.23.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 23:39:52 -0800 (PST)
Message-Id: <f98b3fac78a707849951b317f50ee56754d0ff9d.1646725188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 07:39:42 +0000
Subject: [PATCH 3/9] git-sparse-checkout.txt: wording updates for the cone
 mode default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Now that cone mode is the default, we'd like to focus on the arguments
to set/add being directories rather than patterns, and it probably makes
sense to provide an earlier heads up that files from leading directories
get included as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 31 +++++++++++++--------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 4ef03120797..42a984306bb 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -44,9 +44,9 @@ COMMANDS
 	Enable the necessary sparse-checkout config settings
 	(`core.sparseCheckout`, `core.sparseCheckoutCone`, and
 	`index.sparse`) if they are not already set to the desired values,
-	and write a set of patterns to the sparse-checkout file from the
-	list of arguments following the 'set' subcommand. Update the
-	working directory to match the new patterns.
+	populate the sparse-checkout file from the list of arguments
+	following the 'set' subcommand, and update the working directory to
+	match.
 +
 To ensure that adjusting the sparse-checkout settings within a worktree
 does not alter the sparse-checkout settings in other worktrees, the 'set'
@@ -60,15 +60,15 @@ When the `--stdin` option is provided, the directories or patterns are
 read from standard in as a newline-delimited list instead of from the
 arguments.
 +
-When `--cone` is passed or `core.sparseCheckoutCone` is not false, the
-input list is considered a list of directories.  This allows for
-better performance with a limited set of patterns (see 'CONE PATTERN
-SET' below).  The input format matches the output of `git ls-tree
---name-only`.  This includes interpreting pathnames that begin with a
-double quote (") as C-style quoted strings.  Note that the set command
-will write patterns to the sparse-checkout file to include all files
-contained in those directories (recursively) as well as files that are
-siblings of ancestor directories.
+By default, the input list is considered a list of directories, matching
+the output of `git ls-tree -d --name-only`.  This includes interpreting
+pathnames that begin with a double quote (") as C-style quoted strings.
+Note that all files under the specified directories (at any depth) will
+be included in the sparse checkout, as well as files that are siblings
+of either the given directory or any of its ancestors (see 'CONE PATTERN
+SET' below for more details).  In the past, this was not the default,
+and `--cone` needed to be specified or `core.sparseCheckoutCone` needed
+to be enabled.
 +
 When `--no-cone` is passed or `core.sparseCheckoutCone` is false,
 the input list is considered a list of patterns.  This mode is harder
@@ -208,10 +208,9 @@ the following patterns:
 This says "include everything in root, but nothing two levels below root."
 
 When in cone mode, the `git sparse-checkout set` subcommand takes a list of
-directories instead of a list of sparse-checkout patterns. In this mode,
-the command `git sparse-checkout set A/B/C` sets the directory `A/B/C` as
-a recursive pattern, the directories `A` and `A/B` are added as parent
-patterns. The resulting sparse-checkout file is now
+directories. In this mode, the command `git sparse-checkout set A/B/C` sets
+the directory `A/B/C` as a recursive pattern, the directories `A` and `A/B`
+are added as parent patterns. The resulting sparse-checkout file is now
 
 ----------------
 /*
-- 
gitgitgadget

