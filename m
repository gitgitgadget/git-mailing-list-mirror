Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 854B420951
	for <e@80x24.org>; Fri, 17 Mar 2017 23:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbdCQXAc (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 19:00:32 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33124 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdCQXAa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 19:00:30 -0400
Received: by mail-pf0-f182.google.com with SMTP id e129so4509468pfh.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 16:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n6F3vakUt/t4o+UNCJ+wOAe2yTdNmwF7FV5H0JFRCTk=;
        b=Kja4I52OPZzCca5pIBvtLL3N9n1oC/SgUEbWUqN6g+fPGxyAX9fuB6p6uphCZ7RErX
         PeR2LyfrSDc0FdDvUIYbXT7+Wk4eqBciaPHpkRpPhcaE+zwNpek/EhCervn7VdtVuJFp
         755rxqM/WfWGKMIm6Lz7DW29Kul4R4EYnD3OI2Gjrji6qfo2k6UerUYwli6EdPSw7NIC
         d9rNNYdiUNp7p/eBIgMYF1hkWThOZ4pZW/Y9+P9DJDSjlUYFG0MI80+12eoj4/gmkvei
         TyxcutcPz37GEhOD01EOyxRqS3LDQ86ixKpcvF1w1LUYvgyQopHlLYIKf1xA29kLEXE+
         ZalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n6F3vakUt/t4o+UNCJ+wOAe2yTdNmwF7FV5H0JFRCTk=;
        b=AdyG0rIDeCGVSpM1ypcLAoR9XvqLD/4H+0ZRpAOGjGPb5u6YX0V97+yRRbZYzLQvTE
         jhYoumpSZnLW/1/0gzYczxQJdXRPCS8pa/kDOVTofnxKazjMTJtOE6KNy6zx45gUKoOG
         hrMXKDPx87WKIIPomoAQO9F9/dBPU6DtyxPiRd7IndTvJK7U+6el0ot++n3e9TI4+THg
         XDhoZdweRbsz8yeF6jqR8b6rf729PI8VtgqtZWR/StR4CrUe3ocOD4fAfzbQBVGN/f7x
         mBWmOwCW3T32/oiiBKNSIVKWi5vIP9EArlh5OzZ+KzEAlMQsoboNmo0Erznp/eDmM3cZ
         gJ8A==
X-Gm-Message-State: AFeK/H3fe+MQdGeOMvs8ZtEM4E1gnueeofDxP9CwWGBxeb1+wcgV9xZ74a6n6PZAcsU5QYHv
X-Received: by 10.84.130.67 with SMTP id 61mr23106077plc.115.1489791077802;
        Fri, 17 Mar 2017 15:51:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b43f:d341:41cf:b66a])
        by smtp.gmail.com with ESMTPSA id z4sm18868161pge.49.2017.03.17.15.51.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 15:51:17 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] Documentation/git-worktree: use working tree for trees on the file system
Date:   Fri, 17 Mar 2017 15:51:10 -0700
Message-Id: <20170317225110.13417-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.306.g4a9b9b32d4.dirty
In-Reply-To: <20170317222842.GP26789@aiede.mtv.corp.google.com>
References: <20170317222842.GP26789@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I recall correctly, "worktree" is the feature/command, and
"working tree" is an instance in the file system, even when you only
have one working tree.

Using that mental model, the documentation for 'git worktree list'
clearly talks about working trees, so fix it.

Reflow the lines as well.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Duy, this is my instant-make-a-apatch-to-fix-the-world reaction
 in reply to Jonathan.
 
 Thanks,
 Stefan

 Documentation/git-worktree.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 553cf8413f..e080007ed0 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -58,10 +58,10 @@ as if `-b $(basename <path>)` was specified.
 
 list::
 
-List details of each worktree.  The main worktree is listed first, followed by
-each of the linked worktrees.  The output details include if the worktree is
-bare, the revision currently checked out, and the branch currently checked out
-(or 'detached HEAD' if none).
+List details of each working tree.  The main working tree is listed first,
+followed by each of the linked working trees.  The output details include if
+the working tree is bare, the revision currently checked out, and the branch
+currently checked out (or 'detached HEAD' if none).
 
 lock::
 
-- 
2.12.0.306.g4a9b9b32d4.dirty

