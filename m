Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C982C1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665AbcG3R1B (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:27:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36803 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so20018633wma.3
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:26:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VhL2IPEStnvcyv7DLzyDL+zb8pTq0VVdswCFBa/gRSg=;
        b=IbN3lM27neE8uuNHucQ/z/OP7XkTkEfAIyYH9onXRCgkE9WcrpfpiF6IEPdR6inemi
         5nwh+EmKHETbIjl1JJuZrstKaF0qQktEmqsDBkna+iVaiD4Cu2A8CJNr1Zyhn17O8tI6
         rpUvNU8WM4Zv/7OCrOcTv4qXkKqj0mK8XZu/ZUbcoVjEnj/5u6w10Xwx6GINbKqK8Te8
         WgY3JKNMigOdaFpcNWM5+1k/Ul4oyZ3jyxn/nbkOE70BOGBXrn290mQfMNRIc3XUAnNM
         dI93iTglTDZkGDMvMLtoM4C/6S3CVGPbNtlzr+8490GVgKTTBVrW/uMv0wfqXB6PcVIb
         cwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VhL2IPEStnvcyv7DLzyDL+zb8pTq0VVdswCFBa/gRSg=;
        b=E6mg2hFZpa5xW1DAvmk9zdGhadDLeG6n3mifLzQMJ4TaG59p9oJCkHlCC8sXazbzI2
         lvgOH2zokj0uF3+evhiHZjjO94geSKGWhgk5HPGz30hv+ezEnt6p5quCY/W/7LW1R29B
         RhT7rkNBwIUVhwWXWn78CF/2xwAKCp92ykrXbfOB9GpFETvJN6en5BdnR0ZQgT3P57FW
         AM+VbvsuwumVf33uE2+Hqvrx7FYXyPYTVUqqay+EadQosEwNhv+2jvrdHf21I+HDyhEo
         lFCfVXV1lDLfAL69zvuTJm9M27cPHi5IaxjSPzpP2BxjoUuKQU4jFjxt6osXDv64NRsk
         FtrA==
X-Gm-Message-State: AEkoouvZFcbAwfvVlc5Kp0xbkpoZixk7uuK+riEGAXjV/wJ4SDMlu7u9AYb7IQnSGIdl8Q==
X-Received: by 10.28.5.9 with SMTP id 9mr6282755wmf.74.1469899562227;
        Sat, 30 Jul 2016 10:26:02 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:26:01 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v9 23/41] builtin/apply: make create_file() return -1 on error
Date:	Sat, 30 Jul 2016 19:24:51 +0200
Message-Id: <20160730172509.22939-24-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
index a87ca0b..4b4ed40 100644
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
2.9.2.558.gf53e569

