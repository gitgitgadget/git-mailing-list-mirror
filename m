Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3BD20193
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbcHHVEN (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36062 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbcHHVEF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id i138so316452wmf.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YYxenuiPbkPESqe6BI8hzpJsGsVby6apdvU4YSxeNQ4=;
        b=WYy3myvbr9u64my+bDVoZKUcLJZcvw5qPSZfRVqSjRJsUNv+BLlU0sBQIj/DkWR7YK
         gbZ7FDzbeLSXn34yqhhsxrN3ZqS4/ne9gZxc/3ZjW9ZDr6FSARzBtNouH0bwdAO1W0Kt
         kAKhAEFlKeRl2U42AHIq5iIC2wt4jPMfPfsvxJcMGDme5OKiCHFowr6Y9r/QzGrgT3o0
         L+cMdSm9dCg9gUIt1+fOlgLNkCfBQyts+xG7aPAgNDw97XtU0Gljljn8LAKO9IyhKR+7
         ZstRAyKbzkBdWk1Vrx9Y3DvplBXZ3UMiN4qgycbff69+db2IenIjKdNgFfMbHwpelToL
         iLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YYxenuiPbkPESqe6BI8hzpJsGsVby6apdvU4YSxeNQ4=;
        b=ZXhXLrkTVRRbyoVsReLRfJlMb5hPJRe6BA02QRnYcsqcIxOsLTvodAKuZhTqGHU8xU
         lR7pcbdqP4cklczCK1W+R8b59QolhEtmU9RyIKEli9Upe53PcBlWLs/EvVwwYsa9/x9y
         Y212tCBD/6+FlJqfyBATdhrBWEChIwyuRBEBX25vcMEr/TIZ7f+eAjDY/h2PxQKxeEcS
         4isgeg9KNSoC81MjFaWFkfuGHA7Qs8BuXTxpieoIlx6sJHctIOMWXmVV7Y58mcGuUh4n
         sc9pSDIe7es+6VJRVTMrDQBsVLXqT9/GH9AsA39vUk7pEetiNNgB35WD7Xexe5VTXIGY
         rrlw==
X-Gm-Message-State: AEkoouu53rGZK50F+40O+2mV2f4EECH//JvSg1zRqWg9evwuvOJGcNhKiD03sOo85x7KEw==
X-Received: by 10.28.146.211 with SMTP id u202mr18212818wmd.54.1470690244341;
        Mon, 08 Aug 2016 14:04:04 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:03 -0700 (PDT)
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
Subject: [PATCH v10 09/40] builtin/apply: make parse_ignorewhitespace_option() return -1 instead of die()ing
Date:	Mon,  8 Aug 2016 23:03:06 +0200
Message-Id: <20160808210337.5038-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
index 06a76f2..ecb1f7a 100644
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
@@ -4629,8 +4629,8 @@ static void init_apply_state(struct apply_state *state,
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
2.9.2.614.g4980f51

