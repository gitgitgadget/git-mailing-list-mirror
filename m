Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8BF149C7B
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782762507; cv=none; b=GjF8FVFWxPDcaxkAOj+E+S4qvDM5xOWYrgbGy8+cCLf3G4TVsXkpgSZN3irQz9lCoRiivFZh+qxrh+jROOE13OHDdSZcj0ENhoaHCCme8WgfCeEtaethyHpwF81525th/ZkYJJv9MG4ywQlWcfY/0HNZMK7bDN6s1bQ+wLs1/2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782762507; c=relaxed/simple;
	bh=jThc7577GD8ICKV4znG9XdbvAnhSeOOp8J7vrywrT2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEF6SjaUxHKPYElKe77pZXECNx8OkBxxatVhY79FxWTrV10CruVD6GSK/68fIOzAqSdfGfojnhYRJXMVuZCy8H2D6RyteF6KKl75vFdR2byA6QzWOhafwOr3xaWICLQcAu0qTzTda+LANnfpMPnhvjc2CeTClOcGzCcsRLzY9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxpFP10o; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxpFP10o"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4938d60c035so21343225e9.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 12:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782762504; x=1783367304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=haC6VBCCFCxOxh93rtN5UjMg1pxpE6AFWG2HcXqZZak=;
        b=pxpFP10ohKp/0qD9UcrrsukN8DJX051dUI9QbHL+lp9zV7qcx6cgF/HQUERDFa6BXF
         mozxLkV4B3rtquCwAVeoLqrLEy0uEcXkwecHkBdxi8jxFNx8LEJdFUrgZpdjS8VtnfhJ
         wGFHA3ID7GxHwsrScoTpf3Vy/+PBVBn66QnjJYausZBlIZTdhua5VJfg68f0r71pDzxj
         KYcFj8F016TbLSJ5KK+avUJLZE8owABtpPQKk5YSp2CFR8txgB/ekB0n9c7+5mNQql7V
         y8l9m1JfdOXcX/RAwv7a4gAhmR/qMC2FMwfCOQahtiDmrAqwucis57KU6a3Ws723megG
         C1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782762504; x=1783367304;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haC6VBCCFCxOxh93rtN5UjMg1pxpE6AFWG2HcXqZZak=;
        b=q8J9U8YbznSALS/ZwLQsHVk62oMzVBcyFNTpUdt3rqEs69TUfYD1vHn0E06xrBRkvA
         oLZhcNDTrLllDf76zVPoMrKfRw6ry+9T8XnvwHmJgqKD5HSbRwlfmw0w9V/qJo5Qo5Uc
         JsCHdA3/JCG7aduaPmleIrmpgFs7ViKkPQQEnfn/KSv/PGN8SEeWXTkHz11NAfLuV7ka
         c4TAgwsbUVauetGx8ap9i9RU0bzEacfTPoLzHVaK866tjtbNLcI1P7wbi+1LfO7trUGW
         Frqvd5EBSbZbC2L0dqulz4V7sx88SkFdd58HpGznHl+g5gs8/9uinrUQ19wctKxpZIxF
         m/GQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6OtXxEHpsuq2cQlEDSvgaHhV8e/kxFz+qqgAIEt1fjraInZIm0DWfGNSOK34at/VBb6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxbktQCZ+KSfikULy52V+K1u8Zl1ZA+auhIcU3H4nEaL0BkTIG
	bUhEdEKZgdGDUoxJBVmiHMdf0b2NZaBX1FoykUknpvg1ulsEYNF+XC0G
X-Gm-Gg: AfdE7clJSchjCa3xMV5l+t04yIVxKmwBCPp/zUX9EF78lK/nyePo90xQM19k6+s2+wK
	YtNPCmZ4NBCip5OY0Wym6UK56REMRVyJYaeqvD978Dq79KK9Dggm087WFsAwm5uSf1e0ttL6eAI
	CjxfqSAdiMEZUSQAfpmJOKjxjA6F1xNnv31RoXSf9ZubN9o+ZMVnu+IKbvd/JQ2N6YLCpaF55rZ
	zK1xsG0+6XfCbe0vh8IDFH3R1Mby2DWKNe3OvNoYy3uQKAKREaxKJ//G6H1pm1ZiOWSv7CxUmeG
	zx6lqNP1kO56cQRGggHU+G+Pt5wjF6sSazn0/Z4rX19WOteDH+k3qAGDwFup5MrMoWoyuWF7LPF
	sV8sv+KmeNCF6BGtWEudr8SNNj7Z5RmcOdW17srnyh4wJ0J3UgaSrAgvZN9hGATQeDEXzVmF5Pu
	5p3474FRgJ0hTpGnbM6Lp/r8mTJUF6E1uERJsB9mTq4PlnLBk2ABklnp1sc+n0DkDuGxc=
X-Received: by 2002:a05:600c:3b11:b0:493:b3ba:84b4 with SMTP id 5b1f17b1804b1-493b82bc036mr15432535e9.29.1782762503876;
        Mon, 29 Jun 2026 12:48:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8c7b82asm12060115e9.8.2026.06.29.12.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 12:48:23 -0700 (PDT)
Message-ID: <dff9378a-267f-4b49-bee4-615b4bf75abb@gmail.com>
Date: Mon, 29 Jun 2026 20:48:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
 <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com> <akIQLM6xZTHBudWT@pks.im>
 <3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
 <CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/06/2026 19:03, Harald Nordgren wrote:
>> So instead of
>>
>>       # This is the combination of 4 commits
>>       # This is the first commit message
>>       Base subject
>>
>>       Base body
>>
>>       # This is the second commit message
>>       # Another subject
>>
>>       # Another body
>>
>>       # This is the third commit message
>>       # fixup! Base subject
>>
>>       # This is the fourth commit message
>>       # amend! Another subject
>>       A better subject
>>
>>       A better body
>>
>> We'd have
>>
>>       # This is the combination of 4 commits
>>       # 123 Base subject
>>       # 456 Another subject
>>       # 789 fixup! Base subject
>>       # abc amend! Another subject
>>
>>       Base Subject
>>
>>       Base Body
>>
>>       Another subject
>>
>>       Another Body
> 
> I think this makes it a lot harder to read. If every commit body was
> always just a single paragraph it could make sense, but it's generally
> not. Look at the commits in this series, with no delimiter of where
> one commit message ends and the next one starts, it would be very
> confusing.

You've trimmed the line where I said

 >> Possibly with a comment before each message saying where it came
 >> from.

So I'm not against adding a comment before each message, but I do think 
we should omit any messages that would be commented out completely. If 
you look at the rebase example above you can see there is a mass of 
comments between the two pieces of text that make up the new message. 
That makes it hard to see what is actually going to be included in the 
new message.

Thanks

Phillip

>> It would be good to error out if the user tries squash a fixup! style
>> commit and range does not contain its target commit.
> 
> Good point, I don't see a good reason to allow this.
> 
>> There does seem to be some support for merges in this patch series which
>> I think behaves pretty sensibly. If we have
>>
>>             C - D
>>            /     \
>>     - A - B - E - F - G
>>
>> Then squashing A..G should be fine because the parents of F are in the
>> range and it looks like we support that. Squashing should B..G without
>> --ancestry-path should be safe as well because B ends up as the parent
>> of the squashed commit but we don't have a way to disable
>> --ancestry-path (and maybe we don't want to add one). Squashing F^@..G
>> might be useful to fixup a merge (though perhaps amending F rather than
>> creating G is a simpler way to fix a broken merge). Squashing E..G does
>> not make sense because the range does not include one of the merge parents.
> 
> Thanks for a good explanation here!
> 
> 
> Harald
> 

