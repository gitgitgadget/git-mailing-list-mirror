Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A04EC2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbcF0SZH (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33551 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbcF0SZF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id r201so26991770wme.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:24:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gkJGoSIzM7kYKlh/l2TvG9vAREJjYEKInNPh+t1SV0M=;
        b=I09yV5O9VAwB/M/ikWE5HgkTRIYbbS4TMNT9bgVuIaT6CEQacPfVI3uN3kSbzLvVQS
         C1Z39/2NDoGc+ALp1Vwn1ET17FveBVV/HbHjWCv2+suQl/zoLMfOJMz4YtCQQDxFmY/M
         snvVupiduE525gcjaWWbnRfdz6i5vpkCwC8XtJsIQ04wtHsvE+xMoXqQghsGOA3sjvG4
         xzqDfNPRzxFyAT2hyEFk47zouT+dnnnCK20/RyJ6wOH5E97fYxH4UhvCvi5wSQPW1aA8
         NUwmetHnHWWZTuy39BYHBzJhvoMuF4yBWy2tW3UJxb7nzQjMDRKKwN/6+SaZu+C2IoVc
         g+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gkJGoSIzM7kYKlh/l2TvG9vAREJjYEKInNPh+t1SV0M=;
        b=PcYql5hXqa+OK+/cXkMOEGEOJcgzKHqChXHwwGadJekR5Nx/TrFXBbZ5bKLp1STrxS
         th4PScb+I31N0SAYxAWWDGUSYJTDuZMr4FYSBOaCEzgNWJjtm27AWAp7ook1kuJ8tFub
         kc4rlgN2cEEBkrpV/mCY3EowFxmfR4N0Q/lFLnVDIbUilgzy/F92TpLi3WM/umLQpQSN
         u7cbJc78iYuIP84kMvZ1b/SJrZojQtG0h4LyVNXXQdphlFrF40U368oMTfZAhMaNjjWB
         CdiS4BOd9GJse5d929dL0qN3bpIbewpxzQIsiKpR3mGdWxbMDVHD7p0uNLZS7gdOr6bs
         SobA==
X-Gm-Message-State: ALyK8tLTnMxgegChnRlCasfNLbgZF6IFi4tYObxiUysjc5pXlbyIaM73BkUb1/a/1qUdvA==
X-Received: by 10.28.46.147 with SMTP id u141mr11724898wmu.74.1467051891039;
        Mon, 27 Jun 2016 11:24:51 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:24:50 -0700 (PDT)
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
Subject: [PATCH v8 01/41] apply: make some names more specific
Date:	Mon, 27 Jun 2016 20:23:49 +0200
Message-Id: <20160627182429.31550-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
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
index ecb7f1b..c4d9396 100644
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
2.9.0.172.gfb57a78

