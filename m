Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74F3E1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 21:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeHWBCA (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 21:02:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34812 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbeHWBB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 21:01:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so1594684pfi.1
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 14:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bM0ZImX44FDDzCxrcTuNTexIMvIl1Gtzx08Z/65cz20=;
        b=MBCO50lcOj5X9y65NoK8i38VAvjFioNz8eQfMTFLL6PLNfV7isrHadSj4ttS2HH7YS
         M7iUDvjuvKbeLVYrrAUGgnGK1oYSGxfQ4gwoD+6AJznHQ1l6YqNngXVhKX524gjzJ66F
         /E7UnZ7G4H0Rmdm5O6WYf7b8mK7v7NSHRo+QHE4jpBkzzpNtx8JU3Q1jkLW179l1StvH
         4bAAcRXJ9CLhqaxkQEyEgmDxLLf1C5g2m87xMr08AihGoLIplNEm7dFpGDaBUPhHcMB0
         eBlVrXCmra2U61du9hysDiRgSz46uNTFe5F4o51EeaQxoduCkomoeedpkjgmty5O5g8T
         c1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bM0ZImX44FDDzCxrcTuNTexIMvIl1Gtzx08Z/65cz20=;
        b=unTermb/sV7PETdAnOi6r/yjNKB48oDFFMwEWjHnFJ5I82oXcZbp2MV9LTePbZrGeJ
         5FfswUmj1zz8icHUASEngxYoBRT6Iy4P8MJswrexrzmknRaVFoIkD6dmH58wHuO0r6rk
         dKMd8BSru9dlIVVNbHaAFqvh1nrZxA5l6BLYCs0UmxKTMQhrs+vvqn0TzOPkkosHNj3B
         wJw1hXPg4vy4WDOjjO5P0KmMeFMWv2ORhXSsBQWz5/l57xnbm24LFLeLyqiTJcDsE+fn
         s0oxAN5ueoDL6f2qPk4K7XuFnpiBOQzTZ2ABqpyyv3caEj/dgruBdgHTAJ+/ZpLe7sdd
         3/Sg==
X-Gm-Message-State: AOUpUlFc/80HegJuccMpYmjouBJjHmyTYV/ZqPSxDt7g3kNXNEyDpPZF
        I5NjvXzEra2qgOWkr3QHMy+ig4tM
X-Google-Smtp-Source: AA+uWPyjlWpy+NZOO4xgmmB8pv8AyZEi+YpTucWotu+7f+2Uy3h16dFQRnuz3glosFEpIIgs7fYXog==
X-Received: by 2002:a63:2acc:: with SMTP id q195-v6mr21407616pgq.291.1534973724613;
        Wed, 22 Aug 2018 14:35:24 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id n24-v6sm3653205pfi.161.2018.08.22.14.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 14:35:23 -0700 (PDT)
Date:   Wed, 22 Aug 2018 14:35:23 -0700 (PDT)
X-Google-Original-Date: Wed, 22 Aug 2018 21:35:20 GMT
Message-Id: <29d49819fa88e38d08be288d8ca0020e7aa4679e.1534973720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.23.git.gitgitgadget@gmail.com>
References: <pull.23.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] builtin rebase: prepare for builtin rebase -i
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

It is no longer a shell script, so we need to call it in a different way
than the other backends.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c8d632b6f4..87590047b3 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -326,6 +326,13 @@ static void add_var(struct strbuf *buf, const char *name, const char *value)
 	}
 }
 
+static const char *resolvemsg =
+N_("Resolve all conflicts manually, mark them as resolved with\n"
+"\"git add/rm <conflicted_files>\", then run \"git rebase --continue\".\n"
+"You can instead skip this commit: run \"git rebase --skip\".\n"
+"To abort and get back to the state before \"git rebase\", run "
+"\"git rebase --abort\".");
+
 static int run_specific_rebase(struct rebase_options *opts)
 {
 	const char *argv[] = { NULL, NULL };
@@ -333,6 +340,79 @@ static int run_specific_rebase(struct rebase_options *opts)
 	int status;
 	const char *backend, *backend_func;
 
+	if (opts->type == REBASE_INTERACTIVE) {
+		/* Run builtin interactive rebase */
+		struct child_process child = CHILD_PROCESS_INIT;
+
+		argv_array_pushf(&child.env_array, "GIT_CHERRY_PICK_HELP=%s",
+				 resolvemsg);
+		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
+			argv_array_push(&child.env_array, "GIT_EDITOR=:");
+			opts->autosquash = 0;
+		}
+
+		child.git_cmd = 1;
+		argv_array_push(&child.args, "rebase--interactive");
+
+		if (opts->action)
+			argv_array_pushf(&child.args, "--%s", opts->action);
+		if (opts->keep_empty)
+			argv_array_push(&child.args, "--keep-empty");
+		if (opts->rebase_merges)
+			argv_array_push(&child.args, "--rebase-merges");
+		if (opts->rebase_cousins)
+			argv_array_push(&child.args, "--rebase-cousins");
+		if (opts->autosquash)
+			argv_array_push(&child.args, "--autosquash");
+		if (opts->flags & REBASE_VERBOSE)
+			argv_array_push(&child.args, "--verbose");
+		if (opts->flags & REBASE_FORCE)
+			argv_array_push(&child.args, "--no-ff");
+		if (opts->restrict_revision)
+			argv_array_pushf(&child.args,
+					 "--restrict-revision=^%s",
+					 oid_to_hex(&opts->restrict_revision->object.oid));
+		if (opts->upstream)
+			argv_array_pushf(&child.args, "--upstream=%s",
+					 oid_to_hex(&opts->upstream->object.oid));
+		if (opts->onto)
+			argv_array_pushf(&child.args, "--onto=%s",
+					 oid_to_hex(&opts->onto->object.oid));
+		if (opts->squash_onto)
+			argv_array_pushf(&child.args, "--squash-onto=%s",
+					 oid_to_hex(opts->squash_onto));
+		if (opts->onto_name)
+			argv_array_pushf(&child.args, "--onto-name=%s",
+					 opts->onto_name);
+		argv_array_pushf(&child.args, "--head-name=%s",
+				 opts->head_name ?
+				 opts->head_name : "detached HEAD");
+		if (opts->strategy)
+			argv_array_pushf(&child.args, "--strategy=%s",
+					 opts->strategy);
+		if (opts->strategy_opts)
+			argv_array_pushf(&child.args, "--strategy-opts=%s",
+					 opts->strategy_opts);
+		if (opts->switch_to)
+			argv_array_pushf(&child.args, "--switch-to=%s",
+					 opts->switch_to);
+		if (opts->cmd)
+			argv_array_pushf(&child.args, "--cmd=%s", opts->cmd);
+		if (opts->allow_empty_message)
+			argv_array_push(&child.args, "--allow-empty-message");
+		if (opts->allow_rerere_autoupdate > 0)
+			argv_array_push(&child.args, "--rerere-autoupdate");
+		else if (opts->allow_rerere_autoupdate == 0)
+			argv_array_push(&child.args, "--no-rerere-autoupdate");
+		if (opts->gpg_sign_opt)
+			argv_array_push(&child.args, opts->gpg_sign_opt);
+		if (opts->signoff)
+			argv_array_push(&child.args, "--signoff");
+
+		status = run_command(&child);
+		goto finished_rebase;
+	}
+
 	add_var(&script_snippet, "GIT_DIR", absolute_path(get_git_dir()));
 	add_var(&script_snippet, "state_dir", opts->state_dir);
 
@@ -418,6 +498,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 	argv[0] = script_snippet.buf;
 
 	status = run_command_v_opt(argv, RUN_USING_SHELL);
+finished_rebase:
 	if (opts->dont_finish_rebase)
 		; /* do nothing */
 	else if (status == 0) {
-- 
gitgitgadget
