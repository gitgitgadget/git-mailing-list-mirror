Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 587E020A10
	for <e@80x24.org>; Sun,  1 Oct 2017 14:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbdJAO4n (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 10:56:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:47341 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdJAO4m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 10:56:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id t69so6429859wmt.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 07:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=24lZmG0RZojCgo5FyFPvVcVRp4THb8FQGycyZfEukuQ=;
        b=tWI9jOGo7o1uFmJDgpyTaqk6syQftwN68r4eEVHaDX5HX4+sBywkTh22CCRwcLCMaQ
         7wQn1m/YtRNURqFEcOsFW+oPxodX6pkvsu6LyhZnBAYmsIOo8I7o8XPOU8+wbZYVYWdW
         v6no9tZA1Gcc/gzjpZx+A3V2q0/5PgRrGXuskgcmGY9J8NEZFOLKpr//v9T7kPL6u1G8
         An8Prml2Yyoz5enILYKYYETG49NTXq5YO00C7je4jYlgeRhbsQcLcfAU4FoWJ/LwAxzc
         xiFPdc3VP2IJ2JtABBMzaKJKVtgPrOU2TGSKh3SX7DNUROYyYUiGVSQUwxUtvJSTgewH
         6IOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=24lZmG0RZojCgo5FyFPvVcVRp4THb8FQGycyZfEukuQ=;
        b=nh6zx6bhn8oEfLTWuRdRAKBCvQL9NpYBZSsysHmXOZTxG6Qt3xFOBBCpwF2SDZ4zCB
         pEGT5We4tKZ3sV+0vL8zuSpriQmUm7g+IJheekHfzqT03SbZNlHlMQLuL8nh5/td6rMR
         2kUH6IzlzL3+gug6vMGWXBYxRjo1SZhUGV+JbunJYeXimsklpVNcns6de39WofsYUkrc
         zMacELYcqxa7BErie56G/cL2JXFguxioZl/obIwW2rRnCAOvPh9kqza70/TYrK3nXURQ
         EgTsIKj0GedoaVjoGiHXtINpSP6PJz1kIb5XPGrKrPp3IPskUatVfmSo0tAPVQ8HT3lZ
         uuKg==
X-Gm-Message-State: AMCzsaUkABL9oNnfWQBlYE00+1weDY4FUrNSFOC+FNC8CNupI9kiNHdJ
        IxbzBYoOQDQkmL5PaTrNjj3nlg==
X-Google-Smtp-Source: AOwi7QBij4qz5JY8QbGFnHaI02VQlDKPIvYWEFlv8ODnqxxNAnfesQALLraVS8IA22nsAGRF0BPtPw==
X-Received: by 10.28.175.146 with SMTP id y140mr7371433wme.50.1506869801187;
        Sun, 01 Oct 2017 07:56:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id w82sm10473516wme.5.2017.10.01.07.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Oct 2017 07:56:40 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 03/11] lockfile: fix documentation on `close_lock_file_gently()`
Date:   Sun,  1 Oct 2017 16:56:04 +0200
Message-Id: <619c2cad465cf3994ef84908c97ad4c18ea26e78.1506862824.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <cover.1506862824.git.martin.agren@gmail.com>
References: <cover.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 83a3069a3 (lockfile: do not rollback lock on failed close,
2017-09-05) forgot to update the documentation by the function definition
to reflect that the lock is not rolled back in case closing fails.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 lockfile.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lockfile.h b/lockfile.h
index 7c1c484d7..f401c979f 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -240,8 +240,8 @@ extern char *get_locked_file_path(struct lock_file *lk);
  * If the lockfile is still open, close it (and the file pointer if it
  * has been opened using `fdopen_lock_file()`) without renaming the
  * lockfile over the file being locked. Return 0 upon success. On
- * failure to `close(2)`, return a negative value and roll back the
- * lock file. Usually `commit_lock_file()`, `commit_lock_file_to()`,
+ * failure to `close(2)`, return a negative value (the lockfile is not
+ * rolled back). Usually `commit_lock_file()`, `commit_lock_file_to()`,
  * or `rollback_lock_file()` should eventually be called.
  */
 static inline int close_lock_file_gently(struct lock_file *lk)
-- 
2.14.1.727.g9ddaf86

