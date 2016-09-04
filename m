Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D0EE1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbcIDUSt (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:18:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35330 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754208AbcIDUSs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:18:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id c133so10464978wmd.2
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K5rZSzObCf9qSfPtP0OyMOGmtKKf6ONYeXF+1S7vuXo=;
        b=t8jHV6HAK8J+aFGC0XitzWjHnuqrrAwKQ7i8bxcc7BXPspbk0hJO0JZJ7oq+YV+ba6
         C8kpyu/KXtBRCX2jMFGKXjy1HbJS+OxNnY12V8WipiXE7ZFtkDFmVyDr5rtsMWW31E4U
         SNvTSW4ffEB4NNIsY086e9V/4iT5IwTQjotOcRuIkUVVEaR7HrYbBH6LpIDThU936+lk
         Y9VPJ/xgUDqc+n4jTYzQT7oZF3RMcV31j09KKF1BOpkNaMyzhrHl9gZkhG+9ZlnLp8wr
         GMaPayauaYnNq0qD7XelQCQqcDPq8cHa5KKfHniw4FGLX6C9OBVirdNPIw4zou3Wj/xi
         k6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K5rZSzObCf9qSfPtP0OyMOGmtKKf6ONYeXF+1S7vuXo=;
        b=Jkgxr+bnoxVK/nhPcMS/d4rlkZcvJPY3tjPYHX1T6ySvXbp45asRrwC8L0oVwfJtup
         CuZ35jX0YiV9/0Wf5VoeoQAtAixPbqFbR0KxWVsEsbqW7Q59+hPoa1kcWWmtL725gk7B
         tBeSfNET/UDnBuzUwQT+SdtFkjQWv8myFaclDAa7xQ8XTWP8BCyOynpg5f/lZKf4uAsE
         +Tfyi6/W5Un3EXsHt0zx3h6ohvIj8yN8nUXNdwyXMzsPTyi5mYwn7vAggBzAC0nNYqtF
         wv0tTp2BvjXNsKO9dJdi8vVXZFgmTbskhOQ89tje+IyqBpNjXudllOBaane8N4Q5CH6N
         TRfQ==
X-Gm-Message-State: AE9vXwPslvaLJsCuzdaObReyN4M5tddI7+fRFLXoekxmQeb+fp7cgInRz4Ez+YqMdDFTaA==
X-Received: by 10.194.147.19 with SMTP id tg19mr3562381wjb.162.1473020325817;
        Sun, 04 Sep 2016 13:18:45 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:18:45 -0700 (PDT)
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
Subject: [PATCH v14 01/41] apply: make some names more specific
Date:   Sun,  4 Sep 2016 22:17:53 +0200
Message-Id: <20160904201833.21676-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prepare for some structs and constants being moved from
builtin/apply.c to apply.h, we should give them some more
specific names to avoid possible name collisions in the global
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
2.10.0.41.g9df52c3

