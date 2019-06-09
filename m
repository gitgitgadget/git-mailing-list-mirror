Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A43A71F462
	for <e@80x24.org>; Sun,  9 Jun 2019 08:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfFIIhO (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 04:37:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46753 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfFIIhO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 04:37:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so6070935wrw.13
        for <git@vger.kernel.org>; Sun, 09 Jun 2019 01:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vDU4FcvmC9ZN7przgsWdMXqyGExKmNRVlf28PFVI7Pw=;
        b=ArSUhFAWdpbrfZeBq9P6IsdPaBzWyAR9OtMxhj6tujTVSPm84j35fZ/Osq5T4RHyhd
         rTWJEsReMMTPgYH2bxHN08P85SzHHwNZKrN85jnXbvfpZa0D4/6G3k4a2abGCzOPRHD8
         kKIA7J8xygukVP7gNKz37jxqpDhkD5lWUgOecuRUUAHG+pqMS+20NNCVlI7f0U2LjR+1
         tHui5PL50qqK4WqmGEcSNCDxMTeD9vD/Jc79duniKoXxUxK5Z/dXkRVdP/O6qijGGqzC
         JzuKKsLzTaYNDxkhiATvZh+TKgjNT6IWHBTJt2RcomWkPRDxUemQIsTQA513R1+iw9qn
         b4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vDU4FcvmC9ZN7przgsWdMXqyGExKmNRVlf28PFVI7Pw=;
        b=g20TfzUdQ66AL2xnqBqhRUHllaQoekj3wlPgny7dNJDf4fMznr2RaIPhbn9JzbJEpp
         RPeQN+TWXTnNWavowS8hoBYsVaSFlZM0Rv2dVhnB/d9PLNqyqSvMHKgjQOspZ/9U0+iB
         MurUD/GFhPLauFAOPKbnchsqtISf0wRJnNGSJRdfrKdc6Krxc/u7Ezwu1wuYVbc24/OA
         podl/wim8AiHx+KcFHmEQmmHaik5kfpQIJTk+S0vJnPHPnCG40vRlMiHLFAFDP6n4WdI
         gprevUjTu0Hu9mPimuduQSxq4tm99jzKWpwzXhglB9ho79/8NwBqi6ocAVtUWw5tFjO/
         MjEA==
X-Gm-Message-State: APjAAAXD90KHLOURTcFpZAbNdmkrw7y6Dgx1x+Iittlh/wqNkYm5lDgS
        rCL3ZA4pCuklIpJKUgNVhZztVKu4pMEDmQ==
X-Google-Smtp-Source: APXvYqxKSlXWS7ljl1RkaswZgphx7N9Ez1tLHkZHlp9K8HrFM5JJ6Cjzr5Q8VetKZnCLdWtXfJCd2g==
X-Received: by 2002:a05:6000:cf:: with SMTP id q15mr9072257wrx.52.1560069431494;
        Sun, 09 Jun 2019 01:37:11 -0700 (PDT)
Received: from localhost (adsl-22.176.58.193.tellas.gr. [176.58.193.22])
        by smtp.gmail.com with ESMTPSA id u5sm8874437wmc.32.2019.06.09.01.37.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 01:37:10 -0700 (PDT)
Date:   Sun, 9 Jun 2019 09:37:09 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: [GSoC][PATCH 2/3] cherry-pick/revert: add --skip option
Message-ID: <20190609083708.GA28007@hank.intra.tgummerer.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190608191958.4593-3-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608191958.4593-3-rohit.ashiwal265@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/09, Rohit Ashiwal wrote:
> git am or rebase advise the user to use `git (am | rebase) --skip` to
> skip the commit. cherry-pick and revert also have this concept of
> skipping commits but they advise the user to use `git reset` (or in
> case of a patch which had conflicts, `git reset --merge`) which on the
> user's part is annoying and sometimes confusing. Add a `--skip` option
> to make these commands more consistent.

Something I missed in the off-list review for this PR:  I think this
commit message is a bit heavy on the advice part, rather than on the
real advantage the --skip flag brings, which is that it's less
cumbersome for the user to skip a commit, and brings consistency to
the commands.  Maybe something like:

        git am or rebase have a --skip flag to skip the current commit if
        the user wishes to do so.  During a cherry-pick or revert a user
        could likewise skip a commit, but needs to use 'git reset' (or in
        the case of conflicts 'git reset --merge'), followed by 'git
        (cherry-pick | revert) --continue' to skip the commit.  This is
        more annoying and sometimes confusing on the users part.  Add a
        `--skip` option to make skipping commits easier for the user and
        to make the commands more consistent.

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
> +		break;
> +	case REPLAY_PICK:
> +		if (!file_exists(git_path_cherry_pick_head(r)))
> +			return error(_("no cherry-pick in progress"));
> +		break;

I see that in some cases (e.g 'rollback_single_pick'), we just check
if either REVERT_HEAD or CHERRY_PICK_HEAD exist, but would allow the
"wrong" command to be used, e.g. 'git revert --abort' when a
cherry-pick is in progress.  This helps avoiding that, good!

> +	default:
> +		BUG("the control must not reach here.");

We don't support rebase in 'sequencer_skip' yet, makes sense as this
patch is focused on cherry-pick and revert.  There's nothing
preventing supporting that in the future though.

> +	}
> +
> +	if (rollback_single_pick(r))
> +		return error(_("failed to skip the commit"));
> +	if (!is_directory(git_path_seq_dir()))
> +		return 0;

If there's no sequencer directory, we don't need to continue the
cherry-pick/revert, as there's nothing left to do.  Otherwise we
continue.  Good.

So this looks good to me.

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
> -- 
> 2.21.0
> 
