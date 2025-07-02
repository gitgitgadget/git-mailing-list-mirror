Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3C4286887
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465240; cv=none; b=k684syeJH857raoa6UoMcGGN+E4dmphsq+wz9I85N1jZU3i1RNu85MhagNPc2oVUSErkZ/SKgGAc5v2q03WdvrHShwD8eFIRsowuedG/pDSBVKhUKowqrgWQBVrcSKm3SSJfe3b4AMbCq3xnDbUVA3/HGpN3G8pejSrLiykXy4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465240; c=relaxed/simple;
	bh=G2X/t697Aj+XbLGggbggLGmlaxA85+dQVaZ6qsRxnQs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jVy+9JDt+pTg6DMne+V9PAr7Qjv2pIeXObdsXye+P2uUqsYUuVlsukmcYosj10L/VvzxHYOKoKQKh9P5G99SfZXWIGlb9gsTEuZJk4SR/nynM/4wNz97Ek04HpefMHhfIhjcV01CRAirt8gjwh/8PHjIgmGSTRvCToVVPnw4Yvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK/XZfYV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK/XZfYV"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d54214adso49319775e9.3
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751465237; x=1752070037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pXu7is2ufAv/2MqE6MP8Wqkqmz4gbq2JWs2DWraRVuI=;
        b=QK/XZfYVO2s/3GPzcgqGnceZW7VErS6nt2Q4sY7ZCIe0G4/DwjveubTwINNJ3hHr6D
         Hvvt1RoeBwO1x667sT3RQwdvWU0uwPVYnkZas2sXtAtGOCvZObdOd3gb7wK3pUXNz6/G
         41EfM4w5dbDl8++7FRen2IE1ywl6Z7BWy7i1Mb0jNBguAI9XVGYDAyTX8bElKotnBfM1
         lUewu3V32d+u1Q52andEJQHk6JpXfaOH00ZauzmAeGs6/957FOqZebKuuNC0pazYHnqT
         j98Ynyazg4UhOZly/BnoLILO905KKnuPNF8Dat/xxY0uqDluh7mOw1lbYega7SEvvaKv
         XY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751465237; x=1752070037;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXu7is2ufAv/2MqE6MP8Wqkqmz4gbq2JWs2DWraRVuI=;
        b=HbPR4n74poHRKe9KmmK3WYKm2OSRJk5eT83cH7RsuEf3Jv0tcVX3uZ2TnYUMbp/tAV
         rJcYGz67srm+LIeb5YzDYrIZzK0Ic8AvsAZOu0+dRU8GxJqADJBI5CGJJYEpsrUHgjO5
         OqDgD+RZUflwHzCIG1CzB+DjJaF4DFt6umPLXuTXnwI6TXb8hRXgn5cLQWs/5UuIJGgM
         oQbem919Ck3ia5j4tyq7sFeTVMV/KBOpUzr54Q2288NC1Wk5QhntQpsOIYHlPWfOeKiW
         m/qVUmkhhi/sSpSHru5od94kNLuLGfqLvwZqzjATqLLvknSt8rBGsvNn+zCHNnxHjKac
         dF3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWmqCI3IrRFviOXfvlRA3QC8gVubFxukqjezL1NtsM89cJLcbE0ZsXMb/bSo47ulgB8L8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4CcvzO6zudPw92l9ibrAuZgr1GTnynAogMbl7xybebP5X5coS
	UOthLbRg6WEzj0J+W7yNYaWnZEqLq8jpGIB8tBSZj0r/fz7TQWgch+5P
X-Gm-Gg: ASbGnctFcin13i/gmIIi27nFRoZM2npG9AiS8O43ZgGCrcu7izt8rCiPWhWk5wZp3x4
	5kWuabLIber6ZkLbAx2LQlDhUIEsOtOd0VdgP9smazhPzAe800Ep3fYW104wYqSRQRBgyCOyPSc
	6CHCLFQXZMClzpGOH1E4lCs48PpPtF1ngB2LU2gEUfLLZWbwm652Ku3J/s5QAtEbwlbsDFpIvG9
	wpL8O+Jx9aUhkfN46nw+NJqqLvk78UQvQDkne3u9mgGuvu8rT5UVVhvlNLaXm4dYI6BMoBqWiLi
	2l+6WLx+rLm8O8NmgXrpYitKnX9t3CK6aQRefkMndglb3sLmhoEdY9SmpSUU9zVEy2xgp31SzfB
	Is9BN21Fs6iH2P17A2E8bruOCNEWvgDcoLynv9fuQGWcm6DRe
X-Google-Smtp-Source: AGHT+IG6sHEe0dN8njUKG8Pi3jt4LvcGr13gCzUKZYfVwZrV2Osbe7IyyhLQf3JqeaXwxfXno3lNJw==
X-Received: by 2002:a05:600c:35d5:b0:442:ffa6:d07e with SMTP id 5b1f17b1804b1-454a7e978c6mr8374875e9.1.1751465236959;
        Wed, 02 Jul 2025 07:07:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a390d11sm203047135e9.7.2025.07.02.07.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 07:07:16 -0700 (PDT)
Message-ID: <2ee8df78-1c8b-42e6-bf93-a5aa42c20af3@gmail.com>
Date: Wed, 2 Jul 2025 15:07:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/4] add-patch: add diff.context command line overrides
To: Junio C Hamano <gitster@pobox.com>
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
 Christian Couder <christian.couder@gmail.com>,
 Leon Michalak <leonmichalak6@gmail.com>
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
 <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
 <b68c58b667c29c66433b4634ad44ee9ec5257e80.1751128487.git.gitgitgadget@gmail.com>
 <xmqqplel17s3.fsf@gitster.g> <7686a5e0-23c3-4e3a-b5ea-3b8c80ba54fa@gmail.com>
 <xmqqa55nlxdw.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqa55nlxdw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/07/2025 16:54, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>>    * add OPT_DIFF_*() macros to parse-options API, as its utility is
>>>      very narrow, and forces those who are learning parse-options API
>>>      to learn one more thing.
>>
>> It means that we have consistent help for all the commands with these
>> options which I think is valuable. We have a number of other macros
>> that define options that are shared between commands and I think that
>> works quite well.
> 
> I understand that principe.  What I was wondering was if there are
> enough places to use these particular ones to make it worthwhile to
> enlarge the set of OPT_* macros.

There are six users of each of these macros so I think it is worthwhile. 
That's two more users than there are for OPT_RERERE_AUTOUPDATE() and 
twice as many users as OPT_CONTAINS().

>>>    * validation of the value range to be duplicated for each and
>>> every
>>>      users of the new OPT_DIFF_*() macros.
>>
>> Yes the validation is awkward. If we changed the OPT_DIFF_* to use a
>> callback that rejected negative values that would reduce the
>> duplication.
> 
> Yeah, I was wondering about that approach, too.  Another benefit
> with the "validate just after we parse the value before we assign
> the result to a variable or a struct member" approach is that we can
> also complain about -1 that is given from the command line (which
> the current code ignores, if I am not mistaken, because it needs to
> be silent if that -1 is there merely because it is the "not set yet"
> sentinel value).
> 
> Or perhaps the valid value range Réne has been workingon canbe used
> here?

That would be nice

Thanks

Phillip
