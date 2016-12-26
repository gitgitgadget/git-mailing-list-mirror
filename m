Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9328B200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbcLZKXD (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:23:03 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35948 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755659AbcLZKW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:59 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so52438729wma.3
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wNO8LlbIAP3j9bck3bae6lkHeoIlPpBeOCfRzDyMWfM=;
        b=RVO0Qa461ahGaVFzatFY5q/So9IKQMFTUbknQbkTJzuIk3knERythi0izhpt/oLh4J
         koiPgc4mkBSedB+v97p0dSO7DJCO9DU/4idGHjD/EpdVhIgGmdTdy8odkUjFFeVZXc82
         5aQ1P4KRX2gjlYoy2uRFtGh5NSWRPWDfPyut3DAOXz9rwzyp3AAMu71hZ5smv6lk9khp
         l6UeIrU8wYgIZzqxXUIVrB0S3VduJnnFr2R1Ji4ZstKIQSNtnvgBfYdE62puRRGHEMVF
         qGmm63CD75XPterr6WsP1IekRF6lcRjQSbEYUPt6QUTW6KnLmr4g6oF1wQL5FMQ92bWF
         YXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wNO8LlbIAP3j9bck3bae6lkHeoIlPpBeOCfRzDyMWfM=;
        b=bN05WHYzRk+I0JqXyuB7Q2dLoXgI2yz5TWM0xSy1wO2wz8ELYUaEkdlgTUHp8RaeQW
         VKY2NFqhXWK004dkXhbM0T+6sdshEza7RQdymEG1zG63jd00+yueeOwgAzzdM3yyqKxO
         pOtnR/Ni+sVnVSG+APyECIOaLbDhfv6eiesRGOGL4POBkKfBe6Z1C8gDxux7v4u1Mjwv
         +NDQvqpo9U+MuD+73RZbvDjqWfIXM1iMMwfGW+NwTLb11LhhyyerPH89ELOEjCW03eLc
         gEw4cXKq3R9G9P2dHYMXP2rCbpbRKy07xkFYHND33Jdq11ETw3v5RTm+p3Xmn+5MqbFh
         u0RQ==
X-Gm-Message-State: AIkVDXIYd+06Uvn24kCS1h538gxwHTOv5G8lcdGIwbLadp0uLbF86HSrduQL79tCDvTZSQ==
X-Received: by 10.28.126.18 with SMTP id z18mr26770667wmc.87.1482747777628;
        Mon, 26 Dec 2016 02:22:57 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:56 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 21/21] Documentation/git-update-index: explain splitIndex.*
Date:   Mon, 26 Dec 2016 11:22:22 +0100
Message-Id: <20161226102222.17150-22-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
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
index 24e771d22e..87a570cf88 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2792,9 +2792,9 @@ splitIndex.sharedIndexExpire::
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
2.11.0.209.gda91e66374.dirty

