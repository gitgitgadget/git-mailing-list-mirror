Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 345D61F462
	for <e@80x24.org>; Sun,  9 Jun 2019 18:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfFISBa (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 14:01:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52632 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbfFISBa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 14:01:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so6404291wms.2
        for <git@vger.kernel.org>; Sun, 09 Jun 2019 11:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J0LT3ijGLP58liioZFpejA1n9ofKWp6cb/mOBFZla5w=;
        b=Doe6FT08H9G2SbHc8DqB0U8wGhqBVYT+VMQRCweGtFZDiPtHlEXk4ZBRLGG/n3rdRZ
         De+EoVXgbkZ930gCzeIYWyVZN5mC+Bc671xpbf2mZCAErVU/8GSTWNZ1cF59Jf6kedWd
         SX/TAR2l93ALGDv3K6wqiksPA2h05c5j5clGJE+xnVyyASfLsYVT1+bm4Yl1S3IKsLso
         nR7JSuUdfxNGRE0vJU+jFYXluAaFWpaNJ/2jAy4CH2nAdNy5vMsKxMtezOqXQRUuDGgL
         vM3zeyj3yEDeQYXutoVTLpsgCGPsbSxvKgCoII8zK5gi1a1JMt2P0LUWLuM3HrTN0Mvu
         jv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J0LT3ijGLP58liioZFpejA1n9ofKWp6cb/mOBFZla5w=;
        b=WyDw+Suhuw7tMLmmebaw61mzbkZZtc6YEFvErGrSwy90cTFJCdPhesmvNi4ggFfir1
         jYKC73m9cdzNPHXM+P6ObgA7ns7BlgDyLqtYuVZGWSrYV1AVFR83zCFMRCg//jVXJf7W
         JIlsFn2T1PWLCzKHmd0VKN2gQwsra/QMoPO3sLr95OlMoXqzWaOoGl0qIotFWkf23ge6
         HW7n87bKE6T/EVq2Zt69DaiYRpMsz6ueeEby3OwRzNB2yGMvhz/FliOR32DuiNryygaV
         Z5h6cEPb6hY3UEpwxUKoUMJSejMYNo1VdJeeH0Vu0fYI7xf7PA8u1arrnhEgoDvX4BMo
         eUpA==
X-Gm-Message-State: APjAAAVOklgJrqK+hdS7xDyj856S6Wpfv6bEen9wL16NQsg0TzAgi1FO
        Irjb0LBn+4YbC9YYNw1wLD4=
X-Google-Smtp-Source: APXvYqziBWzzl19HEH9DiMbZyQ1Aj7yuhbrbKYg4kxj14LjDWxeBGaiVwd0V2Yx8BxDz0tyBwCQYbg==
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr10148380wmc.36.1560103286434;
        Sun, 09 Jun 2019 11:01:26 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id 95sm10334436wrk.70.2019.06.09.11.01.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 11:01:25 -0700 (PDT)
Subject: Re: [GSoC][PATCH 2/3] cherry-pick/revert: add --skip option
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>, git@vger.kernel.org
Cc:     newren@gmail.com, t.gummerer@gmail.com
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190608191958.4593-3-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0659a53e-0712-eb50-f15f-1c6a56fd3213@gmail.com>
Date:   Sun, 9 Jun 2019 19:01:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190608191958.4593-3-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

--skip is definitely a useful addition to cherry-pick/revert

On 08/06/2019 20:19, Rohit Ashiwal wrote:
> git am or rebase advise the user to use `git (am | rebase) --skip` to
> skip the commit. cherry-pick and revert also have this concept of
> skipping commits but they advise the user to use `git reset` (or in
> case of a patch which had conflicts, `git reset --merge`) which on the
> user's part is annoying and sometimes confusing. Add a `--skip` option
> to make these commands more consistent.
> 
> In the next commit, we will change the advice messages hence finishing
> the process of teaching revert and cherry-pick "how to skip commits".
> 
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>  Documentation/git-cherry-pick.txt |  4 +-
>  Documentation/git-revert.txt      |  4 +-
>  Documentation/sequencer.txt       |  4 ++
>  builtin/revert.c                  |  5 +++
>  sequencer.c                       | 23 +++++++++++
>  sequencer.h                       |  1 +
>  t/t3510-cherry-pick-sequence.sh   | 63 +++++++++++++++++++++++++++++++
>  7 files changed, 98 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index 754b16ce0c..955880ab88 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -10,9 +10,7 @@ SYNOPSIS
>  [verse]
>  'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff]
>  		  [-S[<keyid>]] <commit>...
> -'git cherry-pick' --continue
> -'git cherry-pick' --quit
> -'git cherry-pick' --abort
> +'git cherry-pick' --continue | --skip | --abort | --quit
>  
>  DESCRIPTION
>  -----------
> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index 0c82ca5bc0..ffce98099c 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -9,9 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>...
> -'git revert' --continue
> -'git revert' --quit
> -'git revert' --abort
> +'git revert' --continue | --skip | --abort | --quit
>  
>  DESCRIPTION
>  -----------
> diff --git a/Documentation/sequencer.txt b/Documentation/sequencer.txt
> index 5a57c4a407..3bceb56474 100644
> --- a/Documentation/sequencer.txt
> +++ b/Documentation/sequencer.txt
> @@ -3,6 +3,10 @@
>  	`.git/sequencer`.  Can be used to continue after resolving
>  	conflicts in a failed cherry-pick or revert.
>  
> +--skip::
> +	Skip the current commit and continue with the rest of the
> +	sequence.
> +
>  --quit::
>  	Forget about the current operation in progress.  Can be used
>  	to clear the sequencer state after a failed cherry-pick or
> diff --git a/builtin/revert.c b/builtin/revert.c
> index d4dcedbdc6..5dc5891ea2 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -102,6 +102,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>  		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
>  		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
>  		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
> +		OPT_CMDMODE(0, "skip", &cmd, N_("skip current commit and continue"), 's'),
>  		OPT_CLEANUP(&cleanup_arg),
>  		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
>  		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
> @@ -151,6 +152,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>  			this_operation = "--quit";
>  		else if (cmd == 'c')
>  			this_operation = "--continue";
> +		else if (cmd == 's')
> +			this_operation = "--skip";
>  		else {
>  			assert(cmd == 'a');
>  			this_operation = "--abort";
> @@ -210,6 +213,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>  		return sequencer_continue(the_repository, opts);
>  	if (cmd == 'a')
>  		return sequencer_rollback(the_repository, opts);
> +	if (cmd == 's')
> +		return sequencer_skip(the_repository, opts);
>  	return sequencer_pick_revisions(the_repository, opts);
>  }
>  
> diff --git a/sequencer.c b/sequencer.c
> index 9c561a041b..f586e677d3 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2784,6 +2784,29 @@ int sequencer_rollback(struct repository *r, struct replay_opts *opts)
>  	return -1;
>  }
>  
> +int sequencer_skip(struct repository *r, struct replay_opts *opts)
> +{
> +	switch (opts->action) {
> +	case REPLAY_REVERT:
> +		if (!file_exists(git_path_revert_head(r)))
> +			return error(_("no revert in progress"));

This error message is slightly misleading. If the user has already
committed a conflict resolution then REVERT_HEAD/CHERRY_PICK_HEAD will
not exist but it is possible that a cherry-pick/revert is in progress if
the user was picking a sequence of commits. It would be nice to give a
different error message or maybe just a warning in that case.
sequencer_get_last_command() should help with that.

> +		break;
> +	case REPLAY_PICK:
> +		if (!file_exists(git_path_cherry_pick_head(r)))
> +			return error(_("no cherry-pick in progress"));
> +		break;
> +	default:
> +		BUG("the control must not reach here.");
> +	}
> +
> +	if (rollback_single_pick(r))
> +		return error(_("failed to skip the commit"));

If rollback_single_pick() sees that HEAD is the null oid then it gives
the error "cannot abort from a branch yet to be born". We're not
aborting and if we're picking a sequence of commits the skip ought
succeed, but it won't at the moment. If we're picking a single commit
then the skip should probably fail like abort but with an appropriate
message. Admittedly that's all a bit of a corner case.

> +	if (!is_directory(git_path_seq_dir()))
> +		return 0;
> +
> +	return sequencer_continue(r, opts);
> +}
> +
>  static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
>  {
>  	struct lock_file todo_lock = LOCK_INIT;
> diff --git a/sequencer.h b/sequencer.h
> index 0c494b83d4..731b9853eb 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -129,6 +129,7 @@ int sequencer_pick_revisions(struct repository *repo,
>  			     struct replay_opts *opts);
>  int sequencer_continue(struct repository *repo, struct replay_opts *opts);
>  int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
> +int sequencer_skip(struct repository *repo, struct replay_opts *opts);
>  int sequencer_remove_state(struct replay_opts *opts);
>  
>  #define TODO_LIST_KEEP_EMPTY (1U << 0)
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index 941d5026da..48cc9f13ee 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -93,6 +93,69 @@ test_expect_success 'cherry-pick cleans up sequencer state upon success' '
>  	test_path_is_missing .git/sequencer
>  '
>  
> +test_expect_success 'cherry-pick --skip requires cherry-pick in progress' '
> +	pristine_detach initial &&
> +	test_must_fail git cherry-pick --skip
> +'
> +
> +test_expect_success 'revert --skip requires revert in progress' '
> +	pristine_detach initial &&
> +	test_must_fail git revert --skip
> +'
> +
> +test_expect_success 'cherry-pick --skip to skip commit' '
> +	pristine_detach initial &&
> +	test_must_fail git cherry-pick anotherpick &&
> +	test_must_fail git revert --skip &&
> +	git cherry-pick --skip &&
> +	test_cmp_rev initial HEAD &&
> +	test_path_is_missing .git/CHERRY_PICK_HEAD
> +'
> +
> +test_expect_success 'revert --skip to skip commit' '
> +	pristine_detach anotherpick &&
> +	test_must_fail git revert anotherpick~1 &&
> +	test_must_fail git cherry-pick --skip &&
> +	git revert --skip &&
> +	test_cmp_rev anotherpick HEAD
> +'
> +
> +test_expect_success 'skip "empty" commit' '
> +	pristine_detach picked &&
> +	test_commit dummy foo d &&
> +	test_must_fail git cherry-pick anotherpick &&
> +	git cherry-pick --skip &&
> +	test_cmp_rev dummy HEAD
> +'
> +
> +test_expect_success 'skip a commit and check if rest of sequence is correct' '
> +	pristine_detach initial &&
> +	echo e >expect &&
> +	cat >expect.log <<-EOF &&
> +	OBJID
> +	:100644 100644 OBJID OBJID M	foo
> +	OBJID
> +	:100644 100644 OBJID OBJID M	foo
> +	OBJID
> +	:100644 100644 OBJID OBJID M	unrelated
> +	OBJID
> +	:000000 100644 OBJID OBJID A	foo
> +	:000000 100644 OBJID OBJID A	unrelated
> +	EOF
> +	test_must_fail git cherry-pick base..yetanotherpick &&
> +	test_must_fail git cherry-pick --skip &&

It would be good to check that the cherry-pick has progressed since
--skip and didn't just fail without trying to pick another commit.


Best Wishes

Phillip

> +	echo d >foo &&
> +	git add foo &&
> +	git cherry-pick --continue &&
> +	{
> +		git rev-list HEAD |
> +		git diff-tree --root --stdin |
> +		sed "s/$OID_REGEX/OBJID/g"
> +	} >actual.log &&
> +	test_cmp expect foo &&
> +	test_cmp expect.log actual.log
> +'
> +
>  test_expect_success '--quit does not complain when no cherry-pick is in progress' '
>  	pristine_detach initial &&
>  	git cherry-pick --quit
> 

