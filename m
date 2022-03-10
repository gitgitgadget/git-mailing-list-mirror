Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD52C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242422AbiCJNgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiCJNgf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:36:35 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E5C14E958
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:35:34 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q14so8024273wrc.4
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=UjcNwPjFwUvibmIlJ6VWSo0iPWib0yHZMjniE23Nzcs=;
        b=eZh/YqvpRfrfpuwbTKRycCF6okBSqJk6T5VKRp21suXtFOuTAiXH8clxiTgeC+Sro7
         W3MqwIJAOCInQ5397znQtuXyc9AOEuk3EdchxVaLDVYQn+9pJOy+6j8jbgScPFC6ENXm
         XjTrkIFLepgcyuPdSV0R6RnQlZsMUOdyouWMXIhSJglMedfXVotH/P2IwLrWTrGf6XJs
         Awl5lMW7msKiDxJvDXJuKWTCAV2r/uttVubFCFE59bxaFw1ONRB+z/nZs4L/l9j34jN5
         6knU2mydus/o2VKAdrrcXCjuRf/0pR02BoJMl34Yp+EPJZB6HOXndnzTStUGgtoChzy9
         5bSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UjcNwPjFwUvibmIlJ6VWSo0iPWib0yHZMjniE23Nzcs=;
        b=xpsm7/b80kuoppO6bFG9Jmqo1gayq4Tx644UJUnDXbcIITWsBkQejQIKRClI9iHSTr
         gOMSqYduhsxjVWKiRj9MLBo2EupwsrCxuLCN/71QegzyoXz9pNMubwMwTdAxAUPSX2MP
         B+g1pa6qlIW27DQFlLcff0mKsj6ULH+rj8CEOgIP2Osa3atZsLNLW/CzHvM5zPh+9wVj
         1BBMZK0usTvc/cBvGXJMiihBPOrFjnSPAielhTTj5CKNN+hgMfAoHtXjEcbI2cdLlEmA
         VITlRkZA0muo5MY5y5UhQKdZ634t21Zynzp4HUDkH3Z6a0zz9puSxrAJgf9Vl3IzP3UP
         f3pQ==
X-Gm-Message-State: AOAM533RUr1DTr94LWI/kRtdC53m59LKcgMA2EYIb2g0e6qk+j3QNYDp
        6q6kqc3PgXlwv0zMPadxw59bkjAgOuQ=
X-Google-Smtp-Source: ABdhPJwg+K/5u5sPD7iZdrvvMrZCNCg6mgLPcHQN1Bs+/qe4EBp+A+nj0ZywQ+tb5jAnyXdeDVYugQ==
X-Received: by 2002:a5d:6488:0:b0:1ea:7bfa:41e1 with SMTP id o8-20020a5d6488000000b001ea7bfa41e1mr3602316wri.563.1646919332688;
        Thu, 10 Mar 2022 05:35:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4-20020a5d4984000000b001f97df6c85bsm4210633wrq.1.2022.03.10.05.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:35:32 -0800 (PST)
Message-Id: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Mar 2022 13:35:27 +0000
Subject: [PATCH 0/4] A couple of fixes for the Trace2 documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While verifying a suggestion for a contributor before sending it, I noticed
that the Trace2 documentation contained an incorrect example. Looking
around, I found a couple other things I wanted to fix, so here are the
patches.

Johannes Schindelin (4):
  trace2 docs: a couple of grammar fixes
  trace2 docs: surround more terms in backticks
  trace2 docs: fix a JSON formatted example
  trace2 docs: clarify what `varargs` is all about

 Documentation/technical/api-trace2.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)


base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1172%2Fdscho%2Ffix-trace2-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1172/dscho/fix-trace2-docs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1172
-- 
gitgitgadget
