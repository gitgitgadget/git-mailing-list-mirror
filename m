Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FDCC7619A
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 07:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjC0HzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 03:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjC0HzH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 03:55:07 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCD210CE
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 00:55:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so6344145wmq.2
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 00:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679903704;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOfCol77P22FNRxRrdx1lGsV8WscYZEMj07x9W6iQz4=;
        b=dqqmn1VbSd6ioN2HWFHz+wrL5OaUkcBxmI8MsMwNfthvaB4Ttq7QYORTDIxSeKDncw
         t+nE06uXu9/VqtQPV8GpVVJAyy+BCR912V0o55cGmlThYlZKQQkr7sR5mTbntHFyTG6n
         WXt37ZS13B4JPIaZFRGSAQc9yXgRl7siQtoj0B6sh1n38EFSC7kQG1xjhHNnIJ8FnPVk
         YxDXPIhwp3C/r8sUftblCqhNyHP5kxc3MEQXtJTe6BA8opk631uARBcomVieDH5pUyuk
         o6lS+m3vTdK3tYRgoWt3H7QSsw076bTBdLbFTUoe4Zi5naqCiHyncrI0fGG7/9ZM4BtR
         ptwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679903704;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOfCol77P22FNRxRrdx1lGsV8WscYZEMj07x9W6iQz4=;
        b=NnNG844IBlFfoeD0OD+S77muDIc9DiZ5HGAngbm38okXeexlNIctmzIcC88bBl4iRW
         tRwJR8cqqwdNVp5Z6LBAibB9n9+QdVeBZDqoxz30003zhssjBeN//sxWyw57IScu8M96
         3RogCtcAyt8yYdDUJzy22ndR/d+NYtGudvuIiL7Lvw/EVQPbHNiW8zfK80dRyzK46IRp
         JEoLxV31irEzsFJkK5Yh4PCRMgVs6q9cfKRc/xHk1pVNr36+zBrWGaBzA8MUrRgp8Qim
         eIWrg+JP23K5paGnjAulDdJ4gjbl8ZDUoBBIa2mnH7TC/fmgs2MklAWwy2jRwK/Jgy2Q
         EHsg==
X-Gm-Message-State: AAQBX9d7ySXi6bKnZ4ljDK+xLqiRqXWyaM7rnDzUcOHe7WKJ1ea6oqFa
        YievaW3Krg9FhBk4oIKywR8isTeQ+cQ=
X-Google-Smtp-Source: AKy350ZZ1lObDF0hGhXi4XODdYRVILQ48DnklxWGY0hyT6117VyHG9FVrqaXH2XBuebg3uyPU0f5kA==
X-Received: by 2002:a7b:cd18:0:b0:3ef:6aa1:9284 with SMTP id f24-20020a7bcd18000000b003ef6aa19284mr2979560wmj.29.1679903704303;
        Mon, 27 Mar 2023 00:55:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d4305000000b002c3f81c51b6sm24254734wrq.90.2023.03.27.00.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 00:55:03 -0700 (PDT)
Message-Id: <pull.1488.v2.git.1679903703.gitgitgadget@gmail.com>
In-Reply-To: <pull.1488.git.1678283349.gitgitgadget@gmail.com>
References: <pull.1488.git.1678283349.gitgitgadget@gmail.com>
From:   "William Sprent via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Mar 2023 07:55:01 +0000
Subject: [PATCH v2 0/2] builtin/sparse-checkout: add check-rules command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Elijah Newren <newren@gmail.com>,
        William Sprent <williams@unity3d.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

This v2 addresses comments from Elijah's review comments.

There's one thing worth highlighting. Elijah pointed out that the the
"check-rules cone mode is default" test would be stronger if the test itself
started with a 'git sparse-checkout set --no-cone' to explicitly test that
the default interpretation of the rules passed with the '--rules-file'
option is cone mode even though the current checkout is non-cone. I
implemented this and it exposed that the option did not actually behave that
way, and that the test only verified the default behaviour of a bare
repository.

I've modified the logic of the '--rules-file' option such that it defaults
to cone mode unless combined with '--no-cone', and I've added a line to the
documentation to make this more explicit.

The alternative would be to have '--rules-file' assume non cone mode when in
a non cone mode checkout, but I think this depends a bit on "how deprecated"
non-cone mode is vs. how important it is to have the option behave
consistently with 'sparse-checkout set' (which respects the current
checkout).

Changes since v1:

 * Explicitly state in documentation that '--rules-file' expects newline
   separated rules.
 * Explicitly state in documentation that '-z' does not affect the
   '--rules-file' input.
 * Fixup typo where 'When called with the --rules-file <file> flag' was
   missing "flag".
 * Fixup behaviour in 'check-rules --rules-file', such that it defaults to
   accepting cone mode patterns when in a non cone checkout.
 * Remember to release string buffers in 'check_rules()'.
 * Explicitly state in documentation that '--rules-file' defaults to cone
   mode unless combined with '--no-cone'.
 * Better test that the default of '--rules-file' is to expect '--cone-mode'
   by running 'check-rules' in a non-cone mode checkout.

William Sprent (2):
  builtin/sparse-checkout: remove NEED_WORK_TREE flag
  builtin/sparse-checkout: add check-rules command

 Documentation/git-sparse-checkout.txt |  25 +++-
 builtin/sparse-checkout.c             | 137 ++++++++++++++++++---
 git.c                                 |   2 +-
 t/t1091-sparse-checkout-builtin.sh    | 167 +++++++++++++++++++++++++-
 4 files changed, 307 insertions(+), 24 deletions(-)


base-commit: d15644fe0226af7ffc874572d968598564a230dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1488%2Fwilliams-unity%2Fsparse-doodle-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1488/williams-unity/sparse-doodle-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1488

Range-diff vs v1:

 1:  4b231e9beb4 = 1:  4b231e9beb4 builtin/sparse-checkout: remove NEED_WORK_TREE flag
 2:  21c8375efff ! 2:  ef6e5b4d786 builtin/sparse-checkout: add check-rules command
     @@ Documentation/git-sparse-checkout.txt: paths to pass to a subsequent 'set' or 'a
      +By default `check-rules` reads a list of paths from stdin and outputs only
      +the ones that match the current sparsity rules. The input is expected to consist
      +of one path per line, matching the output of `git ls-tree --name-only` including
     -+that pathnames that begin with a double quote (") are interpreted C-style quoted
     -+strings.
     ++that pathnames that begin with a double quote (") are interpreted as C-style
     ++quoted strings.
      ++
     -+When called with the `--rules-file <file>` the input files are matched against
     -+the sparse checkout rules found in `<file>` instead of the current ones. The
     -+rules in the files are expected to be in the same form as accepted by `git
     -+sparse-checkout set --stdin`.
     ++When called with the `--rules-file <file>` flag the input files are matched
     ++against the sparse checkout rules found in `<file>` instead of the current ones.
     ++The rules in the files are expected to be in the same form as accepted by `git
     ++sparse-checkout set --stdin` (in particular, they must be newline-delimited).
      ++
     -+The `--rules-file` flag can be combined with the `--[no]-cone` with the same
     -+effect as for the `set` command with the `--stdin` flag.
     ++By default, the rules passed to the `--rules-file` option are interpreted as
     ++cone mode directories. To pass non-cone mode patterns with `--rules-file`,
     ++combine the option with the `--no-cone` option.
      ++
     -+When called with the `-z` flag the input format and output format is \0
     -+terminated and not quoted.
     ++When called with the `-z` flag, the format of the paths input on stdin as well
     ++as the output paths are \0 terminated and not quoted. Note that this does not
     ++apply to the format of the rules passed with the `--rules-file` option.
      +
      +
       EXAMPLES
     @@ builtin/sparse-checkout.c: static int sparse_checkout_disable(int argc, const ch
      +		if (path_in_sparse_checkout(path, the_repository->index))
      +			write_name_quoted(path, stdout, line_terminator);
      +	}
     ++	strbuf_release(&line);
     ++	strbuf_release(&unquoted);
      +
      +	return 0;
      +}
     @@ builtin/sparse-checkout.c: static int sparse_checkout_disable(int argc, const ch
      +			     builtin_sparse_checkout_check_rules_usage,
      +			     PARSE_OPT_KEEP_UNKNOWN_OPT);
      +
     ++	if (check_rules_opts.rules_file && check_rules_opts.cone_mode < 0)
     ++		check_rules_opts.cone_mode = 1;
     ++
      +	update_cone_mode(&check_rules_opts.cone_mode);
      +	pl.use_cone_patterns = core_sparse_checkout_cone;
      +	if (check_rules_opts.rules_file) {
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'disable fails outside w
      +	folder1/file
      +	EOF
      +
     -+	git -C bare sparse-checkout check-rules \
     ++	git -C repo sparse-checkout set --no-cone &&
     ++	git -C repo sparse-checkout check-rules \
      +		--rules-file ../rules >actual <all-files &&
      +
     -+	test_cmp expect actual
     ++	git -C bare sparse-checkout check-rules \
     ++		--rules-file ../rules >actual-bare <all-files &&
     ++
     ++	test_cmp expect actual &&
     ++	test_cmp expect actual-bare
      +'
      +
      +test_expect_success 'check-rules quoting' '

-- 
gitgitgadget
