Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D01B0F29
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732545391; cv=none; b=rLOJ5Te/KeY0Gux6aKFLNHnp0h2iAqFtfKdovTk8gd4DyoKwB3r0LwjudRnleWeGO6rK0iILFkdHwMrlSHpS+tYJsk1Q79PiVeh/334Bin29vLlndH9OWVVz1M8kFS0VoX0dSl7IC8aXncTN7sHxrS/8Q+gL/RyKwsjIIEBBbvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732545391; c=relaxed/simple;
	bh=xXrRqBjkTsTRnRegygN25eTTU+ZgtegPlkPBU3KIUe8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a2fT1V96SCDic4rNl+wJRai2+oCCL/lBsju8lcayFLvQ5bJwGGxn0oD3KMruPIUFysv2wGITZEJqCMKyXsNUggu47wYJI1Yo8T7kNXFzTo13rWdBHxtzuvtML8W/z9W2MczEc6iiLpwzmDa7jdzcVoGd6gR+0dNWZpBLQO07ju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZ85lNpe; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZ85lNpe"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3823eaad37aso3439542f8f.0
        for <git@vger.kernel.org>; Mon, 25 Nov 2024 06:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732545387; x=1733150187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WT5W7/4CtPjyPwKf8llVja7xM/zkeZMFOMW7DA3OWms=;
        b=gZ85lNpefQIw3xePBD09HtnnM19mgVsazyXFZzZjDGZ3rvdCVbNx+3mclW3utxtJnl
         pjfStNDMuq7pVM5T2uCUOsP8JHuvmeH5OulQjX07LB5zc0bB9U2Pi2CegZJuM21anY+U
         cBMxesZdY0hTEQW0v99MJ4AuA+U5w3R3zg5dY2RFTZHpake3S52ZUKydPQ7boBcOI304
         gZdobrUVowJ80Jb/UnWqlncUyjjaHmRzvqlBcfvwAHufvdNdRUoVCleIo3KZ7ru9FQVx
         DIzwXSQ5pNmU844TOGKro3CfxqqFnZ7RWeX0gy4APrSAAE09+wOP4YLILZL6E3Ed7j4H
         c4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732545387; x=1733150187;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WT5W7/4CtPjyPwKf8llVja7xM/zkeZMFOMW7DA3OWms=;
        b=AvSMhFkj5skAmORppbXSJWN4fe9wQVSwFYhJUJRet22RbHgyeKVmvjKBT20lwPm4Oz
         +iapk1vUjRyjC2QnABdixDKPEcST/6sWtL1aWfntRnfWNxQbMx/b7qPrVZxOP9XB+Jdp
         NLs3XV2w9Xt1iibr7HPL1L6R3N08G7eA+IIQ8CJOd+OdcsZ3VxvJXm84MB+US1Y49xZB
         j7OTYVvLq9Ki5c07brdnPWLorjpIwIGrwUTEEVYLx1Nbpe3guK5IObwcEneqyHuuxn6T
         +ESxUf3q6VEUHw8yrLA1hhyAHFqf8QWZA/mnJvrmLGHixOxdprmrx1MspUajmggPcjhr
         jXnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0vVx8bvJGKy6u6sgzz0NZLzUW8lumMd88Jbhnh1qfmaQzDaHlf8hw73pPWpLOnV89vIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPLRIOj2gcwaCGnUh4KwzVKJhuBeyeiAWzua3vX39RV9wWdjeo
	h1BNXRQGKtDvgHyyrzu+WtP1X+CXNvZGj6MfKHww1dmAv3b2FylXbsj4HA==
X-Gm-Gg: ASbGnct6H6TpBblM/GNCIntSSxg2PZ8qWh/ZwAMCBFI/tIWhyySwcPwieY8xDTxl4O+
	09+vp2hfmW+HoTp0/j7m6OJrhNB/nG+b9WFwc0nmpUAKkaxQpciiModDts+ckf6cO2y+/pL1c9p
	UpVEMQ51WgAEnE6pqxna9LQVjIx6LWo7T+GfxFxhfbG19f4c3d9J2hey3DcGPkjjobZw2jc0m+g
	mdb/dNsrVSVaKjW3IaFpDJW+bQwyN9odTboMk9fTT80oJAAQn3KGIKFaZeA4mJDTqd1aTyvlJop
	NXvr9CCnuUlOUQR74xzyLAVG/uX5
X-Google-Smtp-Source: AGHT+IHAtDwGqVqx4SKX9L0hQ1XgBUqa2sio/WPtia0ZeP7Xo+34YJMZ4v8VnFRkVhHOwg3gFMKchA==
X-Received: by 2002:a5d:59a4:0:b0:382:48ba:631 with SMTP id ffacd0b85a97d-38259d2b917mr14910964f8f.22.1732545387104;
        Mon, 25 Nov 2024 06:36:27 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6f7:6401:d76b:efc0:c762:b74b? ([2a0a:ef40:6f7:6401:d76b:efc0:c762:b74b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349d60de86sm59352655e9.35.2024.11.25.06.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 06:36:26 -0800 (PST)
Message-ID: <62966a75-45fb-48ca-9ed2-6ff683de09c4@gmail.com>
Date: Mon, 25 Nov 2024 14:36:25 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/3] sequencer: comment out properly in todo list
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <cover.1731406513.git.code@khaugsbakk.name>
 <cover.1732481200.git.code@khaugsbakk.name>
 <7739a6e2-8758-4d0f-b1d6-f0879a89590f@gmail.com>
 <3bd7cd08-61b6-4b57-a293-1c94eb3529d7@app.fastmail.com>
Content-Language: en-US
In-Reply-To: <3bd7cd08-61b6-4b57-a293-1c94eb3529d7@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kristoffer

On 25/11/2024 10:52, Kristoffer Haugsbakk wrote:
> On Mon, Nov 25, 2024, at 11:07, phillip.wood123@gmail.com wrote:
> 
> Hi Phillip, thanks for the review!

You're welcome, thanks for fixing this

>>>       +    that hash3’s commit message should be used for the resulting commit.
>>>       +    So the user is presented with an editor where the two first commit
>>>       +    messages are commented out and the third is not.
>>
>> I'd perhaps say
>>
>>      If there are conflicts when applying commit hash3 then the user is
>>      presented ...
>>
>> as we only show all the messages to the user when there are conflicts.
> 
> I use `fixup -c` for the third/last commit here.  So I am prompted to
> edit the commit message. I tested this on this series:
> 
>      git checkout --detach kh/sequencer-comment-char
>      git rebase -i fd3785337beb285ed7fd67ce6fc3d3bed2097b40
> 
> Which gave me [this] editor without these changes (with
> `core.commentChar` set to `%`).

Oh, I see the same thing, I was sure we only showed the final message 
unless there were conflicts. I wonder if I've misremembered or the 
behavior has changed in any case that's outside the scope of this series.

Thanks

Phillip

>>
>>> However this does
>>>       +    not work if `core.commentChar`/`core.commentString` is in use since
>>>       +    the comment char is hardcoded (#) in this `sequencer.c` function.
>>>       +    As a result the first commit message will not be commented out.
>>>       +
>>>       +    † 1: See 9e3cebd97cb (rebase -i: add fixup [-C | -c] command,
>>>       +        2021-01-29)
>>>       +
>>>       +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>            Co-authored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>       +    Reported-by: Taylor Blau <me@ttaylorr.com>
>>>            Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> Thanks for updating the trailers, they look good to me
>>
>> Best Wishes
>>
>> Phillip
> 
> † this:
> 
>      % This is a combination of 3 commits.
>      % This is the 1st commit message:
> 
>      sequencer: comment checked-out branch properly
> 
>      `git rebase --update-ref` does not insert commands for dependent/sub-
>      branches which are checked out.[1]  Instead it leaves a comment about
>      that fact.  The comment char is hardcoded (#).  In turn the comment
>      line gets interpreted as an invalid command when `core.commentChar`/
>      `core.commentString` is in use.
> 
>      † 1: See 900b50c242 (rebase: add --update-refs option, 2022-07-19)
> 
>      Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
>      % The commit message #2 will be skipped:
> 
>      % sequencer: comment `--reference` subject line properly
>      %
>      % `git revert --reference <commit>` leaves behind a comment in the
>      % first line:[1]
>      %
>      %     # *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***
>      %
>      % Meaning that the commit will just consist of the next line if the user
>      % exits the editor directly:
>      %
>      %     This reverts commit <--format=reference commit>
>      %
>      % But the comment char here is hardcoded (#).  Which means that the
>      % comment line will inadvertently be included in the commit message if
>      % `core.commentChar`/`core.commentString` is in use.
>      %
>      % † 1: See 43966ab3156 (revert: optionally refer to commit in the
>      %     "reference" format, 2022-05-26)
>      %
>      % Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
>      % This is the commit message #3:
> 
>      sequencer: comment commit messages properly
> 
>      The rebase todo editor has commands like `fixup -c` which affects
>      the commit messages of the rebased commits.[1]  For example:
> 
>          pick hash1 <msg>
>          fixup hash2 <msg>
>          fixup -c hash3 <msg>
> 
>      This says that hash2` and hash3 should be squashed into hash1 and
>      that hash3’s commit message should be used for the resulting commit.
>      So the user is presented with an editor where the two first commit
>      messages are commented out and the third is not.  However this does
>      not work if `core.commentChar`/`core.commentString` is in use since
>      the comment char is hardcoded (#) in this `sequencer.c` function.
>      As a result the first commit message will not be commented out.
> 
>      † 1: See 9e3cebd97cb (rebase -i: add fixup [-C | -c] command,
>          2021-01-29)
> 
>      Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>      Co-authored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>      Reported-by: Taylor Blau <me@ttaylorr.com>
>      Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
>      % Please enter the commit message for your changes. Lines starting

