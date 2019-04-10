Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04D720248
	for <e@80x24.org>; Wed, 10 Apr 2019 17:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfDJRiD (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 13:38:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36906 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbfDJRiA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 13:38:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id f53so1220394ede.4
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 10:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VGa1TGfOv9y6bEt+6hgkdmnHLmKqG/XMqv3vvT4xQNo=;
        b=V405BHSgWwN6mjn4KtVfnNcg2Z3IjWAZ4KgvAKe9vFBkMj1IztJoZKejSqffXYfAuw
         ofYGuKRs8rM6vuTSEsvjuDqMDPKEhpf+EhYdx5z+46Vn5OkAY+4A3DOhjUEl6nyaZloo
         daxUtDwmhrDpm6jx5IwtLy2jVHwf5Hx9tcMOwzxxqXf8fdeQ29SQpo26fF4qpkJ2edOM
         eX1U8vUR0MIEHZ/YMR7J3ii+ivThnF3enpW3wUQUQ6reKkreBvvrmp67E9Kc4EE6xiMj
         5vrTX8CZJp6EZEzbJGFL6HSVrbvF/jRlptTX/nP/TeT9MdkUue894huzODxKcpFqs5IF
         ygbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VGa1TGfOv9y6bEt+6hgkdmnHLmKqG/XMqv3vvT4xQNo=;
        b=tNfKahNzgFbIuBiapo21X/DaSYuap0mPUZFmBNHVW0fZefJu9+3rslQSABCMtIA9bI
         ki0tMP1MSSECssyybgGhLGpS463WMYhB28ZNZg1as1bL9EhQ+8+/AQYdoE6H0EETatMJ
         ToePvbUXz5mQjv3XbmBltnxhMh446oSym1qTzh4sAlkfDsUr4ybK5fire6bRVP2jvazJ
         XuPTikEW4pQcUFimx8o4qnsSY6nywU7v6ihbwrfsmW3QtK+mlUXbpxhji03sRGo/csVT
         knG7/YIVa94bQLKSB3fGxxUm6NSNUOSCKf9aTI51JV9zb7Z0eLzWhakz2sXkhV+UZV54
         9zdQ==
X-Gm-Message-State: APjAAAVu9c3Wm7ikx7Nl2lvm1Jmo/a4T5U8uk5JpyCEzbBRO9uegV97V
        wBT2L6hRllQZUsyx2uFsv5GfmZhw
X-Google-Smtp-Source: APXvYqyYv7A55QtuLDK9UR9oDbXWD79MF1NZ8Daop0RkHSlQb+soLBISlcWuY4o3th4hX9DzpFeTng==
X-Received: by 2002:a17:906:7010:: with SMTP id n16mr6660749ejj.271.1554917878208;
        Wed, 10 Apr 2019 10:37:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i26sm3921662ejc.51.2019.04.10.10.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:37:57 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:37:57 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Apr 2019 17:37:46 GMT
Message-Id: <ddd0ee51f68ef98f4d6a57353d28d6bfaff445f2.1554917868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 09/11] built-in add -i: support `?` (prompt help)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With this change, we print out the same colored help text that the
Perl-based `git add -i` prints in the main loop when question mark is
entered.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 62ce446dd9..03d0770013 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -12,10 +12,12 @@ static int use_color = -1;
 
 enum color_add_i {
 	COLOR_HEADER = 0,
+	COLOR_HELP,
 };
 
 static char list_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_BOLD,      /* Header */
+	GIT_COLOR_BOLD_RED,  /* Help */
 };
 
 static const char *get_add_i_color(enum color_add_i ix)
@@ -29,6 +31,8 @@ static int parse_color_slot(const char *slot)
 {
 	if (!strcasecmp(slot, "header"))
 		return COLOR_HEADER;
+	if (!strcasecmp(slot, "help"))
+		return COLOR_HELP;
 
 	return -1;
 }
@@ -112,6 +116,7 @@ struct list_and_choose_options {
 	struct list_options list_opts;
 
 	const char *prompt;
+	void (*print_help)(void);
 };
 
 /*
@@ -145,6 +150,11 @@ static ssize_t list_and_choose(struct prefix_item **items, size_t nr,
 		if (!input.len)
 			break;
 
+		if (!strcmp(input.buf, "?")) {
+			opts->print_help();
+			continue;
+		}
+
 		p = input.buf;
 		for (;;) {
 			size_t sep = strcspn(p, " \t\r\n,");
@@ -431,11 +441,23 @@ struct command_item {
 		       struct file_list *files, struct list_options *opts);
 };
 
+static void command_prompt_help(void)
+{
+	const char *help_color = get_add_i_color(COLOR_HELP);
+	color_fprintf_ln(stdout, help_color, "%s", _("Prompt help:"));
+	color_fprintf_ln(stdout, help_color, "1          - %s",
+			 _("select a numbered item"));
+	color_fprintf_ln(stdout, help_color, "foo        - %s",
+			 _("select item based on unique prefix"));
+	color_fprintf_ln(stdout, help_color, "           - %s",
+			 _("(empty) select nothing"));
+}
+
 int run_add_i(struct repository *r, const struct pathspec *ps)
 {
 	struct list_and_choose_options main_loop_opts = {
 		{ 4, N_("*** Commands ***"), print_command_item, NULL },
-		N_("What now")
+		N_("What now"), command_prompt_help
 	};
 	struct command_item
 		status = { { "status" }, run_status };
-- 
gitgitgadget

