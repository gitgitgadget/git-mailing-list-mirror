Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82EFD2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbcHHVEm (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33926 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbcHHVE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so17867130wma.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9uThRjorNLR2r6yM62FXNdGLrmxKh6dU7O4TOWCJmAI=;
        b=pjNk/ch3po3yP/2c73m4Wux4QlfQNDa5n4lo33h7xef3Izw5Wh5ftsyth0sjXqytZ2
         /du28C1abJyzAuhLClhEtbAk1EW6Skr6Gp6zyonPlFykzUWN5xPFUdvn/r3k+RyAJ2vE
         7knBxBZ9rcy3vXtz0ZAe4lXQ3T4E4a/kIm165B+efOdJLop97qo8dvVsjfI9jOmSjJGR
         y+0O9bTAhYK6IyBNtsstFj/u/VduJ3xLdn69kLCeY4R8uwzQOEUaVMauzgvL/2fmW58d
         fDPDSxA1bnOy+IZWlNP8dhk/aRbGR9y3ocKUSa6mDYO1iHD9W0Cdm7kEjAagGD4IXC3F
         BtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9uThRjorNLR2r6yM62FXNdGLrmxKh6dU7O4TOWCJmAI=;
        b=BzdKVKzZR16zwA1bIHL+jU5VqVhNtWmWc5/jH6AvSxdbhJh7JUwPH1Vd6hSUpOWeRg
         0rJHiKDfCHUPZuTNUrAhF8gJ3LqoysUsOBO9G614V8Vgnun9VWhW0uyPHOv4Ae1P/zvp
         +arp+zxiQp0U4rNa7jkSyIUqPWPZk1O0PpWRZaJR0Mt3cdw2jykxszRj+uvlHKKeN7yM
         68skYJnV0QIU0Z/GO0ouhFV38pk4BIppNIhGrXxiupLO4oHrU7Mve2xEEodS3I3NU8hY
         P0SzLE9Rpf6D0T6tsVINzcye9NodNsDmmxHLod+2S0HL/NL1XpBdQ4cr+wFWiKsd9fMw
         Ai1A==
X-Gm-Message-State: AEkoouvabxUspsncorpcv0RqH7OI6gVeR92gL/+yX5/BOEwAiSfu8u995MgNnieedjyVDA==
X-Received: by 10.194.171.131 with SMTP id au3mr86913941wjc.125.1470690266866;
        Mon, 08 Aug 2016 14:04:26 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:26 -0700 (PDT)
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
Subject: [PATCH v10 25/40] builtin/apply: make write_out_results() return -1 on error
Date:	Mon,  8 Aug 2016 23:03:22 +0200
Message-Id: <20160808210337.5038-26-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
index 003acec..c787ead 100644
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
2.9.2.614.g4980f51

