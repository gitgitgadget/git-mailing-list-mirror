Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EDBC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiBXJqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiBXJqN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:46:13 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7259C27DF31
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:45:43 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v21so2045782wrv.5
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=VOkPenQJma4fOv8IPrCj/cKsOLHq1qMeLYLEKXDrUCg=;
        b=e/knnqyY3GdErz020KWC84lTNNWtnx7clFZD/zILy4TOlT4uXP+q70VdroHEz7ULKC
         Pm7hNneO2MMn5XrCtIYUbOBu0AzV/M21Y3ol/xDgUoFHMC6/Si+OoJuxqcmQm9OH//bU
         6yBRf9g78kW9KGj44AvnfDnmGil5G1vMRtI0s556BC5dN3ny2iPTjLrxIagOtgOq7YpI
         OU0WJAcqPKG38uUoxljU3QaQSg4Q8+AZ9wTiNHM5IpGN0g5T2m4Hx8F3ZzzWMfc6bJ3p
         88C2UEtRpBhv9GNSwUAFgKd0JWwHbUDNUqQ6w8+Nnh2ts234UpIgnxMmAhbKVO8b0sC4
         GrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VOkPenQJma4fOv8IPrCj/cKsOLHq1qMeLYLEKXDrUCg=;
        b=Mhx9FI2dfWMVcifCtSWsmGENPF6Xt8Cw4epVFnXd/krqchFUlk/d+ji1hhgdPkgAoL
         bT/tX0bhcd93EDdb4VkaEYSr5UR9Xp0Hxaa6Hp9HUD2wr9LT1oxNWGVoRCuquH3cvKT6
         oGKgcS9Rd9Y6r2fTx4RFOuPZ6bnG2ECy5NiWh/Pjd80nW6NCx64+zWX9nmmA3TzOBUP2
         vZC9xeOra/+Ka5RA5vRfXLfUQvoM2RwKLyZtyfSqdIMomwxfCrsZFvKTrCbAcPnqqSeC
         Gtd3TqGr82x5NxtpcV2BsyZ3Vcedt1a/SU2jg3bzzYNhGqCVvkxKLPqRfkFS27T2N7tv
         Eb+g==
X-Gm-Message-State: AOAM532u7efjsX0Dfi7hMlSIDQkaNfnL5bwkluva3KxQ0dMETohsDvYl
        RmKJserx8/8mpSnWp+j5EEdilRr2Q08=
X-Google-Smtp-Source: ABdhPJyAqqGR4SYKWJcGg+E9ZQGyNkDyWXSJjIOPCoEr6BQOl7gc7roeKfJS0rG5fVHZxQFYwYS7GA==
X-Received: by 2002:a05:6000:2a2:b0:1e8:6dd5:767b with SMTP id l2-20020a05600002a200b001e86dd5767bmr1486785wry.444.1645695941696;
        Thu, 24 Feb 2022 01:45:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10sm2098305wrt.57.2022.02.24.01.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:45:41 -0800 (PST)
Message-Id: <pull.1161.git.1645695940.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 09:45:37 +0000
Subject: [PATCH 0/3] adding new branch.autosetupmerge option "simple"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit introduces a new option to the branch.autosetupmerge setting,
"simple", which is intended to be consistent with and complementary to the
push.default "simple" option.

The push.defaut option "simple" helps produce predictable/understandable
behavior for beginners, where they don't accidentally push to the "wrong"
branch in centralized workflows. If they create a local branch with a
different name and then try to do a plain push, it will helpfully fail and
explain why.

However, such users can often find themselves confused by the behavior of
git after they first branch, and before they push. At that stage, their
upstream tracking branch is the original remote branch, and pull (for
example) behaves very differently to how it later does when they create
their own same-name remote branch.

This new option (with push.default set to simple) ensures that push/pull
behavior is generally consistent - tracking will be automatically set up for
branches that push will work for (and pull will be consistent for) only.

Tao Klerks (3):
  merge: new autosetupmerge option 'simple' for matching branches
  t3200: tests for new branch.autosetupmerge option "simple"
  branch documentation: new autosetupmerge option "simple"

 Documentation/config/branch.txt |  4 +++-
 Documentation/git-branch.txt    |  4 +++-
 branch.c                        |  9 +++++++++
 branch.h                        |  1 +
 config.c                        |  3 +++
 t/t3200-branch.sh               | 35 +++++++++++++++++++++++++++++++++
 6 files changed, 54 insertions(+), 2 deletions(-)


base-commit: dab1b7905d0b295f1acef9785bb2b9cbb0fdec84
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1161%2FTaoK%2Ffeature-branch-autosetupmerge-simple-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1161/TaoK/feature-branch-autosetupmerge-simple-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1161
-- 
gitgitgadget
