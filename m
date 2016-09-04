Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08801F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932506AbcIDUUi (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:20:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35396 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932119AbcIDUS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:18:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id c133so10465530wmd.2
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6wJ4PxwSV2e/xUpD+zTTKkb7Coz/zVVoXaDlHqPdG3E=;
        b=LTqBbalp5sCjbvkjCF89HBMo/UNR2tMmQnPS1ZmI8XALol5mbcOmwVp5EG8+QRWbM+
         MFPtUh9atnO48H90pJcGo9OX5G3DqRxx8WMIAODC+g0w9fO+o68K3Ikzen7sRf8y9wZ3
         6vNcCD2POCwcaqzug4CAPDZo5E3LBmnJLB8tw4KGmtWgUeT1E48MQ8GuL44MF1LCeNYZ
         Kq1k7VnDqkq1DD2cyT9AqZ9GLNHk3QoFiVGIEB1HzWefAvSCa756DYxJGRc9ibI3P1tM
         GN7Gwpz4LLge3N/JiueG7ghkWg4ob52YCbobEWAJDDwXMovk0IyqazWZfmoRCg4z+Qlu
         6ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6wJ4PxwSV2e/xUpD+zTTKkb7Coz/zVVoXaDlHqPdG3E=;
        b=dgHBJ/xKAsathnBB0i0op6tHl9vRQi8NQ10x4MbbqBOD3VFh9PXwpB/zZURMRZWrsU
         H9kwCP6rSyatUGIksUOEMMbUXuzo03aIpCcJ3stxSI39iNLieE6dXL6/D8X7HQGUxz+I
         N92qh7UuZWdga1oDDtdhrh5d9qXMyufLlV4sU69QVgJD8hexcJe0VvlDUa+L/lmR5utl
         DnjJPoFhnoS/Q0EzYWLToojzm5P61JwNSINFILhf0Em0iU7TkeC5o1g7wdB5KncSSm9s
         J+sV/i99EMF4mgcNXrrJry9Zwu1FZZQNA+8yHUdWxEh5+lAor7wn1VqX1ev7jMZQOE9A
         H9kw==
X-Gm-Message-State: AE9vXwNttdltdP7UcOrMW1xoYkGpQuKIm1j0NqafqBlUmV+YhRAMjN3d0SrLorNq6ANnCg==
X-Received: by 10.194.59.77 with SMTP id x13mr27148829wjq.144.1473020337000;
        Sun, 04 Sep 2016 13:18:57 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:18:56 -0700 (PDT)
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
Subject: [PATCH v14 09/41] builtin/apply: make parse_ignorewhitespace_option() return -1 instead of die()ing
Date:   Sun,  4 Sep 2016 22:18:01 +0200
Message-Id: <20160904201833.21676-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.10.0.41.g9df52c3

