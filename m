Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA74346E51
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697077; cv=none; b=HFG/MhXaxAdG3x0E0ksuxs4jjMAaVLEPAj0U7wB4PZUaDswFtHMpni3WVW3Ihci2xIUJp7y4tm7eR/eBCjACL/mwsBLYPydMSkHjSJJSvcoYlfA92okjy+x8PbsU4lSPCFoxtP8makMZRRomaGGOpbNhtlDhda2Ct3v9+6Zkjc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697077; c=relaxed/simple;
	bh=LMMrHIneWgXJpFd5QEKYJhYXJe6+1qkgwoysxWEOVqA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FSaObpTr/4J1zDiNBvA/gcp8Cx+0J9uBTtlYrBffsImfYl/AVokYDv9sPNtr1XbUeyOZUasrjjL0drXNUbIceBBiaJd/3jU+DSbk1j8Ix/iChO/zi9VsIi2Dy+zJY+ejnaNaBWwomcw+Z36snzApQkGj28uH3zeM5gV5/ZCndxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMdFLOfr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMdFLOfr"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1600d040e4so130069066b.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783697074; x=1784301874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TCVOWHFGIl0DXce2avP0a3cZz4TtOnQdmMSG1sWpTIw=;
        b=lMdFLOfrpdWhGjRK9SD8Ll2/osmHR9FmhCaNi94QapnL4+dPI6luzjcmqpLBG9B2Oq
         0my1yji0z/Fp9nil3gTJn54+CHo2WVP3auDUQMQDRN6D7iS1gwnI7xBXmrnGE80ckJMa
         QZtdEbj8V3do5kijM/qeIZbHNQV9rKSFbgzB9/t1aOeoo93AYEdj1tb3QnzbLhQf4UEQ
         0LMAPnz5beUilZPjG714yYrWXQoboPKtnZzmOo5yQ6ooSOvLsGZS2URnJRKrF6jf1SIM
         eC6ORr9D1SdCrq3yr0CLhaYCsaJEYJ6MC5i6udvaoLqRVR4QdnyuZxcxLUs1wS+jOvcM
         l4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783697074; x=1784301874;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TCVOWHFGIl0DXce2avP0a3cZz4TtOnQdmMSG1sWpTIw=;
        b=pZxSe+D4nGsCV/a/1P56BtMHP0HDdUhxS3gT/P8CiGuIM/6ogqTSTexNUi55ZbkAZ8
         jYTs5nuZrOstOd/pPQ4Fra9EcU2OECcJTc+qVyKp0xepLie9OA9fg7TOu0Adxvukjhc1
         p46l4qdw6ddvcd6hIUpdEN4yoiX7tDSAZTBzmYB1sv3MbYHX3kcTRiBxzLa8ILtfJ+hC
         zLYzfeeJE5Oq21ysezZO55WfC1yJt41cGw3Zvn/fxBt0kvf0KCDLkSrgoQ3yRmirXO5u
         CkQCSF2rCtcT9ZbfM9s+qE9rukPMuoun2jYmZDeWqAvs6CTUfLEI58mXfV9JHLg+Dcer
         +LvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp6NOrGlGmrAzOXKtlJtGyFIY7mbJNLiplZbXDSRmUtHr6/LCUufqeS4oDTB6U+RBrqOJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSKPzdWerhpJlG8dRArLrTUo5F1gJkM/MF9fMLHVr5o0tfBURy
	hk5x6gP0qX5/i5QUqjnikoKfdumJLRq0ziu/zA6dbGD33cJgegw0iFEp
X-Gm-Gg: AfdE7ckldIvbJgRJvf6Mw0kjPmIujmB31b6Q9d6wGFPw+Lt3UeI/CqaMmb3U24DT1OV
	UvMMY8vzuS3oNAvedEDunrFyLhqnyCknbkj1ViHZGyIQPND9+fopVUzplJyggPvOTVOKVlu7pKb
	to8S4ob8GD00GE0RNmzB+6gj8fWhiJdMt0t4HO2K5OhZjtxkO5rePX+ryZAmryZQ9ZhgDCIg9o7
	ciBXzmZZwb8uSqRLzBYmd/y+hBmqnX1mOiX7+uxknnFpl5acri0ljuZtESYH891GasYj32Z7chK
	8lKa3gZNUaDeR8FsR8tPnjSp4nvbkXFm/w6j3DXACp8KNF/7HC5JLMgpJYzTt9l/GunsujTpYQ1
	oMoYLf/mq9V3OVFamMpXAyalNe9COJn86cTu9gA+WeCK+eWLHxMp80o6L3Tyqv6BGbd7izhtsPB
	N8SIqebdHeg2swZXIp4lyOVVvaAkwjtyMoT0I4+2o6/Hv32h1Xjhi31nDltmr19VduAcs=
X-Received: by 2002:a17:907:e1c7:20b0:c12:8c27:e2e1 with SMTP id a640c23a62f3a-c15fe511ea3mr125673066b.5.1783697073903;
        Fri, 10 Jul 2026 08:24:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad821666sm630175666b.4.2026.07.10.08.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 08:24:33 -0700 (PDT)
Message-ID: <e35f1268-2518-4a44-9c7c-28ba13ca7b7b@gmail.com>
Date: Fri, 10 Jul 2026 16:24:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v18 5/7] branch: add --delete-merged <branch>
Reply-To: phillip.wood@dunelm.org.uk
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Phillip Wood <phillip.wood123@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
 <a84c555d99c98abcd4618833c14fa35b191fbda2.1782338106.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <a84c555d99c98abcd4618833c14fa35b191fbda2.1782338106.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 24/06/2026 22:55, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> 	git branch --delete-merged <branch>...

This design means that unlike --forked there is no way to limit the 
branches considered for deletion. I wonder if we'd be better to have 
--delete-merged take an argument like --forked so that the user can 
limit the branches that might be deleted without resorting to the config 
setting added in the next patch.

> deletes the local branches that "--forked <branch>" would list,
> keeping only those whose tip is reachable from their configured
> upstream. The work has already landed on the upstream they track,
> so the local copy is no longer needed.
> 
> A branch is not deleted when:
> 
>    * it is checked out in any worktree
>    * its upstream remote-tracking branch no longer exists, since a
>      missing upstream is not by itself a sign of integration
>    * its push destination equals its upstream (<branch>@{push} is
>      the same as <branch>@{upstream}), such as a local "main" that
>      tracks and pushes to "origin/main". Right after a pull it just
>      looks "fully merged", so it is kept. Only branches that push
>      somewhere other than their upstream, typically topics in a fork
>      workflow, are candidates.
> 
> A branch whose work is not yet merged into its upstream is silently
> skipped, so one unmerged topic does not abort the whole sweep.
> 
> A branch that another, surviving branch tracks as its upstream is
> also kept, so a branch is never deleted out from under one stacked
> on top of it. Such a kept branch is itself merged, so when its own
> upstream is being deleted, clear its now-stale upstream config.

The commit message explains the new feature really well. The 
implementation looks good, I've left a few questions and comments on the 
tests

> +static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable)
> +{
> [...]
> +		strbuf_addf(&key, "branch.%s.merge", branch->name);
> +		repo_config_set_gently(the_repository, key.buf, NULL);
> +		strbuf_reset(&key);
> +		strbuf_addf(&key, "branch.%s.remote", branch->name);
> +		repo_config_set_gently(the_repository, key.buf, NULL);

If there are any errors updating the config then the config code will 
print a message and we continue. As clearing the config is really a 
convenience feature I think it is fine to ignore errors here.

> +static int delete_merged_branches(int argc, const char **argv,
> +				 unsigned int flags)
> [...]
> +		if (check_branch_commit(short_name, short_name,
> +					&candidates.items[i]->objectname, NULL,
> +					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))

This check is performed again when we call delete_branches() but we need 
to do it here to prune the branch in order to stop delete_branches() 
printing an error message. The check involves finding a merge-base so it 
is not necessarily cheap - if that becomes a problem in the future we 
can add a flag to delete_branches() to skip the check there.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 3104c555f6..047ba54778 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1839,4 +1839,189 @@ test_expect_success '--forked narrows a <pattern> argument' '
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

A comment would have helped to explain what this helper does. Also 
calling it create_merged_branch() would be clearer too I think.

> +	(
> +		cd repo &&
> +		git checkout -b "$1" "$2" &&

If we add '--track' we can avoid having to run "git branch 
--set-upstream-to" below. The same goes for many if not all of the 
branches created by "git checkout -b" and "git branch" in these tests.

> +		git commit --allow-empty -m "$1 work" &&
> +		git push origin "$1:next" &&

We let the caller specify the upstream branch, but then always push to 
origin/next - should be be using 'git push ${2%%/*} "$1:${2#*/}"', or if 
we don't need that flexibility hard coding the upstream branch?

> +		git fetch origin &&

We've just pushed, what are we fetching here?

> +		git branch --set-upstream-to="$2" "$1"
> +	)
> +}
> +
> +test_expect_success '--delete-merged deletes merged branches and spares the rest' '
> +	test_when_finished "rm -rf repo" &&

The first thing setup_repo_for_delete does is delete repo so do we need 
this as well?

> +	setup_repo_for_delete_merged &&
> +	merged_branch merged origin/next &&
> +	(
> +		cd repo &&
> +		git checkout -b unmerged origin/next &&
> +		git commit --allow-empty -m "unmerged work" &&

good - we have a branch with upstream origin/next that isn't merged and 
one that is.

> +		git branch --set-upstream-to=origin/next unmerged &&
> +		git checkout -b tracks-other other/main &&
> +		git branch --set-upstream-to=other/main tracks-other &&
> +		git checkout --detach

I assume this is to ensure we don't spare a branch because it is checked 
out?

> +	) &&
> +	sha=$(git -C repo rev-parse --short merged) &&
> +
> +	git -C repo branch --delete-merged origin/next >actual 2>&1 &&
> +
> +	echo "Deleted branch merged (was $sha)." >expect &&

There doesn't seem to be any reason for these command or the ones below 
to be outside the subshell - they're all running commands in "repo". 
That seems to be a common pattern in these tests.

> +	test_cmp expect actual &&

This is good we have two branches with an upstream of origin/next, but 
only one of them is merged. We also check no other branches are deleted.

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

Right, we create three branches that are all merged into origin/next

> +	(
> +		cd repo &&
> +		git checkout -b mainline main &&
> +		git checkout -b on-local mainline &&
> +		git branch --set-upstream-to=mainline on-local &&

Why do we need on-local to track mainline rather than main? I'm a bit 
confused what the point of mainline is.

> +		git update-ref refs/remotes/origin/topic refs/remotes/origin/next &&
> +		git branch --set-upstream-to=origin/topic upstream-gone &&
> +		git update-ref -d refs/remotes/origin/topic &&

These three lines can be replaced by

	git config branch.gone.merge does-not-exist

> +		git branch --set-upstream-to=origin/main main &&
> +		git config branch.main.pushRemote origin &&

What does this do? Isn't its pushRemote already origin?

> +		git checkout -b tracks-other other/main &&
> +		git branch --set-upstream-to=other/main tracks-other &&
> +		git checkout checked-out
> +	) &&
> +
> +	git -C repo branch --delete-merged origin/next mainline &&

Do we want to use "origin/*" here instead so that we check that main is 
not deleted because its push destination matches its upstream?

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

This checks we delete on-local - good. I wonder if we should add a 
comment about the expected outcome so it is clear to the casual reader 
what is happening.

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
> +	git -C repo branch --dry-run --delete-merged origin/next >out &&

This belongs in a later patch and shows that the patches in this series 
have not been individually tested (c.f. my previous mail about running 
"git rebase --keep-base --exec")

> +	test_grep ! "feature" out &&
> +
> +	git -C repo branch --delete-merged origin/next 2>err &&
> +
> +	test_must_be_empty err &&

So we don't delete anything because feature is needed by topic

> +	git -C repo rev-parse --verify refs/heads/feature &&
> +	git -C repo rev-parse --verify refs/heads/topic &&

I preferred the way this as checked in the previous tests with 
for-each-ref and test_cmp as that shows everything that was kept.

> +	echo origin/next >expect &&
> +	git -C repo rev-parse --abbrev-ref feature@{upstream} >actual &&
> +	test_cmp expect actual &&
> +	echo feature >expect &&
> +	git -C repo rev-parse --abbrev-ref topic@{upstream} >actual &&
> +	test_cmp expect actual

This is a bit of a faff. Perhaps

     git config --local --get-regexp 
"branch.(feature|topic).(merge|remote)" >actual

followed by test_cmp would be more concise and more clearly show that 
we're interested in checking that the config settings still exist.

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

I'd find this easier to follow if the base branch which is created 
firest was numbered 1, rather than the tip of the stack.


> +	git -C repo branch --delete-merged origin/next &&

b3 is merged but cannot be deleted because it is the upstream for b2 
which although it is merged into b3 isn't a candidate for deletion 
because its upstream is b3.

I'm not quite sure what this test demonstrates that the next one does not.

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
> +test_expect_success '--delete-merged clears the upstream of a kept base whose own base is deleted' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo_for_delete_merged &&
> +	(
> +		cd repo &&
> +		git branch lower origin/next &&
> +		git branch --set-upstream-to=origin/next lower &&
> +		git branch mid origin/next &&
> +		git branch --set-upstream-to=lower mid &&
> +		git checkout -b tip mid &&
> +		git commit --allow-empty -m "tip work" &&
> +		git branch --set-upstream-to=mid tip &&
> +		git checkout --detach
> +	) &&
> +
> +	git -C repo branch --delete-merged origin/next lower &&

We expect lower to be deleted, but not mid because although it is merged 
it is the upstream of an unmerged branch. Again it would be nice to 
check that with for-each-ref (maybe that is a common enough pattern to 
justify a helper that takes the expected output on stdin

	check_branches <<-\EOF
	main
	mid
	tip
	EOF

> +	test_must_fail git -C repo rev-parse --verify refs/heads/lower &&
> +	git -C repo rev-parse --verify refs/heads/mid &&
> +	test_must_fail git -C repo rev-parse mid@{upstream} &&
> +	echo mid >expect &&
> +	git -C repo rev-parse --abbrev-ref tip@{upstream} >actual &&
> +	test_cmp expect actual

I'd check the config settings here as suggested for the test above. The 
test coverage looks good, there are just a few places where a comment 
would help explain what's going on and some places where we can save a 
few commands.

Thanks

Phillip

> +'
> +
>   test_done

