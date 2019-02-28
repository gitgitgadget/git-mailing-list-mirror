Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A48020248
	for <e@80x24.org>; Thu, 28 Feb 2019 19:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfB1Tdy (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 14:33:54 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:45092 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730829AbfB1Tdy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 14:33:54 -0500
Received: by mail-ed1-f49.google.com with SMTP id f19so8599308eds.12
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 11:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=KUBAbMui58J+yoADN4+Na5DFq0rjquJHvgy1ClDZ0Ls=;
        b=ipNwsz7fyLJtdOsf+lPOKzV+RKxO9wMPTb/B25SaeVMomupurcJ+7FEuRYD272EzVu
         M0mB4OYhArr/E+9tyjT5FjbP5/V/W9KuZXlcTzesbM6EhCPS+j4ULw3oJxIMgd+cgxW0
         c2lLsmiuM1qQWCSshAGoc/qJqcLVtmhiUzdZB3NoFNAnKwrKLtHH1B/rQKY3dQAKu5j7
         6oMVQ6+RGngbSc+pOCnf/ABgss0XWloJ3ToBRAZhWJfEeMZ+2Qd2URh9NkzaiSbizlBX
         gdEZ4xj8WnNgNPhevLTJiTuCEl6Kqj1wH8U0sHLYNMg6phxswgAqqja7mFrdUj/UHOyS
         G5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KUBAbMui58J+yoADN4+Na5DFq0rjquJHvgy1ClDZ0Ls=;
        b=pMPyGSffwqcQAU57VOkgj/jIkJYZcD6u+9l3cB56C9Bh4Z0hHsRs7VfxUkyKAMsAAb
         HtlQzdKN5Fp1LUpfnSdCYJS9ZgoC+oOrnzvIwaXhMt3jCBC0K6E8tubxJB7fNd59Xhug
         t7/1RJ0lqQ1uHnd6OFj8i9hEOAI0NV2UZt5IYy5wy3KI6RiMyTbekkeZ0DjxglV+x5t+
         QNrQy2Gjh9qE2TAubR7Kfzke+URN9ClWvmlfaxiUQTIMNTF3FNntbT6/fLffHfm/4udt
         srsZldqj4cvSm+CUCL3CJxT4t9f7ab3IQ42g8DDFowIT6M9WUqvd7tGZxoq3bw+1Cqf9
         L54g==
X-Gm-Message-State: APjAAAWUlaJIHzX3s5UF5Wsl8Ne6frwwKLkOWKtsuXVEpxteN0Mfrfia
        tM9/qK+6rxX2UA9IYmp4HNYiYtGF
X-Google-Smtp-Source: APXvYqy1VD4u8CCIuFAN+I4XckcsRKPnG4xVaymyiTxbo3xBj/TB2YN8SdFsjwmscPqXzJmN5e+50g==
X-Received: by 2002:a50:940a:: with SMTP id p10mr1045254eda.54.1551382432393;
        Thu, 28 Feb 2019 11:33:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p47sm5280190eda.31.2019.02.28.11.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 11:33:51 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:33:51 -0800 (PST)
X-Google-Original-Date: Thu, 28 Feb 2019 19:33:50 GMT
Message-Id: <pull.154.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Retire the "let Travis trigger a Windows build" hack
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

We have something much better now: a real Azure Pipeline. Not only is it a
lot faster (due to parallelizing the test suite), it also won't time out
waiting for the Windows job to start.

Johannes Schindelin (1):
  travis: remove the hack to build the Windows job on Azure Pipelines

 .travis.yml             |  10 ----
 ci/run-windows-build.sh | 103 ----------------------------------------
 2 files changed, 113 deletions(-)
 delete mode 100755 ci/run-windows-build.sh


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-154%2Fdscho%2Fremove-travis-windows-hack-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-154/dscho/remove-travis-windows-hack-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/154
-- 
gitgitgadget
