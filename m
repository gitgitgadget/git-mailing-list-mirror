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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D1A61F462
	for <e@80x24.org>; Wed, 24 Jul 2019 21:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfGXVVl (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 17:21:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36968 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfGXVVl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 17:21:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id i70so11093784pgd.4
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 14:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJCdKpQo5Hr8sG19zOUp5RSrWm2ad+/kIZJoGHxIkS8=;
        b=JtMa+GzvFt73x3L/HXKy6a0loFO5knzXR07dYYnVXKuXh61ivE2MThrDi42z4ZzmpQ
         GmUySmOYad/AJLAxVZfMDSwI6qCDqTecqrClioWtShxZzl3WPNrKGkAxubwrAhepPKgh
         LKnUpu4JzsHXrTqqySWt3mbrlG5Rz0/1Hus2WVadKiIAC9NWK25k8AKfJ2MrJbA06OyH
         CgNZrSoq0zcSL/FbVkwY2mitBgk02IAIGVUx85k8kjM7o3aCQeSmaxc18M4mioV8b3I8
         KLn0C2oCqYds+QY/iCf4m2uY8+sl5EVjtoxtzKoObc94QCJv8Wbr6vdjvCq7G8JuMDTt
         iA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJCdKpQo5Hr8sG19zOUp5RSrWm2ad+/kIZJoGHxIkS8=;
        b=PlSgvPWj+f0xbnRq5tE0f4H2p1fi3k5ENNLiEt9TEzas0pcFgfUzSVjM1kvxvCqp98
         DP9xWlmxK/W+1aSo3a6FwDbVSxk9ulnQbmHRqvZQFeg4aE8hsNilGoQZeBKTKHpY5zlO
         xC/kTJJLyFanAjDYc1dnv4ipbnkxjBLmLPzRWF0lauW3KH+MjVI/6ZIT6dG2/8YYibru
         PyH7+t8iKUnidkQIiIcq3ph8kyFoUKTrjvVwLktNBkMDuu98M5qg5SaeLQqUYSQ7iuuk
         m5ThglGRg8+wvagrsOhdusP3V2CQbc66FL4CByMyEo4wHyIC6RtLgKqjSe8wMH6zWs0x
         3c7w==
X-Gm-Message-State: APjAAAUZS2hx8IV39LpBcft4ANHO1ZeheW9/UYktXbszew9YVhCo2vp3
        N9BS3E2WRkicmBG2M88vUWo=
X-Google-Smtp-Source: APXvYqzfzh/z7+IVvh9qtvUrYGW1ev3iarUNYnvXsEYW6SOiN4ED/QCAcYUJMqjClAwiTRyXIGJOHw==
X-Received: by 2002:a17:90a:21ac:: with SMTP id q41mr91042021pjc.31.1564003300128;
        Wed, 24 Jul 2019 14:21:40 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.227])
        by smtp.gmail.com with ESMTPSA id i9sm46777405pgo.46.2019.07.24.14.21.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 14:21:39 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, phillip.wood123@gmail.com,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [GSoC][PATCH v3 0/1] rebase -i: add --ignore-whitespace flag
Date:   Thu, 25 Jul 2019 02:48:45 +0530
Message-Id: <20190724211846.18131-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190712185015.20585-1-rohit.ashiwal265@gmail.com>
References: <20190712185015.20585-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This revision removes --ignore-whitespace from rebase--interactive since its
only caller preserve-merges is now deprecated. Also rename t3431 to t3433.

Rohit Ashiwal (1):
  rebase -i: add --ignore-whitespace flag

 Documentation/git-rebase.txt            | 10 +++-
 builtin/rebase.c                        | 26 ++++++++--
 t/t3422-rebase-incompatible-options.sh  |  1 -
 t/t3433-rebase-options-compatibility.sh | 66 +++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 7 deletions(-)
 create mode 100755 t/t3433-rebase-options-compatibility.sh

Range-diff:
1:  a1bb91fe43 ! 1:  eef6f6fa25 rebase -i: add --ignore-whitespace flag
    @@ -42,6 +42,7 @@
       * --preserve-merges and --interactive
       * --preserve-merges and --signoff
       * --preserve-merges and --rebase-merges
    ++ * --preserve-merges and --ignore-whitespace
     + * --rebase-merges and --ignore-whitespace
       * --rebase-merges and --strategy
       * --rebase-merges and --strategy-option
    @@ -59,9 +60,19 @@
      	int autostash;
      	char *cmd;
     @@
    - 	flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
    - 	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
    + 		.git_format_patch_opt = STRBUF_INIT	\
    + 	}
    + 
    +-static struct replay_opts get_replay_opts(const struct rebase_options *opts)
    ++static struct replay_opts get_replay_opts(struct rebase_options *opts)
    + {
    + 	struct replay_opts replay = REPLAY_OPTS_INIT;
      
    +@@
    + 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
    + 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
    + 	replay.strategy = opts->strategy;
    ++
     +	if (opts->ignore_whitespace) {
     +		struct strbuf buf = STRBUF_INIT;
     +
    @@ -72,19 +83,9 @@
     +		free(opts->strategy_opts);
     +		opts->strategy_opts = strbuf_detach(&buf, NULL);
     +	}
    -+
    - 	switch (command) {
    - 	case ACTION_NONE: {
    - 		if (!opts->onto && !opts->upstream)
    -@@
    - 		{ OPTION_STRING, 'S', "gpg-sign", &opts.gpg_sign_opt, N_("key-id"),
    - 			N_("GPG-sign commits"),
    - 			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
    -+		OPT_BOOL(0, "ignore-whitespace", &opts.ignore_whitespace,
    -+			 N_("ignore changes in whitespace")),
    - 		OPT_STRING(0, "strategy", &opts.strategy, N_("strategy"),
    - 			   N_("rebase strategy")),
    - 		OPT_STRING(0, "strategy-opts", &opts.strategy_opts, N_("strategy-opts"),
    + 	if (opts->strategy_opts)
    + 		parse_strategy_opts(&replay, opts->strategy_opts);
    + 
     @@
      	argc = parse_options(argc, argv, NULL, options,
      			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
    @@ -133,18 +134,6 @@
      			die(_("cannot combine '--rebase-merges' with "
      			      "'--strategy-option'"));
     
    - diff --git a/sequencer.h b/sequencer.h
    - --- a/sequencer.h
    - +++ b/sequencer.h
    -@@
    - 	int verbose;
    - 	int quiet;
    - 	int reschedule_failed_exec;
    -+	int ignore_whitespace;
    - 
    - 	int mainline;
    - 
    -
      diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
      --- a/t/t3422-rebase-incompatible-options.sh
      +++ b/t/t3422-rebase-incompatible-options.sh
    @@ -157,10 +146,10 @@
      test_rebase_am_only -C4
      
     
    - diff --git a/t/t3431-rebase-options-compatibility.sh b/t/t3431-rebase-options-compatibility.sh
    + diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
      new file mode 100755
      --- /dev/null
    - +++ b/t/t3431-rebase-options-compatibility.sh
    + +++ b/t/t3433-rebase-options-compatibility.sh
     @@
     +#!/bin/sh
     +#
    @@ -184,7 +173,7 @@
     +	EOF
     +	git add file &&
     +	git commit -m "add file" &&
    -+	q_to_tab >file <<-EOF &&
    ++	cat >file <<-EOF &&
     +	line 1
     +	new line 2
     +	line 3
    @@ -193,7 +182,7 @@
     +	git tag side &&
     +
     +	git checkout --orphan master &&
    -+	q_to_tab >file <<-EOF &&
    ++	cat >file <<-EOF &&
     +	line 1
     +	        line 2
     +	line 3
-- 
2.21.0

