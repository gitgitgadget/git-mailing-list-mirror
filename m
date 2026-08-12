Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E584144D035
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541772; cv=none; b=LTjdAO0iGR8iFFmIZmktUjC9IAEDy4uXVB3Yrxb4yvki+6zCJYlbAPe3BpLl7ndvxMB3+OsGgHBBtEDGn+Q2+eB0h6XjKwX5ZzW9ravZ4+hlsBvzO5twuAYlRfb9jqbprY6msypLzB5I+TG6sYcgyNCurVLlH8KdkiRLVfcjnCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541772; c=relaxed/simple;
	bh=IJLF3L/TuJRzsyaySRH74aLZx1OWigSwYQbiy+1ppEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8QrzblBBit8y3ouVkXZu/Ba4A/yvTPDFh4P9ptLHPsAUccEk3MZ+wiA2h5+bU3AITC4qZ2fnIj3uY/rcmSMZI2GpRWQvMNARfIZr50nBcuGzk0PTEPLriCno3DX9nlL3Zmi5ormX5Pxyyvl8RtIUA3fuKDZtKGwvcTgVpYNpeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f64EWXbJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f64EWXbJ"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso1649239a12.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786541768; x=1787146568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zXg0xG0Kgqbo0FItbdoHbAJgbbY4Av7P8WRy3tqiwxY=;
        b=f64EWXbJoq4F50DnYntDj2cG+E2agoUFU1Zw76lUTiBonG1WYtrLPX/q/bUwgzuc2Q
         TiDHXpuheI6ba282bK53MHolIw8P0yN+f8Uax5hW8RbpPp88EVTtMbPwFAo/qgAFwK/a
         nBvIm9kIHADPQQXqwlkzal4EgWKjuNlhI68GHPolgSNyt1MgVJT4BgGCs6bclwXEZH8B
         3tYjSMwZk+G7sNXkn6DSuaKtN5pV7kiz1t4yRSk/1BAJG51BBZCV19fZVRSTrBBIj74o
         uyzHxeEKrzFMMt+aFIiGpSNDzpytWcnMa0JLY+Vrn18cnqxBjOHwBiG2Ut0CxTtROWDX
         jBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786541768; x=1787146568;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zXg0xG0Kgqbo0FItbdoHbAJgbbY4Av7P8WRy3tqiwxY=;
        b=MoqT14EN4JzhnJj3nFaKxR4MY9KAAVbgabUhpX9+ZD5bmGQEjXqLt4Jxor83c2zZT1
         40TRK82OHI6FHbzggHt+NDbBkrCcj6UgeyFdxeTf7AqGcUlTNIWDTEOKZ5ec89WdMWhI
         3+I2xnF9FNY+Husya4AeKL1e3nw4enOSA9awBMACjcOrjr3Vo7iYKUzqtluciy3fwHAp
         fzjdZj3MT6TugIRwEF/YQpssQbN5ZtL4a7gP4IWCSP+0mktDgpfBmq6hnzKqRsAUEPt8
         7YocyEQjv7Jp8tvfPrvYEfgFUEozgRbucXd0yPBjcImSgcAa4P/yaP+Dsdy/hBcTlGS5
         vHMw==
X-Forwarded-Encrypted: i=1; AHgh+Rr8PGHiFn5EovvCPzZCoa110B6Atz15G8/W5T3PHi0Jxxl6ltFpAI5gszfHlIAdpklVEmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXxYTjHVV/y8t4g5YPGpjdGpzywoYs06WeZ28UKNsJvbAa1kD5
	lb/0OgRT0AsNkIAoN5Q71QnBpSnYWVWWQ9tbbPBqMYaCnNULHxKMHPY6
X-Gm-Gg: AR+sD119Oo2zod3/4gypz2qhuCnM8oBDisqfaL1UOyM+Yo9gRyze1qppbWopqqr+KKh
	hC/W6GCcM9evNzxmZx5B38cKnPhWM7DYwzRbJW1DbdnwwafywtC0XnLBjh/PeKfD/wjWS7kqWKm
	TRzU1/VByXHpEuR9OjwOmqh3oww5edIKRsfSY4n1iDd838tOTSSiVVlDcKzic1JtAS4gb3CcBGu
	ez3DcVmt3OaV+7RizoxBsVVMKpIpmqIVkQzVhfAPhCgea5AGDBRdBYk8CGxyWfKfK/0V8mxDD0x
	MAHvcDqekvnnn+kcCOTAp40ktqvXy9neefC806/GAD9nRTqAVx2mAX6f/hRAqQ+vP4WmEtbeADC
	0VYCkoJngg/r87b6F6EEzvbLGG1RCXFG68xzpNVwy/gzExZkxPiT6n4PAJ7kParF9RH3AfADDrd
	RJTVPb9P5g2ZOyQFuGkZvjJFKBewIk7ZAopaLfSTODGTefvK6FHK6owAnda7BSchw+nP2mgNUIX
	SC3T71j+3+GY5Mwi+J4VUoXFQ==
X-Received: by 2002:a17:907:f816:b0:c20:2d38:e518 with SMTP id a640c23a62f3a-c20f2e66a3bmr232243066b.2.1786541767856;
        Wed, 12 Aug 2026 06:36:07 -0700 (PDT)
Received: from [10.0.1.15] (85-71-82-202.rce.o2.cz. [85.71.82.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a376a45f17sm664383a12.29.2026.08.12.06.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 06:36:07 -0700 (PDT)
Message-ID: <e832d095-2a6f-4e98-b20a-f21175bfc817@gmail.com>
Date: Wed, 12 Aug 2026 15:36:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bugreport
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
References: <a7899757-9c3d-4735-b7ab-469808707e61@gmail.com>
 <8fe70f89-89a8-426f-bab9-21284722c58d@app.fastmail.com>
 <f4e39b04-b6dd-4b83-9103-8a1c98019dce@gmail.com>
 <CALnO6CD-nWAJhaMqAPCL9NOHUtqbna6Z=RHZVrE_WfOeC6bdsw@mail.gmail.com>
From: =?UTF-8?Q?Marcel_Svitalsk=C3=BD?= <marcel.svitalsky@gmail.com>
Content-Language: en-US, cs, en-GB
In-Reply-To: <CALnO6CD-nWAJhaMqAPCL9NOHUtqbna6Z=RHZVrE_WfOeC6bdsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/08/2026 15:14, D. Ben Knoble wrote:
> [please don't top-post]
>
>
>> On 12/08/2026 14:54, Kristoffer Haugsbakk wrote:
>>> I have only skimmed this.
>>>
>>> On Wed, Aug 12, 2026, at 14:31, Marcel Svitalský wrote:
>>>> What did you do before the bug happened? (Steps to reproduce your issue)
>>>> I called `git lg` command to display git graph log in my terminal. The
>>>> command is defined in my
>>>> general gitconfig file as follows:
>>>>
>>>> # double liner with hash, time, branches and tags on first line and the
>>>> message on second
>>>> lg = "!f() { num=15; if [ \"$1\" != \"\" ] && ( echo \"$1\" | grep -q
>>>> \"^[0-9]\\\\+\\$\" ) ; then num=\"$1\" ; shift ; fi ; [ $num -eq 0 ] &&
>>>> num=999999999 ; git \"$@\" log -n \"$num\" --graph --abbrev-commit
>>>> --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold
>>>> cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold
>>>> yellow)%d%C(reset)%n'' %C(white)%s%C(reset)' --all; }; f"
>>> Note the `--all`.
>>>
>>>> What did you expect to happen? (Expected behavior)
>>>> I expected to see git graph log with the project commits.
>>>>
>>>> What happened instead? (Actual behavior)
>>>> On top of the project commits were added these four pseudo-commits made
>>>> by some Git component(s).
>>>>
>>>> * f7b611ce - Wed, 12 Aug 2026 09:26:03 +0200 (5 hours ago)
>>>> |  Notes added by 'git notes append' - rewrite-analytics
>>>> * 1a7605bb - Wed, 12 Aug 2026 09:26:03 +0200 (5 hours ago)
>>>> |  Notes added by 'git notes append' - rewrite-analytics
>>>> * c2a05d79 - Wed, 12 Aug 2026 09:25:03 +0200 (5 hours ago)
>>>> |  Notes added by 'git notes append' - rewrite-analytics
>>>>     \
>>>>      * 01c630e0 - Wed, 12 Aug 2026 09:13:00 +0200 (5 hours ago)
>>>>         chatter: initialize notes ref - chatter
>>>>
>>>> They are not graphically connected with the actual commits, they just
>>>> sit there over them. No other graphical
>>>> tool (Sublime Merge, IntelliJ Idea) displays them.
>>> They are Git notes. They form their own connected graph. That’s why they
>>> are not connected with the “actual commits” like from some branch.
>>>
>>> The `--all` will include all refs, including Git notes like
>>> `refs/notes/commits`.
>>>
>>> This doesn’t look like a bug.
>>>
>>>> [snip]
> On Wed, Aug 12, 2026 at 9:03 AM Marcel Svitalský
> <marcel.svitalsky@gmail.com> wrote:
>> I see, thank you. Is this a new feature? I've been using this command
>> for years
>> and today is the first time I am seeing this.
> Notes are not new. Perhaps a tool you use started creating them?

I suspect lazygit. Or Idea, I don't know and won't investigate any further.

>> Also, is there another
>> flag instead of
>> `--all` that would just include the actual commits only?
> You could limit the refs to be listed, like maybe "--branches --tags
> --remotes", or "--exclude='refs/notes/*' --all" ? (I'm omitting
> treatment of refs/stash, too, for now.)

Works fine, thank you very much (and yes, I now realize I could and 
should have
looked at the man page to begin with).

I suppose this can be closed now (I do not know the procedures here). 
Thanks again!

MS
