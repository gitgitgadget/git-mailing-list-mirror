Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1933D4E2
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417037; cv=none; b=CZOlUAIJwBGU0E2y7hS1Lkgy1tgJwz5k9Vbr4azxFe+oqPZKn8qzrH4cypjuVLqS3dsgEQBKPiCYHEoV+Bk6Mso/IJDLCTaMYOAbOUj3AC+bbORNq9ksRa6cAIa88RxB0rEEA27rteh7x7KudT5wD3Ipb5jW4yPEEruwcLkvep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417037; c=relaxed/simple;
	bh=2zit50e8vxrFMNCubRWHRWlR6F0ax/1GLTC6ZEJsN/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpbFajH6lkknzZT3/2TQ3MhdOwWG1HIwsyiYYb1WLj01EieCP0s4bAFZq6l3n/DCGrbMs+8FQ//MT1PCLuo6qrVnt26skxtZqgr0rUTjG+r9xxE4+eyVnNt8zkcZmaGXhITa1dUpZ+DFitQoLJJIHhPAsj4lulCyCWYNDVT3yQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwT5kixF; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwT5kixF"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1f7666a90bso295756666b.3
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 06:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785417034; x=1786021834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CTxzlgHHwnnZHEgi+NqS/Oa5N3N1qWn41PKqfkDiSVQ=;
        b=XwT5kixFFivoWQgy8b5dvGHltJxJSa1JMIZceGgXvOvehxBIbKk7xjWTcpiGsCxzMa
         HUD8M/QDar3zttSTRYsd3sb23fQnUQotYlbZUZeE+gJjjidkD0cZfhpgAIeJpXxE3bKh
         30cgoXXsHpQ9y4O49mxXkD4/dUWp8JYcmQbK2feNvGrKVhXPaQd0grIJrNWG1Qh9T5Qd
         q91GfRTOBH+lAuKcDAxqgT3D/dAuV2KGMh3eBJGydbBOZsWv1gffB3as38vrfTV+3uUj
         hqPz1qRVK/ozlCsoVAKvgKPANyvabk71JTNoMPpdxtYqRn6NFhYW89hPNAuS5WWzj6Jo
         p0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785417034; x=1786021834;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CTxzlgHHwnnZHEgi+NqS/Oa5N3N1qWn41PKqfkDiSVQ=;
        b=JJkDM1REDFDjNtm8cewBFn73eeSOvC74A1hlgCMUdOSSOhAPbOF8rGOIc6IoODTJDT
         5p2BjELzcUaaF7CdqNMzsDo31u6WqRST9nOGCDYZtKeb5zwchOwUmA45m/gUo6lXMCU8
         SnNricLtetcaVurPRGiHYDOcXX7fldriOwsQafd8De0hALhNn19MKx3m6YB9A9FEi28u
         WPyxMpryaL47WNOlIxqc7JA82dWAIFlx+1nplzkNYx5Qd8XntwqEWPUTwUds85k5dzxE
         oByzk+gJGQKcXBirFPQTZEQYo9xPT5ubsSixUyhUob6TP0zTX7NYtJLaYkGQFPzcEKIp
         h0Sw==
X-Forwarded-Encrypted: i=1; AHgh+RropSEP3EryC4jE7cGvM9OcA3pyLpsALS6QnpnoN4Qyxe1xTXwRqHkAl86YhSofCkGXSDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWxIQ0EdvO6gMTkAw9uAgjiW4B0WthmVym/kJcZUUSuiFz7mj/
	kycuR5QOHjrcVL25bvdxW3PngeEEDUTS2OfFgy9uYowzYYhrbqcGySQF
X-Gm-Gg: AR+sD11aWkKI0b4RVc4U76AwPtJeHWV6hmpzvaznHvBNdx3OuD9rEPOiglw5ZaJIXvo
	5BPN5uA/m5RioCiuNaFwuEfDvjPalsEsK5svNWHlrjAZWRCwVq3W1J6gZkn0aI6Gj6a7T9C2rJQ
	O7YDVuoLiqFxZLenIcdSYkLuv27tpRBEMLGwFjn/jsAMB/db8QbESZKKVFAg/MrxEubWP58onzM
	aqYIhY1jIH76nvgsz3h2BRYduub0qpwXxNMoqwHa2Ov4oyqwM6NveqKpc4fYxB+3V490/5PCTHE
	P8iEnUSv+kp8pAQ1l9KGkgGMsJXDu4XHO8qsfYnwm3Aym1k6cFtJT23c2pG8+g2cBPGNe0ay+rF
	/CVdWzz2lHw7gz/A3S/Z2RwEyd2j2jWROoxsWcd/a7TjZ8AsHtcd3gRva27LfecK7uiiEDM8c8o
	edwHUj3tEosjG3rGQWJ5j7OcIB6M0Y+jeEF8Lw6VTWV/+yDF1doF7Y3EnIbAHSBlkIP3R5uMoft
	twblAO+F9HBC+/1JSTNsCvzR1Mr10fk/aFhf5H5cd/tMrP9kw8=
X-Received: by 2002:a17:906:1009:20b0:c0f:de3c:dce with SMTP id a640c23a62f3a-c1fa55cf9f6mr90540366b.41.1785417034023;
        Thu, 30 Jul 2026 06:10:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:55d5:4403:6ca9:2c6b? ([2a0a:ef40:17bb:9901:55d5:4403:6ca9:2c6b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8579b0asm64790766b.23.2026.07.30.06.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 06:10:33 -0700 (PDT)
Message-ID: <0844b4e0-679b-4c0a-bea1-5779b4d0489d@gmail.com>
Date: Thu, 30 Jul 2026 14:10:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] rebase: skip branch symref aliases
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Son Luong Ngoc <sluongng@gmail.com>
References: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
 <pull.2126.v3.git.1784708107.gitgitgadget@gmail.com>
 <b9a01e9141d580606527cb1a658c7c72710fb013.1784708107.git.gitgitgadget@gmail.com>
 <5bece313-6ffb-450b-add1-29652b64de10@gmail.com>
 <00e529b6-7ae7-463f-a4b3-0991e9411aba@gmail.com> <xmqq7bmhycxq.fsf@gitster.g>
 <8631114b-aa6f-446e-9710-92c400320eac@gmail.com> <xmqqpl07fb1u.fsf@gitster.g>
 <61291144-60da-4e37-83ef-fe09e91c4f51@gmail.com> <xmqqwludan2m.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqwludan2m.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/07/2026 15:26, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> But that was about a low level mechanism that must be more lenient
>>> to be usable as repair tools to recover from such a broken state,
>>> no?
>>
>> It checks the new value of HEAD, not the old one so I don't think so.
>> The commit message talks about topgit using "git symbolic-ref" to set
>> head outside "refs/heads/" - peff had previously tried to tighten it to
>> reject non-branch refs but that broke topgit. I've just had a quick look
>> at the topgit code and still sets HEAD to point to "refs/top-bases/..."
>> by default[1], although there are plans to start using
>> "refs/heads/{top-bases}/..." instead.
> 
> Ah, that name vaguely rings a bell.  Is it still in use, and now
> they prevent us from forbidding funny characters like {} in the
> refname?  Sigh...

Yes, it still seems to be maintained, I guess they chose the funny 
characters to try and avoid name collisions because no-one would want 
them in a "normal" branch name.

Thanks

Phillip

>> ... It
>> appears topgit's rebase command is built around "git rebase"[2] so I
>> think we need to continue to support rebasing a non-branch HEAD.
> 
> Sigh, again, but OK.
> 
> Thanks.
> 

