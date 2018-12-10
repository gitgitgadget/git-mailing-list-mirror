Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC77120A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 15:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeLJPKt (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 10:10:49 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:44732 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbeLJPKr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 10:10:47 -0500
Received: by mail-pl1-f175.google.com with SMTP id k8so5371337pls.11
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 07:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=OXSCvWYyshIvn/64/tMkaLB4iPhJeYfQQjtNQm/3/lI=;
        b=IuazdO3EG/EwuMKYDLY+RoxAw2vNOqjZXu28XupLthSFOU+lFRXQ/8ZJG10siqhP2A
         KOaS2/SlFuZRkNS0C2e0mFlFB0nXMxtDcSs516WqsJvNtyA2v9nSJG/bVCI8YLoVO2vH
         SPJ7NP2qmUeREmvr7dLFNdTsGNVh4GFMJiXCR7VXAk8ycqZCqenfn7x+Lc+anSZvdjP+
         SwE30suJvckpEMxiWBNe/SxiUq4xWElTCS+esbspxdPF/NHRh2tI2IH7x05O6QcBem+Z
         GxckKTEV04SH+9+KZgLts1Ldab/+N4KovHoOTwmilSWeCjmN11fbICVOo5lVI4zbvWt+
         oWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OXSCvWYyshIvn/64/tMkaLB4iPhJeYfQQjtNQm/3/lI=;
        b=SspkOIbjSPSp/QLMiB7InkW5q1IT31VYbnuOw3qBv4l/nbMaN8nrMLttf0tZnUyL67
         PatssoFsaE/vrfXbLk8jUmLv7CeP7TVLyaex0Vs4FvejonC7MAeKQnT1t0GUcrGdxDA1
         hvfPs1iyq+bTsPlF1+XWdiKJnZlEgJ0Uc1Lqf45FQ4Pvp8joMy6YkzQNro+fmyaGys7y
         b61nOZ7NiRJFb2F56XB1MgCGOH/qHzZyPr/O9R9HThcAljtAjPGDe/GN/rSl1TQHS7f7
         g1ObJ6t7X5Mho2Xd0IAzLgpGB0naHLi+H6L7Jqnkqitut9UV6gIyIzen8ACQuLlzukm0
         zwUw==
X-Gm-Message-State: AA+aEWY7HGMkD81GRCW3qNffNvkYlMUUjDxE1EcwkJ7IobL+YVl3sxdb
        U1nITo1qMYSrFI2+v+0i0Mu8alXE
X-Google-Smtp-Source: AFSGD/W+yBm0iWLntQXERc3S7f6/XBPvxY1HsQWrbC2WT1e3PwLRmoldBLaL9SPOXa8iTFQu6oFjHQ==
X-Received: by 2002:a17:902:2ec1:: with SMTP id r59mr12622098plb.254.1544454646054;
        Mon, 10 Dec 2018 07:10:46 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id d202sm19768221pfd.58.2018.12.10.07.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 07:10:45 -0800 (PST)
Date:   Mon, 10 Dec 2018 07:10:45 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 15:10:42 GMT
Message-Id: <pull.82.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] worktree: add completion for the rev argument in git worktree add <path>
 <rev>
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

This is inspired by one of those half-finished contributions in the Git for
Windows project. Fall cleaning, if you like.

Johannes Schindelin (1):
  completion: complete <rev> in `git worktree add <path> <rev>`

 contrib/completion/git-completion.bash | 5 +++++
 1 file changed, 5 insertions(+)


base-commit: d166e6afe5f257217836ef24a73764eba390c58d
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-82%2Fdscho%2Fcomplete-worktree-add-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-82/dscho/complete-worktree-add-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/82
-- 
gitgitgadget
