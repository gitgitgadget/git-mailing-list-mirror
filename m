Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6300620248
	for <e@80x24.org>; Sun, 17 Mar 2019 10:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfCQKQX (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 06:16:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45533 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfCQKQX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 06:16:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so151210pgk.12
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=epOOx5qmhX9XAzSIHFLPF2H7cgbOFAXzQxVq89PKzho=;
        b=nBpIT/AtfmwMfiidYThurTnsm1jIpVK0mpGPs7pdCPY9ptzuw0QALppZE1E2Cu90bd
         uIPWMmYKHfP/lSlOLHfj+srUup/YCGBa5jOji06qD8wacLNa4Yn1BcxkatOG7sDsrPQL
         66P1s5K7VIL6LVfFlaFR09FE+fOndy/6ILp5cnk1SW8lZdu4KeKQrGnqMCknm8ulgGUh
         wUz4grx3KYgDw8EIF/XiU9ZNeMuFsY8QFP301KlBaSdz+8gNCHq5OoU/Lg018PERa99N
         KdZsNDRnJikQMUcPVLAaGN82Bx57XX7/IteaASwI4bvYkvLv1VvkeQgYBUmjmHwZt/zK
         pOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=epOOx5qmhX9XAzSIHFLPF2H7cgbOFAXzQxVq89PKzho=;
        b=bu/QgLbCQMeDpfY0fnkv4gWo/B/kOzr3Iw2nPlj32Nt4Q57iqYgWYBQCjS4FR3VJMN
         SRFcBtDdwwH6aripUEfAv8n81iVvd0/g9MYQZaZdgGlRggH/uEQdWehkDyggWhaHORIy
         uLFnNAsOvdG1/n8DkUowZvAHN63rxEYWRduObrC30bIN0YWcc6FK4g2r/306cIbDntwS
         JMlflJW6pptRsMHDWIIIKiLlKEHcXzZordSqeHdMeVR6NgbETL44IBwAtouWAwPPQ7XV
         k+9+5Mr4NDXiVFo7DH3mmPB1+0/9/a6E7L5xdibad6xCyldQmE2wiSdkrl2pytpjNU29
         hQCA==
X-Gm-Message-State: APjAAAUlDQwpYtLUhRovpKTnoFrYgfmSo0YDCRwq6vDK+0kkJWCWFn2A
        myhuUWKt4kBb9XN5ADHbBvy1Dbz4
X-Google-Smtp-Source: APXvYqxDoQt4rCKuAi1rbEX8eNpV/RKOnhzsVYalHol6VCwxbjNzgfwy5W/8UXReeCal16v8sqzS9w==
X-Received: by 2002:a17:902:834b:: with SMTP id z11mr14009128pln.257.1552817781784;
        Sun, 17 Mar 2019 03:16:21 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id r10sm1964302pfn.188.2019.03.17.03.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 03:16:21 -0700 (PDT)
Date:   Sun, 17 Mar 2019 03:16:19 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v8 10/11] sequencer.c: define describe_cleanup_mode
Message-ID: <4edca9db0b2a32621a7622b5b709db23b2512d1e.1552817044.git.liu.denton@gmail.com>
References: <cover.1552275703.git.liu.denton@gmail.com>
 <cover.1552817044.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552817044.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Define a function which allows us to get the string configuration value
of a enum commit_msg_cleanup_mode. This is done by refactoring
get_cleanup_mode such that it uses a lookup table to find the mappings
between string and enum and then using the same LUT in reverse to define
describe_cleanup_mode.

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 62 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 2cbfb848dd..f782e8bab2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -160,6 +160,22 @@ static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
 static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
 static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge/reschedule-failed-exec")
 
+struct cleanup_config_mapping {
+	const char *value;
+	enum commit_msg_cleanup_mode editor;
+	enum commit_msg_cleanup_mode no_editor;
+};
+
+/* the 0th element of this array must be the "default" */
+static struct cleanup_config_mapping cleanup_config_mapping[] = {
+	{ "default", COMMIT_MSG_CLEANUP_ALL, COMMIT_MSG_CLEANUP_SPACE },
+	{ "verbatim", COMMIT_MSG_CLEANUP_NONE, COMMIT_MSG_CLEANUP_NONE },
+	{ "whitespace", COMMIT_MSG_CLEANUP_SPACE, COMMIT_MSG_CLEANUP_SPACE },
+	{ "strip", COMMIT_MSG_CLEANUP_ALL, COMMIT_MSG_CLEANUP_ALL },
+	{ "scissors", COMMIT_MSG_CLEANUP_SCISSORS, COMMIT_MSG_CLEANUP_SPACE },
+	{ NULL, 0, 0 }
+};
+
 static int git_sequencer_config(const char *k, const char *v, void *cb)
 {
 	struct replay_opts *opts = cb;
@@ -504,26 +520,37 @@ static int fast_forward_to(struct repository *r,
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
 	int use_editor, int die_on_error)
 {
-	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
-		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
-				    COMMIT_MSG_CLEANUP_SPACE;
-	else if (!strcmp(cleanup_arg, "verbatim"))
-		return COMMIT_MSG_CLEANUP_NONE;
-	else if (!strcmp(cleanup_arg, "whitespace"))
-		return COMMIT_MSG_CLEANUP_SPACE;
-	else if (!strcmp(cleanup_arg, "strip"))
-		return COMMIT_MSG_CLEANUP_ALL;
-	else if (!strcmp(cleanup_arg, "scissors"))
-		return use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
-				    COMMIT_MSG_CLEANUP_SPACE;
-	else if (!die_on_error) {
+	struct cleanup_config_mapping *def = &cleanup_config_mapping[0];
+	struct cleanup_config_mapping *p;
+
+	if (!cleanup_arg)
+		return use_editor ? def->editor :
+				    def->no_editor;
+
+	for (p = cleanup_config_mapping; p->value; p++)
+		if (!strcmp(cleanup_arg, p->value))
+			return use_editor ? p->editor :
+					    p->no_editor;
+
+	if (!die_on_error) {
 		warning(_("invalid cleanup mode %s, falling back to default"), cleanup_arg);
-		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
-				    COMMIT_MSG_CLEANUP_SPACE;
+		return use_editor ? def->editor :
+				    def->no_editor;
 	} else
 		die(_("invalid cleanup mode %s"), cleanup_arg);
 }
 
+static const char *describe_cleanup_mode(enum commit_msg_cleanup_mode cleanup_mode)
+{
+	struct cleanup_config_mapping *curr;
+
+	for (curr = &cleanup_config_mapping[1]; curr->value; curr++)
+		if (cleanup_mode == curr->editor)
+			return curr->value;
+
+	BUG("invalid cleanup_mode provided (%d)", cleanup_mode);
+}
+
 void append_conflicts_hint(struct index_state *istate,
 			   struct strbuf *msgbuf)
 {
@@ -2350,6 +2377,8 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		opts->allow_rerere_auto =
 			git_config_bool_or_int(key, value, &error_flag) ?
 				RERERE_AUTOUPDATE : RERERE_NOAUTOUPDATE;
+	else if (!strcmp(key, "options.default-msg-cleanup"))
+		opts->default_msg_cleanup = get_cleanup_mode(value, 1, 1);
 	else
 		return error(_("invalid key: %s"), key);
 
@@ -2754,6 +2783,9 @@ static int save_opts(struct replay_opts *opts)
 		res |= git_config_set_in_file_gently(opts_file, "options.allow-rerere-auto",
 						     opts->allow_rerere_auto == RERERE_AUTOUPDATE ?
 						     "true" : "false");
+
+	res |= git_config_set_in_file_gently(opts_file, "options.default-msg-cleanup",
+					     describe_cleanup_mode(opts->default_msg_cleanup));
 	return res;
 }
 
-- 
2.21.0.512.g57bf1b23e1

