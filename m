Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29373BCD2B
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142633; cv=none; b=PkxsMjWjexfzr2xhPFip+HMPSTWUppMvPqtAatBz00gsCzqMP0xpjK/Jo3MRNW+rMXu2cWgs/Gpbgjf/iVP/seh2w4Ze9s7Go9J32VCo5U0+47t93cGMtprdAmDW4U2jwhYOtx/+PyaJjdptH8MgHkokvqwXGqdTvTtLYYsH0mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142633; c=relaxed/simple;
	bh=VgopQl+YjCfk6iAj+GJ5wyz7Gcv3OpSGg7cFs7+/Qw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0dxPHYw/vJJLuU6Acy3pUWqkVeRmdNUDZwUbnqP0XtMbZ6AV1lY8p+WRC5lqB8o7rjaX8XCV/46LwzK/CWj5+EmxATSfBPRFE+mgITcNxbAs5e6QIXLWsMVAwEKXZwO1yyU4JBYqOkxRS6q8P0R0pM6O8WfRm7qZ9ez5bwdGT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kxj0AY7y; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kxj0AY7y"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so3524469f8f.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782142630; x=1782747430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S0NMtfsQVJk2aXtqLGHL15ZX6J9SHB+Lmm6hVTULGHQ=;
        b=Kxj0AY7yR9Y/G1MqKDHy9D8in4oZJkITs86tt7iO8/kkX9/9z7knlDwqR0x8DyEIYM
         0Z9vv704+f946LE6Xz8RzmXzqcFIT0OHQKl5n/bPigQNFG21F5sU7RYtpMAJ1ChV8O3G
         N03pJUjUKOc/QFYLvvEAkacgGKKqn4LQ523X/2OUWb+zZ5YKmMdEUVBdHBH7cUq5R8Js
         9fl4Mg/ZJvVCfzMCVk0CAF0p9VXm4z6lDNFlcFjk8B1osCnaKFDBm4eqUfcKPjAlSEuh
         PTpDg3RChIN4oktC5hQSzgQz/nUIHzfetrI+p1Ij78PYgABUGEMyiciSjlhmsGS61RMm
         98nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782142630; x=1782747430;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0NMtfsQVJk2aXtqLGHL15ZX6J9SHB+Lmm6hVTULGHQ=;
        b=bSmR7Riei4T0FU2viSQUCIV2OSRAQ8UASVz3TMasp0fov7Jqd/JnkpDgMB3waLPmns
         e32xzcwMCgAU/Eex/wyQC7+h2CqmrdWWtjAI86v6hQ4Dnlny1zNuyJlbwZVyIgJRMJb9
         iXJGJQaXsGV4kqn/gvembdOWTLjWzwBvhhXA3+EAypzINOmLr7ePf8Ph71OlbjECf+SY
         VR9N1ZP7BhFNvfRebCfTMnwtSMOHM+KnSUFI7NKQ+gVMnX+dyrXVW2gEdyCH+sgyfX1P
         ziiLA9c2DJvOZXQmKyoZJbwBRurZieIZ+onAelOzHOXmdme70dOGTxly1gVlbRkoUML1
         5GOA==
X-Forwarded-Encrypted: i=1; AHgh+RoCGw0OV7+vV4WatB/DzUijvCWe30Wn4EnLookp7qPeJRzWXt1jQDbRexDigTBYUD2OAF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1DpoaU1C4ZalLJqxYuCXJbA5nuQxelmLPaacL+wV/pZb23T6N
	J2DoWdB08jdJj0ilskVvnYRUtPkdyXKUU8s4iAS5dMODM+5+W4uVi1nZ
X-Gm-Gg: AfdE7cmUCnKqA8Vz+z7rxZFTonUL+YsRV7Eeb92ItRSLATqAzc45IHuPIc/JHvNCfGq
	jUIiYWp/8SltYxcjB6FOSjLidhIzAHzx2UwkVwqCwgfsBEjRC1A8pMarE92i7C5WlzGeeEMc36w
	RAGt5JibPSVCAdYzZe/6EqOdCRIVGj0HthAjiD70U2j+7NX1L8h8XuviE0dbzCCB0YORs4QHmdp
	3nH8wkv8Cxe4erIKlx315OJPaxp+w0E7yQS4Zw9B/wU3KidbFVDiXJ+k5KQjqIMYBukt4YrUd2r
	LiY+kE9McCbpsewK2iyYYv1eZ/07pFQe2L8rPCXMXxDhQKhijhOydR5jxA7Hdgnpl2np5Hrkzg6
	S7/ys3UxOkWUZC7v/FU3ASmz/HQ1g+O8aoSFAD5sMfxQubK8Nz3yPVYd9k/OBnCEakZHLKHjbys
	tB/sMRgjqvkKApbOXAX9WISsr1fzdbjC4SaHEDHXK13CsA6zE7SPzuTjV7ewhKcvYG2v0=
X-Received: by 2002:a05:6000:490a:b0:46a:41d3:deba with SMTP id ffacd0b85a97d-46a41d3ded3mr1508823f8f.43.1782142630020;
        Mon, 22 Jun 2026 08:37:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4666cea9581sm25337223f8f.0.2026.06.22.08.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 08:37:09 -0700 (PDT)
Message-ID: <cb6fcdfb-67b4-429d-b820-c4e623f28cfa@gmail.com>
Date: Mon, 22 Jun 2026 16:36:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v17 5/7] branch: add --delete-merged <branch>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
 <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <46da7c814056ddbc23accf19a61d0451b949127e.1782113388.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <46da7c814056ddbc23accf19a61d0451b949127e.1782113388.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 22/06/2026 08:29, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> +static int collect_upstream(const struct reference *ref, void *cb_data)
> +{
> +	struct string_list *upstreams = cb_data;
> +	struct branch *branch = branch_get(ref->name);
> +	const char *upstream = branch_get_upstream(branch, NULL);
> +
> +	string_list_append(upstreams, ref->name)->util =
> +		xstrdup_or_null(upstream);
> +	return 0;
> +}
> +
> +/*
> + * Keep any branch that another, surviving branch tracks as its
> + * upstream, so we never delete a branch out from under one stacked on
> + * top of it.  Sparing a branch makes it a survivor whose own upstream
> + * then needs the same protection, so repeat until nothing changes.
> + */
> +static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable)
> +{
> +	struct string_list upstreams = STRING_LIST_INIT_DUP;
> +	struct string_list_item *item;
> +	bool spared;
> +
> +	refs_for_each_branch_ref(refs, collect_upstream, &upstreams);
> +	do {
> +		spared = false;
> +		for_each_string_list_item(item, &upstreams) {
> +			const char *up = item->util, *up_short;
> +
> +			if (!up || strset_contains(deletable, item->string))
> +				continue;
> +			if (!skip_prefix(up, "refs/heads/", &up_short) ||
> +			    !strset_contains(deletable, up_short))
> +				continue;
> +
> +			strset_remove(deletable, up_short);
> +			spared = true;
> +		}
> +	} while (spared);
> +
> +	string_list_clear(&upstreams, 1);
> +}

This keeps the whole chain of branches, which is the safest thing to
do but potentially keeps unneeded branches around. It is only really
the upstream branches of unmerged branches which are useful so we
could just keep those, and if their upstream branch is going to be
deleted clear the upstream config for that branch.

For example, if we have branch feature-3 with upstream feature-2 which
has upstream feature-1, then if feature-1 and feature-2 are merged we'd
delete feature-1 but keep feature-2 and clear its upstream config. If we
also had feature-4 that was not merged and had upstream feature-1 we'd
keep feature-1 and leave the upstream config for feature-2 unchanged.

Here is a possible implementation for that. It compiles but I've not
written any new tests. It does pass the existing tests which means
either it is buggy or we don't have coverage for keeping a chain of
branches.

static int collect_upstreams(const struct reference *ref, void *cb_data)
{
	struct collect_upstream_data *data = cb_data;
	struct strset *deletable = data->deletable;
	struct strset *upstreams = data->upstreams;
	struct branch *branch;
	const char *upstream_ref, *upstream_name;

	/*
	 * We're only interested in the upstreams of branches that
	 * are not being deleted.
	 */
	if (strset_contains(deletable, ref->name))
		return 0;
	branch = branch_get(ref->name);
	if (!branch)
		return 0;
	upstream_ref = branch_get_upstream(branch, NULL);
	/*
	 * We're only interested in the upstream if it is going to
	 * be deleted.
	 */
	if (!upstream_ref ||
	    !skip_prefix(upstream_ref, "refs/heads/", &upstream_name) ||
	    !strset_contains(deletable, upstream_name))
		return 0;
	/*
	 * Do not delete this branch because it is the upstream of
	 * an unmerged branch. Also remember it so we can check if
	 * its upstream is marked for deletion once we've visited all
	 * branches
	 */
	strset_remove(deletable, upstream_name);
	strset_add(upstreams, upstream_name);

	return 0;
}

/*
  * Keep any branch that another, surviving branch tracks as its
  * upstream, so we never delete a branch out from under one stacked on
  * top of it.  If the upstream branch has an upstream set that is marked
  * for deletion clear its upstream config.
  */
static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable)
{
	struct strset upstreams = STRSET_INIT;
	struct collect_upstream_data data = {
		.deletable = deletable,
		.upstreams = &upstreams,
	};
	struct strbuf buf = STRBUF_INIT;
	struct hashmap_iter iter;
	struct strmap_entry *entry;

	refs_for_each_branch_ref(refs, collect_upstreams, &data);
	strset_for_each_entry(&upstreams, &iter, entry) {
		const char *upstream_upstream;
		struct branch *upstream_branch;

		/* We know upstream_ref is a branch, skip "refs/heads/" */
		upstream_branch = branch_get(entry->key);
		upstream_upstream = branch_get_upstream(upstream_branch, NULL);
		if (upstream_upstream &&
		    strset_contains(deletable, upstream_upstream)) {
			/*
			 * This branch has been merged and is the upstream of
			 * an unmerged branch.  Its upstream is marked for
			 * deletion because it is not the upstream of any
			 * unmerged branch so clear its upstream config.
			 */
			strbuf_reset(&buf);
			strbuf_addf(&buf, "branch.%s.merge", upstream_branch->name);
			repo_config_set_gently(the_repository, buf.buf, NULL);
			strbuf_setlen(&buf, buf.len - 5);
			strbuf_addstr(&buf, "remote");
			repo_config_set_gently(the_repository, buf.buf, NULL);
		}
	}
	strbuf_release(&buf);
	strset_clear(&upstreams);

}


> +	for (i = 0; i < candidates.nr; i++) {
> +		const char *short_name;
> +
> +		if (skip_prefix(candidates.items[i]->refname, "refs/heads/",
> +				&short_name) &&
> +		    strset_contains(&deletable, short_name))
> +			strvec_push(&to_delete, short_name);
> +	}

It would be nicer to use strset_for_each_entry() here. First declare

	struct hashmap_iter iter;
	struct strmap_entry *entry;

at the top of the function and then replace the loop with

	strset_for_each_entry(&deletable, &iter, entry)
		strvec_push(&to_delete, entry->key);

Thanks

Phillip


> +	if (to_delete.nr)
> +		ret = delete_branches(to_delete.nr, to_delete.v,
> +				      FILTER_REFS_BRANCHES,
> +				      DELETE_BRANCH_SKIP_UNMERGED |
> +				      DELETE_BRANCH_NO_HEAD_FALLBACK |
> +				      flags);
> +
> +	strvec_clear(&to_delete);
> +	strset_clear(&deletable);
> +	ref_array_clear(&candidates);
> +	ref_filter_clear(&filter);
> +	return ret;
> +}
> +
>   static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
>   
>   static int edit_branch_description(const char *branch_name)
> @@ -746,6 +862,7 @@ int cmd_branch(int argc,
>   	/* possible actions */
>   	int delete = 0, rename = 0, copy = 0, list = 0,
>   	    unset_upstream = 0, show_current = 0, edit_description = 0;
> +	int delete_merged = 0;
>   	const char *new_upstream = NULL;
>   	int noncreate_actions = 0;
>   	/* possible options */
> @@ -799,6 +916,8 @@ int cmd_branch(int argc,
>   		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
>   		OPT_BOOL(0, "edit-description", &edit_description,
>   			 N_("edit the description for the branch")),
> +		OPT_BOOL(0, "delete-merged", &delete_merged,
> +			N_("delete local branches whose upstream matches <branch> and are merged")),
>   		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
>   		OPT_MERGED(&filter, N_("print only branches that are merged")),
>   		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
> @@ -846,7 +965,8 @@ int cmd_branch(int argc,
>   			     0);
>   
>   	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
> -	    !show_current && !unset_upstream && argc == 0)
> +	    !show_current && !unset_upstream && !delete_merged &&
> +	    argc == 0)
>   		list = 1;
>   
>   	if (filter.with_commit || filter.no_commit ||
> @@ -856,7 +976,7 @@ int cmd_branch(int argc,
>   
>   	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
>   			    !!show_current + !!list + !!edit_description +
> -			    !!unset_upstream;
> +			    !!unset_upstream + !!delete_merged;
>   	if (noncreate_actions > 1)
>   		usage_with_options(builtin_branch_usage, options);
>   
> @@ -898,6 +1018,10 @@ int cmd_branch(int argc,
>   				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
>   				      (quiet ? DELETE_BRANCH_QUIET : 0));
>   		goto out;
> +	} else if (delete_merged) {
> +		ret = delete_merged_branches(argc, argv,
> +					     quiet ? DELETE_BRANCH_QUIET : 0);
> +		goto out;
>   	} else if (show_current) {
>   		print_current_branch_name();
>   		ret = 0;
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 3104c555f6..1d372f95e8 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1839,4 +1839,155 @@ test_expect_success '--forked narrows a <pattern> argument' '
>   	test_cmp expect actual
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
> +		git config remote.pushDefault fork &&
> +		git config push.default current &&
> +		git fetch other
> +	)
> +}
> +
> +merged_branch () {
> +	(
> +		cd repo &&
> +		git checkout -b "$1" "$2" &&
> +		git commit --allow-empty -m "$1 work" &&
> +		git push origin "$1:next" &&
> +		git fetch origin &&
> +		git branch --set-upstream-to="$2" "$1"
> +	)
> +}
> +
> +test_expect_success '--delete-merged deletes merged branches and spares the rest' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo_for_delete_merged &&
> +	merged_branch merged origin/next &&
> +	(
> +		cd repo &&
> +		git checkout -b unmerged origin/next &&
> +		git commit --allow-empty -m "unmerged work" &&
> +		git branch --set-upstream-to=origin/next unmerged &&
> +		git checkout -b tracks-other other/main &&
> +		git branch --set-upstream-to=other/main tracks-other &&
> +		git checkout --detach
> +	) &&
> +	sha=$(git -C repo rev-parse --short merged) &&
> +
> +	git -C repo branch --delete-merged origin/next >actual 2>&1 &&
> +
> +	echo "Deleted branch merged (was $sha)." >expect &&
> +	test_cmp expect actual &&
> +	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
> +	cat >expect <<-\EOF &&
> +	main
> +	tracks-other
> +	unmerged
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--delete-merged deletes merged branches and spares protected ones' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo_for_delete_merged &&
> +	merged_branch on-next origin/next &&
> +	merged_branch checked-out origin/next &&
> +	merged_branch upstream-gone origin/next &&
> +	(
> +		cd repo &&
> +		git checkout -b mainline main &&
> +		git checkout -b on-local mainline &&
> +		git branch --set-upstream-to=mainline on-local &&
> +		git update-ref refs/remotes/origin/topic refs/remotes/origin/next &&
> +		git branch --set-upstream-to=origin/topic upstream-gone &&
> +		git update-ref -d refs/remotes/origin/topic &&
> +		git branch --set-upstream-to=origin/main main &&
> +		git config branch.main.pushRemote origin &&
> +		git checkout -b tracks-other other/main &&
> +		git branch --set-upstream-to=other/main tracks-other &&
> +		git checkout checked-out
> +	) &&
> +
> +	git -C repo branch --delete-merged origin/next mainline &&
> +
> +	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
> +	cat >expect <<-\EOF &&
> +	checked-out
> +	main
> +	mainline
> +	tracks-other
> +	upstream-gone
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--delete-merged requires at least one <branch>' '
> +	test_must_fail git -C forked branch --delete-merged 2>err &&
> +	test_grep "requires at least one <branch>" err
> +'
> +
> +test_expect_success '--delete-merged keeps a branch that is an upstream' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo_for_delete_merged &&
> +	merged_branch feature origin/next &&
> +	(
> +		cd repo &&
> +		git checkout -b topic feature &&
> +		git commit --allow-empty -m "topic work" &&
> +		git branch --set-upstream-to=feature topic &&
> +		git checkout --detach
> +	) &&
> +
> +	git -C repo branch --delete-merged origin/next 2>err &&
> +
> +	test_must_be_empty err &&
> +	git -C repo rev-parse --verify refs/heads/feature &&
> +	git -C repo rev-parse --verify refs/heads/topic
> +'
> +
> +test_expect_success '--delete-merged keeps a chain of upstreams of a kept branch' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo_for_delete_merged &&
> +	(
> +		cd repo &&
> +		git branch b3 origin/next &&
> +		git branch --set-upstream-to=origin/next b3 &&
> +		git branch b2 origin/next &&
> +		git branch --set-upstream-to=b3 b2 &&
> +		git checkout -b b1 b2 &&
> +		git commit --allow-empty -m "b1 work" &&
> +		git branch --set-upstream-to=b2 b1 &&
> +		git checkout --detach
> +	) &&
> +
> +	git -C repo branch --delete-merged origin/next &&
> +
> +	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
> +	cat >expect <<-\EOF &&
> +	b1
> +	b2
> +	b3
> +	main
> +	EOF
> +	test_cmp expect actual
> +'
> +
>   test_done

