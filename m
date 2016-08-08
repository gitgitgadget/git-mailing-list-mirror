Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 186E12018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbcHHVFk (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:05:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35968 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbcHHVD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:03:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id i138so315602wmf.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:03:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jpolm/+EuonKlKMuTW4TJ33+FBY2vK6RBAjQ7fQyij4=;
        b=QrMElC482bB9Mn1VUpZs/boUOxpiBPOhMV7APPQvr3OgmQLSFfLsp4CFuU7unR/HCa
         7Yb1isFx9c60ZrCca6Y/dYxy14cVDgWPvBwDgao/YW7CetmjRd3+E7XitE1PWsrc1kr4
         Ibq7Xr16wC347hxUUBxUC/GiQ7Cdkz18e9Bsz6YXkhf7UnGSULJ5Qf2aSmHPvA84kAm+
         Y7B5ImjRnXqQCNnP1mJMLrzLGgGqoEH9u/uyYbhPQ9ILGZEYlBCLGlVc6RpKc6EbLuwB
         1faxW4b9djb455OhuTjBj1QqqC7kFvAhTEBbgpGi/LgpoJwcWX/uWUdlndwyeD/YsUWh
         K5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jpolm/+EuonKlKMuTW4TJ33+FBY2vK6RBAjQ7fQyij4=;
        b=SZkpivXi1RVeOF7NJF/yl7scbEIszYDNw0EScYJUQ0vhMxs7L0OMveBA1NKZKB56JD
         WR0TFFX5xvG0e8MZ9cL213/AtjItMoiAPrCdzdRa59abuzPaUHijw62XdDH/qFCcho2m
         WSpsoj8OWxot/V77SARVtF3EvjfhG2QOwLMfSWZjxRZlZQcge7E1FmPMTSqlig0A4Xk4
         /+2hhWUItUwCuQoMFmgikQiDHyTP5M8lm90msvYeVTrS+xeaA0DCaSbbJIkDnpDTeeZl
         k/mRdypGTjTHahWy4EZ0knEHMuFHXz2Ln5GUVxkH9BhxBGfrUwRzjqc4lB9WzmSXJV0I
         PPSw==
X-Gm-Message-State: AEkooutiZkSJ7JSdHYk/1SL5tKr28s7ef7UMU7F3OSoBAtj0KyqU1UrahiwNn5drATACHg==
X-Received: by 10.194.97.17 with SMTP id dw17mr83700931wjb.8.1470690233019;
        Mon, 08 Aug 2016 14:03:53 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:03:52 -0700 (PDT)
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
Subject: [PATCH v10 01/40] apply: make some names more specific
Date:	Mon,  8 Aug 2016 23:02:58 +0200
Message-Id: <20160808210337.5038-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
2.9.2.614.g4980f51

