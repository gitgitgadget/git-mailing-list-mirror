Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB3AC4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJTXRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJTXRB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:17:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7050D22C63C
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:16:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u10so2029802wrq.2
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkL4xfvxaUQq61aJIFtagIZKznYCECJQPR5GXxXao/o=;
        b=oYouPMuzusjcqqJ7zOBt+Vwt2D1U/eGvLB+XEN6MOuHnYqQyDkGT7xENOGQiuQ0UG2
         ZcTKH5GWLtTJkAKpfUS40E4H1WiXEHiBJpvsAV2nn1GvDscL/PsTjyAIlzJlGhQuE3M/
         BiSm8swhxhMXho9zqeWlFEPiOHZSO6qMoc2aLeXkf+xkrms+g9JBrnq9yEwLxyGmg+PT
         8W3e9jbFv5EAOZomV8oljklnKDi3xAlfGQM0iqckT+mruLl5cPWSxTvQ1i1FdvcF1U1k
         SXAxn1ezRKj9h40+OkjhQc2ZrprH6T6wgiaILjDHIGDyT/VSed8Vvx+0wJr7n1rRlHEq
         mQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkL4xfvxaUQq61aJIFtagIZKznYCECJQPR5GXxXao/o=;
        b=aTrAWvMiSm0xTmhfGJrAq87ejxts7sX1trO20tHaChza0GIi5fwqMq7C6XCgUt0cWD
         qRrXhmGZ2+kEO3j+PtmohquQEQlfLx9EEjDCgnR8kOvznJFEkcFv7/E26g3grtSl0MXE
         wK9hO7UW8wGxJ6IM0oYXW583YfZWFmq68pKpru+jxvlXv9bavXg/jKNDgw7EVu+RreTj
         E3oLDtEhS0DEjKbopOmb0ZtnQL9xLTqC18dFaOaftbmtZbkp1fh9L/RqcoM/dZlTLUU+
         28kBPpqEeyJlz46+8bM2tItiTSsLDexZ+3MsEx7rHwE1PDOECWtuJ38DGrLx7SDcuxKC
         wu6Q==
X-Gm-Message-State: ACrzQf1O6Y8m0YdbeTKtUkePMq3m7K7ili0FtVnZgoP0XRtTT1+f9CNk
        KpDZWOv6/jstRqKbGdwjkbamsyPDnE8=
X-Google-Smtp-Source: AMsMyM7V5V0LnuNT5wF5rQ34QheV0x3sJ0Ojee9djpava1k8QlKPn7I8Wu5oyi+4PWxBUZmE88anbA==
X-Received: by 2002:a5d:47ab:0:b0:231:1b02:3db5 with SMTP id 11-20020a5d47ab000000b002311b023db5mr9881007wrb.422.1666307817253;
        Thu, 20 Oct 2022 16:16:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2-20020adff582000000b0022cd0c8c696sm3637824wro.103.2022.10.20.16.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 16:16:56 -0700 (PDT)
Message-Id: <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
References: <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 23:16:49 +0000
Subject: [PATCH v4 0/6] patch-id fixes and improvements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches add fixes and features to the "git patch-id" command, mostly
discovered through our usage of patch-id in the revup project
(https://github.com/Skydio/revup). On top of that I've tried to make general
cleanup changes where I can.

Summary:

1: Fixed a bug in the combination of --stable with binary files and
header-only, and expanded the test to cover both binary and non-binary
files.

2: Switch internal usage of patch-id in rebase / cherry-pick to use the
stable variant to reduce the number of code paths and improve testing for
bugs like above.

3: Fixed bugs with patch-id and binary diffs. Previously patch-id did not
behave correctly for binary diffs regardless of whether "--binary" was given
to "diff".

4: Fixed bugs with patch-id and mode changes. Previously mode changes were
incorrectly excluded from the patch-id.

5: Add a new "--include-whitespace" mode to patch-id that prevents
whitespace from being stripped during id calculation. Also add a config
option for the same behavior.

6: Remove unused prefix from patch-id logic.

V1->V2: Fixed comment style V2->V3: The ---/+++ lines no longer get added to
the patch-id of binary diffs. Also added patches 3-7 in the series. V3->V3:
Dropped patch7. Updated flag name to --verbatim. Updated commit message
descriptions.

Signed-off-by: Jerry Zhang jerry@skydio.com

Jerry Zhang (6):
  patch-id: fix stable patch id for binary / header-only
  patch-id: use stable patch-id for rebases
  builtin: patch-id: fix patch-id with binary diffs
  patch-id: fix patch-id for mode changes
  builtin: patch-id: add --verbatim as a command mode
  builtin: patch-id: remove unused diff-tree prefix

 Documentation/git-patch-id.txt |  24 ++++---
 builtin/log.c                  |   2 +-
 builtin/patch-id.c             | 113 ++++++++++++++++++++++++---------
 diff.c                         |  75 +++++++++++-----------
 diff.h                         |   2 +-
 patch-ids.c                    |  10 +--
 patch-ids.h                    |   2 +-
 t/t3419-rebase-patch-id.sh     |  63 +++++++++++++++---
 t/t4204-patch-id.sh            |  95 +++++++++++++++++++++++++--
 9 files changed, 287 insertions(+), 99 deletions(-)


base-commit: 45c9f05c44b1cb6bd2d6cb95a22cf5e3d21d5b63
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1359%2Fjerry-skydio%2Fjerry%2Frevup%2Fmaster%2Fpatch_ids-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1359/jerry-skydio/jerry/revup/master/patch_ids-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1359

Range-diff vs v3:

 1:  7d4c2e91ce0 ! 1:  321757ef919 patch-id: fix stable patch id for binary / header-only
     @@ Metadata
       ## Commit message ##
          patch-id: fix stable patch id for binary / header-only
      
     -    Previous logic here skipped flushing the hunks for binary
     -    and header-only patch ids, which would always result in a
     -    patch-id of 0000.
     +    Patch-ids for binary patches are found by hashing the object
     +    ids of the before and after objects in succession. However in
     +    the --stable case, there is a bug where hunks are not flushed
     +    for binary and header-only patch ids, which would always result
     +    in a patch-id of 0000. The --unstable case is currently correct.
      
          Reorder the logic to branch into 3 cases for populating the
          patch body: header-only which populates nothing, binary which
 2:  25e28b7dab3 = 2:  ec4a2422d5b patch-id: use stable patch-id for rebases
 3:  21642128927 ! 3:  81501355313 builtin: patch-id: fix patch-id with binary diffs
     @@ Commit message
          builtin: patch-id: fix patch-id with binary diffs
      
          "git patch-id" currently doesn't produce correct output if the
     -    incoming diff has any binary files. Add logic to
     -    get_one_patchid to handle the different possible styles of binary
     -    diff. This attempts to keep resulting patch-ids identical to what
     -    would be produced by the counterpart logic in diff.c, that is it
     -    produces the id by hashing the a and b oids in succession.
     +    incoming diff has any binary files. Add logic to get_one_patchid
     +    to handle the different possible styles of binary diff. This
     +    attempts to keep resulting patch-ids identical to what would be
     +    produced by the counterpart logic in diff.c, that is it produces
     +    the id by hashing the a and b oids in succession.
      
          In general we handle binary diffs by first caching the object ids from
          the "index" line and using those if we then find an indication
 4:  6e07cfd5691 = 4:  bb0b4add03c patch-id: fix patch-id for mode changes
 5:  bbaa2425ad0 ! 5:  b160f2ae49f builtin: patch-id: add --include-whitespace as a command mode
     @@ Metadata
      Author: Jerry Zhang <jerry@skydio.com>
      
       ## Commit message ##
     -    builtin: patch-id: add --include-whitespace as a command mode
     +    builtin: patch-id: add --verbatim as a command mode
      
     -    There are situations where the user might not want the default setting
     -    where patch-id strips all whitespace. They might be working in a
     -    language where white space is syntactically important, or they might
     -    have CI testing that enforces strict whitespace linting. In these cases,
     -    a whitespace change would result in the patch fundamentally changing,
     -    and thus deserving of a different id.
     +    There are situations where the user might not want the default
     +    setting where patch-id strips all whitespace. They might be working
     +    in a language where white space is syntactically important, or they
     +    might have CI testing that enforces strict whitespace linting. In
     +    these cases, a whitespace change would result in the patch
     +    fundamentally changing, and thus deserving of a different id.
      
          Add a new mode that is exclusive of --stable and --unstable called
     -    --include-whitespace. It also corresponds to the config
     -    patchid.include_whitespace = true. In this mode, the stable algorithm
     -    is used and whitespace is not stripped from the patch text.
     +    --verbatim. It also corresponds to the config
     +    patchid.verbatim = true. In this mode, the stable algorithm is
     +    used and whitespace is not stripped from the patch text.
     +
     +    Users of --unstable mainly care about compatibility with old git
     +    versions, which unstripping the whitespace would break. Thus there
     +    isn't a usecase for the combination of --verbatim and --unstable,
     +    and we don't expose this so as to not add maintainence burden.
      
          Signed-off-by: Jerry Zhang <jerry@skydio.com>
          fixes https://github.com/Skydio/revup/issues/2
     @@ Documentation/git-patch-id.txt: git-patch-id - Compute unique ID for a patch
       --------
       [verse]
      -'git patch-id' [--stable | --unstable]
     -+'git patch-id' [--stable | --unstable | --include-whitespace]
     ++'git patch-id' [--stable | --unstable | --verbatim]
       
       DESCRIPTION
       -----------
     @@ Documentation/git-patch-id.txt: This can be used to make a mapping from patch ID
       OPTIONS
       -------
       
     -+--include-whitespace::
     -+	Use the "stable" algorithm described below and also don't strip whitespace
     -+	from lines when calculating the patch-id.
     ++--verbatim::
     ++	Calculate the patch-id of the input as it is given, do not strip
     ++	any whitespace.
      +
     -+	This is the default if patchid.includeWhitespace is true and implies
     -+	patchid.stable.
     ++	This is the default if patchid.verbatim is true.
      +
       --stable::
       	Use a "stable" sum of hashes as the patch ID. With this option:
     @@ builtin/patch-id.c: static int scan_hunk_header(const char *p, int *p_before, in
       
       static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
      -			   struct strbuf *line_buf, int stable)
     -+			   struct strbuf *line_buf, int stable, int include_whitespace)
     ++			   struct strbuf *line_buf, int stable, int verbatim)
       {
       	int patchlen = 0, found_next = 0;
       	int before = -1, after = -1;
     @@ builtin/patch-id.c: static int get_one_patchid(struct object_id *next_oid, struc
       		    !skip_prefix(line, "From ", &p) &&
      -		    starts_with(line, "\\ ") && 12 < strlen(line))
      +		    starts_with(line, "\\ ") && 12 < strlen(line)) {
     -+			if (include_whitespace)
     ++			if (verbatim)
      +				the_hash_algo->update_fn(&ctx, line, strlen(line));
       			continue;
      +		}
     @@ builtin/patch-id.c: static int get_one_patchid(struct object_id *next_oid, struc
      -		/* Compute the sha without whitespace */
      -		len = remove_space(line);
      +		/* Add line to hash algo (possibly removing whitespace) */
     -+		len = include_whitespace ? strlen(line) : remove_space(line);
     ++		len = verbatim ? strlen(line) : remove_space(line);
       		patchlen += len;
       		the_hash_algo->update_fn(&ctx, line, len);
       	}
     @@ builtin/patch-id.c: static int get_one_patchid(struct object_id *next_oid, struc
       }
       
      -static void generate_id_list(int stable)
     -+static void generate_id_list(int stable, int include_whitespace)
     ++static void generate_id_list(int stable, int verbatim)
       {
       	struct object_id oid, n, result;
       	int patchlen;
     @@ builtin/patch-id.c: static void generate_id_list(int stable)
       	oidclr(&oid);
       	while (!feof(stdin)) {
      -		patchlen = get_one_patchid(&n, &result, &line_buf, stable);
     -+		patchlen = get_one_patchid(&n, &result, &line_buf, stable, include_whitespace);
     ++		patchlen = get_one_patchid(&n, &result, &line_buf, stable, verbatim);
       		flush_current_id(patchlen, &oid, &result);
       		oidcpy(&oid, &n);
       	}
     @@ builtin/patch-id.c: static void generate_id_list(int stable)
       }
       
      -static const char patch_id_usage[] = "git patch-id [--stable | --unstable]";
     -+static const char * const patch_id_usage[] = {
     -+	N_("git patch-id [--stable | --unstable | --include-whitespace]"),
     -+	NULL
     ++static const char *const patch_id_usage[] = {
     ++	N_("git patch-id [--stable | --unstable | --verbatim]"), NULL
      +};
      +
      +struct patch_id_opts {
      +	int stable;
     -+	int include_whitespace;
     ++	int verbatim;
      +};
       
       static int git_patch_id_config(const char *var, const char *value, void *cb)
     @@ builtin/patch-id.c: static void generate_id_list(int stable)
      +		opts->stable = git_config_bool(var, value);
      +		return 0;
      +	}
     -+	if (!strcmp(var, "patchid.includewhitespace")) {
     -+		opts->include_whitespace = git_config_bool(var, value);
     ++	if (!strcmp(var, "patchid.verbatim")) {
     ++		opts->verbatim = git_config_bool(var, value);
       		return 0;
       	}
       
     @@ builtin/patch-id.c: static int git_patch_id_config(const char *var, const char *
      +	int opts = 0;
      +	struct option builtin_patch_id_options[] = {
      +		OPT_CMDMODE(0, "unstable", &opts,
     -+			N_("use the unstable patch-id algorithm"), 1),
     ++		    N_("use the unstable patch-id algorithm"), 1),
      +		OPT_CMDMODE(0, "stable", &opts,
     -+			N_("use the stable patch-id algorithm"), 2),
     -+		OPT_CMDMODE(0, "include-whitespace", &opts,
     -+			N_("use the stable algorithm and don't strip whitespace"), 3),
     ++		    N_("use the stable patch-id algorithm"), 2),
     ++		OPT_CMDMODE(0, "verbatim", &opts,
     ++			N_("don't strip whitespace from the patch"), 3),
      +		OPT_END()
      +	};
      +
      +	git_config(git_patch_id_config, &config);
      +
     -+	/* includeWhitespace implies stable */
     -+	if (config.include_whitespace)
     ++	/* verbatim implies stable */
     ++	if (config.verbatim)
      +		config.stable = 1;
      +
      +	argc = parse_options(argc, argv, prefix, builtin_patch_id_options,
      +			     patch_id_usage, 0);
      +
      +	generate_id_list(opts ? opts > 1 : config.stable,
     -+			 opts ? opts == 3 : config.include_whitespace);
     ++			 opts ? opts == 3 : config.verbatim);
       	return 0;
       }
      
     @@ t/t4204-patch-id.sh: test_expect_success 'file order is relevant with --unstable
       	test_patch_id_file_order relevant --unstable --unstable
       '
       
     -+test_expect_success 'whitespace is relevant with --include-whitespace' '
     -+	test_patch_id_whitespace relevant --include-whitespace --include-whitespace
     ++test_expect_success 'whitespace is relevant with --verbatim' '
     ++	test_patch_id_whitespace relevant --verbatim --verbatim
      +'
      +
     -+test_expect_success 'whitespace is irrelevant without --include-whitespace' '
     ++test_expect_success 'whitespace is irrelevant without --verbatim' '
      +	test_patch_id_whitespace irrelevant --stable --stable
      +'
      +
     @@ t/t4204-patch-id.sh: test_expect_success 'patchid.stable = false is unstable' '
       	test_patch_id relevant patchid.stable=false
       '
       
     -+test_expect_success 'patchid.includeWhitespace = true is correct and stable' '
     -+	test_config patchid.includeWhitespace true &&
     -+	test_patch_id_whitespace relevant patchid.includeWhitespace=true &&
     -+	test_patch_id irrelevant patchid.includeWhitespace=true
     ++test_expect_success 'patchid.verbatim = true is correct and stable' '
     ++	test_config patchid.verbatim true &&
     ++	test_patch_id_whitespace relevant patchid.verbatim=true &&
     ++	test_patch_id irrelevant patchid.verbatim=true
      +'
      +
     -+test_expect_success 'patchid.includeWhitespace = false is unstable' '
     -+	test_config patchid.includeWhitespace false &&
     -+	test_patch_id relevant patchid.includeWhitespace=false
     ++test_expect_success 'patchid.verbatim = false is unstable' '
     ++	test_config patchid.verbatim false &&
     ++	test_patch_id relevant patchid.verbatim=false
      +'
      +
       test_expect_success '--unstable overrides patchid.stable = true' '
     @@ t/t4204-patch-id.sh: test_expect_success '--stable overrides patchid.stable = fa
       	test_patch_id irrelevant patchid.stable=false--stable --stable
       '
       
     -+test_expect_success '--include-whitespace overrides patchid.stable = false' '
     ++test_expect_success '--verbatim overrides patchid.stable = false' '
      +	test_config patchid.stable false &&
     -+	test_patch_id_whitespace relevant stable=false--include-whitespace --include-whitespace
     ++	test_patch_id_whitespace relevant stable=false--verbatim --verbatim
      +'
      +
       test_expect_success 'patch-id supports git-format-patch MIME output' '
     @@ t/t4204-patch-id.sh: test_expect_success 'patch-id handles no-nl-at-eof markers'
       	calc_patch_id withnl <withnl &&
      -	test_cmp patch-id_nonl patch-id_withnl
      +	test_cmp patch-id_nonl patch-id_withnl &&
     -+	calc_patch_id nonl-inc-ws --include-whitespace <nonl &&
     -+	calc_patch_id withnl-inc-ws --include-whitespace <withnl &&
     ++	calc_patch_id nonl-inc-ws --verbatim <nonl &&
     ++	calc_patch_id withnl-inc-ws --verbatim <withnl &&
      +	! test_cmp patch-id_nonl-inc-ws patch-id_withnl-inc-ws
       '
       
 6:  a1f6f36d487 ! 6:  dcdfac7a153 builtin: patch-id: remove unused diff-tree prefix
     @@ builtin/patch-id.c: static int get_one_patchid(struct object_id *next_oid, struc
      +		if (!skip_prefix(line, "commit ", &p) &&
       		    !skip_prefix(line, "From ", &p) &&
       		    starts_with(line, "\\ ") && 12 < strlen(line)) {
     - 			if (include_whitespace)
     + 			if (verbatim)
 7:  69440797f30 < -:  ----------- documentation: format-patch: clarify requirements for patch-ids to match

-- 
gitgitgadget
