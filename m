Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83BA81F462
	for <e@80x24.org>; Mon, 17 Jun 2019 09:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfFQJRM (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 05:17:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33345 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfFQJRL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 05:17:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so4043222wme.0
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 02:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=5Ts/9HSyIBX7Eca7aMdbZ/S2AbTkKvOMLJYz8D1JQ4o=;
        b=R73MBiMkRFudbkfEQvz2JThzVi3KCSyHQMt6dCfcaVpSqAUZSfaGQoMJ19MKPE1E7z
         Bm7lFuectQGZcANPRxQ3XrWb6+8N7pKwLGCCKaKkWkDE782kDltWsLO9I/p2JddsDqMc
         XHT/xb0VKByCUJPAvURyAYjcs2OFBlBAkdFtyWbCAugGtDf1EAazNLTGCBkXGvs+u8UH
         cyi2S0cfj/oVnKZBkJcvp1emKDd8QM3lbtyJw6KqT4Qz3ybBKnrVqkuSYtoNUSJE4F4W
         cmuB64hvX8qXeK537vFY0GoxhBcKdtA/VdSDwY9CyJ1d4s8vzckB0yv3A3uDqGDAR5b9
         wjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=5Ts/9HSyIBX7Eca7aMdbZ/S2AbTkKvOMLJYz8D1JQ4o=;
        b=uAC0MLcCl4pMm1/Db6jgRclJhLNTVl0fKXgSmx+O8GAvkq5XuR20vjzKGJpmg0vEql
         gUpoPekJJuN1tBLD4a2dG+ITjAZtgywm5bvqpTkoBv2t43YCD7P6k8urLuW1udNKAWsA
         FsOmGRc3i+zncA5wvq2+uY7eiSp0/Wpc7Q4fgnwu/D/8zI2iKnwEdFLguFU3nPWSgMuc
         ucXbShuqM5TKzu+A7jOGOq2UT7ApWpomiJzRtTB/Ck8jp4TOW7U/i+nkOGmg19Gy80RP
         qeS8YvtJ09LvbyuJvPr131BM3KJF9HUUqNhV9S/H62Pr5v4CylfR2O/PX9oySB28/4fP
         N75Q==
X-Gm-Message-State: APjAAAVdUx8FGX6HLU+p3ayHTvtSbceXO4RJBH50XYqzNF1V8X3Mj9ra
        QjYn47TSZLrgb7ezGL72jbg=
X-Google-Smtp-Source: APXvYqxq4vhgAITcfoptC/KHMQY7AGoAEKWxa1rGA73A/IYtATC4gjGsWUY4uvFZq3DcJSFBkUl/vw==
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr16632990wmc.16.1560763030392;
        Mon, 17 Jun 2019 02:17:10 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id l124sm16322890wmf.36.2019.06.17.02.17.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 02:17:09 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2] show --continue/skip etc. consistently in synopsis
Date:   Mon, 17 Jun 2019 10:17:09 +0100
Message-Id: <20190617091709.5785-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190616132457.19413-1-phillip.wood123@gmail.com>
References: <20190616132457.19413-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The synopsis for am shows the command mode options as
    (--continue | --skip | --abort | --quit)
They are on a single line and in parenthesis as they are not
optional. Fix the merge and rebase docs to match this style.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    This patch is based on top of nd/merge-quit.
    The docs for cherry-pick/revert are updated to this style by
    https://public-inbox.org/git/20190616082040.9440-1-rohit.ashiwal265@gmail.com/T/#u

 Documentation/git-merge.txt  | 3 +--
 Documentation/git-rebase.txt | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index b7d581fc76..926ea4f460 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -13,8 +13,7 @@ SYNOPSIS
 	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
 	[--[no-]allow-unrelated-histories]
 	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
-'git merge' --abort
-'git merge' --continue
+'git merge' (--continue | --abort | --quit)
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 5629ba4c5d..a67d40596a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	[<upstream> [<branch>]]
 'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
-'git rebase' --continue | --skip | --abort | --quit | --edit-todo | --show-current-patch
+'git rebase' (--continue | --skip | --abort | --quit | --edit-todo | --show-current-patch)
 
 DESCRIPTION
 -----------
-- 
2.21.0

