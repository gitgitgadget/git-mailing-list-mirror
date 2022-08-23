Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F33C32789
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 19:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiHWTXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 15:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiHWTXE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 15:23:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607DA60502
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 11:04:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bq11so11366715wrb.12
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 11:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=ikFQWEfRdIynsdVGW6fUd+BYEfs3PqfKzNFN9wLsLzY=;
        b=QxJMtMKmpSHuJsvzV0m5B9MGOenxjHLIhlYnsV/0oThGJJnsA/1hmBq3oHXrsrklcE
         /dkCEfayo3ZwZy0WnX0XugLmft39UCV9Ypr+PMQKW92fHjMbro8WYAtrBtJiBGTbkM/z
         Xqeu29LW7loHTvrfyWScXiA10+XISl705VGP6GWXThLuK1gI/d5jysU3X0lLMhghWIX8
         j5663I5mSn/VU/4iVdDQIZ7VL0ff2gnQMxybsmcf9tHUUGbBjNG/GHkm81XHdkJsyqVe
         hrJoef4tHX74u1fTdKUygk+g7UeNT43e6ViBXhORZS7aS5nB2NV4ohMW72vAtVZXoHAw
         fkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=ikFQWEfRdIynsdVGW6fUd+BYEfs3PqfKzNFN9wLsLzY=;
        b=1R2GWOYXqxe89s/mtq3jmlj/Q28SvSgdq2MaN5VLmyJ9B5PPyH/baEi3CLc450Tg4H
         xVF1vQrI10xKVakseN/K0ANbkNl4w0TTuXWHAQFCXI3Wd2OLc17ymp73IuHGohsHm9vV
         14Sg4qLxwi5E23vHvN0zvQamNKS0CcsmL/0XzInteStbK2zOCFWMcg0FMHlPadVTmuBG
         DMALxoOOC16njEULqiTIBJzniKJcnbcR29ROqTLN2RXSXHwSm7Ohhw382A3CuaZPD3or
         YPNjQksR4VS4akb2J+NOprOqz6WtmvrDjTn+NU6wplmWzY6wSfD5hfe1Y8EGRVDu/gg7
         t6zw==
X-Gm-Message-State: ACgBeo1jo39+W/USxqLQAo1yFgNQH9G2AjKmAEAyQB1C1cuFrdJo4O6f
        UbHJpQS5lzmYawOdBDjal9ClVa++YBk=
X-Google-Smtp-Source: AA6agR61XRP55jmW+f7Xmqwj+F7R51Fv8ZvQXjpXuiq2s7lejERVi7BnjoS3Sv79ZBAQW7Kke+spAg==
X-Received: by 2002:a5d:6f0f:0:b0:225:5589:576f with SMTP id ay15-20020a5d6f0f000000b002255589576fmr6727597wrb.607.1661277875240;
        Tue, 23 Aug 2022 11:04:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c410e00b003a50924f1c0sm18361828wmi.18.2022.08.23.11.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:04:34 -0700 (PDT)
Message-Id: <9dac9f74d2e19899b3e6c1d28e83878ded4469d6.1661277870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 18:04:30 +0000
Subject: [PATCH 3/3] add -p: handle `diff-so-fancy`'s hunk headers better
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `diff-so-fancy` diff colorizer produces hunk headers that look
nothing like the built-in `add -p` expects: there is no `@@ ... @@` line
range, and therefore the parser cannot determine where any extra
information starts, such as the function name that is often added to
those hunk header lines.

However, we can do better than simply swallowing the unparseable hunk
header. In the `diff-so-fancy` case, it shows something like `@ file:1
@`. Let's just show the complete hunk header because it probably offers
useful information.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c                | 8 +++++++-
 t/t3701-add-interactive.sh | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index f2fffe1af02..1f3f3611ee9 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -8,6 +8,7 @@
 #include "diff.h"
 #include "compat/terminal.h"
 #include "prompt.h"
+#include "utf8.h"
 
 enum prompt_mode_type {
 	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_ADDITION, PROMPT_HUNK,
@@ -363,7 +364,7 @@ static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
 		header->colored_extra_start = p + 3 - s->colored.buf;
 	else
 		/* could not parse colored hunk header, showing nothing */
-		header->colored_extra_start = hunk->colored_start;
+		header->colored_extra_start = line - s->colored.buf;
 	header->colored_extra_end = hunk->colored_start;
 
 	return 0;
@@ -649,6 +650,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 		size_t len;
 		unsigned long old_offset = header->old_offset;
 		unsigned long new_offset = header->new_offset;
+		int needs_extra_space = 0;
 
 		if (!colored) {
 			p = s->plain.buf + header->extra_start;
@@ -658,6 +660,8 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 			p = s->colored.buf + header->colored_extra_start;
 			len = header->colored_extra_end
 				- header->colored_extra_start;
+			if (utf8_strnwidth(p, len, 1 /* skip ANSI */) > 0)
+				needs_extra_space = 1;
 		}
 
 		if (s->mode->is_reverse)
@@ -673,6 +677,8 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 			strbuf_addf(out, ",%lu", header->new_count);
 		strbuf_addstr(out, " @@");
 
+		if (needs_extra_space)
+			strbuf_addch(out, ' ');
 		if (len)
 			strbuf_add(out, p, len);
 		else if (colored)
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 7e3c1de71f5..9deb7a87f1e 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -772,7 +772,8 @@ test_expect_success 'gracefully fail to parse colored hunk header' '
 	echo content >test &&
 	test_config interactive.diffFilter "sed s/@@/XX/g" &&
 	printf y >y &&
-	force_color git add -p <y
+	force_color git add -p >output 2>&1 <y &&
+	grep XX output
 '
 
 test_expect_success 'diff.algorithm is passed to `git diff-files`' '
-- 
gitgitgadget
