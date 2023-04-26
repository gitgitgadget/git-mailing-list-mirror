Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E13C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 07:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbjDZHp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 03:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbjDZHpL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 03:45:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B724226
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 00:44:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f09b4a156eso45009775e9.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 00:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682495082; x=1685087082;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DrYFywBJ6KwnsRDLvaMium/c48VucEjXPJx/cOyzV74=;
        b=JbFVvSReP4BU+B5i5jP9YhWoshGVhIVVBJb1u1kTK0yoqU7wJstgJzhHSmpKRcb8xe
         MpGXFO4Y803yIXunAHIntPaWSKKIciykEgoSUi8KHWdei4R7xwdOWHQPrW2QR4ChgXzl
         DtV8sZQPnaR1vZk0RXwyt+8g0i4dF6XSPW8kUzrdVqB5XX37rJLsF9tzXtrAxjJikkgg
         OsJA+nQHcgEdKhMLDQKwrtUXzrzBeltL56tkPOKCBMfn+VKetDYp0Hl71IBGpR5UY8nM
         T8VyNyluOtNEa3Z5m2r9s2Ah0TzmpVNSvMkva/pTYDAk1kuWnPbWnPcTcx/48r5xhyqJ
         lXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682495082; x=1685087082;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrYFywBJ6KwnsRDLvaMium/c48VucEjXPJx/cOyzV74=;
        b=A3PUoEWjD5yxxnfjCwTLhPw3XNalr3NtQtXGl7YmAl4cREOpE3WiYCdeTk/tQsoYQV
         PpkgM4YDPQdhe6x3VYpDyRfoaZUX6NaLKElf/sGfmQEiF9HMENyaUoYJxkhsgy9lne08
         uY0pMTiagUpP/2Xhz4uFqzzNR8IxtnbgejbQ/ffGMDOTeol7RR87ErEo0Wb01oZ31H3R
         NUElJzIBf5wTcrSmYFU+3qk4DaHEy79gMJHbfuJqy4pfKJsOZyr76c/2GPdQuBTb2eA+
         AjKRvlwiLxeGKugHvBbpHpu6fQyX7shd7nLvEVlyraxIf3LT0YSEU0KN55LQeTt3x/2H
         RcxQ==
X-Gm-Message-State: AAQBX9cfcYi1k3Uplh/YXXhfJZX9zLYJ04kBrDBE8fyW5LJ9DbQb/IWx
        GSUsMO7pvq4Ya4rMmaM32P5zWI76UH4=
X-Google-Smtp-Source: AKy350aT5fIrWo5ErYY0z2KUCkNMCMdEaMMF21QoFM4L+d7N1M1bCvJRjmF+KpFq5jNXjc14iXpYdA==
X-Received: by 2002:a1c:ed01:0:b0:3f1:70cf:a2d9 with SMTP id l1-20020a1ced01000000b003f170cfa2d9mr12021784wmh.9.1682495082273;
        Wed, 26 Apr 2023 00:44:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1-20020a5d48c1000000b002f27dd92643sm8060461wrs.99.2023.04.26.00.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 00:44:41 -0700 (PDT)
Message-Id: <pull.1485.git.git.1682495081131.gitgitgadget@gmail.com>
From:   "Pooyan Khanjankhani via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Apr 2023 07:44:41 +0000
Subject: [PATCH] revisions.txt: correct a mistake in dotted range notations
 section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pooyan Khanjankhani <pooyankhan@gmail.com>,
        Pooyan Khanjankhani <p.khanjankhani@digikala.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pooyan Khanjankhani <p.khanjankhani@digikala.com>

Insert a missing 'not' word in a negative sentence.
  ... but are [not] reachable from neither A or C.

Signed-off-by: Pooyan Khanjankhani <p.khanjankhani@digikala.com>
---
    docs: Fix sentencing
    
    Just fixed a sentence in docs.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1485%2FTheKhanj%2Fdocs%2Fsentencing-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1485/TheKhanj/docs/sentencing-v1
Pull-Request: https://github.com/git/git/pull/1485

 Documentation/revisions.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 9aa58052bc7..00c2f030da5 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -306,7 +306,7 @@ other, e.g.
 
 does *not* specify two revision ranges for most commands.  Instead
 it will name a single connected set of commits, i.e. those that are
-reachable from either B or D but are reachable from neither A or C.
+reachable from either B or D but are not reachable from neither A or C.
 In a linear history like this:
 
     ---A---B---o---o---C---D

base-commit: ae73b2c8f1da39c39335ee76a0f95857712c22a7
-- 
gitgitgadget
