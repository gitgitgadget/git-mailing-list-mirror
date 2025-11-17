Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AD733343C
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763389639; cv=none; b=VRWEz1jEbJujpMW/dz/3dyJ3kS+RxB9y3gHOC90TYvzvg+FfT0jAg99Zy7WjPsdg03tUTLdonv53CBX+xWF7dRTvIwNJ5/0JzewpRmhNKPCZoBGnWEX/f+KikVpAPWHaLyzkdHJhRrgD0YZV8o7TSieJWqd8MnKMfwbZgzhie8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763389639; c=relaxed/simple;
	bh=wgZRkRycGQCTmthnIuQ+sAurGiK+XBp8PGZ9jgnfea0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=LCZF1+h9xzl+WQWDQgeY9iCYNeTMXg8tM3oOJzEVBuLJHvyVqiSshlZYsJh771g9x/dSA8k2N2lGYug6lH74578G/HOq0snifeKP7HxW2GEK2pnyNZHA/ylKWWcmselxG89i4AO9H7JhQuY4rmzO4nZnWFF03UR+koVwEuc9NOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+VPGoK2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+VPGoK2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so24030525e9.3
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 06:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763389636; x=1763994436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hr+G4zi6YuQiLfz1lNBaNwVQk/2sw6Ae36yCy3erTqg=;
        b=H+VPGoK2LgX9NJcbssZgJx4jRBaPEY+VI32Nv08RTwYxbw2LaUExK0ud4epAOhWb+1
         DK3MowFlx3yzQgHzxuy7MjL+wpSLEsC6Rx5uu/ThLBT6JBC3Ycj8XhZJePj7AxBNPQMr
         8Prcswp1T6RR9KTyQb6PNFmrW7EZJRS+Bb1eglhqLUupQFesIT9CaIJlCgffF3k3ngUy
         UZr+8ZjBXgGDXi18kgwzrt98xUaIJ1x/K9bUDB7LUzBPxAWrr4YPltpxQgEyNPu88VbG
         ypsuXDis1QlFwQE9e5KTc0koZcuDl8cakBFkDHcDuZmD1Q9V/0015Zlp47MDl8YF2MbM
         eL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763389636; x=1763994436;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hr+G4zi6YuQiLfz1lNBaNwVQk/2sw6Ae36yCy3erTqg=;
        b=d/zdE/duB7VFy0NxiRwGurFPaeWOjSEiyFfyVLc9IiORIlrNQ4dO08yP4xcN8B17DO
         GufIRRUp5C7dy2erm2v6Yd1ODNzeAaoKOznQdiwFqeX2iKuVaWTZmkU6tVKSuMvPmD1X
         5vRQzE8kR4JSelB6DGL7yTi6bxz9n/rwAL/6CvPdrxRHVP9OrprLifPHvaefWMY5QPiy
         oMvRsKyZ2BGJvqlBkAuCJDDnWAQfKcvMA9F6cCRkMJeQSmw7E5Zv6vGPDuJ/VEZ8mNrC
         iKaVJO7fW+qyJe5AdB3TZNZ36C7YsBem+X6syEASCGB2HF6x0CIoQEXJmztN6wyL9HUo
         wfFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc6vAoLU9g+bdAeA3wgl6VFrBmPR/p30mghdO0uorDtkEIIile8UJgXbNbKhsaGOQH5oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykDCceEDe9g/yWAywG8Yk1CwhVqyhXfOSVluJZrQjlK9I3R2Us
	POeEVfwyOpuGEwQFDYR4zPhHlMnJspX6vfsPX4veVb/vcZoWzWVfT6Gt
X-Gm-Gg: ASbGncsfMxjOQ5m/Mm7d23cf1Pz95PI23mkldOWgTGLrNHR33v9gPhbOAzLet4K5nzm
	6YRJB1sIuT2HjYRfhSbvTUk8rubok+pF9BaLQ7nXgK6HUI946Sa88WmXrNVQHJmBP5oLAYcPzBC
	CU4U7lm5ZirF4Y6O7Oew8nNe0p1wf+u67mRiqOw7YZxV7qbmKnIUAii4vF9TOdq9QStajlGrxoc
	iNyDDh2cw23m74KE68dxexAE4QEJZsCJsdmS26S3ZpwsYlFFlQSJ6WqTRmEEBNHD0tqcatQoIzP
	QK69ReFyAqZGsPuYr56M6vNsJ/jFqjsTZqVc/p0eWFLJidtO+aocQhHCBi3kCtilYBptR3ln/mv
	hfeMhJjXBiALi35N9LgNfZttlXXgBJa3fACWxyiLzwsA9rrkH2hTatkda8Ry4sSFhYpcCT3+hx3
	TrsofJajQuNuvuKbZ/o08gbrq6nq+I+ylrczEhurPaITkHzNGdgzTSv3tOWOeq+xjaDqy2v4uIm
	SwfNS5CTxvV
X-Google-Smtp-Source: AGHT+IFL7jMyU4g5kTCCqY8uigvraEy9+S2jFbA92Q/c6mfUHgmIyb0r4l/cDXOt9n4BKL7zGX7XSg==
X-Received: by 2002:a05:600c:4753:b0:477:333a:f71f with SMTP id 5b1f17b1804b1-4778fe60658mr122332285e9.17.1763389635277;
        Mon, 17 Nov 2025 06:27:15 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477952823d3sm166773345e9.11.2025.11.17.06.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 06:27:14 -0800 (PST)
Message-ID: <10ad6161-8d9d-4e07-ab62-105adac2220d@gmail.com>
Date: Mon, 17 Nov 2025 14:27:13 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] commit: add --committer option
To: Matej Dujava <mdujava@kocurkovo.cz>, ZheNing Hu <adlternative@gmail.com>,
 git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
 <CAOLTT8TPrNTCjHwJfdeei+t8+7AxGC-dvbq-4oHJ=qNn_c+-jQ@mail.gmail.com>
 <7d99f00c-3602-4b28-8efd-4780cad41ca8@gmail.com>
 <CAOLTT8TLEsSAcfUomoActrUSzje5mQNE7EweXh8WtY3sOfzfkg@mail.gmail.com>
 <aRpMW-g_rt4jStnu@kocurkovo.cz>
Content-Language: en-US
In-Reply-To: <aRpMW-g_rt4jStnu@kocurkovo.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/11/2025 22:12, Matej Dujava wrote:
> On Wed, Nov 12, 2025 at 11:58:02PM +0800, ZheNing Hu wrote:
>> Phillip Wood <phillip.wood123@gmail.com> 于2025年11月11日周二 22:38写道：
> 
> I use includeIf pattern in a config to separate identities
> 
> ~/.gitconfig:
> ```
>   [includeIf "gitdir:~/.local/src/personal/"]
>       path ~/.gitconfig-personal
>   [includeIf "gitdir:~/.local/src/companyA/"]
>       path ~/.gitconfig-companyA
>   [includeIf "gitdir:~/.local/src/companyB/"]
>       path ~/.gitconfig-companyB
> ```
> 
> then each
> ~/.gitconfig-IDENTITY:
> ```
>   [user]
>       name = ...
>       email = ...
>       signingkey = ...
> ```

I think that's a common pattern, so long as one can arrange the 
directory structure so that the repositories for each identity are under 
a different sub-directory it works well.

>> You're right that after realizing the misconfiguration and correcting the
>> repository's user.name and user.email, running `git commit --amend` will
>> fix the committer information, but the author remains unchanged. Users
>> then need an additional `git commit --amend --author=...` to fix the 
>> author,
>> which does work but requires an extra step.
> 
> For just one commit, after you fix identity (update .git/config or move
> project so includeIf uses correct config) then `git commit --amend
> --reset-author` should get right identity for both commiter and author.

As you note below it also resets the author date which might to be 
desirable.
>> I see your point that this becomes more cumbersome when dealing with
>> multiple commits. In such cases, users currently need to use something 
>> like:
>>
>> ```
>> GIT_AUTHOR_NAME="..." GIT_AUTHOR_EMAIL="..." \
>> GIT_COMMITTER_NAME="..." GIT_COMMITTER_EMAIL="..." \
>> git rebase -f <target>
>> ```
> 
> In my test ^ (using 2.51.2) did not set specified AUTHOR identity

Indeed, rebase sets GIT_AUTHOR_{NAME,EMAIL,DATE} when running "git 
commit" to preserve the authorship of the commit being picked so any 
value that is set in the environment when running "git rebase" is ignored.

> but using:
> 
>    git rebase <target> -fx "git commit --amend --no-edit --reset-author"
> 
> is close to rewriting commits with new identity, but this will change
> both dates (committer, author).
> If --reset-author is not used but either GIT_AUTHOR_* are exported or
> --author '...' is used in a -x arg, then author date is kept untouched.

Yes "git rebase -x 'git commit --author=... --amend --no-edit'" is 
probably the easiest way to reset the author and committer.
>>
>> This is indeed tedious and error-prone, especially when you want
>> to quickly fix and push commits to the platform.
>>
>> `git commit --amend --author --committer` or a new `git rebase
>> --author --committer`
>> would provide a more user-friendly workflow for correcting identity
>> information after misconfiguration, eliminating the need to manually
>> set multiple
>> environment variables or run multiple commands.

I'm still not sure why we need a "--committer" option when the committer 
identity is taken from the corrected config anyway.

Thanks

Phillip

