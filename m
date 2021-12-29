Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EFEC433FE
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 18:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhL2SzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 13:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhL2SzM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 13:55:12 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5FEC06173E
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:12 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso12196105wme.1
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=EgnP2Zo14d3Jjns2s0aJK0pq386VxuzLtOHl6zxQzro=;
        b=SEBi3isfUJbZysds9c6W43Jvenu3p26VrsiFzhNMOkEhu9zgRv9BSWonemC53aTv6u
         6X5UGXmhgpudPIGO5o0bPV8kYAPyVWAEMc35gP/CsxwbUKrQMduQeISLeL9C7SGs+EMY
         siv84i4BVNE8abzh+qze+p7zF6Qp1ezqJln4hbh+B/CUjZQZHVLMXeqzQDlAhA/G7/8+
         rDobkkG+RNH3j9lWF7cDzum36CMZ2yl11cODUI5TbXidLTETWv9ivYanJ1Tn8DBYv5Rp
         Ew35ZIQQFdc1yNrd4WEyhk/zeUasgs8a1A1KiuumpERx0vzBkCW+gASbYf2x7exdms31
         mbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=EgnP2Zo14d3Jjns2s0aJK0pq386VxuzLtOHl6zxQzro=;
        b=2GJOlwISds6N4cMIIhdrbHRPscFaYxtVlnztHLgt5DS1FurX/qPgeVTxlNoO6MNmJ1
         hCw3x1FD3RTwh4cyQeSjQSAAWCAlfSRH8RYUXoldRaIPkhwfJ4Yu2ApwWdNdSNGsHkrH
         DTKUiMecUurFeZjY7x/Jbyt/VjM8qn/z71QlyVE47rbmD5F3cMBiLE5nIkH3kQCwbyzy
         MPu5dpM0TN7L/6AUaN4p6RT8KEKXjNRbWwDvOFQYQb3qzVPGLiFmdq0TEMibpjLb/q4j
         Lp7Te5HpIorf7zoL6pTt6PbKvk/T5DwRisAVl5M9tfh3HqafLA41wC5nPpGCaNP52TVE
         hr/g==
X-Gm-Message-State: AOAM530d1+MguRELfb29hkhWc/TrkDzFNXKxJNGkNFmc8ZTtaaF+O+4O
        TfsdgsZKWUZeiSm1SChmAWQ6d7L3MFI=
X-Google-Smtp-Source: ABdhPJz+tvee1+erfpEsh3z1/IRVg3sLlDRfqrgzhBrtLSted8WtRx4xvPDPWelbnQkkJvea+PQB/A==
X-Received: by 2002:a7b:c7c5:: with SMTP id z5mr22936652wmk.173.1640804109629;
        Wed, 29 Dec 2021 10:55:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay39sm17020739wmb.29.2021.12.29.10.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 10:55:09 -0800 (PST)
Message-Id: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 29 Dec 2021 18:54:56 +0000
Subject: [PATCH v3 00/11] Factorization of messages with similar meaning
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a meager attempt at rationalizing a small fraction of the
internationalized messages. Sorry in advance for the dull task of reviewing
these insipide patches.

Doing so has some positive effects:

 * non-translatable constant strings are kept out of the way for translators
 * messages with identical meaning are built identically
 * the total number of messages to translate is decreased.

Changes since V1:

 * took into account the comments, except for ref-filter.c where the
   proposed refactoring is not obvious.
 * added even more strings to the "cannot be used together" crowd.

Jean-Noël Avila (11):
  i18n: refactor "foo and bar are mutually exclusive"
  i18n: refactor "%s, %s and %s are mutually exclusive"
  i18n: turn "options are incompatible" into "cannot be used together"
  i18n: standardize "cannot open" and "cannot read"
  i18n: tag.c factorize i18n strings
  i18n: factorize "--foo requires --bar" and the like
  i18n: factorize "no directory given for --foo"
  i18n: refactor "unrecognized %(foo) argument" strings
  i18n: factorize "--foo outside a repository"
  i18n: ref-filter: factorize "%(foo) atom used without %(bar) atom"
  i18n: turn even more messages into "cannot be used together" ones

 apply.c                                   |  8 ++++----
 archive.c                                 |  8 ++++----
 builtin/add.c                             | 14 +++++++-------
 builtin/am.c                              |  4 ++--
 builtin/branch.c                          |  2 +-
 builtin/cat-file.c                        |  2 +-
 builtin/checkout.c                        | 12 ++++++------
 builtin/clone.c                           |  4 ++--
 builtin/commit.c                          | 18 ++++++++++--------
 builtin/describe.c                        |  6 +++---
 builtin/diff-tree.c                       |  2 +-
 builtin/difftool.c                        |  4 ++--
 builtin/fast-export.c                     |  4 ++--
 builtin/fetch.c                           |  8 ++++----
 builtin/index-pack.c                      |  4 ++--
 builtin/init-db.c                         |  2 +-
 builtin/log.c                             |  8 ++++----
 builtin/ls-files.c                        |  2 +-
 builtin/merge.c                           |  4 ++--
 builtin/pack-objects.c                    |  2 +-
 builtin/push.c                            |  8 ++++----
 builtin/rebase.c                          | 10 +++++-----
 builtin/repack.c                          |  4 ++--
 builtin/reset.c                           | 10 +++++-----
 builtin/rev-list.c                        |  4 ++--
 builtin/rm.c                              |  4 ++--
 builtin/show-branch.c                     |  4 ++--
 builtin/stash.c                           |  8 ++++----
 builtin/submodule--helper.c               |  4 ++--
 builtin/tag.c                             | 19 +++++++++++--------
 builtin/worktree.c                        |  6 +++---
 diff.c                                    |  8 ++++----
 fetch-pack.c                              |  2 +-
 git.c                                     |  6 +++---
 http-fetch.c                              |  4 ++--
 range-diff.c                              |  2 +-
 ref-filter.c                              | 22 +++++++++++-----------
 revision.c                                | 22 +++++++++++-----------
 t/t0001-init.sh                           |  2 +-
 t/t2025-checkout-no-overlay.sh            |  2 +-
 t/t2026-checkout-pathspec-file.sh         |  8 ++++----
 t/t2072-restore-pathspec-file.sh          |  6 +++---
 t/t3431-rebase-fork-point.sh              |  2 +-
 t/t3601-rm-pathspec-file.sh               |  4 ++--
 t/t3704-add-pathspec-file.sh              | 10 +++++-----
 t/t3909-stash-pathspec-file.sh            |  6 +++---
 t/t4209-log-pickaxe.sh                    | 10 +++++-----
 t/t5606-clone-options.sh                  |  4 ++--
 t/t7107-reset-pathspec-file.sh            |  6 +++---
 t/t7500-commit-template-squash-signoff.sh | 11 ++++++-----
 t/t7526-commit-pathspec-file.sh           | 10 +++++-----
 51 files changed, 176 insertions(+), 170 deletions(-)


base-commit: 2ae0a9cb8298185a94e5998086f380a355dd8907
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1088%2Fjnavila%2Fi18n-refactor-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1088/jnavila/i18n-refactor-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1088

Range-diff vs v2:

  1:  71699eaa27b !  1:  05af90f5814 i18n: refactor "foo and bar are mutually exclusive"
     @@ t/t2025-checkout-no-overlay.sh: test_expect_success 'checkout --no-overlay remov
       '
       
       test_expect_success '--no-overlay --theirs with D/F conflict deletes file' '
     -
     - ## t/t4209-log-pickaxe.sh ##
     -@@ t/t4209-log-pickaxe.sh: test_expect_success 'usage' '
     - 	test_i18ngrep "switch.*requires a value" err &&
     - 
     - 	test_expect_code 128 git log -Gregex -Sstring 2>err &&
     --	grep "mutually exclusive" err &&
     -+	grep "cannot be used together" err &&
     - 
     - 	test_expect_code 128 git log -Gregex --find-object=HEAD 2>err &&
     --	grep "mutually exclusive" err &&
     -+	grep "cannot be used together" err &&
     - 
     - 	test_expect_code 128 git log -Sstring --find-object=HEAD 2>err &&
     --	grep "mutually exclusive" err &&
     -+	grep "cannot be used together" err &&
     - 
     - 	test_expect_code 128 git log --pickaxe-all --find-object=HEAD 2>err &&
     - 	grep "mutually exclusive" err
  2:  be4e8757f38 !  2:  4accf1629e5 i18n: refactor "%s, %s and %s are mutually exclusive"
     @@ diff.c: void diff_setup_done(struct diff_options *options)
       
       	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_G_REGEX_MASK))
       		die(_("-G and --pickaxe-regex are mutually exclusive, use --pickaxe-regex with -S"));
     +
     + ## t/t4209-log-pickaxe.sh ##
     +@@ t/t4209-log-pickaxe.sh: test_expect_success 'usage' '
     + 	test_i18ngrep "switch.*requires a value" err &&
     + 
     + 	test_expect_code 128 git log -Gregex -Sstring 2>err &&
     +-	grep "mutually exclusive" err &&
     ++	grep "cannot be used together" err &&
     + 
     + 	test_expect_code 128 git log -Gregex --find-object=HEAD 2>err &&
     +-	grep "mutually exclusive" err &&
     ++	grep "cannot be used together" err &&
     + 
     + 	test_expect_code 128 git log -Sstring --find-object=HEAD 2>err &&
     +-	grep "mutually exclusive" err &&
     ++	grep "cannot be used together" err &&
     + 
     + 	test_expect_code 128 git log --pickaxe-all --find-object=HEAD 2>err &&
     + 	grep "mutually exclusive" err
  3:  53bad588bfc !  3:  486cc6c89e2 i18n: turn "options are incompatible" into "cannot be used together"
     @@ t/t2072-restore-pathspec-file.sh: test_expect_success 'error conditions' '
       	test_must_fail git restore --pathspec-from-file=list --source=HEAD^1 -- fileA.t 2>err &&
       	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
      
     + ## t/t3431-rebase-fork-point.sh ##
     +@@ t/t3431-rebase-fork-point.sh: test_expect_success 'git rebase --fork-point with ambigous refname' '
     + 
     + test_expect_success '--fork-point and --root both given' '
     + 	test_must_fail git rebase --fork-point --root 2>err &&
     +-	test_i18ngrep "cannot combine" err
     ++	test_i18ngrep "cannot be used together" err
     + '
     + 
     + test_expect_success 'rebase.forkPoint set to false' '
     +
       ## t/t3704-add-pathspec-file.sh ##
      @@ t/t3704-add-pathspec-file.sh: test_expect_success 'error conditions' '
       	>empty_list &&
     @@ t/t7526-commit-pathspec-file.sh: test_expect_success 'error conditions' '
      +	test_i18ngrep -e "options .--pathspec-from-file. and .--interactive/--patch. cannot be used together" err &&
       
       	test_must_fail git commit --pathspec-from-file=list --all -m "Commit" 2>err &&
     - 	test_i18ngrep -e "--pathspec-from-file with -a does not make sense" err &&
     +-	test_i18ngrep -e "--pathspec-from-file with -a does not make sense" err &&
     ++	test_i18ngrep -e "options .--pathspec-from-file. and .-a. cannot be used together" err &&
     + 
     + 	test_must_fail git commit --pathspec-from-file=list -m "Commit" -- fileA.t 2>err &&
     + 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
  4:  88dfde62eda =  4:  a2b42087342 i18n: standardize "cannot open" and "cannot read"
  5:  6d89c23a248 !  5:  2d83654c48a i18n: tag.c factorize i18n strings
     @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
       	}
       	if (filter.lines != -1)
      -		die(_("-n option is only allowed in list mode"));
     -+		only_in_list = "-n";
     - 	if (filter.with_commit)
     +-	if (filter.with_commit)
      -		die(_("--contains option is only allowed in list mode"));
     -+		only_in_list = "--contains";
     - 	if (filter.no_commit)
     +-	if (filter.no_commit)
      -		die(_("--no-contains option is only allowed in list mode"));
     -+		only_in_list = "--no-contains";
     - 	if (filter.points_at.nr)
     +-	if (filter.points_at.nr)
      -		die(_("--points-at option is only allowed in list mode"));
     ++		only_in_list = "-n";
     ++	else if (filter.with_commit)
     ++		only_in_list = "--contains";
     ++	else if (filter.no_commit)
     ++		only_in_list = "--no-contains";
     ++	else if (filter.points_at.nr)
      +		only_in_list = "--points-at";
      +	if (only_in_list)
     -+		die("the '%s' option is only allowed in list mode", only_in_list);
     ++		die(_("the '%s' option is only allowed in list mode"), only_in_list);
       	if (filter.reachable_from || filter.unreachable_from)
       		die(_("--merged and --no-merged options are only allowed in list mode"));
       	if (cmdmode == 'd') {
  6:  f83ed5cb799 !  6:  1097cc7d6d1 i18n: factorize "--foo requires --bar" and the like
     @@ Metadata
       ## Commit message ##
          i18n: factorize "--foo requires --bar" and the like
      
     +    They are all replaced by "the option '%s' requires '%s'", which is a
     +    new string but replaces 17 previous unique strings.
     +
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## archive.c ##
     @@ archive.c: static int parse_archive_args(int argc, const char **argv,
       		die(_("Unexpected option --remote"));
       	if (exec)
      -		die(_("Option --exec can only be used together with --remote"));
     -+		die(_("%s requires %s"), "--exec", "--remote");
     ++		die(_("the option '%s' requires '%s'"), "--exec", "--remote");
       	if (output)
       		die(_("Unexpected option --output"));
       	if (is_remote && args->extra_files.nr)
     @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
       
       	if (!show_only && ignore_missing)
      -		die(_("Option --ignore-missing can only be used together with --dry-run"));
     -+		die(_("%s requires %s"), "--ignore-missing", "--dry-run");
     ++		die(_("the option '%s' requires '%s'"), "--ignore-missing", "--dry-run");
       
       	if (chmod_arg && ((chmod_arg[0] != '-' && chmod_arg[0] != '+') ||
       			  chmod_arg[1] != 'x' || chmod_arg[2]))
     @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
       				    prefix, pathspec_from_file, pathspec_file_nul);
       	} else if (pathspec_file_nul) {
      -		die(_("--pathspec-file-nul requires --pathspec-from-file"));
     -+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
     ++		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
       	}
       
       	if (require_pathspec && pathspec.nr == 0) {
     @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const
       				    prefix, opts->pathspec_from_file, opts->pathspec_file_nul);
       	} else if (opts->pathspec_file_nul) {
      -		die(_("--pathspec-file-nul requires --pathspec-from-file"));
     -+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
     ++		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
       	}
       
       	opts->pathspec.recursive = 1;
     @@ builtin/commit.c: static const char *prepare_index(const char **argv, const char
       				    prefix, pathspec_from_file, pathspec_file_nul);
       	} else if (pathspec_file_nul) {
      -		die(_("--pathspec-file-nul requires --pathspec-from-file"));
     -+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
     ++		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
       	}
       
       	if (!pathspec.nr && (also || (only && !allow_empty &&
     @@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const ch
       
       	if (anonymized_seeds.cmpfn && !anonymize)
      -		die(_("--anonymize-map without --anonymize does not make sense"));
     -+		die(_("%s requires %s"), "--anonymize-map", "--anonymize");
     ++		die(_("the option '%s' requires '%s'"), "--anonymize-map", "--anonymize");
       
       	if (refspecs_list.nr) {
       		int i;
     @@ builtin/index-pack.c: int cmd_index_pack(int argc, const char **argv, const char
       		usage(index_pack_usage);
       	if (fix_thin_pack && !from_stdin)
      -		die(_("--fix-thin cannot be used without --stdin"));
     -+		die(_("%s requires %s"), "--fix-thin", "--stdin");
     ++		die(_("the option '%s' requires '%s'"), "--fix-thin", "--stdin");
       	if (from_stdin && !startup_info->have_repository)
       		die(_("--stdin requires a git repository"));
       	if (from_stdin && hash_algo)
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
       		creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
       	else if (!rdiff_prev)
      -		die(_("--creation-factor requires --range-diff"));
     -+		die(_("%s requires %s"), "--creation-factor", "--range-diff");
     ++		die(_("the option '%s' requires '%s'"), "--creation-factor", "--range-diff");
       
       	if (rdiff_prev) {
       		if (!cover_letter && total != 1)
     @@ builtin/reset.c: int cmd_reset(int argc, const char **argv, const char *prefix)
       				    prefix, pathspec_from_file, pathspec_file_nul);
       	} else if (pathspec_file_nul) {
      -		die(_("--pathspec-file-nul requires --pathspec-from-file"));
     -+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
     ++		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
       	}
       
       	unborn = !strcmp(rev, "HEAD") && get_oid("HEAD", &oid);
     @@ builtin/reset.c: int cmd_reset(int argc, const char **argv, const char *prefix)
       
       	if (intent_to_add && reset_type != MIXED)
      -		die(_("-N can only be used with --mixed"));
     -+		die(_("%s requires %s"), "-N", "--mixed");
     ++		die(_("the option '%s' requires '%s'"), "-N", "--mixed");
       
       	prepare_repo_settings(the_repository);
       	the_repository->settings.command_requires_full_index = 0;
     @@ builtin/rm.c: int cmd_rm(int argc, const char **argv, const char *prefix)
       				    prefix, pathspec_from_file, pathspec_file_nul);
       	} else if (pathspec_file_nul) {
      -		die(_("--pathspec-file-nul requires --pathspec-from-file"));
     -+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
     ++		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
       	}
       
       	if (!pathspec.nr)
     @@ builtin/stash.c: static int push_stash(int argc, const char **argv, const char *
       				    prefix, pathspec_from_file, pathspec_file_nul);
       	} else if (pathspec_file_nul) {
      -		die(_("--pathspec-file-nul requires --pathspec-from-file"));
     -+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
     ++		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
       	}
       
       	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
     @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix)
       		die(_("options '%s', '%s' and '%s' cannot be used together"), "-b", "-B", "--detach");
       	if (lock_reason && !keep_locked)
      -		die(_("--reason requires --lock"));
     -+		die(_("%s requires %s"), "--reason", "--lock");
     ++		die(_("the option '%s' requires '%s'"), "--reason", "--lock");
       	if (lock_reason)
       		opts.keep_locked = lock_reason;
       	else if (keep_locked)
     @@ fetch-pack.c: static int find_common(struct fetch_negotiator *negotiator,
       
       	if (args->stateless_rpc && multi_ack == 1)
      -		die(_("--stateless-rpc requires multi_ack_detailed"));
     -+		die(_("%s requires %s"), "--stateless-rpc", "multi_ack_detailed");
     ++		die(_("the option '%s' requires '%s'"), "--stateless-rpc", "multi_ack_detailed");
       
       	packet_reader_init(&reader, fd[0], NULL, 0,
       			   PACKET_READ_CHOMP_NEWLINE |
     @@ http-fetch.c: int cmd_main(int argc, const char **argv)
       	if (packfile) {
       		if (!index_pack_args.nr)
      -			die(_("--packfile requires --index-pack-args"));
     -+			die(_("%s requires %s"), "--packfile", "--index-pack-args");
     ++			die(_("the option '%s' requires '%s'"), "--packfile", "--index-pack-args");
       
       		fetch_single_packfile(&packfile_hash, argv[arg],
       				      index_pack_args.v);
     @@ http-fetch.c: int cmd_main(int argc, const char **argv)
       
       	if (index_pack_args.nr)
      -		die(_("--index-pack-args can only be used with --packfile"));
     -+		die(_("%s requires %s"), "--index-pack-args", "--packfile");
     ++		die(_("the option '%s' requires '%s'"), "--index-pack-args", "--packfile");
       
       	if (commits_on_stdin) {
       		commits = walker_targets_stdin(&commit_id, &write_ref);
     +
     + ## revision.c ##
     +@@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
     + 	if (revs->no_walk && revs->graph)
     + 		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
     + 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
     +-		die(_("%s requires %s"), "--grep-reflog", "--walk-reflogs");
     ++		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
     + 
     + 	if (revs->line_level_traverse &&
     + 	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
     +
     + ## t/t2026-checkout-pathspec-file.sh ##
     +@@ t/t2026-checkout-pathspec-file.sh: test_expect_success 'error conditions' '
     + 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
     + 
     + 	test_must_fail git checkout --pathspec-file-nul 2>err &&
     +-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err
     ++	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err
     + '
     + 
     + test_done
     +
     + ## t/t2072-restore-pathspec-file.sh ##
     +@@ t/t2072-restore-pathspec-file.sh: test_expect_success 'error conditions' '
     + 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
     + 
     + 	test_must_fail git restore --pathspec-file-nul --source=HEAD^1 2>err &&
     +-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
     ++	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
     + 
     + 	test_must_fail git restore --pathspec-from-file=empty_list --source=HEAD^1 2>err &&
     + 	test_i18ngrep -e "you must specify path(s) to restore" err
     +
     + ## t/t3601-rm-pathspec-file.sh ##
     +@@ t/t3601-rm-pathspec-file.sh: test_expect_success 'error conditions' '
     + 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
     + 
     + 	test_must_fail git rm --pathspec-file-nul 2>err &&
     +-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
     ++	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
     + 
     + 	>empty_list &&
     + 	test_must_fail git rm --pathspec-from-file=empty_list 2>err &&
     +
     + ## t/t3704-add-pathspec-file.sh ##
     +@@ t/t3704-add-pathspec-file.sh: test_expect_success 'error conditions' '
     + 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
     + 
     + 	test_must_fail git add --pathspec-file-nul 2>err &&
     +-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
     ++	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
     + 
     + 	# This case succeeds, but still prints to stderr
     + 	git add --pathspec-from-file=empty_list 2>err &&
     +
     + ## t/t3909-stash-pathspec-file.sh ##
     +@@ t/t3909-stash-pathspec-file.sh: test_expect_success 'error conditions' '
     + 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
     + 
     + 	test_must_fail git stash push --pathspec-file-nul 2>err &&
     +-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err
     ++	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err
     + '
     + 
     + test_done
     +
     + ## t/t7107-reset-pathspec-file.sh ##
     +@@ t/t7107-reset-pathspec-file.sh: test_expect_success 'error conditions' '
     + 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
     + 
     + 	test_must_fail git reset --pathspec-file-nul 2>err &&
     +-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
     ++	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
     + 
     + 	test_must_fail git reset --soft --pathspec-from-file=list 2>err &&
     + 	test_i18ngrep -e "fatal: Cannot do soft reset with paths" err &&
     +
     + ## t/t7526-commit-pathspec-file.sh ##
     +@@ t/t7526-commit-pathspec-file.sh: test_expect_success 'error conditions' '
     + 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
     + 
     + 	test_must_fail git commit --pathspec-file-nul -m "Commit" 2>err &&
     +-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
     ++	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
     + 
     + 	test_must_fail git commit --pathspec-from-file=empty_list --include -m "Commit" 2>err &&
     + 	test_i18ngrep -e "No paths with --include/--only does not make sense." err &&
  7:  2b7d558f8f9 =  7:  4c17e08b9d3 i18n: factorize "no directory given for --foo"
  8:  5f80ac2fa20 =  8:  b75c5b1ce35 i18n: refactor "unrecognized %(foo) argument" strings
  9:  9dd53960c42 =  9:  44d715a224c i18n: factorize "--foo outside a repository"
 10:  a575f566f2a = 10:  03a880d534b i18n: ref-filter: factorize "%(foo) atom used without %(bar) atom"
 11:  89066f01f32 ! 11:  12c5da81087 i18n: turn even more messages into "cannot be used together" ones
     @@ builtin/am.c: static int parse_opt_show_current_patch(const struct option *opt,
      -		return error(_("--show-current-patch=%s is incompatible with "
      -			       "--show-current-patch=%s"),
      +		return error(_("options '--show-current-patch=%s' and '--show-current-patch=%s' "
     -+					   "cannot used together"),
     ++					   "cannot be used together"),
       			     arg, valid_modes[resume->sub_mode]);
       
       	resume->mode = RESUME_SHOW_PATCH;
     @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *pr
       
       	if (force_path && batch.enabled) {
      -		error("--path=<path> incompatible with --batch");
     -+		error("'--path=<path>' and '--batch' cannot be used together");
     ++		error("options '--path=<path>' and '--batch' cannot be used together");
       		usage_with_options(cat_file_usage, options);
       	}
       
     @@ builtin/describe.c: int cmd_describe(int argc, const char **argv, const char *pr
       		describe("HEAD", 1);
       	} else if (dirty) {
      -		die(_("--dirty is incompatible with commit-ishes"));
     -+		die(_("'%s' and commit-ishes cannot be used together"), "--dirty");
     ++		die(_("option '%s' and commit-ishes cannot be used together"), "--dirty");
       	} else if (broken) {
      -		die(_("--broken is incompatible with commit-ishes"));
     -+		die(_("'%s' and  commit-ishes cannot be used together"), "--broken");
     ++		die(_("option '%s' and commit-ishes cannot be used together"), "--broken");
       	} else {
       		while (argc-- > 0)
       			describe(*argv++, argc == 0);
      
     - ## builtin/init-db.c ##
     -@@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, const char *prefix)
     - 	}
     - 	else {
     - 		if (real_git_dir)
     --			die(_("--separate-git-dir incompatible with bare repository"));
     -+			die(_("'--separate-git-dir' and bare repository cannot be used together"));
     - 		if (work_tree)
     - 			set_git_work_tree(work_tree);
     - 	}
     -
       ## builtin/rebase.c ##
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
       
     @@ diff.c: void diff_setup_done(struct diff_options *options)
       	/*
       	 * Most of the time we can say "there are changes"
      
     - ## t/t0001-init.sh ##
     -@@ t/t0001-init.sh: test_expect_success 'implicit bare & --separate-git-dir incompatible' '
     - 	mkdir -p bare.git &&
     - 	test_must_fail env GIT_DIR=. \
     - 		git -C bare.git init --separate-git-dir goop.git 2>err &&
     --	test_i18ngrep "incompatible" err
     -+	test_i18ngrep "cannot be used together" err
     - '
     - 
     - test_expect_success 'bare & --separate-git-dir incompatible within worktree' '
     -@@ t/t0001-init.sh: test_expect_success 'bare & --separate-git-dir incompatible within worktree' '
     - 	git clone --bare . bare.git &&
     - 	git -C bare.git worktree add --detach ../linkwt &&
     - 	test_must_fail git -C linkwt init --separate-git-dir seprepo 2>err &&
     --	test_i18ngrep "incompatible" err
     -+	test_i18ngrep "cannot be used together" err
     - '
     - 
     - test_lazy_prereq GETCWD_IGNORES_PERMS '
     -
       ## t/t2026-checkout-pathspec-file.sh ##
      @@ t/t2026-checkout-pathspec-file.sh: test_expect_success 'error conditions' '
       	test_i18ngrep -e "options .--pathspec-from-file. and .--patch. cannot be used together" err &&
     @@ t/t2026-checkout-pathspec-file.sh: test_expect_success 'error conditions' '
      +	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot be used together" err &&
       
       	test_must_fail git checkout --pathspec-file-nul 2>err &&
     - 	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err
     + 	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err
      
       ## t/t2072-restore-pathspec-file.sh ##
      @@ t/t2072-restore-pathspec-file.sh: test_expect_success 'error conditions' '
     @@ t/t2072-restore-pathspec-file.sh: test_expect_success 'error conditions' '
      +	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot be used together" err &&
       
       	test_must_fail git restore --pathspec-file-nul --source=HEAD^1 2>err &&
     - 	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
     -
     - ## t/t3431-rebase-fork-point.sh ##
     -@@ t/t3431-rebase-fork-point.sh: test_expect_success 'git rebase --fork-point with ambigous refname' '
     - 
     - test_expect_success '--fork-point and --root both given' '
     - 	test_must_fail git rebase --fork-point --root 2>err &&
     --	test_i18ngrep "cannot combine" err
     -+	test_i18ngrep "cannot be used together" err
     - '
     - 
     - test_expect_success 'rebase.forkPoint set to false' '
     + 	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
      
       ## t/t3601-rm-pathspec-file.sh ##
      @@ t/t3601-rm-pathspec-file.sh: test_expect_success 'error conditions' '
     @@ t/t3601-rm-pathspec-file.sh: test_expect_success 'error conditions' '
      +	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot be used together" err &&
       
       	test_must_fail git rm --pathspec-file-nul 2>err &&
     - 	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
     + 	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
      
       ## t/t3704-add-pathspec-file.sh ##
      @@ t/t3704-add-pathspec-file.sh: test_expect_success 'error conditions' '
     @@ t/t3704-add-pathspec-file.sh: test_expect_success 'error conditions' '
      +	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot be used together" err &&
       
       	test_must_fail git add --pathspec-file-nul 2>err &&
     - 	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
     + 	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
      
       ## t/t3909-stash-pathspec-file.sh ##
      @@ t/t3909-stash-pathspec-file.sh: test_expect_success 'error conditions' '
     @@ t/t3909-stash-pathspec-file.sh: test_expect_success 'error conditions' '
      +	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot be used together" err &&
       
       	test_must_fail git stash push --pathspec-file-nul 2>err &&
     - 	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err
     + 	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err
      
       ## t/t4209-log-pickaxe.sh ##
      @@ t/t4209-log-pickaxe.sh: test_expect_success 'usage' '
     @@ t/t7107-reset-pathspec-file.sh: test_expect_success 'error conditions' '
      +	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot be used together" err &&
       
       	test_must_fail git reset --pathspec-file-nul 2>err &&
     - 	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
     + 	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
      
       ## t/t7500-commit-template-squash-signoff.sh ##
      @@ t/t7500-commit-template-squash-signoff.sh: test_expect_success '--fixup=reword: ignores staged changes' '
     @@ t/t7500-commit-template-squash-signoff.sh: test_expect_success 'amend! commit al
       	test_expect_success "--fixup=reword: incompatible with $1" "
      -		echo 'fatal: reword option of --fixup is mutually exclusive with'\
      -			'--patch/--interactive/--all/--include/--only' >expect &&
     -+		echo 'fatal: reword option of --fixup and'\
     -+			'--patch/--interactive/--all/--include/--only'\
     ++		echo 'fatal: reword option of --fixup and' \
     ++			'--patch/--interactive/--all/--include/--only' \
      +			'cannot be used together' >expect &&
       		test_must_fail git commit --fixup=reword:HEAD~ $1 2>actual &&
       		test_cmp expect actual
     @@ t/t7500-commit-template-squash-signoff.sh: done
      
       ## t/t7526-commit-pathspec-file.sh ##
      @@ t/t7526-commit-pathspec-file.sh: test_expect_success 'error conditions' '
     - 	test_i18ngrep -e "options .--pathspec-from-file. and .--interactive/--patch. cannot be used together" err &&
     - 
     - 	test_must_fail git commit --pathspec-from-file=list --all -m "Commit" 2>err &&
     --	test_i18ngrep -e "--pathspec-from-file with -a does not make sense" err &&
     -+	test_i18ngrep -e ".--pathspec-from-file. and .-a. cannot be used together" err &&
     + 	test_i18ngrep -e "options .--pathspec-from-file. and .-a. cannot be used together" err &&
       
       	test_must_fail git commit --pathspec-from-file=list -m "Commit" -- fileA.t 2>err &&
      -	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
      +	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot be used together" err &&
       
       	test_must_fail git commit --pathspec-file-nul -m "Commit" 2>err &&
     - 	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
     + 	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&

-- 
gitgitgadget
