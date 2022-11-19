Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DDAC433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 14:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiKSOC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 09:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiKSOCY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 09:02:24 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F6B63BAA
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 06:02:23 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e11so533072wru.8
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 06:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dNWncZ5U3mDOO4p6xDKgiREJQvJBUv5d81NZdoQOeTQ=;
        b=HXkE7mlX7zixtth3CBfU9qus7Tnatci2aCWHl5t33trtaZiibhj94QoO2QN1TK2sVB
         N4yH+aHaQU4TpqRoHHpm8cajxFvqvoasbzs1rOJ0y/qreFu6qh2hBPWpyOHP72OEwctV
         pFdoxXbZyYeb30+iX0Gn5S+ejh9J4g/xL/J+y4u/wy+5iSErHP/OYRNGkaDluC6LPm4z
         5zJe06xilg4oNCkVlDGOzO8zGdc5DLU462bTRDhMWbakElOxPvN6WY1lvaJVUKe5K2+t
         SI+lAkSvGFGpCIGijDLJtqb7mdUPhwwxt50BSAskEw6AoH71q6fjz0ntiPJUzmoMk/0u
         l04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNWncZ5U3mDOO4p6xDKgiREJQvJBUv5d81NZdoQOeTQ=;
        b=QMK5lddn4WQ8x0DDCQ1+b6ZNJ1KvpYJC7X3fQiRSVhD9LcfPCJcGAF+0IAuoyXR8FU
         8/xj9C+RbtmaAyqBFy78N4SCuh8p7ETDMI3IyF1JoEyoHm0yHJOVPO2eGuWyH5N1EH1Y
         O3HvnQFCgf6aPGyw2hC9CiOJHx//fAAxCbF3LMrtFMOEcd7fdiRM0DV5w++H92MLO6H5
         t10b6+k5P1XGMoFKGjPqgA45rB7i6oYvgVlD/lHeOCK3xX2XqYeuj7Kfw1LTDBS3ZVvr
         ZDlYdZ8rFu2F/jqgUxMAQfBm/4rfhOaNx7OR+14zPEf6bKf6in3X2LuGS0JLRgb7XYiL
         7eqg==
X-Gm-Message-State: ANoB5pnecWbaeo/puIJEsooGNwDu7QIpkAFlU/rz5VQg2KlTbfo5QCMU
        X8OEvvcWwReKqXsW2XarJW8TJjd1loE=
X-Google-Smtp-Source: AA0mqf48AXFLSfdn9NAg3f9QWbfiwukJjDtvwWHU3843RKVLJARIRY/n/fyLdS//fW189dYtHfxFzg==
X-Received: by 2002:a5d:6110:0:b0:22c:dd11:7cac with SMTP id v16-20020a5d6110000000b0022cdd117cacmr6523286wrt.205.1668866541820;
        Sat, 19 Nov 2022 06:02:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc10-20020a05600c524a00b003cf9bf5208esm13601642wmb.19.2022.11.19.06.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 06:02:21 -0800 (PST)
Message-Id: <pull.1423.git.1668866540.gitgitgadget@gmail.com>
From:   "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Nov 2022 14:02:18 +0000
Subject: [PATCH 0/2] git-jump: support Emacs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an optional argument 'stdout' to print the quickfix lines to standard
output. It can be used with M-x grep on Emacs.

Detect emacsclient by GIT_EDITOR and invoke the function. Tested with
EDITOR="emacsclient" and EDITOR="emacsclient -t".

Yoichi Nakayama (2):
  git-jump: add an optional argument 'stdout'
  git-jump: invoke emacsclient

 contrib/git-jump/README   |  9 ++++++++-
 contrib/git-jump/git-jump | 22 +++++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)


base-commit: eea7033409a0ed713c78437fc76486983d211e25
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1423%2Fyoichi%2Fgit-jump-emacs-support-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1423/yoichi/git-jump-emacs-support-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1423
-- 
gitgitgadget
