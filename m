Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628372;
	b=Jz065924bNxyYkK6gLw8m/JfNQ5Zb4pimGgqfxjmJBzOM9nGI1qPoQrRshFItfrznqyL
	 Joubq0cXdXmJ6QLzYxgzBn8CcfJPp8pvNhEEpnfUpUHS8lnoUbWd7Cd8lpHlLBUKEwe8E
	 3+lu15L9G8G0js5qBesFmU84yy3uBdP3vFXk1lmStbfFcDF6GLBQCAOEiwtrVnWvCjdAR
	 pA2mq5QvWRjnWQJYpqZmmggy3lTGutNuhTBwEjH0PaWYDQIK1zDVH5+5w1jyQQ1GnTaNN
	 5qV36af5psP63o3GzIZjCuTvvfpg177Fc/DZFHxNSIhQeUfjhABZ1Hhxp3dtRZb5Rgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=F6r/7aXG9paChp1on82Mwzz50BriR2HPcKKIMUoelAM=;
	b=NNyaa14OZ0i+dIRH0A+ShP5+jsuN+g0JOBcIAnt1e+GU5WDByqTHROgyj11VSiiWLedV
	 CnghuJcLIAwGiN3PCYk7kHFjdMQqJmjo05A5zI4nttTU3w4FhxtjTv0ri1+bnDISqV91E
	 nzXqm9x8p9IVy9c6xiCNFIjnheijGno0/nRkvUhfYIou6RPIW5jkf4R2tR+/cP7ME8Ni3
	 4IOnFePyHFR3XzMGrtplBMZrZlXxzzh5pm+RfyQqdbKPaHDSsSx17ILSTFHWWZH/sop4H
	 6AV0oakVNkVUG5F3j0TMnRYTBfb+ZvM2r5ndKmxeilhPaotBvaOqiphwgpWk0lgq9Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0AJlk0HP;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0536606A32C
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 14:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0536606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0AJlk0HP
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b486e1d02eso3987016a12.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 06:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793628370; x=1794233170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F6r/7aXG9paChp1on82Mwzz50BriR2HPcKKIMUoelAM=;
        b=0AJlk0HPxaCiprLWpLmPHMobyDIj8zxVojlhv94XjXfDwOJLOWgltxzepDYZWfrC8a
         sC5rIEtuX0QwI+1vn/3SJBjxmdYH4n7OcRpoF1P33qyFThpdmt3bfmG0JYjbfcqYUZfA
         uek7tWMqryAWsMSaP78T2vVOXQTEFf70TaNsCXItuDPeo0PmgykRQ9fWwXET+NLENZyH
         nELwvd9jv8KBa+4m2NYA7R3EL6CuiX8REvnURDZ5/S/l1CaqkbwfOvYQPbClOBXfjmRc
         rFCT80iYe0YAa7qMp80HwH5HctHaoZ5U5FQ+Gx9MZ+MCy/N2Kmqc3uVRBBOE1b24sl6k
         /1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793628370; x=1794233170;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F6r/7aXG9paChp1on82Mwzz50BriR2HPcKKIMUoelAM=;
        b=sPR+jYj6REnh8kyC7LVO1MeDZcG8ctyRkXOCqV6yCqg1jPusGPLfNstOY7dtnMBtZc
         1DckP2NSjF9uRNTQbdMcxRCo5sXb4kitBRDio6L1H8jpgA5HBedypQ1S5dg1UfY2iwgC
         N7B7fWM8GUCeK9WEgLB9OYusq6vkRALQdzSaE97hEmQugWrKMa1Qg2q1rtkutvui6gCO
         aCO2lKprkrcoVjXGwd2OIRpMvp1se0va6qlAr1oAxxx9sgEFTWyrMRc1xO6A752Rvzb6
         sWDUNvMK6xmfcXY6SqKQcSc/E+rzBgOKgdHSklGX2mLEqQszISoKgaQ2TXtcgWktID8g
         p0yA==
X-Forwarded-Encrypted: i=1; AKwUvBxvsTLtHBzRv6egNkRIFNgif76rmwXrdmehtKA6UrBTNXc7KmG64Zk7yMBBezzG/2sISRg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IpGyo4jPs1tsd0MTpgxsE9EPLYw6VbErxzaUDIwaHw8DzoLIA
	zLiBY5OyXrSxoVm7Sqbg6y3r60aP9myXJb4hFlvkq4e5uvJIxpXmFWVB
X-Gm-Gg: AYBFou0E/UsTLf1mpjQNz84FHgT+vew9zTMa9X4XHPHfzz63nOul3P6chGYv7igCI+5
	/neUYOgWk9jhzVhM21soDqaP3HpE13/wCZoGLebGyRZonJ8/5VpoyVIn808FqFnsbAskHB//d6S
	MzzLyPRZzfvhGU0uN4vlwhvLoV7qJZVomzeFSvDP4j/xS80tJbFMvG45+C6c3qy78/c22PTgdRc
	g1L4ce96qQg4T6j4T/JBx9aVRBfKRjrsuwMYQJt91tEifK+1qo3eqr959GNCsVdrg4XWmDZKaeN
	266H8nsbA4EDOF81YhKOqHF1YIGNoExx+UjBrWSpyzhiZFoiVMFFc281xZY4bsWc58KEr65U49h
	fwE0mFHmRDJxXzu487b5YXSW4hns6R3VzLRJryJE7T/qWLgbl5ZkTydxdmKqOEMt86igM8pRE7x
	aInLTBLIkiFWrmJklBVegKhXCI4GTjQ2tYsrdfdHr4b47La8JSuGC/1a7tJ+WzR+Sy43hDH+Kin
	4gTc5IdyLfVOyjstOh0nDSB6hYS0at08Yjl/6HZrGzAwn3fFHGCdo0RQIPHR/d7TI00YCPJVCky
	s8Wk95bI/YoFQqtz1LZazWV9a3yr4pjP5ET9iuVFy4pxGL3DNtmzuQaurFhI8eUaaEj45j7G3sU
	iVCh5/w8=
X-Received: by 2002:a05:6402:2709:b0:6b1:ba86:5f43 with SMTP id 4fb4d7f45d1cf-6b4d4d7a943mr7356743a12.19.1793628369702;
        Mon, 02 Nov 2026 06:06:09 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4ec9ee7c9sm3417218a12.7.2026.11.02.06.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 06:06:08 -0800 (PST)
Message-ID: <37d53d40-66b6-46bb-a38d-0d3534ca112a@gmail.com>
Date: Mon, 2 Nov 2026 14:06:05 +0000
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
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] ref-filter: name the worktree of a branch being
 rebased or bisected
To: Jasper Mayone <me@jaspermayone.com>, git@vger.kernel.org
Cc: gitster@pobox.com, sunshine@sunshineco.com,
 kristofferhaugsbakk@fastmail.com, ben.knoble@gmail.com,
 haraldnordgren@gmail.com
References: <20261024165311.57387-1-me@jaspermayone.com>
 <20261030142137.54750-1-me@jaspermayone.com>
 <20261030142137.54750-3-me@jaspermayone.com>
Content-Language: en-US
In-Reply-To: <20261030142137.54750-3-me@jaspermayone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jasper

On 30/10/2026 14:21, Jasper Mayone wrote:
> %(worktreepath) gives the worktree that has a branch checked out, and
> "git branch" uses it to mark such branches with "+". It only looks at
> the HEAD of each worktree, so while a worktree is rebasing or
> bisecting a branch, its HEAD is detached and the branch shows no
> worktree at all.
> 
> The rest of Git already treats that branch as checked out: "git
> worktree add" and "git branch -d" refuse it, because finishing the
> rebase or bisect will check it out again.

Those commands also reject branches that are being updated by a rebase 
via "update-ref" commands. If we're interested in checkouts we don't 
want to list those, but it means that "%(worktree)" will still give 
different results.

> "git worktree list" shows
> such a worktree as "(detached HEAD)", so %(worktreepath) is the only
> place a script could find out which worktree is working on the
> branch.

I don't really follow this logic. At the moment neither "git 
for-each-ref", nor "git worktree list" show this  - there is no way for 
a script to find out which worktree is working on a given branch. We can 
choose to add it to one or both commands.

> Also map the branch that a worktree is rebasing or bisecting to that
> worktree, as prepare_checked_out_branches() in branch.c does.

If we want it to behave like prepare_checked_out_branches() we should 
use that function, rather than copying some of it to a separate file. If 
we want to only list checked out branches we could do as I previously 
suggested and add a function to branch.c that lists the worktrees where 
a branch is checked out.

> Branches that "rebase --update-refs" will update are not mapped: that
> worktree has not checked them out, it only moves them when the rebase
> is done.

I think that's sensible

> As a result "git branch" marks such a branch with "+", also when it
> runs in the worktree that is rebasing or bisecting it, where it shows
> both "* (no branch, rebasing topic)" and "+ topic". Document that.

That sounds a bit confusing - "* (no branch, rebasing topic)" already 
tells us what we need to know, why do we need "+ topic" as well? The 
output of git branch is intended for human consumption, not scripts.

> diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
> index bfdf459329..d499d7e0d4 100644
> --- a/Documentation/git-branch.adoc
> +++ b/Documentation/git-branch.adoc
> @@ -33,7 +33,10 @@ DESCRIPTION
>   If `--list` is given, or if there are no non-option arguments, existing
>   branches are listed; the current branch will be highlighted in green and
>   marked with an asterisk.  Any branches checked out in linked worktrees will
> -be highlighted in cyan and marked with a plus sign. Option `-r` causes the
> +be highlighted in cyan and marked with a plus sign. A branch that a
> +worktree is rebasing or bisecting counts as checked out there, so it is
> +marked in the same way,

I follow this up to here

> also in the worktree that is rebasing or bisecting it.

but what is this trying to say?

> diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
> index a7b31e8aaf..90ff37259e 100644
> --- a/Documentation/git-for-each-ref.adoc
> +++ b/Documentation/git-for-each-ref.adoc
> @@ -182,7 +182,9 @@ but if used together the last option is selected.
>   
>   `worktreepath`::
>   	The absolute path to the worktree in which the ref is checked
> -	out, if it is checked out in any linked worktree. Empty string
> +	out, if it is checked out in any linked worktree. A branch that
> +	a worktree is rebasing or bisecting counts as checked out there,
> +	although that worktree's `HEAD` is detached. Empty string
>   	otherwise.

It is not a new problem, but I think it would be helpful to add 
something like

     As the path may contain a newline, it is recommended to either use
     one of the quoting options, or follow `%(worktreepath)` with `%00`
     and parse the output by looking for the `NUL` after the worktree
     path and then the LF that terminates each output record.

     Note that if a branch checked out in more than one worktree,
     `%(worktreepath)` will only show one of those worktrees.

> diff --git a/ref-filter.c b/ref-filter.c
> index bdf54f6f59..1aebea243e 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> [...]
> +/*
> + * Map each branch to the worktree that has it checked out. A worktree
> + * that is rebasing or bisecting a branch has it checked out, too,
> + * even though its HEAD may be detached, as for
> + * prepare_checked_out_branches() in branch.c.
> + */
>   static void populate_worktree_map(struct hashmap *map, struct worktree **worktrees)
>   {
> -	int i;
> +	struct strbuf ref = STRBUF_INIT;
>   
> -	for (i = 0; worktrees[i]; i++) {
> -		if (worktrees[i]->head_ref) {
> -			struct ref_to_worktree_entry *entry;
> -			entry = xmalloc(sizeof(*entry));
> -			entry->wt = worktrees[i];
> -			hashmap_entry_init(&entry->ent,
> -					strhash(worktrees[i]->head_ref));
> +	for (size_t i = 0; worktrees[i]; i++) {
> +		struct worktree *wt = worktrees[i];
> +		struct wt_status_state state = { 0 };
>   
> -			hashmap_add(map, &entry->ent);
> +		if (wt->is_bare)
> +			continue;

This is a change in behavior. We currently print the git_dir of bare 
worktrees. I think you can argue that this change is a bug fix as the 
user asked for the worktree path, but it should be explained in the 
commit message.

It is a shame that we end up duplicating code that is already in 
branch.c. As I said last time, I think that it would be better to have a 
single implementation that maps branches to worktrees in branch.c and 
call that function rather than duplicating it here.

Thanks

Phillip

> +
> +		if (wt->head_ref)
> +			add_worktree_entry(map, wt, wt->head_ref);
> +
> +		if (wt_status_check_rebase(wt, &state) &&
> +		    (state.rebase_in_progress ||
> +		     state.rebase_interactive_in_progress) &&
> +		    state.branch) {
> +			strbuf_reset(&ref);
> +			strbuf_addf(&ref, "refs/heads/%s", state.branch);
> +			add_worktree_entry(map, wt, ref.buf);
>   		}
> +		wt_status_state_free_buffers(&state);
> +
> +		if (wt_status_check_bisect(wt, &state) &&
> +		    state.bisecting_from) {
> +			strbuf_reset(&ref);
> +			strbuf_addf(&ref, "refs/heads/%s", state.bisecting_from);
> +			add_worktree_entry(map, wt, ref.buf);
> +		}
> +		wt_status_state_free_buffers(&state);
>   	}
> +	strbuf_release(&ref);
>   }
>   
>   static void lazy_init_worktree_map(void)
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index 7c44186341..e04599392d 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -442,6 +442,41 @@ test_expect_success 'worktree colors correct' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'branch being rebased in a worktree is marked' '
> +	test_when_finished "git -C rebase_dir rebase --abort; rm -rf rebase_dir; git worktree prune; git branch -D rebasing" &&
> +	git worktree add -b rebasing rebase_dir branch-two &&
> +	git -C rebase_dir commit --allow-empty -m rebase-me &&
> +	test_must_fail git -C rebase_dir rebase -f -x false HEAD~1 &&
> +	test_must_fail git -C rebase_dir symbolic-ref -q HEAD &&
> +	git branch --list rebasing >actual &&
> +	echo "+ rebasing" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'branch being rebased is marked in its own worktree' '
> +	test_when_finished "git -C rebase_dir rebase --abort; rm -rf rebase_dir; git worktree prune; git branch -D rebasing" &&
> +	git worktree add -b rebasing rebase_dir branch-two &&
> +	git -C rebase_dir commit --allow-empty -m rebase-me &&
> +	test_must_fail git -C rebase_dir rebase -f -x false HEAD~1 &&
> +	git -C rebase_dir branch --list rebasing >actual &&
> +	echo "+ rebasing" >expect &&
> +	test_cmp expect actual &&
> +	git -C rebase_dir branch >actual &&
> +	test_grep "^\* (no branch, rebasing rebasing)" actual
> +'
> +
> +test_expect_success 'branch being bisected in a worktree is marked' '
> +	test_when_finished "git -C bisect_dir bisect reset; rm -rf bisect_dir; git worktree prune; git branch -D bisecting" &&
> +	git worktree add -b bisecting bisect_dir branch-two &&
> +	git -C bisect_dir commit --allow-empty -m bisect-one &&
> +	git -C bisect_dir commit --allow-empty -m bisect-two &&
> +	git -C bisect_dir bisect start HEAD HEAD~2 &&
> +	test_must_fail git -C bisect_dir symbolic-ref -q HEAD &&
> +	git branch --list bisecting >actual &&
> +	echo "+ bisecting" >expect &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success "set up color tests" '
>   	echo "<RED>main<RESET>" >expect.color &&
>   	echo "main" >expect.bare &&
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 7f060d97bf..d656901f21 100755
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
> @@ -541,6 +542,68 @@ test_expect_success 'validate worktree atom' '
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
>   test_expect_success 'start after with empty value' '
>   	cat >expect <<-\EOF &&
>   	refs/heads/main

