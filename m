Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79331F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbcG3R1E (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:27:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35377 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so20041072wmg.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:26:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eD8r1ZYF1KJOcKUGpqbZt9M4XbHUt8RUOy9++EVEh3o=;
        b=Fqx2B0qqDJcskPxF+Fm2A9u4GA7F5FFrlhTjsLkM8parDo5YWuPHUjsYGYxinY26JV
         FovIpeAiOYUAaKeOvoO6hsieUex2mU23/0nR7PnmCDJilFrN9vaAlxCkx2t67jl+NRea
         UoHZkkrfen2cbnjCUEFkiJtNviQFa9lBoXZ+1DLoAbcwqWgcwZXi2LqiSnRezFuDykXo
         8ysjCGyd2TiY/9CXHXDplqfsr5K7Jr0DMgXfxJGHsd2+gy9sNcm3pOlPs+gvQADbSZYD
         IQ9rvrf+WhyMpywehvg1tgQ5XdyL8or6pakUAwX+PPUq0pfQq/7QHjXk5I/IrPDGfel4
         Ot7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eD8r1ZYF1KJOcKUGpqbZt9M4XbHUt8RUOy9++EVEh3o=;
        b=SdYfDZRwnHJ/sbW4ekliK3NAO+S6XSN17GMNn/MQvdIebzHp0IKqlL1sq/oKcxowYp
         XRoHyjY0ROdLpG70zXq0zBciv7cP/20m3Vci3lqEncDpUBakrcAF5fPtCBLz1J+nxiT4
         kzQddyhJff9GnaDx6u5gG0DdXzSMItAlNYlcBXIPXYXg0U6933/rmQxXcOBau31jd8d9
         B9pvkmmyohFrgH3klmOqLMmqTy61ZAgtcQhtmv9kFo1uxEuR1i9HMXQD5Q4HjEsgW/H/
         G/pTZGQ9RayIh2WBUlBoHeX+qhj4eMw4flCl+s+pkaplFqUTvNoZrCXAd/uCCgZ+NmeJ
         Fdyw==
X-Gm-Message-State: AEkoouuHX0vXQb/kKqvbOBodveDmrq40TC6toAevR3w/69GJkYwPBpkZa50n7ZukFxCN4g==
X-Received: by 10.194.80.104 with SMTP id q8mr47174959wjx.151.1469899565313;
        Sat, 30 Jul 2016 10:26:05 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:26:04 -0700 (PDT)
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
Subject: [PATCH v9 25/41] builtin/apply: make write_out_results() return -1 on error
Date:	Sat, 30 Jul 2016 19:24:53 +0200
Message-Id: <20160730172509.22939-26-chriscool@tuxfamily.org>
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
in "builtin/apply.c", write_out_results() should return -1 instead of
calling exit().

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 815ba77..0834ad2 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4383,6 +4383,12 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 	return -1;
 }
 
+/*
+ * Returns:
+ *  -1 if an error happened
+ *   0 if the patch applied cleanly
+ *   1 if the patch did not apply cleanly
+ */
 static int write_out_results(struct apply_state *state, struct patch *list)
 {
 	int phase;
@@ -4396,8 +4402,10 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 			if (l->rejected)
 				errs = 1;
 			else {
-				if (write_out_one_result(state, l, phase))
-					exit(128);
+				if (write_out_one_result(state, l, phase)) {
+					string_list_clear(&cpath, 0);
+					return -1;
+				}
 				if (phase == 1) {
 					if (write_out_one_reject(state, l))
 						errs = 1;
@@ -4517,10 +4525,17 @@ static int apply_patch(struct apply_state *state,
 		}
 	}
 
-	if (state->apply && write_out_results(state, list)) {
-		/* with --3way, we still need to write the index out */
-		res = state->apply_with_reject ? -1 : 1;
-		goto end;
+	if (state->apply) {
+		int write_res = write_out_results(state, list);
+		if (write_res < 0) {
+			res = -128;
+			goto end;
+		}
+		if (write_res > 0) {
+			/* with --3way, we still need to write the index out */
+			res = state->apply_with_reject ? -1 : 1;
+			goto end;
+		}
 	}
 
 	if (state->fake_ancestor &&
-- 
2.9.2.558.gf53e569

