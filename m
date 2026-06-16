Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8AB42DFE0
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604633; cv=none; b=nP/6fmFLgIVLLGQrMDqA9TfoA+FsYfGljKxK6Ez6ZXeHQ9eHpNocPMp2UVEFiuNlw8RqxPal5iDFBJ2IOtad+0IPW845bpxtbxapu73gOJMPSmUgaRPiZD96Oi/17PvdqLlcKu9DAaMkBOkVvei/ZsQdSbFRgPg9J8F7RRt7+Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604633; c=relaxed/simple;
	bh=upi7u6kl5L4ygt7TKilfDZbjBjq22PSf2jG4wQ5S2zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTnwOjBgSh6kuKSwbCwEIl9beyJ1Mp7551kcLHVY9SxKeBudl258M1rg36TUAy5hWdWLVMVazMP8VDJ3H6kS/vfW6jzopZ7a4DJppOOuIji0goiQnxCZM+ToF3qEM77i4aDRW0Bvq1C1qUTY2zAId8ScflFZ/Dau4HSiUwePOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REJHERU1; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REJHERU1"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68c32f3c6d6so4323970a12.3
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781604630; x=1782209430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fbAPT94KJ0fSva9jedCp0j6fl5Tz6NDk+PeKoQNOWjw=;
        b=REJHERU1ft1CJDWMvHWTlrV3DQRDSsNQG1KajptMbcLC+1htZiPWG/mlvzSxa1izTK
         LhxaWOvqyPi28uttWNHeMyEEx/Pe8aMYhxHw0z1yQmUdaZnNga0sJzLEWtEY13lxJjXe
         v2LnATFJnAB/KjpA1rJognqx/Hhuw2Idc84jicGol0uPMnNnOO/dv+8Owv+EojMYxWfz
         aX174HLSUIrSfQwzGzY52FckXIq9WLffjRYRWQxQ4eO3BAGZ8rTfBecrZv0UP5jIAi1w
         DbqbI2ZOUzQrbpywQNbtd1vIlMCwyQKYI8AVWBlX5Tc72ItlE41srqUFHrQ7tYLWLANR
         GAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604630; x=1782209430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbAPT94KJ0fSva9jedCp0j6fl5Tz6NDk+PeKoQNOWjw=;
        b=H8sWyoD/e6851UAwZmumB0X8x+XUayhS03keSOH9IgBO52lcLzSim8gurMt75UcXj6
         k7UbxmifmE8tRmGnzqZUeGa78TV5wsJC+Tt5IyWpLwmOulaa3YYFoQM+AnNxRaeVIfSo
         VwH004oGpHjhU/MC0tFpnAOhCQvb9HC/TARUMQWAizx9uxxWvR86SKSqA6tMHPyxfP9B
         nSEV976MB9DgstJA0Vft8iXJRAUwOIOO6FDGL689aGVxlSvMi8XPRaxy0sLElfjrc1vJ
         utmpFlVKEI6AwFq1BaitVmnpbXvITFY9Q9cVXsvYCvPDlUyrTodKAnZIdO8FObbuwS2C
         MdzA==
X-Forwarded-Encrypted: i=1; AFNElJ+xc/3+BROl0SIVSb3sLW2ca4pFrZIfGrfv85VTMNkKWM5XczVmPEeDgxhoL1A54TnofuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZpF0G/6ZpJsg8oV42Q+3t6GykylS8j0L6o5UKJJShOm6Ye0g4
	BTj2f0YwxaxlPcvfNdmsxY6gTNfoUGxE+S3Z3NIwGOSOwri42sDYIVK8
X-Gm-Gg: Acq92OFPZ5HAtHaR/YgkIk/j01ujfo/Tiw/T8TJ+vX/pSBHM3nC6/SKXk6KJ2aV8e04
	2JP07i+KRXpqP9MMvLxC3T1LFdaOO+U+dBNtRJAO1Gco/b20ArRtuRVCBEpzwvXzF7mUlQqbobD
	3Isk8iTxJfGGzOTp3oM0WBAhU1HN5V3CmK4RarOEVrRUhH7dYQShXiYP6KNuwWDF/j5C6bhP8M/
	aiJV8Vg19KXIKavR+O25Ks7ohlPlbGa0pj/3MOyAxfSGAxw4Ur7d0bxD8Iw0VBEMDm8WfELPuh2
	Zvm/9jtiKB5iZEBh0mOavfEZKFr+ytcwmzt7q8TleuFldrcMX+wiVoFv5TKWBP3UpE9+SuVuNrZ
	wDReUcjDxW1SDApW8KcqriRheRQDlVH2lydhTCuZ6tATvqxyx065U2TCfOdhrT/jQ5PLWX3bSqN
	/NH/R7mRoE3DmgOV4UjgIAOqi2c3xzph+smcbfhW48DueFvOD1esAUvPjapfmkZ8JeU+SAJFMDs
	bKlSE+ky7s=
X-Received: by 2002:a05:6402:2688:b0:68d:4450:d21 with SMTP id 4fb4d7f45d1cf-695086f2480mr1497013a12.8.1781604629541;
        Tue, 16 Jun 2026 03:10:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6? ([2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937949fb19sm4614466a12.27.2026.06.16.03.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 03:10:28 -0700 (PDT)
Message-ID: <d55b6600-50f3-4e81-a6bf-d270cd7abd2d@gmail.com>
Date: Tue, 16 Jun 2026 11:10:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] rebase: add --squash to fold a range into its
 first commit
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
 <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 15/06/2026 09:37, Harald Nordgren via GitGitGadget wrote:
> Rename to rebase --squash.

Please include the original cover letter as well so people who have not 
read the previous version know what the series is about.

I agree that git-history might be a better place for this but I'm not 
opposed to adding a --squash option to git-rebase. However I do think we 
need to think about the implementation - picking consecutive commits 
when we want to squash them together is inefficient and if we're 
changing the base risks the user having to stop to resolve conflicts 
multiple times. Regardless of whether this ends up in git-rebase or 
git-history I think the implementation should cherry-pick the whole 
commit range by doing the equivalent of

   git merge-tree --merge-base $(git merge-base HEAD @{upstream}) \
                  @{upstream} HEAD

We should also let the user edit the commit message to reflect the 
changes that are being squashed in. We should think about what support 
we want for "amend!" commits that replace the commit message when rebasing.

Thanks

Phillip

> Harald Nordgren (2):
>    t3415: remove prepare-commit-msg hook after use
>    rebase: add --squash to fold a range
> 
>   Documentation/git-rebase.adoc |  11 ++++
>   builtin/rebase.c              |  16 ++++-
>   sequencer.c                   |  24 ++++++-
>   sequencer.h                   |   2 +-
>   t/t3415-rebase-autosquash.sh  | 118 ++++++++++++++++++++++++++++++++++
>   5 files changed, 166 insertions(+), 5 deletions(-)
> 
> 
> base-commit: ea97ad8d017de0c9037451a78008a0fd60abea0c
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v2
> Pull-Request: https://github.com/git/git/pull/2337
> 
> Range-diff vs v1:
> 
>   1:  c55b9cd6f7 = 1:  c55b9cd6f7 t3415: remove prepare-commit-msg hook after use
>   2:  bd1bc62aa8 ! 2:  22d4276ff5 rebase: add --fixup-all to fold a range
>       @@ Metadata
>        Author: Harald Nordgren <haraldnordgren@gmail.com>
>        
>         ## Commit message ##
>       -    rebase: add --fixup-all to fold a range
>       +    rebase: add --squash to fold a range
>        
>            Folding a series of commits into one required either an interactive
>            rebase where each commit after the first was hand-edited to "fixup", or
>            a "git reset --soft" to the merge base followed by "git commit --amend".
>        
>       -    Add "git rebase --autosquash --fixup-all [<upstream>]" to do this
>       -    directly. It keeps the first commit in the range as a "pick" and turns
>       -    every later commit into a "fixup", so the whole range collapses into a
>       -    single commit that reuses the first commit's message. With no <upstream>
>       -    argument the range is "@{upstream}..HEAD", folding all unpushed commits
>       -    into one.
>       +    Add "git rebase --squash [<upstream>]" to do this directly. It keeps
>       +    the first commit in the range as a "pick" and turns every later commit
>       +    into a "fixup", so the whole range collapses into a single commit that
>       +    reuses the first commit's message. With no <upstream> argument the range
>       +    is "@{upstream}..HEAD", folding all unpushed commits into one.
>        
>       -    Fold the commits in their original order, so that any fixup!/squash!
>       -    commits already present in the range are folded in as well. Allow the
>       -    flag only together with --autosquash, and reject --rebase-merges since a
>       -    merge commit cannot be folded into another commit.
>       +    The option implies the merge backend, so it works on its own without
>       +    --autosquash. Fold the commits in their original order, so that any
>       +    fixup!/squash! commits already present in the range are folded in as
>       +    well. Reject --rebase-merges since a merge commit cannot be folded into
>       +    another commit.
>        
>       +    Inspired-by: Sergey Chernov <serega.morph@gmail.com>
>            Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>        
>         ## Documentation/git-rebase.adoc ##
>       @@ Documentation/git-rebase.adoc: option can be used to override that setting.
>         +
>         See also INCOMPATIBLE OPTIONS below.
>         
>       -+--fixup-all::
>       -+	Valid only when used with `--autosquash`.  Keep the first commit in
>       -+	the range as a `pick` and change every later commit to a `fixup`, so
>       -+	the whole range is folded into a single commit that reuses the first
>       -+	commit's message.  With no `<upstream>` argument this folds all commits
>       -+	since `@{upstream}` into one.  The commits are folded in their original
>       -+	order, so any `fixup!`/`squash!` commits already in the range are folded
>       -+	in as well.  Cannot be combined with `--rebase-merges`, as a merge
>       -+	commit cannot be folded into another commit.
>       ++--squash::
>       ++	Keep the first commit in the range as a `pick` and change every later
>       ++	commit to a `fixup`, so the whole range is folded into a single commit
>       ++	that reuses the first commit's message.  With no `<upstream>` argument
>       ++	this folds all commits since `@{upstream}` into one.  The commits are
>       ++	folded in their original order, so any `fixup!`/`squash!` commits
>       ++	already in the range are folded in as well.  Cannot be combined with
>       ++	`--rebase-merges`, as a merge commit cannot be folded into another
>       ++	commit.
>        +
>         --autostash::
>         --no-autostash::
>       @@ Documentation/git-rebase.adoc: are incompatible with the following options:
>          * --strategy
>          * --strategy-option
>          * --autosquash
>       -+ * --fixup-all
>       ++ * --squash
>          * --rebase-merges
>          * --interactive
>          * --exec
>       @@ builtin/rebase.c: struct rebase_options {
>         	int allow_rerere_autoupdate;
>         	int keep_empty;
>         	int autosquash;
>       -+	int fixup_all;
>       ++	int squash;
>         	char *gpg_sign_opt;
>         	int autostash;
>         	int committer_date_is_author_date;
>       @@ builtin/rebase.c: static int do_interactive_rebase(struct rebase_options *opts,
>         		shortrevisions, opts->onto_name, opts->onto,
>         		&opts->orig_head->object.oid, &opts->exec,
>        -		opts->autosquash, opts->update_refs, &todo_list);
>       -+		opts->autosquash, opts->fixup_all, opts->update_refs,
>       ++		opts->autosquash, opts->squash, opts->update_refs,
>        +		&todo_list);
>         
>         cleanup:
>       @@ builtin/rebase.c: int cmd_rebase(int argc,
>         		OPT_BOOL(0, "autosquash", &options.autosquash,
>         			 N_("move commits that begin with "
>         			    "squash!/fixup! under -i")),
>       -+		OPT_BOOL(0, "fixup-all", &options.fixup_all,
>       ++		OPT_BOOL(0, "squash", &options.squash,
>        +			 N_("fold all commits in the range into the first one")),
>         		OPT_BOOL(0, "update-refs", &options.update_refs,
>         			 N_("update branches that point to commits "
>         			    "that are being rebased")),
>       +@@ builtin/rebase.c: int cmd_rebase(int argc,
>       + 	if ((options.flags & REBASE_INTERACTIVE_EXPLICIT) ||
>       + 	    (options.action != ACTION_NONE) ||
>       + 	    (options.exec.nr > 0) ||
>       +-	    options.autosquash == 1) {
>       ++	    options.autosquash == 1 ||
>       ++	    options.squash) {
>       + 		allow_preemptive_ff = 0;
>       + 	}
>       + 	if (options.committer_date_is_author_date || options.ignore_date)
>        @@ builtin/rebase.c: int cmd_rebase(int argc,
>         	options.rebase_merges = (options.rebase_merges >= 0) ? options.rebase_merges :
>         				((options.config_rebase_merges >= 0) ? options.config_rebase_merges : 0);
>         
>       -+	if (options.fixup_all && options.autosquash != 1)
>       -+		die(_("--fixup-all requires --autosquash"));
>       -+
>       -+	if (options.fixup_all && options.rebase_merges)
>       ++	if (options.squash && options.rebase_merges)
>        +		die(_("options '%s' and '%s' cannot be used together"),
>       -+		    "--fixup-all", "--rebase-merges");
>       ++		    "--squash", "--rebase-merges");
>       ++
>       ++	if (options.squash)
>       ++		imply_merge(&options, "--squash");
>        +
>         	if (options.autosquash == 1) {
>         		imply_merge(&options, "--autosquash");
>       @@ sequencer.c: static int todo_list_add_update_ref_commands(struct todo_list *todo
>         		    struct commit *onto, const struct object_id *orig_head,
>         		    struct string_list *commands, unsigned autosquash,
>        -		    unsigned update_refs,
>       -+		    unsigned fixup_all, unsigned update_refs,
>       ++		    unsigned squash, unsigned update_refs,
>         		    struct todo_list *todo_list)
>         {
>         	char shortonto[GIT_MAX_HEXSZ + 1];
>       @@ sequencer.c: int complete_action(struct repository *r, struct replay_opts *opts,
>         		return -1;
>         
>        -	if (autosquash && todo_list_rearrange_squash(todo_list))
>       -+	if (fixup_all)
>       ++	if (squash)
>        +		todo_list_fixup_all_but_first(todo_list);
>        +	else if (autosquash && todo_list_rearrange_squash(todo_list))
>         		return -1;
>       @@ sequencer.h: int complete_action(struct repository *r, struct replay_opts *opts,
>         		    struct commit *onto, const struct object_id *orig_head,
>         		    struct string_list *commands, unsigned autosquash,
>        -		    unsigned update_refs,
>       -+		    unsigned fixup_all, unsigned update_refs,
>       ++		    unsigned squash, unsigned update_refs,
>         		    struct todo_list *todo_list);
>         int todo_list_rearrange_squash(struct todo_list *todo_list);
>         
>       @@ t/t3415-rebase-autosquash.sh: test_expect_success 'pick and fixup respect commit
>         	test_commit_message HEAD -m "something"
>         '
>         
>       -+test_expect_success '--fixup-all folds the range into the first commit' '
>       ++test_expect_success '--squash folds the range into the first commit' '
>        +	git reset --hard base &&
>        +	test_commit --no-tag fold1 file_fold a &&
>        +	test_commit --no-tag fold2 file_fold b &&
>        +	test_commit --no-tag fold3 file_fold c &&
>       -+	git rebase --autosquash --fixup-all HEAD~3 &&
>       ++	git rebase --squash HEAD~3 &&
>        +	test_cmp_rev base HEAD~1 &&
>        +	test_commit_message HEAD -m "fold1" &&
>        +	echo c >expect &&
>        +	test_cmp expect file_fold
>        +'
>        +
>       -+test_expect_success '--fixup-all folds smoothly when a fixup! commit is in the series' '
>       ++test_expect_success '--squash folds smoothly when a fixup! commit is in the series' '
>        +	git reset --hard base &&
>        +	test_commit --no-tag foldA file_fold a &&
>        +	test_commit --no-tag foldB file_fold b &&
>        +	git commit --allow-empty --fixup HEAD~1 &&
>       -+	git rebase --autosquash --fixup-all HEAD~3 &&
>       ++	git rebase --squash HEAD~3 &&
>        +	test_cmp_rev base HEAD~1 &&
>        +	test_commit_message HEAD -m "foldA" &&
>        +	echo b >expect &&
>        +	test_cmp expect file_fold
>        +'
>        +
>       -+test_expect_success '--fixup-all picks the first commit even if it is a fixup!' '
>       ++test_expect_success '--squash picks the first commit even if it is a fixup!' '
>        +	git reset --hard base &&
>        +	test_commit --no-tag fixupbase file_fix a &&
>        +	git commit --allow-empty --fixup HEAD &&
>        +	test_commit --no-tag fixuptail file_fix b &&
>       -+	git rebase --autosquash --fixup-all HEAD~3 &&
>       ++	git rebase --squash HEAD~3 &&
>        +	test_cmp_rev base HEAD~1 &&
>        +	echo b >expect &&
>        +	test_cmp expect file_fix
>        +'
>        +
>       -+test_expect_success '--fixup-all with a single commit in range is a no-op' '
>       ++test_expect_success '--squash with a single commit in range is a no-op' '
>        +	git reset --hard base &&
>        +	test_commit --no-tag solo file_solo a &&
>        +	git rev-parse HEAD >expect &&
>       -+	git rebase --autosquash --fixup-all HEAD~1 &&
>       ++	git rebase --squash HEAD~1 &&
>        +	git rev-parse HEAD >actual &&
>        +	test_cmp expect actual
>        +'
>        +
>       -+test_expect_success '--fixup-all with an empty range succeeds' '
>       ++test_expect_success '--squash with an empty range succeeds' '
>        +	git reset --hard base &&
>       -+	git rebase --autosquash --fixup-all HEAD &&
>       ++	git rebase --squash HEAD &&
>        +	test_cmp_rev base HEAD
>        +'
>        +
>       -+test_expect_success '--fixup-all skips a dropped commit in the range' '
>       ++test_expect_success '--squash skips a dropped commit in the range' '
>        +	git reset --hard base &&
>        +	test_commit --no-tag fixdrop1 file_drop a &&
>        +	git commit --allow-empty -m "empty in the middle" &&
>        +	test_commit --no-tag fixdrop3 file_drop b &&
>       -+	git rebase --autosquash --empty=drop --fixup-all HEAD~3 &&
>       ++	git rebase --squash --empty=drop HEAD~3 &&
>        +	test_cmp_rev base HEAD~1 &&
>        +	test_commit_message HEAD -m "fixdrop1" &&
>        +	echo b >expect &&
>        +	test_cmp expect file_drop
>        +'
>        +
>       -+test_expect_success '--fixup-all folds a merge commit in the middle of the range' '
>       ++test_expect_success '--squash folds a merge commit in the middle of the range' '
>        +	git reset --hard base &&
>        +	test_commit --no-tag mid-first &&
>        +	git checkout -b mid-side &&
>       @@ t/t3415-rebase-autosquash.sh: test_expect_success 'pick and fixup respect commit
>        +	git checkout - &&
>        +	git merge --no-ff -m "merge mid-side" mid-side &&
>        +	test_commit --no-tag mid-last &&
>       -+	git rebase --autosquash --fixup-all base &&
>       ++	git rebase --squash base &&
>        +	test_cmp_rev base HEAD~1 &&
>        +	test_commit_message HEAD -m "mid-first" &&
>        +	test_path_is_file mid-merged.t
>        +'
>        +
>       -+test_expect_success '--fixup-all keeps the first flattened commit when a merge sorts first' '
>       ++test_expect_success '--squash keeps the first flattened commit when a merge sorts first' '
>        +	git reset --hard base &&
>        +	git checkout -b head-side &&
>        +	test_commit --no-tag head-merged &&
>        +	git checkout - &&
>        +	git merge --no-ff -m "merge head-side" head-side &&
>        +	test_commit --no-tag head-last &&
>       -+	git rebase --autosquash --fixup-all base &&
>       ++	git rebase --squash base &&
>        +	test_cmp_rev base HEAD~1 &&
>        +	test_commit_message HEAD -m "head-merged" &&
>        +	test_path_is_file head-merged.t
>        +'
>        +
>       -+test_expect_success '--fixup-all requires --autosquash' '
>       ++test_expect_success '--squash takes precedence over --autosquash' '
>        +	git reset --hard base &&
>       -+	test_must_fail git rebase --fixup-all HEAD~1 2>err &&
>       -+	test_grep "fixup-all requires --autosquash" err &&
>       -+	test_must_fail git rebase --no-autosquash --fixup-all HEAD~1 2>err &&
>       -+	test_grep "fixup-all requires --autosquash" err
>       ++	test_commit --no-tag combo-first &&
>       ++	test_commit --no-tag combo-mid &&
>       ++	git commit --allow-empty --fixup HEAD~1 &&
>       ++	test_commit --no-tag combo-last &&
>       ++	git rebase --autosquash --squash base &&
>       ++	test_cmp_rev base HEAD~1 &&
>       ++	test_commit_message HEAD -m "combo-first"
>       ++'
>       ++
>       ++test_expect_success '--squash folds the range with rebase.autosquash set' '
>       ++	test_config rebase.autosquash true &&
>       ++	git reset --hard base &&
>       ++	test_commit --no-tag cfg-first &&
>       ++	test_commit --no-tag cfg-last &&
>       ++	git rebase --squash base &&
>       ++	test_cmp_rev base HEAD~1 &&
>       ++	test_commit_message HEAD -m "cfg-first"
>        +'
>        +
>       -+test_expect_success '--fixup-all and --rebase-merges cannot be combined' '
>       ++test_expect_success '--squash and --rebase-merges cannot be combined' '
>        +	git reset --hard base &&
>       -+	test_must_fail git rebase --autosquash --rebase-merges \
>       -+		--fixup-all HEAD~1 2>err &&
>       ++	test_must_fail git rebase --rebase-merges --squash HEAD~1 2>err &&
>        +	test_grep "cannot be used together" err &&
>        +	test_path_is_missing .git/rebase-merge
>        +'
> 

