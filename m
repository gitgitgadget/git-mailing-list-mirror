Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE59037AA9C
	for <git@vger.kernel.org>; Mon, 18 May 2026 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118028; cv=none; b=fLrT1ROpjvb7cmZRFCobLyo+0irDm6+TpRCwVB7MvG8dV7gub3WvryGvHFXidNfsTOcXsnQSX5cfBp8VsDWlY5svcQTW52C+tnlEoZqHek95qgtwpUAsJqhy/AKf1Xh9kF3Z5e8jUvPLqJw/sR5tEhBON4i461hN7o4eZK/n4Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118028; c=relaxed/simple;
	bh=AioZHAfl0HWNEAW3v7ln0BtahKABXO6Osb3Ilhy4JRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLStYRH98wLNDGyYLaoP1vd44CkeIdxFZ0WG1ZXzVtR1CQRcph++aXiDREHB8oFdI0Cid2aenfxIvkXznilhwz8ywPZR0dbxgmNIfPvJLzbzzri/TRCDyG6wv4eaHPC62SiqWTqRqzGwAxDJWcMpySfVLoFCUwJCDw7VzyPVhEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qP4MKHQl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qP4MKHQl"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso14729375e9.1
        for <git@vger.kernel.org>; Mon, 18 May 2026 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779118023; x=1779722823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CQt5MuEvrJDJIfVa16Fe/8/aJRraQ5bE0vkyh8Jd668=;
        b=qP4MKHQl8JMw/fjFFvHLnVEM82pHZhXTUC4nAMXErRLoZmvOJx/9Vp+4tMCWB6lUdl
         oHuZrwJPqzomE7l0FfFtN/Ald2IeV7nxw8chPFMrEg3UcdBLW1oKRRJdVlDoAPiF//ot
         H4tWXwhgveR/eAinaTVZxfc0HkSaPJWnHeXQoO9mT7KWy3D9JJ8azDb1khKpivtBW2rz
         xHcWgLxODI45gMe82CIki/LPbtdh8hL44d/Lo9kDvGWkX9J2yf54DyV1YLIN8df0VhT0
         TI9+mBeG0iTfyrK6reldd8XEl+SeCTBDp2sIR7Cc/3F4TzzZGetXTlXy0exCln4M5R+t
         77tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779118023; x=1779722823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQt5MuEvrJDJIfVa16Fe/8/aJRraQ5bE0vkyh8Jd668=;
        b=TftLuwnu4wtrhl/AxCGrp6Gj4x4q5ayUJIjpk4fd9Ma09Z3h669ihhknSr6jcqMUfN
         2pHqWda7Rw0bODEGoG9ZeVqkbQ/mhPnraRBYHg4lY/nkFBQwTX/jwedz+yPfaI3BsnZb
         yjm0MZlDIY6XAXL9UDMb9mO6mEGhML1k2aJw+SKo6V62B6iCAfWFkuzmYJvD3iIgqxtI
         eqWGLf/fAgaelSn2koZnDDo1vXf3i8bBoYkNgTlGsRFOEc1KcZ07Svg2Ywxoh780EVgy
         y3aPEGSosezmKnIpe0EqdiGw/2sB0P8Trr2C89SgThW9vqzkWqND5fDEljvFu7uakYGR
         szEw==
X-Forwarded-Encrypted: i=1; AFNElJ+CErqojM7HzSlSMFNHu+Sp5YWTEZmW2bXrcVO5Z6nS7omVJnaRaf/pFih/ssjdc75Wa+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6J+1wyJyHbmN97QEmc+PaFJ+PtOYhOOEcDu2ICIBMCq3cEoNM
	1zHVVf9pYe89oTOsfaObFqol5nbmXVWn+VIIy4KnnxofhQEPB28/u5Q9ptCqbw==
X-Gm-Gg: Acq92OGvmC4mPZQ2ZyP/mcVHBzzlZX7UsjnTA6Efc/02PEWaWWOpldzdochVXfrV6gg
	NXX5W6G3Wen6dEWYBGAkG6uhwun1hAvPqCxHsQdfMCMJsnyddgxTyOQO4hQxvsH17PbFdjgbq7M
	qh5FgxUkoABl037q1M/NstsHablawEAwdMfRDbiAcm4JBFK15hgDo0vKIAnBikhb3WmGq5iWkU5
	b9Lq8/k5y7RaFLYcDPcNHo0Jkk8aqpxvZxUHHwtZzlaNWmBODUgHyIjlNTRdU/1zVAmIDDWPixM
	wBmRhMyFtUEBLcn2LwgDp3DLBpCGu97gge9nWisFKWj89nPaElyhU9h1yoiM9ck8LJaQf5IkkPq
	ATijXn0/y6PcN3KL+LkvfwnIVycyc3zFNnxuyc2QESGgDc7cSPVWZ1VLk7R9h53ABtmgl0XewcE
	khMNRlZNucSHPtMeWwnkppXfur4AZBUsd1BzDLrckToY+4o2NFSwnG/70yuARCmAXDFnQ5zE6zW
	Ulg/g==
X-Received: by 2002:a05:600c:5304:b0:490:17da:27f8 with SMTP id 5b1f17b1804b1-49017da2830mr25526405e9.18.1779118022652;
        Mon, 18 May 2026 08:27:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:662:5a01:509f:d84a:9a5e:1263? ([2a0a:ef40:662:5a01:509f:d84a:9a5e:1263])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe1a41sm41513860f8f.31.2026.05.18.08.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 08:27:02 -0700 (PDT)
Message-ID: <6501a3d5-a5ec-421b-8526-ee7d4ae5ea98@gmail.com>
Date: Mon, 18 May 2026 16:27:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v9 3/5] branch: add --prune-merged <remote>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
 <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
 <f87e96e99d64c48bd92afecf3a6a819d36e56f6c.1778700883.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <f87e96e99d64c48bd92afecf3a6a819d36e56f6c.1778700883.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 13/05/2026 20:34, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Delete the local branches that --forked <remote> would list, but
> only those whose tip is reachable from their configured upstream
> remote-tracking branch (branch.<name>.merge): the work has already
> landed on the upstream it tracks, so the local copy is no longer
> needed.

I think being able to prune branches that have been merged into their 
upstream is a good idea. However, I find the focus on remotes rather 
than upstream branches in the UI a bit confusing. While the upstream of 
a branch is often a remote tracking branch it doesn't have to be. For my 
personal projects I often do

	git checkout -b topic master

and it would be nice to be able to run

	git branch --prune-merged master

to clean up those topics that have been merged. Similarly I think it is 
confusing that

	git checkout -b topic origin

starts a branch from the default branch on origin, but if I run

	git branch --prune-merged origin

to clean it up, it will clean up all the branches with an upstream on 
origin, not just those whose upstream matches origin/HEAD.

So I like the idea, but would prefer the arguments to --prune-merged to 
be upstream branches, not remotes. We could support globs so that

	git branch --prune-merges 'origin/*'

would clean up all the branches whose upstream is on origin if that is 
useful.

Thanks

Phillip

> A branch whose upstream no longer resolves locally is left alone --
> its disappearance is not, on its own, evidence that the work was
> integrated. With --force, skip the reachability check and delete
> every branch in the candidate set. The currently checked-out
> branch in any worktree is always preserved, as is the local branch
> that mirrors <remote>'s default branch.
> 
> Reachability is read from whatever the remote-tracking refs say
> locally, so the natural workflow is
> 
> 	git fetch <remote>
> 	git branch --prune-merged <remote>
> 
> with no implicit cleanup driven by fetch itself.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   Documentation/git-branch.adoc |  19 +++++
>   builtin/branch.c              | 143 +++++++++++++++++++++++++++++-----
>   t/t3200-branch.sh             |  83 ++++++++++++++++++++
>   3 files changed, 226 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
> index 5773104cd3..375a0a68da 100644
> --- a/Documentation/git-branch.adoc
> +++ b/Documentation/git-branch.adoc
> @@ -25,6 +25,7 @@ git branch (-c|-C) [<old-branch>] <new-branch>
>   git branch (-d|-D) [-r] <branch-name>...
>   git branch --edit-description [<branch-name>]
>   git branch --forked <remote>...
> +git branch --prune-merged <remote>...
>   
>   DESCRIPTION
>   -----------
> @@ -211,6 +212,24 @@ Each _<remote>_ may be either the name of a configured remote
>   `refs/remotes/origin/*` ref) or a specific remote-tracking branch
>   (e.g. `origin/master`). Multiple _<remote>_ arguments are unioned.
>   
> +`--prune-merged`::
> +	Delete the local branches that `--forked` would list for
> +	the same _<remote>_ arguments, but only those whose tip is
> +	reachable from their configured upstream remote-tracking
> +	branch (`branch.<name>.merge`). In other words: the work on
> +	the branch has already landed on the upstream it tracks, so
> +	the local copy is no longer needed.
> ++
> +Run `git fetch` first so the upstream remote-tracking branches
> +reflect the current state of _<remote>_; reachability is checked
> +against whatever the remote-tracking refs say locally.
> ++
> +A branch whose upstream no longer resolves locally is left alone
> +(its disappearance is not, on its own, evidence that the work was
> +integrated). The currently checked-out branch in any worktree is
> +always preserved, as is the local branch that mirrors _<remote>_'s
> +default branch.
> +
>   `-v`::
>   `-vv`::
>   `--verbose`::
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 1941f8a9ad..6fe2ffd7e8 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -21,6 +21,7 @@
>   #include "branch.h"
>   #include "path.h"
>   #include "string-list.h"
> +#include "strvec.h"
>   #include "column.h"
>   #include "utf8.h"
>   #include "ref-filter.h"
> @@ -171,8 +172,8 @@ static int branch_merged(int kind, const char *name,
>   	 * any of the following code, but during the transition period,
>   	 * a gentle reminder is in order.
>   	 */
> -	if (head_rev != reference_rev) {
> -		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
> +	if (head_rev && head_rev != reference_rev) {
> +		int expect = repo_in_merge_bases(the_repository, rev, head_rev);
>   		if (expect < 0)
>   			exit(128);
>   		if (expect == merged)
> @@ -227,7 +228,9 @@ static void delete_branch_config(const char *branchname)
>   	strbuf_release(&buf);
>   }
>   
> -static int delete_branches(int argc, const char **argv, int force, int kinds,
> +static int delete_branches(int argc, const char **argv,
> +			   int no_head_fallback,
> +			   int force, int kinds,
>   			   int quiet, int warn_only, int *n_not_merged)
>   {
>   	struct commit *head_rev = NULL;
> @@ -262,7 +265,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>   	}
>   	branch_name_pos = strcspn(fmt, "%");
>   
> -	if (!force)
> +	if (!force && !no_head_fallback)
>   		head_rev = lookup_commit_reference(the_repository, &head_oid);
>   
>   	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
> @@ -317,8 +320,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>   		}
>   
>   		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
> -		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
> -					force, warn_only, n_not_merged)) {
> +		    check_branch_commit(bname.buf, name, &oid, head_rev,
> +					kinds, force, warn_only, n_not_merged)) {
>   			if (!warn_only)
>   				ret = 1;
>   			goto next;
> @@ -753,36 +756,131 @@ static int collect_forked_branch(const struct reference *ref, void *cb_data)
>   	return 0;
>   }
>   
> -static int list_forked_branches(int argc, const char **argv)
> +static void collect_default_branch_refs(const struct string_list *remote_names,
> +					struct string_list *out)
> +{
> +	struct ref_store *refs = get_main_ref_store(the_repository);
> +	struct string_list_item *item;
> +
> +	for_each_string_list_item(item, remote_names) {
> +		struct strbuf head = STRBUF_INIT;
> +		const char *target;
> +
> +		strbuf_addf(&head, "refs/remotes/%s/HEAD", item->string);
> +		target = refs_resolve_ref_unsafe(refs, head.buf,
> +						 RESOLVE_REF_NO_RECURSE,
> +						 NULL, NULL);
> +		if (target && starts_with(target, "refs/remotes/"))
> +			string_list_insert(out, target);
> +		strbuf_release(&head);
> +	}
> +}
> +
> +static void collect_forked_set(int argc, const char **argv,
> +			       struct string_list *protected_default_refs,
> +			       struct string_list *out)
>   {
>   	struct string_list remote_names = STRING_LIST_INIT_NODUP;
>   	struct string_list tracking_refs = STRING_LIST_INIT_DUP;
> -	struct string_list out = STRING_LIST_INIT_DUP;
> -	struct string_list_item *item;
>   	struct forked_cb cb = {
>   		.remote_names = &remote_names,
>   		.tracking_refs = &tracking_refs,
> -		.out = &out,
> +		.out = out,
>   	};
>   
> -	if (!argc)
> -		die(_("--forked requires at least one <remote>"));
> -
>   	parse_forked_args(argc, argv, &remote_names, &tracking_refs);
>   
>   	refs_for_each_branch_ref(get_main_ref_store(the_repository),
>   				 collect_forked_branch, &cb);
>   
> -	string_list_sort(&out);
> -	for_each_string_list_item(item, &out)
> -		puts(item->string);
> +	string_list_sort(out);
> +
> +	if (protected_default_refs)
> +		collect_default_branch_refs(&remote_names, protected_default_refs);
>   
>   	string_list_clear(&remote_names, 0);
>   	string_list_clear(&tracking_refs, 0);
> +}
> +
> +static int list_forked_branches(int argc, const char **argv)
> +{
> +	struct string_list out = STRING_LIST_INIT_DUP;
> +	struct string_list_item *item;
> +
> +	if (!argc)
> +		die(_("--forked requires at least one <remote>"));
> +
> +	collect_forked_set(argc, argv, NULL, &out);
> +	for_each_string_list_item(item, &out)
> +		puts(item->string);
> +
>   	string_list_clear(&out, 0);
>   	return 0;
>   }
>   
> +static int prune_merged_branches(int argc, const char **argv, int quiet)
> +{
> +	struct string_list candidates = STRING_LIST_INIT_DUP;
> +	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
> +	struct strvec deletable = STRVEC_INIT;
> +	struct string_list_item *item;
> +	int n_not_merged = 0;
> +	int ret = 0;
> +
> +	if (!argc)
> +		die(_("--prune-merged requires at least one <remote>"));
> +
> +	collect_forked_set(argc, argv, &protected_default_refs, &candidates);
> +
> +	for_each_string_list_item(item, &candidates) {
> +		const char *short_name = item->string;
> +		struct strbuf full = STRBUF_INIT;
> +		struct branch *branch;
> +		const char *upstream;
> +
> +		strbuf_addf(&full, "refs/heads/%s", short_name);
> +		if (branch_checked_out(full.buf)) {
> +			strbuf_release(&full);
> +			continue;
> +		}
> +		strbuf_release(&full);
> +
> +		branch = branch_get(short_name);
> +		upstream = branch ? branch_get_upstream(branch, NULL) : NULL;
> +		if (!upstream ||
> +		    !refs_ref_exists(get_main_ref_store(the_repository),
> +				     upstream))
> +			continue;
> +		if (string_list_has_string(&protected_default_refs, upstream)) {
> +			const char *leaf = strrchr(upstream, '/');
> +			if (leaf && !strcmp(leaf + 1, short_name))
> +				continue;
> +		}
> +
> +		strvec_push(&deletable, short_name);
> +	}
> +
> +	if (deletable.nr)
> +		ret = delete_branches(deletable.nr, deletable.v,
> +				      1, 0,
> +				      FILTER_REFS_BRANCHES, quiet,
> +				      1, &n_not_merged);
> +
> +	if (n_not_merged && !quiet)
> +		fprintf(stderr,
> +			Q_("Skipped %d branch that is not fully merged; "
> +			   "delete it with 'git branch -D' if you are sure.\n",
> +			   "Skipped %d branches that are not fully merged; "
> +			   "delete them with 'git branch -D' if you are sure.\n",
> +			   n_not_merged),
> +			n_not_merged);
> +
> +	strvec_clear(&deletable);
> +	string_list_clear(&candidates, 0);
> +	string_list_clear(&protected_default_refs, 0);
> +	return ret;
> +}
> +
>   static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
>   
>   static int edit_branch_description(const char *branch_name)
> @@ -825,6 +923,7 @@ int cmd_branch(int argc,
>   	int delete = 0, rename = 0, copy = 0, list = 0,
>   	    unset_upstream = 0, show_current = 0, edit_description = 0;
>   	int forked = 0;
> +	int prune_merged = 0;
>   	const char *new_upstream = NULL;
>   	int noncreate_actions = 0;
>   	/* possible options */
> @@ -880,6 +979,8 @@ int cmd_branch(int argc,
>   			 N_("edit the description for the branch")),
>   		OPT_BOOL(0, "forked", &forked,
>   			N_("list local branches forked from the given <remote>s")),
> +		OPT_BOOL(0, "prune-merged", &prune_merged,
> +			N_("delete local branches forked from the given <remote>s that are merged into their upstream")),
>   		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
>   		OPT_MERGED(&filter, N_("print only branches that are merged")),
>   		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
> @@ -924,7 +1025,8 @@ int cmd_branch(int argc,
>   			     0);
>   
>   	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
> -	    !show_current && !unset_upstream && !forked && argc == 0)
> +	    !show_current && !unset_upstream && !forked && !prune_merged &&
> +	    argc == 0)
>   		list = 1;
>   
>   	if (filter.with_commit || filter.no_commit ||
> @@ -933,7 +1035,7 @@ int cmd_branch(int argc,
>   
>   	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
>   			    !!show_current + !!list + !!edit_description +
> -			    !!unset_upstream + !!forked;
> +			    !!unset_upstream + !!forked + !!prune_merged;
>   	if (noncreate_actions > 1)
>   		usage_with_options(builtin_branch_usage, options);
>   
> @@ -971,12 +1073,15 @@ int cmd_branch(int argc,
>   	if (delete) {
>   		if (!argc)
>   			die(_("branch name required"));
> -		ret = delete_branches(argc, argv, delete > 1, filter.kind,
> +		ret = delete_branches(argc, argv, 0, delete > 1, filter.kind,
>   				      quiet, 0, NULL);
>   		goto out;
>   	} else if (forked) {
>   		ret = list_forked_branches(argc, argv);
>   		goto out;
> +	} else if (prune_merged) {
> +		ret = prune_merged_branches(argc, argv, quiet);
> +		goto out;
>   	} else if (show_current) {
>   		print_current_branch_name();
>   		ret = 0;
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 24a3ec44ee..94ea493aee 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1771,4 +1771,87 @@ test_expect_success '--forked requires at least one <remote>' '
>   	test_grep "at least one <remote>" err
>   '
>   
> +test_expect_success '--prune-merged: setup' '
> +	test_create_repo pm-upstream &&
> +	test_commit -C pm-upstream base &&
> +	git -C pm-upstream checkout -b next &&
> +	test_commit -C pm-upstream one-commit &&
> +	test_commit -C pm-upstream two-commit &&
> +	git -C pm-upstream branch one HEAD~ &&
> +	git -C pm-upstream branch two HEAD &&
> +	git -C pm-upstream branch wip main &&
> +	git -C pm-upstream checkout main
> +'
> +
> +test_expect_success '--prune-merged deletes branches integrated into upstream' '
> +	test_when_finished "rm -rf pm-merged" &&
> +	git clone pm-upstream pm-merged &&
> +	git -C pm-merged branch one one-commit &&
> +	git -C pm-merged branch --set-upstream-to=origin/next one &&
> +	git -C pm-merged branch two two-commit &&
> +	git -C pm-merged branch --set-upstream-to=origin/next two &&
> +
> +	git -C pm-merged branch --prune-merged origin &&
> +
> +	test_must_fail git -C pm-merged rev-parse --verify refs/heads/one &&
> +	test_must_fail git -C pm-merged rev-parse --verify refs/heads/two
> +'
> +
> +test_expect_success '--prune-merged spares branches with un-integrated commits' '
> +	test_when_finished "rm -rf pm-unmerged" &&
> +	git clone pm-upstream pm-unmerged &&
> +	git -C pm-unmerged checkout -b wip origin/wip &&
> +	git -C pm-unmerged branch --set-upstream-to=origin/next wip &&
> +	test_commit -C pm-unmerged local-only &&
> +	git -C pm-unmerged checkout - &&
> +
> +	git -C pm-unmerged branch --prune-merged origin 2>err &&
> +	test_grep "not fully merged" err &&
> +	test_grep "Skipped 1 branch" err &&
> +	test_grep "git branch -D" err &&
> +	test_grep ! "If you are sure you want to delete it" err &&
> +	git -C pm-unmerged rev-parse --verify refs/heads/wip
> +'
> +
> +test_expect_success '--prune-merged skips branches whose upstream is gone' '
> +	test_when_finished "rm -rf pm-upstream-gone" &&
> +	git clone pm-upstream pm-upstream-gone &&
> +	git -C pm-upstream-gone branch one one-commit &&
> +	git -C pm-upstream-gone branch --set-upstream-to=origin/next one &&
> +
> +	git -C pm-upstream-gone update-ref -d refs/remotes/origin/next &&
> +	git -C pm-upstream-gone branch --prune-merged origin &&
> +
> +	git -C pm-upstream-gone rev-parse --verify refs/heads/one
> +'
> +
> +test_expect_success '--prune-merged never deletes the checked-out branch' '
> +	test_when_finished "rm -rf pm-head" &&
> +	git clone pm-upstream pm-head &&
> +	git -C pm-head checkout -b one one-commit &&
> +	git -C pm-head branch --set-upstream-to=origin/next one &&
> +
> +	git -C pm-head branch --prune-merged origin &&
> +
> +	git -C pm-head rev-parse --verify refs/heads/one
> +'
> +
> +test_expect_success '--prune-merged spares the local default branch' '
> +	test_when_finished "rm -rf pm-default" &&
> +	git clone pm-upstream pm-default &&
> +	git -C pm-default checkout --detach &&
> +	git -C pm-default branch --prune-merged origin &&
> +	git -C pm-default rev-parse --verify refs/heads/main
> +'
> +
> +test_expect_success '--prune-merged protects only the default branch by name, not by upstream' '
> +	test_when_finished "rm -rf pm-default-alias" &&
> +	git clone pm-upstream pm-default-alias &&
> +	git -C pm-default-alias branch --track trunk origin/main &&
> +	git -C pm-default-alias checkout --detach &&
> +	git -C pm-default-alias branch --prune-merged origin &&
> +	git -C pm-default-alias rev-parse --verify refs/heads/main &&
> +	test_must_fail git -C pm-default-alias rev-parse --verify refs/heads/trunk
> +'
> +
>   test_done

