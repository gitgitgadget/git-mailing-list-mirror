Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBA501F516
	for <e@80x24.org>; Mon,  2 Jul 2018 09:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933098AbeGBJQZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 05:16:25 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39225 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753506AbeGBJQY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 05:16:24 -0400
Received: by mail-pg0-f65.google.com with SMTP id n2-v6so6866502pgq.6
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 02:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vjwyayo4bmWLx18kWgh+xvdkhH1i1Mm4ZXtMMzMegNE=;
        b=T+CFuKIPdHCy15MQRDxGO4pRCtU2ah3qzFMAdNqkGjjpLTJ4k+fYU3bHwkvNeM0P14
         nhR57/0G5SuJgui6kcEnULl59Ym348tq0IoTN2GlHWdx8KgALUdcUMZgsW8sx2N/p1+b
         Zhp6t5DBRw9v1PQvbyqcQt7TPBUh86TYOX4MXzUVLrjwGsR93pFW6m5GabbIrWTJ2rIR
         65EU5HfOegDsvhZyWqhUAA8Y4eDtchdcO35n382hmm4hrvbm7IoCkqgabfwgAdeAs2gh
         bsul39IIPQlRzOISZjLTUoOeshLXfJ7TI8rOspiZkfSRaYi7twGpN288yZufW5lfQpew
         afkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vjwyayo4bmWLx18kWgh+xvdkhH1i1Mm4ZXtMMzMegNE=;
        b=YQ8BHXHCMIAoIC1lqO6tr3urn2CJs7BES7lpOez7D4PGvhha1U/NNBETQhjtu7F6nH
         MMvwkKDDojGJgOiqpyy431wMU+FvBUE/fkfQFLRERpAMcBI0GHxvY05GGH4Z43ZjY+Le
         cmbjLpDRmwnn/YC5btI2jDT1fLX4E1vco+opRwxDjvRSqh+wlxlVE4A6QCOlnoHMISZx
         HEnvzotQRz7A9RSCg5+a/503DOdN1nDFGtQbBRA5dB2pfV7VFZdvwIl4T48J7IxrnA9j
         x/ukQ4d+9beSL2seMBMnmCIAyOTZp4x/a3tt1JCz8Du3Zo5h9kuTtuDIn6F1T4+ZiVef
         3uPQ==
X-Gm-Message-State: APt69E0yngT3XyBbqoxk8vNAvpEYNALDl9l1oVX7/WHTOweWNiCmOeSJ
        pTCdtkym7Pwikg/oFTh9u0+P2XVEykg=
X-Google-Smtp-Source: AAOMgpdHyvDaVClLrccYNBdsEr69iHFdXI8NDgw6PqFLF9VM886pm/FxGbfQ/3itpcYkH2Zp3JQXAQ==
X-Received: by 2002:a62:4395:: with SMTP id l21-v6mr24817958pfi.196.1530522983358;
        Mon, 02 Jul 2018 02:16:23 -0700 (PDT)
Received: from localhost.localdomain ([27.34.68.63])
        by smtp.gmail.com with ESMTPSA id y2-v6sm35961795pfk.82.2018.07.02.02.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 02:16:22 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [GSoC] [PATCH v2 0/4] rebase: rewrite rebase in C
Date:   Mon,  2 Jul 2018 15:00:05 +0545
Message-Id: <20180702091509.15950-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628074655.5756-1-predatoramigo@gmail.com>
References: <20180628074655.5756-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a GSoC project, I have been working on the builtin rebase.

The motivation behind the rewrite of rebase i.e. from shell script to C
are for following reasons:

1.  Writing shell scripts and getting it to production is much faster
    than doing the equivalent in C but lacks in performance and extra
    workarounds are needed for non-POSIX platforms.

2.  Git for Windows is at loss as the installer size increases due to
    addition of extra dependencies for the shell scripts which are usually
    available in POSIX compliant platforms.

This series of patches serves to demonstrate a minimal builtin rebase
which supports running `git rebase <upstream>` and also serves to ask for
reviews.

Changes since v1:

  -  Remove the TODO-rebase.sh which shouldn't be merged into `pu`.

  -  Add newline at the end of the file `builtin/rebase.c` in
     `rebase: start implementing it as a builtin`.

  -  Fix unintentional ordering in `git-rebase--common.sh` and fix the commit
     message in `rebase: refactor common shell functions into their own file`.

  -  Fix wrong expression of `argc` in the handle upstream loop, fix wrong
     type casting code, make the condition simple and fix commit message in
     `builtin/rebase: support running "git-rebase <upstream>".

Pratik Karki (4):
  rebase: start implementing it as a builtin
  rebase: refactor common shell functions into their own file
  sequencer: refactor the code to detach HEAD to checkout.c
  builtin/rebase: support running "git rebase <upstream>"

 .gitignore                            |   2 +
 Makefile                              |   4 +-
 builtin.h                             |   1 +
 builtin/rebase.c                      | 282 ++++++++++++++++++++++++++
 checkout.c                            |  64 ++++++
 checkout.h                            |   3 +
 git-rebase.sh => git-legacy-rebase.sh |  62 +-----
 git-rebase--common.sh                 |  61 ++++++
 git.c                                 |   6 +
 sequencer.c                           |  58 +-----
 10 files changed, 428 insertions(+), 115 deletions(-)
 create mode 100644 builtin/rebase.c
 rename git-rebase.sh => git-legacy-rebase.sh (91%)
 create mode 100644 git-rebase--common.sh

-- 
2.18.0

