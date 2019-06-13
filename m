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
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DDC1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 15:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbfFMPUc (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 11:20:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40750 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbfFMMxw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 08:53:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so16435888eds.7
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 05:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=tjlKAvMFwl5NCRqvt3KN47fF8YCgX0ude7uVobuePsQ=;
        b=EFkA2/pYh9zA+18vNIVq/gz8VS4a/Ee5LsNzAtCjkTjpg3X+uV1oSiq+IqScF7xPv1
         WIaVyvA2DBaRoT0DS4Rsif8xwGoSOEsvNX3V3WO7iNawDP4TeJAiHwSwvRglhz38nXOk
         yEkboTCDn8gUFGyn92IxF/LlyiIgiDcAlRUg2GnQXmgNdrGDbBseM1P76Jo0HePzj28X
         bPeDXXSNHnpwRLSDfP4rWGivoncW2f4jgCBHAfsw4LK0JUr/6Ptm6+icqiLNYwy7wt5U
         6N7pXJUfY5jQTrC+61HJxXxaETXG5zQqSoBX39zgF0FL1mVf8sDvdAI7Eeyaq5+ZsH5Y
         lVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tjlKAvMFwl5NCRqvt3KN47fF8YCgX0ude7uVobuePsQ=;
        b=qae+C2yThyX3ISfhkeodGG7ahZJOh6h5OWHrw40u7VvAp57KOxdgLL/dYBR7/AmFoQ
         woJmvIjxH42VxkwqolfA1qQzbkJmkBP4PJ4SN2c6LA959hM7L7YTfgnMf+nzwZNpBtNX
         1WIJcHWHnonysbFEhMY5W/5tB2hJ750U65dmH/SdNeVsQ9bO6tiY2jpIvCk01EHQgLhO
         A6pFQQWZQoMknbD2uRqDt+z9QeCsspTLQ8jesJN3kmlHrvoPtrc1r/RLGkmdT1+YJwGp
         BcKUOSmHMLs514KbmuBotlDC6p71tr4IMD8zki+dNJmjoaCQlXgRVgME4CgQyfIoHTNA
         UjvQ==
X-Gm-Message-State: APjAAAWT4bTbL6/nlx5tU3JOqqTL6F4SJx73HKxNGSOXfRdFEjixQoYE
        N3rPivN6hOlakqy18+34G/7yYB5d
X-Google-Smtp-Source: APXvYqwrzwo6yDJHHbhT/zPn/m/3T3C2QhdPWB6eQaPSEnzyAbIJ19nPA3xoExbjlqF7ea4I44m8Yg==
X-Received: by 2002:a50:b34a:: with SMTP id r10mr2462873edd.84.1560430431315;
        Thu, 13 Jun 2019 05:53:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm862631edr.27.2019.06.13.05.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 05:53:50 -0700 (PDT)
Date:   Thu, 13 Jun 2019 05:53:50 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Jun 2019 12:53:49 GMT
Message-Id: <pull.266.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] ci: split linux-gcc into linux-gcc and linux-gcc-extra
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For people like me, who often look at our CI builds, it is hard to tell
whether test suite failures in the linux-gcc job stem from the first make
test run, or from the second one, after setting all kinds of GIT_TEST_* 
variables to non-default values.

Let's make it easier on people like me.

This also helps the problem where the CI builds often finish the other jobs
waaaay before linux-gcc finally finishes, too: linux-gcc and linux-gcc-extra 
can be run in parallel, on different agents.

Johannes Schindelin (1):
  ci: split the `linux-gcc` job into two jobs

 .travis.yml                |  4 ++++
 azure-pipelines.yml        | 39 ++++++++++++++++++++++++++++++++++++++
 ci/install-dependencies.sh |  4 ++--
 ci/lib.sh                  |  4 ++--
 ci/run-build-and-tests.sh  |  5 ++---
 5 files changed, 49 insertions(+), 7 deletions(-)


base-commit: b697d92f56511e804b8ba20ccbe7bdc85dc66810
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-266%2Fdscho%2Fsplit-gcc-ci-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-266/dscho/split-gcc-ci-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/266
-- 
gitgitgadget
