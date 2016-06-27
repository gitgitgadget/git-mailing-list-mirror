Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CE362018B
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbcF0S0r (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:26:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34715 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbcF0SZR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id 187so26960571wmz.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5nPa6lt6GNpQOy6PTtjHpaaD5ahQsyst5dl5r2doEDI=;
        b=MW1ua/0Q24OGjq4zbCzWXlHvLfFoygn2hiUJYcuBnQOw2D4ti3TSXIjqmt1eV/ky8D
         G6bXyZV2gGkQH9IpBScD8qxq2S1rEO5NU4WE8jzFxpttpioOrzuVEYeR5OLnnt192zgO
         locOOGPqPL2hTg8nzjvmLfwHBk0vq51KSBtl0Dlb3HASMDM51bkNNEoaEp63XvO7e98S
         /zSPP3R3XycHBBZIR3oShhRl4shFGxpwbA+19BN3UoK1qT1SocrPdNschsSVpfjlcA3x
         4Sp1Nvletk7eNuzGw5Ds2NiDYqDRNYqba7bwCk+asHw4SeYiuSJV2N6q69RPQRTIw1nU
         HyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5nPa6lt6GNpQOy6PTtjHpaaD5ahQsyst5dl5r2doEDI=;
        b=S6BeF7QJpUZe5dxOTUXm2DtCuw+kwG9X2t7+sfoO5KXIrbj9qorJ5s35X84CM34ork
         aspgVYPRTpFiQahh4NG1JwHYw4vvsfWT4MmLddTZv384zovmUw1x42H9RtRuPhD/pY2e
         laHXhYM32vh/CKkZVBljrNhh1SBBYI3dVQ61LN/hHpp4OqaZxlv+W9c+DibAOFfzqsf+
         R/5vkTfPZ/yp+8aylMwHpypA5haVtZxT4yH+NpF06FDCVV3rbex43ECocGcwbqJ6IWhV
         bG/MTkcbLTEuppu6uv3dsKV6nUfzeRevuezR1/tI32bJn3xgJbtMQmAeELRqebzc7VJt
         LghA==
X-Gm-Message-State: ALyK8tJyEgbSUooA6YCT87E7uUa6mnWsWXxq+Mzie1dncZv2c7LjzIOuxRHzDWliM2451Q==
X-Received: by 10.28.134.199 with SMTP id i190mr12512348wmd.26.1467051903357;
        Mon, 27 Jun 2016 11:25:03 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:02 -0700 (PDT)
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
Subject: [PATCH v8 09/41] builtin/apply: make parse_ignorewhitespace_option() return -1 instead of die()ing
Date:	Mon, 27 Jun 2016 20:23:57 +0200
Message-Id: <20160627182429.31550-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", parse_ignorewhitespace_option() should return
-1 instead of calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 40e8397..7d0bf66 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -57,20 +57,20 @@ static int parse_whitespace_option(struct apply_state *state, const char *option
 	return error(_("unrecognized whitespace option '%s'"), option);
 }
 
-static void parse_ignorewhitespace_option(struct apply_state *state,
-					  const char *option)
+static int parse_ignorewhitespace_option(struct apply_state *state,
+					 const char *option)
 {
 	if (!option || !strcmp(option, "no") ||
 	    !strcmp(option, "false") || !strcmp(option, "never") ||
 	    !strcmp(option, "none")) {
 		state->ws_ignore_action = ignore_ws_none;
-		return;
+		return 0;
 	}
 	if (!strcmp(option, "change")) {
 		state->ws_ignore_action = ignore_ws_change;
-		return;
+		return 0;
 	}
-	die(_("unrecognized whitespace ignore option '%s'"), option);
+	return error(_("unrecognized whitespace ignore option '%s'"), option);
 }
 
 static void set_default_whitespace_mode(struct apply_state *state)
@@ -4626,8 +4626,8 @@ static void init_apply_state(struct apply_state *state,
 	git_apply_config();
 	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
 		exit(1);
-	if (apply_default_ignorewhitespace)
-		parse_ignorewhitespace_option(state, apply_default_ignorewhitespace);
+	if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
+		exit(1);
 }
 
 static void clear_apply_state(struct apply_state *state)
-- 
2.9.0.172.gfb57a78

