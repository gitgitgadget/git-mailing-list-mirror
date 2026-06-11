Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EDF224B04
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189505; cv=none; b=dUTRbJgXROJ41BRSh1HLAmhww3sTEqu2QZe16Va+KvH2GDhPmFUhgxsaCWfVHq4S4/ESbSQhT07TD3tKwjeilpbmZe1CDh7A903ewzWKybWBk2DBHxSwC3zqsmShFcF/b8bsN07RQGn/pFtzRKyleId5VGtmZl4nbRXANdVg3iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189505; c=relaxed/simple;
	bh=CxvWK28LXngZmb2ZNP22uP68LAs0zVVkz5VPfYubJ+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQWsqNFphpThUG0DolkUqTC0h7WBas3WIXoX2pSJUk1Mkvy0yzhtlmSA1co6zZSoYDqJ+4Ld0nJWf3i/R2eBvhWn47a4s2iyDlWvDTODZLYp/RqCxc6eziPpn4is+SSEkdVJ3L3WviyvuqpNTyqjlln6VAaC8qqer+g/ptzCViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3ybN9IJ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3ybN9IJ"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ce65629acaso91684686d6.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781189503; x=1781794303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAy/KkMf9CVJcoVrx4fFRoT64O4I8ymj0770ePTpvIk=;
        b=C3ybN9IJgVpMrp8NZkR/oX3Szr177m3NQWmT53afWvWeSphngjHlX+jf4NJF/LG7nD
         L2SEIerSxBm67M6hlFwzRvCyg9B6SDAcGJt+pYSLmDOY17ciMXBJOsktmIqv0w7yxsO8
         c4NEJs+vG1LqOXSKcgEtac0SOIJ+IX+eN7aeS0Peuf4cUOeXVh36A5OQTa+wPWDddt9d
         EsCCvrWQknb9CyIc9qXbo3PKdvKzfbtVecIkIrb1LtOYAp3jcwySXPX7eYXcD2OyOZsf
         mXGI8WPn3vXSGlTbh4Gvl0ESABJQttzufI1CKNS5UD4MXYbzdI7SCE/xcV7shkVz/Isd
         NWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781189503; x=1781794303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAy/KkMf9CVJcoVrx4fFRoT64O4I8ymj0770ePTpvIk=;
        b=bZ7aalTQR2FYIGMueQwL++dT5bvNw0naZMZqCKIJ7DuHotDbcXDfz1QVo6l0f7HJln
         /+pM3d7nm4OWOPgxiVEoknicVnrwQG0bCFxOe1bJLjig5HXrGkMuTcN58evN4fYtVl46
         BkT3K2oXZE4wcZqMeD4yJrY0fvSFYGHPVlA5QMapMheLCoxFg8179ZL8q9mb1I73RO3b
         9tG5bt5cnvPEox/Th+emj4dOKuXXl3TtFQKPhXVCfjJmhPQBhA2Iwc+Bojv55dtEIxrN
         9AQbj9KHlnc37lgidGIkEO2fU5rHwllYqljqyI84HKJAdji2qgB3ozH5RiTTeyaZ4nTW
         vlEA==
X-Forwarded-Encrypted: i=1; AFNElJ9OYfEwBuM3JBDKAqlni5f5huEb5ToTdbVIYPO63Xsj7bm32nI7FwNwiIdBP9czRFfPjbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlb0JjqqqEG/qQQycbRuxk3pGJuB6utfwJvAUne7mf4GPFfZCW
	Y5FFPfSzw1VHNsZveg4hj4wDYAMN4EAEgrkTGrOjUwYqJ0LesInnzNe2dQlnEw==
X-Gm-Gg: Acq92OHYq8+Lp5MXTltUBfYb+UShgV9nHnanuiMeZRAFBu+BkmjvI/Asq1752W+8CfE
	/bYXKJrxU/iPbA70tc7CQaes9CxB7NnTMfNflRjIxJQZITKNUJAB/W42V45/mRfaElZ9psMshtw
	0FOjpjU+CcEmuOxRO/UCIKxVt23RkgKMXwr8knAJVujtvN/32m8DBQWwlx9C1I0cq9tvXo5x4gP
	FnsT37cs8p0hJ8rJCnxsbXNJmqOCFtL3ORowT1jJj1ww7rRNWqMR5Adl0R/YN/eFVjyrBkYaLnL
	2z4w0/IrMWgpmprwFcGgWuZ6gul98LLO6l+D+Jg6JgMoSZunZF+E+48jgU/74WTH88BhTmODb/f
	HuhWmvUBnWJGipy8XWzETS3UWt5i3p2CZ2nKig23nuUQEQERa1TzRY5FuY4+hZ4RABt/WX5LkgS
	eKOJ5bSXP1hlUxz3Pss0s7PPXnpIXsHo7b1GCJz56pIT7pCjiBCHFhoIHDCh+R570T/ghubkcMm
	Mms49k=
X-Received: by 2002:a05:6214:d83:b0:8cc:ee52:3e60 with SMTP id 6a1803df08f44-8d1d814dae6mr49347996d6.3.1781189502708;
        Thu, 11 Jun 2026 07:51:42 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d1ea7c9260sm20952216d6.27.2026.06.11.07.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 07:51:42 -0700 (PDT)
Message-ID: <3a3d1dc4-341f-4276-a1ee-2972a885db84@gmail.com>
Date: Thu, 11 Jun 2026 10:51:41 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] commit-reach: remove get_reachable_subset()
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2144.git.1781033285419.gitgitgadget@gmail.com>
 <pull.2144.v2.git.1781178567862.gitgitgadget@gmail.com>
 <ffaf26b1-c55e-43c7-84b6-f810a54f7717@gmail.com>
 <CAL71e4Nn8Lk87A5=t1Wu=SStQqzmFqad+pcyOw_Fu-PLpRMq_g@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAL71e4Nn8Lk87A5=t1Wu=SStQqzmFqad+pcyOw_Fu-PLpRMq_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/2026 9:52 AM, Kristofer Karlsson wrote:
> On Thu, 11 Jun 2026 at 14:57, Derrick Stolee <stolee@gmail.com> wrote:
>> Finally, a commentary: You seem to have a habit of responding to
>> review feedback only through new patch versions, but I'd rather see
>> some thoughts in the discussion thread as direct replies to the review,
>> especially if you think you will change direction like this. Saying
>> something like "Maybe I should update the method to have two walk modes"
>> in a reply would have given me an opportunity to respond and perhaps
>> avoided a new version that went in this direction.
> 
> That's fair, I apologize both for jumping ahead too quickly with a new
> patch and also for evolving it into multiple logical changes
> (both code removal and complex refactoring).
> 
> I will be more mindful going forward about letting the discussion
> settle more before submitting followup patches.
> 
> I have no strong opinion on how to proceed - either park/abandon this
> or go with v1 as-is. I think you're right that having two modes within
> tips_reachable_from_bases is reducing the win here unless the mode is
> truly seamless but the abstraction does leak through a bit.
I think that my biggest issue is that callers are needing to know
something about the performance characteristics of each solution. It
may be better to keep the behavior completely internal: have the
method decide which approach is better based on the information it
has. For instance: is the minimum generation number "infinite"? Then
the BFS is going to be better than the DFS approach. Such an approach
would make it clear why there is the complexity _and_ would improve
both callers in the right scenarios.

You were correct to find two methods that claimed to do the same
thing, but we need to take time to consider the solutions based on
all factors.

Thanks,
-Stolee

