Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B855C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 08:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiKAIzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 04:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAIzI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 04:55:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D98617E27
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 01:55:07 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f16-20020a05600c491000b003cf66a2e7c0so4837750wmp.5
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 01:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtfRFBkBvYZ+0TxzkReWaooklEEA+WZE8J96VQmASAk=;
        b=j5BAkDVoTmrTaf75K6ttYdvCtZyX19dQZ19oqRby+SRYvRLNQnsGcf4r9E8lXl7fxG
         t8ECPyMYpbYW77itpkZKckfEoR+MBdw0nG/Z7KCD7UIJWfTHioMk3f4hm0zxtZJ60eoa
         2Nb5rXfcitWVsQvnp798ZZaDsARdtZbGsfuplveuKQEe3RCJyGdjZb3qrE+j5VKNHqS9
         cqiqxj7TWpGJjwNQKb/U7MDJbn1m+Ixf4yFAp/H4BT/P4Pt4U59UdU2ZkBUODhP3+Nse
         9j2a4Jo9B6ajWLAGBAApWAvKBp7zUYmQ4fCubtNHDouQoO+VtzRZ1GYva2MoJ008wi0C
         MKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtfRFBkBvYZ+0TxzkReWaooklEEA+WZE8J96VQmASAk=;
        b=Xs+9VGqNEMlGHlj5gYdmNOXUNmMzEtm9gkWV12TAxrhp59f/yusZisTdE81pbwtXRj
         7yIei8h8yDu6aG8Fic9BkyHxJszSyHK8OCv0PINu3tZtezHJq0LwtCFLJIxmn8DcWTjQ
         eIuvnsmJnHvPYcvfGALvmvwnEwKNypa87NlPq2RWLSZ6uClvcYU/LvV5g95KSnn8j00w
         bnziEZqaF+Srj6Dmx+uv/olsbSnqp9omsCFJ0rfb3ROwosfrV3V7pShbuIv9L45WwDeH
         bgxfZghRdL92T5ZAZ97w67WxYOAAecTrVwpWtuf6xYClb1aDSOH9v0Y8DvRf2P5xLNVx
         iIBg==
X-Gm-Message-State: ACrzQf2ouenqkzMfeau59cRbx0ynYylyA0QvlENJdCrjd00Gm0Aa8Ng2
        0NoFIrJO68bCxvEE2+9zgtjo7P32irE=
X-Google-Smtp-Source: AMsMyM5QUIXoe+lorM4skccW8Bs0DXrD8MyiEXFVGrdzvujFd1BPYC7fjEXEj1Os/qFVfG6nJ3QVSg==
X-Received: by 2002:a1c:a3c4:0:b0:3cf:81fd:a039 with SMTP id m187-20020a1ca3c4000000b003cf81fda039mr100035wme.49.1667292905747;
        Tue, 01 Nov 2022 01:55:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13-20020adfe58d000000b002366f300e57sm9431134wrm.23.2022.11.01.01.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 01:55:05 -0700 (PDT)
Message-Id: <pull.1397.v4.git.1667292904.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.v3.git.1667014975042.gitgitgadget@gmail.com>
References: <pull.1397.v3.git.1667014975042.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Nov 2022 08:55:02 +0000
Subject: [PATCH v4 0/2] merge-tree: allow specifying a base commit when --write-tree is passed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, kylezhao <kylezhao@tencent.com>,
        Kyle Zhao <kylezhao@tencent.com>
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
  merge-tree.c: support --merge-base in conjunction with --stdin

 Documentation/git-merge-tree.txt |  5 +++
 builtin/merge-tree.c             | 64 ++++++++++++++++++++++++++------
 t/t4301-merge-tree-write-tree.sh | 51 +++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 12 deletions(-)


base-commit: ec1edbcb56ac05e9980299b05924c5c1b51d68b4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1397%2Fkeyu98%2Fkz%2Fmerge-tree-option-merge-base-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1397/keyu98/kz/merge-tree-option-merge-base-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1397

Range-diff vs v3:

 1:  554cbde49e8 ! 1:  bba854fc8fa merge-tree.c: add --merge-base=<commit> option
     @@ builtin/merge-tree.c
       #include "merge-ort.h"
       #include "object-store.h"
      @@ builtin/merge-tree.c: struct merge_tree_options {
     - 	int show_messages;
     - 	int name_only;
     - 	int use_stdin;
     -+	const char *merge_base;
       };
       
       static int real_merge(struct merge_tree_options *o,
     ++		      const char *merge_base,
     + 		      const char *branch1, const char *branch2,
     + 		      const char *prefix)
     + {
      @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       	opt.branch1 = branch1;
       	opt.branch2 = branch2;
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
      -	if (!merge_bases && !o->allow_unrelated_histories)
      -		die(_("refusing to merge unrelated histories"));
      -	merge_bases = reverse_commit_list(merge_bases);
     -+	if (o->merge_base) {
     ++	if (merge_base) {
      +		struct commit *base_commit;
      +		struct tree *base_tree, *parent1_tree, *parent2_tree;
      +
     -+		base_commit = lookup_commit_reference_by_name(o->merge_base);
     ++		base_commit = lookup_commit_reference_by_name(merge_base);
      +		if (!base_commit)
     -+			die(_("could not lookup commit %s"), o->merge_base);
     ++			die(_("could not lookup commit %s"), merge_base);
      +
     -+		opt.ancestor = o->merge_base;
     ++		opt.ancestor = merge_base;
      +		base_tree = get_commit_tree(base_commit);
      +		parent1_tree = get_commit_tree(parent1);
      +		parent2_tree = get_commit_tree(parent2);
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       	if (result.clean < 0)
       		die(_("failure to merge"));
       
     +@@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     + 	struct merge_tree_options o = { .show_messages = -1 };
     + 	int expected_remaining_argc;
     + 	int original_argc;
     ++	const char *merge_base = NULL;
     + 
     + 	const char * const merge_tree_usage[] = {
     + 		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
       			   &o.use_stdin,
       			   N_("perform multiple merges, one per line of input"),
       			   PARSE_OPT_NONEG),
      +		OPT_STRING(0, "merge-base",
     -+			   &o.merge_base,
     ++			   &merge_base,
      +			   N_("commit"),
      +			   N_("specify a merge-base for the merge")),
       		OPT_END()
       	};
       
     +@@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     + 			if (!split[0] || !split[1] || split[2])
     + 				die(_("malformed input line: '%s'."), buf.buf);
     + 			strbuf_rtrim(split[0]);
     +-			result = real_merge(&o, split[0]->buf, split[1]->buf, prefix);
     ++			result = real_merge(&o, merge_base, split[0]->buf, split[1]->buf, prefix);
     + 			if (result < 0)
     + 				die(_("merging cannot continue; got unclean result of %d"), result);
     + 			strbuf_list_free(split);
     +@@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     + 
     + 	/* Do the relevant type of merge */
     + 	if (o.mode == MODE_REAL)
     +-		return real_merge(&o, argv[0], argv[1], prefix);
     ++		return real_merge(&o, merge_base, argv[0], argv[1], prefix);
     + 	else
     + 		return trivial_merge(argv[0], argv[1], argv[2]);
     + }
      
       ## t/t4301-merge-tree-write-tree.sh ##
      @@ t/t4301-merge-tree-write-tree.sh: test_expect_success '--stdin with both a successful and a conflicted merge' '
 -:  ----------- > 2:  db47fbc663e merge-tree.c: support --merge-base in conjunction with --stdin

-- 
gitgitgadget
