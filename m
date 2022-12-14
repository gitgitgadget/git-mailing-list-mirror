Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94EFC4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 16:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiLNQwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 11:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239167AbiLNQw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 11:52:26 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67F21F637
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 08:52:25 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y16so371546wrm.2
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 08:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PnXY5qtWbbjOl8hYhz5+SCSfMB9W1mnaVr4zfuxNLfY=;
        b=N6QiQ6AS0tl3pqQv7IBfqn4/Bm7ZF+uBymYaNNa7iO2tlZs3CsZV1EGMQW+2/Ejn5c
         3QAfwIZL3FZVIOGStY7VEtYO9wJRV81/zEL8HLaajjQ0tAdNuyujDP1RVbljUMPnAPhP
         JTPbDIuUoCZyrJwnIiNJjRToJFF1BBmhNkCZ9EjnvKXdADi8+rVf4ARTISXUtT7Te2WR
         rv2nvuGUIaUTlvt1z26NWAyWUF9+2piGXR4YdlAquQd0/Oqem7U5rU/zflZ8g440Cda/
         lc7bnmlOrNQrS+TukNueX4Ikjyep0wT1DvGwpetbet1UwdGRnRC2hh0bCwZ3+hLQiVI+
         mExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnXY5qtWbbjOl8hYhz5+SCSfMB9W1mnaVr4zfuxNLfY=;
        b=6DTnwV6nq/Fzo+BoFu55f2yZdooQkaC3VP6js4pnvvleoD08jZ19nIsgevRrfSgIyr
         VCt3sTEachOjH6jKDKISNjsIaHTp7ta6M27z0s+N7tGOdGNxFxfKQWmhnHExfVeuyXKX
         EOPFJzZWI3Du8sLecC/WM9brZcoizfN11ypZqroqquppP8KG++nES2zoy52Hgh6J1W0m
         5wONYdmAXbpvOY2Dl4cISGHbRgNluTd+kDM54eOZXiLuH0HrGEffm6opL3/Hi3o1A6PB
         P1HM5dDCPw8qm7OEK80zoogNmAv0WowmxcBl2ZtUgIQ9kGN1K9NY9MFUHcKWMFLd1RW4
         G13g==
X-Gm-Message-State: ANoB5pncUDYmokE/L3sLvNUKxnLuFmJBww46j+byWNK392uzOpEMjLiC
        5lyobAKvHAe+beTtdV9gcovHWYCwJSc=
X-Google-Smtp-Source: AA0mqf6P0VqoigPCxSpJq+wC8dTCU6kNX5sRJQqJx7MHURdxRfNBjkBbVflyNxpzWbXBDZUBoQmShw==
X-Received: by 2002:adf:fc8a:0:b0:242:14bb:439d with SMTP id g10-20020adffc8a000000b0024214bb439dmr14557943wrr.43.1671036744161;
        Wed, 14 Dec 2022 08:52:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d67c9000000b00228dbf15072sm3423527wrw.62.2022.12.14.08.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 08:52:23 -0800 (PST)
Message-Id: <pull.1394.git.git.1671036743272.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Dec 2022 16:52:23 +0000
Subject: [PATCH] git: remove duplicate includes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

These files are already included; we do not need to include them again

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: remove duplicate includes
    
    These files are already included; we do not need to include them again
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1394%2FAtariDreams%2Finclude-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1394/AtariDreams/include-v1
Pull-Request: https://github.com/git/git/pull/1394

 pack-write.c   | 1 -
 sequencer.c    | 1 -
 unpack-trees.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 00787e306db..33637297487 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -5,7 +5,6 @@
 #include "chunk-format.h"
 #include "pack-mtimes.h"
 #include "oidmap.h"
-#include "chunk-format.h"
 #include "pack-objects.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
diff --git a/sequencer.c b/sequencer.c
index dbd56121e24..bcb662e23be 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -36,7 +36,6 @@
 #include "rebase-interactive.h"
 #include "reset.h"
 #include "branch.h"
-#include "log-tree.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 8a762aa0772..d11bef96bf3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -19,7 +19,6 @@
 #include "promisor-remote.h"
 #include "entry.h"
 #include "parallel-checkout.h"
-#include "sparse-index.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as

base-commit: 57e2c6ebbe7108b35ba30184dcbcb6c34c929ad8
-- 
gitgitgadget
