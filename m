Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4569220248
	for <e@80x24.org>; Sat, 23 Mar 2019 15:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbfCWPZ3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 11:25:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45679 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfCWPZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 11:25:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so2624799pfi.12
        for <git@vger.kernel.org>; Sat, 23 Mar 2019 08:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rfHlD13kZp+jsVWNWLz1j4zqLINbDKw87f2UfgFr+CY=;
        b=nLLNhZF5dm7d3P69Uenjdf5tqbQGcq8aSQ5t5L1ViQTLpu+jfOSDwVZfPx/zVrUuiH
         ePSpqOXelbLCfYZwMoMfK48fdxQhdSu5etVyqz84dCDi/HnQhzPFvx+POVbCjObH2Cvu
         52BsyjQuQLwRJ9x2/m5JsTSqJpapFgXPQHwHpU6yF37S4+OKPCjk3elU0p/Tgq/1z8db
         zijqz/BuTnvC4OvVFI4hW4MUC+YthjNAB7FSLIkFKa2pk5jMPo3COUagT86TpULKFJMN
         iyV8TqFdh8pMcZbQf8uXgBfIa+f5JJ6RkItEzcCdVq4I9dw16bobZ3snDHU0sirdZO2k
         AABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rfHlD13kZp+jsVWNWLz1j4zqLINbDKw87f2UfgFr+CY=;
        b=GFQ9fqIR53Lq2BNpSyad2yc85GJruO5ecoshS/s7AgnDXFMuhhB9F3g3115BYq/x+T
         sxWO+A9dvgVpGpmN4lB+nLIaBBdYA0M/SQQkB0iB9P8k2F4Sfh+eArkYDdrDvxYR1sBa
         W6S9ouTMrULFp5/eQOuW05i4uavm+qU1QNyF1MDN4S8wKrDIOdlIwdLv+2Wi3LcSIq+P
         nYvy3Hl/5XkDWolnlCCtINO8EnPb0Glwujd0A9dlxe+GYm0nP8leesqUVMjLuj3N4bfb
         3tk9ea2qFaz2xkZ3cnQ0g8iuofJcUF2dz1hen8fc7sTiEOazPbOxQT1Cw7/o46s6U0w3
         srJw==
X-Gm-Message-State: APjAAAWk4x1qXjUNXxe8r4CRik1jQSivSJ2G9n4zkZuv0x3ch/z9YPaW
        Ze74LDSKxYAIPKBlHEwcuiw4VBLo
X-Google-Smtp-Source: APXvYqzvOs6+AEO4yVHp6tcTnTZ4uss7aooOMqgORSWGHTyGQ4fBA6Grq/sHn8ijB+zKl0MmE6PVjQ==
X-Received: by 2002:a65:538b:: with SMTP id x11mr14162956pgq.35.1553354727908;
        Sat, 23 Mar 2019 08:25:27 -0700 (PDT)
Received: from archbookpro.localdomain ([172.56.17.211])
        by smtp.gmail.com with ESMTPSA id p86sm20926786pfa.104.2019.03.23.08.25.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Mar 2019 08:25:26 -0700 (PDT)
Date:   Sat, 23 Mar 2019 08:25:22 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/3] rebase: learn --keep-base
Message-ID: <cover.1553354374.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series teaches rebase the --keep-base option.

'git rebase --keep-base <upstream>' is equivalent to
'git rebase --onto <upstream>... <upstream>' or
'git rebase --onto $(git merge-base <upstream> HEAD) <upstream>' .

This seems to be a common case that people (including myself!) run into; I was
able to find these StackOverflow posts about this use case:

* https://stackoverflow.com/questions/53234798/can-i-rebase-on-a-branchs-fork-point-without-explicitly-specifying-the-parent
* https://stackoverflow.com/questions/41529128/how-do-you-rebase-only-changes-between-two-branches-into-another-branch
* https://stackoverflow.com/a/4207357


Denton Liu (3):
  rebase: teach rebase --keep-base
  t3416: test rebase --keep-base
  git-rebase.txt: document --keep-base option

 Documentation/git-rebase.txt     | 12 +++++--
 builtin/rebase.c                 | 25 ++++++++++++--
 t/t3416-rebase-onto-threedots.sh | 57 ++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 6 deletions(-)

-- 
2.21.0.512.g57bf1b23e1

