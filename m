Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A1364EA5
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368936; cv=none; b=pMmX6557Kq4grRmrqswLkvEHKdDyVkXqOaoC85qSzrNRz+TjD6bKz7HoxNPrEHrIljfzCiWHj57rOWYHzbnSqh70LTiW/I6zvcGRyEnwNCaGE5qgkD9OCUdRER2T14iRM3AINRHA++r6nYiFHdWmakJj/ZkI75vSmuHx6VPPiMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368936; c=relaxed/simple;
	bh=9gRFsE+3nMrA+Mr8NgsV0bzHpiMfl/fYHkWdj0Lvy8g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EVz/HQdy/7ZljXRPOOkt5oSwQn694yce9CE28FwpXBOj/XLIGVXrA33S3xOHb/isY0idNqFdkQopgSiiamEJWAtSRh6yjJS0kisacNe6rPwTT7So6/X75O7jEDsDPGxaA2dN1YF5znjpH0etUdLxjLYrKMIlkiHhoaYscOnRC5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvRhR7BH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvRhR7BH"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so138018165e9.2
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 02:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777368932; x=1777973732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtl27V6qrFwdBImevipYKlfezE7OjFfT0jAlUE/dIR0=;
        b=qvRhR7BHXbqqpfLZYQk/dXa5iOml0xVY55LbIeUggSv2hFoqc/6SC42uuQzsHP1JLq
         BX2oBHGsUbPI8O5RObvjvvHww7VqaZCZyjg2C/pufGrp0k5PbZc7C8L/cd0W94pPwOef
         ZHrGUrThTOUNY9hH7C8Fk7FCiSL//V61Whl/SKmlG6sF3mStMj1pOhKL05/A9qvxEhUy
         2DGxIwA2CEcSqdYtjvfAEt9yiOc+cr5U69OlObdGw7w8nRQXmDvNE8Cu6niOiaBxqH5Z
         mdkfeM1vGpiVAXSLctHzNQNLT/KcykVsPmiCRUlBGcQCsp8vVNOP5aOzESnZMq76WHzd
         1/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368932; x=1777973732;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtl27V6qrFwdBImevipYKlfezE7OjFfT0jAlUE/dIR0=;
        b=Tt4a0mS9PfZapQSu3ZDxixlDrKMWvSHEzuYjv+sWl2+rvhZhoOASUbLDSfggq7+7L7
         SCSE+hj2GpErGXR6y/Svv7ypW05YArnBV+8FqN6kFfBwp1WPW2e26qVlI/TUcPF0b4tH
         3OwbOGHg2triJR2ii+jNMH71Ylw9GgnMwW7arsTPn6VAiOmv+JNn2yUg+RSS/ihI0PQr
         Nnnjicp3cpkMcuYFawV8C61rdLUEROsiuho36lM6v7AEhfImqDYcDwTPVI18CIkh0bwV
         6IfjHIM9U7TZtBVoNKeFL9N8prkQCp3ib9Cqym6M8a+udZN7HfMqsiDSkL2fz1rxawOy
         HS3w==
X-Forwarded-Encrypted: i=1; AFNElJ9JnMCNH9u3LKMctfnmyVqiWlvfLY/GSHNuJx1pn7bOcLg8KQpwM7ZMXV1AQQaN98dPxqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlFObcNKl27r+Jmsi8RjIsF86HLkSoK0VzPBH3cY51b/5+Ns4x
	iKg8FS/Tw+rrUlvlPFYCVRp5lBXmTb9lmaooE8Kn2m0VH05+aTgJz0KKf9qaSw==
X-Gm-Gg: AeBDieu0LT3TDHgzTqyclxMp2zbDNyuub35yPKSPkoRHvge9gpZqs3bQI8HP8BJESc9
	RBhB6VykbT46D2pyIcGpQl2QPEgPsk3JhsELalSUo1v9oXapUFTm7fNnaYdlgmGp6YAQB+B3vzH
	YH09Ct/AjITVom7rVf9m2lndKO7VQ+RrEK7FVnHSAJlcS2uTKwGgSuBByxssaBQa4YaMhyC7XzD
	fl7/3T9XV+In9e1PZrf7lEjUcS4uRqgXMOfF+QLk7FppTNawZpv6H3N22n1nCU3q+S9yx017aFA
	mgUicMEB1bqcI5+dnJIt3kSoA1ISrXXxX8RaLivojktJj6UjrNPYx33qnOlg/esByiU55yQeIFR
	SmwmR6I1EFoO95Bgn/fYHGdlyq10fh/AHwK27feOS4w95x4i7+hW460Vmy6Ss6nK1rhLRo3lIUe
	okVL6VsGXKHusUknH3VsIRuHfkNr/PbNSlT6+gX0RgzoDEMvN4iQpsyJJM9q2zLz/j6gnLIgMKy
	sex8fghdLSDjoKF5ynalV3N
X-Received: by 2002:a05:600c:820c:b0:488:c683:be89 with SMTP id 5b1f17b1804b1-48a77adc749mr39388945e9.9.1777368932177;
        Tue, 28 Apr 2026 02:35:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773af544sm45864805e9.6.2026.04.28.02.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:35:31 -0700 (PDT)
Message-ID: <88a89e06-5223-4a6f-8f9e-66e72b632ee2@gmail.com>
Date: Tue, 28 Apr 2026 10:35:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v15 5/5] checkout -m: autostash when switching branches
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
 <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
 <96b14db827e51966aceb6513f7d16ed526274ec2.1777065012.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <96b14db827e51966aceb6513f7d16ed526274ec2.1777065012.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 24/04/2026 22:10, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> When switching branches with "git checkout -m", the attempted merge
> of local modifications may cause conflicts with the changes made on
> the other branch, which the user may not want to (or may not be able
> to) resolve right now.  Because there is no easy way to recover from
> this situation, we discouraged users from using "checkout -m" unless
> they are certain their changes are trivial and within their ability
> to resolve conflicts.
> 
> Teach the -m flow to create a temporary stash before switching and
> reapply it after.  On success, the stash is silently applied and
> the list of locally modified paths is shown, same as a successful
> "git checkout" without "-m".
> 
> If reapplying causes conflicts, the stash is kept and the user is
> told they can resolve and run "git stash drop", or run "git reset
> --hard" and later "git stash pop" to recover their changes.

This is looking good, there are just a few small issues. Hopefully the 
next iteration will be the last.

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   Documentation/git-checkout.adoc |  58 ++++++------
>   Documentation/git-switch.adoc   |  33 +++----
>   builtin/checkout.c              | 160 ++++++++++++++------------------
>   sequencer.c                     |  14 ++-
>   t/t3420-rebase-autostash.sh     |  16 ++--
>   t/t7201-co.sh                   |  61 +++++++++++-
>   t/t7600-merge.sh                |   3 +-
>   xdiff-interface.c               |  12 +++
>   xdiff-interface.h               |   1 +
>   9 files changed, 211 insertions(+), 147 deletions(-)
> 
> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
> index 43ccf47cf6..70dd211ee3 100644
> --- a/Documentation/git-checkout.adoc
> +++ b/Documentation/git-checkout.adoc
> @@ -251,20 +251,19 @@ working tree, by copying them from elsewhere, extracting a tarball, etc.
>   	are different between the current branch and the branch to
>   	which you are switching, the command refuses to switch
>   	branches in order to preserve your modifications in context.
> -	However, with this option, a three-way merge between the current
> -	branch, your working tree contents, and the new branch
> -	is done, and you will be on the new branch.
> -+
> -When a merge conflict happens, the index entries for conflicting
> -paths are left unmerged, and you need to resolve the conflicts
> -and mark the resolved paths with `git add` (or `git rm` if the merge
> -should result in deletion of the path).
> +	With this option, the conflicting local changes are
> +	automatically stashed before the switch and reapplied
> +	afterwards.  If the local changes do not overlap with the
> +	differences between branches, the switch proceeds without
> +	stashing.  If reapplying the stash results in conflicts, the
> +	entry is saved to the stash list.  Resolve the conflicts
> +	and run `git stash drop` when done, or clear the working
> +	tree (e.g. with `git reset --hard`) before running `git stash
> +	pop` later to re-apply your changes.
>   +
>   When checking out paths from the index, this option lets you recreate
>   the conflicted merge in the specified paths.  This option cannot be
>   used when checking out paths from a tree-ish.
> -+
> -When switching branches with `--merge`, staged changes may be lost.
>   
>   `--conflict=<style>`::
>   	The same as `--merge` option above, but changes the way the
> @@ -578,39 +577,44 @@ $ git checkout mytopic
>   error: You have local changes to 'frotz'; not switching branches.
>   ------------
>   
> -You can give the `-m` flag to the command, which would try a
> -three-way merge:
> +You can give the `-m` flag to the command, which would carry your local

s/would/will/ or s/would carry/carries/

> +changes to the new branch:
>   
>   ------------
>   $ git checkout -m mytopic
> -Auto-merging frotz
> +Switched to branch 'mytopic'
>   ------------
>   
> -After this three-way merge, the local modifications are _not_
> +After the switch, the local modifications are reapplied and are _not_
>   registered in your index file, 

We don't test this but we do test that "git stash apply" does not update 
the index so we should be fine.

> so `git diff` would show you what
>   changes you made since the tip of the new branch.
>   
>   === 3. Merge conflict
>   
> -When a merge conflict happens during switching branches with
> -the `-m` option, you would see something like this:
> +When the `--merge` (`-m`) option is in effect and the locally
> +modified files overlap with files  that need to be updated by the
> +branch switch,

It is the changes in the files overlapping that causes the merge 
conflict, not the files overlapping

	When the `--merge` (`-m`) option is given and the local changes
	overlap with the changes in the branch we're switching to,

> the changes are stashed and reapplied after the
> +switch.  If this process results in conflicts, a stash entry is saved

s/a/the/

> +and made available in `git stash list`:

I'd drop this line and say instead "a message is printed"

>   ------------
>   $ git checkout -m mytopic
> -Auto-merging frotz
> -ERROR: Merge conflict in frotz
> -fatal: merge program failed
> -------------
> +Your local changes are stashed, however, applying it to carry
> +forward your local changes resulted in conflicts:
>   
> -At this point, `git diff` shows the changes cleanly merged as in
> -the previous example, as well as the changes in the conflicted
> -files.  Edit and resolve the conflict and mark it resolved with
> -`git add` as usual:
> + - You can try resolving them now.  If you resolved them
> +   successfully, discard the stash entry with "git stash drop".
>   
> + - Alternatively you can "git reset --hard" if you do not want
> +   to deal with them right now, and later "git stash pop" to
> +   recover your local changes.

This needs updating to match the new conflict advice.

>   ------------
> -$ edit frotz
> -$ git add frotz
> -------------
> +
> +You can try resolving the conflicts now.  Edit the conflicting files
> +and mark them resolved with `git add` as usual, then run `git stash
> +drop` to discard the stash entry.  Alternatively, you can clear the
> +working tree with `git reset --hard` and recover your local changes
> +later with `git stash pop`.

Is this documentation, or program output?

If you've not done so already it would be well worth checking the 
generated git-checkout.html and the man page

>   CONFIGURATION
>   -------------
> diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
> index 87707e9265..ee58a4d0fd 100644
> --- a/Documentation/git-switch.adoc
> +++ b/Documentation/git-switch.adoc
> @@ -123,18 +123,19 @@ variable.
>   
>   `-m`::
>   `--merge`::
> -	If you have local modifications to one or more files that are
> -	different between the current branch and the branch to which
> -	you are switching, the command refuses to switch branches in
> -	order to preserve your modifications in context.  However,
> -	with this option, a three-way merge between the current
> -	branch, your working tree contents, and the new branch is
> -	done, and you will be on the new branch.
> -+
> -When a merge conflict happens, the index entries for conflicting
> -paths are left unmerged, and you need to resolve the conflicts
> -and mark the resolved paths with `git add` (or `git rm` if the merge
> -should result in deletion of the path).
> +	If you have local modifications to one or more files that
> +	are different between the current branch and the branch to
> +	which you are switching, the command normally refuses to
> +	switch branches in order to preserve your modifications in
> +	context.  However, with this option, the conflicting local
> +	changes are automatically stashed before the switch and
> +	reapplied afterwards.  If the local changes do not overlap
> +	with the differences between branches, the switch proceeds
> +	without stashing.  If reapplying the stash results in
> +	conflicts, the entry is saved to the stash list.  Resolve
> +	the conflicts and run `git stash drop` when done, or clear
> +	the working tree (e.g. with `git reset --hard`) before
> +	running `git stash pop` later to re-apply your changes.
>   
>   `--conflict=<style>`::
>   	The same as `--merge` option above, but changes the way the
> @@ -217,15 +218,15 @@ $ git switch mytopic
>   error: You have local changes to 'frotz'; not switching branches.
>   ------------
>   
> -You can give the `-m` flag to the command, which would try a three-way
> -merge:
> +You can give the `-m` flag to the command, which would carry your local
> +changes to the new branch:

Same comment as for git-checkout.adoc

>   ------------
>   $ git switch -m mytopic
> -Auto-merging frotz
> +Switched to branch 'mytopic'

Don't we show the modified files as well now?
>   ------------
>   
> -After this three-way merge, the local modifications are _not_
> +After the switch, the local modifications are reapplied and are _not_
>   registered in your index file, so `git diff` would show you what
>   changes you made since the tip of the new branch.
>   
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> @@ -755,7 +757,7 @@ static void setup_branch_path(struct branch_info *branch)
>   
>   static void init_topts(struct unpack_trees_options *topts, int merge,
>   		       int show_progress, int overwrite_ignore,
> -		       struct commit *old_commit)
> +		       struct commit *old_commit, bool show_unpack_errors)

As this function only sets up the flags for unpack_trees() I think we 
could call this "quiet" or "show_errors"

>   {
>   	memset(topts, 0, sizeof(*topts));
>   	topts->head_idx = -1;
> @@ -767,7 +769,7 @@ static void init_topts(struct unpack_trees_options *topts, int merge,
>   	topts->initial_checkout = is_index_unborn(the_repository->index);
>   	topts->update = 1;
>   	topts->merge = 1;
> -	topts->quiet = merge && old_commit;
> +	topts->quiet = merge && old_commit && !show_unpack_errors;

We've added a function parameter for this option but then we ignore it 
unless "merge" and "old_commit" are true which is confusing. The reason 
we used to check those was to set "quiet" automatically but we can't do 
that now, so why not just use the value the call requested?

>   	topts->verbose_update = show_progress;
>   	topts->fn = twoway_merge;
>   	topts->preserve_ignored = !overwrite_ignore;
> @@ -776,7 +778,8 @@ static void init_topts(struct unpack_trees_options *topts, int merge,
>   static int merge_working_tree(const struct checkout_opts *opts,
>   			      struct branch_info *old_branch_info,
>   			      struct branch_info *new_branch_info,
> -			      int *writeout_error)
> +			      int *writeout_error,

This is an "out" parameter, so it would make sense to keep it at the end 
of the parameter list.

> +			      bool show_unpack_errors)
>   {
> @@ -853,90 +857,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   		ret = unpack_trees(2, trees, &topts);
>   		clear_unpack_trees_porcelain(&topts);
>   		if (ret == -1) {
> [...]
> +			rollback_lock_file(&lock_file);
> +			return MERGE_WORKING_TREE_UNPACK_FAILED;

We now use a unique return value when unpack_trees() fails - good.

>   		}
>   	}
>   
> @@ -1181,6 +1103,10 @@ static int switch_branches(const struct checkout_opts *opts,
>   	struct object_id rev;
>   	int flag, writeout_error = 0;
>   	int do_merge = 1;
> +	int created_autostash = 0;
> +	struct strbuf old_commit_shortname = STRBUF_INIT;
> +	struct strbuf autostash_msg = STRBUF_INIT;
> +	const char *stash_label_base = NULL;
>   
>   	trace2_cmd_mode("branch");
>   
> @@ -1218,11 +1144,49 @@ static int switch_branches(const struct checkout_opts *opts,
> [...]
>   	if (do_merge) {
> -		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
> +		ret = merge_working_tree(opts, &old_branch_info, new_branch_info,
> +					 &writeout_error, false);
> +		if (ret == MERGE_WORKING_TREE_UNPACK_FAILED && opts->merge) {
> +			strbuf_addf(&autostash_msg,
> +				    "autostash while switching to '%s'",

In an ideal world we'd create a message that said

	On <new branch>: autostash while switching from '<old branch>'

However I as discussed on patch 3, that would require us to be able to 
override the branch name when creating a stash as that's where the "On 
<branch>: " prefix gets added.

> +				    new_branch_info->name);
> +			create_autostash_ref(the_repository,
> +					     "CHECKOUT_AUTOSTASH_HEAD",
> +					     autostash_msg.buf, true);
> +			created_autostash = 1;
> +			ret = merge_working_tree(opts, &old_branch_info, new_branch_info,
> +						 &writeout_error, true);
> +		}
> +		if (created_autostash) {
> +			if (opts->conflict_style >= 0) {
> +				struct strbuf cfg = STRBUF_INIT;
> +				strbuf_addf(&cfg, "merge.conflictStyle=%s",
> +					    conflict_style_name(opts->conflict_style));
> +				git_config_push_parameter(cfg.buf);
> +				strbuf_release(&cfg);
> +			}
> +			apply_autostash_ref(the_repository,
> +					    "CHECKOUT_AUTOSTASH_HEAD",
> +					    new_branch_info->name,
> +					    "local",
> +					    stash_label_base,
> +					    autostash_msg.buf);
> +		}

We now have a single place where we restore the stashed changes - good

> diff --git a/sequencer.c b/sequencer.c
> index 7c0376d9e4..746f85a442 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4765,15 +4765,19 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
>   		strvec_push(&store.args, stash_oid);
>   		if (run_command(&store))
>   			ret = error(_("cannot store %s"), stash_oid);
> +		else if (attempt_apply)
> +			fprintf(stderr,
> +				_("Your local changes are stashed, however applying them\n"
> +				  "resulted in conflicts.  You can either resolve the conflicts\n"
> +				  "and then discard the stash with \"git stash drop\", or, if you\n"
> +				  "do not want to resolve them now, run \"git reset --hard\" and\n"
> +				  "apply the local changes later by running \"git stash pop\".\n"));
>   		else
>   			fprintf(stderr,
> -				_("%s\n"
> +				_("Autostash exists; creating a new stash entry.\n"
>   				  "Your changes are safe in the stash.\n"
>   				  "You can run \"git stash pop\" or"
> -				  " \"git stash drop\" at any time.\n"),
> -				attempt_apply ?
> -				_("Applying autostash resulted in conflicts.") :
> -				_("Autostash exists; creating a new stash entry."));
> +				  " \"git stash drop\" at any time.\n"));
>   	}

This looks good now

> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 9bcf7c0b40..b3293ead8d 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -102,7 +102,7 @@ test_expect_success 'checkout -m with dirty tree' '
>   
>   	test "$(git symbolic-ref HEAD)" = "refs/heads/side" &&
>   
> -	printf "M\t%s\n" one >expect.messages &&
> +	printf "The following paths have local changes:\nM\t%s\n" one >expect.messages &&

To create a multi-line file it is clearer to use

	cat >expect.messages <<-\EOF &&
	The following paths have local changes:
	M	one
	EOF

>   	test_cmp expect.messages messages &&
>   
>   	fill "M	one" "A	three" "D	two" >expect.main &&
> @@ -210,6 +210,65 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
>   	test_cmp expect two
>   '
>   
> +test_expect_success 'checkout -m with mixed staged and unstaged changes' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 0 x y z >same &&
> +	git add same &&
> +	fill 1 2 3 4 5 6 7 >one &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep "Applied autostash" actual &&
> +	fill 0 x y z >expect &&
> +	test_cmp expect same &&
> +	fill 1 2 3 4 5 6 7 >expect &&
> +	test_cmp expect one
> +'
> +
> +test_expect_success 'checkout -m creates a recoverable stash on conflict' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 1 2 3 4 5 >one &&
> +	test_must_fail git checkout side 2>stderr &&
> +	test_grep "Your local changes" stderr &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep "resulted in conflicts" actual &&
> +	test_grep "git stash drop" actual &&
> +	test_grep "git stash pop" actual &&
> +	test_grep "The following paths have local changes" actual &&
> +	git show --format=%B --diff-merges=1 refs/stash >actual &&

I've realized since I suggested this that we should be checking the 
reflog message as well since that's what's shown by "git stash list" so
we need to run

   git log -p -1 --format="%gs%n%B" -g --diff-merges=1 refs/stash >actual

> +	sed /^index/d actual >actual.trimmed &&
> +	cat >expect <<-EOF &&

and add

   autostash while switching to ${SQ}side${SQ}

> +	On main: autostash while switching to ${SQ}side${SQ}
> +
> +	diff --git a/one b/one
> +	--- a/one
> +	+++ b/one
> +	@@ -3,6 +3,3 @@
> +	 3
> +	 4
> +	 5
> +	-6
> +	-7
> +	-8
> +	EOF
> +	test_cmp expect actual.trimmed &&
> +	git stash drop &&
> +	git reset --hard
> +'
> +
> +test_expect_success 'checkout -m which would overwrite untracked file' '
> +	git checkout -f --detach main &&
> +	test_commit another-file &&
> +	git checkout HEAD^ &&
> +	>another-file.t &&
> +	fill 1 2 3 4 5 >one &&
> +	test_must_fail git checkout -m @{-1} 2>err &&
> +	test_grep "would be overwritten by checkout" err &&
> +	test_grep "another-file.t" err

Why the two calls to test_grep, rather than one? Anyway I've realized 
since I suggested this test that we also need to check the message only 
appears once to prevent a regression where merge_working_tree() calls 
unpack_trees() without setting "quiet" the first time it is called. We 
can do that by writing an expect file and calling test_cmp(), or by 
using "test_line_count = 1 err"

Hopefully the next re-roll with be the final one

Thanks

Phillip

> +'
> +
>   test_expect_success 'switch to another branch while carrying a deletion' '
>   	git checkout -f main &&
>   	git reset --hard &&
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 9838094b66..f877d9a433 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -914,7 +914,8 @@ test_expect_success 'merge with conflicted --autostash changes' '
>   	git diff >expect &&
>   	test_when_finished "test_might_fail git stash drop" &&
>   	git merge --autostash c3 2>err &&
> -	test_grep "Applying autostash resulted in conflicts." err &&
> +	test_grep "applying them" err &&
> +	test_grep "resulted in conflicts" err &&
>   	git show HEAD:file >merge-result &&
>   	test_cmp result.1-9 merge-result &&
>   	git stash show -p >actual &&
> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index f043330f2a..5ee2b96d0a 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -325,6 +325,18 @@ int parse_conflict_style_name(const char *value)
>   		return -1;
>   }
>   
> +const char *conflict_style_name(int style)
> +{
> +	switch (style) {
> +	case XDL_MERGE_DIFF3:
> +		return "diff3";
> +	case XDL_MERGE_ZEALOUS_DIFF3:
> +		return "zdiff3";
> +	default:
> +		return "merge";
> +	}
> +}
> +
>   int git_xmerge_style = -1;
>   
>   int git_xmerge_config(const char *var, const char *value,
> diff --git a/xdiff-interface.h b/xdiff-interface.h
> index fbc4ceec40..ce54e1c0e0 100644
> --- a/xdiff-interface.h
> +++ b/xdiff-interface.h
> @@ -55,6 +55,7 @@ void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
>   void xdiff_clear_find_func(xdemitconf_t *xecfg);
>   struct config_context;
>   int parse_conflict_style_name(const char *value);
> +const char *conflict_style_name(int style);
>   int git_xmerge_config(const char *var, const char *value,
>   		      const struct config_context *ctx, void *cb);
>   extern int git_xmerge_style;

