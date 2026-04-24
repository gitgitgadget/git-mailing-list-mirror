Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8233E1CEB
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045662; cv=none; b=KZLEWMoNKnWflWDVEexEspDuJ7CQ9xj6tIot03Adlw3MHbHuVdRXvxAp1LZwA9kwE7/m44fsboQxjBVTRQFT5mt2gIocj/QSywrxWYLfm2ya1tm+0kNnoSkbjFOY/0WZywnUWdPox8mEct1GWKBkYvfp0obwuF/7cFYYmxBqIuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045662; c=relaxed/simple;
	bh=3QpvzYvTINxRLmx7DcmI4d/5pb25v6ULuAVl+1cg3PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/BaKt0U3lAXKG9KlUYpWyT8tzBHM2XHelPR6vKIVn/PGtnwEfQCz3CYybcTNUZ43Qn281ZhESSvYLy2N2Srau0q1EtcGZkaacYsmTrJbe3cp/lvHURjthcNyKEVmi1uZFf2mZQ2BjC1WfqCpdANaa5WT/+wN8pxXRpAYducvTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBPfO3Vf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBPfO3Vf"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48374014a77so104281025e9.3
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777045658; x=1777650458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoiaZrUlPVz3n/0NnHAihLhRRM1kvZGCjc7e3CZEPBo=;
        b=kBPfO3VfgmYuMIFTAYgQOTZ2J0PG0WgLKSwP9TUwbkdlzxRZNcrqfNFijcIFEYH3UA
         U8f5I0mL3OqTx0rkjguMV7woYLP0gracjcJbnsJRaarUQLGgKAwpoy3GqGoEZzti83i3
         beyl0nxMtpFGERCjROnC1Na9ErSm7GxzcVQ/QU5P+AAdFwtt+A2S+/bKhJzv3unBREMR
         MvJblaLbYgXa1DU1AtMZ8aO8QNgei1N92V9bttXAv71fp2pMOS3Q6qTQG5ShrHpX4IkP
         f0J0lj+CWQsZj90eF20FWnViqsPZQvZkBXtjHujGm8m4slBv3dl6VqOiTvQTE/eACfpg
         4NWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777045658; x=1777650458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoiaZrUlPVz3n/0NnHAihLhRRM1kvZGCjc7e3CZEPBo=;
        b=W+y/M07eudhMZMaa7NKaWUaDb9FpQIUX0iLQ3CyWPULCOUtphDxxlB2fuaasskkKGr
         claXc52Os+I5gRQkpxK4m0CGD8OyxSdhKiWcASb3i6FmZcMiGbWD4Fnb9Yt4EdGXSQKT
         +3dWOzpWIdJxqtGfrE1SumRaFvtE/8vGROIdp0PHlNY7O8X+6HFEMPrObdFt6hZivWLb
         jB8xiA6H7/sXFAGybF1AcEnInZ+WIz4oXgjjsQlvhEcl6YyhMfk+eh13jrxq3wOmFYrc
         Cu+G20aDYQWjHSHt7RHkVODWN/gqk6NLcHyOchewKdW65Fls6ILkvtegWwVXC6lIRgK8
         4VEg==
X-Forwarded-Encrypted: i=1; AFNElJ9kyQIMiDLN5uxZOkCoVgZM59q5UkDae/9ulf+J1hMqtApUjirUz0bBDGxApVEPBiH0tvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsd9aEx3cbZVV731I6Ol6/u8IScjh9teQQAjjqq7nBfi1IxdQ8
	GiV/nN/bvzmvZTOod9GkhapID7md9E9pzqpD3BspwftSwQMvcOtMdOWL2ht5Jw==
X-Gm-Gg: AeBDietB8BMPQarg7Gf+YKP/6vuSGuOZ9FYXXiIxrmluDwyRGka2QfvklpqFVEts2Ie
	qQLYqdLRXIll4eC26K6eP4TVmt2h0NmWxJXWe830bNWabbyA0Clj5CXAj2Rp5by+XvWfQy0N1p9
	IkqXU6izCvDTZP0mvI2ckaTDgZPkl7PR7jS0zryb0Q0HsOe7hIZjEyEYLzP2fiC0f1dsV3lR5/U
	f7Gakdqw0PwSH4AV0jfuiGEZ5tr/d7ex3zJoiLUs/QhhSOUBM681CcKThZ87X4TsCHpI5hm3bd9
	I1uVpbWrge8v1lAV6SZVykncj00RV38JL6lKIM73m5WU4u9Hdxrq5kEiq6M6ddf85Mzya4ruMZ0
	Uow1LzvCG8huzecjWNlB62+AS3hpoa2D5QUc4ITDrqHPNMVDX28QczhjOrFqqLMz5YgTMI/GxCM
	ljuJHZxkkuDQbmcXqmDlQbXeQfpxRbpA5UN1GUbk2WdPtSWuweQjXFTqopZg3nyk/zQITtM8B2v
	wUF0JY/EnJKi1XfIqUPjZNh
X-Received: by 2002:a05:600c:1da1:b0:488:bc6a:528d with SMTP id 5b1f17b1804b1-488fb785204mr516475285e9.22.1777045657536;
        Fri, 24 Apr 2026 08:47:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0b4c85sm569067795e9.0.2026.04.24.08.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 08:47:37 -0700 (PDT)
Message-ID: <65f77343-2ee6-4ed6-adb2-271814148310@gmail.com>
Date: Fri, 24 Apr 2026 16:47:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v14 5/5] checkout -m: autostash when switching branches
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
 <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
 <86f33df1eb043d92cc626092d512aec670c89bdb.1776270259.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <86f33df1eb043d92cc626092d512aec670c89bdb.1776270259.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 15/04/2026 17:24, Harald Nordgren via GitGitGadget wrote:
(trimming the documentation - I'll try and look at that next time)

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index c80c62b37b..55c4db04c6 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -17,7 +17,6 @@
>   #include "merge-ll.h"
>   #include "lockfile.h"
>   #include "mem-pool.h"
> -#include "merge-ort-wrappers.h"
>   #include "object-file.h"
>   #include "object-name.h"
>   #include "odb.h"
> @@ -30,6 +29,7 @@
>   #include "repo-settings.h"
>   #include "resolve-undo.h"
>   #include "revision.h"
> +#include "sequencer.h"
>   #include "setup.h"
>   #include "submodule.h"
>   #include "symlinks.h"
> @@ -853,90 +853,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   		ret = unpack_trees(2, trees, &topts);
>   		clear_unpack_trees_porcelain(&topts);
>   		if (ret == -1) {
> -			/*
> -			 * Unpack couldn't do a trivial merge; either
> -			 * give up or do a real merge, depending on
> -			 * whether the merge flag was used.
> -			 */
> -			struct tree *work;
> -			struct tree *old_tree;
> -			struct merge_options o;
> -			struct strbuf sb = STRBUF_INIT;
> -			struct strbuf old_commit_shortname = STRBUF_INIT;
> -
> -			if (!opts->merge) {
> -				rollback_lock_file(&lock_file);
> -				return 1;
> -			}
> -
> -			/*
> -			 * Without old_branch_info->commit, the below is the same as
> -			 * the two-tree unpack we already tried and failed.
> -			 */
> -			if (!old_branch_info->commit) {
> -				rollback_lock_file(&lock_file);
> -				return 1;
> -			}
> -			old_tree = repo_get_commit_tree(the_repository,
> -							old_branch_info->commit);
> -
> -			if (repo_index_has_changes(the_repository, old_tree, &sb))
> -				die(_("cannot continue with staged changes in "
> -				      "the following files:\n%s"), sb.buf);
> -			strbuf_release(&sb);
> -
> -			/* Do more real merge */
> -
> -			/*
> -			 * We update the index fully, then write the
> -			 * tree from the index, then merge the new
> -			 * branch with the current tree, with the old
> -			 * branch as the base. Then we reset the index
> -			 * (but not the working tree) to the new
> -			 * branch, leaving the working tree as the
> -			 * merged version, but skipping unmerged
> -			 * entries in the index.
> -			 */
> -
> -			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
> -					0, 0);
> -			init_ui_merge_options(&o, the_repository);
> -			o.verbosity = 0;
> -			work = write_in_core_index_as_tree(the_repository,
> -							   the_repository->index);
> -
> -			ret = reset_tree(new_tree,
> -					 opts, 1,
> -					 writeout_error, new_branch_info);
> -			if (ret) {
> -				rollback_lock_file(&lock_file);
> -				return ret;
> -			}
> -			o.ancestor = old_branch_info->name;
> -			if (!old_branch_info->name) {
> -				strbuf_add_unique_abbrev(&old_commit_shortname,
> -							 &old_branch_info->commit->object.oid,
> -							 DEFAULT_ABBREV);
> -				o.ancestor = old_commit_shortname.buf;
> -			}
> -			o.branch1 = new_branch_info->name;
> -			o.branch2 = "local";
> -			o.conflict_style = opts->conflict_style;
> -			ret = merge_ort_nonrecursive(&o,
> -						     new_tree,
> -						     work,
> -						     old_tree);
> -			if (ret < 0)
> -				die(NULL);
> -			ret = reset_tree(new_tree,
> -					 opts, 0,
> -					 writeout_error, new_branch_info);
> -			strbuf_release(&o.obuf);
> -			strbuf_release(&old_commit_shortname);
> -			if (ret) {
> -				rollback_lock_file(&lock_file);
> -				return ret;
> -			}
> +			rollback_lock_file(&lock_file);
> +			return ret;

ret is -1 so we return the same value if unpack_trees() fails as do the 
checks at the top of the function do when they fail with "return 
error(...)". Therefore we cannot determine whether a failure of this 
function is due to unpack_trees() or not and so we wont know whether to 
autostash or not. You need to return a unique value here like -2 (or 
ideally a named constant)

>   		}
>   	}
>   
> @@ -1181,6 +1099,10 @@ static int switch_branches(const struct checkout_opts *opts,
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
> @@ -1218,11 +1140,39 @@ static int switch_branches(const struct checkout_opts *opts,
>   			do_merge = 0;
>   	}
>   
> +	if (old_branch_info.name)
> +		stash_label_base = old_branch_info.name;
> +	else if (old_branch_info.commit) {

Style: if one branch of an if statement has braces then all branch should.

> +		strbuf_add_unique_abbrev(&old_commit_shortname,
> +					 &old_branch_info.commit->object.oid,
> +					 DEFAULT_ABBREV);
> +		stash_label_base = old_commit_shortname.buf;
> +	}
> +
>   	if (do_merge) {
>   		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
> +		if (ret == -1 && opts->merge) {
> +			strbuf_addf(&autostash_msg,
> +				    "autostash while switching to '%s'",
> +				    new_branch_info->name);
> +			create_autostash_ref(the_repository,
> +					     "CHECKOUT_AUTOSTASH_HEAD",
> +					     autostash_msg.buf, true);
> +			created_autostash = 1;
> +			ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
> +		}
>   		if (ret) {
> +			if (created_autostash)
> +				apply_autostash_ref(the_repository,
> +						    "CHECKOUT_AUTOSTASH_HEAD",
> +						    new_branch_info->name,
> +						    "local",
> +						    stash_label_base,
> +						    autostash_msg.buf);

Good - now we only try to restore the stashed changes if we actually 
stashed. However we only restore the stashed changes if there was an 
error(). If there isn't an error we call update_refs_for_switch() before 
restoring them. It would be safer to restore them straight away in case 
that function ends up dying for any reason (though I think that's pretty 
unlikely)

	if (created_autostash) {
		if (opts->conflict_style >= 0)
			/* set up confilct style */
		apply_autostash_ref(...);
	}
	if (ret) {

>   			branch_info_release(&old_branch_info);
> -			return ret;
> +			strbuf_release(&old_commit_shortname);
> +			strbuf_release(&autostash_msg);
> +			return ret < 0 ? 1 : ret;

This changes the return value for all errors from merge_working_tree() - 
that's probably a good this as this value is used for the exit code and 
we don't really want an exit code of -1

>   		}
>   	}
>   
> @@ -1231,8 +1181,30 @@ static int switch_branches(const struct checkout_opts *opts,
>   
>   	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
>   
> +	if (opts->conflict_style >= 0) {
> +		struct strbuf cfg = STRBUF_INIT;
> +		strbuf_addf(&cfg, "merge.conflictStyle=%s",
> +			    conflict_style_name(opts->conflict_style));
> +		git_config_push_parameter(cfg.buf);
> +		strbuf_release(&cfg);
> +	}
> +	apply_autostash_ref(the_repository, "CHECKOUT_AUTOSTASH_HEAD",
> +			    new_branch_info->name, "local",
> +			    stash_label_base,
> +			    autostash_msg.buf);> +	discard_index(the_repository->index);

As I said last time we should not be calling apply_autostash() if we 
have not created an autostash. We should also not discard and re-read 
the index if we haven't stashed. I do think we'd be better restoring the 
stashed changes in a single place as I said above.

> +	if (repo_read_index(the_repository) < 0)
> +		die(_("index file corrupt"));
> +
> +	if (created_autostash && !opts->quiet && new_branch_info->commit)
> +		show_local_changes(&new_branch_info->commit->object,
> +				   &opts->diff_options);

This shows the local changes, but it doesn't give any explanation of 
what the output is. For example when switching branches with a conflict 
I see

Your local changes are stashed, however, applying it to carry
forward your local changes resulted in conflicts:

  - You can try resolving them now.  If you resolved them
    successfully, discard the stash entry with "git stash drop".

  - Alternatively you can "git reset --hard" if you do not want
    to deal with them right now, and later "git stash pop" to
    recover your local changes.
M	t/t7201-co.sh

where the changes appear to be part of the advice message. Perhaps we 
should print a short (i.e. one sentance) message along the lines of

	The following paths have local changes

We should test what the user sees here as well.

> +
>   	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
>   	branch_info_release(&old_branch_info);
> +	strbuf_release(&old_commit_shortname);
> +	strbuf_release(&autostash_msg);
>   
>   	return ret || writeout_error;
>   }
> diff --git a/sequencer.c b/sequencer.c
> index 7c0376d9e4..480e8e6c0b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4765,15 +4765,23 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
>   		strvec_push(&store.args, stash_oid);
>   		if (run_command(&store))
>   			ret = error(_("cannot store %s"), stash_oid);
> +		else if (attempt_apply)
> +			fprintf(stderr,
> +				_("Your local changes are stashed, however, applying it to carry\n"
> +				  "forward your local changes resulted in conflicts:\n"

I'm not sure we need to say "local changes" twice here

	Your local changes are stashed, however applying them
	resulted in conflicts.

> +				  "\n"
> +				  " - You can try resolving them now.  If you resolved them\n"
> +				  "   successfully, discard the stash entry with \"git stash drop\".\n"

s/resolved/resolve/

> +				  "\n"
> +				  " - Alternatively you can \"git reset --hard\" if you do not want\n"
> +				  "   to deal with them right now, and later \"git stash pop\" to\n"
> +				  "   recover your local changes.\n"));

I find the bulleted list a bit odd, maybe

	You can either resolve the conflicts and then discard the stash
  	with "git stash drop", or, if you do not want to resolve them
	now, run "git reset --hard" and apply the local changes later by
	running "git stash pop"

would be better?

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
>   
>   	return ret;
> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> index ad3ba6a984..e4e2cb19ce 100755
> --- a/t/t3420-rebase-autostash.sh
> +++ b/t/t3420-rebase-autostash.sh
> @@ -61,18 +61,30 @@ create_expected_failure_apply () {
>   	First, rewinding head to replay your work on top of it...
>   	Applying: second commit
>   	Applying: third commit
> -	Applying autostash resulted in conflicts.
> -	Your changes are safe in the stash.
> -	You can run "git stash pop" or "git stash drop" at any time.
> +	Your local changes are stashed, however, applying it to carry
> +	forward your local changes resulted in conflicts:
> +
> +	 - You can try resolving them now.  If you resolved them
> +	   successfully, discard the stash entry with "git stash drop".
> +
> +	 - Alternatively you can "git reset --hard" if you do not want
> +	   to deal with them right now, and later "git stash pop" to
> +	   recover your local changes.
>   	EOF
>   }
>   
>   create_expected_failure_merge () {
>   	cat >expected <<-EOF
>   	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> -	Applying autostash resulted in conflicts.
> -	Your changes are safe in the stash.
> -	You can run "git stash pop" or "git stash drop" at any time.
> +	Your local changes are stashed, however, applying it to carry
> +	forward your local changes resulted in conflicts:
> +
> +	 - You can try resolving them now.  If you resolved them
> +	   successfully, discard the stash entry with "git stash drop".
> +
> +	 - Alternatively you can "git reset --hard" if you do not want
> +	   to deal with them right now, and later "git stash pop" to
> +	   recover your local changes.
>   	Successfully rebased and updated refs/heads/rebased-feature-branch.
>   	EOF
>   }
> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 9bcf7c0b40..c474c6759f 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -210,6 +210,214 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
>   	test_cmp expect two
>   '
>   
> +test_expect_success 'checkout --merge --conflict=zdiff3 <branch>' '
> +	git checkout -f main &&
> +	git reset --hard &&
> +	git clean -f &&
> +
> +	fill a b X d e >two &&
> +	git checkout --merge --conflict=zdiff3 simple &&

If I change "zdiff3" to "diff3" this test still passes which is 
disappointing. As the code that parses the conflict style is shared with 
other commands and we already have tests for --conflict=diff3 and 
--conflict=merge I'm not sure this test adds much.

> +
> +	cat <<-EOF >expect &&
> +	a
> +	<<<<<<< simple
> +	c
> +	||||||| main
> +	b
> +	c
> +	d
> +	=======
> +	b
> +	X
> +	d
> +	>>>>>>> local
> +	e
> +	EOF
> +	test_cmp expect two
> +'
> +
> +test_expect_success 'checkout -m respects merge.conflictStyle config' '

Looking at the existing tests, 'checkout with --merge, in diff3 -m 
style' and 'checkout --conflict=merge, overriding config' already test 
that we respect merge.conflictStyle and that --conflict overrides it so 
I don't see what new coverage this test adds.

> +	git checkout -f main &&
> +	git reset --hard &&
> +	git clean -f &&
> +
> +	test_config merge.conflictStyle diff3 &&
> +	fill b d >two &&
> +	git checkout -m simple &&
> +
> +	cat <<-EOF >expect &&
> +	<<<<<<< simple
> +	a
> +	c
> +	e
> +	||||||| main
> +	a
> +	b
> +	c
> +	d
> +	e
> +	=======
> +	b
> +	d
> +	>>>>>>> local
> +	EOF
> +	test_cmp expect two
> +'
> +
> +test_expect_success 'checkout -m skips stash when no conflict' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 0 x y z >same &&
> +	git stash list >stash-before &&
> +	git checkout -m side >actual 2>&1 &&

file "same" is unchanged between branch "side" and "branch" main so we 
do not need to stash it.

> +	test_grep ! "Created autostash" actual &&
> +	git stash list >stash-after &&
> +	test_cmp stash-before stash-after &&
> +	fill 0 x y z >expect &&
> +	test_cmp expect same

Even if we created an autostash this test would not pick it up as the 
stash is not written to refs/stash unless there are merge conflicts and 
we don't print "Created autostash" even when we do create an autostash. 
The same is true for "checkout -m -b skips stash with dirty tree" below. 
I don't see how we can check that a stash was not created without using 
GIT_TRACE to see if we run "git stash". Even that is fragile as we might 
start stashing without forking a separate process in future.

> +'
> +
> +test_expect_success 'checkout -m skips stash with non-conflicting dirty index' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 0 x y z >same &&
> +	git add same &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep ! "Created autostash" actual &&
> +	fill 0 x y z >expect &&
> +	test_cmp expect same
> +'
> +
> +test_expect_success 'checkout -m stashes and applies on conflicting changes' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 1 2 3 4 5 6 7 >one &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep ! "Created autostash" actual &&
> +	test_grep "Applied autostash" actual &&
> +	fill 1 2 3 4 5 6 7 >expect &&
> +	test_cmp expect one
> +'

I don't think the two tests above add any extra coverage when we have 
the one below so they can be deleted. Our test suite is slow enough 
already - we only need one test to fail for any given issue.

> +test_expect_success 'checkout -m with mixed staged and unstaged changes' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 0 x y z >same &&
> +	git add same &&
> +	fill 1 2 3 4 5 6 7 >one &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep ! "Created autostash" actual &&
> +	test_grep "Applied autostash" actual &&
> +	fill 0 x y z >expect &&
> +	test_cmp expect same &&
> +	fill 1 2 3 4 5 6 7 >expect &&
> +	test_cmp expect one
> +'
> +
> +test_expect_success 'checkout -m stashes on truly conflicting changes' '

This use of conflicting is rather confusing - what's the difference 
between a conflicting change and a truly conflicting change?

I think a single test is sufficient to check that we create a valid 
stash entry

test_expect_success 'checkout -m stashes on truly conflicting changes' '
	git checkout -f main &&
	git clean -f &&

	fill 1 2 3 4 5 >one &&
	test_must_fail git checkout side 2>stderr &&
	test_grep "Your local changes" stderr &&
	git checkout -m side >actual 2>&1 &&
	test_grep ! "Created autostash" actual &&
	test_grep "resulted in conflicts" actual &&
	test_grep "git stash drop" actual &&
	test_grep "recover your local changes" actual &&
	git show --format=%B --diff-merges=1 refs/stash >actual &&
	sed /^index/d actual >actual.trimmed &&
	cat >expect <<-EOF &&
	On main: autostash while switching to ${SQ}side${SQ}
	diff --git a/one b/one
	--- a/one
	+++ b/one
	@@ -3,6 +3,3 @@
	 3
	 4
	 5
	-6
	-7
	-8
	EOF
	test_cmp expect actual.trimmed &&
'

Then we can delete from here to ...

> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 1 2 3 4 5 >one &&
> +	test_must_fail git checkout side 2>stderr &&
> +	test_grep "Your local changes" stderr &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep ! "Created autostash" actual &&
> +	test_grep "resulted in conflicts" actual &&
> +	test_grep "git stash drop" actual &&
> +	git stash drop &&
> +	git reset --hard
> +'
> +
> +test_expect_success 'checkout -m produces usable stash on conflict' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 1 2 3 4 5 >one &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep "recover your local changes" actual &&
> +	git checkout -f main &&
> +	git stash pop &&
> +	fill 1 2 3 4 5 >expect &&
> +	test_cmp expect one
> +'
> +
> +test_expect_success 'checkout -m autostash message includes target branch' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 1 2 3 4 5 >one &&
> +	git checkout -m side >actual 2>&1 &&
> +	git stash list >stash-list &&
> +	test_grep "autostash while switching to .side." stash-list &&
> +	git stash drop &&
> +	git checkout -f main &&
> +	git reset --hard
> +'
> +
> +test_expect_success 'checkout -m stashes on staged conflicting changes' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 1 2 3 4 5 >one &&
> +	git add one &&
> +	git checkout -m side >actual 2>&1 &&
> +	test_grep ! "Created autostash" actual &&
> +	test_grep "resulted in conflicts" actual &&
> +	test_grep "git stash drop" actual &&
> +	git stash drop &&
> +	git reset --hard
> +'

... here


> +test_expect_success 'checkout -m applies stash cleanly with non-overlapping changes in same file' '

I've no idea what this is trying to do - it looks more like it is 
testing that "git stash" works rather than anything to do with "git 
checkout"

> +	git checkout -f main &&
> +	git reset --hard &&
> +	git clean -f &&
> +
> +	git checkout -b nonoverlap_base &&
> +	fill a b c d >file &&
> +	git add file &&
> +	git commit -m "add file" &&
> +
> +	git checkout -b nonoverlap_child &&
> +	fill a b c INSERTED d >file &&
> +	git commit -a -m "insert line near end of file" &&
> +
> +	fill DIRTY a b c INSERTED d >file &&
> +
> +	git stash list >stash-before &&
> +	git checkout -m nonoverlap_base 2>stderr &&
> +	test_grep "Applied autostash" stderr &&
> +	test_grep ! "resulted in conflicts" stderr &&
> +
> +	git stash list >stash-after &&
> +	test_cmp stash-before stash-after &&
> +
> +	fill DIRTY a b c d >expect &&
> +	test_cmp expect file &&
> +
> +	git checkout -f main &&
> +	git branch -D nonoverlap_base &&
> +	git branch -D nonoverlap_child
> +'
> +
> +test_expect_success 'checkout -m -b skips stash with dirty tree' '
> +	git checkout -f main &&
> +	git clean -f &&
> +
> +	fill 0 x y z >same &&
> +	git checkout -m -b newbranch >actual 2>&1 &&
> +	test_grep ! "Created autostash" actual &&
> +	fill 0 x y z >expect &&
> +	test_cmp expect same &&
> +	git checkout main &&
> +	git branch -D newbranch
> +'

As I said above I don't think this test is testing what it claims to.

I'd suggest adding the following test

test_expect_success 'checkout -m which would overwrite untracked file' '
	git checkout -f --detach main &&
	test_commit another-file &&
	git checkout HEAD^ &&
	>another-file.t &&
	test_must_fail git checkout -m @{-1} 2>err &&
	test_grep "another-file.t.*overwritten" err
'

which passes on master but fails with these patches applied. We need to 
make sure that we don't set "quiet" in unpack_tree_opts the second time 
we call merge_working_tree(). The test could be improved by adding some 
local changes.

This is looking better, but there are still a couple of problems that 
need addressing before it can be considered ready for merging.

Thanks

Phillip

>   test_expect_success 'switch to another branch while carrying a deletion' '
>   	git checkout -f main &&
>   	git reset --hard &&
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 9838094b66..cbef8a534e 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -914,7 +914,7 @@ test_expect_success 'merge with conflicted --autostash changes' '
>   	git diff >expect &&
>   	test_when_finished "test_might_fail git stash drop" &&
>   	git merge --autostash c3 2>err &&
> -	test_grep "Applying autostash resulted in conflicts." err &&
> +	test_grep "your local changes resulted in conflicts" err &&
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

