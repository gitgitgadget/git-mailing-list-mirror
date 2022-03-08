Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD41AC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 07:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344660AbiCHHk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 02:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344642AbiCHHkv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 02:40:51 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5434D3DDEC
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 23:39:55 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so868647wmj.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 23:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iNfUFTserT6zohLzadoxjW83Qh8oDm1GULCxdd09RBA=;
        b=AePT9AJ0teTj8XyPPTBMmqO/gMFtbNUIX//gEKgc7gzPRjkH0kiMh+alQ9Uaq9fvDl
         eo6ctsQ5zSq1l4gAYEnnMxhSC4BuFpokeS1v0u8I5Oyh3mupl2S1WJ+JKv/j7GhswWXU
         QoofJPOwdQ2XWAtaffLCjP1yvvJ4H8i3zsxF0gwWL2GhGqKyeyIMODs/G0IRVSaMT8BQ
         CDGQOaDq2xb2baJqXz3Nipy7z60ChdSWQHTOfZa2XtEYOrHstvrpQHNJZkp7Ys6wDijL
         x9dJnfnQauHYdwSWo88/pM06pKB4o1hgr1xtCoGmHHp6RNXZWufPPl6l6Hz0HHjKXtO8
         /Q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iNfUFTserT6zohLzadoxjW83Qh8oDm1GULCxdd09RBA=;
        b=JIsNMUnpjrpu5sQpKUwwi/HWVLY1ba3jUG0J9DEklocuHtACXeYU/NjgAJe4ael+5M
         DljOU24XLvp5JGGXiKT3vhNWcZh5VG6NCOeqbvirAOTXEqOVuD0zsK0zpXMsgTA8dWfq
         YusMzj7frQErFY5WvcTUoSPACVnRwWB+WNxFUHE46HxXs9P3UGrzqIBrmwRwypLjPzn1
         fHkX+7/WQI51ZWGrYEwEWuLYfcQ+Ne57cX5iOcw9GSu72BxXaphSvw/jEKbQBVRDsn4j
         5eByhhr4Zwd1ZkiHotr9PKrCm1LXhK2XJ88JfCPOd4hOhfNlfxfXSJT9hkf4PDtEv3PP
         fCyQ==
X-Gm-Message-State: AOAM530MahV+g/iihLVLTXTtF6cV+l7jix+Sir469e/w0qqh5iY5ERjW
        27PRHE4DxYgIG6GtqyzbO06/dfsoj9U=
X-Google-Smtp-Source: ABdhPJzYHyRJ5HDHFUxzrKT4psWAcS+u4GCDerad7ERs4EJzYZas1hBggSyZM5agWOH5WG0J1ydLew==
X-Received: by 2002:a05:600c:3544:b0:389:bcb8:cc6e with SMTP id i4-20020a05600c354400b00389bcb8cc6emr2345796wmq.194.1646725193747;
        Mon, 07 Mar 2022 23:39:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b0037fa5c422c8sm1449729wmb.48.2022.03.07.23.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 23:39:53 -0800 (PST)
Message-Id: <cd871966c064a8fada67e4c33c5f7e0c2542efc1.1646725188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 07:39:43 +0000
Subject: [PATCH 4/9] git-sparse-checkout.txt: update docs for deprecation of
 'init'
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

The 'init' subcommand of sparse-checkout was deprecated in ba2f3f58ac
("git-sparse-checkout.txt: update to document init/set/reapply changes",
2021-12-14), but a couple places in the manual still assumed it was the
primary way to use sparse-checkout.  Correct them.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 42a984306bb..b9e44e3dd4c 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -70,11 +70,11 @@ SET' below for more details).  In the past, this was not the default,
 and `--cone` needed to be specified or `core.sparseCheckoutCone` needed
 to be enabled.
 +
-When `--no-cone` is passed or `core.sparseCheckoutCone` is false,
-the input list is considered a list of patterns.  This mode is harder
-to use and less performant, and is thus not recommended.  See the
-"Sparse Checkout" section of linkgit:git-read-tree[1] and the "Pattern
-Set" sections below for more details.
+When `--no-cone` is passed, the input list is considered a list of
+patterns.  This mode is harder to use and less performant, and is thus
+not recommended.  See the "Sparse Checkout" section of
+linkgit:git-read-tree[1] and the "Pattern Set" sections below for more
+details.
 +
 Use the `--[no-]sparse-index` option to use a sparse index (the
 default is to not use it).  A sparse index reduces the size of the
@@ -196,9 +196,9 @@ In addition to the above two patterns, we also expect that all files in the
 root directory are included. If a recursive pattern is added, then all
 leading directories are added as parent patterns.
 
-By default, when running `git sparse-checkout init`, the root directory is
-added as a parent pattern. At this point, the sparse-checkout file contains
-the following patterns:
+By default, when running `git sparse-checkout set` with no directories
+specified, the root directory is added as a parent pattern. At this
+point, the sparse-checkout file contains the following patterns:
 
 ----------------
 /*
-- 
gitgitgadget

