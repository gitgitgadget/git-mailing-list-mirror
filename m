Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF003BB21
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820287; cv=none; b=Bu1QUwM2GmLyI7M2645F1O8SIicpIwe3A7gC6AfLPjExp05M6Bb0xNVlfBGdNMbLGEsPE9VBsPpkX/Zp8dtoxiI7cpmA4uqJscQ8dwDAyhDCXPSy8YGT4BJei87rTsM11dox6d+U0o6QexGxxygN2xznLwQ/Rt4QE1mmsl9SRWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820287; c=relaxed/simple;
	bh=OIi/H0u3Q5YApLcJmebcGMu+MF4kXFoL5y30DV6UOxg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=X6wc2PeRYhNab3ecq2oRnLeAQP8CsuRAXNtMv+Y0BogML3lMMZOYuLFZ1cdO3CNfzp+R+som27XF12M2Ef3PhJE3L6TaENxpbEwfSigI2drVnJA8yca8Mz+fHAKHV471sM3ZqKiMerCNpsuYYOfYKPBtpGHwG+E1ub3Le+mFKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alA1iwij; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alA1iwij"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43161c0068bso47474765e9.1
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 07:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730820284; x=1731425084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=93di6k2m2J36cDUuCR3MAbIfcTFEnaWO9UOPlXF96QA=;
        b=alA1iwij+f/IV4wGnpxfxRvQrcBWXmKT4xm7/ZmfCm6Tb3Id3Wjbot/CjjnOl+Nd03
         OzgJMltykz00tjZcueeQ/dZfCtlKDrZUENqb49yFxxmKWzOHe/Dd3C5CAsv8mUiBgl43
         oJ2QWZv1TdcuASsCKeesqKtXSTyHLMak6ZIyhi1//+89b/YU8gySLwJ5TyXewT7FmDks
         jeihE6hXj6VItriQo2ebQjDV1ByuXV2sWdFX3IRZEwQoQM/Cy6DOSSBEdx2Eb7yf0kKL
         vZ1t21WFE+ss7HHymtC31V2uqJ1X517M8GuYWuSOKBBOBWzE9y53lAa/AbdmJ9gFSlP1
         I19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730820284; x=1731425084;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=93di6k2m2J36cDUuCR3MAbIfcTFEnaWO9UOPlXF96QA=;
        b=McN3QWBYqXUscANVZYEpZRPnkghQ2LfQAxeRZowBSRyANOKMifFowyZ1OE0nvJKoGr
         UBVfdq7z+Y5MwTweehX8TE+6u90iCKR+8MxhBE1tdTE7R8oJU0nYoLhI2Z53RmXbmX3m
         utJ/+O9Z1L4LJrlS/OJ5JZolZDckUJu1+AURQDLCe2q+q2eEinn0G9RkdOFDj51yn+cZ
         +mqJfWS7SYscE9ZqB7l4Fo9KJ0hYGhFc+8KDkl1Lc/wZYQ+puyyLcQN1RVZNcCG/+eHA
         DIk/qSi39J100a6L/JVFw82wHTilBF/3ggZRtooRmY6bSrK0ZwBLsyWvz9U5iBEi+qOj
         sT2w==
X-Forwarded-Encrypted: i=1; AJvYcCV9bk+hJ1PjTBqqVX9LI6SVgCcxFy/S3f4TSNHGG9FTjc9w7Yb05JkEApSHtB+m2+GwTpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5dNmETPZoPAZexEWKW4xLWV3Fpns9AqrSvVqcHYBZssfAM+mE
	1ABfKep/NBCH4K3kQfaivrutUrwMn4Db2AzuWoaIsRg2Veu9XVgw
X-Google-Smtp-Source: AGHT+IHW66mFFkwcrCsC5ylj3+ZB4/l+2P2BZmiwPjN4TS3+cDzR5g9sn6GCeFf9DRP6nEOopSmpug==
X-Received: by 2002:a5d:5f43:0:b0:37c:d20d:447c with SMTP id ffacd0b85a97d-381c7a6c758mr15220065f8f.29.1730820282970;
        Tue, 05 Nov 2024 07:24:42 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158? ([2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7d2bsm16466140f8f.16.2024.11.05.07.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 07:24:41 -0800 (PST)
Message-ID: <743043bf-60b7-4ed7-8cf2-4f3f972968a6@gmail.com>
Date: Tue, 5 Nov 2024 15:24:42 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git rebase exec make -C in worktree confuses repo root dir
To: Eric Sunshine <sunshine@sunshineco.com>, phillip.wood@dunelm.org.uk
Cc: David Moberg <kaddkaka@gmail.com>, Taylor Blau <me@ttaylorr.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>, Elijah Newren
 <newren@gmail.com>, David Moberg <kaddkaka@gmail.com>
References: <CAL2+Miudq0UXAb=R24v+ftZVkHy2We1CFsFAt__tCYMWtCfOow@mail.gmail.com>
 <Zw2K5xJAOGWitfXr@nand.local>
 <CAPig+cQZoO8tMZ1Gip-at8-9n_tk4axctkX=WbaO1==JRru39A@mail.gmail.com>
 <CAL2+MivOu=_HYg+2KoMKMUtz+=q2jv-K9u9Zxrhe3OuHLCmwFA@mail.gmail.com>
 <CAPig+cQ6=HDD447xTHQ84hmsF3SMbC5nH_PXf3rZWvTWmp18ug@mail.gmail.com>
 <1dc91aa7-04da-4023-bbd5-5b12539477ba@gmail.com>
 <CAPig+cQmGXxDshTovdAYaZn5UMr3nvXHyH0q2HvAbaT_fhhiLQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPig+cQmGXxDshTovdAYaZn5UMr3nvXHyH0q2HvAbaT_fhhiLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/10/2024 22:12, Eric Sunshine wrote:
> On Wed, Oct 16, 2024 at 5:15 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 15/10/2024 21:01, Eric Sunshine wrote:
>>>> Den tis 15 okt. 2024 kl 09:11 skrev Eric Sunshine <sunshine@sunshineco.com>:
>>>>> This looks like unintentional behavior; probably a bug. It seems to be
>>>>> triggered by `git rebase -i` setting GIT_DIR. [...]
>>>>>       % git -C dir rev-parse --show-toplevel
>>>>>       /.../bar
>>>>>       % GIT_DIR=../../foo/.git/worktrees/bar \
>>>>>           git -C dir rev-parse --show-toplevel
>>>>>       /.../bar/dir
>>>>>
>>>>> The `git rev-parse --show-toplevel` invocation with GIT_DIR set is
>>>>> incorrectly returning `/.../bar/dir` rather than `/.../bar`.
>>
>> I'm about to go off the list until the 29th so I wont be working on it
>> soon either but I think the problem is that git sets $GIT_DIR when it is
>> run from a linked worktree. I've reproduced the commit message from
>> ff5b7913f0a (sequencer, stash: fix running from worktree subdir,
>> 2022-01-26) below which I think explains the problem we're seeing here.
>> Unfortunately the approach of setting $GIT_WORK_TREE used in that commit
>> won't work for exec commands as they may be run in a different worktree.
> 
> Maybe. Maybe not. exec'ing a command in a worktree other than the
> current worktree may be a "don't do it if it hurts" situation. The
> same shortcoming you describe would crop up when exec'ing a command in
> a foreign repository from the one in which `git rebase -i` is being
> run. If we look at it that way ("don't do it if it hurts"), then
> perhaps a documentation update is warranted; something along the lines
> [1] which gives explains that GIT_* environment variables should be
> cleared by a Git hook if it needs to peek into a foreign repository or
> other worktree. It's not a perfectly satisfactory answer, but would at
> least (somewhat?) allay your concern about `git rebase -i` setting
> GIT_WORK_TREE automatically.

That's certainly the simplest way forward. Until 434e0636db1 (sequencer: 
do not export GIT_DIR and GIT_WORK_TREE for 'exec', 2021-12-04)
we set both GIT_DIR and GIT_WORK_TREE when running an exec command. As 
the message for that commit explains that behavior did not match the 
scripted rebase which was the motivation to stop doing it. Unfortunately 
that left us in the situation where git will sometimes set GIT_DIR when 
the user has not. Ideally I'd like to understand why we're setting 
GIT_DIR in setup_git_dir() when, at least at fist sight, it seems to be 
unnecessary. I think that would take some time so maybe we should just 
go back to setting GIT_DIR and GIT_WORK_TREE in the sequencer when 
running "exec" commands.

Best Wishes

Phillip

> [1]: https://lore.kernel.org/git/pull.1457.git.1673171924727.gitgitgadget@gmail.com/

