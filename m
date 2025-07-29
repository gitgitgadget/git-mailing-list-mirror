Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B693B1EA7C9
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772517; cv=none; b=ZFhlMT3THdO7rULp8UcG0sYrevB/CSReIvShCJEI55Cnc/FuN1UM6AVqAFWUSNhSZRK9CVFaTu0ByqmONILqOma8UnlynMQoBk5cPBtW8jiPVOapoOFYYFs9rf5UFQZqblM2C+eA0v26LSI+IGHzwIRZE3tsAKdXnZldWSg7UsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772517; c=relaxed/simple;
	bh=WTdiu2bnb2lFyeJkqAIRs1OVKzYW2bf++VzQf7fW+g4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wp12GxcHA6V3cepXsodgyfUImk9hKEhYPoNzTCPKkRiTm7jyaYur6GW0Dw65Lvt8teILQl2MMdx4a1EeH+8qRAYUT9x0M/KX+ARUci8Lk7g1YrW2zTvmp48BO3n7f3L/EY+9CMXesh8/Hv3kRTRvHXTppEY78se/AQj/btiQHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAwHvWcJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAwHvWcJ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4561ed868b5so33751295e9.0
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 00:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753772514; x=1754377314; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5y7kzOUNXW3yhqhYgsZ/oOp5AtqJyT3RlAy40ppUFjg=;
        b=CAwHvWcJVEnNtORrB9CB5AW/jxlSlII/AafbFpS5T6mRMsGo8FMhnHD2H4lroqdZ5s
         7zIC6WkYod9tgTGQ3vydhhsWDH8/+KW8qYdk9VTHaSLRxhepRpAdl5ZzHVJM699CjwfW
         LS2lypjrtvzhPQEg0uZuuwpDx9L2fOO6omLJnCB9BNAn9hIaPhToKf3NfHjZN8PDJiQG
         rdyosAYjEpjgjcrhbC6QJBbdAMXQeCVgHq71cqSiOSn3sjPXjzYo24NjjSz6oh5mjg8k
         Og/MBVpJ8mG+fb4zF/5E0nEXLPmTNbG6ka/D21xhJRR7qdm18Njm2Gdp+VHHg8mACvbH
         qlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753772514; x=1754377314;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5y7kzOUNXW3yhqhYgsZ/oOp5AtqJyT3RlAy40ppUFjg=;
        b=ElEKieuiwC1+QwaWmWyWvKqYuBz284QiBaatTPZ1ZrPepxNQGFvY2VHuWRaOAJTFh1
         QTzYXjiBDxa1B2GLJ9XqNis18AJbyL5G0STAK7vLPq8+qQWruidPfIGoDsDVeCTzbQQ8
         vnjcI2Vl3pm16do/WSPL4S/DibizzfAkdKUJtPvWCj3UMwkMaMgm5CvrviWI7OdBoOsw
         7dDCS8QxCJE5LX8eyIfiBxi1y15b6WFSAt9aEdiFVqkVvFQNpoWlodjyfC5qQOPD8l+X
         cEODkVIBhh70nCh7WpzAul/dT8WqN7hs7a6DwK8J1HhkakPcjxZX98uY+JDq3nRlXKIb
         NwAw==
X-Gm-Message-State: AOJu0Yy2uS7eVJPpQ2Ssj4KpCL1reFDhkcApUdIHw3cBoQtK5OdTb1jZ
	OyQnVXv37c9oVC1qyxf4kYRDPwRCpoczvHQaW2OB6CLGLPzFavqysiOwFm7jFQ==
X-Gm-Gg: ASbGncu0UQF+ujeFos7AGezcaLgUoYbh3g5XqKRVMprnlHUj63flNyODDJJbZ1Tb0ti
	oyJubJfGmzh4KcJzYH0dh963D4hNcmNDHrgMhuhUcz5eIVx2sQKxloGADkCKng+hEoeRp26JqvL
	JpLIJutHn4xLfRWIHe0Al+OASuFiffpOnuo9owedOsQ6b/iryR/CoAvZTumk11OTL9x2RJkti7I
	uiY4RP2APErRdBQ//s+hZfzlvDCfDPdK5l0UkOdGR3EarVQ/t/4oe+4Wpgl8AfwkInf02pg+YPv
	OpLUd6Wd0ALybXO9od1IEmMxhWoxoH2r1peXP491owUNJgcqsg3LEJLYmY1Q/M69aCmqvRPSNdD
	zONxIM2uw2ZwvkihEq1dzhTA=
X-Google-Smtp-Source: AGHT+IHso3IvSugDjPEnSSQs3kFdRdglSLKNX+MB/mnMlmVWUHKxTlgS16/uUSzUsz8Z3W+W0hJZuQ==
X-Received: by 2002:a05:600c:6812:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-458762fcfe9mr122842105e9.4.1753772513220;
        Tue, 29 Jul 2025 00:01:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78d45d152sm2477112f8f.3.2025.07.29.00.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 00:01:52 -0700 (PDT)
Message-Id: <pull.1915.v5.git.1753772511.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
References: <pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 29 Jul 2025 07:01:47 +0000
Subject: [PATCH v5 0/4] Better support for customising context lines in --patch commands
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Christian Couder <christian.couder@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>

This series of patches attempt to give --interactive/--patch compatible
builtins ("add", "commit", "checkout", "reset", "restore" and "stash")
better support and nicer experience for configuring how many context lines
are shown in diffs through a variety of ways.

Prior to these patches, the user could not choose how many context lines
they saw in --patch commands (apart from one workaround by using
GIT_DIFF_OPTS=-u<number> ..., however this isn't a good user experience or a
persistent solution). Additionally, the behaviour around reading from the
diff.context and diff.interHunkContext configs was also inconsistent with
other diff generating commands such as "log -p".

The summarised changes below hopefully make this experience better and fix
some inconsistencies:

 * diff.context and diff.interHunkContext configs are now respected by
   --patch compatible commands
 * --unified and --inter-hunk-context command line options have been added
   to --patch compatible commands (which take prescendence over file
   configs)
 * "add" and "commit" in --interactive mode now expose a new "context"
   subcommand which configures the amount of context lines you wish to see
   in subsequent diffs generated from other subcommands such as "patch" or
   "diff"

The original discussion for this can be read at:

 * https://lore.kernel.org/git/CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com/

Changes since v1:

 * Update commit descriptions
 * Update tests to use the more modern and robust test_grep and test_config
   utils
 * Reword some documentation / user messages
 * Ensure each commit is atomic and builds/passes tests on it's own
 * Make new command line options DRY
 * Add tests for interhunk context interaction
 * Error if context config/command line options are negative
 * Drop previous last commit to do with new subcommand for --interactive
   add/commit. My motivations behind this patch series originally where
   quite simple, just for add-patch commands to respect context configs.
   This subcommand, after the discussion in v1, will require more thought
   and a larger implementation that what I had anticipated. I would prefer
   to leave this for another time as it's the least impactful but the most
   time intensive and complicated idea.

Changes since v2:

 * Update tests to only test single command (following Philip's suggestion)
 * Add negative option checks
 * Minor commit re-wording

Changes since v3:

 * Update commit descriptions
 * Read struct properties directly instead of assigning to variables first
 * Simplify config setting / error checking
 * Remove redundant tests in later commit as they were replaced with better
   test(s)
 * Change tests to use single quotes (this messes with the grep so was
   unable to explicitly test single quotes in the error messages, so decided
   to use regex . instead, which is what some other tests that have this
   problem seem to use as well)

Changes since v4:

 * Add back tests to maintain good coverage and remove redundant tests

Leon Michalak (4):
  t: use test_grep in t3701 and t4055
  t: use test_config in t4055
  add-patch: respect diff.context configuration
  add-patch: add diff.context command line overrides

 Documentation/diff-context-options.adoc |  10 ++
 Documentation/git-add.adoc              |   2 +
 Documentation/git-checkout.adoc         |   2 +
 Documentation/git-commit.adoc           |   2 +
 Documentation/git-reset.adoc            |   2 +
 Documentation/git-restore.adoc          |   2 +
 Documentation/git-stash.adoc            |   2 +
 add-interactive.c                       |  45 +++++++--
 add-interactive.h                       |  17 +++-
 add-patch.c                             |  14 ++-
 builtin/add.c                           |  21 ++++-
 builtin/checkout.c                      |  31 +++++-
 builtin/commit.c                        |  16 +++-
 builtin/reset.c                         |  17 +++-
 builtin/stash.c                         |  56 ++++++++---
 commit.h                                |   3 +-
 parse-options.h                         |   2 +
 t/t3701-add-interactive.sh              | 119 +++++++++++++++++++-----
 t/t4055-diff-context.sh                 |  42 ++++-----
 t/t9902-completion.sh                   |   2 +
 20 files changed, 324 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/diff-context-options.adoc


base-commit: cf6f63ea6bf35173e02e18bdc6a4ba41288acff9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1915%2FNinjaInShade%2Finteractive-patch-context-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1915/NinjaInShade/interactive-patch-context-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1915

Range-diff vs v4:

 1:  bbb2bc7082b = 1:  bbb2bc7082b t: use test_grep in t3701 and t4055
 2:  feace2d3676 = 2:  feace2d3676 t: use test_config in t4055
 3:  994029d6602 = 3:  994029d6602 add-patch: respect diff.context configuration
 4:  2774b930406 ! 4:  9731e5b76fb add-patch: add diff.context command line overrides
     @@ parse-options.h: int parse_opt_tracking_mode(const struct option *, const char *
       	OPT_SET_INT_F('4', "ipv4", (v), N_("use IPv4 addresses only"), \
      
       ## t/t3701-add-interactive.sh ##
     -@@ t/t3701-add-interactive.sh: test_expect_success 'hunk splitting works with diff.suppressBlankEmpty' '
     - 	test_cmp expect actual
     +@@ t/t3701-add-interactive.sh: test_expect_success 'add -p rejects negative diff.context' '
     + 	test_grep "diff.context cannot be negative" output
       '
       
     --test_expect_success 'add -p respects diff.context' '
     --	test_write_lines a b c d e f g h i j k l m >file &&
      +for cmd in add checkout restore 'commit -m file'
      +do
      +	test_expect_success "${cmd%% *} accepts -U and --inter-hunk-context" '
     @@ t/t3701-add-interactive.sh: test_expect_success 'hunk splitting works with diff.
      +	test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
      +	git commit -m file file &&
      +	test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
     - 	git add file &&
     --	test_write_lines a b c d e f G h i j k l m >file &&
     --	echo y | git -c diff.context=5 add -p >actual &&
     --	test_grep "@@ -2,11 +2,11 @@" actual
     ++	git add file &&
      +	echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
      +		reset -p -U 4 --inter-hunk-context 2 >actual &&
      +	test_grep "@@ -2,20 +2,20 @@" actual
     - '
     - 
     --test_expect_success 'add -p respects diff.interHunkContext' '
     --	test_write_lines a b c d e f g h i j k l m n o p q r s >file &&
     --	git add file &&
     --	test_write_lines a b c d E f g i i j k l m N o p q r s >file &&
     --	echo y | git -c diff.interhunkcontext=2 add -p >actual &&
     --	test_grep "@@ -2,16 +2,16 @@" actual
     ++'
     ++
      +test_expect_success 'stash accepts -U and --inter-hunk-context' '
      +	test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
      +	git commit -m file file &&
     @@ t/t3701-add-interactive.sh: test_expect_success 'hunk splitting works with diff.
      +	echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
      +		stash -p -U 4 --inter-hunk-context 2 >actual &&
      +	test_grep "@@ -2,20 +2,20 @@" actual
     - '
     - 
     --test_expect_success 'add -p rejects negative diff.context' '
     --	test_config diff.context -1 &&
     --	test_must_fail git add -p 2>output &&
     --	test_grep "diff.context cannot be negative" output
     --'
     ++'
     ++
      +for cmd in add checkout commit reset restore "stash save" "stash push"
      +do
      +	test_expect_success "$cmd rejects invalid context options" '
     @@ t/t3701-add-interactive.sh: test_expect_success 'hunk splitting works with diff.
      +		test_grep -E ".--inter-hunk-context. requires .(--interactive/)?--patch." actual
      +	'
      +done
     - 
     - test_done
     -
     - ## t/t4055-diff-context.sh ##
     -@@ t/t4055-diff-context.sh: test_expect_success 'The -U option overrides diff.context' '
     - 	test_grep ! "^ firstline" output
     - '
     - 
     -+test_expect_success 'The -U option overrides diff.context for "add"' '
     -+	test_config diff.context 8 &&
     -+	git add -U4 -p >output &&
     -+	test_grep ! "^ firstline" output
     -+'
     -+
     -+test_expect_success 'The -U option overrides diff.context for "commit"' '
     -+	test_config diff.context 8 &&
     -+	! git commit -U4 -p >output &&
     -+	test_grep ! "^ firstline" output
     -+'
     -+
     -+test_expect_success 'The -U option overrides diff.context for "checkout"' '
     -+	test_config diff.context 8 &&
     -+	git checkout -U4 -p >output &&
     -+	test_grep ! "^ firstline" output
     -+'
      +
     -+test_expect_success 'The -U option overrides diff.context for "stash"' '
     -+	test_config diff.context 8 &&
     -+	! git stash -U4 -p >output &&
     -+	test_grep ! "^ firstline" output
     -+'
     -+
     -+test_expect_success 'The -U option overrides diff.context for "restore"' '
     -+	test_config diff.context 8 &&
     -+	git restore -U4 -p >output &&
     -+	test_grep ! "^ firstline" output
     -+'
     -+
     - test_expect_success 'diff.context honored by "diff"' '
     - 	test_config diff.context 8 &&
     - 	git diff >output &&
     + test_done
      
       ## t/t9902-completion.sh ##
      @@ t/t9902-completion.sh: test_expect_success 'double dash "git checkout"' '

-- 
gitgitgadget
