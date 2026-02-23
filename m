Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E411A0BD6
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 02:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771812728; cv=none; b=XMwllLXQFA9nvpICJOMF7u6+UQZTpuLax0TIT2vfLErNznRSSQm6by/sscPROLWdxdLW1Bwp1GuMu6yJlFcRbmy9lcrYPR1XU8kNpsxHNGC3HZp8lHO6w+S5f4fb2HIRDQc8qPEDfWxOuYpBCcHrLNDdvFBUgohAtvT8TjsFmsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771812728; c=relaxed/simple;
	bh=XOFaNxLlI1ceO1tvKpxY016AEiz26stYb9GO7gxr/eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrWPFX1/Xbpj62D8eT/+f4O0GPSMEbvn/jxlo25hKutjK/PVzKm7efZ4kO9oouauj8miQgSetPGpAyit6UbqBLJ/bnuAnuIuzjGohhlHuiFJyxkbVmvY+3ut//BaetBNBoQFMmnUTHUbLajw2WPWgchhTBIN+A/FfhHnnBuy4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWRH1woA; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWRH1woA"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8946e0884afso64549536d6.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 18:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771812726; x=1772417526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uiI/NWc3mTMNypa4jIc8lHxFkfHqzntDlrdWJwSoAMM=;
        b=BWRH1woAN1urfdtk4OS6/cnLYx4krsZ1PMW3VWrkLJcZwrsRD2TW5IKiA2ZxIPZgzn
         PQj79zsBsz8clr0EEuTGn3lU5wvu9c3QtEuZYwHt9mXwnc9YJUtVz2fH+EiDarQxaG9B
         mpe2oi5aSTujKJyfxgCRm4af5ySWYpw0DCNS5pkQURJ2nub3vcJcTn4hs7ICzG4zGUTR
         Tq5QKmg2Yt/8y8inUmp3dWJyyjKUuKkrlG0Di0iYkNZB97Wi5CAgTRRMyvhXZxL50Fvr
         JoG0WpOSMwm+vZFMBZ1Usznwt8kvuwwHyhlb03oALk4fd9Iz3i4BcsXacoZH2yqXSQco
         h61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771812726; x=1772417526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiI/NWc3mTMNypa4jIc8lHxFkfHqzntDlrdWJwSoAMM=;
        b=qYHIdzLnYgyA/zsYRbFyzvgJ1mveqVc7VEnv7OS00JhUtShHWYqtbQQU0OIRdDxYN0
         ShsQ3DrsZgEU4oc6ZD4gD4v86rJdGm4pKWZ2nlNS3bJvj93K1nLQlI6q6kbi3RPmJ4QM
         P2j/UlUXdCahp0dfAc2WLpGlavuL0LNHfsr0gfvY1BpUG0vDvkP2d3JLTNWY1BdkuS3E
         90R84Ygyf9hnkoLooIhTi1pVEvUv9pX2A/JJVWbjJm1vTER/E9+l/KQFSiUYKA0TEQ64
         /NzEKu4Z8hDcW9N/4yTDtELLrgRc4qgqnBUYaiHtNJbjejB1SqdGeDePQ9Zixm6ORilB
         VtHA==
X-Forwarded-Encrypted: i=1; AJvYcCX2gVUNiseKgsZr4imUFlNg//uWx+S7c9E8+KDNcT9S/P93tMxrxl+7I7t1w3VqlM7j6Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDfkI3vnsCMCvEjbgKLyYNNufDTP7UU23BH3AJDfnfBji+61NA
	ka7jWgwx7qA6GlNAoBtmhudfEfQZ20hbVnImRAUIf/Mojqq9lDKJ7PTn
X-Gm-Gg: AZuq6aICz8ACLKfvBomZez7MFn7CHtmSOlcKCweOHQ2wDkfre8EpqcSEkf6FYKaoMeV
	5YVu8KXkkzaeSCaT0CSw8OjJn/x4lBUWnH/tFGhjz9jLBws9RcVEQa3ZZBFMjQlmy5KRQsh3rIq
	WxgP1B2rUpJo7UUUan0Q0/nn/JKUUriKhVnOB3tUgMCWCzc9SBIfFlLlYWiAqj6DJ0NCJRps8IF
	ca6nk5+oQ86jIwYoISudUny/zloPZKNM9+864k477v/wCpol/D8JuWqqCxqm95vam71HvN1xIlA
	Z70x05hnnYc56Pc2opg1YwX3NYqurD7TrFCJJ+tbkku1csQDqNeNm48KoDML4MVIqeixjdH4FEO
	6j7Lqc5gtW/Jo7o5mpvETKVmA1u+AsXc+UKRFynk3kVqO6rjev2LPr69C2rdpX/tS5aCV2ZE/v8
	lftdrZi4qLaNTi5FIlUDIZUG649X4ojYgnjSp472upiUvGwXBtyMKfqM2RF5RQDrJyHPfn8QGAa
	exh9tuz3KREQJ7dsmQ/3+gN6ucGKdyxZZji6LyO8/kLhj7b
X-Received: by 2002:ad4:5ce1:0:b0:88f:d4b1:4c2d with SMTP id 6a1803df08f44-89979db61c7mr115111046d6.60.1771812726477;
        Sun, 22 Feb 2026 18:12:06 -0800 (PST)
Received: from ?IPV6:2605:a601:a6b4:9c00:55d0:428:5136:da98? ([2605:a601:a6b4:9c00:55d0:428:5136:da98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c8a771fsm56076556d6.17.2026.02.22.18.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 18:12:05 -0800 (PST)
Message-ID: <8fae2d15-cb0d-4ccb-8cd3-c4775b6666dd@gmail.com>
Date: Sun, 22 Feb 2026 21:12:04 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] color: add color_parse_gently()
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
 <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
 <ddf6131ac9283bfbf4ec9ec000606765d887e6ec.1771026918.git.gitgitgadget@gmail.com>
 <aZQvT_fTlUIJd1DM@pks.im> <xmqq5x7ve3zw.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq5x7ve3zw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/26 11:20 AM, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> On Fri, Feb 13, 2026 at 11:55:16PM +0000, Derrick Stolee via GitGitGadget wrote:
>>> diff --git a/color.c b/color.c
>>> index 07ac8c9d40..ec8872d2dd 100644
>>> --- a/color.c
>>> +++ b/color.c
>>> @@ -264,7 +259,8 @@ static int color_empty(const struct color *c)
>>>   	return c->type <= COLOR_NORMAL;
>>>   }
>>>   
>>> -int color_parse_mem(const char *value, int value_len, char *dst)
>>> +static int color_parse_mem_1(const char *value, int value_len,
>>> +			     char *dst, int gently)
>>>   {
>>>   	const char *ptr = value;
>>>   	int len = value_len;
>>> @@ -365,10 +361,25 @@ int color_parse_mem(const char *value, int value_len, char *dst)
>>>   	OUT(0);
>>>   	return 0;
>>>   bad:
>>> -	return error(_("invalid color value: %.*s"), value_len, value);
>>> +	return gently ? -1 : error(_("invalid color value: %.*s"), value_len, value);
>>>   #undef OUT
>>>   }
>>
>> As far as I can see this isn't really about whether or not the function
>> should be gentle. It's rather whether or not the function should print
>> an error message when it sees an error.
> 
> Do you mean that this error() call is not die(), the flag does not
> fit the usual "gently" criteria?  In other words, should we make
> this call die() if we call it "gently"?

This is an interesting case where the existing color parsing logic is
not following the typical pattern that uses die() on a failed parse.

If we want to change the behavior to die() later, then that could be
considered, though I don't want to consider the ramifications right now.

I think the easiest "local" fix is to use the 'quiet' way, though it adds
some asymmetry in the config code in how it uses the 'gently' parameter.
Let me give this a try in the next version so we can see how it feels.

Thanks,
-Stolee

