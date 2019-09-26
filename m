Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16E331F463
	for <e@80x24.org>; Thu, 26 Sep 2019 21:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfIZVRM (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 17:17:12 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:45880 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfIZVRM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 17:17:12 -0400
Received: by mail-lf1-f47.google.com with SMTP id r134so249438lff.12
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 14:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=zMwLCwGA+EvcxjV0ZECvl72NhS7mhlMoHnMpO01B194=;
        b=HZx9Ih4Q9EXHAcS91iE3Wv8X/oYckX++z7+Z2oqHPxMmgD6zFAHkbv+zWSUL58DfHG
         Udgc/ZdHFSx8yVZemT8+v+VAtqOiztdk0x3INyVQrrA2UOQZbSl0OxgBY7YwSRqac2i9
         5kpBtmFmpkcQ41Br/ksXoamDJzfdRk0DaHhVtoRTzxHW8EmIArTD/qBQAi1uB03yGUvU
         mkB6sRaKMm9t/9adDWDPLbISXWjwn6EzDisqxjqL4vsuS7o/iWDr8dlunQ/BklcQL+B1
         RPgdw2FvlowLBxQI/58PBPPAwsZvS32q4C4zLutrEneOfSI2mRHNhIuvZT9WkfdPkM2m
         8IIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zMwLCwGA+EvcxjV0ZECvl72NhS7mhlMoHnMpO01B194=;
        b=MFjoakrYC1tRcibKTSioMeRDk+U2SVBACAwdNJkBW6wcTeV8tZQV6fkx+f/dbXIrqQ
         X7Amd35jdtPJpw1gkYf9vXdfj4sWV64Ww8KcI8JzRPjMlTmnoZLX4iusnU6o8y+etPaA
         IrU/TLOGdPg/22MGsz5yZtBvaKRvVFSJnmVM5NwS+bX2e48kZNxgYgh5Mxh8j58IZBY1
         HwW3xWNLeltTQAMkzd+UeJRX/0Fs/U8nc0yT8U1GNqxvBHn9XV7izJgK8/f3XkP5tO41
         2dV0ldQtfhhm81y4DGtRcZv9ZCq3GeQfhWGi3nEcPE5YL+H3l+MDrbD8DU/ymHh7GylJ
         0rFQ==
X-Gm-Message-State: APjAAAXVVjil9LtMEUm7MtQ28kWH09g2QV0TDQwg+G/S3SeSOx0fGz0/
        h7HLTBYgMAq9EsZQXu29GwsHFbeH
X-Google-Smtp-Source: APXvYqyHCiyi565GGxxCqg9mxIgRFQlj/Bx5YDLDMgVAHb2tbT9TsQgjwZcZP0avC1fJmijjtMYPgg==
X-Received: by 2002:ac2:48af:: with SMTP id u15mr376841lfg.75.1569532629782;
        Thu, 26 Sep 2019 14:17:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a23sm69672lfl.66.2019.09.26.14.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 14:17:09 -0700 (PDT)
Date:   Thu, 26 Sep 2019 14:17:09 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 21:17:07 GMT
Message-Id: <pull.361.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] git-gui: respect core.hooksPath, falling back to .git/hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is yet another patch from Git for Windows.

Johannes Schindelin (1):
  respect core.hooksPath, falling back to .git/hooks

 git-gui.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)


base-commit: 60c60b627e81bf84e1cb01729d2ae882178f079d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-361%2Fdscho%2Fgit-gui-hooks-path-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-361/dscho/git-gui-hooks-path-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/361
-- 
gitgitgadget
