Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E035CC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 10:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244334AbhLVK7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 05:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240152AbhLVK7r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 05:59:47 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEE7C061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 02:59:47 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i12so1300767wmq.4
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 02:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2qHjIuq6aHLA06hT8+HUh+MKC9eKOONMGbKB5TeyzAY=;
        b=QHnf7StK20GffvthENw15YwsRgubndgb7bhD+d2aBw/Twiq0XJR7j7ZA3qWf0+Ywo4
         2REXY5edX3OIrlMjvXobGXrnVl64XxA8VX0Ua1sVYIgU9ncfoM77VPI2iFvu/ODRULj3
         wZa2+9i4J8L8WNnhn+tCpdBIDcVbydMF7XUV9bDe7y8jmNAY0bQRl6butQCvHUIOFrpb
         OfCnJdSP/j0FARsGGf26xYmLmKD0JqrEp4ESoRxI+7oLKGSY2rAiu0pyt81K9UGE3IJz
         Y0nKHz/DY9djgsAAN4cQIW3k8L+YqjxJiwwaIgioUGH0BuzbO+xFoHw3TeK6N7yGW9nX
         d2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2qHjIuq6aHLA06hT8+HUh+MKC9eKOONMGbKB5TeyzAY=;
        b=TzfIV/yvBux/D6jxMRmfbGs8IP1ua3SlZkfC2bBCJrJ0aFfXL2EbIf4n1culBZaKR+
         IqIYNnPsVDea2w7vWJz2R4xs3vZ911uIktkHbcyOLZMO+2qAc8GpFgNrqD8JBHgI/pgc
         3aFVezL/m6Mpqflg3z4nEoOM0QA2VTAw58TQZIiRsyR1ieN9hZCIBKVRHglE+96Q3Bhp
         sPEVV969bINMk7vGrEtcbOYll4fvfE567uHCfg9om8UlXdlGPINWPptZ6OSQ2MOW2Wp2
         i3+vI1bauh03T+Q5gCkzf3ho6Cqpdk1EByyug/x5CAY1H28TDVbnjLQpM3sApjc7mwhK
         od4Q==
X-Gm-Message-State: AOAM533efED7ZAhmD92TVJmmlVmghmVYQAMBZNzGwKeFO0EThnfd/W2z
        IRBHoY5g4C9ZMcgKKw1oBEjWAiLCtlU=
X-Google-Smtp-Source: ABdhPJwhTsG4laED/na0pqzmgqAGHehYGCcfM9wer5le45taOoGM6i9mGzXfHh3PVXeoxhMKxoOFOg==
X-Received: by 2002:a7b:c4d7:: with SMTP id g23mr549484wmk.13.1640170785955;
        Wed, 22 Dec 2021 02:59:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm1680399wmp.9.2021.12.22.02.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 02:59:45 -0800 (PST)
Message-Id: <pull.1168.git.git.1640170784.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 10:59:40 +0000
Subject: [PATCH 0/4] Reftable test fixes 20211221
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this is an assorted set of fixes to make some tests pass with reftable.

Han-Wen Nienhuys (4):
  t5540: require REFFILES
  t5550: require REFFILES
  t7004: create separate tags for different tests
  t7004: use "test-tool ref-store" for reflog inspection

 t/t5540-http-push-webdav.sh |  6 ++++++
 t/t5550-http-fetch-dumb.sh  |  7 +++++++
 t/t7004-tag.sh              | 22 +++++++++++-----------
 3 files changed, 24 insertions(+), 11 deletions(-)


base-commit: 69a9c10c95e28df457e33b3c7400b16caf2e2962
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1168%2Fhanwen%2Freftable-test-fixes-20211221-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1168/hanwen/reftable-test-fixes-20211221-v1
Pull-Request: https://github.com/git/git/pull/1168
-- 
gitgitgadget
