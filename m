Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6456C43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 11:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiFILfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 07:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243910AbiFILdI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 07:33:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE683D6CD0
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 04:32:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a10so9748264wmj.5
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=QTGO3QvShIMH4LREjGhEqECS4C40nSGhjnS6PgNpMTM=;
        b=DGPVDhuw5bVd8m8DikK0IuhHjvabjqNZY9QpWksAiPVzr4Jo8jeq2hCW41XGg3CZdA
         YsP+e1nxj6EKLsYV4Ca6ce5TqlGogCGJHajK5Cfa0mljAKFCN8drEiTapUFut5+sxDw/
         j5hmMk/vbMuzI+pWhKEOlYUpSLM11ke2kpXkYZFVGRtw7C7NCkp8dSyw4PjsI1GTB+UM
         cSVfTVhH4DFPhD8uLfGZ2n67tU8/eAKqHvdCY0gYh0yeqUzy7NHBPlSGm0b5XB8P/ToL
         4gLtM5a8FvwrdjTG3A/6djY2/W4Skdja0AKzQzNZlm/vw4fKfAQQ+j05titMvaCnEtdC
         HTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QTGO3QvShIMH4LREjGhEqECS4C40nSGhjnS6PgNpMTM=;
        b=uRlJ1xNLkFTQoPdYodhjqmN6IrWrX70Gi3HZ23nxGYc6zYDMGvWxEvMQEzSJNCPAdl
         0rG9PWb4kmSzjnlmx6IHB56YaPyWYPjhRqb85QI0bRctx4MFEq1Z54t/Ef17zRSxiZ17
         mbWfoY2CiTJaRID/WVRdQ6uWQogotjGhBGNsL9Enk5mLvEi2UoXQ+9i0OJklM+bmbBO7
         e5msx6emDNwMppdwmusHsgDXykIOkTcFcjrOS5X0aG9QJxvIzrEZ53ec1tPxfO3YlN7/
         k2Ek2H7oXuLjb/Y5WhZ9l6Nvsqfsa+/HrADf5SLZoJ0RjmcVbT5wE4vwsgnuVRTMB1gP
         rRXA==
X-Gm-Message-State: AOAM533kuOYQwa035rRsqvaEg0fwCca0m3Ydx7MhmYQyXwTFNl9jJKaF
        6AAwoDvZcG/MghWYjw3y2Y0k4a7WExjYvWN5
X-Google-Smtp-Source: ABdhPJwPKh3zhMlCLDqXa4ODGH2qzmnVoUmmUy9iqUXdMruFX6xA6MQ7+lgPhUmER9AwxblRUTKVOw==
X-Received: by 2002:a05:600c:4f47:b0:39c:62cc:75da with SMTP id m7-20020a05600c4f4700b0039c62cc75damr2853718wmq.114.1654774349423;
        Thu, 09 Jun 2022 04:32:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg16-20020a05600c3c9000b0039763d41a48sm29153277wmb.25.2022.06.09.04.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:32:28 -0700 (PDT)
Message-Id: <pull.1253.git.1654774347.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jun 2022 11:32:25 +0000
Subject: [PATCH 0/2] ci(GitHub): mark up compile errors, too
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like we mark up test failures, it makes sense to mark up compile
errors, too.

In a sense, it makes even more sense with compile errors than with test
failures because we can link directly to the corresponding source code in
the former case (if said code has been touched by the Pull Request, that
is). The only downside is that this link currently is kind of misleading if
the Pull Request did not even touch the offending source code (such as was
the case when a GCC upgrade in Git for Windows' SDK all of a sudden pointed
out problems in the source code that had existed for a long time already).
We will see how the GitHub Actions engineers will develop this feature
further.

This patch series is based on js/ci-github-workflow-markup. Which also
serves as an example how this looks like if the offending source code was
not touched by the Pull Request:
https://github.com/gitgitgadget/git/actions/runs/2461737185 because it still
triggers the above-referenced GCC build failure.

Johannes Schindelin (2):
  ci(github): use grouping also in the `win-build` job
  ci(github): also mark up compile errors

 ci/lib.sh                 | 10 ++++++++--
 ci/make-test-artifacts.sh |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)


base-commit: 3069f2a6f4c38e7e599067d2e4a8e31b4f53e2d3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1253%2Fdscho%2Fci-mark-up-compile-failures-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1253/dscho/ci-mark-up-compile-failures-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1253
-- 
gitgitgadget
