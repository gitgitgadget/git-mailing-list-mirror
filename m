Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F71BC6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 00:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiITAUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 20:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiITAUD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 20:20:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7746B28716
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 17:19:59 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o5so713042wms.1
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 17:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=KLGwzOjgB6hDj+5eWGhH0jWBsB3fjiDKa5DnK41C40s=;
        b=RTaMmizCwMi1OEhNpDp4HXI2tMq7LGlgJ4VVeOLolvwuOm+KNBgm3vKbr7bE/nHCgP
         N46XejahPNaZJWhd3P5jkVxTEmI0c/ckrZSbAF2BWWaxe4nA3tt8uc7hL4vwC49Sw8K1
         SaBsZQPZuY7OnEa9pZkxLP1vwCqY5VP/arvMGKvjoaSWO8mexF2ttwRNqaMvkI6d5dr8
         SzDa5r2/Z34y+8I+tR7rk/O3AldEqmplI7TWCsKp2VM2JW5Jl9BfDI3AMqvocxZoyTda
         5GFcoRRHajDfUyNqDbmzZPANVk8SpTUTxpA33va/RvRymElcWcBW61Rtv6NsPSY9tTc+
         RdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KLGwzOjgB6hDj+5eWGhH0jWBsB3fjiDKa5DnK41C40s=;
        b=8KfayU5sfuqMuDt0EwkJQ9upryMcZudk0ZwZU2lB2AePThEQTbWPi4Jnt9JL35ndd9
         JvKXITw3P0fxCQsD442dIAinqtSjhnn2c8tDZZ35XH+C1yDjPGdjmx6MDdw5k2c4eqlb
         2M0SRfVU/5CIRReDUaAe3UBh7IAXrUFhCIvoJHoCHSM91HlmuiRHnkAHlarZWdVHvWcu
         SnB0QZdiSUkHjXs/NBUZ9D0XD/JG/GzbF5+A2NRS5X5WGwvc+fjA+APm9TO/tYkNRRQq
         uZPm7isptDXVHje7moidW/O82VunbEIw3mOvkAovEmzCgpBNL2s1ciUUinQcB5+/ziUh
         8gBg==
X-Gm-Message-State: ACrzQf3cDaTHmZxecz+LYOcfPB3QVZPaWV36ueHuge/pGx9IdunciQO0
        N3RLGJxzZDxe4mbOndQ6quXdz2bTnXY=
X-Google-Smtp-Source: AMsMyM7WmQmmivvNPTjZ34P0FZKImbfxb7+cEwCV6UEPNzzy+cx7GQnfHtxwejSoFuB5E9NfQnnJBg==
X-Received: by 2002:a05:600c:4fcb:b0:3b4:a4dd:6154 with SMTP id o11-20020a05600c4fcb00b003b4a4dd6154mr451609wmq.60.1663633197728;
        Mon, 19 Sep 2022 17:19:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b003b340f00f10sm15421362wmq.31.2022.09.19.17.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 17:19:57 -0700 (PDT)
Message-Id: <68b4d8bea78568f8f00164a7b7c3f8e724699bd9.1663633195.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1360.git.1663633195.gitgitgadget@gmail.com>
References: <pull.1360.git.1663633195.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 00:19:54 +0000
Subject: [PATCH 1/2] diagnose: add to command-list.txt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add 'git diagnose' as an "ancilliaryinterrogator" (like 'git bugreport') to
'command-list.txt' in order to have it show up in 'git help -a' and avoid
the "no link" warning message from the 'check-docs' Makefile target.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 command-list.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/command-list.txt b/command-list.txt
index 93f94e42ab7..bb2e0a9214b 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -91,6 +91,7 @@ git-cvsimport                           foreignscminterface
 git-cvsserver                           foreignscminterface
 git-daemon                              synchingrepositories
 git-describe                            mainporcelain
+git-diagnose                            ancillaryinterrogators
 git-diff                                mainporcelain           info
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
-- 
gitgitgadget

