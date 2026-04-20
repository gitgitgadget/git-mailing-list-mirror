Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084A39D6FE
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776684961; cv=none; b=fjdCqNV5ZYzQ5vBgZF7XcIg6jZ5QYdZoI5oOpKaF3WFLq0tLSvmcpAn541qhzx5e3tGYykAh7fjtHL4SWTYOoYdZzB+Cl3AkvSQweGtO9WXQPVJ2vOgwb4VRqEOPPTSb/E2q0xG5JhKZTOlwCqTM/Z7olD3sV1mWhguGFUB62Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776684961; c=relaxed/simple;
	bh=kB/JFf/dOvxu63yAzo4WtXThz/2oRy+ylVNzTdMMimo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLRKTbcAdAq+0cYXrGJalkRnYIKyMSbZWha5KN7VjHmkCznvKrN3cDCu+iaOcfX51M1TYymWhjv0uc9g4Vj3Pj32ntD3Y+76Xnpm+a2dVTgmR8ODLsO+psemkgrQBymCVCRC8sZAtfaeE+hDIpLYL7CiDK63EVIL6ItIAamT958=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pwdi0rr7; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pwdi0rr7"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8eae9229110so149598485a.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 04:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776684959; x=1777289759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/CWVAzor1FCh89m/ZPrHe4SftBnZ0mmdBrO3WG2pwjI=;
        b=Pwdi0rr7Lami66CXEytjBSvLLgxsRdEYNjyfpKIXs3uxFSfw96bqA5JF05B2zHJ1It
         msjfQl3kGFAhxA6wfUSzc8VvwjeNdqmzBeyehxNJIE6jY1Hv88nkv+oALcMYc5oMgyJZ
         GiTp8PZDjZsnUHGJkp2LmTsutcUlYakTeDet67n4HrKd56qu/0m6CV8ipWiN9Xwtm4au
         6kfM71IS6cdUXS3IRBDshLjeanmSX8ugyj+mw//PqwO0ojUZpjNwiK9D7dJt1J3ARTuN
         L1QVkCN+jnrUayR9Gfqywnob/eWbia20X0QPjCF+jYXgS25oG6Lj2faPT5yjgUN93FxG
         wzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776684959; x=1777289759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CWVAzor1FCh89m/ZPrHe4SftBnZ0mmdBrO3WG2pwjI=;
        b=UF6XUvgBdlmW4IX1nxlLRoOX4MT2+P5NrZcn6wG6H75v4osaKTyla/q6+V5uUGcMXv
         s8k2LKN/5MXO3macVZ7ukoQzOXNM0BQ2Dtk6Br8DTove/XX+PrcUlejQu5O6UzUa7gou
         C7jAgV0CL/1S6HPvCVdaBVhaFe0AKKA12C8v4qqTKO23yBYksHmbTfCsD7DSBJ7j/zR8
         8iCzPGZJc0CCdPWHail93irKKs4oSFPzHLUPEE5Al6cjGdTWyRJ7rr6sPRLtwwri9vKw
         nMoauugJ/0Wlstb1xcvCmEckDDV5yCMPiy7PZRgf9ymCL2yIBZtkzn7TAUnRQRzkS8Yw
         oT5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+yIvX+51b8ycHUj91GP17KvVDR5PyhE5wSc3d2wi3iv/DTK60pGiIOiNQ/nAe0BXi2GH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBev9xA6w8u1EMKgrBFcqj1W4Fmfat1eLJkzhv4GtqJRY5ZirV
	l1Ca410X0kNsPhUdARqtfY4tv0+3DQwaKFcZim0oys85pW/c8/pDwzWFxYY013Kt
X-Gm-Gg: AeBDieuJ/a3a0vrHD+2uZ6IiXjASXbqzmlBXZy5WGGTK6Rd7xTp35qQKBckjnjpH11L
	Eu1SEIquZ8p2VgiSQUJJcuqUmE/JtoY1wDqyPKqeUbgFr9ewxd8vg4OoURf8IcIoRkoEDNGc96E
	bqdJ200ly/ms6dXWSmA27kF6SK7+EXJGPi/uH8ODo0q2Qqa7ugzT9u0YbZjWoLqXRPCaCx54Ajp
	K7OklxWYVpDTNZcvVkb/cdzHgyzlMrSwpul8PzAtNB/AS2o9Hjjove3PXov17gk8+571jHQBsSF
	uHkIbKC3ugXtxkcaQ9r5BvRk9+15BrporipY6aF3vpOTJYLuztjKSwAN1c2YOBBh+ZN0NttiuYF
	b1FqOtyWc6ZPRDVU5IhV7JjhzNR+il8q7+xbyMQlym8ubPutmXzBwrVN8fzqTfMQdLaYLCdibW8
	wypy8LOEU9CMCk1yGfRKAXU0IzQQAzaVw9WqdcF9rhw4D90drPHr5wQYaPgAofSjAFJ6zF4EFhl
	Csa7vj6FupUP6/zEqg=
X-Received: by 2002:a05:620a:5be3:b0:8ea:addd:8942 with SMTP id af79cd13be357-8eaaddd8d51mr444239985a.58.1776684958961;
        Mon, 20 Apr 2026 04:35:58 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d92ce037sm754678285a.32.2026.04.20.04.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 04:35:57 -0700 (PDT)
Message-ID: <5a7d7847-90d5-4d64-8b7e-67731dcbf1dd@gmail.com>
Date: Mon, 20 Apr 2026 07:35:57 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] fetch: add --negotiation-restrict option
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, ps@pks.im
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
 <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <9a25b0fadebb5f0219ceeca9496fc6f84abd020c.1776266066.git.gitgitgadget@gmail.com>
 <xmqq1pgf6g5g.fsf@gitster.g> <5370b884-30e8-44a9-a52e-4c518556fa24@gmail.com>
 <xmqqjyu1udkp.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqjyu1udkp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/2026 6:32 AM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>>>   		OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
>>>>   				N_("report that we have only objects reachable from this object")),
>>>> +		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, N_("revision"),
>>>> +				N_("report that we have only objects reachable from this object")),
>>>
>>> Is OPT_ALIAS() suitable for this?
>>
>> I was not aware of this. Thanks for the pointer!
>>
>> I do plan to make "negotiation-tip" an alias for "negotiation-restrict"
>> based on the new preference for *-restrict as the "real" option now. Is
>> that the right way to do this?
> 
> Let's see.
...
> So
> 
> 	OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, ...),
> 	OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
> 
> would be the right combination in the correct order, I think.
> Mention the official thing first, and then tell that another thing
> is an alias to what the readers have already seen after that (e.g.,
> c28b036f (clone: reorder --recursive/--recurse-submodules,
> 2020-03-16)).

Thanks! This is indeed what I have in my local copy in preparation
for v3. It helps to have early confirmation about this.

-Stolee

