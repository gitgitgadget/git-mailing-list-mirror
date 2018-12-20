Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB3EE1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 12:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbeLTMJ1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 07:09:27 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46104 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731327AbeLTMJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 07:09:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so784911ply.13
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 04:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uYgHJ76OzPvh24q/bi5Yr9Jt4+uJXFpMjZ7ti8vbVzs=;
        b=GC3fOCn+eiUGhyHHKlsL06ygLWQ+Gq1RISKEa2wMqlntSdzpUhD1ZyJDYE7uQBh14E
         rm3YL7C16YbhJGYwxnOtvkH3WkvI1uuXEBsaelIK3mi3nlp3Rxw0vsugoGCOEkD/f/Ak
         kpxMflnkDXZ5m0dHQ95MA/TLjvVwR7dsxNUbx9mIfoy0z+kPT153znmz31eH10k6SGTK
         XAsCTURjc/yA0wZRde0JOOFxj37c1RhCTzceqp9edBejZtn9eEEWDJLCOqQS2B9KQUOT
         3bvbq6xAWL9KjQPRBCGnC8i5JKCUYpEk9aiRbNT+5nA3FHbMTZDQN7UtTH2AjYy/vFul
         8Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uYgHJ76OzPvh24q/bi5Yr9Jt4+uJXFpMjZ7ti8vbVzs=;
        b=pI6R1vC9sKyoaB9spYoEHbUF3R9E5130q2TJApxk7VYqgDKSH3EHujpZapUjWTEjIA
         RzAwrQfVOsnkCFMPWr3F9K6iLFkWaOx/8JOLPfS8swqkCeaUQ/Mz5LJ6rVl8d1pQGCy/
         1EFPnf221IJb7JImwsG+wy8+3Th2TLGuxB6bqLfsTc1N8dXALME9w6O1kTK4x5vPQP/G
         ByRvjwxu6Cm8QCpGED05MOaJh7N+MtfcLylnkCUEaeHEdi4j+KfY6qw54/OYI51s/QhV
         B52TVumwOiW60EFopIRm13ZqGcwWu9tWwqScsLFFG5FdU7+AA8aLEq9jWp3BrgV9S2Wm
         xOmA==
X-Gm-Message-State: AA+aEWYCRxNdtF01JHJpUKn0rP3vL2WxdZW8V3qB0nvE/xXK4u8klP3V
        2SXTOEM5sGMonlysCFUsF5V59ovl
X-Google-Smtp-Source: AFSGD/WqL6PVrj1pH/V9PpHF6UqGG15scCLRne1UJ8k46qFINQXpJiAKe38WcWaEDat3eemuzR768g==
X-Received: by 2002:a17:902:a5ca:: with SMTP id t10mr23799696plq.139.1545307765624;
        Thu, 20 Dec 2018 04:09:25 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id 4sm42538514pfq.10.2018.12.20.04.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:09:25 -0800 (PST)
Date:   Thu, 20 Dec 2018 04:09:25 -0800 (PST)
X-Google-Original-Date: Thu, 20 Dec 2018 12:09:12 GMT
Message-Id: <19fdea5db197527ce306f23cc6fb71aadc9465cd.1545307756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.git.gitgitgadget@gmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 5/7] add-interactive.c: implement show-help command
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

Implement show-help command in add-interactive.c and use it in
builtin add--helper.c.

Use command name "show-help" instead of "help": add--helper is
builtin, hence add--helper --help would be intercepted by
handle_builtin and re-routed to the help command, without ever
calling cmd_add__helper().

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 add-interactive.c     | 19 +++++++++++++++++++
 add-interactive.h     |  2 ++
 builtin/add--helper.c |  7 ++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index c55d934186..ff5bfbac49 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -8,6 +8,16 @@
 
 #define HEADER_INDENT "      "
 
+/* TRANSLATORS: please do not translate the command names
+   'status', 'update', 'revert', etc. */
+static const char help_info[] = 
+		N_("status        - show paths with changes\n"
+		"update        - add working tree state to the staged set of changes\n"
+		"revert        - revert staged set of changes back to the HEAD version\n"
+		"patch         - pick hunks and update selectively\n"
+		"diff          - view diff between HEAD and index\n"
+		"add untracked - add contents of untracked files to the staged set of changes");
+
 enum collection_phase {
 	WORKTREE,
 	INDEX
@@ -244,3 +254,12 @@ void add_i_print_modified(void)
 	free(files);
 	hashmap_free(&s.file_map, 1);
 }
+
+void show_help(void)
+{
+	const char *help_color = get_color(COLOR_HELP);
+	const char *modified_fmt = _("%s");
+	printf("\n");
+	color_fprintf(stdout, help_color, modified_fmt, _(help_info));
+	printf("\n");
+}
diff --git a/add-interactive.h b/add-interactive.h
index 1f4747553c..a74c65b7e1 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -5,4 +5,6 @@ int add_i_config(const char *var, const char *value, void *cbdata);
 
 void add_i_print_modified(void);
 
+void show_help(void);
+
 #endif
\ No newline at end of file
diff --git a/builtin/add--helper.c b/builtin/add--helper.c
index 43545d9af5..e288412d56 100644
--- a/builtin/add--helper.c
+++ b/builtin/add--helper.c
@@ -10,7 +10,8 @@ static const char * const builtin_add_helper_usage[] = {
 
 enum cmd_mode {
 	DEFAULT = 0,
-	STATUS
+	STATUS,
+	HELP
 };
 
 int cmd_add__helper(int argc, const char **argv, const char *prefix)
@@ -20,6 +21,8 @@ int cmd_add__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "status", &mode,
 			 N_("print status information with diffstat"), STATUS),
+		OPT_CMDMODE(0, "show-help", &mode,
+			 N_("show help"), HELP),
 		OPT_END()
 	};
 
@@ -30,6 +33,8 @@ int cmd_add__helper(int argc, const char **argv, const char *prefix)
 
 	if (mode == STATUS)
 		add_i_print_modified();
+	else if (mode == HELP)
+		show_help();
 	else
 		usage_with_options(builtin_add_helper_usage,
 				   options);
-- 
gitgitgadget

