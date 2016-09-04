Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45A9D1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbcIDUT7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32991 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932366AbcIDUTr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:47 -0400
Received: by mail-wm0-f68.google.com with SMTP id w207so10457338wmw.0
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bGsfZE9+4WP5G1A08n9y8qbZQiWOnPVIKXYpk8bKtqw=;
        b=YANiKZAi1GwuTE0hBFWLySjL4ApRS3kGMKfJUasXd5eAZuMXTh5LllxIwtvUD9S40E
         7VO2QYSZboTz8cwuEEp17sZOdKgHsZ4jM7ffERdNY0M5mBcsn0Kr9l6/CQhM0p+NX7tp
         +ceTEw69WblwiraHNaAz9C3PvTxFBhgHulIBQVMyWL+36gG4IJm0Te7McGX6j05ycefY
         42xdevfyEp3SXNatJ4BSSOOUE53NNq1cGPd4MF/S665ENIgNu5BJ5lyfWmJAlHybWB/n
         RZKXRLUaG9Pt159gy+GlFdWCy3h/GairD2SuUYOx23MKauagATmQfPY8aPeVKQMFoLCp
         JkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bGsfZE9+4WP5G1A08n9y8qbZQiWOnPVIKXYpk8bKtqw=;
        b=K477tCtTvSrxwKHppO6SLNxjoDN5RQOalnx1UBQr11bpbPQBUQ+rR3VSl3Z9YhqOBV
         UmgOkQA5hUkpu6XI0jT1A3KQ1EYddvL635uuqEKYHLCQh1CHoktM+CZq88byIBciFNk3
         OaEyNVYD0JKT5MKP1sLmp/uAWtorLw56nj5SoItoFJQXxvZ95p+7YkscWyJn3sUIAnDN
         ETiZJ8GemEyKiEqURSJbsmzINV3p/rivqyGHpCrTW5nl/oyRL7N6f2e0rPrDp4yz3A/X
         SD/JLyrJFXNHA76qmCase/B2pL6/eMvtUXY/rf3rgFmZnBzrNomgluTbkesXYOzu1nNI
         /h9g==
X-Gm-Message-State: AE9vXwNVGGjGk8hNULYLi2ZYtDKEB6y78VMaCqR2dsnD/kiszUfWPmyeRSBb5y/UepwRBA==
X-Received: by 10.194.216.233 with SMTP id ot9mr28759404wjc.166.1473020386041;
        Sun, 04 Sep 2016 13:19:46 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:45 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v14 34/41] apply: don't print on stdout in verbosity_silent mode
Date:   Sun,  4 Sep 2016 22:18:26 +0200
Message-Id: <20160904201833.21676-35-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When apply_verbosity is set to verbosity_silent nothing should be
printed on both stderr and stdout.

To avoid printing on stdout, we can just skip calling the following
functions:

	- stat_patch_list(),
	- numstat_patch_list(),
	- summary_patch_list().

It is safe to do that because the above functions have no side
effects other than printing:

- stat_patch_list() only computes some local values and then call
show_stats() and print_stat_summary(), those two functions only
compute local values and call printing functions,
- numstat_patch_list() also only computes local values and calls
printing functions,
- summary_patch_list() calls show_file_mode_name(), printf(),
show_rename_copy(), show_mode_change() that are only printing.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index df85cbc..ddbb0a2 100644
--- a/apply.c
+++ b/apply.c
@@ -4702,13 +4702,13 @@ static int apply_patch(struct apply_state *state,
 		goto end;
 	}
 
-	if (state->diffstat)
+	if (state->diffstat && state->apply_verbosity > verbosity_silent)
 		stat_patch_list(state, list);
 
-	if (state->numstat)
+	if (state->numstat && state->apply_verbosity > verbosity_silent)
 		numstat_patch_list(state, list);
 
-	if (state->summary)
+	if (state->summary && state->apply_verbosity > verbosity_silent)
 		summary_patch_list(list);
 
 end:
-- 
2.10.0.41.g9df52c3

