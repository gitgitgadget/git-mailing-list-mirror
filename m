Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A7F3222
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705683235; cv=none; b=myRpfclRuUPZRe7HNdw3VnJ7/YhcezlCwX5Q99SRtd7q8KbJx1C7i4zjr4ZGmg2wSZNdsKYMZlK2paiowa8v+1nCpOdzPgEHUX8A/U/2NUN/T6T1VuZat0fU0VGF/IBPcL4HKfvF2Cjg2pfaCxHgvfsr7lkva9JRqAfjj6NhYQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705683235; c=relaxed/simple;
	bh=Ir/tQvw1tnCO4GqlGi67T8ccpU2XYRJGJpmtTe1Wr68=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=s3GKQlPbz7brC8YAODeyDJyFPHc8xfEkjzYwXnAeuVV1MJa+BhF3yD7ZGM0f46/Sz3eNEZQX5umfownSiBbaoBRexeiR4OnNb+zUkRl5JCuzMvYdT+iiPSgMc74xmJQFR2f/ZBkuHfNMHGD1wtUb5djdIinIfKJtGr1qR/IOl9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4GhN7Ho; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4GhN7Ho"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-337d90030bfso767222f8f.2
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 08:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705683232; x=1706288032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aG/siWEMw4v1pDIpB4E0KIsIN06s8TxrdTqx0Fehd/I=;
        b=d4GhN7HoX9aJd7gcSCJIgFu633XgmbU/J/ODT7tFhlxIkUi0lPfSJDWhZ6gsd1nWD/
         i1MDwqsMpwU8nZJxuoKRtwjoIyNsY40iSE8u+/Y1tvsRcz+bBkfIvisSlmDbs1Ylblac
         El6jl5bWdABGP0DbM1TNRSvTqF9UoDmznzoiOPeJtD+EsN6QJnL40cbB2meBM6ri1GtS
         9ZRS9hnxed8g3+r5Moky6FyQlZ07CZaqneQlVdY+KgF2H+XXN0okq6Rqh3W3a5nSsHK3
         A5rRnZZhTWWgD7laeNusW2u25Zo+9T1FdFv4kS1tFU9/T1AUq4i/yB+RHRmO5kZzKyW8
         GTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705683232; x=1706288032;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aG/siWEMw4v1pDIpB4E0KIsIN06s8TxrdTqx0Fehd/I=;
        b=sa0NkBSFAn46S1jWGR5f0ToHYC653iK+l/NtQpV7gqDE9FeHAkARslCm1LkSbikB42
         8l0tXKVBf2TMrZO94+rPKYzFjpFju36EQSrUh0zG03fe832OXHngRibvCsNgZOKXuXiB
         oFHmysCJEm3iHuU91KJQUzHx04/qN20+SyDprBKB/s0W2VTeuBlsmoLgAS7sgGwKxVUE
         R0rbY6PRatus1aTKLtLTlvNneZN3vT2Y5RvMni4akkdgkYnUTUt/FjJR0znu95UwGQYi
         bR9Hq/Bb+reayuqd1q8tEKsWfwnYF8lK1yvLYEO0koorznhsk8LYunKTS42cqksyer6Q
         5VfQ==
X-Gm-Message-State: AOJu0Yzaw2WrtyRXY2aKT98Vgr0PcLk4cbhPx27DMkuIzNGrXxDmHM+9
	3m+9pAb91reGJ1bjZYMuoIf5yA+Qw/JUJ32J6xcdaadVwxELkjMH
X-Google-Smtp-Source: AGHT+IEA1NCdQn9aYvieyyrHZi/IpsyrzQbl041dNWyqvOhRxSLvMBM/vg7fvPn5jxuhxQU/sUDpLA==
X-Received: by 2002:adf:a1dc:0:b0:337:5baa:ec9d with SMTP id v28-20020adfa1dc000000b003375baaec9dmr5581wrv.8.1705683231585;
        Fri, 19 Jan 2024 08:53:51 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d5650000000b0033923370b09sm967584wrw.6.2024.01.19.08.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 08:53:51 -0800 (PST)
Message-ID: <7fc35078-a165-4b3c-96e2-37fbe55e109d@gmail.com>
Date: Fri, 19 Jan 2024 16:53:50 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] precious-files.txt: new document proposing new precious
 file type
To: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Sebastian Thiel <sebastian.thiel@icloud.com>,
 Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
References: <pull.1627.git.1703643931314.gitgitgadget@gmail.com>
 <xmqq8r5gfc3j.fsf@gitster.g>
 <CABPp-BGSTYDUR1oYYXkCSh-1i2zwxBM=-gnoe-ezNbtPi5CV2A@mail.gmail.com>
 <xmqqsf3nl2b3.fsf@gitster.g>
 <298F7067-D572-433F-A7DD-5256B43B97D7@icloud.com>
 <xmqqwms6qwr3.fsf@gitster.g>
 <CABPp-BHaUDdtH6igDmOx_wv8xYh-uA=4L9zDDycrZLaa9c9KLQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABPp-BHaUDdtH6igDmOx_wv8xYh-uA=4L9zDDycrZLaa9c9KLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Elijah

On 19/01/2024 02:58, Elijah Newren wrote:
> On Thu, Jan 18, 2024 at 11:14 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
> [...]
>> So, all it boils down to is these two questions.
> 
> Thanks for summarizing this.

Yes, thank you Junio - I found it very helpful as well

>>   * Which one between "'git add .' adds '.config' that users did not
>>     want to add" and "'git clean -f' removes '.config' together with
>>     other files" a larger problem to the users, who participate in a
>>     project that already decided to use the new .gitignore feature to
>>     mark ".config" as "precious", of older versions of Git that
>>     predate "precious"?
> 
> Accidental "git add ." comes with 3 opportunities to correct the
> problem before it becomes permanent: before commiting, after
> committing but before pushing, and after publishing for patch review
> (where it can even be caught by third parties) but before the
> patch/PR/MR is accepted and included.  At each stage there's a chance
> to go back and correct the problem.

If you've added a secret then catching it after you've published the 
patch for review is likely to be too late. I agree there are a couple of 
chances to catch it before that though.

> Accidental nuking of a file (via either git clean or git checkout or
> git merge or whatever), cannot be reviewed or corrected; it's
> immediately too late.

Indeed, though "git clean" requires the user to pass a flag before it 
will delete anything does have a dry-run mode to check what's going to 
happen so there is an opportunity for users to avoid accidental deletions.

> [...] 
> However, on a closely related note, in my response to Sebastian I
> point out that the '$' syntax permits individual teams to prioritize
> avoiding either accidental deletions or accidental adds on a filename
> or glob granularity, so if folks are concerned with handling by older
> Git versions or are just extra concerned with certain files, they can
> optimize accordingly.

That is an advantage. I do worry that the '$' syntax is unintuitive and 
will further add to the impression that git is hard to use. I think the 
choice comes down how much we are worried about the way older versions 
of git treat ".gitignore" files with the new syntax.

While I can see it would be helpful to settle the syntax question I 
think parsing the new syntax is a relatively small part of the work that 
needs to be done to implement precious files.

Best Wishes

Phillip

