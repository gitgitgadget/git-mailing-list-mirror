Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1318620229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756418AbcJWJ1m (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34114 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756329AbcJWJ1c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id d199so5246403wmd.1
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yCf5ywp4BBvOmn3cSEoNgCd56HtGacxtWzxggKPda7k=;
        b=yVt9AEXSdRXGyk4dHCuqRz9V/N72VqqybIhs5jpIBmPKIAZNILLK1hLrChOPrT8eVv
         CyfyYshcMuU8dqDLUNbbmNf+PImtzTSPH0/TpenYte/6uJfsvmODrZnV2wEW382rJceP
         +6BSibMsgKEeWuj7e3V/PWJ2JqdJSIfwxseM0Tm9/7xDsd6cjbD71r8YlbntgRXplbfR
         ChPxWEIDNY18WApu2+Ob9PZEG+ixDT6luN2jDSG/os2UNgZ+EYSQ8q4vK3OgdAtCdfxu
         ot1w57MFF3wNS6HpLBxmOdR09/KiOYzFWleINGe/BBaDJ4Cy8A2D+Ixfl/4BBkIjtVJu
         LMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yCf5ywp4BBvOmn3cSEoNgCd56HtGacxtWzxggKPda7k=;
        b=FYBhtW08ggyFR9h4/dTP2Ae9m+CRjBLriMvRVoN3GtAlOvsHWCxzCxv6nASINRKuN5
         IKLYw6HfI+g3AflD9KAjzwNbNmPyxhDgpyNSAYWpmMT1ZmebYfE9UkUkxqS2DAkgvCYJ
         cosr8LV1zAnqHl0kEClKXogF0cckLff+thKPZsRLCWFXn3MjkQAQjQDO3daF6Hv9O4Hp
         fmog76nspSS8A9i4UG7WGy8G0KvFF7M1TcB1L4W70ys06jllAnEW08Lz5nc940i+KdHr
         xwYrFRNxCiQRi5asVEjf/LfgGBkRDtGn9RdrzPB2w4vtBZDgbayguMU4ibqBF8nUYmlE
         +upw==
X-Gm-Message-State: AA6/9RmQ5sRxLIJU0HMqKNpmIFhJz8VjLS1qG5NFW9juJrvbLeYhWBRbr4Z4tTlZVK371g==
X-Received: by 10.28.69.214 with SMTP id l83mr17997317wmi.119.1477214851102;
        Sun, 23 Oct 2016 02:27:31 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:30 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 19/19] Documentation/git-update-index: explain splitIndex.*
Date:   Sun, 23 Oct 2016 11:26:48 +0200
Message-Id: <20161023092648.12086-20-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-update-index.txt | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index e091b2a..635d157 100644
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
@@ -394,6 +390,27 @@ Although this bit looks similar to assume-unchanged bit, its goal is
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
+files are deleted if they are older than what is specified by the
+splitIndex.sharedIndexExpire config variable (see
+linkgit:git-config[1]).
+
 Untracked cache
 ---------------
 
-- 
2.10.1.462.g7e1e03a

