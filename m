Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21611F462
	for <e@80x24.org>; Thu, 20 Jun 2019 10:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbfFTKC2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 06:02:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33565 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfFTKC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 06:02:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so2412426wru.0
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 03:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AGkaqsOO0mrx/1fxGMwb/EbpcmCr7YkregXD2w66xSA=;
        b=BVkjeK+kRY3WN48D4PSIm/JbOy6QZ5+8PAQtuSy94mzc2gqLFy3Bp/RqTrTdMibmLu
         gfBdTAanpKJCMkRHOUyjoenPPWJo+YKuHHnU6F5Gkg6fC5QluSS670PZWyOt4cJkkwBp
         mZj+CpDQm2RmswYf4WKDgNbFLw9e+yDkRPbk/Vt1vnd/OW0aSVlxhXEJ4iICK6Xiovq2
         tJGSFhb4t81VDny3GEkxdGGc6qv71mmE9LIojBI63a44SnSaXU3bSNIImsk8UB8lbtjr
         kCrsnDZyZb/hAjbtfSrFQgZV3UKu5p8w0oQbiD5xQmyNEZeJGl974lsE0AiroZDo9hRV
         MB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AGkaqsOO0mrx/1fxGMwb/EbpcmCr7YkregXD2w66xSA=;
        b=g3dV1VVu1V7qZwKKWqvDWNFm9RWdlfIJk8cBxFCzQgMFtB4l9hRp0Xha0tSIX02/AX
         ixOPzn6Yau+1Owgv3BK8320e5ByajS1QvdIEEUoVj2Ew8+8PoVFd2bovOJTctyyn+UVM
         CYwatzfF+f46J3uekXdlEqaGaE5X7YL47uV3Kfnsr81eQMkBFKwH1Ik6zr6IwWki4Trv
         E/Qg77KT3NMMz+juM+Ry5B670fN4ip0u89sCT0WmZXSOOIqCU0spXJyoaok/F930ITNl
         w2BN+HakJTkkJF5GTVkI9984WizUCAOb1E4ytynnmHePVuaRVIb5u/yC1xjaUZqSYwVU
         Utiw==
X-Gm-Message-State: APjAAAXMhgfJKahpAqXzxQp4CjN2Iq++4eGbgTpc1xith431XfC8b0AA
        yHqkDHiXapdySOcTptstN0I=
X-Google-Smtp-Source: APXvYqxGfukBKjwnfN9grdAokEyW3q+bpzuVUmvgj1zecynAObYZr2c/0LmqpsWcdABzLxrAhZLy5A==
X-Received: by 2002:a5d:488b:: with SMTP id g11mr14461971wrq.72.1561024944758;
        Thu, 20 Jun 2019 03:02:24 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id 72sm17483632wrk.22.2019.06.20.03.02.23
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 03:02:24 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v5 4/5] cherry-pick/revert: add --skip option
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        martin.agren@gmail.com, jrnieder@gmail.com, gitster@pobox.com
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190618170650.22721-1-rohit.ashiwal265@gmail.com>
 <20190618170650.22721-5-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0047b8c6-8a58-7546-2ae8-19c4ab668fa3@gmail.com>
Date:   Thu, 20 Jun 2019 11:02:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618170650.22721-5-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 18/06/2019 18:06, Rohit Ashiwal wrote:
> git am or rebase have a --skip flag to skip the current commit if the
> user wishes to do so. During a cherry-pick or revert a user could
> likewise skip a commit, but needs to use 'git reset' (or in the case
> of conflicts 'git reset --merge'), followed by 'git (cherry-pick |
> revert) --continue' to skip the commit. This is more annoying and
> sometimes confusing on the users' part. Add a `--skip` option to make
> skipping commits easier for the user and to make the commands more
> consistent.
> 
> In the next commit, we will change the advice messages hence finishing
> the process of teaching revert and cherry-pick "how to skip commits".
> 
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>   Documentation/git-cherry-pick.txt |   4 +-
>   Documentation/git-revert.txt      |   4 +-
>   Documentation/sequencer.txt       |   4 ++
>   builtin/revert.c                  |   5 ++
>   sequencer.c                       |  69 ++++++++++++++++++++
>   sequencer.h                       |   1 +
>   t/t3510-cherry-pick-sequence.sh   | 102 ++++++++++++++++++++++++++++++
>   7 files changed, 183 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index 754b16ce0c..83ce51aedf 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -10,9 +10,7 @@ SYNOPSIS
>   [verse]
>   'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff]
>   		  [-S[<keyid>]] <commit>...
> -'git cherry-pick' --continue
> -'git cherry-pick' --quit
> -'git cherry-pick' --abort
> +'git cherry-pick' (--continue | --skip | --abort | --quit)
>   
>   DESCRIPTION
>   -----------
> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index 0c82ca5bc0..665e065ee3 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -9,9 +9,7 @@ SYNOPSIS
>   --------
>   [verse]
>   'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>...
> -'git revert' --continue
> -'git revert' --quit
> -'git revert' --abort
> +'git revert' (--continue | --skip | --abort | --quit)
>   
>   DESCRIPTION
>   -----------
> diff --git a/Documentation/sequencer.txt b/Documentation/sequencer.txt
> index 5a57c4a407..3bceb56474 100644
> --- a/Documentation/sequencer.txt
> +++ b/Documentation/sequencer.txt
> @@ -3,6 +3,10 @@
>   	`.git/sequencer`.  Can be used to continue after resolving
>   	conflicts in a failed cherry-pick or revert.
>   
> +--skip::
> +	Skip the current commit and continue with the rest of the
> +	sequence.
> +
>   --quit::
>   	Forget about the current operation in progress.  Can be used
>   	to clear the sequencer state after a failed cherry-pick or
> diff --git a/builtin/revert.c b/builtin/revert.c
> index d4dcedbdc6..5dc5891ea2 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -102,6 +102,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>   		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
>   		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
>   		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
> +		OPT_CMDMODE(0, "skip", &cmd, N_("skip current commit and continue"), 's'),
>   		OPT_CLEANUP(&cleanup_arg),
>   		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
>   		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
> @@ -151,6 +152,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>   			this_operation = "--quit";
>   		else if (cmd == 'c')
>   			this_operation = "--continue";
> +		else if (cmd == 's')
> +			this_operation = "--skip";
>   		else {
>   			assert(cmd == 'a');
>   			this_operation = "--abort";
> @@ -210,6 +213,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>   		return sequencer_continue(the_repository, opts);
>   	if (cmd == 'a')
>   		return sequencer_rollback(the_repository, opts);
> +	if (cmd == 's')
> +		return sequencer_skip(the_repository, opts);
>   	return sequencer_pick_revisions(the_repository, opts);
>   }
>   
> diff --git a/sequencer.c b/sequencer.c
> index 6762a5f485..5720cd1c85 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2761,6 +2761,15 @@ static int rollback_single_pick(struct repository *r)
>   	return reset_merge(&head_oid);
>   }
>   
> +static int skip_single_pick(void)
> +{
> +	struct object_id head;
> +
> +	if (read_ref_full("HEAD", 0, &head, NULL))
> +		return error(_("cannot resolve HEAD"));
> +	return reset_merge(&head);
> +}
> +
>   int sequencer_rollback(struct repository *r, struct replay_opts *opts)
>   {
>   	FILE *f;
> @@ -2810,6 +2819,66 @@ int sequencer_rollback(struct repository *r, struct replay_opts *opts)
>   	return -1;
>   }
>   
> +int sequencer_skip(struct repository *r, struct replay_opts *opts)
> +{
> +	enum replay_action action = -1;
> +	sequencer_get_last_command(r, &action);
> +
> +	/*
> +	 * Check whether the subcommand requested to skip the commit is actually
> +	 * in progress and that it's safe to skip the commit.
> +	 *
> +	 * opts->action tells us which subcommand requested to skip the commit.
> +	 * If the corresponding .git/<ACTION>_HEAD exists, we know that the
> +	 * action is in progress and we can skip the commit.
> +	 *
> +	 * Otherwise we check that the last instruction was related to the
> +	 * particular subcommand we're trying to execute and barf if that's not
> +	 * the case.
> +	 *
> +	 * Finally we check that the rollback is "safe", i.e., has the HEAD
> +	 * moved? In this case, it doesn't make sense to "reset the merge" and
> +	 * "skip the commit" as the user already handled this by committing. But
> +	 * we'd not want to barf here, instead give advice on how to proceed. We
> +	 * only need to check that when .git/<ACTION>_HEAD doesn't exist because
> +	 * it gets removed when the user commits, so if it still exists we're
> +	 * sure the user can't have committed before.
> +	 */

Thanks for updating the comment, I think it is easier to follow now 
(Thanks to Thomas for suggesting it as well)

> +	switch (opts->action) {
> +	case REPLAY_REVERT:
> +		if (!file_exists(git_path_revert_head(r))) {
> +			if (action != REPLAY_REVERT)
> +				return error(_("no revert in progress"));
> +			if (!rollback_is_safe())
> +				goto give_advice;
> +		}
> +		break;
> +	case REPLAY_PICK:
> +		if (!file_exists(git_path_cherry_pick_head(r))) {
> +			if (action != REPLAY_PICK)
> +				return error(_("no cherry-pick in progress"));
> +			if (!rollback_is_safe())
> +				goto give_advice;
> +		}
> +		break;
> +	default:
> +		BUG("unexpected action in sequencer_skip");
> +	}
> +
> +	if (skip_single_pick())
> +		return error(_("failed to skip the commit"));
> +	if (!is_directory(git_path_seq_dir()))
> +		return 0;
> +
> +	return sequencer_continue(r, opts);
> +
> +give_advice:
> +	advise(_("have you committed already?\n"
> +		 "try \"git %s --continue\""),
> +		 action == REPLAY_REVERT ? "revert" : "cherry-pick");
> +	return error(_("there is nothing to skip"));
> +}
> +
>   static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
>   {
>   	struct lock_file todo_lock = LOCK_INIT;
> diff --git a/sequencer.h b/sequencer.h
> index 0c494b83d4..731b9853eb 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -129,6 +129,7 @@ int sequencer_pick_revisions(struct repository *repo,
>   			     struct replay_opts *opts);
>   int sequencer_continue(struct repository *repo, struct replay_opts *opts);
>   int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
> +int sequencer_skip(struct repository *repo, struct replay_opts *opts);
>   int sequencer_remove_state(struct replay_opts *opts);
>   
>   #define TODO_LIST_KEEP_EMPTY (1U << 0)
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index 941d5026da..dc0ac8343c 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -93,6 +93,108 @@ test_expect_success 'cherry-pick cleans up sequencer state upon success' '
>   	test_path_is_missing .git/sequencer
>   '
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
> +test_expect_success 'check advice when we move HEAD by committing' '
> +	pristine_detach initial &&
> +	cat >expect <<-EOF &&
> +	hint: have you committed already?
> +	hint: try "git cherry-pick --continue"
> +	error: there is nothing to skip
> +	fatal: cherry-pick failed
> +	EOF
> +	test_must_fail git cherry-pick base..yetanotherpick &&
> +	echo c >foo &&
> +	git commit -a &&
> +	test_path_is_missing .git/CHERRY_PICK_HEAD &&
> +	test_must_fail git cherry-pick --skip 2>advice &&
> +	test_i18ncmp expect advice
> +'
> +
> +test_expect_success 'allow skipping commit but not abort for a new history' '
> +	pristine_detach initial &&
> +	cat >expect <<-EOF &&
> +	error: cannot abort from a branch yet to be born
> +	fatal: cherry-pick failed
> +	EOF
> +	git checkout --orphan new_disconnected &&
> +	git reset --hard &&
> +	test_must_fail git cherry-pick anotherpick &&
> +	test_must_fail git cherry-pick --abort 2>advice &&
> +	git cherry-pick --skip &&
> +	test_i18ncmp expect advice
> +'
> +
> +test_expect_success 'allow skipping stopped cherry-pick because of untracked file modifications' '
> +	pristine_detach initial &&
> +	git rm --cached unrelated &&
> +	git commit -m "untrack unrelated" &&
> +	test_must_fail git cherry-pick initial base &&
> +	test_path_is_missing .git/CHERRY_PICK_HEAD &&
> +	git cherry-pick --skip

If you change this to --continue rather than --skip the test also 
passes! I think we could fix this by checking if HEAD has changed if 
CHERRY_PICK_HEAD/REVERT_HEAD is missing and not dropping the last 
command in the todo list in that case when we continue.

Best Wishes

Phillip

> +'
> +
>   test_expect_success '--quit does not complain when no cherry-pick is in progress' '
>   	pristine_detach initial &&
>   	git cherry-pick --quit
> 
