Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E28BD1F859
	for <e@80x24.org>; Thu, 11 Aug 2016 08:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933003AbcHKIwz (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 04:52:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35690 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932715AbcHKIwv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 04:52:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so59976wmg.2
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 01:52:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=pu0LDHTmCz7FkFKTyy/7qWPXwW6Y1+HduLjMbHqVTeo=;
        b=GDqmzoOKpReMJI5i7YEyaGptYwI1HioO/Lf91kYz0USS8ECgeal5GnBaQrAmKu/iLG
         t9ea4zFKbbyESgJh9JyNOl5QV0zKk6Xz02wzS3Urce6mRSjeBa1qd8zvMAszac0UD80v
         Ntaa/pNY+z/QCapKlrh64EOJIK9s6OVWI4hzTLgqegjYf+ytqC1tu5xX/aKb4D4cAGls
         gGMd4lDoagMKQZFzjUF35W9sTc+jxT76DBuAuNTDXxZgT09gr0i6VyeSDGA3d+yEmuxE
         oAsOkjsh/uTZbGhQXPgDWGXmSM+lWZR+kdDeXzqmIdV7zlV1RLFPz5I3lbZDdP06PIwR
         5iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pu0LDHTmCz7FkFKTyy/7qWPXwW6Y1+HduLjMbHqVTeo=;
        b=aQyjN7oFI5F9GDVraYlRmgmstRbU2HOaTNHHn0zHS0en6Fa29zLMc7fLogbFS7XeGL
         M+usi2zOZHbtmz+beij520auSs2RKcN0jxlCyy8NDW8Yze8XTQ2dHHMBf7ldlj9gBXG2
         9UI95kbCVudNICnWXPtUU/+2/31aQz5GXLrvm6z1aXaP9Xhb91z9/8fXlaqOZH5sBytk
         dDg/ujNvwQizHx4kyk9fkvnzmQrTbVkbiBNKLhYCz/NKaRLNgY9LdxgSoDCwWOH1quNW
         jsImKcs5djP6RFoSWAQMjh+a1BN2HFPtfY9GiPGwivb0nVwXX2Y/oNy+s7jQ9RXwef0q
         DYJg==
X-Gm-Message-State: AEkoouuGNPLKSUA3KYD85A6SJ7LIHt5rF1yAO4AKHRnoPPnxaFC2tXvgo+by9Ie9Wf4QMw==
X-Received: by 10.194.65.170 with SMTP id y10mr8462014wjs.26.1470905565420;
        Thu, 11 Aug 2016 01:52:45 -0700 (PDT)
Received: from localhost.localdomain ([80.215.37.180])
        by smtp.gmail.com with ESMTPSA id n131sm12325202wmd.3.2016.08.11.01.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 01:52:44 -0700 (PDT)
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
Subject: [PATCH v11 01/40] apply: make some names more specific
Date:	Thu, 11 Aug 2016 10:52:29 +0200
Message-Id: <20160811085229.19017-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To prepare for some structs and constants being moved from
builtin/apply.c to apply.h, we should give them some more
specific names to avoid possible name collisions in the global
namespace.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
I am sending only 01/40 and 28/40 for v11 as there are only
commit message updates in those 2 patches.

I hope that it will make it possible to merge the first 32
patches or so of this series.

As usual cou can get the full series from:

https://github.com/chriscool/git/commits/libify-apply-use-in-am

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
2.9.2.614.g5428e0c

