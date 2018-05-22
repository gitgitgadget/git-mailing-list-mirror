Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42566200B9
	for <e@80x24.org>; Tue, 22 May 2018 21:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeEVVQe (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 17:16:34 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44271 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbeEVVQd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 17:16:33 -0400
Received: by mail-wr0-f195.google.com with SMTP id y15-v6so22644576wrg.11
        for <git@vger.kernel.org>; Tue, 22 May 2018 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oUBF8dZ7o3z3wX2e+FGoWUq7BxqdkAjSjUcwKmUH7P0=;
        b=N/SKg1uz0D5RfaX1B283VUOV7sfniLyTltEJb5sDA3uy6Via1zxZwQqDoaf/cxi9qX
         /AJVqztWve8Ni7YvKSlG70TKQyX0ACDE5dQtPiU7heMLu74/I9kZKrDQR7gUr1OvJM6e
         GjGcckRmG7RBOK5Dv1ILxCx7ENXNL1U0wUbESUv7QZ86b80ITpcw/3A6ImEyZaYsOT/F
         1PjuiqZri0KPTOzFEfTqewpafvSF247EdSMS3es181Vdo5FRe5hDVlAVpuhK6quS6mHR
         gmCmrZvjLAdlYaH5kXm/BF+OoVvX0Gxc2f8Rxs1IVcxu0xd4PCcmYs33wux1syTsmxqG
         UJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oUBF8dZ7o3z3wX2e+FGoWUq7BxqdkAjSjUcwKmUH7P0=;
        b=nr0Fvz2OFQjxtsUl9xt5eO8ecbuudhMO7uJQsBYL5/0uNo2ZY52FlUOnEuQYXcNxp8
         g0k9rBdFNzFJ9we9Vhxtc1U8ELjn6lx8lyuGJR1vrVCC0v+fnGocXfJb/aj4K+85L4U8
         uHilV2ti3zbJD5bSFktSGmxuHpFlhiLfsdV+dLuEr31CJxLxHvFP2v10sO7fubvBmjtW
         WbhUpt64+x+PeaEtZYWs7NkKgn4khDmASCcbVbmRcT8pFxNV/jhfrpFLD27aRaQ8HUIm
         Rjh+jtZkWOYLCtPaaP35Wm0lX5KUsvIshpdcKUVpPXytq2jg4ZEErzWkUumBf1J2XOJ+
         U7OQ==
X-Gm-Message-State: ALKqPwfYAvJ0DM2j+iUwcv7k+8mLFLQF4xh2vrCAPBl3G+tNgWRIQ9lq
        bpWNeiHF8hoAp7vsamiMfGgvD88naOE=
X-Google-Smtp-Source: AB8JxZqHzZfP49XYTUN4bJvt5aZ1OagvmflVBuu8JqJn5D+xX3xvdgEw1BYN6AE1ueZGnA4PLLPOEw==
X-Received: by 2002:adf:a104:: with SMTP id o4-v6mr91218wro.106.1527023792549;
        Tue, 22 May 2018 14:16:32 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-64.w86-221.abo.wanadoo.fr. [86.221.117.64])
        by smtp.googlemail.com with ESMTPSA id z66-v6sm941983wme.13.2018.05.22.14.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 May 2018 14:16:31 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Wink Saville <wink@saville.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 0/4] rebase: split rebase -p from rebase -i
Date:   Tue, 22 May 2018 23:16:21 +0200
Message-Id: <20180522211625.23893-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180522133110.32723-1-alban.gruin@gmail.com>
References: <20180522133110.32723-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This splits the `rebase --preserve-merges` functionnality from
git-rebase--interactive.sh. All the dead code left by the duplication of
git-rebase--interactive.sh is also removed. This will make it easier to rewrite
this script in C.

This patch series is based of js/sequencer-and-root-commits.

Changes since v1:

 - Duplicating the correct version of git-rebase--interactive.sh (thanks
   Stefan!)

Alban Gruin (4):
  rebase: duplicate git-rebase--interactive.sh to
    git-rebase--preserve-merges.sh
  rebase: strip unused code in git-rebase--preserve-merges.sh
  rebase: use the new git-rebase--preserve-merges.sh
  rebase: remove -p code from git-rebase--interactive.sh

 .gitignore                     |    1 +
 Makefile                       |    2 +
 git-rebase--interactive.sh     |  708 +---------------------------
 git-rebase--preserve-merges.sh | 1012 ++++++++++++++++++++++++++++++++++++++++
 git-rebase.sh                  |   32 +-
 5 files changed, 1048 insertions(+), 707 deletions(-)
 create mode 100644 git-rebase--preserve-merges.sh

-- 
2.16.1

