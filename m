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
	by dcvr.yhbt.net (Postfix) with ESMTP id C5EB41F461
	for <e@80x24.org>; Tue, 20 Aug 2019 03:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfHTDpr (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 23:45:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38597 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbfHTDpr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 23:45:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id e11so2383895pga.5
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 20:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NWjYGQw92Jvue0cTHJQvX41JImormDAsXdeExIl4mKA=;
        b=hEszwf32Fc6VlvQfP68AMY7CoTdt82nZKVIgsC/a00l7uZeVQAZguE3OaAHO46NiVD
         vkQrbqAfvfT2dSLBjYd4FyUasvsFA2IbuRzROSGZHhBdJafjKopiT3r/EjN3allPSCL8
         riw/3eI0a+VY0oL84qrKbYLLGPiK25nSwDfFN5oz+aiZer868N0X9pqapWj9U6/XOlDr
         Ost2ntMcRJz10wEWfPrlE8FcZrG+oTI5+B+Y8NgLsHrB4iz/6i9BkqaDJJwHbJquMp6V
         uSXmQtdisfz+RT8GDoakF9QpaV4G87GtaJyLjDZs3kGOMcvIQfVr/jLsuDuoKC5kVBj2
         xTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NWjYGQw92Jvue0cTHJQvX41JImormDAsXdeExIl4mKA=;
        b=FTBXtVonXBkpcPVqjtwcmDtLhoTd3mLTpLIWrUupvNZ1WqYSBYbL2UMOQirjubDH9M
         uBnRj9oC10zip1+0mS0p8OYMOY6C0M9crR43gQKWbgMoSZsmspcGWmv2P7e9AxQxGiGb
         WN9Iy/+ApdrFh2JYRcp2Hxr+kFoA5PpnlLmKzW0H2NG8T5Px6+QOVOJBow9hFCyODOTL
         RBV4AJpKPY6VRCR0HA7U8A4KJqdXOW5ksc55uanGmwkMbWHGuWM9wKgjSYhZcdkN2XlV
         WtOgXJh3/CXQ7CH/2Z/RN5qGX/h4YmfPyfl3T11CVcmbnq5qN07aSCSZcL09nm/X+may
         3NBg==
X-Gm-Message-State: APjAAAUDONtOQ6POPtVHjj4ajHNDwoKHEK9woZNA1c+u3o/wkoYahZzz
        UwikhD9BbCqW/K7KZwG9XfY=
X-Google-Smtp-Source: APXvYqxTwuJW4dNM4pJ0T+VO8wU+Z39jAzAY6n7exLZvO0VLJsGEOoOadEa3PSy4p8hgZ9Fe4zOjUg==
X-Received: by 2002:a17:90a:8b98:: with SMTP id z24mr24289230pjn.77.1566272745574;
        Mon, 19 Aug 2019 20:45:45 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.227])
        by smtp.gmail.com with ESMTPSA id v67sm30115686pfb.45.2019.08.19.20.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 20:45:44 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [PATCH v3 0/6] rebase -i: support more options
Date:   Tue, 20 Aug 2019 09:15:29 +0530
Message-Id: <20190820034536.13071-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've tries to incorporated all the suggestions.

Some points:
  - According to v2.0.0's git-am.sh, ignore-date should override
    committer-date-is-author-date. Ergo, we are not barfing out
    when both flags are provided.
  - Should the 'const' qualifier be removed[2]? Since it is leaving
    a false impression that author should not be free()'d.

[1]: git show v2.0.0:git-am.sh
[2]: https://github.com/git/git/blob/v2.23.0/sequencer.c#L959

Rohit Ashiwal (6):
  rebase -i: add --ignore-whitespace flag
  sequencer: add NULL checks under read_author_script
  rebase -i: support --committer-date-is-author-date
  sequencer: rename amend_author to author_to_rename
  rebase -i: support --ignore-date
  rebase: add --reset-author-date

 Documentation/git-rebase.txt            |  26 +++--
 builtin/rebase.c                        |  53 +++++++---
 sequencer.c                             | 135 ++++++++++++++++++++++--
 sequencer.h                             |   2 +
 t/t3422-rebase-incompatible-options.sh  |   2 -
 t/t3433-rebase-options-compatibility.sh | 100 ++++++++++++++++++
 6 files changed, 289 insertions(+), 29 deletions(-)
 create mode 100755 t/t3433-rebase-options-compatibility.sh

Range-diff:
1:  4cd0aa3084 ! 1:  e82ed8cad5 rebase -i: add --ignore-whitespace flag
    @@ -19,10 +19,13 @@
      default is `--no-fork-point`, otherwise the default is `--fork-point`.
      
      --ignore-whitespace::
    -+	This flag is either passed to the 'git apply' program
    -+	(see linkgit:git-apply[1]), or to 'git merge' program
    -+	(see linkgit:git-merge[1]) as `-Xignore-space-change`,
    -+	depending on which backend is selected by other options.
    ++	Behaves differently depending on which backend is selected.
    +++
    ++'am' backend: When applying a patch, ignore changes in whitespace in
    ++context lines if necessary.
    +++
    ++'interactive' backend: Treat lines with only whitespace changes as
    ++unchanged for the sake of a three-way merge.
     +
      --whitespace=<option>::
     -	These flag are passed to the 'git apply' program
    @@ -63,7 +66,7 @@
      
      static struct replay_opts get_replay_opts(const struct rebase_options *opts)
      {
    -+	char *strategy_opts = opts->strategy_opts;
    ++	struct strbuf strategy_buf = STRBUF_INIT;
      	struct replay_opts replay = REPLAY_OPTS_INIT;
      
      	replay.action = REPLAY_INTERACTIVE_REBASE;
    @@ -71,24 +74,19 @@
      	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
      	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
      	replay.strategy = opts->strategy;
    --	if (opts->strategy_opts)
    --		parse_strategy_opts(&replay, opts->strategy_opts);
    -+
    -+	if (opts->ignore_whitespace) {
    -+		struct strbuf buf = STRBUF_INIT;
    -+
    -+		if (strategy_opts)
    -+			strbuf_addstr(&buf, strategy_opts);
     +
    -+		strbuf_addstr(&buf, " --ignore-space-change");
    -+		free(strategy_opts);
    -+		strategy_opts = strbuf_detach(&buf, NULL);
    -+	}
    -+	if (strategy_opts)
    -+		parse_strategy_opts(&replay, strategy_opts);
    + 	if (opts->strategy_opts)
    +-		parse_strategy_opts(&replay, opts->strategy_opts);
    ++		strbuf_addstr(&strategy_buf, opts->strategy_opts);
    ++	if (opts->ignore_whitespace)
    ++		strbuf_addstr(&strategy_buf, " --ignore-space-change");
    ++	if (strategy_buf.len)
    ++		parse_strategy_opts(&replay, strategy_buf.buf);
      
    ++	strbuf_release(&strategy_buf);
      	return replay;
      }
    + 
     @@
      	argc = parse_options(argc, argv, prefix, options,
      			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
2:  e2c0304587 = 2:  209057b361 sequencer: add NULL checks under read_author_script
3:  6aed57ae2e ! 3:  a4e6644ef8 rebase -i: support --committer-date-is-author-date
    @@ -21,10 +21,12 @@
     +
      --ignore-date::
     -	These flags are passed to 'git am' to easily change the dates
    +-	of the rebased commits (see linkgit:git-am[1]).
     +	This flag is passed to 'git am' to change the author date
    - 	of the rebased commits (see linkgit:git-am[1]).
    ++	of each rebased commit (see linkgit:git-am[1]).
      +
      See also INCOMPATIBLE OPTIONS below.
    + 
     @@
      
      The following options:
    @@ -62,16 +64,6 @@
      	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
      	replay.strategy = opts->strategy;
      
    -@@
    - 		warning(_("--[no-]rebase-cousins has no effect without "
    - 			  "--rebase-merges"));
    - 
    -+	if (opts.committer_date_is_author_date)
    -+		opts.flags |= REBASE_FORCE;
    -+
    - 	return !!run_rebase_interactive(&opts, command);
    - }
    - 
     @@
      
      	if (opts->ignore_whitespace)
    @@ -149,14 +141,14 @@
     +		struct strbuf datebuf = STRBUF_INIT;
     +		char *date = read_author_date_or_null();
     +
    ++		if (!date)
    ++			return -1;
    ++
     +		strbuf_addf(&datebuf, "@%s", date);
     +		free(date);
     +
     +		date = strbuf_detach(&datebuf, &len);
    -+
    -+		if (len > 1)
    -+			res = setenv("GIT_COMMITTER_DATE", date, 1);
    -+
    ++		res = setenv("GIT_COMMITTER_DATE", date, 1);
     +		free(date);
     +
     +		if (res)
    @@ -187,7 +179,7 @@
     +		if (!ident.date_begin)
     +			return error(_("corrupted author without date information"));
     +
    -+		strbuf_addf(&date, "@%s",ident.date_begin);
    ++		strbuf_addf(&date, "@%s", ident.date_begin);
     +		setenv("GIT_COMMITTER_DATE", date.buf, 1);
     +		strbuf_release(&date);
     +	}
4:  36a0c017c2 = 4:  6ac1885c54 sequencer: rename amend_author to author_to_rename
5:  3a4ffeb995 ! 5:  a69749dd67 rebase -i: support --ignore-date
    @@ -16,9 +16,9 @@
      
      --ignore-date::
     -	This flag is passed to 'git am' to change the author date
    --	of the rebased commits (see linkgit:git-am[1]).
    -+	Instead of using the given author date, re-set it to the value
    -+	same as committer (current) date. This implies --force-rebase.
    +-	of each rebased commit (see linkgit:git-am[1]).
    ++	Instead of using the given author date, reset it to the value
    ++	same as the current time. This implies --force-rebase.
      +
      See also INCOMPATIBLE OPTIONS below.
      
    @@ -58,18 +58,6 @@
      	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
      	replay.strategy = opts->strategy;
      
    -@@
    - 		warning(_("--[no-]rebase-cousins has no effect without "
    - 			  "--rebase-merges"));
    - 
    --	if (opts.committer_date_is_author_date)
    -+	if (opts.ignore_date)
    -+		opts.committer_date_is_author_date = 0;
    -+	if (opts.committer_date_is_author_date ||
    -+	    opts.ignore_date)
    - 		opts.flags |= REBASE_FORCE;
    - 
    - 	return !!run_rebase_interactive(&opts, command);
     @@
      		argv_array_push(&am.args, "--ignore-whitespace");
      	if (opts->committer_date_is_author_date)
    @@ -125,18 +113,19 @@
      	return buf->buf;
      }
      
    -+static void ignore_author_date(const char **author)
    ++/* Construct a free()able author string with current time as the author date */
    ++static char *ignore_author_date(const char *author)
     +{
    -+	int len = strlen(*author);
    ++	int len = strlen(author);
     +	struct ident_split ident;
     +	struct strbuf new_author = STRBUF_INIT;
     +
    -+	split_ident_line(&ident, *author, len);
    ++	split_ident_line(&ident, author, len);
     +	len = ident.mail_end - ident.name_begin + 1;
     +
    -+	strbuf_addf(&new_author, "%.*s", len, *author);
    ++	strbuf_addf(&new_author, "%.*s ", len, author);
     +	datestamp(&new_author);
    -+	*author = strbuf_detach(&new_author, NULL);
    ++	return strbuf_detach(&new_author, NULL);
     +}
     +
     +static void push_dates(struct child_process *child)
    @@ -160,11 +149,13 @@
     -		else
     +		else {
     +			if (opts->ignore_date) {
    ++				char *new_author = ignore_author_date(author);
     +				if (!author)
     +					BUG("ignore-date can only be used with "
     +					    "rebase, which must set the author "
     +					    "before committing the tree");
    -+				ignore_author_date(&author);
    ++				free((void *)author);
    ++				author = new_author;
     +			}
      			res = commit_tree(msg.buf, msg.len, cache_tree_oid,
      					  NULL, &root_commit, author,
    @@ -187,7 +178,7 @@
      	reset_ident_date();
      
     +	if (opts->ignore_date) {
    -+		ignore_author_date(&author);
    ++		author = ignore_author_date(author);
     +		free(author_to_free);
     +		author_to_free = (char *)author;
     +	}
6:  cb81e6c4e5 ! 6:  210d15cca0 rebase: add --author-date-is-committer-date
    @@ -1,6 +1,6 @@
     Author: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
     
    -    rebase: add --author-date-is-committer-date
    +    rebase: add --reset-author-date
     
         The previous commit introduced --ignore-date flag to interactive
         rebase, but the name is actually very vague in context of rebase -i
    @@ -16,9 +16,9 @@
      	as the committer date. This implies --force-rebase.
      
      --ignore-date::
    -+--author-date-is-committer-date::
    - 	Instead of using the given author date, re-set it to the value
    - 	same as committer (current) date. This implies --force-rebase.
    ++--reset-author-date::
    + 	Instead of using the given author date, reset it to the value
    + 	same as the current time. This implies --force-rebase.
      +
     
      diff --git a/builtin/rebase.c b/builtin/rebase.c
    @@ -28,7 +28,7 @@
      		OPT_BOOL(0, "committer-date-is-author-date",
      			 &options.committer_date_is_author_date,
      			 N_("make committer date match author date")),
    -+		OPT_BOOL(0, "author-date-is-committer-date", &options.ignore_date,
    ++		OPT_BOOL(0, "reset-author-date", &options.ignore_date,
     +			 "ignore author date and use current date"),
      		OPT_BOOL(0, "ignore-date", &options.ignore_date,
      			 "ignore author date and use current date"),
-- 
2.21.0

