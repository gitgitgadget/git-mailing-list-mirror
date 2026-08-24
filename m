Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792033F0A85
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562826; cv=none; b=TFn6QjpXfxIqL0RdIIa5Ze1XqWcmFRlMa6BWJyyqBBH7SglMncDehlnys9gBRo//+3mUas8a6W0MrwZShNnSlm66PVEII+9NUQrGOmPFUAWY4DOEgQO9bNyZIbYt1iXRUz62bQEbDmfBv6vDAGGw+6a14lro2UP/uQNdg16pCFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562826; c=relaxed/simple;
	bh=6Yr8YJQImPGZeIO65d9P0mA/QV+/Z/6G5IEq1734ljc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=t+YGDOH1q8f/nVgw5rp8DgiA0jYhNCiepnExDJBPv+CDGull5jX6Tb+xhRL7s0nqqOFX48yYBm/4r59n+dEmnjqSQrGumKZTHx4eGkGSJ2a4KR6OtHaILL6jGeabGBYY+2K+reb2FEzzcYJahrKfrQFQjtQK/iJ3cIQX3HKfnzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHg8UrPt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHg8UrPt"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso19829055e9.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 02:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787562823; x=1788167623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:cc
         :content-language:from:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PyySZodeWZkoSSgR/pu2jFDen8UYqBv5DJViNfgZ6VU=;
        b=jHg8UrPtL0BdPaITbXi/7MIpufOxDQWbQZwUBaGajvD0iTQoQISHouysiY54sqabdj
         nkID0ZTtFDfwy2ZW/pDsTDPU9RatlfgHN5Bp00FBX2+9rUtTv6LuRiPpVeN9coJk/K8r
         081D+QITcnKY173NEdFbyWFMUCntazo+xBdOWjxZUypxc/f1ccZsemxk846MoNee4Fmj
         IoPnmAkRV+Q8ey8AenCqubT7YqR8O8FlSOsGJ3f080vZzXCpvMAsrAqnvQT/p3YITILz
         3SXFK9RKb2TWMgLFPkCmduK3VawIkFVUvQT3KdlWTxAYiQ9Fy4JnShWr0G1fpeMe2Bb4
         6rmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787562823; x=1788167623;
        h=content-transfer-encoding:content-type:in-reply-to:cc
         :content-language:from:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PyySZodeWZkoSSgR/pu2jFDen8UYqBv5DJViNfgZ6VU=;
        b=MvP8u+W2gMUMOxajyQEPIoaeSuZZaE/Tt5kJFyOhoXAplGfL/N3py7Q0jSKE4Cs/ut
         7+PBzI6I9B3pW4ZXH4PUqBDP9ZEaZowe5old1jHyIHZZHm36f2eyOg9qmFi5BV4Nq3Pu
         lgtFydVu+hZ6s5VBbvbfBgwn6HIoQ8kuR+a65JaYrI0GjoL5aswDQlFmZ4I7ty+qKhVs
         XXMhMWm29yvIZ00pNFQJEdZTVfzpF77zInBm/UcX69fLvoTBvMq4vUUh+jTq1Uixxvgo
         BMUQ0jpftuU99oMa41YxUGlEPn5I6wWYkUBvAKjYrb/7QkA8NfrepNF7griR62zZ8Mbw
         CnpQ==
X-Forwarded-Encrypted: i=1; AHgh+RpADJ7mGRPTNmAIQveguZZ6EgLnfHyNq4oinctQILcdkNvCSmrnTtkIj/UNAxjKs+6NTmI=@vger.kernel.org
X-Gm-Message-State: AFuF++mouCl8rPyvr2sf7+3CWo0CdiwEyq9NLbUkVCjdp5w+BNsaVOue
	N1xVvFgFw9HWiNFgerwITGp2qMvm3pyBhTG0goMWu/EhZgb3aNNHVjsc
X-Gm-Gg: AR+sD10XKPX5DBqMrq2CAaC2ZSoLaU7f8dHbKfHTMblCavICPQjsbThiTD8WYIQDwf2
	lsguIIGsGyE+4r2zRiJkg3IaDBw+IKjoXCLdU9JbRdvmQPBNmBXFDZk/qdwmv3KTWvjrhXI7yC/
	3GFeufVodxI/d2MBQQiKGTa+mr27KrYLn4jcv/eT0glq73U65HLBMadVaoJqis38ImN/VHAEq9N
	lvS8yQagHYfB3OC8I1SNZCfZ5Ahcl1YkuTBj6JkaC11cYO3YtYwKnatOs4m5l4gR5J/eGaku5SD
	uuy5kwdy3pjAh/e6AlxXcSyD2i3AkbwXBvS0soNyVGf2UnsgyTvNys+UtsjB2hlbAQZJv1fwT+U
	GBStlZ9XxPvwhsj0soQWsze+65xT3UAb8UBhgVy5W+gOP8AjMHs1xXcTFYKEcZ8oeXn5lmvK328
	dx3LvQrYT9LGm+EVwWVviDEm9pCx8odg1ax2NT4c2YlaXl43IA3tjnyjneiKqt+LKBXKmbsMDtk
	yhfSIP+b7yJ2XmOi5AHS1Eci+9IQiTCNkR4oqCqmxno8fo2zWJRvw==
X-Received: by 2002:a05:600c:1d07:b0:496:c93d:e2f with SMTP id 5b1f17b1804b1-499b857fa7bmr246821155e9.15.1787562822424;
        Mon, 24 Aug 2026 02:13:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c7ccac8csm57014245e9.3.2026.08.24.02.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 02:13:41 -0700 (PDT)
Message-ID: <91feddb6-0d1b-42af-9942-307b98aa747d@gmail.com>
Date: Mon, 24 Aug 2026 10:13:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Subject: [RFC] stash: let the stash stack live in a configurable
 ref
To: Vladimir Sitnikov <sitnikov.vladimir@gmail.com>, git@vger.kernel.org
References: <CAB=Je-GRbyonmkW4qXCuMRQhWcAZE8zc_Xp32hwC1i61bNnjaw@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
In-Reply-To: <CAB=Je-GRbyonmkW4qXCuMRQhWcAZE8zc_Xp32hwC1i61bNnjaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vladimir

On 23/08/2026 15:19, Vladimir Sitnikov wrote:
> Hi,
> 
> refs/stash is shared by the main checkout and every linked worktree, so
> two worktrees push onto and pop from the same stack.  With git 2.52.0:
> 
>      git init wt-a && cd wt-a
>      git commit --allow-empty -m base
>      git worktree add ../wt-b -b b
> 
>      echo A >file-a && git add file-a
>      git stash push -m "worktree A: half-finished refactor"
> 
>      cd ../wt-b
>      echo B >file-b && git add file-b
>      git stash push -m "worktree B: unrelated fix"
>      git stash pop      # worktree B's own entry, as expected
>      git stash pop      # worktree A's entry, applied here

When I'm not trying to move changes between branches I associate a stash 
with the branch that's checked out when it is created, not the worktree 
where that the branch happens to be checked out. We already record the 
branch name when creating the stash so perhaps we should add an option 
to pop the last stash that was created on the current branch. Assuming 
agents are working on a branch rather than a detached HEAD that would 
stop them from treading on each others toes and it would mean it is 
still easy to move stashed changes between branches/worktrees when 
needed. It also makes it easy to retrieve a stash for the current branch 
that was created when the branch was checked out in a different 
worktree. If an agent really needs a private stash it can use "git stash 
create" and record the oid of the stash under "refs/worktree/".

On a related note I've been meaning to add an option to specify an 
alternative branch name when creating a stash, so that "git checkout -m" 
and "git rebase --autostash <upstream> <branch>" can record the branch 
that we're switching to, rather than the one that's currently checked 
out when creating stashes.

Thanks

Phillip

> After the second pop, wt-b holds both file-a and file-b, and wt-a has an
> empty stash and a clean tree.  Nothing warned about it, and the entry is
> gone from the stack, so wt-a has no way to find out where its changes
> went.
> 
> This is documented behavior: git-worktree(1) lists refs/bisect,
> refs/worktree and refs/rewritten as the per-worktree exceptions, and
> refs/stash is not among them.  For a human who drives one worktree at a
> time it is mostly harmless, and sharing is occasionally useful - stash
> in one worktree, apply in another, as a way to move work across
> checkouts.
> 
> What changed is who runs these commands.  Running one coding agent per
> worktree, against one repository, has become a common setup, and the
> agents stash and pop on their own schedule.  The failure above then
> turns into silent data movement between unrelated sessions.  The same
> report has already been filed against at least two such tools:
> 
>      https://github.com/github/copilot-cli/issues/1725
>      https://github.com/stablyai/orca/issues/13695
> 
> I would like to propose a configuration knob rather than a new concept,
> because most of the machinery is already in the tree:
> 
>    - refs/worktree/* is per-worktree, so a private stack has somewhere
>      to live;
>    - `git stash export --to-ref` and `git stash import` already read and
>      write a stash stack under an arbitrary ref;
>    - extensions.worktreeConfig and `git config --worktree` already give
>      a worktree its own configuration.
> 
> The missing piece is telling stash itself which ref to use.  Say
> stash.ref, defaulting to refs/stash, honored by push, save, list,
> show, pop, apply, drop, branch and clear.  A worktree that wants
> isolation then asks for it once:
> 
>      git config extensions.worktreeConfig true
>      git config --worktree stash.ref refs/worktree/stash
> 
> Nothing changes for anyone who does not set it, and the tools that
> manage worktrees for agents can set it when they create a worktree.
> 
> Alternatives I considered and rejected:
> 
>    - Making the stash per-worktree unconditionally.  It breaks the
>      stash-here-apply-there workflow, and it moves existing entries out
>      from under scripts.  If that is the destination, it belongs in
>      Documentation/BreakingChanges.adoc for Git 3.0, with a warning
>      released first - but it does not have to block a knob today.
> 
>    - Named stashes.  A name that survives a push by another process is
>      what a ref already is, so this would grow a second naming scheme
>      over the one branches and tags already use, plus commands to list
>      and delete those names.
> 
>    - Leaving it to tooling.  It works - `git stash create` writes a
>      stash commit without touching any ref, so a wrapper can store it
>      under refs/worktree/<name> and apply it later - but every tool
>      reimplements it, and the failure mode for anyone who does not is
>      silent.
> 
> Points I am not sure about, and where I would like guidance before
> writing a patch:
> 
>    - Whether stash.ref is the right name, and whether it should be
>      restricted to refs/ (rejecting a value that is not a ref name).
> 
>    - Whether `git stash list` should be able to show the other stacks -
>      a worktree's entries becoming invisible to the main checkout is the
>      cost of the knob, and `git stash list --all` over
>      worktrees/*/refs/worktree/stash might be a reasonable answer.
> 
>    - Reachability.  fsck and reflog expiry learned to iterate
>      per-worktree refs, and I would like a second opinion on whether
>      stash entries under refs/worktree/* are safe from gc in the same
>      way refs/stash entries are.
> 
> If the direction sounds reasonable, I am happy to write the patch.
> 
> Thanks,
> Vladimir Sitnikov
> 

