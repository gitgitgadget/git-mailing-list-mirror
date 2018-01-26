Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A00431F576
	for <e@80x24.org>; Fri, 26 Jan 2018 09:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753126AbeAZJzb (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 04:55:31 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41228 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752980AbeAZJz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 04:55:27 -0500
Received: by mail-pf0-f195.google.com with SMTP id c6so7977398pfi.8
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 01:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oE2ypPBH2Vm4PMeG8P10JQGnSeKhETvbvc7iCDiQw/s=;
        b=AWUtaOUjlJ1Mv/a7gKEyzDOOtT4Ft2PmB1rOzkD0+IwP+Kzat0dA5gJBZ2HXREMyLF
         h0TpcVPdynwZr7/nTM0ATHDyVW/WRQvF4h9VawzhUkqtx8bY9rCuEFM3zl2+sL/QSPMD
         B069HnC26FhmzOCK3wcHHePAl0Q9K7BqNSAG1k/rK3HlUpPtofsLlHJKmIGoWwDyQh9s
         7WnquoLzD/dWTbSgFIsAKXNCIBmE84eX/wfT7bBqEWTHKXnc9E6DWIwe6pSiOQY4GWg6
         6b3OfJhX0RMVPenJsoHChwfxPbaxE1QWYqbUYKKtqvDqiFBY/7g6zN8lxNR4BC1Sw0k7
         RNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oE2ypPBH2Vm4PMeG8P10JQGnSeKhETvbvc7iCDiQw/s=;
        b=HyyX/NquOLHMZS3SByACm1hujto4CjvJJrWd7Aiv7TDH+I4sfJtf7rpOTxBRAr0t76
         F2zb4jW8+vmg/KEbwLaZmZ35BAM7C/jJiX8vlKI8ntEZ6bIB414JoMpWmdaJI+AXRGlL
         4Km8lwZbd46IxpUKYGQ0BUtGE1/+1ziZw5aqE8TKfG+M73oKKZAUGUy9Wc2066sfxjRQ
         SSTvItIDCmQu6kEUftsOMRAqI+u6cfZ/AvcImG5GK7m4J7Wk5/mrxx5OXehptRn1djrY
         wJ72s9wE0rrmIFDYj5ZL1lfJHjJ/7mX5a8NTw3DwIYr0f/Vh62dxgXErtb3FiP5giwT0
         6MGg==
X-Gm-Message-State: AKwxytfegnvxN0Y83s1AGr9wt2k2nwRpk7XqU+Yggn1UvfIkf7MROZSX
        VzrYWXnbeGaVNO4KEX7msso9Ag==
X-Google-Smtp-Source: AH8x226WcRlyKzsQq5eu0sLhZiABSSiJAiIN05bmAIK+bW6ZujQj1SA84Luz9Gaeuk/1PhwAWbhS7w==
X-Received: by 2002:a17:902:6115:: with SMTP id t21-v6mr14366459plj.322.1516960527175;
        Fri, 26 Jan 2018 01:55:27 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id m65sm21680546pfc.150.2018.01.26.01.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2018 01:55:26 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 26 Jan 2018 16:55:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/2] Add "git rebase --show-patch"
Date:   Fri, 26 Jan 2018 16:55:18 +0700
Message-Id: <20180126095520.919-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a conflict happens during a rebase, you often need to look at the
original patch to see what the changes are. This requires opening your
favourite pager with some random path inside $GIT_DIR.

This series makes that experience a bit better, by providing a command
to read the patch. This is along the line of --edit-todo and --quit
where you can just tell git what to do and not bother with details.

My main focus is "git rebase", but because rebase uses "git am" behind
the scene, "git am" gains --show-patch option too.

There was something more I wanted to do, like coloring to the patch.
But that probably will come later. I'll try to merge these two
21-months-old patches first.

Nguyễn Thái Ngọc Duy (2):
  am: add --show-patch
  rebase: add --show-patch

 Documentation/git-am.txt               |  5 +++-
 Documentation/git-rebase.txt           |  5 +++-
 builtin/am.c                           | 23 ++++++++++++++---
 contrib/completion/git-completion.bash |  6 ++---
 git-rebase--am.sh                      |  3 +++
 git-rebase--interactive.sh             |  4 +++
 git-rebase--merge.sh                   |  4 +++
 git-rebase.sh                          |  7 +++++-
 t/t3400-rebase.sh                      | 34 ++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh          |  6 +++++
 t/t4150-am.sh                          |  5 ++++
 11 files changed, 93 insertions(+), 9 deletions(-)

-- 
2.16.1.205.g271f633410

