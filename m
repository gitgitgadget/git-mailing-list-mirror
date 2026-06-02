Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AED3E1D16
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405404; cv=none; b=NJ/WD+c5tqF2Y4E4PSlZppgs8eK4zPLJSJDTF6lqt8xBbFf0jXzHS4Ydi4YrB7sCdAjbgEyvP4O05RKFjItvzyBl15Dufa2xHpDtkrnqQvfSfAzvLcvXexbaibbgHhwTiMo0XWjM8sgW2bEGHyAAClfZR+e62yrhuqsXMkqQ4lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405404; c=relaxed/simple;
	bh=73/cRLzO/rbjNWATsrjVYtKcbvBwjdduIMpIKAapiqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mY+ktV7Bq8jBemAgDo3/2NZezDAZO9axIS5KFXThHA3ts1lHoayJN9IcuN4TbYIT1g8Q58FRi+bnbfT7R6oRbAHJY7xXtpKc2APCHBFV2NjFGov9yHkESv8nxXBjMO7kTSWFmpR1lOHbH68EBc191pb0Ovb+YZXjpptok9S+xnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPT3MArZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPT3MArZ"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bec441e4018so287463766b.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 06:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780405402; x=1781010202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0cFSD/FhpuI2/u4eqXN8aYn5NiAJwS1WUcyv/FFYmVI=;
        b=nPT3MArZPtSyvAUppYwtxFdRjn2nfx2w6VOtOMUvDlprLJ3FPEx/L94cd0kQY+YxrS
         LKVhayusGpo9LAlvuY3hnfbwsJWE4KFB0teVkK/JOG5ur+2cddJPIQHN0HQJu17yuyGT
         LEJEM4dO/Yaenxnl/ETuS/f+tRdk0VkKvhfkK6ZvBsPG4hvpzmv1Z8rU6k8w9dSspsW8
         /rlSTAKJnUGEIAnsM0b7hALIhEXLm5BiR0/sM0OH8QxrTZj+NR79sFiD4EA+pT7sKnKd
         h864plIpbcvsqgoTuEDf347HFDhYTNvW/d7hApfkAj3VkIN+OyLmOh00YC/vHtvaCPPR
         RkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405402; x=1781010202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cFSD/FhpuI2/u4eqXN8aYn5NiAJwS1WUcyv/FFYmVI=;
        b=Bv3HHoxzQxJ287eSw1cj8uO3b5KGBiWR1p9fuLn+vEPE4XL2OIgOOMXz0pqi9hWKCH
         +rKtkVHSXGn7u69fursSbYEHpKYKPBaK6V0wrhul2OzAa0dAcTxNr8fiYEdqPITDn9s/
         OmcIcaUbyPdO/10a2fRoqPLFgJCzFkT2V33pZ0m/CrXNBDktYBl/nFfVQ95cpl4T2YKS
         08AuDEbTWCFazJVWNmlBOnCqPNZjaj9wW3zgj55bM3uLmsVQ2tJQQOCSEQrW1uVk/imE
         PqVok93GT26q+JeSmLMKwchpd3twIscgm2Oa6jqNGRKQH+Lbpz2/GA/Aow4bUM1KleNY
         Cgjg==
X-Forwarded-Encrypted: i=1; AFNElJ9ifl3y8cynndEyrBngj56j7I+JEZUUFt5w3xHI/T+5mHVHmOS1K4EI8bVxvyGgeWU0k5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGYoxwsWEzTvtB5YPG0YWN4SWTsRbloJDJFPd9M3xbMlgzDX44
	TE9xcLL48ixj50AcYvg0S0RZ79KLKCRmMhwYvcqxrHlxSlqoLSqVxpS3
X-Gm-Gg: Acq92OEkAbEMDg/bWWLoDoAH0pHEffLbXl3AOQRKfZYIekCg6lIdcmSaYTEJ4E4Sh1S
	7IomNxOaug4WMZfU4uG5CvUvm/2/oBFyKSsEGJkAIK4IQJHnAy4QMLNQ7Upmlkz3SyYPMuNs+4E
	W2TtwNkgP3LbTIE81JBXH8q51cMA5J8fzQLSMUKOEO9hdDElVwbJXu+umngoxSBFyj9GO8j1ol1
	zut8ED3u5ZjbbzYi0TOBbbQqS1Qzq9jp1PUjF4Wmsy1yb/JIAut3ikXYMZNPbQlU+z91hWzmNzD
	ydHe9TM3X2yb4KcKd4lXvtPGd4eeS/MtyXzBTkbtkUXjLTvAKHaWJ/8mwcohBtsob+EvYhRdDh5
	wHtDcOFjFXNlgze0JHkHDM4BOfVykmJkqQFipuTIXCwZalsSjfMbBYdP6WOHOVfqVHjgoQVcc4u
	+MQJH7gjZ2qCCEHzbdr672EISF0ftjShKm8TPkJ43f9l3Lhuh9Y2FbXX8775O7E9v182x3RWQEi
	ZVShp0UC0AwxA==
X-Received: by 2002:a17:906:3097:b0:bef:30a1:8c52 with SMTP id a640c23a62f3a-bef30a1a3aemr163919666b.46.1780405401379;
        Tue, 02 Jun 2026 06:03:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-beed0fc9622sm140447566b.30.2026.06.02.06.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 06:03:20 -0700 (PDT)
Message-ID: <8ebc3d98-40a5-4e99-a205-34254cf5172b@gmail.com>
Date: Tue, 2 Jun 2026 14:03:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH 0/4] teach git repo info to handle path keys
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, git@vger.kernel.org
Cc: jltobler@gmail.com, lucasseikioshiro@gmail.com, gitster@pobox.com,
 phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net,
 kumarayushjha123@gmail.com, a3205153416@gmail.com
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/06/2026 16:19, K Jayatheerth wrote:
> 
> So in patches 3 and 4, we add both `path.<field>.absolute` and
> `path.<field>.relative` for `gitdir` and `commondir`. Initially,
> it was proposed by Ayush to use `path.absolute.<field>`, but
> this would break the lexicographical order of the internal field
> array. I tweaked it to place the variant at the end as a suffix instead.

I don't understand the comment about breaking the lexicographical order, 
surely it only breaks if the new items are added out of order? Why can't 
we have

	path.absolute.commondir
	path.absolute.gitdir
	path.relative.commondir
	path.relative.gitdir

?

Thanks

Phillip

> There are still a few open questions that should be addressed
> by the community. I am tagging members who were involved in the
> previous discussions:
> 
> Justin Tobler, Lucas Seiki Oshiro, Junio, Phillip Wood,
> brian m. carlson, and Ayush Jha.
> 
> Apologies if I missed anyone; I included everyone who reviewed
> or participated in the discussions of Eslam's and Lucas's
> patches.
> 
> Questions:
> 
> 1. Should there still be a --path-format flag?
> 2. Should we consider a default option?
>     Currently we have path.gitdir.absolute; should we consider
>     an option where a plain path.gitdir returns some default?
>     If yes:
>       2.1 Should we keep the default the same as rev-parse? Or
>           should either relative or absolute be the default?
>       2.2 When printing using --all, should the default be
>           printed, or should we print both absolute and
>           relative?
> 3. Is printing both absolute and relative in a single call
>     using --all acceptable?
>     If no:
>       3.1 What's a better approach?
> 
> I have discussed these changes with both Justin and Lucas
> internally. This series is presented to gather opinions from the
> wider community before moving forward.
> 
> K Jayatheerth (4):
>    path: add strbuf_add_path for formatting paths
>    rev-parse: use strbuf_add_path for path formatting
>    repo: add path.gitdir with absolute and relative suffix formatting
>    repo: add path.commondir with absolute and relative suffix formatting
> 
>   Documentation/git-repo.adoc |  15 ++++++
>   builtin/repo.c              |  50 ++++++++++++++++++
>   builtin/rev-parse.c         | 100 ++++++++----------------------------
>   path.c                      |  58 +++++++++++++++++++++
>   path.h                      |  16 ++++++
>   t/t1900-repo-info.sh        |  32 ++++++++++++
>   6 files changed, 192 insertions(+), 79 deletions(-)
> 

