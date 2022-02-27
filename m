Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49362C433F5
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 21:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiB0V5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 16:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiB0V5o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 16:57:44 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587916E4E6
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 13:57:06 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so4919436wmp.5
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 13:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=raZeHnz0d+CORTk9WwiMcBzUr8yYuX4fJZnnYzX4to8=;
        b=fVYEw70ricl/Zt8Y7j8ItREnTU5svrnludcQM/PlVJoLne49AF2M2/zJuD7fhXjmYX
         ulFp2ccCmhi14roMpptJE4P1n5xEIAsoa09nYcWmKnW02ILLm0OdLV6n5vWxdlIwYtYz
         ATLzOMEM78mFu7yidIW6EuhNkTQNZ9+n9G0/UzeHFVS2O1JZ9sbfrurpNlFhGBOwEOGP
         FScZEVnLcMQLgUCZirFp766IRT0ALVK3VRdvtzv1SBmnezpZ7hnUamsapwIy9RCBaWhh
         gG/wUUkv6fPpJzGG5tYuh3c0NUOiyl4WVH34v8EEkSiHXutzYa0zCTtaIy2yI0Rj7AD1
         e7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=raZeHnz0d+CORTk9WwiMcBzUr8yYuX4fJZnnYzX4to8=;
        b=xHnle1arUE54/i8KsX12aT94ny7gVcSxMOLOrrD371YBY7n7Y5N9vdqAqVOpwZzCzb
         6QcIx+rdBPzTxnJ9mVYvzOsz9W19loy8WTclyE/xH4/TNzC82jNhFb1Uunh43ztYTP8D
         Qy0bEmp8gBxWPYOUDQpI4IDp4FgMuKakTliOsXFQCkG7st4cRSqvljF7o3EspXO07WFw
         CFoBa7SM7qgBRvK/8yfkAC5rzFPocukwR62d3RuLKWC+cEAcwlBXWHxR1raiG/gGZIyr
         pZks9BQ4cQeDdDNqoB4SuDozE+W+GU+YS+4V1UOH0586LkhCesm4r07kvNGd0+5NNrOb
         daKQ==
X-Gm-Message-State: AOAM533egcbQS3VlHxN2X9q8p78IcoukWQC4q5UTnVCKE5S44H61CLKk
        rJr7KjJTJ8IXx88LupjTlfi2wyatTnk=
X-Google-Smtp-Source: ABdhPJwwezYLANgSyx4PU/9nQhca+JALgaSNbN6cRrJilkobeQD7c2hMaLJjYdfCZ/RJCUxBePkuaQ==
X-Received: by 2002:a1c:2b41:0:b0:380:e379:b8b0 with SMTP id r62-20020a1c2b41000000b00380e379b8b0mr11129959wmr.87.1645999024643;
        Sun, 27 Feb 2022 13:57:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15-20020adfe44f000000b001edbea974cesm8558566wrm.53.2022.02.27.13.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 13:57:04 -0800 (PST)
Message-Id: <c901f9d96ca35da24aa36e1978f6ec27981d0e44.1645999021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.986.v3.git.1645999021.gitgitgadget@gmail.com>
References: <pull.986.v2.git.1645809015.gitgitgadget@gmail.com>
        <pull.986.v3.git.1645999021.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Feb 2022 21:57:00 +0000
Subject: [PATCH v3 2/3] t7519: populate untracked cache before test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

In its current state, the t7519 test dealing with untracked cache
assumes that "git update-index --untracked-cache" will *populate* the
untracked cache. This is not correct - it will only add an empty
untracked cache structure to the index.

If we're going to compare two git status runs with something
interesting happening in-between, we need to ensure that the index is
in a stable/steady state *before* that first run.

Achieve this by adding another prior "git status" run.

At this stage this change does nothing, because there is a bug,
addressed in the next patch, whereby once the empty untracked cache
structure is added by the update-index invocation, the untracked cache
gets updated in every subsequent "git status" call, but the index with
these updates does not get written down.

That bug actually invalidates this entire test case - but we're fixing
that next.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 t/t7519-status-fsmonitor.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 3f984136ea9..fffc57120d6 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -341,6 +341,7 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 		git config core.fsmonitor .git/hooks/fsmonitor-test &&
 		git update-index --untracked-cache &&
 		git update-index --fsmonitor &&
+		git status &&
 		GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace-before" \
 		git status &&
 		test-tool dump-untracked-cache >../before
-- 
gitgitgadget

