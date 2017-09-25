Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F850202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 19:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935851AbdIYTKQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 15:10:16 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:54737 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933306AbdIYTKP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 15:10:15 -0400
Received: by mail-pg0-f50.google.com with SMTP id c137so4521436pga.11
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LNbv4zbVTKpvOEkG+ZlpYDGKaqhgUkUDK+P/mPJrcBs=;
        b=Md65xUM66FfDw+GhEG0pyXPxWAEsfj+GLtSS2PW+4uhokU+N+wC5bDv0tbjbe0FMB9
         1hvmXvE4xh99jebHtTbwkRxCqMlSYHP7bLbO8XksliooJTcdEJc8GPfzCVyIhT5mAAvH
         Qi10mr7cRFEQOA6gjGkLTumchZp7CEelk/Xkgp9KFSMKuEUmxlSB/CkdDI47K2HReYk4
         8OixWFbFkmhAZiNy7x1uAU84FTLJg5xCGRqgrOYwLMz/NwXQhco0WIvQEBzPggCKBlUr
         wwBZYFk5lonHAyOnYTWYRZBxx1AQGNIb3LrPNn7RD6Rj1i5GGtaIMV71KN9Work10ZRv
         dFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LNbv4zbVTKpvOEkG+ZlpYDGKaqhgUkUDK+P/mPJrcBs=;
        b=kBuBp8eqR7Qx5Ep7oDuuGQn4H4Sp3O/iNghMro8czFZK9cyUu1TyusI762F9+YNY9w
         qz9R9MyZUgn5+e2wXn8od1D5lmyBM4KQhmNbHwHeaMddxpFGSTx8G8xVeC4yaQPBpNBU
         QHYNQhrDeA6+db2xFLHTO87OzgAe/4Zb+t/fupBCtGfCtQVatJ/hn5TjSTyL9+p2rzpM
         yyfSlom7zUdQjoBQnGPg2ElizlU3xsouWTHafLWrUawBJgNnGFe497z6jJ7XBSZQqddY
         Xq7GVhQksJRJtr1K/+IB+tDeuo2+W4YjEqK69ZPtQxUhXoOXr3Lq+Xut5x5nj91jZOIQ
         qBPw==
X-Gm-Message-State: AHPjjUjKaZgGeMoxHj96yBYz4AvJ+6fvu2r/7YdbmZsLVOsddKlSqqyf
        nBs5aOmQ6mH6IJUCvPS/PArPFQd1MkM=
X-Google-Smtp-Source: AOwi7QAiFMx4AYj2dJdK4SQW6dNOodpCV3nJsQ61/81ABrztMwqPGPGMb4HcoVYnLfJt59s5c/WBmw==
X-Received: by 10.101.78.131 with SMTP id b3mr8684838pgs.28.1506366614426;
        Mon, 25 Sep 2017 12:10:14 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6810:20db:ec03:dc8a])
        by smtp.gmail.com with ESMTPSA id t17sm12242398pfl.61.2017.09.25.12.10.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 12:10:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com
Subject: [PATCH] Documentation: consolidate submodule.<name>.update
Date:   Mon, 25 Sep 2017 12:10:11 -0700
Message-Id: <20170925191011.29863-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <xmqq1smxj7md.fsf@gitster.mtv.corp.google.com>
References: <xmqq1smxj7md.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have one place to explain the effects of setting submodule.<name>.update
instead of two.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
>> I disagree.  Actually, I think the git-config(1) blurb could just
>> point here, and that the text here ought to be clear about what
>> commands it affects and how an end user would use it.
>
> I tend to agree with the consolidation.

Something like this?

 Documentation/config.txt     |  9 +--------
 Documentation/gitmodules.txt | 20 +++++++++++---------
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1ac0ae6adb..0d5a296b6c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3085,14 +3085,7 @@ submodule.<name>.url::
 	See linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
 
 submodule.<name>.update::
-	The method by which a submodule is updated by 'git submodule update',
-	which is the only affected command, others such as
-	'git checkout --recurse-submodules' are unaffected. It exists for
-	historical reasons, when 'git submodule' was the only command to
-	interact with submodules; settings like `submodule.active`
-	and `pull.rebase` are more specific. It is populated by
-	`git submodule init` from the linkgit:gitmodules[5] file.
-	See description of 'update' command in linkgit:git-submodule[1].
+	See `submodule.<name>.update` in linkgit:gitmodules[5].
 
 submodule.<name>.branch::
 	The remote branch name for a submodule, used by `git submodule
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index db5d47eb19..d156dee387 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -38,15 +38,17 @@ submodule.<name>.url::
 In addition, there are a number of optional keys:
 
 submodule.<name>.update::
-	Defines the default update procedure for the named submodule,
-	i.e. how the submodule is updated by "git submodule update"
-	command in the superproject. This is only used by `git
-	submodule init` to initialize the configuration variable of
-	the same name. Allowed values here are 'checkout', 'rebase',
-	'merge' or 'none'. See description of 'update' command in
-	linkgit:git-submodule[1] for their meaning. Note that the
-	'!command' form is intentionally ignored here for security
-	reasons.
+	The method by which a submodule is updated by 'git submodule update',
+	which is the only affected command, others such as
+	'git checkout --recurse-submodules' are unaffected. It exists for
+	historical reasons, when 'git submodule' was the only command to
+	interact with submodules; settings like `submodule.active`
+	and `pull.rebase` are more specific. It is copied to the config
+	by `git submodule init` from the .gitmodules file.
+	Allowed values here are 'checkout', 'rebase', 'merge' or 'none'.
+	See description of 'update' command in linkgit:git-submodule[1]
+	for their meaning. Note that the '!command' form is intentionally
+	ignored here for security reasons.
 
 submodule.<name>.branch::
 	A remote branch name for tracking updates in the upstream submodule.
-- 
2.14.0.rc0.3.g6c2e499285

