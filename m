Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329279;
	b=PypiZv0cebXmN0S5V8eU7rbkpmqvE00qn74zwzkn9bo5EBEN1AJZFLXwGYh+iF7oS0dr
	 iUFZAoWxNkPQ4wdiEgfY/Uxj07iBxnhsKIvrkUIZm+6kSsaSlfA3leM7VX6ECZpR/Rk8j
	 MVqLWKz4wAAwY1U9fxdaKTC2ns7fwTE7JgNo0unscShaLoPU1TNNUgyleKe74+k0rWqkW
	 YEe2MsD82YnJ8CZFJcv3R4Gg7+3D1SXwsOdyLGuC3o87M8ITMiCSA2g2TqZfxuEH/cdAS
	 U62nqE5OXLPimtKiu8n2w5ZqXjigKgqJoYKcbxDBXfYo5BSXFvTydNXO4M5njyUUDCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:Reply-To:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=KfKXMplbjSe0cJ7A7aGc5mUiI3QcbM04z+3SeYmSrAw=;
	b=gcU0Hfc5Q10ZZnKvpcTAbHresV3glV06wPBSMxuhqZnIv5dMGAXgQtNASLzLHKj7ebDx
	 Fw4QQRwKS6kADGTyOWgtO59oNBW3PwYm+i++jTfTtLQ3Wc7KiDFm/4hliMX81sc2CvGNg
	 a8QIk3C6Qqy7NSDkLrBIb6GXPkXDTylTJXiiJ6YQ3qV4I284V1WJIUfueC0MEgKQQv+fK
	 yGnh2pq78febg4M2alyh8xekHuEzsdnDnfUdQOFRoGUzRbpNCyMB6Qc82APhKvT6qcala
	 /Z4KxHgO5CyGyt+6EIfwbqsvr6KKW0cItH5g8I/WCZGwbRQDnns9y05Rf0llwN9gUoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qf0InN1a;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5D606A32A
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97D5D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qf0InN1a
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so17809235e9.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 08:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794329277; x=1794934077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KfKXMplbjSe0cJ7A7aGc5mUiI3QcbM04z+3SeYmSrAw=;
        b=Qf0InN1ayFnOEFALrd3WQhon8Kc/bqyTp5/FCqCdDsYGA5yUA3wD2hx/tgE8OVvwGS
         k1ePabSBl1NTXBMrV/pqdYdwaHUamypNtDVYg2TXpZR9KL6PdKp9omujdAuW0OT3otzQ
         Zr1p0shsgP/GjAo57VJLUFwI6Br0DqEYMbq8WNrJpwFPxkb13YQfP+qXha0DLMG74AsE
         zXxDPkxNsLbGDfKlZMN4DoTrnLYhRxC/LxjOz/fn6flCVjZn9HjjZrph9Jd3joExHUXN
         ReUITbt5gPoyLLp0KU0QwjF2ubiApVkeTzDA576Slb3U7qv4+KjTsyqguutFviAxZSA5
         z4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329277; x=1794934077;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KfKXMplbjSe0cJ7A7aGc5mUiI3QcbM04z+3SeYmSrAw=;
        b=mt9dBzs5oph5sz0fNtDH+pxdBuE68a/37x63rqzm47yX28TUZ945VHEhKVH+azZz8R
         M/d0csbKDiyx5vtVC/sWMgT0QSuus4vBwWdMU/uHZHNlL5Qv1kCT+FjsGenRkeiqouZq
         gKQ4uzYTMo9Vc1cKEe4a8NqyhT9ijl40JbO8sZzcL3BeMNtVAU21CE/zLeyUxFm08Iio
         ysvqTnPwQPHbRDZvG6Pphh6rHoJ09iw6rXdZG+tbum/VBnvnOnIwHBoK6P9qxh8rJmMq
         00P7XqWbzkZMKahqI90vCB02wFTCIo7AC82fQpEadiLKufotRlRZs9lxZE5cOjEkugkt
         0qAQ==
X-Forwarded-Encrypted: i=1; AL+hErEwnU4pxJo2UlvnQc7rpYm5yNmP7IwMD8b5gqJ3hh6BtNbvQ39swfPCJ9t0wf75KzptvP0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sOUFJLPHt2ODMxQbgzDrvs0ojXhZ5h/zYHW6JA8WKAJKnPMhZ
	rnCdOTbRboPiB8IZP/GqzLRpvO0ctepFgdBn/3PyPwiSkpqy5/mbVsx1
X-Gm-Gg: AYBFou1NKyd1Avn+/Ut9LiLD1EzBbyv5LxRn9tA3JifUTZWNIRWaQlZlYgLsUJlyiZW
	2L+UDtzgAmJAJaPiiOZC/TUfAX2rnEbxKFDJdJMpJMxwDoR+D2DxdQTk9K3iVjYIDbdHTE0O+PJ
	n8hY2qD5sS6DeUNFB06OS7a6x4IfqkVZ65Un4IHc5tpi1baNRnzYE2uNlZbXXhYyfs59qOh/Z9c
	OTLqIq5mjUDOKIFKVivnrGEuLb0TW2JB4zsKaMrhMG4hIwMMI2FDgWkCLkyQnJuvzDwR7x1In14
	GKCfDHfSavYRP6iE1YXcOP6boAvOaW6RjD1TBDZ+Dj+mpNM9oNt/SPcdYSeNdRwhH+GPVoRt8Is
	qrzZoBzHYEqUx5oUmyLt2t1yda28M5464OOjBuswEQOOYzoN00FjhwmvHgqTqa+A3zGKe9bhfwB
	K1dKv518BOOn6va8lxzFLxsqz+Uh1TemP6Uqzd4yAEnYVG72ouFRjGjj+P1KUsmlBmUqwqGiC4u
	siKjWwWPSPCN3tpwsPITsxounjkdY9fjqFwAVxtLtVXGAGdWEJwrPN7gmkeB90EvKA6ApNNUCyE
	4GTTrKiMDufM8rVviLyIjuPXIGmUG8/I0YW/9Ph644bkF4H3vdGtwVHdjg4e43kJ5QlZEsila1f
	TvUyuia0=
X-Received: by 2002:a05:600c:354a:b0:4a2:150f:1613 with SMTP id 5b1f17b1804b1-4ba023361aamr55060805e9.7.1794329276721;
        Tue, 10 Nov 2026 08:47:56 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49836c835fcsm5603748f8f.59.2026.11.10.08.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:47:56 -0800 (PST)
Message-ID: <f55185d7-12e6-4a11-af66-2e358d1cb205@gmail.com>
Date: Tue, 10 Nov 2026 16:47:55 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 3/4] ref-filter: name the worktree of a branch being
 rebased or bisected
Reply-To: phillip.wood@dunelm.org.uk
To: Jasper Mayone <me@jaspermayone.com>, git@vger.kernel.org
Cc: gitster@pobox.com, sunshine@sunshineco.com,
 kristofferhaugsbakk@fastmail.com, ben.knoble@gmail.com,
 haraldnordgren@gmail.com
References: <20261030142137.54750-1-me@jaspermayone.com>
 <20261102182930.3511-1-me@jaspermayone.com>
 <20261102182930.3511-4-me@jaspermayone.com>
Content-Language: en-US
In-Reply-To: <20261102182930.3511-4-me@jaspermayone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jasper

On 02/11/2026 18:29, Jasper Mayone wrote:
> %(worktreepath) gives the worktree that has a branch checked out, and
> "git branch" uses it to mark such branches with "+". It only looks at
> the HEAD of each worktree, so while a worktree is rebasing or
> bisecting a branch, its HEAD is detached and the branch shows no
> worktree at all.
> 
> The rest of Git already treats that branch as checked out: "git
> worktree add" and "git branch -d" refuse it, because finishing the
> rebase or bisect will check it out again. But no command shows which
> worktree is working on the branch: "git worktree list" shows such a
> worktree as "(detached HEAD)", and %(worktreepath) is empty.
> 
> branch.c already knows the answer, as prepare_checked_out_branches()
> records the branch that each worktree has checked out, is rebasing or
> is bisecting. Add branch_checked_out_worktree() to look a branch up in
> that list, and use it for %(worktreepath) in place of the map that
> ref-filter.c builds from the HEAD of each worktree.
> 
> The new function skips the branches that "rebase --update-refs" will
> update. branch_checked_out() includes them, so that they cannot be
> checked out or deleted during the rebase, but the worktree that runs
> the rebase has not checked them out. %(worktreepath) therefore stays
> empty for them, unlike branch_checked_out().
> 
> This also changes the result for a bare repository: its HEAD names a
> branch, and %(worktreepath) used to give the path of the bare
> repository for that branch. "git branch" in a linked worktree marked
> the branch with "+", although no worktree has it checked out and "git
> worktree add" lets you check it out. prepare_checked_out_branches()
> skips bare repositories, so %(worktreepath) is now empty for that
> branch and "git branch" no longer marks it.

We now document the change in behavior - good.

> diff --git a/branch.c b/branch.c
> index 5bb1c28915..8dab72d857 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -485,6 +485,19 @@ const char *branch_checked_out(const char *refname)
>   	return strmap_get(&current_checked_out_branches, refname);
>   }
>   
> +const char *branch_checked_out_worktree(const char *refname)
> +{
> +	const char *path = NULL;
> +
> +	prepare_checked_out_branches();
> +	for (size_t i = 0; i < checked_out_branches_nr; i++) {
> +		if (checked_out_branches[i].kind != BRANCH_CHECKOUT_KIND_UPDATE_REF &&
> +		    !strcmp(refname, checked_out_branches[i].refname))
> +			path = checked_out_branches[i].path;
> +	}

Iterating over all the worktrees for every ref is going to be slower 
than it needs to be. As I said in [1] we should use a hash map to map 
branch names to the worktree where they are checked out. That is also 
what the existing ref-filter code does.

Then we can add a function to get the worktree path where a branch is 
checked out and call that from the ref-filter code.

Thanks

Phillip

> +	return path;
> +}
> +
>   const char *branch_bisecting(const char *refname)
>   {
>   	prepare_checked_out_branches();
> diff --git a/branch.h b/branch.h
> index 95b2431f24..60cb92a3e4 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -106,6 +106,15 @@ void create_branches_recursively(struct repository *r, const char *name,
>    */
>   const char *branch_checked_out(const char *refname);
>   
> +/*
> + * If a worktree has the branch 'refname' checked out, or is rebasing or
> + * bisecting it, return the path of that worktree, or of the last one if
> + * there are more. Otherwise return NULL. Unlike branch_checked_out(),
> + * this ignores the branches that "git rebase --update-refs" will
> + * update, because no worktree has them checked out.
> + */
> +const char *branch_checked_out_worktree(const char *refname);
> +
>   /*
>    * If the branch at 'refname' is currently used for bisecting in a
>    * worktree, then return the path to that worktree.
> diff --git a/ref-filter.c b/ref-filter.c
> index bdf54f6f59..b636e56199 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2,6 +2,7 @@
>   #define DISABLE_SIGN_COMPARE_WARNINGS
>   
>   #include "git-compat-util.h"
> +#include "branch.h"
>   #include "environment.h"
>   #include "gettext.h"
>   #include "config.h"
> @@ -95,30 +96,6 @@ static struct expand_data {
>   	struct object_info info;
>   } oi, oi_deref;
>   
> -struct ref_to_worktree_entry {
> -	struct hashmap_entry ent;
> -	struct worktree *wt; /* key is wt->head_ref */
> -};
> -
> -static int ref_to_worktree_map_cmpfnc(const void *lookupdata UNUSED,
> -				      const struct hashmap_entry *eptr,
> -				      const struct hashmap_entry *kptr,
> -				      const void *keydata_aka_refname)
> -{
> -	const struct ref_to_worktree_entry *e, *k;
> -
> -	e = container_of(eptr, const struct ref_to_worktree_entry, ent);
> -	k = container_of(kptr, const struct ref_to_worktree_entry, ent);
> -
> -	return strcmp(e->wt->head_ref,
> -		keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);
> -}
> -
> -static struct ref_to_worktree_map {
> -	struct hashmap map;
> -	struct worktree **worktrees;
> -} ref_to_worktree_map;
> -
>   /*
>    * The enum atom_type is used as the index of valid_atom array.
>    * In the atom parsing stage, it will be passed to used_atom.atom_type
> @@ -2380,49 +2357,11 @@ static int get_object(struct ref_array_item *ref, int deref,
>   	return ret;
>   }
>   
> -static void populate_worktree_map(struct hashmap *map, struct worktree **worktrees)
> -{
> -	int i;
> -
> -	for (i = 0; worktrees[i]; i++) {
> -		if (worktrees[i]->head_ref) {
> -			struct ref_to_worktree_entry *entry;
> -			entry = xmalloc(sizeof(*entry));
> -			entry->wt = worktrees[i];
> -			hashmap_entry_init(&entry->ent,
> -					strhash(worktrees[i]->head_ref));
> -
> -			hashmap_add(map, &entry->ent);
> -		}
> -	}
> -}
> -
> -static void lazy_init_worktree_map(void)
> -{
> -	if (ref_to_worktree_map.worktrees)
> -		return;
> -
> -	ref_to_worktree_map.worktrees = get_worktrees(the_repository);
> -	hashmap_init(&(ref_to_worktree_map.map), ref_to_worktree_map_cmpfnc, NULL, 0);
> -	populate_worktree_map(&(ref_to_worktree_map.map), ref_to_worktree_map.worktrees);
> -}
> -
>   static char *get_worktree_path(const struct ref_array_item *ref)
>   {
> -	struct hashmap_entry entry, *e;
> -	struct ref_to_worktree_entry *lookup_result;
> +	const char *path = branch_checked_out_worktree(ref->refname);
>   
> -	lazy_init_worktree_map();
> -
> -	hashmap_entry_init(&entry, strhash(ref->refname));
> -	e = hashmap_get(&(ref_to_worktree_map.map), &entry, ref->refname);
> -
> -	if (!e)
> -		return xstrdup("");
> -
> -	lookup_result = container_of(e, struct ref_to_worktree_entry, ent);
> -
> -	return xstrdup(lookup_result->wt->path);
> +	return xstrdup(path ? path : "");
>   }
>   
>   /*
> @@ -3195,13 +3134,6 @@ void ref_array_clear(struct ref_array *array)
>   	FREE_AND_NULL(used_atom);
>   	used_atom_cnt = 0;
>   
> -	if (ref_to_worktree_map.worktrees) {
> -		hashmap_clear_and_free(&(ref_to_worktree_map.map),
> -					struct ref_to_worktree_entry, ent);
> -		free_worktrees(ref_to_worktree_map.worktrees);
> -		ref_to_worktree_map.worktrees = NULL;
> -	}
> -
>   	FREE_AND_NULL(array->counts);
>   }
>   
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index 7c44186341..debfac5f26 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -442,6 +442,35 @@ test_expect_success 'worktree colors correct' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'branch being rebased in a worktree is marked' '
> +	test_when_finished "git -C rebase_dir rebase --abort; rm -rf rebase_dir; git worktree prune; git branch -D rebasing" &&
> +	git worktree add -b rebasing rebase_dir branch-two &&
> +	(
> +		cd rebase_dir &&
> +		git commit --allow-empty -m rebase-me &&
> +		test_must_fail git rebase -f -x false HEAD~1 &&
> +		test_must_fail git symbolic-ref -q HEAD
> +	) &&
> +	git branch --list rebasing >actual &&
> +	echo "+ rebasing" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'branch being bisected in a worktree is marked' '
> +	test_when_finished "git -C bisect_dir bisect reset; rm -rf bisect_dir; git worktree prune; git branch -D bisecting" &&
> +	git worktree add -b bisecting bisect_dir branch-two &&
> +	(
> +		cd bisect_dir &&
> +		git commit --allow-empty -m bisect-one &&
> +		git commit --allow-empty -m bisect-two &&
> +		git bisect start HEAD HEAD~2 &&
> +		test_must_fail git symbolic-ref -q HEAD
> +	) &&
> +	git branch --list bisecting >actual &&
> +	echo "+ bisecting" >expect &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success "set up color tests" '
>   	echo "<RED>main<RESET>" >expect.color &&
>   	echo "main" >expect.bare &&
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 7f060d97bf..317ed6f6cd 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -3,6 +3,7 @@
>   test_description='test for-each-refs usage of ref-filter APIs'
>   
>   . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh
>   . "$TEST_DIRECTORY"/lib-gpg.sh
>   
>   test_expect_success 'setup some history and refs' '
> @@ -541,6 +542,81 @@ test_expect_success 'validate worktree atom' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'worktree atom names a worktree rebasing the branch' '
> +	test_when_finished "git -C rebasing rebase --abort; rm -rf rebasing; git worktree prune; git branch -D rebasing" &&
> +	git worktree add -b rebasing rebasing main &&
> +	git -C rebasing commit --allow-empty -m rebase-me &&
> +	test_must_fail git -C rebasing rebase -f -x false main &&
> +	test_must_fail git -C rebasing symbolic-ref -q HEAD &&
> +	echo "$(pwd)/rebasing" >expect &&
> +	git for-each-ref --format="%(worktreepath)" refs/heads/rebasing >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'worktree atom names a worktree bisecting the branch' '
> +	test_when_finished "git -C bisecting bisect reset; rm -rf bisecting; git worktree prune; git branch -D bisecting" &&
> +	git worktree add -b bisecting bisecting main &&
> +	git -C bisecting commit --allow-empty -m bisect-one &&
> +	git -C bisecting commit --allow-empty -m bisect-two &&
> +	git -C bisecting bisect start HEAD main &&
> +	test_must_fail git -C bisecting symbolic-ref -q HEAD &&
> +	echo "$(pwd)/bisecting" >expect &&
> +	git for-each-ref --format="%(worktreepath)" refs/heads/bisecting >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'worktree atom with an interactive rebase stopped at edit' '
> +	test_when_finished "git -C editing rebase --abort; rm -rf editing; git worktree prune; git branch -D editing" &&
> +	git worktree add -b editing editing main &&
> +	git -C editing commit --allow-empty -m edit-me &&
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES="edit 1" git -C editing rebase -i --keep-empty HEAD~1
> +	) &&
> +	test_must_fail git -C editing symbolic-ref -q HEAD &&
> +	echo "$(pwd)/editing" >expect &&
> +	git for-each-ref --format="%(worktreepath)" refs/heads/editing >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'worktree atom ignores branches rebase --update-refs will move' '
> +	test_when_finished "git -C updating rebase --abort; rm -rf updating; git worktree prune; git branch -D updating mid" &&
> +	git worktree add -b updating updating main &&
> +	git -C updating commit --allow-empty -m one &&
> +	git -C updating branch mid &&
> +	git -C updating commit --allow-empty -m two &&
> +	test_must_fail git -C updating rebase -f --update-refs -x false main &&
> +	git for-each-ref --format="%(refname:short) [%(worktreepath)]" \
> +		refs/heads/updating refs/heads/mid >actual &&
> +	cat >expect <<-EOF &&
> +	mid []
> +	updating [$(pwd)/updating]
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'worktree atom ignores a rebase of a detached HEAD' '
> +	test_when_finished "git -C detached-rebase rebase --abort; rm -rf detached-rebase; git worktree prune" &&
> +	git worktree add --detach detached-rebase main &&
> +	git -C detached-rebase commit --allow-empty -m detached &&
> +	test_must_fail git -C detached-rebase rebase -f -x false main &&
> +	git for-each-ref --format="%(worktreepath)" refs/heads/ >actual &&
> +	test_grep ! detached-rebase actual
> +'
> +
> +test_expect_success 'worktree atom ignores the HEAD of a bare repository' '
> +	test_when_finished "rm -rf bare.git bare-wt" &&
> +	git clone --bare . bare.git &&
> +	git -C bare.git symbolic-ref HEAD refs/heads/main &&
> +	git -C bare.git worktree add --detach ../bare-wt main &&
> +	git -C bare.git for-each-ref --format="%(worktreepath)" refs/heads/main >actual &&
> +	echo >expect &&
> +	test_cmp expect actual &&
> +	git -C bare-wt branch --list main >actual &&
> +	echo "  main" >expect &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'start after with empty value' '
>   	cat >expect <<-\EOF &&
>   	refs/heads/main

