Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35556DF49
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743776028; cv=none; b=oLgO6EDLfLJqfpI6Xq3XXS57JtbzFh6PhhGMekUpqlYf9TiViwI8dBSOXpeGYY5Cawz5OFpwrCOYK6U9dCps2xh2Dqwsthe1nl6P0l9sNCwRkoP8mOpjCHq7IQxxhuxl2DF2fMAmi+Sp+UWB0XWoLCllsAKig+bo4jMHqKxP0Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743776028; c=relaxed/simple;
	bh=TQqWQwDJH3fnKGtJ3M5NF5G57RbZaCpoq32qvQozUNc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=A4cIE6Smtn5ZptLKvviFriKYLQ5s9wybquqxnBL2CZxQ1amk0AScnHHGxdhZtyUDYiTA4DwmXYhGfHdj1PFNf0QamJ13yg4PGi9APbu8CQYP0rMqqaJUPU/tC51JNSROmBzYMONXdlXV1d0JYXyjR6TBQcjxqsk6vioVSDmGO2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdUMAJrW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdUMAJrW"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43edb40f357so2448535e9.0
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 07:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743776023; x=1744380823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yC+4Xih+xHGmqLJkFGT3pSP6dRNttv0FviMHoHQehzY=;
        b=RdUMAJrWX4dPVoVStTWwMbd74JJtHBUgRJfvhGF0ekOAROphfHVf1I57FCrmh6xR/z
         c6G7P/gNxKpu9V/qUyK9ryqbOqYFasZb93sMzz0Lq8zd5o4G1jRdr4uSTPe9VW4xxj3S
         gkz0foK9ngZhQsV+iH/tcbHjVr+Zks6dcH+eNLuCQcIYTHdMJxljbPU1PzFgJr374AXE
         Ft2NfVd5ndm3KXCgL5cPe592WAf4PjDiidwqWO5dW3gEsKGKpbOAWUuZr1cDdrgNv2Z6
         0Dvm5TvwFBCi1q6PIUggdkG4SXYl1BngM0dN/b1vL8SxSE8rtBXZe0VNVN/Jr8TcyHUx
         TU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743776023; x=1744380823;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yC+4Xih+xHGmqLJkFGT3pSP6dRNttv0FviMHoHQehzY=;
        b=r8Gc4uBV8Eozmi7zHs+WN9LQRxPic2+ze5Xy8TmaCILrEqZbttBIeIXVzzFl26Y0xE
         E6L7RORajuMT0O7Q46AFsVBJPZktFVYwTuOApf87qBjbmPn9IhxNCs3oW89M2wA5kKsi
         yw5NP7XDbZkzh19wSVB7lQXNT0kNIoFXjyykkun/F0AO6H0TigyKKQaBN+M5PWJSw5y0
         +8Fe0ukKlO8R9L+MzrTgMLM07THjB10X2I2f4PiWIh7kV1RC3WFmYDlThZMmWrp03IJL
         djsQhdj4EZf458Vl6PkFQcIymMtfZO7UJdgghz12zQxVSy9AU3jRTwrW3H8WdOOFvOLf
         +7qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsO9ToSwg0aNWx19q/6se20G75A7zC3Qa3/B9dpYQwBsQ6fJWTGogDO08fQQz4k0xw+hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyDmvVvRq+tffyrWKBhJqDfmwG1Jmi3B/wz7IuB29CfPw8BNKI
	ne25cbhDdDU40cFGiOhpmj20k8dI5J57m0HwcoC9GSnauBaMlb866ZGsrg==
X-Gm-Gg: ASbGncspP3x75jrFKSQTU07l9tVUxL6khShioAAP1hwbEiwzoi8WY2TfZrr2Ggkm1aM
	Cff1E/lkKX+0fVfu6nrBXSXkftTWtEsVUGDOPSRUHLJTq0lkEya+K9kqi2TcLuW0G3TS7kWqk/q
	O0zxFfSG/iU7ktZT4IHWSMq248BJJhFziLkVPJaU0vgMye7LpzR9ueH6chgDgk4FF1GHsgU4YZ1
	ETWh7qomXeNUMgQoUAT2xFKZQLQ8F8Wr+WbuHWVqzsadjKtpNOWfxAXSWoo8diHlCSnazTH2qU9
	gZX0K5+QtKWBlSL+yUybAiF+EKBoLpDaISYYpeHR2BvpzWEjuoJ4DvSNovKWXEx0WRD9gpB9kB0
	eKcmfpe2g7ryfrJYFLf2y
X-Google-Smtp-Source: AGHT+IH6a/fie7w7cT5JjhBmqye1j/dmFHw8LRA9Ef/jhI4sTiquzp+kywI/YDwxvohBrlgG5KNPgg==
X-Received: by 2002:a05:600c:3ba4:b0:43c:fab3:4fad with SMTP id 5b1f17b1804b1-43ecf8f262dmr27324835e9.16.1743776023183;
        Fri, 04 Apr 2025 07:13:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34bbd9csm46947245e9.20.2025.04.04.07.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 07:13:41 -0700 (PDT)
Message-ID: <8fd9d4d0-93e1-4a88-a1ed-1d84b2150893@gmail.com>
Date: Fri, 4 Apr 2025 15:13:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] wt-status: suggest 'git rebase --continue' to
 conclude 'merge' instruction
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1897.git.1743181401.gitgitgadget@gmail.com>
 <db01acdd062a17b1cca62428eba8c3ed62ca7c6a.1743181401.git.gitgitgadget@gmail.com>
 <0bd7e0c1-fe73-9e16-0737-d6b175a60dd3@gmx.de>
 <a81dbb21-b50b-4358-b2d4-7f804b66bcbc@gmail.com>
 <15222e69-9452-fd61-6ffc-8c8de0c68d8a@gmx.de>
 <08837a1a-b46d-4456-beba-5c889fe9e674@gmail.com>
 <c2f93d99-2f4d-ee6d-7087-42320c6df0f2@gmx.de>
Content-Language: en-US
In-Reply-To: <c2f93d99-2f4d-ee6d-7087-42320c6df0f2@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 04/04/2025 12:41, Johannes Schindelin wrote:
> On Thu, 3 Apr 2025, phillip.wood123@gmail.com wrote:
>> On 03/04/2025 13:17, Johannes Schindelin wrote:
>>> On Wed, 2 Apr 2025, phillip.wood123@gmail.com wrote:
>>>> On 01/04/2025 17:22, Johannes Schindelin wrote:
>>>>
>>>>> It is unfortunate that we cannot fix this, as `git commit` with an
>>>>> interrupted `pick` _would_ retain authorship, right?
>>>>
>>>> Unfortunately not. Running "git commit" rather than "git rebase
>>>> --continue" to commit a conflict resolution when rebasing always
>>>> loses the authorship.
>>>>
>>>>> (Why is that so? Can we really not use the same trick with `merge`s?)
>>>
>>> Authorship is retained when a `git cherry-pick` (what an unwieldy command
>>> name for _such_ a common operation!) failed with merge conflicts and those
>>> conflicts were resolved and the user then calls `git commit`, though.
>>>
>>> Why can this technique not be used in interrupted `pick`/`merge` commands
>>> of `git rebase`?
> 
> [Fixed totally garbled formatting that pretended that the first half of
> this sentence was written by me, the second half by you:]

Sorry I'm not sure what happened there

>> `git cherry-pick` retains authorship by writing CHERRY_PICK_HEAD which
>> `git commit` uses to look up the commit message and authorship.
> 
> And why can we not teach `git commit` to use the author information
> recorded in `.git/rebase-merge/author-script`, too, and teach `git reset
> --hard` to delete it?

If the user passes "--committer-date-is-author-date" then we write the 
author-script when stopping for an unconflicted edit command. However if 
the user runs "git commit" rather than "git commit --amend" we do not 
want to use that script because they are creating a new commit. That 
means that "git commit" cannot simply use the author-script if it 
exists. I expect we could read all of the rebase state to figure out 
what to do but I think it is a much simpler UI to say that the user 
should run "git rebase --continue" unless the user is creating a new 
commit. Otherwise in a world where "git commit" knows about the author 
script the user has to figure out whether or not they need to pass 
"--amend" when running "git commit". If they're committing a conflict 
resolution for a normal pick they should run "git commit". However if 
they are committing a conflict resolution for a fixup then they need to 
add "--amend". If "git commit" starts deciding whether to amend or not 
to avoid the user having to remember that is even more confusing because 
it is behaving differently during a rebase compared to any other time.

>> When we're rebasing the sequencer removes CHERRY_PICK_HEAD and instead
>> writes the commit message to MERGE_MSG and the authorship to
>> .git/rebase-merge/author-script. I think the reason for the different
>> behavior is to avoid confusing things like `git status`.
> 
> The reason is probably more that you can mix `git rebase` and `git
> cherry-pick` (why does this common operation have such a long name,
> again?). I actually do this quite often, I frequently even have something
> like this in my rebase scripts:
> 
> 	exec git cherry-pick ..upstream/seen^{xx/something-something}^2
> 
>> CHERRY_PICK_HEAD has been removed when rebasing since it was
>> introduced in d7e5c0cbfb0 (Introduce CHERRY_PICK_HEAD, 2011-02-19). These days
>> rebase supports --reset-author-date which means it cannot use the same
>> mechanism as cherry-pick.
> 
> Right. But it can recapitulate cherry-pick's strategy in spirit. After
> all, `git commit` had to be taught about an interrupted `git cherry-pick`
> so that it _could_ pick up the necessary information and use that.
> Likewise, `git commit` could be taught about an interrupted `git rebase`
> and similarly pick up the author information from what `git rebase`
> recorded.
> 
>> Personally I'd much rather we tell people to use "git rebase --continue"
>> to commit their conflict resolutions as using "git commit" has never
>> worked if one wanted to preserve authorship and I think making it work
>> would be a pain and probably fragile as I'm not sure how we'd ensure
>> "git commit" knew it was committing a conflict resolution created by
>> "git rebase" rather than one created by some other commit run while the
>> rebase was stopped or by an exec command.
> 
> Even I, the inventor of `git rebase -i`, have run afoul of this authorship
> resetting on more than a dozen occasions.
> 
> This is proof enough for me that Git is unnecessarily confusing (no big
> revelation there, right? Git earned that reputation very effortlessly, not
> only in this particular scenario).

I think it's confusing because "git commit" tries to do too much and 
that it was a mistake to allow merge conflicts to be committed by "git 
commit" rather than "git <cmd> --continue". I believe the reason "git 
commit" allows conflict resolutions to be committed is historical and 
that "git merge --continue" was a later addition. Originally "git 
commit" was the only way to conclude a conflicted merge. Arguably that's 
not too bad for a merge or a single cherry-pick but I'd argue it would 
be much less confusing if "git commit" refused to run when it looked 
like the user was committing a conflict resolution and told them to run 
"git <cmd> --continue" instead.

> I'd rather like this usability problem to be fixed, even if it is a pain.
> If the pain stems from the way the source code is organized, well, then
> maybe this hints at the need to clean up a little?
The sequencer could certainly use a clean up but I fear it would be a 
huge time sink for both the patch author and the reviewer.

Best Wishes

Phillip
