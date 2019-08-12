Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 468091F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 19:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfHLTqL (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 15:46:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43780 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLTqL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 15:46:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id r26so14058784pgl.10
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3vX2IPw4laS4eTLIdldBLluQZgVDQ1kAJ3qq+i+inYQ=;
        b=c/o5WmtApIrdcxg73YYSfYk14rObhhdrfRjNvIPupowvN8uM9qium02Bze9m1vXsWZ
         Wsj/lL1JpeaJRD8za6ZwJCt1pgMkNWcuhaghL3CjC0xcZQzERTeew8ctq1+qibML+mYt
         Pnlad8bSzXSQ2tOBqwoAqnUkwXzbHbEbpF+m5nRXzzc7B0dVdsXcOhL2iH7yAGo7Y0Yw
         bVtva/bJRHtNgVVgX3QAUmlObdHJ9ichI4dOtbBkZ2wyaaFRZe/tcpwvdUDn7GAW19vl
         C3thAo/K3xFothkMAZHiAfy7t9fPiwapGFsG3ALF/RjbhtXOV8cy9yPWxDkz/D/NzpqZ
         qSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3vX2IPw4laS4eTLIdldBLluQZgVDQ1kAJ3qq+i+inYQ=;
        b=LMEq5w3OpVMd+Aen4Ok97zZjZh9XLehX45W+0TVMTtY/d28ScIXIDJy4qbB0ck6rF/
         o0J7Whu2AqMeCc8QxklxjQ10M/1yl3j1tFkfogHiqUXRs0Sd8bRasww//HV2IRllOcS6
         ffPpHV9IJMv7WfrC5wZ6aPFyUypi94n2UVInI0ah9rNWGPPm91lpu7jXbQUiWlcFql/6
         xt0Yh56qs4c4CMacw9BWdykeJ/JYCQckI5cNIuZaw9QCa1Ed2UaBYnSMCNSSwm2sKIgG
         Xz6bXriYiSpRPuqPtCja72pFpc2Z/Ua+qnqCzLdhPhFSgqF6EVQVXnoJJtWu0FU9UCx/
         pucA==
X-Gm-Message-State: APjAAAUpycYlg5dDhgp3GWk0LmQzNetT1lO2DrmuKipGtM4gIOZ9GIzh
        8Qpv18y8sqleBcMv+Y74rbw=
X-Google-Smtp-Source: APXvYqw7vPh5O10leZXC8v30aNefOK4IMQJHygOLBOjoHq/awfTJUtFowfe0wDMVjgLYDQ4MHEE3KA==
X-Received: by 2002:a17:90a:b016:: with SMTP id x22mr883607pjq.116.1565639169363;
        Mon, 12 Aug 2019 12:46:09 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.228])
        by smtp.gmail.com with ESMTPSA id j187sm13275947pfg.178.2019.08.12.12.46.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 12:46:08 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [GSoC][PATCH v2 0/6] rebase -i: support more options
Date:   Tue, 13 Aug 2019 01:12:54 +0530
Message-Id: <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've tried to work on all the suggestion in this revision.

Based on: 2e27de94d485a6da0c8e264c165e55100f1a13a8 (tag: v2.23.0-rc2)

Rohit Ashiwal (6):
  rebase -i: add --ignore-whitespace flag
  sequencer: add NULL checks under read_author_script
  rebase -i: support --committer-date-is-author-date
  sequencer: rename amend_author to author_to_rename
  rebase -i: support --ignore-date
  rebase: add --author-date-is-committer-date

 Documentation/git-rebase.txt            |  23 +++--
 builtin/rebase.c                        |  66 +++++++++---
 sequencer.c                             | 132 ++++++++++++++++++++++--
 sequencer.h                             |   2 +
 t/t3422-rebase-incompatible-options.sh  |   2 -
 t/t3433-rebase-options-compatibility.sh | 100 ++++++++++++++++++
 6 files changed, 295 insertions(+), 30 deletions(-)
 create mode 100755 t/t3433-rebase-options-compatibility.sh

Range-diff:
1:  e213112385 ! 1:  4cd0aa3084 rebase -i: add --ignore-whitespace flag
    @@ -60,32 +60,35 @@
      	int autostash;
      	char *cmd;
     @@
    - 		.git_format_patch_opt = STRBUF_INIT	\
    - 	}
      
    --static struct replay_opts get_replay_opts(const struct rebase_options *opts)
    -+static struct replay_opts get_replay_opts(struct rebase_options *opts)
    + static struct replay_opts get_replay_opts(const struct rebase_options *opts)
      {
    ++	char *strategy_opts = opts->strategy_opts;
      	struct replay_opts replay = REPLAY_OPTS_INIT;
      
    + 	replay.action = REPLAY_INTERACTIVE_REBASE;
     @@
      	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
      	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
      	replay.strategy = opts->strategy;
    +-	if (opts->strategy_opts)
    +-		parse_strategy_opts(&replay, opts->strategy_opts);
     +
     +	if (opts->ignore_whitespace) {
     +		struct strbuf buf = STRBUF_INIT;
     +
    -+		if (opts->strategy_opts)
    -+			strbuf_addstr(&buf, opts->strategy_opts);
    ++		if (strategy_opts)
    ++			strbuf_addstr(&buf, strategy_opts);
     +
     +		strbuf_addstr(&buf, " --ignore-space-change");
    -+		free(opts->strategy_opts);
    -+		opts->strategy_opts = strbuf_detach(&buf, NULL);
    ++		free(strategy_opts);
    ++		strategy_opts = strbuf_detach(&buf, NULL);
     +	}
    - 	if (opts->strategy_opts)
    - 		parse_strategy_opts(&replay, opts->strategy_opts);
    ++	if (strategy_opts)
    ++		parse_strategy_opts(&replay, strategy_opts);
      
    + 	return replay;
    + }
     @@
      	argc = parse_options(argc, argv, prefix, options,
      			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
    @@ -165,14 +168,14 @@
     +# both the backends fall short of optimal behaviour.
     +test_expect_success 'setup' '
     +	git checkout -b topic &&
    -+	q_to_tab >file <<-EOF &&
    ++	q_to_tab >file <<-\EOF &&
     +	line 1
     +	Qline 2
     +	line 3
     +	EOF
     +	git add file &&
     +	git commit -m "add file" &&
    -+	cat >file <<-EOF &&
    ++	cat >file <<-\EOF &&
     +	line 1
     +	new line 2
     +	line 3
    @@ -181,10 +184,10 @@
     +	git tag side &&
     +
     +	git checkout --orphan master &&
    -+	cat >file <<-EOF &&
    -+	line 1
    -+	        line 2
    -+	line 3
    ++	sed -e "s/^|//" >file <<-\EOF &&
    ++	|line 1
    ++	|        line 2
    ++	|line 3
     +	EOF
     +	git add file &&
     +	git commit -m "add file" &&
    @@ -192,7 +195,7 @@
     +'
     +
     +test_expect_success '--ignore-whitespace works with am backend' '
    -+	cat >expect <<-EOF &&
    ++	cat >expect <<-\EOF &&
     +	line 1
     +	new line 2
     +	line 3
    @@ -204,7 +207,7 @@
     +'
     +
     +test_expect_success '--ignore-whitespace works with interactive backend' '
    -+	cat >expect <<-EOF &&
    ++	cat >expect <<-\EOF &&
     +	line 1
     +	new line 2
     +	line 3
2:  df13514788 = 2:  e2c0304587 sequencer: add NULL checks under read_author_script
3:  5735ec9ca2 ! 3:  6aed57ae2e rebase -i: support --committer-date-is-author-date
    @@ -140,31 +140,28 @@
      static const char *read_author_ident(struct strbuf *buf)
      {
     @@
    - 	return buf->buf;
    - }
    + {
    + 	struct child_process cmd = CHILD_PROCESS_INIT;
      
    -+static int setenv_committer_date_to_author_date(void)
    -+{
    -+	int res = 1;
    -+	char *date = read_author_date_or_null();
    ++	if (opts->committer_date_is_author_date) {
    ++		size_t len;
    ++		int res = -1;
    ++		struct strbuf datebuf = STRBUF_INIT;
    ++		char *date = read_author_date_or_null();
     +
    -+	if (date)
    -+		res = setenv("GIT_COMMITTER_DATE", date, 1);
    ++		strbuf_addf(&datebuf, "@%s", date);
    ++		free(date);
     +
    -+	free(date);
    -+	return res;
    -+}
    ++		date = strbuf_detach(&datebuf, &len);
     +
    - static const char staged_changes_advice[] =
    - N_("you have staged changes in your working tree\n"
    - "If these changes are meant to be squashed into the previous commit, run:\n"
    -@@
    - {
    - 	struct child_process cmd = CHILD_PROCESS_INIT;
    - 
    -+	if (opts->committer_date_is_author_date &&
    -+	    setenv_committer_date_to_author_date())
    -+		return 1;
    ++		if (len > 1)
    ++			res = setenv("GIT_COMMITTER_DATE", date, 1);
    ++
    ++		free(date);
    ++
    ++		if (res)
    ++			return -1;
    ++	}
      	if ((flags & CREATE_ROOT_COMMIT) && !(flags & AMEND_MSG)) {
      		struct strbuf msg = STRBUF_INIT, script = STRBUF_INIT;
      		const char *author = NULL;
    @@ -173,30 +170,31 @@
      	if (parse_head(r, &current_head))
      		return -1;
     -
    -+	if (!(flags & AMEND_MSG) && opts->committer_date_is_author_date &&
    -+	    setenv_committer_date_to_author_date())
    -+		return -1;
      	if (flags & AMEND_MSG) {
      		const char *exclude_gpgsig[] = { "gpgsig", NULL };
      		const char *out_enc = get_commit_output_encoding();
     @@
    - 			res = error(_("unable to parse commit author"));
    - 			goto out;
    - 		}
    -+		if (opts->committer_date_is_author_date) {
    -+			char *date;
    -+			int len = strlen(author);
    -+			char *idx = memchr(author, '>', len);
    + 		commit_list_insert(current_head, &parents);
    + 	}
    + 
    ++	if (opts->committer_date_is_author_date) {
    ++		int len = strlen(author);
    ++		struct ident_split ident;
    ++		struct strbuf date = STRBUF_INIT;
     +
    -+			++idx;
    -+			date = malloc(author + len - idx);
    -+			memcpy(date, idx, author + len - idx);
    -+			setenv("GIT_COMMITTER_DATE", date, 1);
    -+			free(date);
    -+		}
    - 		parents = copy_commit_list(current_head->parents);
    - 		extra = read_commit_extra_headers(current_head, exclude_gpgsig);
    - 	} else if (current_head) {
    ++		split_ident_line(&ident, author, len);
    ++
    ++		if (!ident.date_begin)
    ++			return error(_("corrupted author without date information"));
    ++
    ++		strbuf_addf(&date, "@%s",ident.date_begin);
    ++		setenv("GIT_COMMITTER_DATE", date.buf, 1);
    ++		strbuf_release(&date);
    ++	}
    ++
    + 	if (write_index_as_tree(&tree, r->index, r->index_file, 0, NULL)) {
    + 		res = error(_("git write-tree failed to write a tree"));
    + 		goto out;
     @@
      			opts->signoff = 1;
      		}
    @@ -271,18 +269,18 @@
      '
      
     +test_expect_success '--committer-date-is-author-date works with am backend' '
    -+	git rebase -f HEAD^ &&
    ++	git commit --amend &&
     +	git rebase --committer-date-is-author-date HEAD^ &&
    -+	git show HEAD --pretty="format:%at" >authortime &&
    -+	git show HEAD --pretty="format:%ct" >committertime &&
    ++	git show HEAD --pretty="format:%ai" >authortime &&
    ++	git show HEAD --pretty="format:%ci" >committertime &&
     +	test_cmp authortime committertime
     +'
     +
     +test_expect_success '--committer-date-is-author-date works with interactive backend' '
    -+	git rebase -f HEAD^ &&
    ++	git commit --amend &&
     +	git rebase -i --committer-date-is-author-date HEAD^ &&
    -+	git show HEAD --pretty="format:%at" >authortime &&
    -+	git show HEAD --pretty="format:%ct" >committertime &&
    ++	git show HEAD --pretty="format:%ai" >authortime &&
    ++	git show HEAD --pretty="format:%ci" >committertime &&
     +	test_cmp authortime committertime
     +'
     +
4:  cdcd66347b ! 4:  36a0c017c2 sequencer: rename amend_author to author_to_rename
    @@ -3,8 +3,9 @@
         sequencer: rename amend_author to author_to_rename
     
         The purpose of amend_author was to free() the malloc()'d string
    -    obtained from get_author(). But the name does not actually convey
    -    this purpose. Rename it to something meaningful.
    +    obtained from get_author() while amending a commit. But we can
    +    also use the variable to free() the author at our convenience.
    +    Rename it to convey this meaning.
     
         Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
     
5:  2f45a4e0b9 ! 5:  3a4ffeb995 rebase -i: support --ignore-date
    @@ -17,7 +17,7 @@
      --ignore-date::
     -	This flag is passed to 'git am' to change the author date
     -	of the rebased commits (see linkgit:git-am[1]).
    -+	Lie about the author date by re-setting it to the value
    ++	Instead of using the given author date, re-set it to the value
     +	same as committer (current) date. This implies --force-rebase.
      +
      See also INCOMPATIBLE OPTIONS below.
    @@ -63,6 +63,8 @@
      			  "--rebase-merges"));
      
     -	if (opts.committer_date_is_author_date)
    ++	if (opts.ignore_date)
    ++		opts.committer_date_is_author_date = 0;
     +	if (opts.committer_date_is_author_date ||
     +	    opts.ignore_date)
      		opts.flags |= REBASE_FORCE;
    @@ -93,6 +95,8 @@
      	}
      
     -	if (options.committer_date_is_author_date)
    ++	if (options.ignore_date)
    ++		options.committer_date_is_author_date = 0;
     +	if (options.committer_date_is_author_date ||
     +	    options.ignore_date)
      		options.flags |= REBASE_FORCE;
    @@ -118,33 +122,38 @@
      static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
      static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
     @@
    - 	return res;
    + 	return buf->buf;
      }
      
     +static void ignore_author_date(const char **author)
     +{
    ++	int len = strlen(*author);
    ++	struct ident_split ident;
     +	struct strbuf new_author = STRBUF_INIT;
    -+	char *idx = memchr(*author, '>', strlen(*author));
     +
    -+	strbuf_add(&new_author, *author, idx - *author);
    -+	strbuf_addstr(&new_author, "> ");
    ++	split_ident_line(&ident, *author, len);
    ++	len = ident.mail_end - ident.name_begin + 1;
    ++
    ++	strbuf_addf(&new_author, "%.*s", len, *author);
     +	datestamp(&new_author);
     +	*author = strbuf_detach(&new_author, NULL);
     +}
    ++
    ++static void push_dates(struct child_process *child)
    ++{
    ++	time_t now = time(NULL);
    ++	struct strbuf date = STRBUF_INIT;
    ++
    ++	strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
    ++	argv_array_pushf(&child->args, "--date=%s", date.buf);
    ++	argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
    ++	strbuf_release(&date);
    ++}
     +
      static const char staged_changes_advice[] =
      N_("you have staged changes in your working tree\n"
      "If these changes are meant to be squashed into the previous commit, run:\n"
     @@
    - {
    - 	struct child_process cmd = CHILD_PROCESS_INIT;
    - 
    --	if (opts->committer_date_is_author_date &&
    -+	if (opts->committer_date_is_author_date && !opts->ignore_date &&
    - 	    setenv_committer_date_to_author_date())
    - 		return 1;
    - 	if ((flags & CREATE_ROOT_COMMIT) && !(flags & AMEND_MSG)) {
    -@@
      
      		if (res <= 0)
      			res = error_errno(_("could not read '%s'"), defmsg);
    @@ -153,8 +162,8 @@
     +			if (opts->ignore_date) {
     +				if (!author)
     +					BUG("ignore-date can only be used with "
    -+					    "rebase -i, which must set the "
    -+					    "author before committing the tree");
    ++					    "rebase, which must set the author "
    ++					    "before committing the tree");
     +				ignore_author_date(&author);
     +			}
      			res = commit_tree(msg.buf, msg.len, cache_tree_oid,
    @@ -169,29 +178,11 @@
      	if (opts->gpg_sign)
      		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
     +	if (opts->ignore_date)
    -+		argv_array_pushf(&cmd.args, "--date=%ld", time(NULL));
    ++		push_dates(&cmd);
      	if (defmsg)
      		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
      	else if (!(flags & EDIT_MSG))
     @@
    - 	if (parse_head(r, &current_head))
    - 		return -1;
    - 	if (!(flags & AMEND_MSG) && opts->committer_date_is_author_date &&
    --	    setenv_committer_date_to_author_date())
    -+	    !opts->ignore_date && setenv_committer_date_to_author_date())
    - 		return -1;
    - 	if (flags & AMEND_MSG) {
    - 		const char *exclude_gpgsig[] = { "gpgsig", NULL };
    -@@
    - 			res = error(_("unable to parse commit author"));
    - 			goto out;
    - 		}
    --		if (opts->committer_date_is_author_date) {
    -+		if (opts->committer_date_is_author_date && !opts->ignore_date) {
    - 			char *date;
    - 			int len = strlen(author);
    - 			char *idx = memchr(author, '>', len);
    -@@
      
      	reset_ident_date();
      
    @@ -229,8 +220,7 @@
      		if (opts->gpg_sign)
      			argv_array_push(&cmd.args, opts->gpg_sign);
     +		if (opts->ignore_date)
    -+			argv_array_pushf(&cmd.args,
    -+					 "GIT_AUTHOR_DATE=%ld", time(NULL));
    ++			push_dates(&cmd);
      
      		/* Add the tips to be merged */
      		for (j = to_merge; j; j = j->next)
6:  8fa3da175c ! 6:  cb81e6c4e5 rebase: add --author-date-is-committer-date
    @@ -17,7 +17,7 @@
      
      --ignore-date::
     +--author-date-is-committer-date::
    - 	Lie about the author date by re-setting it to the value
    + 	Instead of using the given author date, re-set it to the value
      	same as committer (current) date. This implies --force-rebase.
      +
     
-- 
2.21.0

