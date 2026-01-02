Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E5C8CE
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367129; cv=none; b=EGUDIphzci7nobOV1qb+wfXjz8nKKB29eXN6BUp9YLBBeR/mg3c1FmrDTNW/1SeBsw3XoOUtw8JuFhMV975pgOcv++/eEpmFPWKIIEKFxmJGg3etjw+1CEUdrjh/0rAq2tXRXmS2uyFyde/4Ebg51VnTgGraD6c618kaECZC20w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367129; c=relaxed/simple;
	bh=+zd71ilJAW+1F5MolzCtMYt2iDFs8RpfLUTagWJt4l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DlaiZHjgN0mPrc8mL4J4mwC2Kbveh5kGWGIynKTJUAKgScWZi/XevDHbq+mdzbkIEOW5RlORAR96IBek8vAfji1Ji1rhD1O04tQ1LKMAbpHeaFncjrA0FUzsoojPPl6EhE/jjtuneE4EPAozI3PTfIEJgWAg/YgANvAl6a3EgK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuYJOVgX; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuYJOVgX"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so9830738f8f.3
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 07:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767367126; x=1767971926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SuR2o/XQ/5hsO75+wE5dSU8GTZdi8IrqozGAb8oglJE=;
        b=TuYJOVgXD9VIWrV7866WckagzE+RR9dl22hlCqvrl6B53nbRR/YMAj8yMeTWeXHGF1
         8KCWQFLOiZxq+SvEzjP/We48VdYZvohl1jeBekH93YtqVrGi0XA7+QrWhgkS7VD+6RZu
         bp54SiGJPZQWarBRSB9MLIKJZ/pA6yFMdoHldgRAIAx4B4OuunsvXK+iPWJ2fPecInwN
         3+/2jFgHGMvJaD8Qk+7wmvltFLZcGNr1j++2cEc16bq67k80ZDaBk5q9H+wrPsIVK6IW
         6tkVTSMbgct8axBUwPTzrKC1awbWRdyVatIJ1pWP9Nu95CaWFUr21stT/6sqR4m2C98N
         +XXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767367126; x=1767971926;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuR2o/XQ/5hsO75+wE5dSU8GTZdi8IrqozGAb8oglJE=;
        b=PTR0Pst+lbmH/HRG6awxOXnSYrOUH2Vk5S8VfBgZOgRNq4fwI8FOSkAFls7ddnOVhm
         070HDcDF6IgQ7xSIPsmWxCFyhHjLed/pWsC2zsYROxB86SCrNoCQ8SLo4GQDaczV+AN3
         C0pJtAQ1201ZjdRBI3gX+FTqOUCbkVeuaejbYNKo8vq/AvTsMGObLVCAp9HtUkBQyT4C
         OElYo6VTwFwfPYGibqMWbYpmM2V1rBQi4p98Q7kv5+wzD+0u1xuD3IzAw3cjnksKaje7
         zqwqaE6RIgAIrzAke3SMi9/cRUv5N4YM2NiYjDk2+zA8K3o86FqbK+7HJNoWW5HjYM2/
         iStg==
X-Forwarded-Encrypted: i=1; AJvYcCVYsme7YPwkqCUsfP4t3Lkg6VAtKphv2m6BoZ96X3/LXBiCggR4j2C4W/xxBaLx8bZx55g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQdOApivHA01LiWq6ge84S+SiFBw/M5hkfml5OX6QKmpDPQjbI
	LQ0HHXjCPrI8+iSsmiXP30di8/5kKFgfyq9jDVZ/4y/yHecFOhFs05De
X-Gm-Gg: AY/fxX6hBmdvFWYHmRLYnn3BH0cOKgz40WedNEYqRfLjDodfDbk/AgaHBIETQLaGg6/
	JJyP86/1Lz2jlfuW17wD6uxV+rMtjxVjpvG33SYBb/DdSHbOXtoOoYWXHM4GhauoZAowtAC48Xj
	iAII8h7lCfFNg9z3NNZ/P35ax/xWqJ2gn6zKjiFyPKFOfuAFOPD/fthFpyqyaROknmQOoXMDCZ6
	exJtcExa9cfJutpyPU7J3En3hyYZJhQUddXAOMU62KtAqgR2IPsH6mD1pDiyJonyT4tWVM33jGv
	bRhQ8ib8CRoKFwzbQdBblNq2Gkgh6a2JMTyyzCGJFuEkldipYyz+4Pr/5QoRPWan+SqtS7vfyJU
	nlG7OficE0Waeo+bLIy98Zusj6PVjFgWnqs7APQhBWCsQIXvmHlR+gqwvwshRoC8vKQiWwnrCQ9
	97Bfw2+FgUFaHtyUYMTH0OpyD0r+Ben7jiFp2UeuhsUtcOqiw48qKl8crsRtIcODbnrg==
X-Google-Smtp-Source: AGHT+IGgT0AST0//DjiF90XiY7sj1vK+wEtU6yJMBcXHN9QCNFaybx9oZtWKN0y2gcXt5kWxus4CVQ==
X-Received: by 2002:a05:6000:26cf:b0:42f:ba58:6599 with SMTP id ffacd0b85a97d-4324e4fd943mr51599050f8f.35.1767367125380;
        Fri, 02 Jan 2026 07:18:45 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa08d9sm85194284f8f.30.2026.01.02.07.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 07:18:44 -0800 (PST)
Message-ID: <6526c419-c60c-49d2-9c1a-52be7aca82f0@gmail.com>
Date: Fri, 2 Jan 2026 15:18:43 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v11] status: show comparison with push remote tracking
 branch
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.2138.v10.git.git.1767110888.gitgitgadget@gmail.com>
 <pull.2138.v11.git.git.1767352663477.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2138.v11.git.git.1767352663477.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 02/01/2026 11:17, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> "git status" on a branch that follows a remote branch compares
> commits on the current branch and the remote-tracking branch it
> builds upon, to show "ahead", "behind", or "diverged" status.
> 
> When working on a feature branch that tracks a remote feature branch,
> but you also want to track progress relative to the push remote's
> tracking branch (which may differ from the upstream branch), git status
> now shows an additional comparison.

This is great and it is really good that it is now using the default 
push destination rather than a custom config key.

> When a push remote is configured (via branch.<name>.pushRemote or
> remote.pushDefault) git status shows both the comparison with the
> upstream tracking branch (as before) and an additional comparison with
> the push remote's tracking branch, if it differs from the upstream
> tracking branch.

Looking at the tests, it seems that the extra information is shown 
whenever the upstream branch differs from the default push destination 
even if they are on the same remote. I think that is sensible but this 
paragraph should be updated to reflect the fact that one does not need 
to set either of the "pushDefault" config settings to benefit from this.

> The push branch comparison appears on a separate
> line after the upstream branch status, using the same format:
> - "Ahead of 'origin/feature' by N commits" when purely ahead
> - "Behind 'origin/feature' by N commits" when purely behind
> - "Diverged from 'origin/feature' by N commits" when diverged

I'm wondering why we don't reuse the existing messages - I don't see how 
using a different wording for the push destination compared to the 
upstream branch benefits the user. We should adjust the hints that are 
shown so that we only recommend pulling from the upstream branch and 
only recommend pushing to the default push destination but the 
comparisons should be the same. Also I don't find the message "Diverged 
from 'origin/feature' by N commits' very helpful, I'd find it more 
useful if it gave the ahead/behind count like we do for the upstream branch.

> Example output when tracking upstream/main with pushRemote set to origin:
>      On branch feature
>      Your branch is ahead of 'upstream/main' by 2 commits.
>        (use "git pull" if you want to integrate the remote branch with yours)

Is this a typo? - why are we recommending "git pull" when our branch is 
ahead of the upstream branch?

>      Ahead of 'origin/feature' by 5 commits.

It would be nice to have a hint suggesting the user runs "git push" here.

> The comparison is only shown when a push remote is configured and the
> push remote's tracking branch differs from the upstream tracking branch.

Looking at the tests, only the second half of that sentence appears to 
be true.

> diff --git a/remote.c b/remote.c
> index 59b3715120..2317725f7d 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2237,6 +2237,81 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
>   	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
>   }
>   
> +static char *get_remote_push_branch(struct branch *branch, char **full_ref_out)
> +{
> +	const char *push_remote;
> +	const char *resolved;
> +	int flag;
> +	struct strbuf ref_buf = STRBUF_INIT;
> +	char *ret = NULL;
> +
> +	if (!branch)
> +		return NULL;
> +
> +	push_remote = pushremote_for_branch(branch, NULL);
> +	if (!push_remote)
> +		return NULL;
> +
> +	strbuf_addf(&ref_buf, "refs/remotes/%s/%s", push_remote, branch->name);

Shouldn't we be taking account of the push and fetch refspecs here? 
There is no guarantee that $branch maps to refs/remotes/$remote/$branch. 
To take a silly example, if we have

     remote.$remote.fetch = 
refs/heads/$branch:refs/remotes/$remote/abc-$branch
     remote.$remote.pull = refs/heads/$branch:refs/heads/xyz-$branch

Then we should be using "refs/remotes/$remote/abc-xyz-$branch" in the 
message above as "$branch" will be pushed to "xyz-$branch" on the remote 
which is fetched to "$remote/abc-xyz-$branch"

> +
> +	resolved = refs_resolve_ref_unsafe(
> +		get_main_ref_store(the_repository),
> +		ref_buf.buf,
> +		RESOLVE_REF_READING,
> +		NULL, &flag);

As we don't use flag we can pass NULL - see the documentation for this 
function in refs.h

> +static void format_push_branch_comparison(struct strbuf *sb,
> +					     const char *branch_refname,
> +					     const char *push_full,
> +					     const char *push_short,
> +					     enum ahead_behind_flags abf)
> +{
> +	int push_ahead = 0, push_behind = 0;
> +	int stat_result;
> +
> +	stat_result = stat_branch_pair(branch_refname, push_full,
> +				       &push_ahead, &push_behind, abf);
> +	if (stat_result < 0)
> +		return;
> +
> +	strbuf_addstr(sb, "\n");

As I said above it would be nice if we could use the existing messages 
here. Can we have a separate preparatory patch that refactors 
fromat_tracking_info() so that we can use the same messages for the 
upstream branch and the default push destination?

> @@ -2311,6 +2387,19 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>   			strbuf_addstr(sb,
>   				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
>   	}
> +
> +	if (!upstream_is_gone && sti >= 0 && abf != AHEAD_BEHIND_QUICK) {

Why do we handle AHEAD_BEHIND_QUICK differently to the upstream branch? 
Surely it would be useful to tell the user whether the branch is up to 
date with the default push destination or not?

> diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
> index 0b719bbae6..f27ae719ad 100755
> --- a/t/t6040-tracking-info.sh
> +++ b/t/t6040-tracking-info.sh
> [...]
> +test_expect_success 'status shows ahead of both origin/main and feature branch' '
> +	(
> +		cd test &&
> +		git checkout -b feature2 origin/main &&
> +		git push origin HEAD &&
> +		advance work &&
> +		git status >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch feature2
> +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
> +	  (use "git push" to publish your local commits)

Why are we still suggesting pushing to the upstream branch when we know 
the user is pushing to a different remote branch?

> +	Ahead of ${SQ}origin/feature2${SQ} by 1 commit.

Why aren't we suggesting to use "git push" here?

Thanks for working on this. With a few tweaks it will be a really useful 
improvement to "git status"

Phillip

> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'checkout shows ahead of both origin/main and feature branch' '
> +	(
> +		cd test &&
> +		git checkout feature2 >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
> +	  (use "git push" to publish your local commits)
> +
> +	Ahead of ${SQ}origin/feature2${SQ} by 1 commit.
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'setup for ahead of tracked but diverged from main' '
> +	(
> +		cd test &&
> +		git checkout -b feature4 origin/main &&
> +		advance work1 &&
> +		git checkout origin/main &&
> +		advance work2 &&
> +		git push origin HEAD:main &&
> +		git checkout feature4 &&
> +		advance work3
> +	)
> +'
> +
> +test_expect_success 'status shows diverged from origin/main and ahead of feature branch' '
> +	(
> +		cd test &&
> +		git checkout feature4 &&
> +		git branch --set-upstream-to origin/main &&
> +		git push origin HEAD &&
> +		advance work &&
> +		git status >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch feature4
> +	Your branch and ${SQ}origin/main${SQ} have diverged,
> +	and have 3 and 1 different commits each, respectively.
> +	  (use "git pull" if you want to integrate the remote branch with yours)
> +
> +	Ahead of ${SQ}origin/feature4${SQ} by 1 commit.
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'setup upstream remote' '
> +	(
> +		cd test &&
> +		git remote add upstream ../. &&
> +		git fetch upstream &&
> +		git config remote.pushDefault origin
> +	)
> +'
> +
> +test_expect_success 'status with upstream remote and push.default set to origin' '
> +	(
> +		cd test &&
> +		git checkout -b feature5 upstream/main &&
> +		git push origin &&
> +		advance work &&
> +		git status >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch feature5
> +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
> +	  (use "git push" to publish your local commits)
> +
> +	Ahead of ${SQ}origin/feature5${SQ} by 1 commit.
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'status with upstream remote and push.default set to origin and diverged' '
> +	(
> +		cd test &&
> +		git checkout -b feature6 upstream/main &&
> +		advance work &&
> +		git push origin &&
> +		git reset --hard upstream/main &&
> +		advance work &&
> +		git status >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch feature6
> +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
> +	  (use "git push" to publish your local commits)
> +
> +	Diverged from ${SQ}origin/feature6${SQ} by 2 commits.
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'status with upstream remote and push branch up to date' '
> +	(
> +		cd test &&
> +		git checkout -b feature7 upstream/main &&
> +		git push origin &&
> +		git status >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch feature7
> +	Your branch is up to date with ${SQ}upstream/main${SQ}.
> +
> +	Your branch is up to date with ${SQ}origin/feature7${SQ}.
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'checkout shows push branch up to date' '
> +	(
> +		cd test &&
> +		git checkout feature7 >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	Your branch is up to date with ${SQ}upstream/main${SQ}.
> +
> +	Your branch is up to date with ${SQ}origin/feature7${SQ}.
> +	EOF
> +	test_cmp expect actual
> +'
> +
>   test_done
> 
> base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe

