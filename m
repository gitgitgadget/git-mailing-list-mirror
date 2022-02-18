Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B25C433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 18:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbiBRSXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 13:23:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbiBRSXg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 13:23:36 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3F94839F
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:23:17 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m27so4158204wrb.4
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=t7b3m9Rq2KN5IYcg8WPU2Bd4mc+yvSDKynkTm6DTCxs=;
        b=ef/xKUG2eHpeGyMNpxayaUJ/5Eqt51Y16MDIi/exewm3+k7WINOKbADjSiI0f0kaJj
         203BLK4wlWB3EFXO62Jk/onLGjze3+jX8yKewLWA9Ii9NmzNx0O0VHJ+3EPP1KZ6EqZZ
         s+njjCQNWFr9r8NlblOgpCXfz1qVcT/4mjf5DRc1bHzVCXodz1iSygAGTRRKNig/CXxz
         KjNfeqhfo/s36Emuy0ezLaQIyVru7pSpZP0KE9IoxL5AYlSrbDElM9srhBwd55K6feey
         HPNdU5XT8VnrzP4Zn1T0LpT5CzGzNxEumUlGWRji6RvSe6YenhKOxerI7UAj7iGtd6ke
         hSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=t7b3m9Rq2KN5IYcg8WPU2Bd4mc+yvSDKynkTm6DTCxs=;
        b=W1ojdGU6iwdeVmBF7AvYtQJjUJD9S/W6rYkAbZbbuhPh2X0eaZ4k/6k63zp2Uy7Gyc
         MayEZkOXreNk0Y/DsGD+k8ZkHSJ320t+q396fed+Zhq+JKXdvSzmxjjzjPWo/4neuVq4
         KW+stwdA2IB/sAfQF4rPGj/bJK9b9U4ORd6ngYtLRpoAMdAoXjZTtty2g9MrW7Dzh784
         S48/sEEenqt6UxEEAFQIwbMK7GMqN6ndp08rDcKvILK0h8rTRXP8jiBTn420DvYUrZxX
         Wrj21yqB0x2L/tb9aVJaRhQJt3Z0zbsAlG+v2xCeexHi+u0pKkm6Ml29Gs1MV3spxaRW
         C+Vg==
X-Gm-Message-State: AOAM530AXxO1fW19U7gLrc+pnPMUqxx8YRyWa2aNN3d9xVFGBavvAItA
        liTImUnIfnJ2SvfyRSbn9NBhFJ50qFo=
X-Google-Smtp-Source: ABdhPJzWXBnsileDcoiw6S0IOqBExBWIzCF7dcjfDVi4rEzV2J76Rn/iTVk7DUAErSpe/UfA/+/Eig==
X-Received: by 2002:a05:6000:23b:b0:1e4:a4d1:a9f3 with SMTP id l27-20020a056000023b00b001e4a4d1a9f3mr7079538wrz.278.1645208596006;
        Fri, 18 Feb 2022 10:23:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b00354d399ef32sm83578wmq.39.2022.02.18.10.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:23:15 -0800 (PST)
Message-Id: <pull.1212.v10.git.git.1645208594.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
References: <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Feb 2022 18:23:10 +0000
Subject: [PATCH v10 0/4] Add cat-file --batch-command flag
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The feature proposal of adding a command interface to cat-file was first
discussed in [A]. In [B], Taylor expressed the need for a fuller proposal
before moving forward with a new flag. An RFC was created [C] and the idea
was discussed more thoroughly, and overall it seemed like it was headed in
the right direction.

This patch series consolidates the feedback from these different threads.

This patch series has four parts:

 1. preparation patch to rename a variable
 2. adding an enum to keep track of batch modes
 3. add a remove_timestamp() helper that takes stdin and removes timestamps
 4. logic to handle --batch-command flag, adding contents, info, flush
    commands

Changes since v9

 * add test to exercise format for batch-command
 * minor semantic improvements
 * removed README entry for environment variable used in test

Changes since v8

 * have caller free line through a helper function for the sake of
   separation of concerns

Changes since v7

 * revert back to having caller set nr to 0
 * add comment before dispatch_calls to clarify usage of helper
 * rename prefix->name

Changes since v6 (thanks to Eric's feedback)

 * allow command parsing logic to handle the case of flush as well
 * fixed documentation by adding --batch-command to the synopsis and
   adjusting tick marks
 * set nr=0 within helper function

Changes since v5

 * replaced flush tests that used fifo pipes to using a GIT_TEST_ env
   variable to control whether or not --batch-command flushes on exit.
 * added remove_timestamp helper in tests.
 * added documentation to show format can be used with --batch-command

Changes since v4

 * added Phillip's suggested test for testing flush. This should have
   addressed the flaky test that was hanging. I tested it on my side and
   wasn't able to reproduce the deadlock.
 * plugged some holes in the logic that parsed the command and arguments,
   thanks to Eric's feedback
 * fixed verbiage in commit messages per Christian's feedback
 * clarified places in documentation that should mention --batch-command per
   Eric's feedback

Changes since v3 (thanks to Junio's feedback):

 * added cascading logic in batch_options_callback()
 * free memory for queued call input lines
 * do not throw error when flushing an empty queue
 * renamed cmds array to singular queued_cmd
 * fixed flaky test that failed --stress

Changes since v2:

 * added enum to keep track of which batch mode we are in (thanks to Junio's
   feedback)
 * fixed array allocation logic (thanks to Junio's feedback)
 * added code to flush commands when --batch-commands receives an EOF and
   exits (thanks to Phillip's feedback)
 * fixed docs formatting (thanks to Jonathan's feedback)

Changes since v1:

 * simplified "session" mechanism. "flush" will execute all commands that
   were entered in since the last "flush" when in --buffer mode
 * when not in --buffer mode, each command is executed and flushed each time
 * rename cmdmode to transform_mode instead of just mode
 * simplified command parsing logic
 * changed rename of cmdmode to transform_mode
 * clarified verbiage in commit messages

A. https://lore.kernel.org/git/xmqqk0hitnkc.fsf@gitster.g/ B.
https://lore.kernel.org/git/YehomwNiIs0l83W7@nand.local/ C.
https://lore.kernel.org/git/e75ba9ea-fdda-6e9f-4dd6-24190117d93b@gmail.com/

John Cai (4):
  cat-file: rename cmdmode to transform_mode
  cat-file: introduce batch_mode enum to replace print_contents
  cat-file: add remove_timestamp helper
  cat-file: add --batch-command mode

 Documentation/git-cat-file.txt |  42 +++++++-
 builtin/cat-file.c             | 178 ++++++++++++++++++++++++++++++---
 t/t1006-cat-file.sh            | 135 +++++++++++++++++++++++--
 3 files changed, 333 insertions(+), 22 deletions(-)


base-commit: b80121027d1247a0754b3cc46897fee75c050b44
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1212%2Fjohn-cai%2Fjc-cat-file-batch-command-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1212/john-cai/jc-cat-file-batch-command-v10
Pull-Request: https://github.com/git/git/pull/1212

Range-diff vs v9:

 1:  76d6e4fe517 = 1:  76d6e4fe517 cat-file: rename cmdmode to transform_mode
 2:  12084a335cb = 2:  12084a335cb cat-file: introduce batch_mode enum to replace print_contents
 3:  bf74b6cd75b = 3:  bf74b6cd75b cat-file: add remove_timestamp helper
 4:  dbe194f8a85 ! 4:  c6ea1214062 cat-file: add --batch-command mode
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +	fflush(stdout);
      +}
      +
     -+static void free_cmds(struct queued_cmd *cmd, int nr)
     ++static void free_cmds(struct queued_cmd *cmd, size_t *nr)
      +{
     -+	int i;
     ++	size_t i;
      +
     -+	for (i = 0; i < nr; i++)
     ++	for (i = 0; i < *nr; i++)
      +		FREE_AND_NULL(cmd[i].line);
     ++
     ++	*nr = 0;
      +}
      +
      +
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +
      +		if (!strcmp(cmd->name, "flush")) {
      +			dispatch_calls(opt, output, data, queued_cmd, nr);
     -+			free_cmds(queued_cmd, nr);
     -+			nr = 0;
     -+			continue;
     -+		}
     -+
     -+		if (!opt->buffer_output) {
     ++			free_cmds(queued_cmd, &nr);
     ++		} else if (!opt->buffer_output) {
      +			cmd->fn(opt, p, output, data);
     -+			continue;
     ++		} else {
     ++			ALLOC_GROW(queued_cmd, nr + 1, alloc);
     ++			call.fn = cmd->fn;
     ++			call.line = xstrdup_or_null(p);
     ++			queued_cmd[nr++] = call;
      +		}
     -+
     -+		ALLOC_GROW(queued_cmd, nr + 1, alloc);
     -+		call.fn = cmd->fn;
     -+		call.line = xstrdup_or_null(p);
     -+		queued_cmd[nr++] = call;
      +	}
      +
      +	if (opt->buffer_output &&
      +	    nr &&
      +	    !git_env_bool("GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT", 0)) {
      +		dispatch_calls(opt, output, data, queued_cmd, nr);
     -+		free_cmds(queued_cmd, nr);
     ++		free_cmds(queued_cmd, &nr);
      +	}
      +
      +	free(queued_cmd);
     @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *pr
       			    N_("with --batch[-check]: ignores stdin, batches all known objects"), 'b'),
       		/* Batch-specific options */
      
     - ## t/README ##
     -@@ t/README: a test and then fails then the whole test run will abort. This can help to make
     - sure the expected tests are executed and not silently skipped when their
     - dependency breaks or is simply not present in a new environment.
     - 
     -+GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT=<boolean>, when true will prevent cat-file
     -+--batch-command from flushing to output on exit.
     -+
     - Naming Tests
     - ------------
     - 
     -
       ## t/t1006-cat-file.sh ##
      @@ t/t1006-cat-file.sh: $content"
       	test_cmp expect actual
     @@ t/t1006-cat-file.sh: $content"
      +	test -z "$content" ||
      +		test_expect_success "--batch-command $opt output of $type content is correct" '
      +		maybe_remove_timestamp "$batch_output" $no_ts >expect &&
     -+		maybe_remove_timestamp "$(test_write_lines "contents $sha1" \
     -+		| git cat-file --batch-command $opt)" $no_ts >actual &&
     ++		maybe_remove_timestamp "$(test_write_lines "contents $sha1" |
     ++		git cat-file --batch-command $opt)" $no_ts >actual &&
      +		test_cmp expect actual
      +	'
      +
      +	test_expect_success "--batch-command $opt output of $type info is correct" '
      +		echo "$sha1 $type $size" >expect &&
     -+		test_write_lines "info $sha1" \
     -+		| git cat-file --batch-command $opt >actual &&
     ++		test_write_lines "info $sha1" |
     ++		git cat-file --batch-command $opt >actual &&
      +		test_cmp expect actual
      +	'
      +    done
     @@ t/t1006-cat-file.sh: $content"
           test_expect_success "custom --batch-check format" '
       	echo "$type $sha1" >expect &&
       	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
     + 	test_cmp expect actual
     +     '
     + 
     ++    test_expect_success "custom --batch-command format" '
     ++	echo "$type $sha1" >expect &&
     ++	echo "info $sha1" | git cat-file --batch-command="%(objecttype) %(objectname)" >actual &&
     ++	test_cmp expect actual
     ++    '
     ++
     +     test_expect_success '--batch-check with %(rest)' '
     + 	echo "$type this is some extra content" >expect &&
     + 	echo "$sha1    this is some extra content" |
      @@ t/t1006-cat-file.sh: test_expect_success "setup" '
       
       run_tests 'blob' $hello_sha1 $hello_size "$hello_content" "$hello_content"
       
      +test_expect_success '--batch-command --buffer with flush for blob info' '
      +	echo "$hello_sha1 blob $hello_size" >expect &&
     -+	test_write_lines "info $hello_sha1" "flush" | \
     ++	test_write_lines "info $hello_sha1" "flush" |
      +	GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT=1 \
      +	git cat-file --batch-command --buffer >actual &&
      +	test_cmp expect actual
     @@ t/t1006-cat-file.sh: test_expect_success "setup" '
      +
      +test_expect_success '--batch-command --buffer without flush for blob info' '
      +	touch output &&
     -+	test_write_lines "info $hello_sha1" | \
     ++	test_write_lines "info $hello_sha1" |
      +	GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT=1 \
      +	git cat-file --batch-command --buffer >>output &&
      +	test_must_be_empty output
     @@ t/t1006-cat-file.sh: test_expect_success "--batch-check with multiple sha1s give
      +	deadbeef missing
      +	EOF
      +
     -+	test_write_lines "info $hello_sha1"\
     -+	"info $tree_sha1"\
     -+	"info $commit_sha1"\
     -+	"info $tag_sha1"\
     -+	"info deadbeef" | git cat-file --batch-command --buffer >actual &&
     ++	git cat-file --batch-command --buffer >actual <<-EOF &&
     ++	info $hello_sha1
     ++	info $tree_sha1
     ++	info $commit_sha1
     ++	info $tag_sha1
     ++	info deadbeef
     ++	EOF
     ++
      +	test_cmp expect actual
      +'
      +
     @@ t/t1006-cat-file.sh: test_expect_success "--batch-check with multiple sha1s give
      +	deadbeef missing
      +	EOF
      +
     -+	test_write_lines "contents $hello_sha1"\
     -+	"contents $commit_sha1"\
     -+	"contents $tag_sha1"\
     -+	"contents deadbeef"\
     -+	"flush" | git cat-file --batch-command --buffer | remove_timestamp >actual &&
     ++	git cat-file --batch-command --buffer >actual_raw <<-EOF &&
     ++	contents $hello_sha1
     ++	contents $commit_sha1
     ++	contents $tag_sha1
     ++	contents deadbeef
     ++	flush
     ++	EOF
     ++
     ++	remove_timestamp <actual_raw >actual &&
      +	test_cmp expect actual
      +'
      +

-- 
gitgitgadget
