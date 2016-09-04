Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 074321F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932290AbcIDUT1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32880 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932271AbcIDUTV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id w207so10456381wmw.0
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XRYyBwC+/m9hTTUDZJyydgGwyfVcROIoZSZlIYqlIdI=;
        b=kYeG+nOTYIwfci1Y0rgxI90zAAE+FRnu/88GOkI1nCe5B+ALuiIsxExu0N8HqmfQYS
         v3mn5XJoNbYjj3zRexcImayXZjfCKAFwLygiP9pNJziC1b5F6LyUJ7WkEylbQeeKV6l2
         sG/jHtV89Xz7yJaKnaz0e6oMBqhTE9vFPh08IMl7o9OM41WrnHm5RsITZUXO3wMkJSzF
         wjr2NV+d9i7EKK6bpP8dUZ9uFOFc7CxvCcalPMPgk1XvEswZBnoSXOIi3X2ntu3B4bkQ
         8nfIJFTm01CiJroWv5OMtJt6BWIMS4ObSK35uGnfeCAlh+nLpP2WJdo2SEHf41te34D1
         c6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XRYyBwC+/m9hTTUDZJyydgGwyfVcROIoZSZlIYqlIdI=;
        b=mELiAo8v9yQ9z6mCTSRKDwttr+Vu4srDCrXPapvTu/NnA2LEdhHTZuGd3fQJo/syNC
         Fjw30eaTSVKjVh9tG5QG7CO5C5O8FvF8eaKE+5r0xw3k6XSeuJLRWusnupfUSSoUyQMW
         4f2I58NPOIMel135g9AsM9Hi8QXtWBhHAnzxrDmO4M8qa06hSj13FFtHBUWoS9ZB/qxk
         uBIyZAKQ8fp5n3ce0s0Wa+vWGU/kTlKzpmCR6NMKz04Wf2TFfEZ1bZy24wiO+FeUD/uP
         cJDru2gIuD4bollqO9KklLK5HHNutJp9mzb2SaYG/CfhNaoLJjUy0XwDbLUehNtrjLiI
         X62g==
X-Gm-Message-State: AE9vXwMpuR69AD7ClDinWSqRagmjIiv1NapZhNzLh+XPUjKGQqxgVSeqCZPLcTY/trGMPg==
X-Received: by 10.194.205.2 with SMTP id lc2mr31483961wjc.175.1473020360584;
        Sun, 04 Sep 2016 13:19:20 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:19 -0700 (PDT)
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
Subject: [PATCH v14 23/41] builtin/apply: make create_file() return -1 on error
Date:   Sun,  4 Sep 2016 22:18:15 +0200
Message-Id: <20160904201833.21676-24-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of exit()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", create_file() should just return what
add_conflicted_stages_file() and add_index_file() are returning
instead of calling exit().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index a646900..fdfeab0 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4269,7 +4269,7 @@ static int add_conflicted_stages_file(struct apply_state *state,
 	return 0;
 }
 
-static void create_file(struct apply_state *state, struct patch *patch)
+static int create_file(struct apply_state *state, struct patch *patch)
 {
 	char *path = patch->new_name;
 	unsigned mode = patch->new_mode;
@@ -4280,13 +4280,10 @@ static void create_file(struct apply_state *state, struct patch *patch)
 		mode = S_IFREG | 0644;
 	create_one_file(state, path, mode, buf, size);
 
-	if (patch->conflicted_threeway) {
-		if (add_conflicted_stages_file(state, patch))
-			exit(128);
-	} else {
-		if (add_index_file(state, path, mode, buf, size))
-			exit(128);
-	}
+	if (patch->conflicted_threeway)
+		return add_conflicted_stages_file(state, patch);
+	else
+		return add_index_file(state, path, mode, buf, size);
 }
 
 /* phase zero is to remove, phase one is to create */
@@ -4302,8 +4299,10 @@ static void write_out_one_result(struct apply_state *state,
 		return;
 	}
 	if (patch->is_new > 0 || patch->is_copy) {
-		if (phase == 1)
-			create_file(state, patch);
+		if (phase == 1) {
+			if (create_file(state, patch))
+				exit(128);
+		}
 		return;
 	}
 	/*
@@ -4314,8 +4313,10 @@ static void write_out_one_result(struct apply_state *state,
 		if (remove_file(state, patch, patch->is_rename))
 			exit(128);
 	}
-	if (phase == 1)
-		create_file(state, patch);
+	if (phase == 1) {
+		if (create_file(state, patch))
+			exit(128);
+	}
 }
 
 static int write_out_one_reject(struct apply_state *state, struct patch *patch)
-- 
2.10.0.41.g9df52c3

