Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F41720248
	for <e@80x24.org>; Wed, 17 Apr 2019 10:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbfDQKY4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 06:24:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40956 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731446AbfDQKY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 06:24:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id z24so2906203wmi.5
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 03:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=Sl3agnoIoDAyD4hQ3aXMEkWR6OjcNMimksCf5gM35vg=;
        b=QSddCKN61j5b/KMPvmNWwtgHLYZB0AExLQsjnGFaFCWh96lh8nXRVmlceBm7DjMbqY
         i9TTIgZJ5KzojJj+SKXAUlj+7Wo6HPsz5P8p/s+Cn75uYk6ohCXuU3ISzceFctvSLAqO
         op5cu4j5eg/6Mvcq0mjoBafJWD6bm9CsVx9Asnbex9CvIqBv0vNzKQjJ6NKbcmMGtaw6
         +uyryDKfwhKAqQMllfGhmcXlVDfm+3TM78rsZNNhMDFuaGSbTcIciQxYJ8S163Xfy9Y3
         2i9jRNTyAMmlekfOYDWgm0Wi1plXb8ElPUjhyLEZVWLttgsLnyRMu9LSSuDqJMT87JHE
         Y7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=Sl3agnoIoDAyD4hQ3aXMEkWR6OjcNMimksCf5gM35vg=;
        b=h/4vaaFzegjYoiOSyu9ptQeaj4laAYAzilDAJkh9Jq3VKVBjPViBXd4B9k5CR3OkBs
         1JIvpsj5fHobW819+b6yAVL4cLzTY3PO1M2Ik4ur6SHSuqa/8gSHnDyN+akRneDN+N5s
         2i98giPqvTIiPyORi2Q0n+t+JTc/MRug7IRqSmCdw/cHajgIMqeIuX23hxPHZ8j7JlGs
         B0+D7HCLMCJTcWD1+lKzPr5npCm/NNf0++aFQjJShxWCPYZYOJzdNavDffRDR3296dWF
         yODBY1JH+rQ5I+SOviOc6MC21oRhNDYgeSERqA4beeUnEDCkNM0dlfHkcZQfLPjfaJud
         sX4Q==
X-Gm-Message-State: APjAAAWnYsTYKi8T8HQ8gR5Vw5udM3vtWdQCiexZSODUqjkbcFLQtJnG
        MTXln5FDZeHIxaJYe6hVDvPW7Smz9zQ=
X-Google-Smtp-Source: APXvYqx1j6NCU/UGdkTgmOEoASvbulqzk8d2/uK4rspniNuJYMn5mJa2tujfn+fFAO/3CwtcxkAzxg==
X-Received: by 2002:a1c:480b:: with SMTP id v11mr30049415wma.25.1555496693069;
        Wed, 17 Apr 2019 03:24:53 -0700 (PDT)
Received: from lindisfarne.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id a11sm53399903wrx.5.2019.04.17.03.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 03:24:52 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v10 00/10] Fix scissors bug during conflict
Date:   Wed, 17 Apr 2019 11:23:20 +0100
Message-Id: <20190417102330.24434-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553150827.git.liu.denton@gmail.com>
References: <cover.1553150827.git.liu.denton@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

With Denton's blessing I've rebased his patches on top of my patch to
fix the message cleanup with cherry-pick --signoff and -x [1]. I've
also refactored a couple of the patches and cleaned up the coding
style in places. The refactoring aims to simplify the code that deals
with saving and restoring the cleanup option for cherry-pick/revert
and improve the --cleanup option handling/parsing in builtin/merge.c
and builtin/pull.c. I've dropped patch 7 as it didn't sit well with
the new opts->explicit_cleanup added by [1]. I think it is easier just
to keep the existing code in the sequencer for parsing the cleanup
option rather trying to create a single function that does two
slightly different things.

Apologies to those of you that received some of these patches
yesterday when I was sending them to Denton, I didn't realize that
send-email "helpfully" cc'd people in the *-by: footers.

Best Wishes

Phillip

[1] https://public-inbox.org/git/20190329110842.30604-1-phillip.wood123@gmail.com/

Denton Liu (10):
  t7600: clean up style
  t3507: clean up style
  t7604: clean up style
  t7502: clean up style
  commit: extract cleanup_mode functions to sequencer
  parse-options.h: extract common --cleanup option
  merge: cleanup messages like commit
  merge: add scissors line on merge conflict
  sequencer.c: save and restore cleanup mode
  cherry-pick/revert: add scissors line on merge conflict

 Documentation/git-cherry-pick.txt |   7 ++
 Documentation/git-revert.txt      |   7 ++
 Documentation/merge-options.txt   |   7 ++
 builtin/commit.c                  |  49 +++++-------
 builtin/merge.c                   |  51 +++++++++---
 builtin/pull.c                    |  12 +++
 builtin/revert.c                  |   7 ++
 builtin/tag.c                     |   3 +-
 parse-options.h                   |   1 +
 sequencer.c                       |  73 +++++++++++++++--
 sequencer.h                       |   9 ++-
 t/t3507-cherry-pick-conflict.sh   | 128 +++++++++++++++++++++++++-----
 t/t5521-pull-options.sh           |   8 ++
 t/t7502-commit-porcelain.sh       |  93 ++++++++++++----------
 t/t7600-merge.sh                  |  73 +++++++++++++----
 t/t7604-merge-custom-message.sh   |  75 +++++++++++++++--
 wt-status.c                       |  12 ++-
 wt-status.h                       |   1 +
 18 files changed, 484 insertions(+), 132 deletions(-)

Range-diff to pu
 1:  32caff17f2 !  1:  e660dff207 t7600: clean up style
    @@ -13,7 +13,6 @@
         Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
      --- a/t/t7600-merge.sh
 2:  9af8efc5c2 !  2:  86ae21aff9 t3507: clean up style
    @@ -8,7 +8,6 @@
     
         Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
      --- a/t/t3507-cherry-pick-conflict.sh
 3:  7d4e0b5f24 !  3:  6f3e0fcd3b t7604: clean up style
    @@ -11,7 +11,6 @@
         Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
      --- a/t/t7604-merge-custom-message.sh
 4:  6743bfce4b !  4:  fa41595854 t7502: clean up style
    @@ -10,7 +10,6 @@
         Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
      --- a/t/t7502-commit-porcelain.sh
 5:  9e699bcc45 !  5:  3e87ab3176 commit: extract cleanup_mode functions to sequencer
    @@ -3,7 +3,6 @@
         commit: extract cleanup_mode functions to sequencer
     
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/builtin/commit.c b/builtin/commit.c
      --- a/builtin/commit.c
 6:  4753ea288a !  6:  d042d82f4f parse-options.h: extract common --cleanup option
    @@ -7,7 +7,6 @@
     
         Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/builtin/commit.c b/builtin/commit.c
      --- a/builtin/commit.c
 7:  f2feeefc50 <  -:  ---------- sequencer.c: remove duplicate code
 8:  b4ad22cdb6 !  7:  c4821d47fc merge: cleanup messages like commit
    @@ -6,18 +6,17 @@
         commit.cleanup configuration or --cleanup option, just like how
         git-commit does it.
     
    -    We also give git-pull the passthrough option of --cleanup so that it can
    -    also take advantage of this change.
    +    We also give git-pull the option of --cleanup so that it can also take
    +    advantage of this change.
     
         Finally, add testing to ensure that messages are properly cleaned up.
         Note that some newlines that were added to the commit message were
         removed so that if a file were read via -F, it would be copied
         faithfully.
     
    -    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Helped-by: Eric Sunshine <sunshine@sunshineco.com>
    +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
      --- a/Documentation/merge-options.txt
    @@ -99,10 +98,10 @@
     -		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
     +	if (0 < option_edit) {
     +		strbuf_addch(&msg, '\n');
    -+		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
    ++		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
     +			wt_status_append_cut_line(&msg);
    -+
    -+		strbuf_commented_addf(&msg, "\n");
    ++			strbuf_commented_addf(&msg, "\n");
    ++		}
     +		strbuf_commented_addf(&msg, _(merge_editor_comment));
     +		strbuf_commented_addf(&msg, _(cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS ?
     +			scissors_editor_comment :
    @@ -129,11 +128,24 @@
      	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
      			&result_commit, NULL, sign_commit))
     @@
    - 	if (option_edit < 0)
    - 		option_edit = default_edit_option();
    + 	}
    + 	resolve_undo_clear();
      
    -+	cleanup_mode = get_cleanup_mode(cleanup_arg, 0 < option_edit, 1);
    ++	if (option_edit < 0)
    ++		option_edit = default_edit_option();
     +
    ++	cleanup_mode = get_cleanup_mode(cleanup_arg, 0 < option_edit);
    ++
    + 	if (verbosity < 0)
    + 		show_diffstat = 0;
    + 
    +@@
    + 			fast_forward = FF_NO;
    + 	}
    + 
    +-	if (option_edit < 0)
    +-		option_edit = default_edit_option();
    +-
      	if (!use_strategies) {
      		if (!remoteheads)
      			; /* already up-to-date */
    @@ -153,48 +165,37 @@
      static char *opt_squash;
      static char *opt_commit;
      static char *opt_edit;
    -+static char *opt_cleanup;
    ++static char *cleanup_arg;
      static char *opt_ff;
      static char *opt_verify_signatures;
      static int opt_autostash = -1;
     @@
      	OPT_PASSTHRU(0, "edit", &opt_edit, NULL,
      		N_("edit message before committing"),
      		PARSE_OPT_NOARG),
    -+	OPT_PASSTHRU(0, "cleanup", &opt_cleanup, NULL,
    -+		N_("how to strip spaces and #comments from message"),
    -+		0),
    ++	OPT_CLEANUP(&cleanup_arg),
      	OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
      		N_("allow fast-forward"),
      		PARSE_OPT_NOARG),
     @@
      		argv_array_push(&args, opt_commit);
      	if (opt_edit)
      		argv_array_push(&args, opt_edit);
    -+	if (opt_cleanup)
    -+		argv_array_push(&args, opt_cleanup);
    ++	if (cleanup_arg)
    ++		argv_array_pushf(&args, "--cleanup=%s", cleanup_arg);
      	if (opt_ff)
      		argv_array_push(&args, opt_ff);
      	if (opt_verify_signatures)
     @@
      
      	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
      
    -+	if (opt_cleanup) {
    -+		const char *prefix = "--cleanup=";
    -+		const char *cleanup_arg;
    -+
    -+		if (strncmp(opt_cleanup, prefix, strlen(prefix)))
    -+			BUG("expecting prefix %s, argument is %s", prefix, opt_cleanup);
    -+
    -+		cleanup_arg = &opt_cleanup[strlen(prefix)];
    -+
    ++	if (cleanup_arg)
     +		/*
     +		 * this only checks the validity of cleanup_arg; we don't need
     +		 * a valid value for use_editor
     +		 */
    -+		get_cleanup_mode(cleanup_arg, 0, 1);
    -+	}
    ++		get_cleanup_mode(cleanup_arg, 0);
     +
      	parse_repo_refspecs(argc, argv, &repo, &refspecs);
      
 9:  7bd6d4370f !  8:  4ad58797e4 merge: add scissors line on merge conflict
    @@ -11,7 +11,6 @@
     
         Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
      --- a/Documentation/merge-options.txt
    @@ -61,7 +60,9 @@
      			die_errno(_("could not read MERGE_MSG"));
     +
     +		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
    -+		    wt_status_locate_end(sb.buf + merge_msg_start, sb.len - merge_msg_start) < sb.len - merge_msg_start)
    ++		    wt_status_locate_end(sb.buf + merge_msg_start,
    ++					 sb.len - merge_msg_start) <
    ++				sb.len - merge_msg_start)
     +			merge_contains_scissors = 1;
      	} else if (!stat(git_path_squash_msg(the_repository), &statbuf)) {
      		if (strbuf_read_file(&sb, git_path_squash_msg(the_repository), 0) < 0)
    @@ -103,10 +104,10 @@
     +	 * We can't use cleanup_mode because if we're not using the editor,
     +	 * get_cleanup_mode will return COMMIT_MSG_CLEANUP_SPACE instead, even
     +	 * though the message is meant to be processed later by git-commit.
    -+	 * Thus, we will get the cleanup mode which is returned when we _are_ using
    -+	 * an editor.
    ++	 * Thus, we will get the cleanup mode which is returned when we _are_
    ++	 * using an editor.
     +	 */
    -+	if (get_cleanup_mode(cleanup_arg, 1, 1) == COMMIT_MSG_CLEANUP_SCISSORS) {
    ++	if (get_cleanup_mode(cleanup_arg, 1) == COMMIT_MSG_CLEANUP_SCISSORS) {
     +	    fputc('\n', fp);
     +	    wt_status_add_cut_line(fp);
     +	    /* comments out the newline from append_conflicts_hint */
10:  8805d809d4 <  -:  ---------- sequencer.c: define describe_cleanup_mode
 -:  ---------- >  9:  b3136d4fae sequencer.c: save and restore cleanup mode
11:  b86bb747c9 ! 10:  582f842b9e cherry-pick/revert: add scissors line on merge conflict
    @@ -8,7 +8,6 @@
     
         Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
      --- a/Documentation/git-cherry-pick.txt
    @@ -50,38 +49,23 @@
      --- a/builtin/merge.c
      +++ b/builtin/merge.c
     @@
    - 	 * Thus, we will get the cleanup mode which is returned when we _are_ using
    - 	 * an editor.
    + 	 * Thus, we will get the cleanup mode which is returned when we _are_
    + 	 * using an editor.
      	 */
    --	if (get_cleanup_mode(cleanup_arg, 1, 1) == COMMIT_MSG_CLEANUP_SCISSORS) {
    +-	if (get_cleanup_mode(cleanup_arg, 1) == COMMIT_MSG_CLEANUP_SCISSORS) {
     -	    fputc('\n', fp);
     -	    wt_status_add_cut_line(fp);
     -	    /* comments out the newline from append_conflicts_hint */
     -	    fputc(comment_line_char, fp);
     -	}
     -
     -	append_conflicts_hint(&the_index, &msgbuf);
    -+	append_conflicts_hint(&the_index, &msgbuf, get_cleanup_mode(cleanup_arg, 1, 1));
    ++	append_conflicts_hint(&the_index, &msgbuf,
    ++			      get_cleanup_mode(cleanup_arg, 1));
      	fputs(msgbuf.buf, fp);
      	strbuf_release(&msgbuf);
      	fclose(fp);
     
    - diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
    - --- a/builtin/rebase--interactive.c
    - +++ b/builtin/rebase--interactive.c
    -@@
    - 		OPT_END()
    - 	};
    - 
    -+	opts.action = REPLAY_INTERACTIVE_REBASE;
    - 	sequencer_init_config(&opts);
    - 	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
    - 
    --	opts.action = REPLAY_INTERACTIVE_REBASE;
    - 	opts.allow_ff = 1;
    - 	opts.allow_empty = 1;
    - 
    -
      diff --git a/builtin/revert.c b/builtin/revert.c
      --- a/builtin/revert.c
      +++ b/builtin/revert.c
    @@ -103,8 +87,10 @@
      	if (opts->keep_redundant_commits)
      		opts->allow_empty = 1;
      
    -+	if (cleanup_arg)
    -+		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1, 1);
    ++	if (cleanup_arg) {
    ++		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1);
    ++		opts->explicit_cleanup = 1;
    ++	}
     +
      	/* Check for incompatible command line arguments */
      	if (cmd) {
    @@ -114,44 +100,20 @@
      --- a/sequencer.c
      +++ b/sequencer.c
     @@
    - 	{ NULL, 0, 0 }
    - };
    - 
    -+static inline int is_rebase_i(const struct replay_opts *opts)
    -+{
    -+	return opts->action == REPLAY_INTERACTIVE_REBASE;
    -+}
    -+
    - static int git_sequencer_config(const char *k, const char *v, void *cb)
    - {
    - 	struct replay_opts *opts = cb;
    -@@
    - 		if (status)
    - 			return status;
    - 
    --		opts->default_msg_cleanup = get_cleanup_mode(s, 0, 0);
    -+		opts->default_msg_cleanup = get_cleanup_mode(s, !is_rebase_i(opts), 0);
    - 
    - 		free((char *)s);
    - 		return status;
    -@@
    - 	git_config(git_sequencer_config, opts);
    - }
    - 
    --static inline int is_rebase_i(const struct replay_opts *opts)
    --{
    --	return opts->action == REPLAY_INTERACTIVE_REBASE;
    --}
    --
    - static const char *get_dir(const struct replay_opts *opts)
    - {
    - 	if (is_rebase_i(opts))
    + 			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_ALL;
    + 			opts->explicit_cleanup = 1;
    + 		} else if (!strcmp(s, "scissors")) {
    +-			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
    ++			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SCISSORS;
    + 			opts->explicit_cleanup = 1;
    + 		} else {
    + 			warning(_("invalid commit message cleanup mode '%s'"),
     @@
      }
      
      void append_conflicts_hint(struct index_state *istate,
     -			   struct strbuf *msgbuf)
    -+		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode)
    ++	struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode)
      {
      	int i;
      
    @@ -169,10 +131,28 @@
      
      	if (!clean)
     -		append_conflicts_hint(r->index, msgbuf);
    -+		append_conflicts_hint(r->index, msgbuf, opts->default_msg_cleanup);
    ++		append_conflicts_hint(r->index, msgbuf,
    ++				      opts->default_msg_cleanup);
      
      	return !clean;
      }
    +@@
    + 			  unsigned int flags)
    + {
    + 	struct child_process cmd = CHILD_PROCESS_INIT;
    +-	const char *value;
    + 
    + 	if ((flags & CREATE_ROOT_COMMIT) && !(flags & AMEND_MSG)) {
    + 		struct strbuf msg = STRBUF_INIT, script = STRBUF_INIT;
    +@@
    + 		argv_array_push(&cmd.args, "-e");
    + 	else if (!(flags & CLEANUP_MSG) &&
    + 		 !opts->signoff && !opts->record_origin &&
    +-		 git_config_get_value("commit.cleanup", &value))
    ++		 !opts->explicit_cleanup)
    + 		argv_array_push(&cmd.args, "--cleanup=verbatim");
    + 
    + 	if ((flags & ALLOW_EMPTY))
     
      diff --git a/sequencer.h b/sequencer.h
      --- a/sequencer.h
    @@ -185,7 +165,7 @@
     +void append_conflicts_hint(struct index_state *istate,
     +		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode);
      enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
    - 	int use_editor, int die_on_error);
    + 	int use_editor);
      
     
      diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh


-- 
2.21.0

