Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B43D1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 03:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeCCDja (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 22:39:30 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38410 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbeCCDj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 22:39:29 -0500
Received: by mail-pf0-f194.google.com with SMTP id d26so4816149pfn.5
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 19:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJz7mVRxhzQWWUmY2VKUxiDi3HsGM0cUBxYxgx3CYYw=;
        b=U76JqdwZ1n4gey+gB8J8WmdECbhymVRqrpyHp5dGlc6EJjIV+x+pXZ8bJ/hRT/B6gq
         GWuzc613BlHnD6unjp1Oa5lnSNfOzakAzgEg5OVYyqdoLlwM08HM330KjgTiguDr/L+p
         lzCxz2iVmJPBL/izkglmB9FYMiPPuln1J19nHAELwu6sBSHTmPsEY8VY/gbm/yIV+fG7
         SsOErmSloDHN1eXa6xX33ttK6Ey+5+lQd752TbFMVA9r3b2xNt0hBfM9tnCHJy+aAGqP
         V6pYouo+NEST2t5iqgmf153+XlYy5SHCh9y9mjnUeLzQYx17ci0EtRQWCCkXePTLHUYR
         2uSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJz7mVRxhzQWWUmY2VKUxiDi3HsGM0cUBxYxgx3CYYw=;
        b=KkCmJgnFzq3nM4toYZULCzq0WryIH4qHI0ht8iLEzZKAwJ02Rffi2eJOsNzjivXBmN
         Mto4oG3XxpYhplAUV8NRPmDMOtTp6AbKyqko93Tpbj7OUDCDcKBXfBlODzdEDPUwR1gS
         waoK+PAtA0Py4nrrKdsdfgWulTqFdP0Q9uoZ1J5Z3PudyvEdd0C26C3kEQXfOduJxyQx
         IU9x8SxOb6OAaz+qmZG/SN4K22+x18dYc8rUu1GmiEMe3lgQB44M7mcIC73g/ig8UJ7b
         vhKAPmVkbbjp5ntlDyqojSHIObjwjKQRHBpddWBwkLMlUnknxzDdXU41Qix1HJQmm9xb
         OMpA==
X-Gm-Message-State: APf1xPADnY+wrsjDnqTgrX6ZOGv/l1XGZl2K2LTDPZ0OobYfIa8iQWG3
        omysEViTnWo5+gpYAF/dAb9MFg==
X-Google-Smtp-Source: AG47ELve3xZzFCU7HWIWnMNwiUEjmhJS6H8shaZ3R0qW4rC7KbFPB/s6/YWJaMRZsvtM0hvishxnXg==
X-Received: by 10.101.82.69 with SMTP id q5mr6188987pgp.259.1520048368873;
        Fri, 02 Mar 2018 19:39:28 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id j23sm1843412pfi.78.2018.03.02.19.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 19:39:28 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 10:39:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/3] gc.txt: more details about what gc does
Date:   Sat,  3 Mar 2018 10:39:16 +0700
Message-Id: <20180303033918.15751-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303033918.15751-1-pclouds@gmail.com>
References: <20180303033918.15751-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-gc.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 571b5a7e3c..862c931104 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -15,8 +15,9 @@ DESCRIPTION
 -----------
 Runs a number of housekeeping tasks within the current repository,
 such as compressing file revisions (to reduce disk space and increase
-performance) and removing unreachable objects which may have been
-created from prior invocations of 'git add'.
+performance), removing unreachable objects which may have been
+created from prior invocations of 'git add', packing refs, pruning
+reflog, rerere or stale working trees.
 
 Users are encouraged to run this task on a regular basis within
 each repository to maintain good disk space utilization and good
@@ -59,6 +60,10 @@ then existing packs (except those marked with a `.keep` file)
 are consolidated into a single pack by using the `-A` option of
 'git repack'. Setting `gc.autoPackLimit` to 0 disables
 automatic consolidation of packs.
++
+If `git gc --auto` goes ahead because of either too loose objects or
+packs, all other housekeeping tasks (e.g. rerere, working trees,
+reflog...) will also be be performed.
 
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
@@ -133,6 +138,9 @@ The optional configuration variable `gc.pruneExpire` controls how old
 the unreferenced loose objects have to be before they are pruned.  The
 default is "2 weeks ago".
 
+The optional gc.worktreePruneExpire controls how old a stale working
+tree before `git worktree prune` deletes it. The default is "3 months
+ago".
 
 Notes
 -----
-- 
2.16.1.435.g8f24da2e1a

