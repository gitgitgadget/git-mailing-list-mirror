Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3291CC433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 07:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbiBBH3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237875AbiBBH3n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 02:29:43 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA9DC06173D
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 23:29:42 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d1so17428429plh.10
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 23:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhrvSI2jGaqZEMdRU+/MzKC3AxQ+Ry3jwcpek4ZQFxQ=;
        b=dk435Wdgws6sSU+HTHSVav5JFzo47I/OHg9NPHnLLK/TxkLygzU+vhpxctsZ0aek7B
         BpxvAIRRfYLZCAZ9au+2cUJdztXK+nKNItbR7vCnHxnGtNtf0mzA8mFkS7L/QO0bO6+G
         9kwZluxpSkuqF+1DHmn2+58JdzNKcMdZfKs07GMOc9GynQYNTUQlTOxl7tSqFxPf1sAm
         eHs4CqoRIOgmikasib4oV1GyMftUjSu5DstsXgk27fS8/A8FPNSEN9Jiqbhrg5lpW/34
         Je4xFR7hoYL+zXrPeVgSIchNc0pP5/6nmd8MFsvuO++wHbIiIj4Aae5KpZ3Lk0w3jrEG
         deFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhrvSI2jGaqZEMdRU+/MzKC3AxQ+Ry3jwcpek4ZQFxQ=;
        b=jpXImSVse6thXscdsKVaxWQewBefNFSUUyBMtOP9fYDixF0ImT09YLVPFMJP9iJIeH
         8MxdPSNIc/QaBQy/bj2Z8rWjqh9b4eV9sztY70NTkMmpwrO3ACieeGF17jJLdjjNZ0/k
         6umM9mcsFCjAGQ3kF7ot6nXnn4KbDoc+wLapH5thHSuwEWq2PcVXEO+E5s7eAPD7RzCs
         iPeI2P6V8aAgKLeVKZRpgT+X7bCrm1L09qVDSjio5WpEDPqZMT5euAbrHY3crYmBMfgC
         qK+GTluSWcwzXdTHD+yA3fkHoDAgaf4st6i8PYjBj4mk5TgZ947rLY1dJo4juu54w9a2
         g6Yw==
X-Gm-Message-State: AOAM532t9jwqr7jcQdEyDQLPgWYKmFvhQtp+bgstb7EhChvfJmceDMsI
        Cjnjpoi0FYp/DtD6tgb6uu4W1jRnB/jSTEUY
X-Google-Smtp-Source: ABdhPJwOpBTUJeDFVjAPvqdVQu/Kc2KxpSAGiuGgrUtGGQQlSVgFrjGeZbTi3DndAHR2HSvUB9PHqw==
X-Received: by 2002:a17:902:ba84:: with SMTP id k4mr28690757pls.142.1643786982103;
        Tue, 01 Feb 2022 23:29:42 -0800 (PST)
Received: from ffyuanda.localdomain ([101.206.226.106])
        by smtp.gmail.com with ESMTPSA id j6sm9418352pfu.18.2022.02.01.23.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:29:41 -0800 (PST)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com, me@ttaylorr.com,
        adlternative@gmail.com, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH] builtin/diff.c: fix "git-diff" usage string typo
Date:   Wed,  2 Feb 2022 15:28:44 +0800
Message-Id: <20220202072844.35545-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove mistaken right square brackets from "git-diff"
usage string. Make the usage string conform to "git-diff"
documentation (Documentation/git-diff.txt).

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index fa4683377e..bb7fafca61 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -28,9 +28,9 @@ static const char builtin_diff_usage[] =
 "git diff [<options>] [<commit>] [--] [<path>...]\n"
 "   or: git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]\n"
 "   or: git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]\n"
-"   or: git diff [<options>] <commit>...<commit>] [--] [<path>...]\n"
-"   or: git diff [<options>] <blob> <blob>]\n"
-"   or: git diff [<options>] --no-index [--] <path> <path>]\n"
+"   or: git diff [<options>] <commit>...<commit> [--] [<path>...]\n"
+"   or: git diff [<options>] <blob> <blob>\n"
+"   or: git diff [<options>] --no-index [--] <path> <path>\n"
 COMMON_DIFF_OPTIONS_HELP;
 
 static const char *blob_path(struct object_array_entry *entry)
-- 
2.35.0

