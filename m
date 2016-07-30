Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4BF11F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750AbcG3R1N (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:27:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35368 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so20040993wmg.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:26:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+tkWEnlNrCfHJYY0hCp7TTXJAJujIQtopvvsVWS2rs4=;
        b=A6ZTYxm0boqkqhHuHmtKhDF1T5S8q7tpzPunbnmlXLQSCGqNPesKPIm/FZv/SkNqMb
         aGqrAqR8dCwUDmv+wS4P9eQuqigKc5QyfzHugRjXh/iQRNBvwSTyF7XKQSV1U3xO5Xz4
         iAptHhvqOKMx7/ovQLBmSHiMbfrBisCF02aGVkDUWobx3DoN1PYuZ+29cPQKTR/73PkR
         zV8wJ3ke43TFw968eUyZz1+lvJ4mrt7MPpjMu3o+hwRspzT4uhnmhgkzD82u04Jv8ZAr
         7J6eY6Eol2+VCkcCcuKpnCUJI8cVZVQB1Th/zPTFfjfl4AY8geWyhUYu2eHbKvrmZVvl
         CJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+tkWEnlNrCfHJYY0hCp7TTXJAJujIQtopvvsVWS2rs4=;
        b=iTMINHosgV7LULTxJOkgFtz19bZ4gFr/wfgh0n4yk+QNbkCczHeyMb7+dwAgNaensD
         wHpkMm22FjZVvu+c+Wd2oI5QDbKLcIR1g0hzj0cnS39ux6PkJi5EHcflz8OSlhiOZ7Mx
         P47PS31QFzuI9rIuTXKXx5TBLt/tyagYRjjGaKuaCKsrYJ96ucjZSo0A5pTZKErJXCH6
         n92Ttz+2GEi5nQXOmFvK7zQ3e7WMGQvmaShayv1ngy8kIeI4E1pzhJxvXd2+9/ddfZ6s
         xLlx8ACfR4G2IRSjr/s9WmgGRvy2mjszS9IoeK7BmpX1vZhCOFMd4r2cIzTEk/PbO0iM
         QL8g==
X-Gm-Message-State: AEkoouvtm7KaaZ7DMVOr8qxmIlndK/5dejmoXpWNn+82iMh1JPYjP0zkz/pd8w+SFaesEA==
X-Received: by 10.28.61.215 with SMTP id k206mr6553382wma.80.1469899563767;
        Sat, 30 Jul 2016 10:26:03 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:26:03 -0700 (PDT)
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
Subject: [PATCH v9 24/41] builtin/apply: make write_out_one_result() return -1 on error
Date:	Sat, 30 Jul 2016 19:24:52 +0200
Message-Id: <20160730172509.22939-25-chriscool@tuxfamily.org>
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
in "builtin/apply.c", write_out_one_result() should just return what
remove_file() and create_file() are returning instead of calling
exit().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 4b4ed40..815ba77 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4287,36 +4287,29 @@ static int create_file(struct apply_state *state, struct patch *patch)
 }
 
 /* phase zero is to remove, phase one is to create */
-static void write_out_one_result(struct apply_state *state,
-				 struct patch *patch,
-				 int phase)
+static int write_out_one_result(struct apply_state *state,
+				struct patch *patch,
+				int phase)
 {
 	if (patch->is_delete > 0) {
-		if (phase == 0) {
-			if (remove_file(state, patch, 1))
-				exit(128);
-		}
-		return;
+		if (phase == 0)
+			return remove_file(state, patch, 1);
+		return 0;
 	}
 	if (patch->is_new > 0 || patch->is_copy) {
-		if (phase == 1) {
-			if (create_file(state, patch))
-				exit(128);
-		}
-		return;
+		if (phase == 1)
+			return create_file(state, patch);
+		return 0;
 	}
 	/*
 	 * Rename or modification boils down to the same
 	 * thing: remove the old, write the new
 	 */
-	if (phase == 0) {
-		if (remove_file(state, patch, patch->is_rename))
-			exit(128);
-	}
-	if (phase == 1) {
-		if (create_file(state, patch))
-			exit(128);
-	}
+	if (phase == 0)
+		return remove_file(state, patch, patch->is_rename);
+	if (phase == 1)
+		return create_file(state, patch);
+	return 0;
 }
 
 static int write_out_one_reject(struct apply_state *state, struct patch *patch)
@@ -4403,7 +4396,8 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 			if (l->rejected)
 				errs = 1;
 			else {
-				write_out_one_result(state, l, phase);
+				if (write_out_one_result(state, l, phase))
+					exit(128);
 				if (phase == 1) {
 					if (write_out_one_reject(state, l))
 						errs = 1;
-- 
2.9.2.558.gf53e569

