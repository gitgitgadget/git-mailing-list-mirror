Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB3F3B9D9E
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403940; cv=none; b=iyRad3dKplsPGfW81MAHEoRS3W+N3dluex+6SPIonAvgYl0fLgqLyo6QGPy4MWitHcAbiXW6W5sqPYWgos+Y68eY1Ld8vuqW96xznYcRjhtFSKr48CvMBaeKNrgbyRXbDgDlkGcvRtuof4XGTdhjJsi24E9biDuclFU/6mxBVsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403940; c=relaxed/simple;
	bh=jVSJhlJTjZ8xE4MM5/M6XlYUlZaOOdqs6tNrYFHqakY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BD5fQRks3oQN8CX9GZWowpnYro9Y7F0cTWJYGLgbf0Je10XOJBch1VVJYDyuvkpeZ9j+rQk25Nkk/N8rhjqBJZa9RrHUPnhSpNQI8ZakhtR5LG8m0OdJ2khD6Rv2Aao0JNLTnOUPlC1rkUZv3EeDDs3WVquWDFgz8EcqgqMZL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFR6wJ7S; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFR6wJ7S"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so8990615e9.2
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785403937; x=1786008737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qy/lYkB39glEo+b6UORWBDJ5VWBIRtRvC3AdhiuvDds=;
        b=DFR6wJ7SbgMXpQI5RntC75y5axCET2eLwdRvY0+vP4WXHN+GLMkfNhpf52D9ok6cUX
         N9qtZ2iuohI42yKW7ZS9ZL4sVoytCaTttpwVnXJ4m6gXxqpxB5J67K/AOJRT0JxOE5Zz
         zFFmi4wK7YsyJejyp56AsQBU7pBK6Zvu0YX8H1bzjaHnmBTSmWFEI5lE11Av8uZiIm33
         vn/AMfwAZfH3k+nS4zWAYmq/xH6AwCiaebXOQZKvDVhfW4THUB3gwksFfdD6kkIP+LXN
         PTzyFJ3Mt48vkP6DQfF3MD+lSaTUWhnl5WxQR7d5sqQkRfJRRuNPfcNfedc/3AfKp0A2
         bJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785403937; x=1786008737;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qy/lYkB39glEo+b6UORWBDJ5VWBIRtRvC3AdhiuvDds=;
        b=FGPWwsafMLBgdOpo/Vlp9wNvv6oZwc5tUva1Gutg0Mnax5Z3Hr1l7gHEdhmJ8mSZkI
         oh5zmxg6Vv3h7yPhaOnFoesezSTwkl80i6nIFhzZbTVyDYIahzJcIUQ6jhJFZadWpdCT
         4zJTwWgL/v3RkpzWA1k3rSDiAWscORAhTzRd/tkj8TTzo1Q724qjxzI/1avvezN8srgv
         e9gamPgMvlXdPETceduc36+NhTQRhMW0fTOM9X8iqKXBllXAO1QKpWvA5yQxE3jI3VWd
         vOjNca4t82oZmE4ZTqioSHF+7u5q+Oay/p5bGYxzjCZU4IxmUYk3FvAF3O2ECA+Xev0x
         2BVg==
X-Forwarded-Encrypted: i=1; AHgh+RoMQpE3c/9wYX+GxkuQKR+nZdrTRfnyC4NlPdThkDFzjhZqLPqqzSSsI4F0MHu3cp9C5tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHDB2JQlei9oIqpOeiQRkQ51WzjiprxzeZLM++thpqY+hRuggz
	ynvRmW4x5CKc2VbZhhSaWqTCwSsLMmA0fB1N2R0r0i7Ejfbosk+X2moR
X-Gm-Gg: AR+sD128dF0ReOV9FZBFkdJJYkHQ+7s3nMgeyu9JWZRLY445wOON00qc48c9WZpgd6W
	ALpfLTGqtahwhZY4L4UFoxiDZ81sDGwFhJn3W99/JZ44/tGDdjxI5apIQ5tMthoI6WTCjj30LzA
	ebUsyU1P7QZwcko1H06ZXYlqg62CLDWoeU5zMLfq2jMB1o8tJCDhAX+N7EQRledOShJztrezLI3
	i3sP7hgWPNfP9J2OO11UicdL80E2x/10dEXKDFHWdYUJOW2BkvMLaDhfJXYGEfGE7S8m7jJrjTu
	JgFpVOzCNY7CQk1VKkSycl7Gbw70G4d0PKWFAfTzKDl5QNdF9rgUtpjRDFzl6rxkI+wp/2HgWD/
	fj48kuwUjNF6XsgSy5C1OckPCOTRqELt/zhnMv9z4f8wc0d+1WssYgWgfYqG6QrdI8nW9hnl56c
	+pVBB1sSXjiLem09zIM/GDOxrMijTovPP4KfyqTlvqrZPXRkgxEzXtDMD60DQ+2KZBUIB5iOiR2
	RSVtX8yVtBYVKEx9T0GttA2ipX+qQwLcs7CVwnV+2c=
X-Received: by 2002:a05:600c:3b25:b0:495:3de8:33a6 with SMTP id 5b1f17b1804b1-49800e80f32mr21493405e9.16.1785403936828;
        Thu, 30 Jul 2026 02:32:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc893fe58sm7655949f8f.31.2026.07.30.02.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 02:32:15 -0700 (PDT)
Message-ID: <2574f79a-f04e-449f-aeb4-10d68cdc9437@gmail.com>
Date: Thu, 30 Jul 2026 10:32:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v23 5/7] branch: add --delete-merged <branch>
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
 <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
 <5fd74f0050e5af1f2ab03ddae56dc96385e6a237.1784979136.git.gitgitgadget@gmail.com>
 <1f282ad4-9937-4c95-89d4-70f7a1c883a8@gmail.com>
 <CAHwyqnV_Uj3anbU9xRBtEUP3M84y9obK6+kx3c1s18NV2ta8eA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnV_Uj3anbU9xRBtEUP3M84y9obK6+kx3c1s18NV2ta8eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 30/07/2026 00:13, Harald Nordgren wrote:
>>> @@ -38,6 +39,7 @@ static const char * const builtin_branch_usage[] = {
>>>        N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
>>>        N_("git branch [<options>] [-r | -a] [--points-at]"),
>>>        N_("git branch [<options>] [-r | -a] [--format]"),
>>> +     N_("git branch [<options>] (--delete-merged <branch>)... [<pattern>...]"),
>>
>> I don't quite follow this - why the "()" and doesn't --delete-merged
>> take a pattern?
> 
> I don't get this one, but would this be better?
> 
> ```
> git branch [--dry-run] --delete-merged <pattern>
>     [--delete-merged <pattern>]... [<branch-pattern>...]

I think I just didn't understand what "(--option)..." means - grepping 
around that does seem to be what we use for "give this option at least 
once" so I think the original is fine.

>>> +static int branch_pushes_to_upstream(struct branch *branch,
>>> +                                  const char *upstream)
>>> +{
>>> +     struct remote *remote = remote_get(remote_for_branch(branch, NULL));
>>> +     char *tracking = NULL;
>>> +     int ret = 0;
>>> +
>>> +     if (remote)
>>> +             tracking = apply_refspecs(&remote->fetch, branch->refname);
>>
>> This tells us which remote tracking ref corresponds to the branch
>>
>>> +     if (tracking && !strcmp(tracking, upstream))
>>> +             ret = 1;
>>
>> Here we check that it does not match the upstream branch. That ignores
>> the push refspect though so does not tell us whether pushing the branch
>> to the upstream remote would update the upstream branch on that remote.
> 
>> We need to apply the push refspec to the local branch, apply the fetch
>> refspec in reverse to the result and then compare that to the upstream
>> branch.

Oops I think that's wrong. We should apply the fetch refspec to the 
result of the push refspec, not apply it in reverse.

If we want to pretend that origin uses "main" rather than "master" we 
could set

	remote.origin.push refs/heads/main:refs/heads/master
	remote.origin.fetch refs/heads/master:refs/remotes/origin/main

so we map refs/heads/main to refs/heads/master and then map that to 
refs/remotes/origin/main. There's nothing (apart from maybe common 
sense) to say the refspecs have to be symmetric though.

> I'll try to do something about this, but I removed a big part of the
> push logic when introducing the stacked branches, it simplified things
> a lot without it. But maybe too simplistic.

Maybe I'm missing something but aren't the two concerns independent?

>>> +             git checkout -b tracks-other other/main --track &&
>>> +             git checkout checked-out &&
>>> +
>>> +             git branch --delete-merged origin/* \
>>> +                     --delete-merged main &&
>>
>> These lines look very short why the wrapping?
> 
> Will unwrap some of these.
> 
>> Why do we keep "lower", rather than clear the upstream config of "mid"?
> 
> We keep lower to preserve the upstream chain of surviving tip.

Yes but why do we want to do that? It's a change in behavior from 
clearing the upstream of mid that wasn't really called out clearly as a 
change in behavior for xxx reason in the cover letter of the iteration 
that introduced it. Why is it desirable to keep the whole chain rather 
than just the upstream of the unmerged branch?

Thanks

Phillip
