Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8D331F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbcG3RZ1 (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:25:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35153 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbcG3RZX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:25:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so20039092wmg.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:25:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AJsGCXFnnUat1D14SXuuTTw/qb5ij8j+61UfdzxRF60=;
        b=uH4Tc5XSPQQop4x/TWP03sNeLFEj0YF3gfvYFQgIcVx+5ISWokeTc26rphKxsQTDBb
         qLSeTzd2GX+Y4aj4X8yOHJIz5A19Gn/ish8VJyaBrMPQcP/KIr2H3bH7qYxEdN9tUzWy
         WTW/Mw8lBFgHlI/WeUNyJNbQOV70NAwvojeEDcywOBQ7C0i7FiojH7eLqOenfr0m3RqV
         HBD2i3QRjshf0DkdfsYJNPnPkvOeV6+grU8qj3hOqY4m96j62Ej+TwGE7YSXZOP7b18O
         PGS+HUIsaylKMzriydLCD0j/oLHTo2qlzTq+XvM2J1mV/MPteQBbfc1PHK6tlT6Fn529
         Cc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AJsGCXFnnUat1D14SXuuTTw/qb5ij8j+61UfdzxRF60=;
        b=dWJ5QfS823TCILA5KJYtJ5iKJj6o0S5s4tyv2tSJKbd9X9AJLBUA88J306/ARQQG5A
         eO2E/Hqm9cPm1WtLA6idfo0w+U94lXA48JjjKPrllMsgoxXsVn8P7oeoaiCH2vunteW3
         lKdXcvEk8GeGOZ/EcSREuq2lUeEt8j1L5yD7WgyRrqzf3qmKjSACUIFJnhzp+5D1cjvi
         DcAxniWPRs85dPUUJUDrH2oR8YiJiSwPkDsYTLlo9elX/ynsnwJKuPcq8oWnlzpXhEFO
         pbr4lQAKayeiNRkqDXlLHGi5P99L4/IsQMgk3lBFqqIxhp/e3sktZzbB61SUksf+4xbp
         b8xw==
X-Gm-Message-State: AEkoouuSIvmbw8H5dCwOXaN89EH6/PJ7LtZPuHpGsIm/wpxUNeUYGodZsZEMwFrpq0pjig==
X-Received: by 10.194.61.205 with SMTP id s13mr42673343wjr.86.1469899522018;
        Sat, 30 Jul 2016 10:25:22 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:21 -0700 (PDT)
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
Subject: [PATCH v9 01/41] apply: make some names more specific
Date:	Sat, 30 Jul 2016 19:24:29 +0200
Message-Id: <20160730172509.22939-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To prepare for some structs and constants being moved from
builtin/apply.c to apply.h, we should give them some more
specific names to avoid possible name collisions in th global
namespace.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 1a488f9..ab8f0bd 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -21,7 +21,7 @@
 #include "ll-merge.h"
 #include "rerere.h"
 
-enum ws_error_action {
+enum apply_ws_error_action {
 	nowarn_ws_error,
 	warn_on_ws_error,
 	die_on_ws_error,
@@ -29,7 +29,7 @@ enum ws_error_action {
 };
 
 
-enum ws_ignore {
+enum apply_ws_ignore {
 	ignore_ws_none,
 	ignore_ws_change
 };
@@ -45,8 +45,8 @@ enum ws_ignore {
  * See also "struct string_list symlink_changes" in "struct
  * apply_state".
  */
-#define SYMLINK_GOES_AWAY 01
-#define SYMLINK_IN_RESULT 02
+#define APPLY_SYMLINK_GOES_AWAY 01
+#define APPLY_SYMLINK_IN_RESULT 02
 
 struct apply_state {
 	const char *prefix;
@@ -110,8 +110,8 @@ struct apply_state {
 	struct string_list fn_table;
 
 	/* These control whitespace errors */
-	enum ws_error_action ws_error_action;
-	enum ws_ignore ws_ignore_action;
+	enum apply_ws_error_action ws_error_action;
+	enum apply_ws_ignore ws_ignore_action;
 	const char *whitespace_option;
 	int whitespace_error;
 	int squelch_whitespace_errors;
@@ -3750,11 +3750,11 @@ static void prepare_symlink_changes(struct apply_state *state, struct patch *pat
 		if ((patch->old_name && S_ISLNK(patch->old_mode)) &&
 		    (patch->is_rename || patch->is_delete))
 			/* the symlink at patch->old_name is removed */
-			register_symlink_changes(state, patch->old_name, SYMLINK_GOES_AWAY);
+			register_symlink_changes(state, patch->old_name, APPLY_SYMLINK_GOES_AWAY);
 
 		if (patch->new_name && S_ISLNK(patch->new_mode))
 			/* the symlink at patch->new_name is created or remains */
-			register_symlink_changes(state, patch->new_name, SYMLINK_IN_RESULT);
+			register_symlink_changes(state, patch->new_name, APPLY_SYMLINK_IN_RESULT);
 	}
 }
 
@@ -3769,9 +3769,9 @@ static int path_is_beyond_symlink_1(struct apply_state *state, struct strbuf *na
 			break;
 		name->buf[name->len] = '\0';
 		change = check_symlink_changes(state, name->buf);
-		if (change & SYMLINK_IN_RESULT)
+		if (change & APPLY_SYMLINK_IN_RESULT)
 			return 1;
-		if (change & SYMLINK_GOES_AWAY)
+		if (change & APPLY_SYMLINK_GOES_AWAY)
 			/*
 			 * This cannot be "return 0", because we may
 			 * see a new one created at a higher level.
-- 
2.9.2.558.gf53e569

