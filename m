Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89C1C4167B
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 17:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiLLReN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 12:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiLLRdj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 12:33:39 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802012DCE
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 09:33:29 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so5858361wmh.0
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 09:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TYZ0/NHROXBWByrvk0seM4uVpMPU0m3+sjCHxDJ11fw=;
        b=Z8jQI3G9SF6tu5D20SqJmpFskU8EkneP2uiL4dRX7jw0IGWMEILd7t1qWPIwyYqpnT
         XN33yQV4+6uOEKE8eV01QjQa4UaggH5Wgh5rfTpKjYcyVsMounud2zYOqN8U3BXnLqmK
         VnfeKE3sgN7nwaxCIl999SOwMX2sNEtUUWOFIKtS+gymaMOrm+piNPRrdCo4ICVu6OYi
         LH9EoBuSM0Lu30UCV154Cpd+XNV5bw3JmIkjexrPR9qP/8/rkD2xeWg1n0hDLGD9DaaO
         OgHds8JPsRqIPe7TnDcphJu822ptp1crVYs4JfifeSBN2XHFU/qTJy1WLj+QK6WpfseT
         tv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYZ0/NHROXBWByrvk0seM4uVpMPU0m3+sjCHxDJ11fw=;
        b=tdybWm0Ssw7hRc2X2xRBz0SzuK+uMedgDtM23+qik1Id/NRrGTX5mMJ5kU8Um343Zu
         iUjRNJ1k0oZ86gBKFF1Hm9so9Tzx4BKdly04B+O2OsaxpeqxFvUWmNCBSsJSfiHoJMMc
         btuOg4YbYeadj3rVP/57RgyjFWdNFn/LhiGpMnmmnge4RTFvk3mxubVCAp7eYm74CI9i
         gTk5uir5FMZKdUlrDM8OybHNaDFM20LSZReOv+Fu2kITByM9JlP8hBtnKc+ZfUPJzvua
         zxjBoV2s5VODdzxmMYRTeaw8voCoEpg5dHqBqmha5yOFLBDT7NxhUCAz/cqwODHi6TvA
         6t7w==
X-Gm-Message-State: ANoB5pkMBnBjkXTNEC5FLM6eck1x8cuVkcx5O0Qxcsg9lxoW8/ZLEM3/
        8oMhs5x+MKf84vSlFZhMJclPGH4KMxY=
X-Google-Smtp-Source: AA0mqf6o3wEvqZdw8DVdB1wY2LZ+f3HCg0uGWQ1avKiYYrpnSnxeqh1MQS9h52sY1MZ6dWTCzexyjQ==
X-Received: by 2002:a05:600c:1e08:b0:3cf:8e62:f8fd with SMTP id ay8-20020a05600c1e0800b003cf8e62f8fdmr13144316wmb.8.1670866407906;
        Mon, 12 Dec 2022 09:33:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b0024217e7aaa7sm9308337wrr.50.2022.12.12.09.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:33:27 -0800 (PST)
Message-Id: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 17:33:23 +0000
Subject: [PATCH 0/3] Bundle URIs 4.5: fixups from part IV
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, vdye@github.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches represent small fixups that came in review from the last
version of 'ds/bundle-uri-4'. Since it was merged to 'next', these patches
are forward-fixes on that branch.

Note: I did not include any changes that could be solved by adding an UNUSED
macro, saving that for Peff and his already-prepared patches in that area.

Thanks, -Stolee

Derrick Stolee (3):
  bundle-uri: drop unused 'uri' parameter
  bundle-uri: advertise based on repo config
  bundle-uri: remove GIT_TEST_BUNDLE_URI env variable

 builtin/clone.c              |  1 -
 bundle-uri.c                 |  4 ++--
 bundle-uri.h                 |  8 ++++----
 t/lib-bundle-uri-protocol.sh | 12 ++++++++----
 t/t5601-clone.sh             |  8 ++++----
 transport.c                  |  5 ++---
 6 files changed, 20 insertions(+), 18 deletions(-)


base-commit: cec58f9965c845be74753aac6f49b4f177faa064
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1443%2Fderrickstolee%2Fbundle-redo%2Fadvertise-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1443/derrickstolee/bundle-redo/advertise-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1443
-- 
gitgitgadget
