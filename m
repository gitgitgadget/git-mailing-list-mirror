Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A954C3B0593
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337822; cv=none; b=JDNM8kNNonOR+VlxKOsi9piVvfBmrEvbIysf1LHftFfhJXwx7YRExqrcY1l+jjRDeclyVx+Wa2czUNhH7H5eJOozn1m5rKZMNjI9sx0ZUAxsVRCA0FDqVIoXmp82qylQWzgcSAsvwgHtyD0Yl45jqJowEYuH7e5Ei8jNQKNFkh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337822; c=relaxed/simple;
	bh=kwlmp27BAbaXZBep96J0dA0jj4/fJtmaJL1+6kR+1Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubSINKeYv9naPt8MZT1nN5WhMxXBHnUA1mxburCarS31p5OTvHZ+kAGLyOqCCWi7llLLSUpGEU5pOv4I8EVhPQwCIp26fvJ2ySViLtSJ4ojhwgXVWUGy+lLhcGBB+8qmIJh9c9M0wyUbbdX4JcwGmMDmgyqtTCH3PvoeIop0GTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PO2cRGiN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO2cRGiN"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954c0833b4so7504335e9.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 08:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785337819; x=1785942619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZytDXdAqB4x75yd/6WyQChrzTf4D0G7mKemzxPCXGLk=;
        b=PO2cRGiNKiQiBtKxjM/R1seYt5r1+UDV7ERri1z+JN6REil4LfYMAiQkqpfPrC0NEf
         C+WtZhGDe/Mlkw8boKhDqAx+WsAV7JHgTDrEDavYo1ZGPA1YcNKeXy+A/FMkfjU5PLxx
         IAYUVZn+aBvVR6fXylKQD3uK37ti44s6PbiQPKSJ+tdFpAfKHSUxChojBbKnVODoKzN3
         VZHKv7s9Ui4O9adh2wijTtduUW3b3Sm1NICt9o9drzKlenulSxKi6IfyBYViajGKc7VZ
         cicxiew4o1dV6sx5SDO/5FmHfaKQaOzDoZcdcpcZEPNbcdFoOmKklPMO5d0T+9nxAWNR
         b7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785337819; x=1785942619;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZytDXdAqB4x75yd/6WyQChrzTf4D0G7mKemzxPCXGLk=;
        b=AHfGw2EdMI3TydthwJhXST+CxzQLllLkrM5I2G9mEliLG5RIuPxBwL5RjLn1GY2bUm
         RmdxI/CtlBKiYNwN/pd3npmy7xp63/YyMeE8x7IiEl3tqXfXFQNMnlBLrmf42Hm+E3us
         CcIyDZIcsp33kXlq+7spM/BQBz9bw5Bry+D6CmewopNlMgo2bX1B+T3H7LP2O6+0pCo5
         IWkuhoIxIWRJjZmlibCzVjGuMk6i+e+lmnf3IA5Zt4Gl3Iw6/eVyuKly8Gr0MaS97ZDm
         CWPHgbWr6DU3PA1c/NX/+1kdf0mv+ue42BKxzxGTetUBMrxNoa8x7Zp+x7y/qfklYbn6
         b6aA==
X-Forwarded-Encrypted: i=1; AHgh+Rr5GPL6JnJiqW/MX4ZYzlNRun+7Rio6rQpCM5oPWvBHYG9vzMtNW93RlLfbWW9GAcMoJSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytEXSACyPoc+4wB3VaxkS/f9hnQyriIRQxGCVtgv3icpVSoo+R
	VtMk9YmYB0lhcq/jcc5msxYC5TORndJtiwU3ZSBATnV8pGAnJcdbMXyD
X-Gm-Gg: AR+sD115tLieLHRh3rIXGn5UhnXWHT4F7sSN5d5owCI7nlS+0x9FN0ptitF+bnDSN7c
	/jag7QutNZWC+pY+1O/Urq0dprkmW1WuOYyriDW5GnxfiJ1L039Gy5LWrYl0hvQ/wVp/AKfg3RM
	othfXDe5Q8rJObCgw+oe3iLS9PqniqYy63AU09SaosPEPOyfb2CdE4oJkTCEmaLZfKV9FjBZRdT
	8ggFESLtD2JYlIKIvwMuTKYwTFobCi2/6YaxGPWXIx0kp+sIT4mycDl8vnd/2PX3rUSFv2JHHwi
	UNARxk/tfPYxXfXLNSBdIdIFgY+W3C8mthpZJVqf7fErLYKJcaDzHg2MjbXHlWPF58vzW7x71e5
	azL/Skkmt7QtHKZq4SjB/g1tDLNjSX1cHH7sDIvTsy7Abj7oiacCS67oY6R2BqYF7nsrJYLEpyD
	BhfqVpjMulDGy69OIoHB+133rApBFN4/o6rOntpNoqjqpIyy8i6ApnRDj5Le1yqho48hfjMmmTW
	DsUbfOIasIqAhvB/o3JfKFsg0sXL+r1JPkdFrmEk7aGwX9lrnFudg==
X-Received: by 2002:a05:600c:1c27:b0:493:e974:41ac with SMTP id 5b1f17b1804b1-496c643c6f9mr83594695e9.16.1785337818392;
        Wed, 29 Jul 2026 08:10:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496e8e06f7csm71733485e9.0.2026.07.29.08.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 08:10:17 -0700 (PDT)
Message-ID: <1f282ad4-9937-4c95-89d4-70f7a1c883a8@gmail.com>
Date: Wed, 29 Jul 2026 16:10:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v23 5/7] branch: add --delete-merged <branch>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
 <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
 <5fd74f0050e5af1f2ab03ddae56dc96385e6a237.1784979136.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <5fd74f0050e5af1f2ab03ddae56dc96385e6a237.1784979136.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

Sorry it has taken so long for we to look at this again - I'm not sure 
where last week went.

On 25/07/2026 12:32, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
>      git branch (--delete-merged <branch>)... [<pattern>...]
> 
> deletes local branches matching the optional patterns when their
> configured upstream matches one of the --delete-merged arguments and
> their tip is reachable from that upstream. The work has already landed
> on the upstream they track, so the local copy is no longer needed.
> 
> The option can be repeated to widen the upstream match. Keeping the
> candidate patterns as positional arguments lets users bound the set of
> local branches that may be deleted independently of the upstream
> selection.
> 
> A branch is not deleted when:
> 
>    * it is checked out in any worktree
>    * its configured upstream ref no longer exists, since a missing
>      upstream is not by itself a sign of integration
>    * pushing it by name to the remote configured by
>      branch.<name>.remote would update its upstream, as determined by
>      mapping the branch ref through that remote's fetch refspec. For
>      example, a local "main" that tracks "origin/main" is kept even when
>      remote.pushDefault names a fork. Right after a pull it merely looks
>      fully merged.
> 
> A branch whose work is not yet merged into its upstream is silently
> skipped, so one unmerged topic does not abort the whole sweep.
> 
> A branch that a surviving branch depends on through a chain of local
> upstreams is also kept, so no branch is deleted out from under stacked
> work. 

Shouldn't this be part of the list above. So we no-longer delete any 
branch in a chain of stacked branches when one of them is unmerged? 
Previously we only kept the upstream of the unmerged branch and deleted 
the rest.

Collect this transitive set without changing the candidate set
> during ref iteration: walk upstream chains from surviving branches,
> visit each branch at most once, and remove the collected bases only
> after the iteration completes. This makes the result independent of
> ref iteration order without repeated full scans.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   Documentation/git-branch.adoc |  30 +++++
>   builtin/branch.c              | 158 +++++++++++++++++++++++++-
>   t/t3200-branch.sh             | 204 ++++++++++++++++++++++++++++++++++
>   3 files changed, 390 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
> index b0d66a6deb..2a96cd7253 100644
> --- a/Documentation/git-branch.adoc
> +++ b/Documentation/git-branch.adoc
> @@ -25,6 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
>   git branch (-c|-C) [<old-branch>] <new-branch>
>   git branch (-d|-D) [-r] <branch-name>...
>   git branch --edit-description [<branch-name>]
> +git branch (--delete-merged <branch>)... [<pattern>...]
>   
>   DESCRIPTION
>   -----------
> @@ -201,6 +202,35 @@ This option is only applicable in non-verbose mode.
>   	Print the name of the current branch. In detached `HEAD` state,
>   	nothing is printed.
>   
> +`--delete-merged <branch>`::
> +	Delete local branches whose configured upstream matches
> +	_<branch>_, but only when their tip is reachable from that
> +	upstream. In other words, the work on the branch has already
> +	landed on the upstream it tracks, so the local copy is no longer
> +	needed. The option can be repeated to widen the upstream match.
> +	Optional _<pattern>_ arguments limit which local branches are
> +	considered, e.g. `git branch --delete-merged 'origin/*'
> +	'topic-*'`.
> ++
> +A branch is not deleted when:
> ++
> +--
> +* its configured upstream ref no longer exists,
> +* it is checked out in any worktree, or
> +* pushing it by name to the remote configured by
> +  `branch.<name>.remote` would update its upstream, so it cannot be
> +  distinguished from a branch that just looks "fully merged" right
> +  after a pull.

  * it is the upstream of an unmerged branch

> +--
> ++
> +A branch whose work has not yet been merged into its upstream is
> +silently skipped. Delete it with `git branch -D` if you want to
> +remove it anyway.
> ++
> +A branch that a surviving branch depends on through a chain of local
> +upstreams is kept, so a branch is never deleted out from under stacked
> +work.
> +
>   `-v`::
>   `-vv`::
>   `--verbose`::
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 1ef8362c12..78b694034f 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -21,6 +21,7 @@
>   #include "branch.h"
>   #include "path.h"
>   #include "string-list.h"
> +#include "strmap.h"
>   #include "column.h"
>   #include "utf8.h"
>   #include "ref-filter.h"
> @@ -38,6 +39,7 @@ static const char * const builtin_branch_usage[] = {
>   	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
>   	N_("git branch [<options>] [-r | -a] [--points-at]"),
>   	N_("git branch [<options>] [-r | -a] [--format]"),
> +	N_("git branch [<options>] (--delete-merged <branch>)... [<pattern>...]"),

I don't quite follow this - why the "()" and doesn't --delete-merged 
take a pattern?

>   	NULL
>   };
>   
> @@ -699,6 +701,148 @@ static int parse_opt_forked(const struct option *opt, const char *arg, int unset
>   	return 0;
>   }
>   
> +struct stacked_branch_data {
> +	struct strset *deletable_branch_names;
> +	struct strset *protected_branch_names;
> +	struct strset *visited_branch_names;
> +};
> +
> +static int collect_stacked_branch_bases(const struct reference *ref,
> +					void *cb_data)
> +{
> +	struct stacked_branch_data *data = cb_data;
> +	const char *branch_name;
> +
> +	if (!skip_prefix(ref->name, "refs/heads/", &branch_name))
> +		BUG("expected local branch ref, got '%s'", ref->name);
> +	if (strset_contains(data->deletable_branch_names, branch_name))
> +		return 0;
> +
> +	while (strset_add(data->visited_branch_names, branch_name)) {
> +		struct branch *branch = branch_get(branch_name);
> +		const char *upstream_refname = branch_get_upstream(branch, NULL);
> +		const char *upstream_branch_name;
> +
> +		if (!upstream_refname ||
> +		    !skip_prefix(upstream_refname, "refs/heads/",
> +				 &upstream_branch_name) ||
> +		    !strset_contains(data->deletable_branch_names,
> +				    upstream_branch_name))
> +			break;
> +
> +		strset_add(data->protected_branch_names, upstream_branch_name);
> +		branch_name = upstream_branch_name;
> +	}

This looks correct, it is a shame we have to build 
"visited_branch_names" but the code is clear.

> +	return 0;
> +}
> +
> +static void protect_stacked_branch_bases(struct ref_store *refs,
> +					 struct strset *deletable_branch_names)
> +{
> +	struct strset protected_branch_names = STRSET_INIT;
> +	struct strset visited_branch_names = STRSET_INIT;
> +	struct stacked_branch_data data = {
> +		.deletable_branch_names = deletable_branch_names,
> +		.protected_branch_names = &protected_branch_names,
> +		.visited_branch_names = &visited_branch_names,
> +	};
> +	struct refs_for_each_ref_options opts = {
> +		.prefix = "refs/heads/",
> +	};
> +	struct hashmap_iter iter;
> +	struct strmap_entry *entry;
> +
> +	refs_for_each_ref_ext(refs, collect_stacked_branch_bases, &data, &opts);
> +
> +	strset_for_each_entry(&protected_branch_names, &iter, entry)
> +		strset_remove(deletable_branch_names, entry->key);

We remove the protected branches from deleteable - good

> +
> +	strset_clear(&visited_branch_names);
> +	strset_clear(&protected_branch_names);
> +}
> +
> +static int branch_pushes_to_upstream(struct branch *branch,
> +				     const char *upstream)
> +{
> +	struct remote *remote = remote_get(remote_for_branch(branch, NULL));
> +	char *tracking = NULL;
> +	int ret = 0;
> +
> +	if (remote)
> +		tracking = apply_refspecs(&remote->fetch, branch->refname);

This tells us which remote tracking ref corresponds to the branch

> +	if (tracking && !strcmp(tracking, upstream))
> +		ret = 1;

Here we check that it does not match the upstream branch. That ignores 
the push refspect though so does not tell us whether pushing the branch 
to the upstream remote would update the upstream branch on that remote.

We need to apply the push refspec to the local branch, apply the fetch 
refspec in reverse to the result and then compare that to the upstream 
branch.

> +
> +	free(tracking);
> +	return ret;
> +}
> +
> +static int delete_merged_branches(const struct strvec *upstreams,
> +				 const char **argv, unsigned int flags)
> +{
> +	struct ref_store *refs = get_main_ref_store(the_repository);
> +	struct ref_filter filter = REF_FILTER_INIT;
> +	struct ref_array candidates = { 0 };
> +	struct strset deletable_branch_names = STRSET_INIT;
> +	struct strvec branches_to_delete = STRVEC_INIT;
> +	struct hashmap_iter iter;
> +	struct strmap_entry *entry;
> +	int ret = 0;
> +
> +	for (size_t i = 0; i < upstreams->nr; i++)
> +		if (ref_filter_forked_add(&filter, upstreams->v[i]) < 0)
> +			die(_("'%s' is not a valid branch or pattern"),
> +			    upstreams->v[i]);
> +
> +	filter.kind = FILTER_REFS_BRANCHES;
> +	filter.name_patterns = argv;
> +	filter_refs(&candidates, &filter, filter.kind);
> +
> +	for (int i = 0; i < candidates.nr; i++) {
> +		const char *branch_refname = candidates.items[i]->refname;
> +		const char *branch_name;
> +		struct branch *branch;
> +		const char *upstream_refname;
> +
> +		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
> +			BUG("filter returned non-branch ref '%s'", branch_refname);
> +		if (branch_checked_out(branch_refname))
> +			continue;
> +
> +		branch = branch_get(branch_name);
> +		upstream_refname = branch_get_upstream(branch, NULL);
> +		if (!upstream_refname || !refs_ref_exists(refs, upstream_refname))
> +			continue;
> +		if (branch_pushes_to_upstream(branch, upstream_refname))
> +			continue;
> +		if (check_branch_commit(branch_name, branch_name,
> +					&candidates.items[i]->objectname, NULL,
> +					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
> +			continue;
> +
> +		strset_add(&deletable_branch_names, branch_name);
> +	}

We build the set of branches to delete and then

> +	protect_stacked_branch_bases(refs, &deletable_branch_names);

remove the ones that are upstreams of branches that are not in the set 
and then

> +	strset_for_each_entry(&deletable_branch_names, &iter, entry)
> +		strvec_push(&branches_to_delete, entry->key);

build a list of branches to delete - good.

> +	if (branches_to_delete.nr)
> +		ret = delete_branches(branches_to_delete.nr, branches_to_delete.v,
> +				      FILTER_REFS_BRANCHES,
> +				      DELETE_BRANCH_SKIP_UNMERGED |
> +				      DELETE_BRANCH_NO_HEAD_FALLBACK |
> +				      flags);
> +
> +	strvec_clear(&branches_to_delete);
> +	strset_clear(&deletable_branch_names);
> +	ref_array_clear(&candidates);
> +	ref_filter_clear(&filter);
> +	return ret;
> +}

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 4ffd224a71..268203089b 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1872,4 +1872,208 @@ test_expect_success '--forked requires a value' '
>   	test_grep "requires a value" err
>   '
>   
> +test_expect_success '--delete-merged: setup' '
> +	git init -b main upstream &&
> +	(
> +		cd upstream &&
> +		test_commit base &&
> +		git checkout -b next &&
> +		test_commit next-work &&
> +		git checkout main
> +	) &&
> +	git init -b main other &&
> +	test_commit -C other other-base &&
> +	git init -b main fork
> +'
> +
> +setup_repo_for_delete_merged () {
> +	rm -rf repo &&
> +	git clone upstream repo &&
> +	(
> +		cd repo &&
> +		git remote add fork ../fork &&
> +		git remote add other ../other &&
> +		git config push.default current &&
> +		git fetch other
> +	)
> +}
> +
> +create_merged_branch () {
> +	(
> +		cd repo &&
> +		git checkout -b "$1" origin/next --track &&
> +		git commit --allow-empty -m "$1 work" &&
> +		git push origin "$1:next"
> +	)
> +}
> +
> +check_branches () {
> +	git for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
> +	cat >expect &&
> +	test_cmp expect actual
> +}

This makes checking the remaining branches in the tests really nice> +
> +test_expect_success '--delete-merged keeps cloned main without a default push remote' '
> +	setup_repo_for_delete_merged &&
> +	(
> +		cd repo &&
> +		git checkout --detach &&
> +
> +		git branch --delete-merged */* &&

Unless I've missed something main does not have an upstream branch set, 
so we'd never expect it to be deleted, even if a push remote was set.

> +
> +		check_branches <<-\EOF
> +		main
> +		EOF
> +	)
> +'
> +
> +test_expect_success '--delete-merged deletes only selected merged branches' '
> +	setup_repo_for_delete_merged &&
> +	create_merged_branch also-merged &&
> +	create_merged_branch merged &&
> +	(
> +		cd repo &&
> +		git checkout -b unmerged origin/next --track &&

In the tests we try to avoid mixing options and positional arguments so 
we use either
	git checkout --track -b unmerged origin/next
or
	git checkout -b unmerged --track origin/next

> +		git commit --allow-empty -m "unmerged work" &&
> +		git checkout -b tracks-other other/main --track &&
> +		sha=$(git rev-parse --short merged) &&
> +
> +		git branch --delete-merged origin/next merged >actual 2>&1 &&
> +		echo "Deleted branch merged (was $sha)." >expect &&
> +		test_cmp expect actual &&
> +
> +		check_branches <<-\EOF
> +		also-merged

As we passed "merged" on the command line "also-merged" was not deleted 
- good.

> +		main
> +		tracks-other
> +		unmerged
> +		EOF
> +	)
> +'
> +
> +test_expect_success '--delete-merged keeps main despite a different default push remote' '
> +	setup_repo_for_delete_merged &&
> +	create_merged_branch on-next &&
> +	create_merged_branch checked-out &&
> +	create_merged_branch upstream-gone &&
> +	(
> +		cd repo &&
> +		git config remote.pushDefault fork &&
> +		git checkout -b local-to-delete main --track &&
> +		git update-ref refs/remotes/origin/topic refs/remotes/origin/next &&
> +		git branch --set-upstream-to=origin/topic upstream-gone &&
> +		git update-ref -d refs/remotes/origin/topic &&

As I think I said last time, this is a very round-about way to have the 
upstream gone. It would be much simpler just to set the config directly.

> +		git checkout -b tracks-other other/main --track &&
> +		git checkout checked-out &&
> +
> +		git branch --delete-merged origin/* \
> +			--delete-merged main &&

These lines look very short why the wrapping?

> +
> +		check_branches <<-\EOF
> +		checked-out
> +		main
> +		tracks-other
> +		upstream-gone
> +		EOF
> +	)
> +'
> +
> +test_expect_success '--delete-merged keeps the upstream of a surviving branch' '
> +	setup_repo_for_delete_merged &&
> +	create_merged_branch feature &&
> +	(
> +		cd repo &&
> +		git checkout -b topic feature --track &&

we base our branch on feature which is merged into origin/next

> +		git commit --allow-empty -m "topic work" &&
> +
> +		git branch --delete-merged origin/next 2>err &&
> +
> +		test_must_be_empty err &&
> +		check_branches <<-\EOF &&
> +		feature
> +		main
> +		topic
> +		EOF
> +
> +		git config --local --get-regexp "branch\\.(feature|topic)\\.(merge|remote)" >actual &&
> +		cat >expect <<-\EOF &&
> +		branch.feature.remote origin
> +		branch.feature.merge refs/heads/next

and so we keep feature and it's upstream config (because it's upstream 
branch still exists) - good.

> +		branch.topic.remote .
> +		branch.topic.merge refs/heads/feature
> +		EOF
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success '--delete-merged keeps the upstream chain of a surviving branch' '
> +	setup_repo_for_delete_merged &&
> +	(
> +		cd repo &&
> +		git config remote.pushDefault fork &&
> +		git branch lower origin/next --track &&
> +		git branch mid lower --track &&
> +		git checkout -b tip mid --track &&
> +		git commit --allow-empty -m "tip work" &&
> +
> +		git branch --delete-merged origin/next \
> +			--delete-merged lower >actual 2>&1 &&
> +		test_must_be_empty actual &&
> +
> +		check_branches <<-\EOF &&
> +		lower

Why do we keep "lower", rather than clear the upstream config of "mid"?


I'm not completely convinced by the new behavior wrt stacked branches, 
but this looks good apart from the branch_pushes_to_upstream() issue.

Thanks

Phillip

> +		main
> +		mid
> +		tip
> +		EOF
> +
> +		git config --local --get-regexp "branch\\.(lower|mid|tip)\\.(merge|remote)" >actual &&
> +		cat >expect <<-\EOF &&
> +		branch.lower.remote origin
> +		branch.lower.merge refs/heads/next
> +		branch.mid.remote .
> +		branch.mid.merge refs/heads/lower
> +		branch.tip.remote .
> +		branch.tip.merge refs/heads/mid
> +		EOF
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success '--delete-merged result is independent of stacked branch names' '
> +	setup_repo_for_delete_merged &&
> +	(
> +		cd repo &&
> +		git branch c-lower origin/next --track &&
> +		git branch b-mid c-lower --track &&
> +		git checkout -b a-tip b-mid --track &&
> +		git commit --allow-empty -m "tip work" &&
> +
> +		git branch --delete-merged origin/next \
> +			--delete-merged "c-*" &&
> +
> +		check_branches <<-\EOF &&
> +		a-tip
> +		b-mid
> +		c-lower
> +		main
> +		EOF
> +
> +		git branch --delete-merged origin/next \
> +			--delete-merged "c-*" >actual 2>&1 &&
> +		test_must_be_empty actual &&
> +
> +		check_branches <<-\EOF
> +		a-tip
> +		b-mid
> +		c-lower
> +		main
> +		EOF
> +	)
> +'
> +
> +test_expect_success '--delete-merged requires a value' '
> +	test_must_fail git -C forked branch --delete-merged 2>err &&
> +	test_grep "requires a value" err
> +'
>   test_done

