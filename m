Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84CA3F6613
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676056; cv=none; b=S7kxQ/77OOFTTXCqOSBfP5WyNJp8kRsdNFKhsFevAeVAvXrVSYQ6HDvc4FNe4qZyv/yyuz6tf68qx0EiId76RSZ8m6rwaQUri624QEI6iormP2fhmW2lQiXhYXfIO+rv5eAazJ+XaPi9p1M/IU3Z7XHBvg7FE7x9kRUR/7sRPE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676056; c=relaxed/simple;
	bh=O5EV19wK8Pwf5iPQ1Fgob0tFVcwBe5HTwl7PzY1Kzx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q72tUIZgjoGp1ekb2/QuCvEEwnYaFUbxDDzDBSjVj2IMpdwwGm9Akw7M4+2a2GyHrApUg5hBjS3pNAWtYX/TcrP1AxCSKGZhDr+yBzsHP4ZDaOgnmmJHbFyVDE3Z3mgI41EE6IgPjyGdMxPUmYfmmQG0S5LPvRM+IFTa/WNkDMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCDT6bma; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCDT6bma"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493ed9d8c5cso4497935e9.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 02:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783676053; x=1784280853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=coyBKYPyudT+/wsX/maonO8+ZKzfYAjfDACXR0UKexs=;
        b=RCDT6bmaYOIkeWq4qCsb2n9ZQWuOKCSEgpeL+UY5KRHwkEH+9PRTLhFEwO+LhLiUrQ
         ve+fLtHSnQyxopjUba91RyBpLa7m4iKAh3/tLie3h/jF/t9FwssaWZHNkWSLDJGpvnx5
         Q9eZAxiii8BXCK5PYqVciHinK5kFu5sMSavZYblHU2DFbBbQBTkUf561zNEfSj19RwPN
         b13A6C3th7Cdf7ezPmS4jlkK1ofufBjXAfpi3PDAmavRjTVQrOkMhxnKuJ6sQoE36oEY
         1R6tLu2brlqOxVN2stkY1iAIOyny/VnbOdP///8OVcynQrPQ80zMF6z5pg0CDhdPkWkR
         f2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783676053; x=1784280853;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=coyBKYPyudT+/wsX/maonO8+ZKzfYAjfDACXR0UKexs=;
        b=M4yzi5RI9RUIoKV5FiW7YNfj48/QBt1LUlAfUkKRuETgdL/TC0YBP9bZWw6Ld3KJxP
         /c7u89xf4v+c0ddFn0dXePVO0pml2UQ1XWGTDG0C40+aY+NCvvT2/Ho6yF3RMeg2zMwI
         h+5gYUmO+DDWynubZoDj1G/hvXpU9/aQhEbgC/qhuXKRHeboUv/F6HE7QUtGZi7hDk1R
         ldm1d+2d9nx8Dv2ZDnlrpOHU0P84Z6kl4PxtpGIqGm9foFI61uZdEKzOPYKRNz7Do0az
         oyKQTQCQQkYecMFtHwlXgu02mmzLddSeZRMyHaNFSW7RPEZEqvuDDL8fMrJWLxl4/Cle
         jPbg==
X-Forwarded-Encrypted: i=1; AHgh+RosZrxmDApfSmTxK8b17LUF6zNiP3Gy+yuYmHS6hSCDY4QMyFHo8dEAVzXVWkSeIvWBTIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy09UpoypAWL0uh3b34kVdC2j4Ah1cNQWw+AdWfWeD4W3KWCLB
	0V9t+Tmont6f5icdPucEPux+/u2RvrPTgKKN/Wa057fUlkcLazaigyXh
X-Gm-Gg: AfdE7cm+HfpsbC5mIkxeJmxeAg6smTtj2Wpb1PjoSg9+sNVa45l5eKBYHmLFIZsjrbw
	nQj2WPTa5zrKgTXzoYUdNcsc+rJ5rKHI1+UzV7yylHTwK6sxl6e03WLbNu4nJG4BeP0uGffbr0j
	VBS13oK7sue0H42plU+QmReGC0lsunpFP0gdD2hy2vWoTYOU91JgYxrefGsiU+LRnzsnEpv64rs
	9rNQFPVvkxHscaA68PVrwVG9i/QQtyJK3gPDPPjY/1qYMosKzp7JNvEYtDRoliXk03fQw4I9JAh
	sdfta/vnXQedZRXxOqTwSzX8qCHWflwkOitmrxE2ciRgPNj6zAPfW/5erw4Io0vkYZl7/B4bn/b
	Ts6if7NrdXDoi+tYk6hqcz4pH4ld19bbRRFW4gH2WOUN4XGa2Z0NGtv/dJZC0SGFOClkawyPOSI
	ogo1OaKwwSCBMQrG1wd/EjZDyX33w3XgMXQwwdp3LsFHe2aH7hnZ/bxhzWZhOw4Ri3Ivg=
X-Received: by 2002:a05:600d:8496:10b0:493:e034:a3b5 with SMTP id 5b1f17b1804b1-493e68c6eaamr80812125e9.24.1783676052851;
        Fri, 10 Jul 2026 02:34:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4f09f89sm42810075e9.10.2026.07.10.02.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 02:34:12 -0700 (PDT)
Message-ID: <0f37a01d-c39e-47b3-b8e9-48cdd42672df@gmail.com>
Date: Fri, 10 Jul 2026 10:34:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 0/3] worktree: add post-worktree-add and
 post-worktree-remove hooks
To: domen@cachix.org, git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Caleb White <cdwhite3@pm.me>, Junio C Hamano <gitster@pobox.com>
References: <7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe@mtasv.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe@mtasv.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Domen

On 10/07/2026 00:36, Domen Kožar wrote:
> 
> Today there is no reliable trigger to set that up when a worktree
> appears: post-checkout does not fire for --no-checkout or --orphan
> and cannot be told apart from a plain checkout. Nothing at all fires
> when a worktree goes away, so stale databases and services pile up
> after "git worktree remove" or a manual rm followed by "git worktree
> prune". Wrapping the worktree commands only helps when every tool,
> human or agent, goes through the wrapper.

I agree a hook that's run after the worktree is added is useful (I have 
a patch for it that I've never got round to cleaning up and sending so 
thank you for working on this). It is useful for copying across 
untracked files to the new worktree like "config.mak".

> Patch 1 adds a post-worktree-add hook that fires after the working
> tree is fully set up. Patch 2 adds post-worktree-remove for "git
> worktree remove". Patch 3 extends it to "git worktree prune" so that
> manually deleted worktrees are also observed.

I don't have a strong opinion on a hook running when a worktree is 
removed - an IDE that cares about that could set up a filesystem watch 
on the directory but I guess adding a hook doesn't do any harm.
> Two design points I would especially appreciate feedback on:
> 
>   * post-worktree-add runs after post-checkout and is skipped when
>     post-checkout fails. An argument could be made that it should run
>     whenever the worktree was created, regardless of the earlier
>     hook's exit status, since tooling registering worktrees would
>     otherwise miss one that does exist.

Looking at the existing code, if the checkout fails then we remove the 
worktree because "is_junk == 1" when remove_junk() is called via 
atexit() so I think it is correct to skip the new hook in that case.

The new hook is run after the checkout, but before the post-checkout 
hook - we should document their relative order. I see the hook is run in 
the new worktree and passed the absolute directory and worktree id. I'm 
wondering if either of those is useful if we're running the hook in the 
new worktree.

>   * for entries pruned because their gitdir file points to a location
>     that no longer exists, the hook receives the recorded path; when
>     the path cannot be determined at all (missing or corrupt gitdir
>     file) it receives an empty string.

So the hook knows a worktree was removed but not which one?

Thanks

Phillip

> Thanks,
> Domen
> 
> Domen Kožar (3):
>    worktree: add post-worktree-add hook
>    worktree: add post-worktree-remove hook
>    worktree: run post-worktree-remove hook when pruning
> 
>   Documentation/githooks.adoc |  41 +++++++++++++
>   builtin/worktree.c          |  73 ++++++++++++++++++-----
>   t/t2400-worktree-add.sh     | 113 ++++++++++++++++++++++++++++++++++++
>   t/t2401-worktree-prune.sh   |  88 ++++++++++++++++++++++++++++
>   t/t2403-worktree-move.sh    |  44 ++++++++++++++
>   worktree.c                  |   1 -
>   worktree.h                  |   6 +-
>   7 files changed, 347 insertions(+), 19 deletions(-)
> 
> 
> base-commit: f85a7e662054a7b0d9070e432508831afa214b47

