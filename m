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
	by dcvr.yhbt.net (Postfix) with ESMTP id DE50C1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 12:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733072AbfJJMfg (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 08:35:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43437 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbfJJMff (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 08:35:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id j18so7664118wrq.10
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=N2/VlsWoI+WDevLeCXqDwv3m41amNLdIvT1ALJogveY=;
        b=Tr8blUvRee0oaE+S4v+u/baHFVvOT7tMq+n2vpjM09Nd1TJdwII7Kt2h2HkdOXCc1s
         62/T+j0AIRvpAvVbYA7AbkHaFrhHI39PBupIYtbIxbNJHqF9FqA2j4PnGTQjfXvnlvzp
         yR0l9/Yak3flktA3SG4ufBOlsqIf4Bxdsn3r9gcKhD14bcSW4QtCp7ySzRRH1pD0dnx2
         pasttsHkWecNyv59Vwcd3YHp7uGNuzuydRDTkptsWJPopa9kUXMSkuaJZAiWopEU2YTo
         X1F1rCxVdflxK7rTvNNtnPrTkutUUJ3pr7rfh5FjoHlrhJISGOK9tpUXEPkYaUb/JlLd
         zVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N2/VlsWoI+WDevLeCXqDwv3m41amNLdIvT1ALJogveY=;
        b=WSEjmCKCh8SsC6gLMIsmMST32vE2rssWMmZLo0RBStvbHOOyuBF/iVkbmbKnUfLnYA
         /TYUtWZOYkhLNqAAvc/agjpXkt0tTDioVewQtoSn63+DylohCM3qIdDO05ZONemcN3mL
         VeUeFCp9GGpF92hhtHHhJ1o80P4qHoB5bN1eQ3zffs5KffvLh+qIBZXuRH/8jVDbxd+0
         jFrnTq/EdDI3hZawtXw0NF+0pJGzVnIkTosymiaGPkWtDjr+Gjw3wjnE16xCINKkqoAw
         7/vH1iNyPxU5L2mrPDAGhSEHWplF9Y3KvyOKegaj8dSowWpT4tsWvk55x5w8cgW0CuY5
         xdgw==
X-Gm-Message-State: APjAAAWes9d1NtFG1g01unPvdlPxUPSdq1xO6kl8cdqGSiS/HzNgrS5R
        e+ParkV76/9Vj24yJ50VTHn3vNJX
X-Google-Smtp-Source: APXvYqyA11XvmaPMyrj+e3icWDD6MjchwcTTmPBi4cIuslmaIEot6Wj7FsSdkEyjFeeEl9d6qLQLsA==
X-Received: by 2002:adf:814d:: with SMTP id 71mr8660387wrm.193.1570710933756;
        Thu, 10 Oct 2019 05:35:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2sm9030966wrt.45.2019.10.10.05.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 05:35:33 -0700 (PDT)
Date:   Thu, 10 Oct 2019 05:35:33 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 12:35:31 GMT
Message-Id: <pull.387.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] t1308-config-set: fix a test that has a typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am currently trying to whittle down the number of open PRs at 
https://github.com/git/git, and this is one of the patches I deem valuable
enough (and complete enough) to put through to the Git mailing list even
when the original contributor has gone silent.

Tanay Abhra (1):
  t1308-config-set: fix a test that has a typo

 t/t1308-config-set.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)


base-commit: 70bf0b755af4d1e66da25b7805cac0e481a082e4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-387%2Fdscho%2Fconfig-set-test-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-387/dscho/config-set-test-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/387
-- 
gitgitgadget
