Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5EA020248
	for <e@80x24.org>; Mon, 11 Mar 2019 11:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCKLQJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 07:16:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36060 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfCKLQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 07:16:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id j125so3866657wmj.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r7iePPJrrtLOP21b4mEzwgD75YkcuGqx8/Shv3vSaqM=;
        b=ADqKm3s1K90ewfg7j3nuNzWBJOVhdLg5atvS5c0VyDIyrPAWnTmAAjigQcofceTTro
         xcwXYhXnVfp73aSKVAkeGvdzmy4WbSytCC8oUYcbKGXU7FRSt6S1gZK9V8xsxPqfQi36
         pQMGGx8odFqi57ALB9i+QVPaixKCtT4T23/L7MLFXgi5ee0e9yXYZW0PEFbUwoZt+dTT
         4oOS8IsS5m7G+w81Oa0blNhHPAIaJQsFG8m4O2YbrWuwklwYsdz1wuNExe6BCH0lnO51
         ESSmcKGsCWCpcvAzNGt9sAivav7U/4ZfMMnHVchjDIHH9q9aJJUMIGU9ZZmK+Un4y5vH
         9eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r7iePPJrrtLOP21b4mEzwgD75YkcuGqx8/Shv3vSaqM=;
        b=iBUK6Pu7Qo5rt4UE6SaBKxZf9/Q06fRF5HUBZVS0QcDCZXlYJdHuWxzfmZ0VP9McxE
         KNRMPx5a8Qh44Wbr4dMsLUxIKoxb0EbptzsGnkEvQPFjnRCEIE2EN4rRpWev3mKiTrpE
         ZpO9dv6+KnNyZP+FiBLtS91n45rKlS9Idyjzx4PoSle0gC8LM7ORp8d5DVNQsj3YeOg4
         DNd3HOs7g1JDtoU58G46vDK0sn+95aDvvdHLo5YHvJ7jE/K6OwsbVnrBR1FnssyjJake
         z1Bi5hyyiulj6izPvr6Rfdb6JyiV+ic+NeEpID6Z6DSLQ+hOGGnhk3rQESDtAPLOmSCe
         pVBQ==
X-Gm-Message-State: APjAAAVVdNFglRXbOmHxF83pqvzn+fiO8aIMGf23nQyQy1PARLDFscXh
        vuBIK38gN5xsbPsUAf65PQg=
X-Google-Smtp-Source: APXvYqxSj1VixWn92Xny+IBUpnYarlIeiKz8ZqyrWetmKQ1kxmWyWuHCjafMxDfuk2GDnaI7oRQi/A==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr16856751wmb.61.1552302964098;
        Mon, 11 Mar 2019 04:16:04 -0700 (PDT)
Received: from [192.168.2.201] (host-92-22-31-213.as13285.net. [92.22.31.213])
        by smtp.googlemail.com with ESMTPSA id d21sm21110810wrc.44.2019.03.11.04.16.02
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 04:16:03 -0700 (PDT)
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command
 'switch'
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
Date:   Mon, 11 Mar 2019 11:16:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308095752.8574-11-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Duy

On 08/03/2019 09:57, Nguyễn Thái Ngọc Duy wrote:
> "git checkout" doing too many things is a source of confusion for many
> users (and it even bites old timers sometimes). To remedy that, the
> command will be split into two new ones: switch and
> something-to-checkout-paths. 

I think this is a good idea, thanks for working on it. I wonder if it
would be a good idea to have the new command refuse to checkout a new
branch if there is a cherry-pick/revert/merge/rebase in progress (with
an option to override the check) as switching branches in the middle of
one of those is likely to be confusing to users (if I do it it is
normally because I've forgotten that I've not run 'git whatever
--continue').

> The good old "git checkout" command is
> still here and will be until all (or most of users) are sick of it.
> 
> See the new man page for the final design of switch. The actual
> implementation though is still pretty much the same as "git checkout"
> and not completely aligned with the man page. Following patches will
> adjust their behavior to match the man page.
> ---
>  .gitignore                        |   1 +
>  Documentation/config/advice.txt   |  13 +-
>  Documentation/config/branch.txt   |   4 +-
>  Documentation/config/checkout.txt |   9 +-
>  Documentation/config/diff.txt     |   3 +-
>  Documentation/git-checkout.txt    |   4 +
>  Documentation/git-switch.txt      | 259 ++++++++++++++++++++++++++++++
>  Documentation/gitattributes.txt   |   3 +-
>  Documentation/githooks.txt        |   8 +-
>  Makefile                          |   1 +
>  builtin.h                         |   1 +
>  builtin/checkout.c                |  60 +++++--
>  command-list.txt                  |   1 +
>  git.c                             |   1 +
>  14 files changed, 341 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/git-switch.txt
> 
> diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
> new file mode 100644
> index 0000000000..ff60ba69fb
> --- /dev/null
> +++ b/Documentation/git-switch.txt
> @@ -0,0 +1,259 @@
> +git-switch(1)
> +=============
> +
> +NAME
> +----
> +git-switch - Switch branches
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git switch' [<options>] [--guess] <branch>
> +'git switch' [<options>] --detach [<start-point>]
> +'git switch' [<options>] (-c|-C|--orphan) <new-branch> [<start-point>]
> +
> +DESCRIPTION
> +-----------
> +Switch to a specified branch. The working tree and the index are
> +updated to match the branch. All new commits will be added to the tip
> +of this branch.
> +
> +Optionally a new branch could be created with either `-c` or `-C`, or
> +detach the working tree from any branch with `--detach`, along with
> +switching.
> +
> +Switching branches does not require a clean index and working tree
> +(i.e. no differences compared to 'HEAD'). The operation is aborted
> +however if the switch leads to loss of local changes, unless told
> +otherwise.
> +
> +OPTIONS
> +-------
> +<branch>::
> +	Branch to switch to.
> +
> +<new-branch>::
> +	Name for the new branch.
> +
> +<start-point>::
> +	The name of a commit at which to switch to before creating a
> +	new branch or detach from.
> ++
> +You can use the `"@{-N}"` syntax to refer to the N-th last
> +branch/commit switched to "git switch" or "git checkout"
> +operation. You may also specify `-` which is synonymous to `"@{-1}"`.
> ++
> +As a special case, you may use `"A...B"` as a shortcut for the merge
> +base of `A` and `B` if there is exactly one merge base. You can leave
> +out at most one of `A` and `B`, in which case it defaults to `HEAD`.
> +
> +-c <new-branch>::
> +--create <new-branch>::
> +	Create a new branch named `<new-branch>` starting at
> +	`<start-point>` before switching to the branch. This is a
> +	convenient shortcut for:
> ++
> +------------
> +$ git branch <new-branch>
> +$ git switch <new-branch>
> +------------
> +
> +-C <new-branch>::
> +--force-create <new-branch>::
> +	Similar to `--create` except that if `<new-branch>` already
> +	exists, it will be reset to `<start-point>`. This is a
> +	convenient shortcut for:

If we're renaming the options to be more meaningful then maybe we should
consider a different name for this one - it has nothing to do with
creating a branch. Maybe --reset or --update?

> ++
> +------------
> +$ git branch -f <new-branch>
> +$ git switch <new-branch>
> +------------
> +
> +-d::
> +--detach::
> +	Switch to a commit for inspection and discardable
> +	experiments. See the "DETACHED HEAD" section in
> +	linkgit:git-checkout[1] for details.
> +
> +-g::
> +--guess::
> +	If `<branch>` is not found but there does exist a tracking
> +	branch in exactly one remote (call it `<remote>`) with a
> +	matching name, treat as equivalent to
> ++
> +------------
> +$ git switch -c <branch> --track <remote>/<branch>
> +------------
> ++
> +If the branch exists in multiple remotes and one of them is named by
> +the `checkout.defaultRemote` configuration variable, we'll use that
> +one for the purposes of disambiguation, even if the `<branch>` isn't
> +unique across all remotes. Set it to e.g. `checkout.defaultRemote=origin`
> +to always checkout remote branches from there if `<branch>` is
> +ambiguous but exists on the 'origin' remote. See also
> +`checkout.defaultRemote` in linkgit:git-config[1].
> +
> +-q::
> +--quiet::
> +	Quiet, suppress feedback messages.
> +
> +-f::
> +--force::
> +	Proceed even if the index or the working tree differs from
> +	HEAD. Both the index and working tree are restored to match
> +	the switching target. This is used to throw away local
> +	changes.

I'd always thought that --force meant "throw away my local changes if
they conflict with the new branch" not "throw them away regardless"
(which is better as it is deterministic). Maybe we can come up with a
clearer name here --discard-changes? At the moment --force does not
throw away conflicts properly (see the script below in my comments about
--merge).

> +
> +--progress::
> +--no-progress::
> +	Progress status is reported on the standard error stream
> +	by default when it is attached to a terminal, unless `--quiet`
> +	is specified. This flag enables progress reporting even if not
> +	attached to a terminal, regardless of `--quiet`.
> +
> +-t::
> +--track::
> +	When creating a new branch, set up "upstream" configuration.
> +	`-c` is implied. See "--track" in linkgit:git-branch[1] for
> +	details.
> ++
> +If no `-c` option is given, the name of the new branch will be derived
> +from the remote-tracking branch, by looking at the local part of the
> +refspec configured for the corresponding remote, and then stripping
> +the initial part up to the "*".  This would tell us to use "hack" as
> +the local branch when branching off of "origin/hack" (or
> +"remotes/origin/hack", or even "refs/remotes/origin/hack").  If the
> +given name has no slash, or the above guessing results in an empty
> +name, the guessing is aborted.  You can explicitly give a name with
> +`-c` in such a case.
> +
> +--no-track::
> +	Do not set up "upstream" configuration, even if the
> +	branch.autoSetupMerge configuration variable is true.
> +
> +-m::
> +--merge::
> +	If you have local modifications to one or more files that are
> +	different between the current branch and the branch to which
> +	you are switching, the command refuses to switch branches in
> +	order to preserve your modifications in context.  However,
> +	with this option, a three-way merge between the current
> +	branch, your working tree contents, and the new branch is
> +	done, and you will be on the new branch.

I was wondering what people felt about making this the default for the
new command. If I'm carrying changes over to the new branch then I want
them to be merged in, it's annoying to have them carried over most of
the time but then sometimes have the checkout fail without specifying
--merge. At the moment if --merge falls back to doing a three-way merge
then it loses any newly staged files that are not in either HEAD. I
think they are thrown away in reset_tree(). Here is a script to
demonstrate that

d="$(mktemp -d)" &&
cd "$d" &&
git init &&
echo a>a &&
git add a &&
git commit -ama &&
git branch topic &&
echo b>a &&
git commit -amb &&
git checkout topic &&
echo c>a &&
echo x>x &&
git add x &&
git checkout -m master &&
echo 'x is missing &&
! git ls-files --error-unmatch x &&
# a is unmerged
git checkout -f topic &&
echo 'a is in stage 1'
git ls-files -s a


Best Wishes

Phillip

> ++
> +When a merge conflict happens, the index entries for conflicting
> +paths are left unmerged, and you need to resolve the conflicts
> +and mark the resolved paths with `git add` (or `git rm` if the merge
> +should result in deletion of the path).
> +
> +--conflict=<style>::
> +	The same as --merge option above, but changes the way the
> +	conflicting hunks are presented, overriding the
> +	merge.conflictStyle configuration variable.  Possible values are
> +	"merge" (default) and "diff3" (in addition to what is shown by
> +	"merge" style, shows the original contents).
> +
> +--orphan <new-branch>::
> +	Create a new 'orphan' branch, named `<new-branch>`, started from
> +	`<start-point>` and switch to it. See explanation of the same
> +	option in linkgit:git-checkout[1] for details.
> +
> +--ignore-other-worktrees::
> +	`git switch` refuses when the wanted ref is already
> +	checked out by another worktree. This option makes it check
> +	the ref out anyway. In other words, the ref can be held by
> +	more than one worktree.
> +
> +--recurse-submodules::
> +--no-recurse-submodules::
> +	Using --recurse-submodules will update the content of all initialized
> +	submodules according to the commit recorded in the superproject. If
> +	local modifications in a submodule would be overwritten the checkout
> +	will fail unless `-f` is used. If nothing (or --no-recurse-submodules)
> +	is used, the work trees of submodules will not be updated.
> +	Just like linkgit:git-submodule[1], this will detach the
> +	submodules HEAD.
> +
> +EXAMPLES
> +--------
> +
> +The following command switches to the "master" branch:
> +
> +------------
> +$ git switch master
> +------------
> +
> +After working in the wrong branch, switching to the correct branch
> +would be done using:
> +
> +------------
> +$ git switch mytopic
> +------------
> +
> +However, your "wrong" branch and correct "mytopic" branch may differ
> +in files that you have modified locally, in which case the above
> +switch would fail like this:
> +
> +------------
> +$ git switch mytopic
> +error: You have local changes to 'frotz'; not switching branches.
> +------------
> +
> +You can give the `-m` flag to the command, which would try a three-way
> +merge:
> +
> +------------
> +$ git switch -m mytopic
> +Auto-merging frotz
> +------------
> +
> +After this three-way merge, the local modifications are _not_
> +registered in your index file, so `git diff` would show you what
> +changes you made since the tip of the new branch.
> +
> +To switch back to the previous branch before we switched to mytopic
> +(i.e. "master" branch):
> +
> +------------
> +$ git switch -
> +------------
> +
> +You can grow a new branch from any commit. For example, switch to
> +"HEAD~3" and create branch "fixup":
> +
> +------------
> +$ git switch -c fixup HEAD~3
> +Switched to a new branch 'fixup'
> +------------
> +
> +If you want to start a new branch from a remote branch of the same
> +name, use `-g`:
> +
> +------------
> +$ git switch -g new-topic
> +Branch 'new-topic' set up to track remote branch 'new-topic' from 'origin'
> +Switched to a new branch 'new-topic'
> +------------
> +
> +To check out commit "HEAD~3" for temporary inspection or experiment
> +without creating a new branch:
> +
> +------------
> +$ git switch --detach HEAD~3
> +HEAD is now at 9fc9555312 Merge branch 'cc/shared-index-permbits'
> +------------
> +
> +If it turns out whatever you have done is worth keeping, you can
> +always create a new name for it (without switching away):
> +
> +------------
> +$ git switch -c good-surprises
> +------------
> +
> +SEE ALSO
> +--------
> +linkgit:git-checkout[1]
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 9b41f81c06..cd0f9fa507 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -112,7 +112,8 @@ Checking-out and checking-in
>  
>  These attributes affect how the contents stored in the
>  repository are copied to the working tree files when commands
> -such as 'git checkout' and 'git merge' run.  They also affect how
> +such as 'git switch', 'git checkout'  and 'git merge' run.
> +They also affect how
>  Git stores the contents you prepare in the working tree in the
>  repository upon 'git add' and 'git commit'.
>  
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 5bf653c111..8ff72f0613 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -165,12 +165,13 @@ rebased, and is not set when rebasing the current branch.
>  post-checkout
>  ~~~~~~~~~~~~~
>  
> -This hook is invoked when a linkgit:git-checkout[1] is run after having updated the
> +This hook is invoked when a linkgit:git-checkout[1] or
> +linkgit:git-switch[1] is run after having updated the
>  worktree.  The hook is given three parameters: the ref of the previous HEAD,
>  the ref of the new HEAD (which may or may not have changed), and a flag
>  indicating whether the checkout was a branch checkout (changing branches,
>  flag=1) or a file checkout (retrieving a file from the index, flag=0).
> -This hook cannot affect the outcome of `git checkout`.
> +This hook cannot affect the outcome of `git switch` or `git checkout`.
>  
>  It is also run after linkgit:git-clone[1], unless the `--no-checkout` (`-n`) option is
>  used. The first parameter given to the hook is the null-ref, the second the
> @@ -406,7 +407,8 @@ exit with a zero status.
>  For example, the hook can simply run `git read-tree -u -m HEAD "$1"`
>  in order to emulate `git fetch` that is run in the reverse direction
>  with `git push`, as the two-tree form of `git read-tree -u -m` is
> -essentially the same as `git checkout` that switches branches while
> +essentially the same as `git switch` or `git checkout`
> +that switches branches while
>  keeping the local changes in the working tree that do not interfere
>  with the difference between the branches.
>  
> diff --git a/Makefile b/Makefile
> index 148668368b..8e91db73ad 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -802,6 +802,7 @@ BUILT_INS += git-merge-subtree$X
>  BUILT_INS += git-show$X
>  BUILT_INS += git-stage$X
>  BUILT_INS += git-status$X
> +BUILT_INS += git-switch$X
>  BUILT_INS += git-whatchanged$X
>  
>  # what 'all' will build and 'install' will install in gitexecdir,
> diff --git a/builtin.h b/builtin.h
> index 6538932e99..c64e44450e 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -227,6 +227,7 @@ extern int cmd_show_index(int argc, const char **argv, const char *prefix);
>  extern int cmd_status(int argc, const char **argv, const char *prefix);
>  extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
>  extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
> +extern int cmd_switch(int argc, const char **argv, const char *prefix);
>  extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
>  extern int cmd_tag(int argc, const char **argv, const char *prefix);
>  extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 7d23083282..1eff10dbef 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -34,6 +34,11 @@ static const char * const checkout_usage[] = {
>  	NULL,
>  };
>  
> +static const char * const switch_branch_usage[] = {
> +	N_("git switch [<options>] [<branch>]"),
> +	NULL,
> +};
> +
>  struct checkout_opts {
>  	int patch_mode;
>  	int quiet;
> @@ -1411,33 +1416,25 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
>  	return newopts;
>  }
>  
> -int cmd_checkout(int argc, const char **argv, const char *prefix)
> +static int checkout_main(int argc, const char **argv, const char *prefix,
> +			 struct checkout_opts *opts, struct option *options,
> +			 const char * const usagestr[])
>  {
> -	struct checkout_opts real_opts;
> -	struct checkout_opts *opts = &real_opts;
>  	struct branch_info new_branch_info;
>  	int dwim_remotes_matched = 0;
>  	int dwim_new_local_branch;
> -	struct option *options = NULL;
>  
> -	memset(opts, 0, sizeof(*opts));
>  	memset(&new_branch_info, 0, sizeof(new_branch_info));
>  	opts->overwrite_ignore = 1;
>  	opts->prefix = prefix;
>  	opts->show_progress = -1;
>  	opts->overlay_mode = -1;
> -	opts->no_dwim_new_local_branch = 0;
>  
>  	git_config(git_checkout_config, opts);
>  
>  	opts->track = BRANCH_TRACK_UNSPECIFIED;
>  
> -	options = parse_options_dup(options);
> -	options = add_common_options(opts, options);
> -	options = add_switch_branch_options(opts, options);
> -	options = add_checkout_path_options(opts, options);
> -
> -	argc = parse_options(argc, argv, prefix, options, checkout_usage,
> +	argc = parse_options(argc, argv, prefix, options, usagestr,
>  			     PARSE_OPT_KEEP_DASHDASH);
>  
>  	dwim_new_local_branch = !opts->no_dwim_new_local_branch;
> @@ -1570,3 +1567,42 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  		return checkout_branch(opts, &new_branch_info);
>  	}
>  }
> +
> +int cmd_checkout(int argc, const char **argv, const char *prefix)
> +{
> +	struct checkout_opts opts;
> +	struct option *options = NULL;
> +	int ret;
> +
> +	memset(&opts, 0, sizeof(opts));
> +	opts.no_dwim_new_local_branch = 0;
> +
> +	options = parse_options_dup(options);
> +	options = add_common_options(&opts, options);
> +	options = add_switch_branch_options(&opts, options);
> +	options = add_checkout_path_options(&opts, options);
> +
> +	ret = checkout_main(argc, argv, prefix, &opts,
> +			    options, checkout_usage);
> +	FREE_AND_NULL(options);
> +	return ret;
> +}
> +
> +int cmd_switch(int argc, const char **argv, const char *prefix)
> +{
> +	struct checkout_opts opts;
> +	struct option *options = NULL;
> +	int ret;
> +
> +	memset(&opts, 0, sizeof(opts));
> +	opts.no_dwim_new_local_branch = 0;
> +
> +	options = parse_options_dup(options);
> +	options = add_common_options(&opts, options);
> +	options = add_switch_branch_options(&opts, options);
> +
> +	ret = checkout_main(argc, argv, prefix, &opts,
> +			    options, switch_branch_usage);
> +	FREE_AND_NULL(options);
> +	return ret;
> +}
> diff --git a/command-list.txt b/command-list.txt
> index 3a9af104b5..13317f47d4 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -171,6 +171,7 @@ git-status                              mainporcelain           info
>  git-stripspace                          purehelpers
>  git-submodule                           mainporcelain
>  git-svn                                 foreignscminterface
> +git-switch                              mainporcelain           history
>  git-symbolic-ref                        plumbingmanipulators
>  git-tag                                 mainporcelain           history
>  git-unpack-file                         plumbinginterrogators
> diff --git a/git.c b/git.c
> index 2014aab6b8..39582cf511 100644
> --- a/git.c
> +++ b/git.c
> @@ -573,6 +573,7 @@ static struct cmd_struct commands[] = {
>  	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
>  	{ "stripspace", cmd_stripspace },
>  	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
> +	{ "switch", cmd_switch, RUN_SETUP | NEED_WORK_TREE },
>  	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
>  	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
>  	{ "unpack-file", cmd_unpack_file, RUN_SETUP | NO_PARSEOPT },
> 

