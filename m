Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1CD91F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 18:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754273AbeGHSB0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 14:01:26 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46976 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754230AbeGHSBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 14:01:25 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so4966080pld.13
        for <git@vger.kernel.org>; Sun, 08 Jul 2018 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bji98rVYcJqyYuYVvaVo4OR86M+OWGxXlca3aI2NKQc=;
        b=ug0LfAPrhRWkwrCzHHH9l6rUgg5Qiocpoo6oz+Sj/CllUL9z7CZ/jK7xOedHe+ojC1
         sEJQHdtoEia/j+co7YyEcY2Xx6Urw1yMUIMwKfUKtZoxO86/p7dQAZQyPgrUCI8rck1T
         sJfzr+/HWMJDPfVuI0IHZKhuen7pvg05NaLHMOF2INGaWyNh1ooWZQrws9cpUNw6cA9x
         Ph/34lrYwIqTjeITcyCENHi3uKbDVcN1B894s4kuO5MajhbA3S/2Yf9Rlmsq1Ufha/Rp
         KP48pEhnENHYqjmadJwKFGx3d6SQrcT+qEd6lQBkiX4xHIJt3yyzr67fu4jeG95uCVvW
         Ln0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bji98rVYcJqyYuYVvaVo4OR86M+OWGxXlca3aI2NKQc=;
        b=Ai+Vl8D+zjYVSIVD/NT90uNyLEhOsDC5E6jD5EOd4WYpJYUJCiwhUflXQEacMdR3am
         LLnvGLauZy77478KaJ3qMuaiQaNIK5AyvFZWdIO1AEWKwDNJgVmWoVRNmkkrI5Ac53d1
         f+Hh7ESYd0R3S3+HN7yS8Wh43lBEmlg1cSxA1eC1P5Wojz+ZoNYhZuQfrtnBVFaln1Tb
         fiHOZlPXPSqVf+EBcnzImz9pVM8sxs5gbzeyqoUMDWeFrm3EFQdE1ei/XaMf9EA+XFLu
         RyOfF3ALiwGdh00+/y/8W4GDbsBsS1P4opWw6fz9RzaZKwsxX8zAGz+EBm7wVvCKYEdj
         KDwA==
X-Gm-Message-State: APt69E2XtUp06gEGYtJcfe28kJSmEV4C/Dj2JzacpAmFjBfxRFozEoF9
        q0jMESZloJxPlwsta7ou7z1q1b3nBh0=
X-Google-Smtp-Source: AAOMgpf0yunuAJNx3l19kokw/hTyr1uS+ON/v8hjfBN6b1WTm2R4kF6WXbn9EFazC9O14Dr1RI0GYQ==
X-Received: by 2002:a17:902:7b94:: with SMTP id w20-v6mr17692892pll.280.1531072885017;
        Sun, 08 Jul 2018 11:01:25 -0700 (PDT)
Received: from localhost.localdomain ([27.34.68.75])
        by smtp.gmail.com with ESMTPSA id u13-v6sm18019149pgr.36.2018.07.08.11.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 11:01:24 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     Pratik Karki <predatoramigo@gmail.com>, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        alban.gruin@gmail.com, gitster@pobox.com
Subject: [GSoC] [PATCH v4 0/4] rebase: rewrite rebase in C
Date:   Sun,  8 Jul 2018 23:46:00 +0545
Message-Id: <20180708180104.17921-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
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

Changes since v3:

  -  Fix commit message of `rebase: start implementing it as a builtin`.

  -  Acknowledge Junio's style reviews.

  -  Acknowledge Johannes Schindelin's review.

Pratik Karki (4):
  rebase: start implementing it as a builtin
  rebase: refactor common shell functions into their own file
  sequencer: refactor the code to detach HEAD to checkout.c
  builtin/rebase: support running "git rebase <upstream>"

 .gitignore                            |   2 +
 Makefile                              |   4 +-
 builtin.h                             |   1 +
 builtin/rebase.c                      | 292 ++++++++++++++++++++++++++
 checkout.c                            |  64 ++++++
 checkout.h                            |   3 +
 git-rebase.sh => git-legacy-rebase.sh |  69 +-----
 git-rebase--common.sh                 |  68 ++++++
 git.c                                 |   6 +
 sequencer.c                           |  58 +----
 10 files changed, 446 insertions(+), 121 deletions(-)
 create mode 100644 builtin/rebase.c
 rename git-rebase.sh => git-legacy-rebase.sh (89%)
 create mode 100644 git-rebase--common.sh

-- 
2.18.0

