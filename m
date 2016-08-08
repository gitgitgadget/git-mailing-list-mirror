Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49EDB20193
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbcHHVEg (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36305 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbcHHVEd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:33 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so318477wmf.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mqKVgr/XpUhT4J4XCgPpKPe+z0xWDRzMH/W4lpxA5nA=;
        b=CYNdjAd+nK6TqeyVt+zNPDH3WZZ1OASllgVkujMZ3bmIms3cW+JBjkUhW6SvxgF31z
         +0aFdxV2JSAdPbJyhJP4PBOt90yKu4mYzV7xQ/kYKmOrEePi7mF5ikwla7SkHYhmUHXq
         d/B2VbozJSmIeLMSSosaWVs6FsAaSLTzkcHYczQchm9wl9Gkkk1ddNjfhPhbuC2TTvn0
         R/Bbzo0gMa7EfWQOspYGiH3XuFB24OTXSqEkuB+TAnnvmRdGgxcDiPl5PN5H3yGrYpZz
         7jfiMa1AMH1r1euBoavdiQqF2Hn9dgs4njRwxWz6c+9hvkQQw7EfRyJRTB0KEvsIkLZv
         q9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mqKVgr/XpUhT4J4XCgPpKPe+z0xWDRzMH/W4lpxA5nA=;
        b=kOtxmBfAGqXCfSS3x+LY7EIJ73TpuelJ2CCvxM9e2a54SQKe4SSjwvs5zIC28xlmGo
         dSq03ZBEkLTRsBuD9ijWoyxgIYvWoNOjTxsVYoGtNQOFfbnPWAj3POh4Qp1eJFIhgjkL
         jIytEtl61phy85m/gO9/RNWoloO5a1WhisN1MYCl/oCjhO9bQWi9eLU0wN14mTe6XRCu
         t/jZtHJ8jrhz+56rDOJ2Wbjd+EXk/Zw1g7AVH2/WUIGTDlSu7ATErM0dxjU0COqHhrfK
         jukAo0fJxYRT5gw/15NGeCGclV+6kffnSUeg5MS+7EW7MOIwwT1/Yk3BCpnjW4yfY82z
         2kzQ==
X-Gm-Message-State: AEkoous28WRKW2/yualfi5xQPJJIWjDFyJiI4m84s2T5JxBwXJhWDrdTH51aF4fIIN06Xw==
X-Received: by 10.28.209.14 with SMTP id i14mr17250643wmg.35.1470690271995;
        Mon, 08 Aug 2016 14:04:31 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:31 -0700 (PDT)
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
Subject: [PATCH v10 29/40] apply: rename and move opt constants to apply.h
Date:	Mon,  8 Aug 2016 23:03:26 +0200
Message-Id: <20160808210337.5038-30-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
index 429fe44..9c396bb 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4463,9 +4463,6 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 
 static struct lock_file lock_file;
 
-#define INACCURATE_EOF	(1<<0)
-#define RECOUNT		(1<<1)
-
 /*
  * Try to apply a patch.
  *
@@ -4495,8 +4492,8 @@ static int apply_patch(struct apply_state *state,
 		int nr;
 
 		patch = xcalloc(1, sizeof(*patch));
-		patch->inaccurate_eof = !!(options & INACCURATE_EOF);
-		patch->recount =  !!(options & RECOUNT);
+		patch->inaccurate_eof = !!(options & APPLY_OPT_INACCURATE_EOF);
+		patch->recount =  !!(options & APPLY_OPT_RECOUNT);
 		nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0) {
 			free_patch(patch);
@@ -4811,10 +4808,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
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
2.9.2.614.g4980f51

