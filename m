Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F961FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753784AbdCFJti (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:49:38 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33594 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbdCFJtc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:49:32 -0500
Received: by mail-wm0-f68.google.com with SMTP id n11so12762311wma.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GW01GWqYhi+ewc+xySxnvW4H0jrjdPuwpuWtXHnyNgI=;
        b=jINCs20YfuP8BZRYJ/9s5JU1z5EQppO15HNlREeciCIl3VAy617KobMwmWef1Px7vN
         gvoEaVQfFuCpQFQ3/oP4e9X1TKTR63OCgpMXG/1gnv8gmhZd6VnS1V3zirJSXCYTIkeu
         K5+EhNduOvj6RPiuFPhPcKMi3RtIF1e4djsJHd/gVzCEK0sgT4fWXygANcAjjRdF+hH7
         jXKw9cAQmGVV969w7tF5Ptg4EWd0hKQoAt2btjrRFneCNo8RDXI7LkK4RQNA3qRpZ7FS
         1fQ0jz9ucjphzDaA0XdXrtqBE3Dsah+TrYQzbiBgPSRLBKLFA/9TwrKbmtlM8D+I3Ib1
         MCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GW01GWqYhi+ewc+xySxnvW4H0jrjdPuwpuWtXHnyNgI=;
        b=o3CPgmSSLy1t0dzWvZTTRDWdzdJK59CftfYFXBCzomlZJgn9bsrdEq+IqJt6cvNPtd
         AioqQazEeegd8H1wcR8kFmjCw3SfUzUJwsfw3oA4AYfa8i3DgTvTJcwocQy0ohVckng/
         3opnzAy0uihs4SHohNrFgTpA+oHuwDlwbcnvYO2Bj+Y9pTWpGhv84OdWOdBlqdHPSNIJ
         22sdjqm05gXt23SEWgBtNH7aCCF9eL4o4gcTOO6FNCJdq4zPqKhBYistfOsVMla1TWRI
         XV/ZXiAF/8GjfEm3n27ghMjBWlMvLzeY1OfAdZ1jNClE5EKVoirQSkpYulVWG1pYOQYV
         g29Q==
X-Gm-Message-State: AMke39moYpNzos+WLBiqBp6nmoPq2V9m8A+rHd7x1sdYw7uhFSP5DUTlkQHmbL/D26xfVA==
X-Received: by 10.28.165.70 with SMTP id o67mr12297603wme.11.1488793367925;
        Mon, 06 Mar 2017 01:42:47 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:46 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 22/22] Documentation/git-update-index: explain splitIndex.*
Date:   Mon,  6 Mar 2017 10:42:03 +0100
Message-Id: <20170306094203.28250-23-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
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
index 2afd5d982b..24ed9c476d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2873,7 +2873,7 @@ splitIndex.sharedIndexExpire::
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
2.12.0.206.g74921e51d6.dirty

