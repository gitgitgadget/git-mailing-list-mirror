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
	by dcvr.yhbt.net (Postfix) with ESMTP id 222C91F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 18:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfJJSgw (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 14:36:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41933 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfJJSgv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 14:36:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id q9so9100932wrm.8
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 11:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=L+geB88FXh5lyya9mWaT1PY2hcsJCbVX3lGurNfqWyk=;
        b=S/9AjV6meTSmbm5n83dPzGz2KVlX85+2Hlx0L21GflbMUjFawlFM+xOEkON9gI9M7/
         hW1wgYzbvoSWYv40mRuSQuE6YOsWGWY+tYZIt4gyA/fLP9p8a6puu2ChtfvldIsfYpcn
         22+t5tqKVwGJDEwJWkRaSWy3s6iapvp3JMuZ5YPnIb+QOMVp/rob9h+tNT8owzCkJsW7
         F+L8KRG1//iJKQ/KjBawBeLXZzTgDOS3cIOdL3X8q9Js9lSzCPMUhxyZhiwZGhVharDR
         jpyhnTinnIOl2C3pWe1E5DniYSUQ8pOYdR7QsBH+SGZSaRQtLNk3tFn6YS1V8gjpn7bV
         vrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L+geB88FXh5lyya9mWaT1PY2hcsJCbVX3lGurNfqWyk=;
        b=KqipI2y7vMCWgUNh6nhdR+wf79zy2BgX2iAQP3QZPz6BZ+LjbAfKUgbib5OsXU3f2L
         Qi3Yp4kx4L+otLqRfmpQ6OitfGnjY0R0fGBYQa7mTKS/kMgzTRTyUdeK5BN5QgLS6vH9
         Ot0o3Wq8qCzyWozNqn5Yf9XtfnbGjRoqp+GOlkhttp/oZ3cOKRh5sYAH2zcVbv1b6J5I
         mn7/R+U1fqpeNF7zt1lu6lN1ZSKFw2Rb2xSo0i8XLyaXbXdnkv4i8WSe21vDj7hmdBMU
         ImIl17Z/2LJXgjbQH2VyMGEIWl2IGq0kSB9i5xqv3bHmhEbPtc5p4mpgY/If7ZvZgO9M
         o4bw==
X-Gm-Message-State: APjAAAXy4ASEQggCcELKu/DDO+h4/XYve/rtvzgwqjefVzXbwYvnGPNj
        6FxBQ02Hb6WAi1N4htWVhDY9RIaW
X-Google-Smtp-Source: APXvYqxnHPNnDMJ9JDUY9CJ/3edNnVhNlOtnNCZe1ZPR48j964JXdstHXWFKXZPhpm3DJ/NCDl4uAA==
X-Received: by 2002:adf:df0e:: with SMTP id y14mr10211025wrl.312.1570732609756;
        Thu, 10 Oct 2019 11:36:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm6582806wrv.66.2019.10.10.11.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 11:36:49 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:36:49 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 18:36:45 GMT
Message-Id: <pull.388.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] sequencer: start running post-commit hook again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I converted the sequencer to avoid forking git commit i forgot about
the post-commit hook. These patches are based on
pw/rebase-i-show-HEAD-to-reword, otherwise the new test fails as that branch
changes the number of commits we make.

Phillip Wood (3):
  sequencer.h fix placement of #endif
  sequencer: use run_commit_hook()
  sequencer: run post-commit hook

 builtin/commit.c              | 24 +----------------
 commit.h                      |  3 ---
 sequencer.c                   | 50 +++++++++++++++++++++++++++--------
 sequencer.h                   |  6 +++--
 t/t3404-rebase-interactive.sh | 17 ++++++++++++
 5 files changed, 61 insertions(+), 39 deletions(-)


base-commit: b0a3186140dbc7bd64cbc6ef733386a0f1eb6a4d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-388%2Fphillipwood%2Fwip%2Frebase-commit-hooks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-388/phillipwood/wip/rebase-commit-hooks-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/388
-- 
gitgitgadget
