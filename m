Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E95C43219
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 03:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiKCD35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 23:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiKCD3q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 23:29:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D45140E9
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 20:29:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z14so829015wrn.7
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 20:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruZPmAIYxQWn04SFemgr91Ckfx1xn56lCT445+M3Fcs=;
        b=ZHXmaVW6KAF3/7BgF6N/s/Jz3YHzCOHwUlyKUU0rJPXdJUOVWp5AvQ6c4ltyshcbVe
         1UUQewDvYl03np63c/KfTHd22kG3M+/tKpy/ESGsor5TuZHZW1PpTRMiQwXew/9PRQA8
         yM59j+lGIxoiIuYs96T9A6va/1BDFPVHKMdu0WUq1RU0aC3+haMSgDjCTKtaqF6kES2+
         qFrE3ulPjJqMCBYSm1Dyhj6rVtBiErtNtzZkzJfYkG5gB3sEkJrd1QidvyQb0ovBexcG
         msndfDGXBHAULq6Z3xCn8lb/y3vNBq7oyC/Yt/F+9fTS9/Qp4e7cnVzwaJObEEbGG+l+
         thPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruZPmAIYxQWn04SFemgr91Ckfx1xn56lCT445+M3Fcs=;
        b=qlSHhTLlJcq7tHb/3Tpjeo0cBqovKmXq9MB+JzQJgDBQk3Ht0TmXwlafyf86e6oymd
         XX94QEbwO6yCAlMA1bF2C0JI0OPU19kF4fhGXAORch38xXoEGZCGscpxeknZgi9lSva6
         6f7vf1izpCPM2Ci8Q3/aT78ESvg0x+9WeMnp2hZqTA43vCdHErDNy79hbZ1nheb6BAsD
         MJ3BmMdob4Umhai0cBaiHOa2kEvOCVX2AcKTDBahI1lhEgkgob5EMT/jV3wF7kQEsVeh
         4TNzgsUNf/VYbFr/b9AC0Dt9OV3fIsxNFmBDUJPqt2K0daG0aAlW5R+x3Wa+ijI6SMh+
         C7xQ==
X-Gm-Message-State: ACrzQf2tjL9xkwKpcXQfLuadtA6j+6VcjILBpANjeVG3T+dpUK7uyVGW
        zKdSKLpwByoYN70JyoSz1ttRmw/UPng=
X-Google-Smtp-Source: AMsMyM769ovTSnvLrpLPWh7qSXndj3OcNxNWLgILclCHMIFCThfZCttaf/ZnN7yXk8+dOJmfJSkM+g==
X-Received: by 2002:a5d:6c6f:0:b0:236:d270:7bd2 with SMTP id r15-20020a5d6c6f000000b00236d2707bd2mr11213223wrz.366.1667446183355;
        Wed, 02 Nov 2022 20:29:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c18-20020a05600c0a5200b003b3365b38f9sm3851570wmq.10.2022.11.02.20.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 20:29:42 -0700 (PDT)
Message-Id: <pull.1397.v5.git.1667446182.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.v4.git.1667292904.gitgitgadget@gmail.com>
References: <pull.1397.v4.git.1667292904.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Nov 2022 03:29:40 +0000
Subject: [PATCH v5 0/2] merge-tree: allow specifying a base commit when --write-tree is passed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, kylezhao <kylezhao@tencent.com>,
        Taylor Blau <me@ttaylorr.com>, Kyle Zhao <kylezhao@tencent.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for Elijah's work. I'm very excited that merge-ort is integrated into
the git merge-tree, which means that we can use merge-ort in bare
repositories to optimize merge performance.

In this patch, I introduce a new --merge-base=<commit> option to allow
callers to specify a merge-base for the merge. This may allow users to
implement git cherry-pick and git rebase in bare repositories with git
merge-tree cmd.

Changes since v1:

 * Changed merge_incore_recursive() to merge_incore_nonrecursive() when
   merge-base is specified.
 * Fixed c style problem.
 * Moved commit lookup/die logic out to the parsing logic in
   cmd_merge_tree().
 * use test_commit for test

Changes since v2:

 * commit message
 * Rebased on top of en/merge-tree-sequence.
 * Set opt.ancestor to o->merge_base. Because opt.ancestor is a *char. To
   make it easier to pass parameters, I moved
   lookup_commit_reference_by_name() to real_ merge() again.
 * Added test comment.

Changes since v3:

 * support --merge-base in conjunction with --stdin

Kyle Zhao (2):
  merge-tree.c: add --merge-base=<commit> option
  merge-tree.c: allow specifying the merge-base when --stdin is passed

 Documentation/git-merge-tree.txt | 16 ++++++++
 builtin/merge-tree.c             | 65 ++++++++++++++++++++++++++------
 t/t4301-merge-tree-write-tree.sh | 55 +++++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 12 deletions(-)


base-commit: ec1edbcb56ac05e9980299b05924c5c1b51d68b4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1397%2Fkeyu98%2Fkz%2Fmerge-tree-option-merge-base-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1397/keyu98/kz/merge-tree-option-merge-base-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1397

Range-diff vs v4:

 1:  bba854fc8fa ! 1:  01df0d1a6a7 merge-tree.c: add --merge-base=<commit> option
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char
       		OPT_END()
       	};
       
     +@@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     + 
     + 		if (o.mode == MODE_TRIVIAL)
     + 			die(_("--trivial-merge is incompatible with all other options"));
     ++		if (merge_base)
     ++			die(_("--merge-base is incompatible with --stdin"));
     + 		line_termination = '\0';
     + 		while (strbuf_getline_lf(&buf, stdin) != EOF) {
     + 			struct strbuf **split;
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
       			if (!split[0] || !split[1] || split[2])
       				die(_("malformed input line: '%s'."), buf.buf);
 2:  db47fbc663e ! 2:  3bdfad03cca merge-tree.c: support --merge-base in conjunction with --stdin
     @@ Metadata
      Author: Kyle Zhao <kylezhao@tencent.com>
      
       ## Commit message ##
     -    merge-tree.c: support --merge-base in conjunction with --stdin
     +    merge-tree.c: allow specifying the merge-base when --stdin is passed
      
     -    The previous change add "--merge-base" option in order to allow users to
     -    specify merge-base for the merge. But it doesn't compatible well with
     -    --stdin, because multiple batched merges can only have the same specified
     -    base.
     +    The previous commit added a `--merge-base` option in order to allow
     +    using a specified merge-base for the merge.  Extend the input accepted
     +    by `--stdin` to also allow a specified merge-base with each merge
     +    requested.  For example:
      
     -    This patch allows users to pass --merge-base option into the input line,
     -    such as:
     +        printf "<b3> -- <b1> <b2>" | git merge-tree --stdin
      
     -        printf "--merge-base=<b3> <b1> <b2>" | git merge-tree --stdin
     -
     -    This does a merge of b1 and b2, and uses b3 as the merge-base.
     +    does a merge of b1 and b2, and uses b3 as the merge-base.
      
          Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
      
     @@ Documentation/git-merge-tree.txt: OPTIONS
       --merge-base=<commit>::
       	Instead of finding the merge-bases for <branch1> and <branch2>,
      -	specify a merge-base for the merge.
     -+	specify a merge-base for the merge. When --stdin is passed, this
     -+	option should be passed into the input line.
     ++	specify a merge-base for the merge. This option is incompatible
     ++	with `--stdin`.
       
       [[OUTPUT]]
       OUTPUT
     +@@ Documentation/git-merge-tree.txt: with linkgit:git-merge[1]:
     +   * any messages that would have been printed to stdout (the
     +     <<IM,Informational messages>>)
     + 
     ++INPUT FORMAT
     ++------------
     ++'git merge-tree --stdin' input format is fully text based. Each line
     ++has this format:
     ++
     ++	[<base-commit> -- ]<branch1> <branch2>
     ++
     ++If one line is separated by `--`, the string before the separator is
     ++used for specifying a merge-base for the merge and the string after
     ++the separator describes the branches to be merged.
     ++
     + MISTAKES TO AVOID
     + -----------------
     + 
      
       ## builtin/merge-tree.c ##
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     - 
     - 		if (o.mode == MODE_TRIVIAL)
     - 			die(_("--trivial-merge is incompatible with all other options"));
     -+		if (merge_base)
     -+			die(_("--merge-base should be passed into the input line"));
     - 		line_termination = '\0';
       		while (strbuf_getline_lf(&buf, stdin) != EOF) {
       			struct strbuf **split;
       			int result;
      +			const char *input_merge_base = NULL;
     -+			const char *arg;
       
       			split = strbuf_split(&buf, ' ');
      -			if (!split[0] || !split[1] || split[2])
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char
       				die(_("malformed input line: '%s'."), buf.buf);
       			strbuf_rtrim(split[0]);
      -			result = real_merge(&o, merge_base, split[0]->buf, split[1]->buf, prefix);
     ++			strbuf_rtrim(split[1]);
      +
     -+			/* parse --merge-base=<commit> option */
     -+			arg = split[0]->buf;
     -+			if (skip_prefix(arg, "--merge-base=", &arg))
     -+				input_merge_base = arg;
     ++			/* parse the merge-base */
     ++			if (!strcmp(split[1]->buf, "--")) {
     ++				input_merge_base = split[0]->buf;
     ++			}
      +
     -+			if (input_merge_base && split[2] && !split[3]) {
     -+				strbuf_rtrim(split[1]);
     -+				result = real_merge(&o, input_merge_base, split[1]->buf, split[2]->buf, prefix);
     ++			if (input_merge_base && split[2] && split[3] && !split[4]) {
     ++				strbuf_rtrim(split[2]);
     ++				strbuf_rtrim(split[3]);
     ++				result = real_merge(&o, input_merge_base, split[2]->buf, split[3]->buf, prefix);
      +			} else if (!input_merge_base && !split[2]) {
      +				result = real_merge(&o, NULL, split[0]->buf, split[1]->buf, prefix);
      +			} else {
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success '--stdin with both a succe
      +test_expect_success '--merge-base is incompatible with --stdin' '
      +	test_must_fail git merge-tree --merge-base=side1 --stdin 2>expect &&
      +
     -+	grep "^fatal: --merge-base should be passed into the input line" expect
     ++	grep "^fatal: --merge-base is incompatible with --stdin" expect
      +'
      +
       # specify merge-base as parent of branch2
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'specify merge-base as par
       	)
       '
       
     ++# Since the earlier tests have verified that individual merge-tree calls
     ++# are doing the right thing, this test case is only used to test whether
     ++# the input format is available.
     ++
      +test_expect_success '--stdin with both a normal merge and a merge-base specified merge' '
      +	cd base-b2-p &&
     -+	printf "c1 c3\n--merge-base=c2 c1 c3" | git merge-tree --stdin >actual &&
     ++	printf "c1 c3\nc2 -- c1 c3" | git merge-tree --stdin >actual &&
      +
      +	printf "1\0" >expect &&
      +	git merge-tree --write-tree -z c1 c3 >>expect &&

-- 
gitgitgadget
