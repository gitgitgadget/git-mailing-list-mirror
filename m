Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D0C520248
	for <e@80x24.org>; Wed, 17 Apr 2019 14:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbfDQOdN (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 10:33:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38651 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732520AbfDQOdL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 10:33:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so3878326wmc.3
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=2aFIoiHn7j26pXlfTkt4mExeq7SpjgBZmILbvH4T+14=;
        b=pI65QbGR+nOtTRc92ZcwJTG175gIVYJ1cMt6nbu3CS9Q1/t+Z95FUywLUEHtOB0WuF
         NTPLFWnG7r5pOZRTNEBqhfKdFv324qxEZQl6f5+CF1RZ0k22pTTUhx522tFMyyum8gYb
         TUriaWVXkwFml7VVlsOPI+3B6XmU3sp9WX4L9tHfozMltemGRbcgO1RZv9jOQ71rpyxn
         oCLGgvsbdtjRKZIqdnQ3gfwNj0mMGwDtdD7Vb8mSD3z7pxTcHuuEzabxjsZnp4yP0bz1
         f4JE9IvLJOo3wkze8dEeHodnlK/dW3L0mRW4+1UvDMoRWOmBdk+86eEYir4aoiT7hfIS
         XQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=2aFIoiHn7j26pXlfTkt4mExeq7SpjgBZmILbvH4T+14=;
        b=M3OWgRig3mT+fvzir/iS7um8tmMAK5/Mvd9fiAiVG9jkWZLFaBqPchrlheC5GtinWX
         QEzC1ubRBnSc2mVV1XPA6+S2OKhSdAKXw5sOKkuWHjvtC1sLcURwPDlPl6w0WEIslTwe
         j/+TSjqQv2IaBeZoTaZqiVx2wYI6H22azHK+5d9JQT4WZ8VoTDr0LjHcJuzFHVx2IAgV
         qlZdwHGYB4jtMMZYGdDt8FZY+kb63GZUzj7KptCPwRurPYJN90ksF4nIIS+EZUBlTtI1
         7RMwgCWEzB/++n+oIw7mmQf9bnBaO5Vc89ZFUPjPjN+unWRk421cOvKrqEbksjwLlFBF
         lNbQ==
X-Gm-Message-State: APjAAAVz3u3bbKQF2qXkW3jU7URcmCufr9a50k+cUlFoX92Z7/8G13vO
        O5n4Q6gFaB4tgnWARTm+xqdcU3VxfH0=
X-Google-Smtp-Source: APXvYqzRjA2/iyUe/3i2Wz1C49mh2vcOeC/4UlKWSduG7ncUbGZo1jrCxEx7Iin5DTh0/etTaCfr4w==
X-Received: by 2002:a1c:c504:: with SMTP id v4mr32551785wmf.45.1555511589526;
        Wed, 17 Apr 2019 07:33:09 -0700 (PDT)
Received: from localhost.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id t17sm52127726wrr.26.2019.04.17.07.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:33:09 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 10/12] rebase -i: use struct rebase_options in do_interactive_rebase()
Date:   Wed, 17 Apr 2019 15:30:42 +0100
Message-Id: <20190417143044.17655-11-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417143044.17655-1-phillip.wood123@gmail.com>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
 <20190417143044.17655-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

All the parameters that are passed to do_interactive_rebase() apart from
`flags` are already in `struct rebase_options` so there is no need to
pass them separately.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 69 +++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index aa97d81ab8..277dbaadf4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -113,6 +113,8 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
+	if (opts->strategy_opts)
+		parse_strategy_opts(&replay, opts->strategy_opts);
 
 	return replay;
 }
@@ -262,44 +264,50 @@ static int init_basic_state(struct replay_opts *opts, const char *head_name,
 	return write_basic_state(opts, head_name, onto, orig_head);
 }
 
-static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
-				 const char *switch_to, struct commit *upstream,
-				 struct commit *onto, const char *onto_name,
-				 struct object_id *squash_onto, const char *head_name,
-				 struct commit *restrict_revision, char *raw_strategies,
-				 struct string_list *commands, unsigned autosquash)
+static void split_exec_commands(const char *cmd, struct string_list *commands)
+{
+	if (cmd && *cmd) {
+		string_list_split(commands, cmd, '\n', -1);
+
+		/* rebase.c adds a new line to cmd after every command,
+		 * so here the last command is always empty */
+		string_list_remove_empty_items(commands, 0);
+	}
+}
+
+static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 {
 	int ret;
 	const char *head_hash = NULL;
 	char *revisions = NULL, *shortrevisions = NULL;
 	struct argv_array make_script_args = ARGV_ARRAY_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
+	struct replay_opts replay = get_replay_opts(opts);
+	struct string_list commands = STRING_LIST_INIT_DUP;
 
-	if (prepare_branch_to_be_rebased(the_repository, opts, switch_to))
+	if (prepare_branch_to_be_rebased(the_repository, &replay,
+					 opts->switch_to))
 		return -1;
 
-	if (get_revision_ranges(upstream, onto, &head_hash,
+	if (get_revision_ranges(opts->upstream, opts->onto, &head_hash,
 				&revisions, &shortrevisions))
 		return -1;
 
-	if (raw_strategies)
-		parse_strategy_opts(opts, raw_strategies);
-
-	if (init_basic_state(opts, head_name, onto, head_hash)) {
+	if (init_basic_state(&replay, opts->head_name, opts->onto, head_hash)) {
 		free(revisions);
 		free(shortrevisions);
 
 		return -1;
 	}
 
-	if (!upstream && squash_onto)
+	if (!opts->upstream && opts->squash_onto)
 		write_file(path_squash_onto(), "%s\n",
-			   oid_to_hex(squash_onto));
+			   oid_to_hex(opts->squash_onto));
 
 	argv_array_pushl(&make_script_args, "", revisions, NULL);
-	if (restrict_revision)
+	if (opts->restrict_revision)
 		argv_array_push(&make_script_args,
-				oid_to_hex(&restrict_revision->object.oid));
+				oid_to_hex(&opts->restrict_revision->object.oid));
 
 	ret = sequencer_make_script(the_repository, &todo_list.buf,
 				    make_script_args.argc, make_script_args.argv,
@@ -313,10 +321,13 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 						&todo_list))
 			BUG("unusable todo list");
 
-		ret = complete_action(the_repository, opts, flags, shortrevisions, onto_name,
-				      onto, head_hash, commands, autosquash, &todo_list);
+		split_exec_commands(opts->cmd, &commands);
+		ret = complete_action(the_repository, &replay, flags,
+			shortrevisions, opts->onto_name, opts->onto, head_hash,
+			&commands, opts->autosquash, &todo_list);
 	}
 
+	string_list_clear(&commands, 0);
 	free(revisions);
 	free(shortrevisions);
 	todo_list_release(&todo_list);
@@ -336,7 +347,6 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	unsigned flags = 0;
 	int abbreviate_commands = 0, ret = 0;
 	struct object_id squash_onto = null_oid;
-	struct string_list commands = STRING_LIST_INIT_DUP;
 	enum {
 		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH,
 		SHORTEN_OIDS, EXPAND_OIDS, CHECK_TODO_LIST, REARRANGE_SQUASH, ADD_EXEC
@@ -424,23 +434,12 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		warning(_("--[no-]rebase-cousins has no effect without "
 			  "--rebase-merges"));
 
-	if (opts.cmd && *opts.cmd) {
-		string_list_split(&commands, opts.cmd, '\n', -1);
-
-		/* rebase.c adds a new line to cmd after every command,
-		 * so here the last command is always empty */
-		string_list_remove_empty_items(&commands, 0);
-	}
-
 	switch (command) {
 	case NONE: {
-		struct replay_opts replay_opts = get_replay_opts(&opts);
 		if (!opts.onto && !opts.upstream)
 			die(_("a base commit must be provided with --upstream or --onto"));
 
-		ret = do_interactive_rebase(&replay_opts, flags, opts.switch_to, opts.upstream, opts.onto,
-					    opts.onto_name, opts.squash_onto, opts.head_name, opts.restrict_revision,
-					    opts.strategy_opts, &commands, opts.autosquash);
+		ret = do_interactive_rebase(&opts, flags);
 		break;
 	}
 	case SKIP: {
@@ -477,14 +476,18 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	case REARRANGE_SQUASH:
 		ret = rearrange_squash_in_todo_file();
 		break;
-	case ADD_EXEC:
+	case ADD_EXEC: {
+		struct string_list commands = STRING_LIST_INIT_DUP;
+
+		split_exec_commands(opts.cmd, &commands);
 		ret = add_exec_commands(&commands);
+		string_list_clear(&commands, 0);
 		break;
+	}
 	default:
 		BUG("invalid command '%d'", command);
 	}
 
-	string_list_clear(&commands, 0);
 	return !!ret;
 }
 
-- 
2.21.0

