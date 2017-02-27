Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F0D21F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbdB0SLZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:11:25 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36183 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdB0SLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:11:16 -0500
Received: by mail-wm0-f68.google.com with SMTP id r18so14672055wmd.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q2pD+buXEazb+CeOdH+4CEPmQsBqe0K9qkC8X5IKWR4=;
        b=YFJ8D+dWXNUmRZx4uFZENTj2TlP2uv5UDvzrVUP4qlwshL9wrp0DJFn1wc9zsj/uEh
         31H9mqAttrAPcuMQr3Vx3hL+0YjiUEv5a0A8J8QWi4ZgonUhRAgBB9JjUzj4QDGRX323
         rCcjncDG9C/FfVydpi/EPDSBaPlmZhcp10MmHpIQUgTc/VX1gxHcolem+Ez6JZl9pEDU
         YKqCUh4JgNypUcJc3KpKol0Y9vp7WcT+amnR9XUACnbiGCepWhf99gnPODigKH9/rYvx
         fXzDlRyHiKApJMqPr+Ymxbu0RZmKojt3gaLmxe8mnLSLSWlOLE89AsU+bDteUXb10KGI
         zCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q2pD+buXEazb+CeOdH+4CEPmQsBqe0K9qkC8X5IKWR4=;
        b=t73Et42ObzXdFzzThv0SgEF1EkChZfchg0hQPfAlyoFRjR/8BhTMBRfqh0vAoShHLP
         5dxazkrVRF+UxOimdVo0ktbL9UJsk2Pn+ftNAClA2la9eFsdSxoPDbAfb2RQjZg7nmeI
         LBivqeKW3RfhYafdYLSeOUYhD4VNVsQZOJMkyrEus6+pzbP72ok2wcpum7KtO0ZbvhJu
         6tgcP9yLubC0QZYK+TB4q06a7na5CJkRR7bd3mxnRjRzLQlPvrKD1eBVAAkT7xphQGws
         f71ythFq7k8525rZpfZ5bbUpJAnosLUVzNQyRBNTN8STR1R/toMXA86msQOk6ocrHycW
         hBPQ==
X-Gm-Message-State: AMke39kvUjsWyd2bjZMQtygEEyClDbbcoSJVisR+fDiwkjSvQqC/xFtZr4sT6hosLYjtkg==
X-Received: by 10.28.216.14 with SMTP id p14mr13855122wmg.56.1488218467710;
        Mon, 27 Feb 2017 10:01:07 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:01:06 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 22/22] Documentation/git-update-index: explain splitIndex.*
Date:   Mon, 27 Feb 2017 19:00:19 +0100
Message-Id: <20170227180019.18666-23-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt           |  2 +-
 Documentation/git-update-index.txt | 37 +++++++++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e9982c5e3..2ccb053d92 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2853,7 +2853,7 @@ splitIndex.sharedIndexExpire::
 	The default value is "2.weeks.ago".
 	Note that a shared index file is considered modified (for the
 	purpose of expiration) each time a new split-index file is
-	created based on it.
+	either created based on it or read from it.
 	See linkgit:git-update-index[1].
 
 status.relativePaths::
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index e091b2a409..1579abf3c3 100644
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
+This mode is designed for repositories with very large indexes, and
+aims at reducing the time it takes to repeatedly write these indexes.
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
+files are deleted if their modification time is older than what is
+specified by the splitIndex.sharedIndexExpire config variable (see
+linkgit:git-config[1]).
+
+To avoid deleting a shared index file that is still used, its
+modification time is updated to the current time everytime a new split
+index based on the shared index file is either created or read from.
+
 Untracked cache
 ---------------
 
-- 
2.12.0.22.g0672473d40

