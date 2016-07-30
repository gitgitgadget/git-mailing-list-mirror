Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBAD11F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbcG3R1P (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:27:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34292 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so20053022wma.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:26:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZOIjPn32B4ij8kn8p6SGlp69njM/1bVEaMFHB8FphIM=;
        b=otXSUeH+5b4MGPHMEgG4++QPOl5sVc3p7sGaSI85mpJjFMUem9rru4DlEXzSkOsNoc
         djNnbaISBhF5RzglaFb13B9PIKsEVdFQqXVmjysVgWAuAScsUgFs8D6tKhJSSjQy6aVL
         nImq57mAiinCWfa37gqMMveLf+saMx8mZaJTE0Wjc8MS5/gFTcPnWk5/y6qRuUE92lyO
         bbNBkRWLi58dSxgOC3zkx98GURrK6UN6OJ94omxkQUkf8uEbJ8PlJPYTy4ardGrj4Nyc
         Kpp5IkLgOwPcGXxLcHS1u/dq9rYxhaN8ifuR5HQbizuOVeBlBa4b6DXU3PFBpTeTt7H0
         WbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZOIjPn32B4ij8kn8p6SGlp69njM/1bVEaMFHB8FphIM=;
        b=PzLViavV+oNCS25p1ifQqdpxKzjp1XpgVGrmWZ2W2CTSHsa7xKIYttd89LwGO9EBG7
         1kCO1wA4RN0p77yU+nKXe+e81sqEfaLXds8uTkUEIaNMzAh+5YWbPSCh2UWSVhtYYFT+
         42NikCYckBj1pjFR93oyXosUZbQTSZPj0wO+U8ebaJeQda6FrlzvfZw+p6JZaDZ+woaA
         xIG1557X7oIkTyQDLJSecPI47idNlJEwA6ecmp9B+TDcUpZpkXVXf0VhIRoZtqPPu07E
         Iy39ft6ElS7gsLYVR2Uga7hS9Spn+w4/j+kjlEaU9un/YhNI0fUsfB+GZsBveWk2Lw10
         CZMA==
X-Gm-Message-State: AEkoouuDkPc9aqwp198IoN71yZYi/lw/UQNsWDkHLmDy5abbrrG7aQBwJo0decsgVp9nMw==
X-Received: by 10.194.87.66 with SMTP id v2mr48490506wjz.40.1469899570662;
        Sat, 30 Jul 2016 10:26:10 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.26.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:26:09 -0700 (PDT)
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
Subject: [PATCH v9 29/41] apply: rename and move opt constants to apply.h
Date:	Sat, 30 Jul 2016 19:24:57 +0200
Message-Id: <20160730172509.22939-30-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The constants for the "inaccurate-eof" and the "recount" options will
be used in both "apply.c" and "builtin/apply.c", so they need to go
into "apply.h", and therefore they need a name that is more specific
to the API they belong to.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.h         |  3 +++
 builtin/apply.c | 11 ++++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/apply.h b/apply.h
index 53f09b5..ca1dcee 100644
--- a/apply.h
+++ b/apply.h
@@ -108,4 +108,7 @@ extern int init_apply_state(struct apply_state *state,
 extern void clear_apply_state(struct apply_state *state);
 extern int check_apply_state(struct apply_state *state, int force_apply);
 
+#define APPLY_OPT_INACCURATE_EOF	(1<<0)
+#define APPLY_OPT_RECOUNT		(1<<1)
+
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index c7e570a..486e5f7 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4460,9 +4460,6 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 
 static struct lock_file lock_file;
 
-#define INACCURATE_EOF	(1<<0)
-#define RECOUNT		(1<<1)
-
 /*
  * Try to apply a patch.
  *
@@ -4492,8 +4489,8 @@ static int apply_patch(struct apply_state *state,
 		int nr;
 
 		patch = xcalloc(1, sizeof(*patch));
-		patch->inaccurate_eof = !!(options & INACCURATE_EOF);
-		patch->recount =  !!(options & RECOUNT);
+		patch->inaccurate_eof = !!(options & APPLY_OPT_INACCURATE_EOF);
+		patch->recount =  !!(options & APPLY_OPT_RECOUNT);
 		nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0) {
 			free_patch(patch);
@@ -4808,10 +4805,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
 		OPT_BIT(0, "inaccurate-eof", &options,
 			N_("tolerate incorrectly detected missing new-line at the end of file"),
-			INACCURATE_EOF),
+			APPLY_OPT_INACCURATE_EOF),
 		OPT_BIT(0, "recount", &options,
 			N_("do not trust the line counts in the hunk headers"),
-			RECOUNT),
+			APPLY_OPT_RECOUNT),
 		{ OPTION_CALLBACK, 0, "directory", &state, N_("root"),
 			N_("prepend <root> to all filenames"),
 			0, apply_option_parse_directory },
-- 
2.9.2.558.gf53e569

