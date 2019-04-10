Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC9BB20248
	for <e@80x24.org>; Wed, 10 Apr 2019 17:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfDJRiC (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 13:38:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40541 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbfDJRiA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 13:38:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id h22so2780313edw.7
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 10:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fdswRMC4oucqvXAVxi1kpHDZut5vtM+fkzoXOH31Fqo=;
        b=mlvLU/ge7jduDfQXm5O7WEwTcA47mdCbGjZPaI1Vi2Td7L5KuLZgnJFIOb/HTcoxcG
         hX6uHRu4FjKVBsM6xp61PuXcMEbLmrFXf4WCTNbBndtNc+6NXGuaryGPLAjCyD2QR4b/
         VFz/jnwDt3WKHla1CMslEqX7+luIcff09g453YbopmascjvCyZjNhAOAnHCNIyhdB1Cs
         H2kjYUCuv1SbqrtPp0/SCBEbAacBtSWh2jKHSIHVAHMSvCNqHODrwtiSOWPu+6jsvor9
         kLdzj91DvAPni2D9HMZzk2wFrpAzYItGlydU+upQstXBlC7Mi2UWGNAlVFnXFvhX8RKM
         1P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fdswRMC4oucqvXAVxi1kpHDZut5vtM+fkzoXOH31Fqo=;
        b=EM5Ipfhhc4RGrGl2R0oa3VUQiprKu76pwyiaUMNHmtGOfMTsQprEQp7PuyxtAsbIEh
         CSpuwGgMsL6h0Pqz7haiva7R1PExsJM96ATPbQF93/YQ4VGF0EKezLmKg10i8giBzBTo
         8jI7D5bq/+GMhi18FEMxz4FLn0vNLxMl4MMmxfJRJZSJtuCd6ypt5OgxWtIY+owN88Iu
         BoxBMQ2VLfiNa78O/EPqdUDuvtoHQoVFL1lnwxIi5X67YR5fewtIP8vGS3ZWyvwPAAgi
         rLjz9qeiGhrOX8GrVmOD6BAOd7W1u2VIHATTACP8y812DUwull2IfwjbzUPt7+g04aNw
         FphA==
X-Gm-Message-State: APjAAAXbgI+4Us6dFMVr6Zem7EpIVjQ4ZTKyRuQcvcIMBCeVGUCIou7W
        l9duWgkAG3kSwgTJetWNHsKo+AOx
X-Google-Smtp-Source: APXvYqyga0cH9fOm4JEYWpGEyVrbQt9ZfUCKI76f3QOUKHbiBvSdn6x9+Y2mPw980+mdyziEu8z3MQ==
X-Received: by 2002:a50:9ea5:: with SMTP id a34mr16019660edf.191.1554917879027;
        Wed, 10 Apr 2019 10:37:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p16sm10460866eds.61.2019.04.10.10.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:37:58 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:37:58 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Apr 2019 17:37:47 GMT
Message-Id: <3e1a88d9c038818fb0d53483e6d9c569d687b38e.1554917868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 10/11] built-in add -i: use color in the main loop
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Slavica Djukic <slawica92@hotmail.com>

The error messages as well as the unique prefixes are colored in `git
add -i` by default; We need to do the same in the built-in version.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 03d0770013..a1550d9b9f 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -13,11 +13,17 @@ static int use_color = -1;
 enum color_add_i {
 	COLOR_HEADER = 0,
 	COLOR_HELP,
+	COLOR_PROMPT,
+	COLOR_ERROR,
+	COLOR_RESET,
 };
 
 static char list_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_BOLD,      /* Header */
 	GIT_COLOR_BOLD_RED,  /* Help */
+	GIT_COLOR_BOLD_BLUE, /* Prompt */
+	GIT_COLOR_BOLD_RED,  /* Error */
+	GIT_COLOR_RESET,     /* Reset */
 };
 
 static const char *get_add_i_color(enum color_add_i ix)
@@ -33,6 +39,12 @@ static int parse_color_slot(const char *slot)
 		return COLOR_HEADER;
 	if (!strcasecmp(slot, "help"))
 		return COLOR_HELP;
+	if (!strcasecmp(slot, "prompt"))
+		return COLOR_PROMPT;
+	if (!strcasecmp(slot, "error"))
+		return COLOR_ERROR;
+	if (!strcasecmp(slot, "reset"))
+		return COLOR_RESET;
 
 	return -1;
 }
@@ -125,6 +137,8 @@ struct list_and_choose_options {
 static ssize_t list_and_choose(struct prefix_item **items, size_t nr,
 			       struct list_and_choose_options *opts)
 {
+	const char *prompt_color = get_add_i_color(COLOR_PROMPT);
+	const char *error_color = get_add_i_color(COLOR_ERROR);
 	struct strbuf input = STRBUF_INIT;
 	ssize_t res = -1;
 
@@ -137,7 +151,8 @@ static ssize_t list_and_choose(struct prefix_item **items, size_t nr,
 
 		list(items, nr, &opts->list_opts);
 
-		printf("%s%s", opts->prompt, "> ");
+		color_fprintf(stdout, prompt_color, "%s", opts->prompt);
+		fputs("> ", stdout);
 		fflush(stdout);
 
 		if (strbuf_getline(&input, stdin) == EOF) {
@@ -178,7 +193,8 @@ static ssize_t list_and_choose(struct prefix_item **items, size_t nr,
 				index = find_unique(p, items, nr);
 
 			if (index < 0 || index >= nr)
-				printf(_("Huh (%s)?\n"), p);
+				color_fprintf_ln(stdout, error_color,
+						 _("Huh (%s)?"), p);
 			else {
 				res = index;
 				break;
@@ -423,15 +439,21 @@ static int run_status(struct repository *r, const struct pathspec *ps,
 	return 0;
 }
 
+struct print_command_item_data {
+	const char *color, *reset;
+};
+
 static void print_command_item(int i, struct prefix_item *item,
 			       void *print_command_item_data)
 {
+	struct print_command_item_data *d = print_command_item_data;
+
 	if (!item->prefix_length ||
 	    !is_valid_prefix(item->name, item->prefix_length))
 		printf(" %2d: %s", i + 1, item->name);
 	else
-		printf(" %3d: [%.*s]%s", i + 1,
-		       (int)item->prefix_length, item->name,
+		printf(" %2d: %s%.*s%s%s", i + 1,
+		       d->color, (int)item->prefix_length, item->name, d->reset,
 		       item->name + item->prefix_length);
 }
 
@@ -455,8 +477,16 @@ static void command_prompt_help(void)
 
 int run_add_i(struct repository *r, const struct pathspec *ps)
 {
+	struct print_command_item_data data = {
+		/*
+		 * When color was asked for, use the prompt color for
+		 * highlighting, otherwise use square brackets.
+		 */
+		want_color(use_color) ? get_add_i_color(COLOR_PROMPT) : "[",
+		want_color(use_color) ? get_add_i_color(COLOR_RESET) : "]"
+	};
 	struct list_and_choose_options main_loop_opts = {
-		{ 4, N_("*** Commands ***"), print_command_item, NULL },
+		{ 4, N_("*** Commands ***"), print_command_item, &data },
 		N_("What now"), command_prompt_help
 	};
 	struct command_item
-- 
gitgitgadget

