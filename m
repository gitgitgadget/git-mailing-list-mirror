Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B1CC1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 12:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKMMlR (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 07:41:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38120 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfKMMlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 07:41:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id z19so1847389wmk.3
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 04:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jOXQWr1EMAM719ZWjuNc3i9d0/4P0b1PGFEKAjfYFnw=;
        b=a5AMvyXFdo3er3ezsg2MDQbwVgYKL4A7Oq2ILZL3zNQ6tkP2KFPrMFKkLK9SMGXBQK
         Eih1RCpKIEmM20fkKAVJEzEZLJWCi0I+jBV26Y4TDnw6WOM0Bk5uCPM4kl29usFV/hvN
         BVCVD2MN5HHcx4IWqdfA+UbQTQIoYbg5iCtgbTz6Loo5fEAml3kk2yz5ia5P2ZFjETj1
         y/zNDciYZFyoiMFH7fH4VeJVFADsslRo8gfoHq2GGaeO0EDrIxDt+CUjBd698y4m6Oca
         J4yNXcnZc9O0JhS0SClgjThzJaRCLx5c2sG3VTh6RiGl8dgralkTIhj5tDJPrdqB3F1i
         Hm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jOXQWr1EMAM719ZWjuNc3i9d0/4P0b1PGFEKAjfYFnw=;
        b=JvOjDnbOwzuvsDkfavQzFPLvuoh52M4xx7PdSncRlm3ff/eMYmSa5z2synjBDzAaL7
         y28swPKuMJDQ5j933qpLkyHl59t431joQbacWWyIEc4/JID77gVtyAqGfhBQmixwEEqG
         UmHlOnJ6j1dbJSons2sSWvZOUO6p6512uAGorrJF3L/IaS2N435zxm0BmKhYxZw1hH7W
         khbxNqNhY8/FGz4kLO1+ojM7tKHDdFCsdpSIqVsBKmJtzDlbRzBSuFWXAZUlxZEqBnlB
         NddyHgnxfvzDKSrlUDn3ZGOiknEZFC8+13qfuAWFpPsmRvJDi5NZ90PdF0BdXA+jpL/7
         pHKw==
X-Gm-Message-State: APjAAAVAAZ+DWdH9CWX7IoDfNHFSCT9mVB7Vgf1QI5oiMFfFSWhbz/Jl
        RFQtMRGpvAjdNBWVdXEGMH6z/Lux
X-Google-Smtp-Source: APXvYqwBYJOPagnFOBjgmmyLxS2J4HK09QbqgPhMIrTqQFwkccUQEXQOGoHLMz5kGbDEu4rdUuicPA==
X-Received: by 2002:a1c:2344:: with SMTP id j65mr2794089wmj.38.1573648873470;
        Wed, 13 Nov 2019 04:41:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 91sm2834226wrm.42.2019.11.13.04.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 04:41:12 -0800 (PST)
Message-Id: <bdf9058d9e71ac279a630234efd333c3c082cc96.1573648866.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
References: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
        <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Nov 2019 12:41:03 +0000
Subject: [PATCH v6 7/9] built-in add -i: support `?` (prompt help)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
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
 add-interactive.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 7b6bcf6f8a..8d3829fe68 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -11,6 +11,7 @@ struct add_i_state {
 	struct repository *r;
 	int use_color;
 	char header_color[COLOR_MAXLEN];
+	char help_color[COLOR_MAXLEN];
 };
 
 static void init_color(struct repository *r, struct add_i_state *s,
@@ -43,6 +44,7 @@ static void init_add_i_state(struct add_i_state *s, struct repository *r)
 	s->use_color = want_color(s->use_color);
 
 	init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
+	init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
 }
 
 /*
@@ -210,6 +212,7 @@ struct list_and_choose_options {
 	struct list_options list_opts;
 
 	const char *prompt;
+	void (*print_help)(struct add_i_state *s);
 };
 
 #define LIST_AND_CHOOSE_ERROR (-1)
@@ -250,6 +253,11 @@ static ssize_t list_and_choose(struct add_i_state *s,
 		if (!input.len)
 			break;
 
+		if (!strcmp(input.buf, "?")) {
+			opts->print_help(s);
+			continue;
+		}
+
 		p = input.buf;
 		for (;;) {
 			size_t sep = strcspn(p, " \t\r\n,");
@@ -514,12 +522,24 @@ static void print_command_item(int i, struct string_list_item *item,
 		       item->string + util->prefix_length);
 }
 
+static void command_prompt_help(struct add_i_state *s)
+{
+	const char *help_color = s->help_color;
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
 	struct add_i_state s = { NULL };
 	struct list_and_choose_options main_loop_opts = {
 		{ 4, N_("*** Commands ***"), print_command_item, NULL },
-		N_("What now")
+		N_("What now"), command_prompt_help
 	};
 	struct {
 		const char *string;
-- 
gitgitgadget

