Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C623DD536
	for <git@vger.kernel.org>; Fri,  1 May 2026 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777653769; cv=none; b=L52VIiEaXbGFkP7Jw5fonG2Jeg8AArw0SVzsIDVSu19Z8cpMqrca8VfngRo59oadvJBPPJyV3sJ0uqwpnSFLDM8x8ZUPiBzMknVrk4iagMaHkad2eHfqc5Ej6HI0w9Wf9mDQk0ny1PLzH8iWmUcnVDmTBEQCtPf1FBlzHGLUxEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777653769; c=relaxed/simple;
	bh=xv4Fpk62GYrxaKQHjhcAAWbsdbSiJoS6haYtQskY83w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGN0sRrBdjaE11H6b7f5dgwdt+G8LqTGYSIcCZt/kZUoglTLcQ3U6rogRi4GCJwvV+ZOoHnyBNoG9eVz7srM/SQEP/8ZDTHHPfpAAMTn9hYwe4L1w5+22uck92NwJSllzSVvf7g3bN/IKcKPCUjy4JzpzfuvmCOwBNEdTfGi6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8PCcgGt; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8PCcgGt"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d65f4073bfso274058185a.3
        for <git@vger.kernel.org>; Fri, 01 May 2026 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777653761; x=1778258561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xv4Fpk62GYrxaKQHjhcAAWbsdbSiJoS6haYtQskY83w=;
        b=k8PCcgGtNIKPTwuq1lfLHi8l53JzUkdRFx+UNJ4bRqIOGq07mJaH1UTvtpFmmoBdC5
         lb9usOp9rGhYMKoivD1Xs1qYsh+EHjiJm2jDZe0Maxholi3mOyzuFk/Q0lQ76im1CrPj
         QQStrV0L19if+GwQX2Tr8Nsd+CQs87Yk2P1Zvb1pdvrj6ZEK6ylc8/NuUkaqEvUtkFkJ
         xJINbCJD7G24O2ya09GtPzFOZwkqUH/kwyp7M5WHX8S17RnVww4+gG/MWCTSzwkC2akS
         5yA/cm4TiTh63Yge6G5/zAoAwxbNzSXtDZMSPKODW86llrol5qNXkyF3SimZI6FM90yS
         kDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777653761; x=1778258561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xv4Fpk62GYrxaKQHjhcAAWbsdbSiJoS6haYtQskY83w=;
        b=jMU4/X1e2Gnrh5dsfSr9toG/a2Gw/7iXqtxKFAPy6LpSp1YNXV3RYMFkgh06eDKnXz
         8IYJcBgigdG51JQqOg/szIi3ibJJYcMqmjqQtyWRh7dlTUL0ZOHxUuLypWHLUmxkz9nG
         0Gug9qg81E25O0ajcqc63wctjmZBavaXCDkcmuE1itAtH8DJyJXdaXaQhTIR0gtYA2EX
         JnOfPwyLlgo68fUwdqOVkDcHWRUxqa9TebfN1Lwz+npJSQuE4hPI1u3xtQA+cvO9biug
         t7kHh9FkCl73J83BXxRQkSMG0zjvm1HSIrSp7Ub/+H1K2EAGyCIl0ylfCZdeGhOnORF8
         vIQg==
X-Gm-Message-State: AOJu0YzzholbPipsKNTKTXOHV/qGXdugfU2dKWb1FoETK7Yu3+8bds0a
	cPhGBXAfzeAzONf4yI/hWXZuGI94GKkUDne1bT65ShmyJF4EqAA49GJKMN/dqNTb
X-Gm-Gg: AeBDievsSIAd3M83AtDu+m759KX1s8djJbCjIdeYuuF2AE/TZIQN+IzGTzfscilsJXs
	75XHI7t5y9pfn3MHldV8AyQ+XSjvhV2vwjBEQQWs5fcmIGJ2xLCEuxNFhwafIFF9V1UZSvvVN8P
	AhgGc1RMASL/NxACeRNtK7bD9INlrSFQ3sq0rb7Z0+aAjDRaHcWsbCboPhg3pUK2cFrxtOXgbtk
	6+drsvxyxKOmPt7NZOL53nB3TvjZoEU75qEZQCKl/MkxoE8/CyaSFiFqFT64Rbjzt9hsVj5yr7g
	Zk5/nLZ0BzgFN+H6LHHwjkjphLP46Pco+vjiuc0jxJHYlaOO4lK9hW+wXGLNuJkJBf91FCtrQg9
	G1NnEPjv8GMkjLDhiJ7VT0ZZs/+FseFgzUF0VQFeio6sBDhI3T1wKNbfpeagn6GxcYeYLbEc2Vw
	CpN1cmGIqasPT9UpcwgjJ8+6fOHDNx/dxXn0iUszrBT3SMI/6bnubSUPw=
X-Received: by 2002:a05:620a:199c:b0:8ed:d906:a8ff with SMTP id af79cd13be357-8fd160c960amr23940585a.14.1777653761046;
        Fri, 01 May 2026 09:42:41 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100::59a? ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29a80784sm210796885a.12.2026.05.01.09.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 09:42:40 -0700 (PDT)
Message-ID: <a1a7237c-ffed-4a7a-ae58-55769aaa4453@gmail.com>
Date: Fri, 1 May 2026 12:42:39 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] git-gui: handle missing worktree and separated
 gitdir
To: Johannes Sixt <j6t@kdbg.org>, Shroom Moo <egg_mushroomcow@foxmail.com>
Cc: git@vger.kernel.org
References: <tencent_AEE968E8E785907BA55A383977C8968ED406@qq.com>
 <tencent_8A236D9D4A8D8CCA7DAA083157AA8543700A@qq.com>
 <3b0b37ed-1a5d-4fe1-b2b4-7db67a62a06d@gmail.com>
 <77219c75-7968-413f-a642-0446145c8023@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <77219c75-7968-413f-a642-0446145c8023@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/1/26 9:13 AM, Johannes Sixt wrote:
> Am 30.04.26 um 18:18 schrieb Mark Levedahl:
>>
>> On 4/30/26 6:02 AM, Shroom Moo wrote:
>> We have quite a bit of code that attempts to make Git GUI work from the
> .git directory and also in bare repositories.
>
> 87cd09f43e56 ("git-gui: work from the .git dir", 2010-01-23) made the
> first step. The original code just used the $_gitdir as the working
> directory. However, at that time we did not have alternate worktrees,
> and the old code, when used today, does not work in a `git
> worktree`-created worktree. Later, the `git rev-parse --show-toplevel`
> call came with 38ec8d3e2652 ("git-gui: correct assignment of work-tree",
> 2010-10-20). However, it also changes the fall-back code slightly, so
> that running Git GUI from the .git directory would not work the same way
> as before and takes the .git directory as the work tree (because in the
> .git directory --show-cdup is not "..", but empty).
>
> I think we need to restructure the existing flow a bit and not just fix
> a single spot in the code. I suggest this order of operation:
>
> 1. Handle the bare repository case. If not enabled, fail. Otherwise, we
> can work with an empty $_gitworktree.
>
> 2. Collect --show-toplevel into $_gitworktree.
>
> 2a. If this failed: If --is-inside-git-dir is true, and the last
> $_gitdir directory component is exactly ".git", take the parent
> repository as $_gitworktree. Otherwise, fail.
>
> 3. Handle all the other edge cases, if any, with the so determined
> $_gitworktree. (I didn't think through, yet, what needs to be done.)
>
> -- Hannes
>

I found one horrid edge case: 

Start git-gui in a gitdir not embedded in a worktree, with core.bare=false as there are
one or more gitfile and/or symlinked worktrees elsewhere.
- current git-gui aborts with an uncaught error. Good.
- git-gui with the wrapped --show-toplevel call finds no worktree to switch to, so runs in
the gitdir allowing commits of the gitdir items.
-  I just added and  committed the *file* refs/heads/master to branch master in such a gitdir.

git-gui's normal gui must be started ONLY if rev-parse --is-inside-work-tree is true. (The
blame view invoked by gitk in theory could be allowed to run in a bare repository
read-only mode.).

For read/write mode:
if --is-inside-git-dir == true at startup, we must abort, or find a valid worktree and
switch to that.

My personal preference is for git-gui to abort:
   I started git-gui where it cannot run. 
   My error. Let me learn and fix that.

Alternatively, ask me what to do:
    e.g., prepare a dialog after looking at git-worktree list, and the parent dir IFF this
dir is named .git, telling me of my mistake and offering me one or more worktrees to
switch to.

But please, don't just switch to another directory without asking. This is just
encouraging me to make careless errors.

Mark

