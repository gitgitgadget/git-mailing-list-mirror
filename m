Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 869B92018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbcF0SZc (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33437 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbcF0SZb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id r201so26996995wme.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=do0YY7eYgJbLZu2vfa075H6dUZP6kahbZRTErEGjRlI=;
        b=WRcIAaaBUtZph4H2JFID4Wkis0ZFYdutWzIwC80ADbLQpumvh31M2+o/MDvFkjFD2F
         LB+bUwl/LkVZQ28OsZl0viVmo8sfHpdzJ51qg1Ckf2QyUvd+UEIjEieb4RJzS53RAdRy
         V67hhu+Aaur7JuWX2u+hQhPy/4R5ykH3TFYnmRKCGIVv5eHUzrXc0Dv7FBqGMy65czMJ
         7OAsKFZ1WPparGZZv4XYCvO7vGVQQcpEBfCQDJVKRmSEsCItFQUPBMSGhgdQGz0mqSsu
         27vuIs/emT7NB8EMcGp2fyBYdBZ8ZSk+vREguoYBvDGzHTO9R//U6lamaUkU6uW9j64b
         YFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=do0YY7eYgJbLZu2vfa075H6dUZP6kahbZRTErEGjRlI=;
        b=PPQN0sthX98fbKLvc7T0Z4vJLoAjyfI044Wcde6TXIjyxNc7hZWhK6aaNWPjsTO1wv
         Y8LKyOnwluc+a2+Gzo0qdJQKVCr5N69U1fN9Qr4lBajXaVFQFEy7+/GPQ6l9J9pSU4Cn
         PRF8xILGR5t/dSauCiOy3NCCIQrfix8LEuNIJiHt+TozTPT0SaJgeyiteOxK0dQGOLtz
         640Wkuh42++GS+CO1927We4lX32j4uZesFIXgYERBxPLAsMnWLPuozr48JDWkRogv4Zo
         qKJzyNNL7qyZqld0Aiz+U+QNynkbvVFeG8+4sebZXrocf+QKpvr18AFSAd1w4IR9CQ24
         JgHw==
X-Gm-Message-State: ALyK8tLBNeFCKP0/mJViGawoYk9raBLHlVt0Os3cXA4iVjM0lVumaQr/q3nNkS8gMXWuzw==
X-Received: by 10.28.215.139 with SMTP id o133mr11752480wmg.74.1467051929787;
        Mon, 27 Jun 2016 11:25:29 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:28 -0700 (PDT)
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
Subject: [PATCH v8 29/41] apply: rename and move opt constants to apply.h
Date:	Mon, 27 Jun 2016 20:24:17 +0200
Message-Id: <20160627182429.31550-30-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
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
index c08ecde..467b31f 100644
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
2.9.0.172.gfb57a78

