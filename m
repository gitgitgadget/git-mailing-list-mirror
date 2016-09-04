Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F2B81F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932334AbcIDUTj (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36269 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932279AbcIDUTY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id l65so2666657wmf.3
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PNyTfYcW1lJckqiAtsXchJMjkBgMFoswlPfZ0p8NXFQ=;
        b=axYkQ6OGuo1FtF6QSmKDpufR3kHvG3M93jrlDeTxZfUTMw/TWY/kc3YKw1P/EqJeGq
         uPYRzuP6Y0W8BbMcvKQkuY/DifaAxEAQiV9GmxkPt0+BT81R8faiCMs9IlZ0bxQQzZQv
         0a3KYhIpFG5hraD3VoSlfcl5w3HOF7Wx84KQng+OrHc+m26xkc9tbTbnD9lizG/t+Xsx
         JvqnQACUrbqwojNHH3aHVSjYRL+mhdSbtJSS5hHrHZadjwlUNJVeNw1LyQUNijfE0weT
         fqaVS6C6qiTNRH6eb7mjV9wgXjya3aVeLhuEYrcF7+2yuJfwzefR4LqsIhPMKtc9F4A3
         fFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PNyTfYcW1lJckqiAtsXchJMjkBgMFoswlPfZ0p8NXFQ=;
        b=I8+eU9SY6G6lGKcuyHGTXVuiHLFsVcZ8NgckNCky8mCXQ045PkVLLQviy7dB9g8XD8
         fAmuWIuiU6aU36OQyq0JGF4i0oYQpO/kBv3HDfK6c1kImXm5zFAS3SpR4lrVC5Lpgjhw
         j/jkm4r94f8ke8PZdfH28uZFp5sikJQr+vVbODHNKDk+dq1AO6mJX0nGfiu46XpvLNd4
         HUf2gLMsvPwAIXveBvfHsngPzlDOSIxsed68EyDGV3yluCYwkz0BxrB/lmhgVbg4H89L
         LnUKktGOr5TG2PNKAotuUvNByPK8D+J0K7HXqBef5+SbAQTGJ33O5Ro/Zy7yF1EgJUrQ
         GONA==
X-Gm-Message-State: AE9vXwPIsdDjXbpdQjJO3ozLE+0Y7UqVhf0J6j0I1xF/0ddLKoudCa9QZZRUMQaIJJ7cOA==
X-Received: by 10.195.2.42 with SMTP id bl10mr28075797wjd.21.1473020363044;
        Sun, 04 Sep 2016 13:19:23 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:22 -0700 (PDT)
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
Subject: [PATCH v14 25/41] builtin/apply: make write_out_results() return -1 on error
Date:   Sun,  4 Sep 2016 22:18:17 +0200
Message-Id: <20160904201833.21676-26-chriscool@tuxfamily.org>
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
2.10.0.41.g9df52c3

