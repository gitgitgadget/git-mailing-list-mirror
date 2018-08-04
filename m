Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA9F6208E9
	for <e@80x24.org>; Sat,  4 Aug 2018 01:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732193AbeHDDwW (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 23:52:22 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:44532 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732190AbeHDDwW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 23:52:22 -0400
Received: by mail-yb0-f202.google.com with SMTP id 189-v6so7008493ybz.11
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 18:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6lMuCaioPx9eGcAjtLW7YoChPwqjtFsAApBe6RC3WmY=;
        b=ZJCjMKMRTWysyoIoD8tZR2BBs6eOC2v9C2CHeKy6eBcz9637ylkMInsFUMxsufwwe2
         KZIX2bM8vxPXTt6TGKD43D2ZdnmTIFkQ/kNmRnUJWMDDY7CluG9usZ5KB7WLqoHyAgzA
         8q+UiOCZKalMYwXXBCRv4hbCHQb/HPm6mas6xQOFRroHQistJo4hc7Ub38Oc71V5oH35
         JtESOJEkA1uKaXS1brCAAa73dh0Qpghz3dX2nqazZ2bOmSqfWupxiv0sPxIZGJxE32LK
         eAilRWRU1Cv450hOTRJbGEAnCzybUKYetfypvU2uPwoBuUfqqr0OlusYJcztYrv0ChyK
         kbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6lMuCaioPx9eGcAjtLW7YoChPwqjtFsAApBe6RC3WmY=;
        b=naPiIel3kkcr6cYsysJBrCxvYhkJC9KHxVN4uk/ryzE0RxUTkTGPhwsnQ4Z2Nxl8Wv
         6jSHtlIfNCqp6zLWka27gn713OHalr/HVk2dpngmqboh9/sMDmLMzsLtB8olfVblnAGi
         sUryNTC+LdIp8G9lqK3deONoxdY5ZwRenGlLzGeJuIFwjfU02rfZAvhRAjrI0vFrA4vz
         IKtQ7fWzHPJg04Pq4ZP0NKTybsOqksfikN+aElPP7vIiceFVcrM/rlK+ahTIx1f0S/mn
         DTgRBAkyoPe8l2wdJ/aFnDKIgvwTxDhHpcpiJyge0NVFiMPPpxJsu8LlIvH85rV5dG7U
         DVTw==
X-Gm-Message-State: AOUpUlHbejcFVvrU9m9muoU6RLL+Th6+shvZmGS+2uPn2uHSekDtCBtZ
        ITdagS4M1P+uSm+DNegvuOdDhilaFVJbPKmzwzUJMvd+3OAmV1Do06uTRiLl8LLb+8XA4lJQX5a
        Z1fBwD74fbx0iFidfwfucRENAJREoStZLGWxS13htKBSFC8HfUC0WAJp2nQuK
X-Google-Smtp-Source: AAOMgpf0IYNi8GNx7r0ZNkLtFiIU/UGvdUCDCGHhHDdKnw+AA9BOoQz5RLKYuHPi4guELlDF4gA5PXfEarx3
X-Received: by 2002:a25:2a46:: with SMTP id q67-v6mr1151119ybq.28.1533347613348;
 Fri, 03 Aug 2018 18:53:33 -0700 (PDT)
Date:   Fri,  3 Aug 2018 18:53:15 -0700
In-Reply-To: <20180804015317.182683-1-sbeller@google.com>
Message-Id: <20180804015317.182683-6-sbeller@google.com>
Mime-Version: 1.0
References: <20180804015317.182683-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 5/7] diff.c: rename color_moved to markup_moved
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This just renames a variable to make the next patch easier to review.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 28 ++++++++++++++--------------
 diff.h |  2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index 2e711809700..d3829c7d086 100644
--- a/diff.c
+++ b/diff.c
@@ -821,7 +821,7 @@ static int shrink_potential_moved_blocks(struct moved_entry **pmb,
 }
 
 /*
- * If o->color_moved is COLOR_MOVED_PLAIN, this function does nothing.
+ * If o->markup_moved is COLOR_MOVED_PLAIN, this function does nothing.
  *
  * Otherwise, if the last block has fewer alphanumeric characters than
  * COLOR_MOVED_MIN_ALNUM_COUNT, unset DIFF_SYMBOL_MOVED_LINE on all lines in
@@ -836,7 +836,7 @@ static int shrink_potential_moved_blocks(struct moved_entry **pmb,
 static void adjust_last_block(struct diff_options *o, int n, int block_length)
 {
 	int i, alnum_count = 0;
-	if (o->color_moved == COLOR_MOVED_PLAIN)
+	if (o->markup_moved == COLOR_MOVED_PLAIN)
 		return;
 	for (i = 1; i < block_length + 1; i++) {
 		const char *c = o->emitted_symbols->buf[n - i].line;
@@ -895,7 +895,7 @@ static void mark_color_as_moved(struct diff_options *o,
 
 		l->flags |= DIFF_SYMBOL_MOVED_LINE;
 
-		if (o->color_moved == COLOR_MOVED_PLAIN)
+		if (o->markup_moved == COLOR_MOVED_PLAIN)
 			continue;
 
 		/* Check any potential block runs, advance each or nullify */
@@ -4220,7 +4220,7 @@ void diff_setup(struct diff_options *options)
 		options->b_prefix = "b/";
 	}
 
-	options->color_moved = diff_color_moved_default;
+	options->markup_moved = diff_color_moved_default;
 }
 
 void diff_setup_done(struct diff_options *options)
@@ -4333,7 +4333,7 @@ void diff_setup_done(struct diff_options *options)
 		die(_("--follow requires exactly one pathspec"));
 
 	if (!options->use_color || external_diff())
-		options->color_moved = 0;
+		options->markup_moved = 0;
 }
 
 static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
@@ -4796,16 +4796,16 @@ int diff_opt_parse(struct diff_options *options,
 		options->use_color = 0;
 	else if (!strcmp(arg, "--color-moved")) {
 		if (diff_color_moved_default)
-			options->color_moved = diff_color_moved_default;
-		if (options->color_moved == COLOR_MOVED_NO)
-			options->color_moved = COLOR_MOVED_DEFAULT;
+			options->markup_moved = diff_color_moved_default;
+		if (options->markup_moved == COLOR_MOVED_NO)
+			options->markup_moved = COLOR_MOVED_DEFAULT;
 	} else if (!strcmp(arg, "--no-color-moved"))
-		options->color_moved = COLOR_MOVED_NO;
+		options->markup_moved = COLOR_MOVED_NO;
 	else if (skip_prefix(arg, "--color-moved=", &arg)) {
 		int cm = parse_color_moved(arg);
 		if (cm < 0)
 			die("bad --color-moved argument: %s", arg);
-		options->color_moved = cm;
+		options->markup_moved = cm;
 	} else if (skip_to_optional_arg_default(arg, "--color-words", &options->word_regex, NULL)) {
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
@@ -5623,7 +5623,7 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	if (WSEH_NEW & WS_RULE_MASK)
 		BUG("WS rules bit mask overlaps with diff symbol flags");
 
-	if (o->color_moved)
+	if (o->markup_moved)
 		o->emitted_symbols = &esm;
 
 	for (i = 0; i < q->nr; i++) {
@@ -5633,7 +5633,7 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	}
 
 	if (o->emitted_symbols) {
-		if (o->color_moved) {
+		if (o->markup_moved) {
 			struct hashmap add_lines, del_lines;
 
 			hashmap_init(&del_lines,
@@ -5643,7 +5643,7 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 
 			add_lines_to_move_detection(o, &add_lines, &del_lines);
 			mark_color_as_moved(o, &add_lines, &del_lines);
-			if (o->color_moved == COLOR_MOVED_ZEBRA_DIM)
+			if (o->markup_moved == COLOR_MOVED_ZEBRA_DIM)
 				dim_moved_lines(o);
 
 			hashmap_free(&add_lines, 0);
@@ -5731,7 +5731,7 @@ void diff_flush(struct diff_options *options)
 			fclose(options->file);
 		options->file = xfopen("/dev/null", "w");
 		options->close_file = 1;
-		options->color_moved = 0;
+		options->markup_moved = 0;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
diff --git a/diff.h b/diff.h
index b8bbe7baeb8..0dd1651dda4 100644
--- a/diff.h
+++ b/diff.h
@@ -217,7 +217,7 @@ struct diff_options {
 		COLOR_MOVED_PLAIN = 1,
 		COLOR_MOVED_ZEBRA = 2,
 		COLOR_MOVED_ZEBRA_DIM = 3,
-	} color_moved;
+	} markup_moved;
 	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
 	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
 };
-- 
2.18.0.597.ga71716f1ad-goog

