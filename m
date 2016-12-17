Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0773C1FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758270AbcLQO4d (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:33 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:36762 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758072AbcLQO43 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:29 -0500
Received: by mail-wj0-f193.google.com with SMTP id j10so18023171wjb.3
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=okjDcRr0JfcE7YBDN7mQ6NR8rOH6ziWNSaZ1l92Unxg=;
        b=hMuCQR24qyIChB5x11LchprSqqlRfvq8u1yA+ptAAKfbHXTixwBDP/m/+g7125Tl3I
         IGNYRZeh6ZwrVNsSlY1YK4vWJKaA2GRmgKmdyevJIAGKChj5ndSI7uxIrMDx4CFGwZFV
         wbAw5FsSMEiCgfaSN3kqxp6D7+hSZydUNnjKyUt1f1r4xrzszTOpEHkEUuw9fB34AMbc
         rhASInaLnOmY4CZv8gqO5oAv/6rAk3QAQ9k+IdCgZosAg7unne01KelAqgpzPNgiOshA
         yr8xENRF25GxpOVibTZprK2XVUG4ZYDzl3tJPRFTYDdr8FaWQ++TASf19OzEipCisiKf
         2Hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=okjDcRr0JfcE7YBDN7mQ6NR8rOH6ziWNSaZ1l92Unxg=;
        b=eYHvb7WCiKkV5iQG3HlrbRKOPOc6qc1l/Sv6FU0JHrDcEO/CFRssVr5BloVova4tOU
         1qjQqW2QhuvbIfsa3A3EeVqz3O0kpo3OpPfsrCKO2RNk5U2C2eASuIYwIuQru8yzt0/g
         Di/EyU/kvxgF9A3gBnm7jUKyTbmyCymKfkUmrEGiDBGcrA+c8VRWz5NUB4Nde//ZT4zH
         +ZhmpVQ9o3f3kl0q6oxi0CQXaLuEZXy2Mrg8H6wfEWm5eOBcX0omeGrmZMAx7ArNrfhl
         IPmG2TAfCDXMZoTR8/Qac2JMyzxClQLZUOKeuvUHkM97A4z80vq6Qmr08CjONzNuS4+N
         BjGg==
X-Gm-Message-State: AKaTC03EnFRdLHEWkoDPF8OjsHHcMgjen6BvAFy/f+YVkeLOcDOog07TAgY5nKXU5QJq1g==
X-Received: by 10.194.171.66 with SMTP id as2mr8415466wjc.77.1481986587674;
        Sat, 17 Dec 2016 06:56:27 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:27 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 21/21] Documentation/git-update-index: explain splitIndex.*
Date:   Sat, 17 Dec 2016 15:55:47 +0100
Message-Id: <20161217145547.11748-22-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt           |  6 +++---
 Documentation/git-update-index.txt | 37 +++++++++++++++++++++++++++++--------
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8fbef25cb1..52a3cac4ff 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2782,9 +2782,9 @@ splitIndex.sharedIndexExpire::
 	index file is created. The value "now" expires all entries
 	immediately, and "never" suppresses expiration altogether.
 	The default value is "one.week.ago".
-	Note that each time a new split-index file is created, the
-	mtime of the related shared index file is updated to the
-	current time.
+	Note that each time a split index based on a shared index file
+	is either created or read from, the mtime of the shared index
+	file is updated to the current time.
 	See linkgit:git-update-index[1].
 
 status.relativePaths::
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index e091b2a409..46c953b2f2 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -163,14 +163,10 @@ may not support it yet.
 
 --split-index::
 --no-split-index::
-	Enable or disable split index mode. If enabled, the index is
-	split into two files, $GIT_DIR/index and $GIT_DIR/sharedindex.<SHA-1>.
-	Changes are accumulated in $GIT_DIR/index while the shared
-	index file contains all index entries stays unchanged. If
-	split-index mode is already enabled and `--split-index` is
-	given again, all changes in $GIT_DIR/index are pushed back to
-	the shared index file. This mode is designed for very large
-	indexes that take a significant amount of time to read or write.
+	Enable or disable split index mode. If split-index mode is
+	already enabled and `--split-index` is given again, all
+	changes in $GIT_DIR/index are pushed back to the shared index
+	file.
 +
 These options take effect whatever the value of the `core.splitIndex`
 configuration variable (see linkgit:git-config[1]). But a warning is
@@ -394,6 +390,31 @@ Although this bit looks similar to assume-unchanged bit, its goal is
 different from assume-unchanged bit's. Skip-worktree also takes
 precedence over assume-unchanged bit when both are set.
 
+Split index
+-----------
+
+This mode is designed for very large indexes that take a significant
+amount of time to read or write.
+
+In this mode, the index is split into two files, $GIT_DIR/index and
+$GIT_DIR/sharedindex.<SHA-1>. Changes are accumulated in
+$GIT_DIR/index, the split index, while the shared index file contains
+all index entries and stays unchanged.
+
+All changes in the split index are pushed back to the shared index
+file when the number of entries in the split index reaches a level
+specified by the splitIndex.maxPercentChange config variable (see
+linkgit:git-config[1]).
+
+Each time a new shared index file is created, the old shared index
+files are deleted if their mtime is older than what is specified by
+the splitIndex.sharedIndexExpire config variable (see
+linkgit:git-config[1]).
+
+To avoid deleting a shared index file that is still used, its mtime is
+updated to the current time everytime a new split index based on the
+shared index file is either created or read from.
+
 Untracked cache
 ---------------
 
-- 
2.11.0.49.g2414764.dirty

