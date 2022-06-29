Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884B9C43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 15:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiF2PVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 11:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiF2PVm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 11:21:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506B62CDEF
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 08:21:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fi2so33244561ejb.9
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=agiwyDzq1NNS/tFL5BlfFyDCBv/8gAfe3XKP6ZNCaxU=;
        b=eZs+5EGOS/oXeozyjYqU7miz7AH8idm+JFdGMkd1+JrvMoOxDLzFLm3jNuqwxhxynQ
         mmUUm31tCesJXWCskNXivYf3OblOA/R9pDTFoSNoHGmGp2q1kiVgonOrGgAib2MaR9iv
         U76WNXwrs2dHL0B3mXqfUBwOMlIgJGi0X7U+VrVsMGctI9cIOXTQEahf3E8Kl2zuVC4h
         Vyu3SSQ3AjOMC67ai5vrUsingvJufN1behcfTrxUODohcPoMBWPejy0B/oA5gt4H/YyA
         DDIF3zYtuRO5Z6WbJl0/8gQWym3H0qC2YNupSdZ2MGnOdOXF9Yvk2WJ5TFHNZQQGY70V
         vwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=agiwyDzq1NNS/tFL5BlfFyDCBv/8gAfe3XKP6ZNCaxU=;
        b=ChesmdOV3O6nNTDkrW3LxCgVhPy5bF5iqvo54QUWPeJcmU6H9JyHQPWgUuIzBLEBKt
         73cffySw6JZPbdn2x9WO8hNvJNp5zQjAqOt1PAnV51DUQV8DjgVG2ZCwYPBQgysOrJs6
         /hOMy80vV+bqwQKkFsaNZfr3+eETZYkLqCKgwGPC7LyN3HLYXBOSJVvI+XXWz1GVt2B2
         W/LR5Uq8QAvlkG6KxqXqvYAbyFJ3YDXyhhIXuD4o33EJP6yVuInXyiZE1isX7QCG2Dtx
         6wbnu4KACHyjTb8RNmbox35o4u8TPKL0ElKe/ZpPZKnPsvJmdcA3Hxht6JWaPn7mdXRj
         a14w==
X-Gm-Message-State: AJIora/LogAxf3WG4HI3lKrHs1gPDY179o0ujk8QCApYKGuF/qG2fnkF
        KAl+u9ZwXqZSlN4xwvsYZJ4=
X-Google-Smtp-Source: AGRyM1vpRCoORD8kofBV3tF33JL87rJBoxTJ0NUfXhVovmKih6Cpxj+c8GGGLKb75rOyCaPDcU4+yg==
X-Received: by 2002:a17:906:db:b0:718:d986:d3d7 with SMTP id 27-20020a17090600db00b00718d986d3d7mr3872787eji.532.1656516097340;
        Wed, 29 Jun 2022 08:21:37 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id bg6-20020a170906a04600b00722e31fcf42sm7880997ejb.184.2022.06.29.08.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 08:21:36 -0700 (PDT)
Message-ID: <050620c5-6096-5abf-1723-1367f05b7d35@gmail.com>
Date:   Wed, 29 Jun 2022 16:21:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] git-rebase.txt: use back-ticks consistently
Content-Language: en-GB-large
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, Johannes.Schindelin@gmx.de,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1270.v2.git.1656446577611.gitgitgadget@gmail.com>
 <pull.1270.v3.git.1656508868146.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1270.v3.git.1656508868146.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

The range-diff looks fine to me

Thanks

Phillip

On 29/06/2022 14:21, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> While inspecting the 'git rebase' documentation, I noticed that it is
> inconsistent with how it uses back-ticks (or other punctuation) for
> identifying Git commands, command-line arguments, or values for those
> arguments.
> 
> Sometimes, an argument (like '--interactive') would appear without any
> punctuation, causing the argument to not have any special formatting.
> Other times, arguments or 'git rebase' itself would have single-quotes
> giving a bold look (in the HTML documentation at least).
> 
> By consistently using back-ticks, these types of strings appear in a
> monospace font with special highlighting to appear more clearly as text
> that exists in a command-line invocation of a Git command.
> 
> This rather-large diff is the result of scanning git-rebase.txt and
> adding back-ticks as appropriate. Some are adding back-ticks where there
> was no punctuation. Others are replacing single quotes.
> 
> There are also a few minor cleanups in the process, including those
> found by reviewers.
> 
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>      git-rebase.txt: use back-ticks consistently
>      
>      While I noticed this inconsistency when looking at git rebase as part of
>      the git rebase --update-refs work, I didn't know the best way to update
>      the document from start to finish.
>      
>      Feedback tells me that splitting this patch isn't worth it.
>      
>      
>      Updates in v3
>      =============
>      
>       * A much smaller round of edits, but huge thanks to Junio and Phillip
>         for a careful attention to detail.
>       * Use 'am' over am.
>       * Don't use colons in subsection headings.
>       * Fix a commit message typo.
>      
>      
>      Updates in v2
>      =============
>      
>       * The 'apply' and 'merge' backends are now quoted with single quotes
>         instead of back-ticks. (Phrases such as "the merge command"
>         describing the todo file still use back-ticks.)
>       * The pre-rebase hook now has back-ticks.
>       * An unnecessary comma is removed.
>       * When talking about 'ours' and 'theirs' as "sides" of a rebase, use
>         single quotes. Use back-ticks only for the ours strategy.
>       * A bulleted list is converted to use ";;" syntax.
>      
>      Thanks, -Stolee
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1270%2Fderrickstolee%2Frebase-docs-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1270/derrickstolee/rebase-docs-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1270
> 
> Range-diff vs v2:
> 
>   1:  02983cdb79d ! 1:  9c59d120c14 git-rebase.txt: use back-ticks consistently
>       @@ Commit message
>            was no punctuation. Others are replacing single quotes.
>        
>            There are also a few minor cleanups in the process, including those
>       -    found by reviwers.
>       +    found by reviewers.
>        
>            Helped-by: Phillip Wood <phillip.wood123@gmail.com>
>            Helped-by: Junio C Hamano <gitster@pobox.com>
>       @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
>        -replaced by the patch differ only in whitespace from the existing
>        -file, you will get a merge conflict instead of a successful patch
>        -application.
>       -+apply backend:;;
>       ++apply backend;;
>        +	When applying a patch, ignore changes in whitespace in context
>        +	lines. Unfortunately, this means that if the "old" lines being
>        +	replaced by the patch differ only in whitespace from the existing
>       @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
>        -when merging. Unfortunately, this means that any patch hunks that were
>        -intended to modify whitespace and nothing else will be dropped, even
>        -if the other side had no changes that conflicted.
>       -+merge backend:;;
>       ++merge backend;;
>        +	Treat lines with only whitespace changes as unchanged when merging.
>        +	Unfortunately, this means that any patch hunks that were intended
>        +	to modify whitespace and nothing else will be dropped, even if the
>       @@ Documentation/git-rebase.txt: In addition, the following pairs of options are in
>         -----------------------
>         
>        -git rebase has two primary backends: apply and merge.  (The apply
>       --backend used to be known as the 'am' backend, but the name led to
>       --confusion as it looks like a verb instead of a noun.  Also, the merge
>        +`git rebase` has two primary backends: 'apply' and 'merge'.  (The 'apply'
>       -+backend used to be known as the `am` backend, but the name led to
>       + backend used to be known as the 'am' backend, but the name led to
>       +-confusion as it looks like a verb instead of a noun.  Also, the merge
>        +confusion as it looks like a verb instead of a noun.  Also, the 'merge'
>         backend used to be known as the interactive backend, but it is now
>         used for non-interactive cases as well.  Both were renamed based on
> 
> 
>   Documentation/git-rebase.txt | 242 ++++++++++++++++++-----------------
>   1 file changed, 122 insertions(+), 120 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 262fb01aec0..a872ab0fbd1 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -16,40 +16,40 @@ SYNOPSIS
>   
>   DESCRIPTION
>   -----------
> -If <branch> is specified, 'git rebase' will perform an automatic
> +If `<branch>` is specified, `git rebase` will perform an automatic
>   `git switch <branch>` before doing anything else.  Otherwise
>   it remains on the current branch.
>   
> -If <upstream> is not specified, the upstream configured in
> -branch.<name>.remote and branch.<name>.merge options will be used (see
> +If `<upstream>` is not specified, the upstream configured in
> +`branch.<name>.remote` and `branch.<name>.merge` options will be used (see
>   linkgit:git-config[1] for details) and the `--fork-point` option is
>   assumed.  If you are currently not on any branch or if the current
>   branch does not have a configured upstream, the rebase will abort.
>   
>   All changes made by commits in the current branch but that are not
> -in <upstream> are saved to a temporary area.  This is the same set
> +in `<upstream>` are saved to a temporary area.  This is the same set
>   of commits that would be shown by `git log <upstream>..HEAD`; or by
>   `git log 'fork_point'..HEAD`, if `--fork-point` is active (see the
>   description on `--fork-point` below); or by `git log HEAD`, if the
>   `--root` option is specified.
>   
> -The current branch is reset to <upstream>, or <newbase> if the
> ---onto option was supplied.  This has the exact same effect as
> -`git reset --hard <upstream>` (or <newbase>).  ORIG_HEAD is set
> +The current branch is reset to `<upstream>` or `<newbase>` if the
> +`--onto` option was supplied.  This has the exact same effect as
> +`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
>   to point at the tip of the branch before the reset.
>   
>   The commits that were previously saved into the temporary area are
>   then reapplied to the current branch, one by one, in order. Note that
> -any commits in HEAD which introduce the same textual changes as a commit
> -in HEAD..<upstream> are omitted (i.e., a patch already accepted upstream
> +any commits in `HEAD` which introduce the same textual changes as a commit
> +in `HEAD..<upstream>` are omitted (i.e., a patch already accepted upstream
>   with a different commit message or timestamp will be skipped).
>   
>   It is possible that a merge failure will prevent this process from being
>   completely automatic.  You will have to resolve any such merge failure
>   and run `git rebase --continue`.  Another option is to bypass the commit
>   that caused the merge failure with `git rebase --skip`.  To check out the
> -original <branch> and remove the .git/rebase-apply working files, use the
> -command `git rebase --abort` instead.
> +original `<branch>` and remove the `.git/rebase-apply` working files, use
> +the command `git rebase --abort` instead.
>   
>   Assume the following history exists and the current branch is "topic":
>   
> @@ -79,7 +79,7 @@ remain the checked-out branch.
>   
>   If the upstream branch already contains a change you have made (e.g.,
>   because you mailed a patch which was applied upstream), then that commit
> -will be skipped and warnings will be issued (if the `merge` backend is
> +will be skipped and warnings will be issued (if the 'merge' backend is
>   used).  For example, running `git rebase master` on the following
>   history (in which `A'` and `A` introduce the same set of changes, but
>   have different committer information):
> @@ -176,11 +176,11 @@ would result in the removal of commits F and G:
>   ------------
>   
>   This is useful if F and G were flawed in some way, or should not be
> -part of topicA.  Note that the argument to --onto and the <upstream>
> +part of topicA.  Note that the argument to `--onto` and the `<upstream>`
>   parameter can be any valid commit-ish.
>   
> -In case of conflict, 'git rebase' will stop at the first problematic commit
> -and leave conflict markers in the tree.  You can use 'git diff' to locate
> +In case of conflict, `git rebase` will stop at the first problematic commit
> +and leave conflict markers in the tree.  You can use `git diff` to locate
>   the markers (<<<<<<) and make edits to resolve the conflict.  For each
>   file you edit, you need to tell Git that the conflict has been resolved,
>   typically this would be done with
> @@ -205,8 +205,8 @@ OPTIONS
>   -------
>   --onto <newbase>::
>   	Starting point at which to create the new commits. If the
> -	--onto option is not specified, the starting point is
> -	<upstream>.  May be any valid commit, and not just an
> +	`--onto` option is not specified, the starting point is
> +	`<upstream>`.  May be any valid commit, and not just an
>   	existing branch name.
>   +
>   As a special case, you may use "A\...B" as a shortcut for the
> @@ -215,19 +215,19 @@ leave out at most one of A and B, in which case it defaults to HEAD.
>   
>   --keep-base::
>   	Set the starting point at which to create the new commits to the
> -	merge base of <upstream> and <branch>. Running
> -	'git rebase --keep-base <upstream> <branch>' is equivalent to
> +	merge base of `<upstream>` and `<branch>`. Running
> +	`git rebase --keep-base <upstream> <branch>` is equivalent to
>   	running
> -	'git rebase --onto <upstream>...<branch> <upstream> <branch>'.
> +	`git rebase --onto <upstream>...<branch> <upstream> <branch>`.
>   +
>   This option is useful in the case where one is developing a feature on
>   top of an upstream branch. While the feature is being worked on, the
>   upstream branch may advance and it may not be the best idea to keep
>   rebasing on top of the upstream but to keep the base commit as-is.
>   +
> -Although both this option and --fork-point find the merge base between
> -<upstream> and <branch>, this option uses the merge base as the _starting
> -point_ on which new commits will be created, whereas --fork-point uses
> +Although both this option and `--fork-point` find the merge base between
> +`<upstream>` and `<branch>`, this option uses the merge base as the _starting
> +point_ on which new commits will be created, whereas `--fork-point` uses
>   the merge base to determine the _set of commits_ which will be rebased.
>   +
>   See also INCOMPATIBLE OPTIONS below.
> @@ -238,23 +238,23 @@ See also INCOMPATIBLE OPTIONS below.
>   	upstream for the current branch.
>   
>   <branch>::
> -	Working branch; defaults to HEAD.
> +	Working branch; defaults to `HEAD`.
>   
>   --continue::
>   	Restart the rebasing process after having resolved a merge conflict.
>   
>   --abort::
>   	Abort the rebase operation and reset HEAD to the original
> -	branch. If <branch> was provided when the rebase operation was
> -	started, then HEAD will be reset to <branch>. Otherwise HEAD
> +	branch. If `<branch>` was provided when the rebase operation was
> +	started, then `HEAD` will be reset to `<branch>`. Otherwise `HEAD`
>   	will be reset to where it was when the rebase operation was
>   	started.
>   
>   --quit::
> -	Abort the rebase operation but HEAD is not reset back to the
> +	Abort the rebase operation but `HEAD` is not reset back to the
>   	original branch. The index and working tree are also left
>   	unchanged as a result. If a temporary stash entry was created
> -	using --autostash, it will be saved to the stash list.
> +	using `--autostash`, it will be saved to the stash list.
>   
>   --apply::
>   	Use applying strategies to rebase (calling `git-am`
> @@ -269,16 +269,16 @@ See also INCOMPATIBLE OPTIONS below.
>   	empty after rebasing (because they contain a subset of already
>   	upstream changes).  With drop (the default), commits that
>   	become empty are dropped.  With keep, such commits are kept.
> -	With ask (implied by --interactive), the rebase will halt when
> +	With ask (implied by `--interactive`), the rebase will halt when
>   	an empty commit is applied allowing you to choose whether to
>   	drop it, edit files more, or just commit the empty changes.
> -	Other options, like --exec, will use the default of drop unless
> -	-i/--interactive is explicitly specified.
> +	Other options, like `--exec`, will use the default of drop unless
> +	`-i`/`--interactive` is explicitly specified.
>   +
> -Note that commits which start empty are kept (unless --no-keep-empty
> +Note that commits which start empty are kept (unless `--no-keep-empty`
>   is specified), and commits which are clean cherry-picks (as determined
>   by `git log --cherry-mark ...`) are detected and dropped as a
> -preliminary step (unless --reapply-cherry-picks is passed).
> +preliminary step (unless `--reapply-cherry-picks` is passed).
>   +
>   See also INCOMPATIBLE OPTIONS below.
>   
> @@ -287,7 +287,7 @@ See also INCOMPATIBLE OPTIONS below.
>   	Do not keep commits that start empty before the rebase
>   	(i.e. that do not change anything from its parent) in the
>   	result.  The default is to keep commits which start empty,
> -	since creating such commits requires passing the --allow-empty
> +	since creating such commits requires passing the `--allow-empty`
>   	override flag to `git commit`, signifying that a user is very
>   	intentionally creating such a commit and thus wants to keep
>   	it.
> @@ -299,7 +299,7 @@ flag exists as a convenient shortcut, such as for cases where external
>   tools generate many empty commits and you want them all removed.
>   +
>   For commits which do not start empty but become empty after rebasing,
> -see the --empty flag.
> +see the `--empty` flag.
>   +
>   See also INCOMPATIBLE OPTIONS below.
>   
> @@ -314,7 +314,7 @@ See also INCOMPATIBLE OPTIONS below.
>   By default (or if `--no-reapply-cherry-picks` is given), these commits
>   will be automatically dropped.  Because this necessitates reading all
>   upstream commits, this can be expensive in repos with a large number
> -of upstream commits that need to be read.  When using the `merge`
> +of upstream commits that need to be read.  When using the 'merge'
>   backend, warnings will be issued for each dropped commit (unless
>   `--quiet` is given). Advice will also be issued unless
>   `advice.skippedCherryPicks` is set to false (see linkgit:git-config[1]).
> @@ -348,10 +348,10 @@ See also INCOMPATIBLE OPTIONS below.
>   	Using merging strategies to rebase (default).
>   +
>   Note that a rebase merge works by replaying each commit from the working
> -branch on top of the <upstream> branch.  Because of this, when a merge
> +branch on top of the `<upstream>` branch.  Because of this, when a merge
>   conflict happens, the side reported as 'ours' is the so-far rebased
> -series, starting with <upstream>, and 'theirs' is the working branch.  In
> -other words, the sides are swapped.
> +series, starting with `<upstream>`, and 'theirs' is the working branch.
> +In other words, the sides are swapped.
>   +
>   See also INCOMPATIBLE OPTIONS below.
>   
> @@ -360,9 +360,9 @@ See also INCOMPATIBLE OPTIONS below.
>   	Use the given merge strategy, instead of the default `ort`.
>   	This implies `--merge`.
>   +
> -Because 'git rebase' replays each commit from the working branch
> -on top of the <upstream> branch using the given strategy, using
> -the 'ours' strategy simply empties all patches from the <branch>,
> +Because `git rebase` replays each commit from the working branch
> +on top of the `<upstream>` branch using the given strategy, using
> +the `ours` strategy simply empties all patches from the `<branch>`,
>   which makes little sense.
>   +
>   See also INCOMPATIBLE OPTIONS below.
> @@ -392,11 +392,11 @@ See also INCOMPATIBLE OPTIONS below.
>   
>   -q::
>   --quiet::
> -	Be quiet. Implies --no-stat.
> +	Be quiet. Implies `--no-stat`.
>   
>   -v::
>   --verbose::
> -	Be verbose. Implies --stat.
> +	Be verbose. Implies `--stat`.
>   
>   --stat::
>   	Show a diffstat of what changed upstream since the last rebase. The
> @@ -411,13 +411,13 @@ See also INCOMPATIBLE OPTIONS below.
>   
>   --verify::
>   	Allows the pre-rebase hook to run, which is the default.  This option can
> -	be used to override --no-verify.  See also linkgit:githooks[5].
> +	be used to override `--no-verify`.  See also linkgit:githooks[5].
>   
>   -C<n>::
> -	Ensure at least <n> lines of surrounding context match before
> +	Ensure at least `<n>` lines of surrounding context match before
>   	and after each change.  When fewer lines of surrounding
>   	context exist they all must match.  By default no context is
> -	ever ignored.  Implies --apply.
> +	ever ignored.  Implies `--apply`.
>   +
>   See also INCOMPATIBLE OPTIONS below.
>   
> @@ -436,21 +436,21 @@ details).
>   
>   --fork-point::
>   --no-fork-point::
> -	Use reflog to find a better common ancestor between <upstream>
> -	and <branch> when calculating which commits have been
> -	introduced by <branch>.
> +	Use reflog to find a better common ancestor between `<upstream>`
> +	and `<branch>` when calculating which commits have been
> +	introduced by `<branch>`.
>   +
> -When --fork-point is active, 'fork_point' will be used instead of
> -<upstream> to calculate the set of commits to rebase, where
> +When `--fork-point` is active, 'fork_point' will be used instead of
> +`<upstream>` to calculate the set of commits to rebase, where
>   'fork_point' is the result of `git merge-base --fork-point <upstream>
>   <branch>` command (see linkgit:git-merge-base[1]).  If 'fork_point'
> -ends up being empty, the <upstream> will be used as a fallback.
> +ends up being empty, the `<upstream>` will be used as a fallback.
>   +
> -If <upstream> is given on the command line, then the default is
> +If `<upstream>` is given on the command line, then the default is
>   `--no-fork-point`, otherwise the default is `--fork-point`. See also
>   `rebase.forkpoint` in linkgit:git-config[1].
>   +
> -If your branch was based on <upstream> but <upstream> was rewound and
> +If your branch was based on `<upstream>` but `<upstream>` was rewound and
>   your branch contains commits which were dropped, this option can be used
>   with `--keep-base` in order to drop those commits from your branch.
>   +
> @@ -458,24 +458,26 @@ See also INCOMPATIBLE OPTIONS below.
>   
>   --ignore-whitespace::
>   	Ignore whitespace differences when trying to reconcile
> -differences. Currently, each backend implements an approximation of
> -this behavior:
> +	differences. Currently, each backend implements an approximation of
> +	this behavior:
>   +
> -apply backend: When applying a patch, ignore changes in whitespace in
> -context lines. Unfortunately, this means that if the "old" lines being
> -replaced by the patch differ only in whitespace from the existing
> -file, you will get a merge conflict instead of a successful patch
> -application.
> +apply backend;;
> +	When applying a patch, ignore changes in whitespace in context
> +	lines. Unfortunately, this means that if the "old" lines being
> +	replaced by the patch differ only in whitespace from the existing
> +	file, you will get a merge conflict instead of a successful patch
> +	application.
>   +
> -merge backend: Treat lines with only whitespace changes as unchanged
> -when merging. Unfortunately, this means that any patch hunks that were
> -intended to modify whitespace and nothing else will be dropped, even
> -if the other side had no changes that conflicted.
> +merge backend;;
> +	Treat lines with only whitespace changes as unchanged when merging.
> +	Unfortunately, this means that any patch hunks that were intended
> +	to modify whitespace and nothing else will be dropped, even if the
> +	other side had no changes that conflicted.
>   
>   --whitespace=<option>::
> -	This flag is passed to the 'git apply' program
> +	This flag is passed to the `git apply` program
>   	(see linkgit:git-apply[1]) that applies the patch.
> -	Implies --apply.
> +	Implies `--apply`.
>   +
>   See also INCOMPATIBLE OPTIONS below.
>   
> @@ -537,7 +539,7 @@ See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
>   -x <cmd>::
>   --exec <cmd>::
>   	Append "exec <cmd>" after each line creating a commit in the
> -	final history. <cmd> will be interpreted as one or more shell
> +	final history. `<cmd>` will be interpreted as one or more shell
>   	commands. Any command that fails will interrupt the rebase,
>   	with exit code 1.
>   +
> @@ -550,7 +552,7 @@ or by giving more than one `--exec`:
>   +
>   	git rebase -i --exec "cmd1" --exec "cmd2" --exec ...
>   +
> -If `--autosquash` is used, "exec" lines will not be appended for
> +If `--autosquash` is used, `exec` lines will not be appended for
>   the intermediate commits, and will only appear at the end of each
>   squash/fixup series.
>   +
> @@ -560,11 +562,12 @@ without an explicit `--interactive`.
>   See also INCOMPATIBLE OPTIONS below.
>   
>   --root::
> -	Rebase all commits reachable from <branch>, instead of
> -	limiting them with an <upstream>.  This allows you to rebase
> -	the root commit(s) on a branch.  When used with --onto, it
> -	will skip changes already contained in <newbase> (instead of
> -	<upstream>) whereas without --onto it will operate on every change.
> +	Rebase all commits reachable from `<branch>`, instead of
> +	limiting them with an `<upstream>`.  This allows you to rebase
> +	the root commit(s) on a branch.  When used with `--onto`, it
> +	will skip changes already contained in `<newbase>` (instead of
> +	`<upstream>`) whereas without `--onto` it will operate on every
> +	change.
>   +
>   See also INCOMPATIBLE OPTIONS below.
>   
> @@ -643,9 +646,9 @@ In addition, the following pairs of options are incompatible:
>   BEHAVIORAL DIFFERENCES
>   -----------------------
>   
> -git rebase has two primary backends: apply and merge.  (The apply
> +`git rebase` has two primary backends: 'apply' and 'merge'.  (The 'apply'
>   backend used to be known as the 'am' backend, but the name led to
> -confusion as it looks like a verb instead of a noun.  Also, the merge
> +confusion as it looks like a verb instead of a noun.  Also, the 'merge'
>   backend used to be known as the interactive backend, but it is now
>   used for non-interactive cases as well.  Both were renamed based on
>   lower-level functionality that underpinned each.) There are some
> @@ -654,19 +657,19 @@ subtle differences in how these two backends behave:
>   Empty commits
>   ~~~~~~~~~~~~~
>   
> -The apply backend unfortunately drops intentionally empty commits, i.e.
> +The 'apply' backend unfortunately drops intentionally empty commits, i.e.
>   commits that started empty, though these are rare in practice.  It
>   also drops commits that become empty and has no option for controlling
>   this behavior.
>   
> -The merge backend keeps intentionally empty commits by default (though
> -with -i they are marked as empty in the todo list editor, or they can
> -be dropped automatically with --no-keep-empty).
> +The 'merge' backend keeps intentionally empty commits by default (though
> +with `-i` they are marked as empty in the todo list editor, or they can
> +be dropped automatically with `--no-keep-empty`).
>   
>   Similar to the apply backend, by default the merge backend drops
> -commits that become empty unless -i/--interactive is specified (in
> +commits that become empty unless `-i`/`--interactive` is specified (in
>   which case it stops and asks the user what to do).  The merge backend
> -also has an --empty={drop,keep,ask} option for changing the behavior
> +also has an `--empty={drop,keep,ask}` option for changing the behavior
>   of handling commits that become empty.
>   
>   Directory rename detection
> @@ -674,20 +677,20 @@ Directory rename detection
>   
>   Due to the lack of accurate tree information (arising from
>   constructing fake ancestors with the limited information available in
> -patches), directory rename detection is disabled in the apply backend.
> +patches), directory rename detection is disabled in the 'apply' backend.
>   Disabled directory rename detection means that if one side of history
>   renames a directory and the other adds new files to the old directory,
>   then the new files will be left behind in the old directory without
>   any warning at the time of rebasing that you may want to move these
>   files into the new directory.
>   
> -Directory rename detection works with the merge backend to provide you
> +Directory rename detection works with the 'merge' backend to provide you
>   warnings in such cases.
>   
>   Context
>   ~~~~~~~
>   
> -The apply backend works by creating a sequence of patches (by calling
> +The 'apply' backend works by creating a sequence of patches (by calling
>   `format-patch` internally), and then applying the patches in sequence
>   (calling `am` internally).  Patches are composed of multiple hunks,
>   each with line numbers, a context region, and the actual changes.  The
> @@ -698,11 +701,11 @@ order to apply the changes to the right lines.  However, if multiple
>   areas of the code have the same surrounding lines of context, the
>   wrong one can be picked.  There are real-world cases where this has
>   caused commits to be reapplied incorrectly with no conflicts reported.
> -Setting diff.context to a larger value may prevent such types of
> +Setting `diff.context` to a larger value may prevent such types of
>   problems, but increases the chance of spurious conflicts (since it
>   will require more lines of matching context to apply).
>   
> -The merge backend works with a full copy of each relevant file,
> +The 'merge' backend works with a full copy of each relevant file,
>   insulating it from these types of problems.
>   
>   Labelling of conflicts markers
> @@ -710,30 +713,30 @@ Labelling of conflicts markers
>   
>   When there are content conflicts, the merge machinery tries to
>   annotate each side's conflict markers with the commits where the
> -content came from.  Since the apply backend drops the original
> +content came from.  Since the 'apply' backend drops the original
>   information about the rebased commits and their parents (and instead
>   generates new fake commits based off limited information in the
>   generated patches), those commits cannot be identified; instead it has
> -to fall back to a commit summary.  Also, when merge.conflictStyle is
> -set to diff3 or zdiff3, the apply backend will use "constructed merge
> +to fall back to a commit summary.  Also, when `merge.conflictStyle` is
> +set to `diff3` or `zdiff3`, the 'apply' backend will use "constructed merge
>   base" to label the content from the merge base, and thus provide no
>   information about the merge base commit whatsoever.
>   
> -The merge backend works with the full commits on both sides of history
> +The 'merge' backend works with the full commits on both sides of history
>   and thus has no such limitations.
>   
>   Hooks
>   ~~~~~
>   
> -The apply backend has not traditionally called the post-commit hook,
> -while the merge backend has.  Both have called the post-checkout hook,
> -though the merge backend has squelched its output.  Further, both
> +The 'apply' backend has not traditionally called the post-commit hook,
> +while the 'merge' backend has.  Both have called the post-checkout hook,
> +though the 'merge' backend has squelched its output.  Further, both
>   backends only call the post-checkout hook with the starting point
>   commit of the rebase, not the intermediate commits nor the final
>   commit.  In each case, the calling of these hooks was by accident of
>   implementation rather than by design (both backends were originally
>   implemented as shell scripts and happened to invoke other commands
> -like 'git checkout' or 'git commit' that would call the hooks).  Both
> +like `git checkout` or `git commit` that would call the hooks).  Both
>   backends should have the same behavior, though it is not entirely
>   clear which, if any, is correct.  We will likely make rebase stop
>   calling either of these hooks in the future.
> @@ -741,10 +744,10 @@ calling either of these hooks in the future.
>   Interruptability
>   ~~~~~~~~~~~~~~~~
>   
> -The apply backend has safety problems with an ill-timed interrupt; if
> +The 'apply' backend has safety problems with an ill-timed interrupt; if
>   the user presses Ctrl-C at the wrong time to try to abort the rebase,
>   the rebase can enter a state where it cannot be aborted with a
> -subsequent `git rebase --abort`.  The merge backend does not appear to
> +subsequent `git rebase --abort`.  The 'merge' backend does not appear to
>   suffer from the same shortcoming.  (See
>   https://lore.kernel.org/git/20200207132152.GC2868@szeder.dev/ for
>   details.)
> @@ -756,8 +759,8 @@ When a conflict occurs while rebasing, rebase stops and asks the user
>   to resolve.  Since the user may need to make notable changes while
>   resolving conflicts, after conflicts are resolved and the user has run
>   `git rebase --continue`, the rebase should open an editor and ask the
> -user to update the commit message.  The merge backend does this, while
> -the apply backend blindly applies the original commit message.
> +user to update the commit message.  The 'merge' backend does this, while
> +the 'apply' backend blindly applies the original commit message.
>   
>   Miscellaneous differences
>   ~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -777,23 +780,23 @@ completeness:
>     them to stderr.
>   
>   * State directories: The two backends keep their state in different
> -  directories under .git/
> +  directories under `.git/`
>   
>   include::merge-strategies.txt[]
>   
>   NOTES
>   -----
>   
> -You should understand the implications of using 'git rebase' on a
> +You should understand the implications of using `git rebase` on a
>   repository that you share.  See also RECOVERING FROM UPSTREAM REBASE
>   below.
>   
> -When the git-rebase command is run, it will first execute a "pre-rebase"
> -hook if one exists.  You can use this hook to do sanity checks and
> -reject the rebase if it isn't appropriate.  Please see the template
> -pre-rebase hook script for an example.
> +When the rebase is run, it will first execute a `pre-rebase` hook if one
> +exists.  You can use this hook to do sanity checks and reject the rebase
> +if it isn't appropriate.  Please see the template `pre-rebase` hook script
> +for an example.
>   
> -Upon completion, <branch> will be the current branch.
> +Upon completion, `<branch>` will be the current branch.
>   
>   INTERACTIVE MODE
>   ----------------
> @@ -848,7 +851,7 @@ not look at them but at the commit names ("deadbee" and "fa1afe1" in this
>   example), so do not delete or edit the names.
>   
>   By replacing the command "pick" with the command "edit", you can tell
> -'git rebase' to stop after applying that commit, so that you can edit
> +`git rebase` to stop after applying that commit, so that you can edit
>   the files and/or the commit message, amend the commit, and continue
>   rebasing.
>   
> @@ -876,14 +879,13 @@ commit, the message from the final one is used.  You can also use
>   "fixup -C" to get the same behavior as "fixup -c" except without opening
>   an editor.
>   
> -
> -'git rebase' will stop when "pick" has been replaced with "edit" or
> +`git rebase` will stop when "pick" has been replaced with "edit" or
>   when a command fails due to merge errors. When you are done editing
>   and/or resolving conflicts you can continue with `git rebase --continue`.
>   
>   For example, if you want to reorder the last 5 commits, such that what
> -was HEAD~4 becomes the new HEAD. To achieve that, you would call
> -'git rebase' like this:
> +was `HEAD~4` becomes the new `HEAD`. To achieve that, you would call
> +`git rebase` like this:
>   
>   ----------------------
>   $ git rebase -i HEAD~5
> @@ -903,7 +905,7 @@ like this:
>   ------------------
>   
>   Suppose you want to rebase the side branch starting at "A" to "Q". Make
> -sure that the current HEAD is "B", and call
> +sure that the current `HEAD` is "B", and call
>   
>   -----------------------------
>   $ git rebase -i -r --onto Q O
> @@ -956,23 +958,23 @@ SPLITTING COMMITS
>   -----------------
>   
>   In interactive mode, you can mark commits with the action "edit".  However,
> -this does not necessarily mean that 'git rebase' expects the result of this
> +this does not necessarily mean that `git rebase` expects the result of this
>   edit to be exactly one commit.  Indeed, you can undo the commit, or you can
>   add other commits.  This can be used to split a commit into two:
>   
>   - Start an interactive rebase with `git rebase -i <commit>^`, where
> -  <commit> is the commit you want to split.  In fact, any commit range
> +  `<commit>` is the commit you want to split.  In fact, any commit range
>     will do, as long as it contains that commit.
>   
>   - Mark the commit you want to split with the action "edit".
>   
>   - When it comes to editing that commit, execute `git reset HEAD^`.  The
> -  effect is that the HEAD is rewound by one, and the index follows suit.
> +  effect is that the `HEAD` is rewound by one, and the index follows suit.
>     However, the working tree stays the same.
>   
>   - Now add the changes to the index that you want to have in the first
>     commit.  You can use `git add` (possibly interactively) or
> -  'git gui' (or both) to do that.
> +  `git gui` (or both) to do that.
>   
>   - Commit the now-current index with whatever commit message is appropriate
>     now.
> @@ -983,7 +985,7 @@ add other commits.  This can be used to split a commit into two:
>   
>   If you are not absolutely sure that the intermediate revisions are
>   consistent (they compile, pass the testsuite, etc.) you should use
> -'git stash' to stash away the not-yet-committed changes
> +`git stash` to stash away the not-yet-committed changes
>   after each commit, test, and amend the commit if fixes are necessary.
>   
>   
> @@ -1087,12 +1089,12 @@ NOTE: While an "easy case recovery" sometimes appears to be successful
>         example, a commit that was removed via `git rebase
>         --interactive` will be **resurrected**!
>   
> -The idea is to manually tell 'git rebase' "where the old 'subsystem'
> +The idea is to manually tell `git rebase` "where the old 'subsystem'
>   ended and your 'topic' began", that is, what the old merge base
>   between them was.  You will have to find a way to name the last commit
>   of the old 'subsystem', for example:
>   
> -* With the 'subsystem' reflog: after 'git fetch', the old tip of
> +* With the 'subsystem' reflog: after `git fetch`, the old tip of
>     'subsystem' is at `subsystem@{1}`.  Subsequent fetches will
>     increase the number.  (See linkgit:git-reflog[1].)
>   
> 
> base-commit: 9bef0b1e6ec371e786c2fba3edcc06ad040a536c
