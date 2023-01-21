Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5820BC27C76
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 01:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjAUBzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 20:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjAUBzb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 20:55:31 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C557314C
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:55:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y1so1776219wru.2
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=up1K6ASendt3wBZNEW7mzt7EXMtvG+o1RYZ2Nbk1IQE=;
        b=RfQ04/O9BhCaAojMFfl1ryIWdLRFVgbOwXsqiul/SXOjaDYs2Yik9RLo1qJRu//jDv
         ZjgJrdAf5VVJFDmykWK6/EbYImCPoDkr+TywLRvQayu5fLaLl3HhAgNblwyQiUzSkmc6
         Knt4+V6B/wEn4oJM3D6d+7mqyjIfvffD5Uj/4am6Jg8Q1Xq4cbhY8IPlGa+nSPSuvI/d
         4a2PXELN+1E+4pgv8Tn9N8bGpi9srvyQ2rgq4DU1rQbtmFuCX3Y8yfKrFFe+6CJrYNw+
         LOTWT70YfM+MpT+V66ccRjcjM6WoiOdYSGf/FE31aH7G6CVtsYho5PcUdo3tJr2qibwY
         PuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=up1K6ASendt3wBZNEW7mzt7EXMtvG+o1RYZ2Nbk1IQE=;
        b=F6pR/DB4w68xOBAck1c11rEOCgcFcwSK5iqdWwpO4S6H2guAsuGkr2vUipW4kraaaa
         vwdsXXbkQpuQZmmyBFy7BSeQN2jKazjYKYfDgJbo0Ac4FMRIJVyNRnZyw6H9vTREDxN9
         17dDjPwyMgSnyXk8Z8CPhflb2OYcOgMRC4TuzSIf7B3cBizQEhASn3fkJ2KaeSlPsDMC
         ytsUd8VgJl5nLkedAGhfYA62VVc0SW/7KDkJS5weyQRILVwycVlE927SswWawshY80GW
         VRTtTSZrQhwrhyr6oOE+sunSJVF+mTASvAIKAZ2Qw9Aah71RUTLU+f2JP59Qa87dyLNf
         zIeQ==
X-Gm-Message-State: AFqh2krES7raqvv16fYfguz+d90FqO5SBFjYHW0bO8D/kkqIQm1Mu6Gp
        Kpw0nYQAgwM+8Gl+beV9m9OttsDvrfI=
X-Google-Smtp-Source: AMrXdXszLsQFBKb+NqYxdQRLnqtxnBzOAo+MPsupsUJRcIptYo4q8rMD71fnrBfEOiltnG93U6vcqA==
X-Received: by 2002:a5d:55c5:0:b0:242:3812:f948 with SMTP id i5-20020a5d55c5000000b002423812f948mr23627542wrw.24.1674266128134;
        Fri, 20 Jan 2023 17:55:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g1-20020a5d46c1000000b00241cfe6e286sm36654752wrs.98.2023.01.20.17.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 17:55:27 -0800 (PST)
Message-Id: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
References: <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Jan 2023 01:55:19 +0000
Subject: [PATCH v3 0/7] rebase: fix several code/testing/documentation issues around flag
 incompatibilities
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had a report about --update-refs being ignored when --whitespace=fix was
passed, confusing an end user. These were already marked as incompatible in
the manual, but the code didn't check for the incompatibility and provide an
error to the user.

Folks brought up other flags tangentially when reviewing an earlier round of
this series, and I found we had more that were missing checks, and that we
were missing some testcases, and that the documentation was wrong on some of
the relevant options. So, I ended up getting lots of little fixes to
straighten these all out.

Left out of this series:

 * If an option like rebase.autosquash or rebase.updateRefs are selected and
   the user specifies e.g. --whitespace=fix, we should either (a) tailor the
   error message better to point out that it's a config option that is
   incompatible with their command line flag, or (b) implement
   --whitespace=fix for the merge backend so we can just deprecate and
   eventually remove the apply backend[1].

[1] See "longer term goal" at
https://lore.kernel.org/git/xmqqa78d2qmk.fsf@gitster-ct.c.googlers.com/

Changes since v2:

 * Remove the extra patch and reword the comment in t3422 more thoroughly.
 * Add tests for other flag incompatibilities that were missing
 * Add code that was missing for checking various flag incompatibilities
 * Fix incorrect claims in the documentation around incompatible options
 * A few other miscellaneous fixups noticed while doing all the above

Changes since v1:

 * Add a patch nuking the -C option to rebase (fixes confusion around the
   comment in t3422 and acknowledges the fact that the option is totally and
   utterly useless and always has been. It literally never affects the
   results of a rebase.)

Signed-off-by: Elijah Newren newren@gmail.com

Elijah Newren (7):
  rebase: mark --update-refs as requiring the merge backend
  rebase: flag --apply and --merge as incompatible
  rebase: remove --allow-empty-message from incompatible opts
  rebase: fix docs about incompatibilities with --root
  rebase: add coverage of other incompatible options
  rebase: clarify the OPT_CMDMODE incompatibilities
  rebase: fix formatting of rebase --reapply-cherry-picks option in docs

 Documentation/git-rebase.txt           | 73 +++++++++++++-------------
 builtin/rebase.c                       | 36 +++++++++----
 t/t3422-rebase-incompatible-options.sh | 42 +++++++++++++--
 3 files changed, 101 insertions(+), 50 deletions(-)


base-commit: 221222b278e713054e65cbbbcb2b1ac85483ea89
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1466%2Fnewren%2Frebase-update-refs-imply-merge-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1466/newren/rebase-update-refs-imply-merge-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1466

Range-diff vs v2:

 2:  2e44d0b7e57 ! 1:  9089834adea rebase: mark --update-refs as requiring the merge backend
     @@ Commit message
          --update-refs is built in terms of the sequencer, which requires the
          merge backend.  It was already marked as incompatible with the apply
          backend in the git-rebase manual, but the code didn't check for this
     -    incompatibility and warn the user.  Check and warn now.
     +    incompatibility and warn the user.  Check and error now.
      
     -    While at it, fix a typo in t3422...and fix some misleading wording (all
     -    useful options other than --whitespace=fix have long since been
     -    implemented in the merge backend).
     +    While at it, fix a typo in t3422...and fix some misleading wording
     +    (most options which used to be am-specific have since been implemented
     +    in the merge backend as well).
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     + ## Documentation/git-rebase.txt ##
     +@@ Documentation/git-rebase.txt: start would be overridden by the presence of
     + +
     + If the configuration variable `rebase.updateRefs` is set, then this option
     + can be used to override and disable this setting.
     +++
     ++See also INCOMPATIBLE OPTIONS below.
     + 
     + INCOMPATIBLE OPTIONS
     + --------------------
     +
       ## builtin/rebase.c ##
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
       		}
     @@ t/t3422-rebase-incompatible-options.sh: test_expect_success 'setup' '
      -# --merge nor --interactive (nor any options that imply those two) use
      -# git-am, using them together will result in flags like --whitespace=fix
      -# being ignored.  Make sure rebase warns the user and aborts instead.
     -+# Rebase has a useful option, --whitespace=fix, which is actually
     -+# built in terms of flags to git-am.  Since neither --merge nor
     -+# --interactive (nor any options that imply those two) use git-am,
     -+# using them together will result in --whitespace=fix being ignored.
     -+# Make sure rebase warns the user and aborts instead.
     ++# Rebase has a couple options which are specific to the apply backend,
     ++# and several options which are specific to the merge backend.  Flags
     ++# from the different sets cannot work together, and we do not want to
     ++# just ignore one of the sets of flags.  Make sure rebase warns the
     ++# user and aborts instead.
       #
       
       test_rebase_am_only () {
 1:  a0f8f5fac1c ! 2:  a8b5a0e4fb0 rebase: remove completely useless -C option
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    rebase: remove completely useless -C option
     +    rebase: flag --apply and --merge as incompatible
      
     -    The `-C` option to rebase was introduced with 67dad687ad ("add -C[NUM]
     -    to git-am", 2007-02-08).  Based on feedback on the patch, the author
     -    added the -C option not just to git-am but also to git-rebase.  But did
     -    it such that the option was just passed through to git-am (which passes
     -    it along to git-apply), with no corresponding option to format-patch.
     -
     -    As per the git-apply documentation for the `-C` option:
     -        Ensure at least <n> lines of surrounding context match...When fewer
     -        lines of surrounding context exist they all must match.
     -
     -    The fact that format-patch was not passed a -U option to increase the
     -    number of context lines meant that there would still only be 3 lines of
     -    context to match on.  So, anyone attempting to use this option in
     -    git-rebase would just be spinning their wheels and wasting time.  I was
     -    one such user a number of years ago.
     -
     -    Since this option can at best waste users time and is nothing more than
     -    a confusing no-op, and has never been anything other than a confusing
     -    no-op, and no one has ever bothered to create a testcase for it that
     -    goes beyond option parsing, simply excise the option.
     +    Previously, we flagged options which implied --apply as being
     +    incompatible with options which implied --merge.  But if both options
     +    were given explicitly, then we didn't flag the incompatibility.  The
     +    same is true with --apply and --interactive.  Add the check, and add
     +    some testcases to verify these are also caught.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     - ## Documentation/git-rebase.txt ##
     -@@ Documentation/git-rebase.txt: include::rerere-options.txt[]
     - 	Allows the pre-rebase hook to run, which is the default.  This option can
     - 	be used to override `--no-verify`.  See also linkgit:githooks[5].
     + ## builtin/rebase.c ##
     +@@ builtin/rebase.c: static int parse_opt_am(const struct option *opt, const char *arg, int unset)
     + 	BUG_ON_OPT_NEG(unset);
     + 	BUG_ON_OPT_ARG(arg);
       
     ---C<n>::
     --	Ensure at least `<n>` lines of surrounding context match before
     --	and after each change.  When fewer lines of surrounding
     --	context exist they all must match.  By default no context is
     --	ever ignored.  Implies `--apply`.
     --+
     --See also INCOMPATIBLE OPTIONS below.
     --
     - --no-ff::
     - --force-rebase::
     - -f::
     -@@ Documentation/git-rebase.txt: The following options:
     ++	if (opts->type != REBASE_UNSPECIFIED && opts->type != REBASE_APPLY)
     ++	    die(_("apply options and merge options cannot be used together"));
     ++
     + 	opts->type = REBASE_APPLY;
       
     -  * --apply
     -  * --whitespace
     -- * -C
     + 	return 0;
     +@@ builtin/rebase.c: static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
     + 	BUG_ON_OPT_NEG(unset);
     + 	BUG_ON_OPT_ARG(arg);
       
     - are incompatible with the following options:
     +-	if (!is_merge(opts))
     +-		opts->type = REBASE_MERGE;
     ++	if (opts->type != REBASE_UNSPECIFIED && opts->type != REBASE_MERGE)
     ++	    die(_("apply options and merge options cannot be used together"));
     ++
     ++	opts->type = REBASE_MERGE;
       
     -
     - ## builtin/rebase.c ##
     -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     - 			 N_("ignore author date and use current date")),
     - 		OPT_HIDDEN_BOOL(0, "ignore-date", &options.ignore_date,
     - 				N_("synonym of --reset-author-date")),
     --		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
     --				  N_("passed to 'git apply'"), 0),
     - 		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
     - 			 N_("ignore changes in whitespace")),
     - 		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
     -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     - 		if (!strcmp(option, "--whitespace=fix") ||
     - 		    !strcmp(option, "--whitespace=strip"))
     - 			allow_preemptive_ff = 0;
     --		else if (skip_prefix(option, "-C", &p)) {
     --			while (*p)
     --				if (!isdigit(*(p++)))
     --					die(_("switch `C' expects a "
     --					      "numerical value"));
     --		} else if (skip_prefix(option, "--whitespace=", &p)) {
     -+		else if (skip_prefix(option, "--whitespace=", &p)) {
     - 			if (*p && strcmp(p, "warn") && strcmp(p, "nowarn") &&
     - 			    strcmp(p, "error") && strcmp(p, "error-all"))
     - 				die("Invalid whitespace option: '%s'", p);
     -
     - ## t/t3406-rebase-message.sh ##
     -@@ t/t3406-rebase-message.sh: test_expect_success 'rebase --onto outputs the invalid ref' '
     - 	test_i18ngrep "invalid-ref" err
     - '
     + 	return 0;
     + }
     +@@ builtin/rebase.c: static int parse_opt_interactive(const struct option *opt, const char *arg,
     + 	BUG_ON_OPT_NEG(unset);
     + 	BUG_ON_OPT_ARG(arg);
     + 
     ++	if (opts->type != REBASE_UNSPECIFIED && opts->type != REBASE_MERGE)
     ++	    die(_("apply options and merge options cannot be used together"));
     ++
     + 	opts->type = REBASE_MERGE;
     + 	opts->flags |= REBASE_INTERACTIVE_EXPLICIT;
       
     --test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
     --	test_must_fail git rebase -Cnot-a-number HEAD 2>err &&
     --	test_i18ngrep "numerical value" err &&
     --	test_must_fail git rebase --whitespace=bad HEAD 2>err &&
     --	test_i18ngrep "Invalid whitespace option" err
     --'
     --
     - write_reflog_expect () {
     - 	if test $mode = --apply
     - 	then
      
       ## t/t3422-rebase-incompatible-options.sh ##
      @@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
     + 
       }
       
     ++# Check options which imply --apply
       test_rebase_am_only --whitespace=fix
     --test_rebase_am_only -C4
     + test_rebase_am_only -C4
     ++# Also check an explicit --apply
     ++test_rebase_am_only --apply
       
       test_done
 -:  ----------- > 3:  f4fbfd40d45 rebase: remove --allow-empty-message from incompatible opts
 -:  ----------- > 4:  a1e61ac8f21 rebase: fix docs about incompatibilities with --root
 -:  ----------- > 5:  48c40c0dda0 rebase: add coverage of other incompatible options
 -:  ----------- > 6:  8664cce6cf7 rebase: clarify the OPT_CMDMODE incompatibilities
 -:  ----------- > 7:  0e8b06163f2 rebase: fix formatting of rebase --reapply-cherry-picks option in docs

-- 
gitgitgadget
