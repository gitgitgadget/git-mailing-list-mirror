Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C292FC6FA90
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 05:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiITF67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 01:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiITF6e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 01:58:34 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CE056BA4
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 22:58:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso908564wmr.3
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 22:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=XhpCjLINC+1loHmVwaM4BFcTJjgc5Xtl7eE25YELpwU=;
        b=CMg1VL8p5IgMJb3dhHRJcE/mT0ewM3H5lJTb1K3Nt75hNXOcNF0LG2D4Ofna5PI9qQ
         /7DbjJ0U/I8LV35qACx1c+AX4SsGBijacLLnYaSVIUioaH+7rywFPlsew74hbRg8tBYY
         Kb6W9pcVQujQrgUTCACe5ODixj+VFv/9A9HQr+9UlIDIVxTrOcbrirXzZmGoKZhiKy88
         mOQc/h5nMI32k8xtVHNyljUtB2LMbgZZssZZEWQ8MiA66icukxzbITGQXQrS0Ba7PLh5
         0Av2bb3MsfvuSNlGxbOKoidwzVfs92Bg1eO43pJ3Ct6eXwBDO5yPAa71bJ56zZl76Oo0
         TIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=XhpCjLINC+1loHmVwaM4BFcTJjgc5Xtl7eE25YELpwU=;
        b=amZA2ssFVqTAjOzbzd9NDCERoZLSd8GY1R47cOqeTRZjBA+lX0sG3jJrW33OTcsbLl
         EqLJIt/JXf6Cw2aGvJVwVREkX7vQi09l5QkuJ87y5P+ZkRb2itzpgXn/IrUvB1clCI/C
         f7xHGGuAMddQuJggZSWz+b8T5tV5wuttp20UiPByCIPKP4dncSV2/A2hCskLPWbHbowG
         hwuV5kMbrC6tf6TNvsf9nYza0cdzJvn3EfImYZmmKxBTJNNZlByAlDKi/tz1veAssf3l
         OKChlMawhSN3kKdCTGXymPxZygHQ9OyRQFFd5/HrvkSg+k+nnR/BubxYmG7v3lIC7ARQ
         77HA==
X-Gm-Message-State: ACrzQf0eFHYGb5+33RvvvvLZnRMWHym5MAxTI6igvhF8sDrV499e7kKi
        6soUrsjv7gkgW2l96qm1YYSoC/KayO4=
X-Google-Smtp-Source: AMsMyM6/0k13j1STgtB62h+vmLCLkohb3h2WI6AJhM5NDdyecwNrMznyZHstjyoV6Oe07H/AyfhUtw==
X-Received: by 2002:a1c:541d:0:b0:3b4:b691:d4ff with SMTP id i29-20020a1c541d000000b003b4b691d4ffmr990003wmb.56.1663653507018;
        Mon, 19 Sep 2022 22:58:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bv2-20020a0560001f0200b002286231f479sm551420wrb.50.2022.09.19.22.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 22:58:26 -0700 (PDT)
Message-Id: <pull.1359.git.1663653505.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 05:58:23 +0000
Subject: [PATCH 0/2] update internal patch-id to use "stable" algorithm
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Internal usage of patch-id in rebase / cherry-pick doesn't persist
patch-ids, so there's no need to specifically invoke the unstable variant.

This allows the unstable logic to be cleaned up.

In the process, fixed a bug in the combination of --stable with binary files
and header-only, and expanded the test to cover both binary and non-binary
files.

Signed-off-by: Jerry Zhang jerry@skydio.com

Jerry Zhang (2):
  patch-id: fix stable patch id for binary / header-only
  patch-id: use stable patch-id for rebases

 builtin/log.c              |  2 +-
 diff.c                     | 44 ++++++++++++++++----------------------
 diff.h                     |  2 +-
 patch-ids.c                | 10 ++++-----
 patch-ids.h                |  2 +-
 t/t3419-rebase-patch-id.sh | 19 ++++++++++------
 6 files changed, 39 insertions(+), 40 deletions(-)


base-commit: e188ec3a735ae52a0d0d3c22f9df6b29fa613b1e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1359%2Fjerry-skydio%2Fjerry%2Frevup%2Fmaster%2Fpatch_ids-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1359/jerry-skydio/jerry/revup/master/patch_ids-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1359
-- 
gitgitgadget
