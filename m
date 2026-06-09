Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248BF3AF646
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999409; cv=none; b=U3KtTd/2bIHssHNSzq3audrm9cFybIdXnFBg6dsYTi31HeU5Gsz4TGzZxUR6G1+JDvUTHRTiPldxZMm78jEUu6mx61MgURwn9QngtqVFTqhH7A4YFi1cm7xpwzdhvQXer1Kj6vl1R3bjr3AC5uZSUDK3JRzvvLfJRcMzUE3z6yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999409; c=relaxed/simple;
	bh=91YPKahbhnhp/hUGhefc00apSkZePLVNQ2rFmqC/pMk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pp7s5af+7pUu83lqVrPsO90nynD5JZPgND4dkAF9gE8qcwkH/A8yky7eYBlaPLinvN9A0NT2YOC43kreVvntxY7dwfsgo8gyPDKrYm9Ci/6gdmgBU885AFJ+WI2oIZmv0FePYlkxNGNqL/JoxpNEgMdE9Oi+09KrjnYjtTKeFhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABB/9773; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABB/9773"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bec43ee8ff0so761795566b.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780999406; x=1781604206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RSqrQCXt2kMb6okwiJlT16ujXPsa2ZOq47RxXcOeZDk=;
        b=ABB/9773/APeewx40nPbblUfXG3Ffm21JXY1x9a/6ffmW5xF5hEXGU0O8dSImwkMva
         XQL1taECSPAEnswviYpEK8PtpabpGYeCKEeU0gAw+jIioLs+Ty+A7CyIdJJr+rutuio8
         Eif3L/CtHg2Ho78WGjdA2/7ohXllwGyf+tx2U78f3MI1cyNaiwGoidlp3RI/7nMNoLcD
         Un2Oh0Yfhr7fuuW3pDPti7O9W13Nb9sbghSICo2ogxFd2ghzF8ykv9FBJ0JLVTh66X8j
         sNF92DKKu8dKde3vbUVCNqtAMX/tGkElpI8P6OjtW9zU4+rT1jfdEyjGkAI0/H6B7V4t
         cZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999406; x=1781604206;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSqrQCXt2kMb6okwiJlT16ujXPsa2ZOq47RxXcOeZDk=;
        b=Inl1gVOLIklTjO8cvkEamwDXV/N86JRaYE2TTA9EyszWuAGeZt0K17rbs6GDMZnrXG
         xBj1im7isPBAxOW6NJH6N+QSKf0YCF5Xfz1rdnC4nTe0oiPJeE4xITmnyOeMBoG/E7bF
         ezWfyzlTy1WZBnlrdCQQy0CRv7xpRPSPsaQ8awn0n3HZuhgAS5TdP7+vFgTk/Oes5+8R
         /rEn1zuSkTqrYGCEwviGjHWHiIPMklgiMVAVu6bz/62KyIC8/aCXcih+h/OOZM3ZzL3o
         gKYd6du3q0tTt6oBkFItdaKFPKvC2BS8SeojWaZa+XxwptN1pjaZGBxIxprlly8bDy5A
         hgnw==
X-Gm-Message-State: AOJu0YzJImTEonr62jqiki8ck4hxdIBOFgyqrb5mOrAsmp0a/bAUH5A8
	abdW/7vjv+PKNjdD1rKM5nMOEMeC4YydlXSjG+6hCoJwbaojkpniqMUr
X-Gm-Gg: Acq92OGSqJ9BUqMvnH3wtmoLbpVprlnwPIR4/5K5Jt6fWA3nJzt5kNCQ0sf8mIp/Tto
	5zCSAACuDKNv1+0CiFXq/RtVHZXfWSEMp5blQZH8O4hExoMBIJi7Lo00WWexGmMZCrm4MrKK0hi
	gUosKoy8nDvLlZejCAApzG6xeSoBOo9nfmeQkFEIvQzYORTe9g7JmGPP4FpOgW28eG3xn4bT9zn
	BUKbnMEhssB2HJfN0hzL2Qrf1Y0S+b4CxVj3YOEp+e52SSPHhyHIk8SflFiDq0wOqi6N0pHNd/K
	fPdmLofrwRiL4wcXtPNRYF5b3H3kXC+gv7FjGDFiYSa/g3YQfsA6ALXk8z4yVpwCVjL4yvx53On
	zMRxx5GSHJqayc3ptTvE05j+Iv4/unFNKYEP1q/8iEx5q3NfOTc/Ow2IBF2Fy9ttJ0sZBTIoywH
	YwtRoANPm9xO3czwtDS6+i5zQvZYuAXSnrOfSvdoo0pqu4dKMg5Saw2WU9N7Zh/slCio4hENkbl
	sMPSYqui5lg0dsR43zXp1NV1UM=
X-Received: by 2002:a17:906:c104:b0:bee:7c9b:fbcb with SMTP id a640c23a62f3a-bf3a68ee6c9mr849703366b.5.1780999405807;
        Tue, 09 Jun 2026 03:03:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:56bf:64ff:fe70:f122? ([2a0a:ef40:69a:b801:56bf:64ff:fe70:f122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e051b0sm1007054866b.31.2026.06.09.03.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 03:03:25 -0700 (PDT)
Message-ID: <b9055227-f6e8-452d-928c-d944ad840f31@gmail.com>
Date: Tue, 9 Jun 2026 11:03:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/9] reset: introduce ability to skip reference updates
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Pablo Sabater <pabloosabaterr@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
 <20260603-b4-pks-history-drop-v2-5-742cb5b5176d@pks.im>
 <0fdaeec8-99cd-4dc9-9549-8a08133deebf@gmail.com> <aiaH3ZmFZfmWYwr7@pks.im>
 <aiaI6thDj8y_EekG@pks.im>
Content-Language: en-US
In-Reply-To: <aiaI6thDj8y_EekG@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 08/06/2026 10:18, Patrick Steinhardt wrote:
> On Mon, Jun 08, 2026 at 11:14:08AM +0200, Patrick Steinhardt wrote:
>> On Fri, Jun 05, 2026 at 04:12:42PM +0100, Phillip Wood wrote:
>>> Hi Patrick
>>>
>>> On 03/06/2026 17:14, Patrick Steinhardt wrote:
>>>> In a subsequent commit we'll introduce a new caller to `reset_head()`
>>>> that really only wants to update the index and working tree, without
>>>> updating any references. Introduce a new flag that lets the caller
>>>> perform this operation.
>>>
>>> We already have a flag to update ORIG_HEAD so would it make more sense to
>>> have a flag to update HEAD, rather than adding a flag to disable the
>>> updates? It would mean updating the existing callers but I think it is a
>>> clearer api and it avoids the pitfall of
>>>
>>> 	RESET_HEAD_ORIG_HEAD | RESET_HEAD_SKIP_REF_UPDATES
>>
>> Hm. The question is whether it's sensible to have
>> `!RESET_HEAD_UPDATE_HEAD && RESET_HEAD_UPDATE_ORIG_HEAD`. That feels
>> like a somewhat weird request, too, and we'd have to introduce extra
>> logic to make that combination work.

As there are no users at the moment we could make that a BUG() and 
implement it later if required. At least that way we're not introducing 
conflicting flags, we're just not implementing setting a certain 
combination of refs.

>>> I wonder about the function name as well if we make updating HEAD optional
>>> then what does reset_head() mean? Maybe we should rename it something along
>>> the lines of reset_worktree() or update_working_copy()? I'm not really sure
>>> what a good name would be.
>>
>> That's a good point, the name does get somewhat awkward. I think we
>> should keep "reset" in there, but `reset_worktree()` to me reads as it
>> if was rather related to git-worktree(1) than anything else. Maybe
>> `reset_working_tree()`?
> 
> I think I'll skip these changes for the next iteration for now. The
> patch series has already exploded quite a bit in its scope due to the
> refactorings of `reset_head()`, so I'd prefer to maybe do such changes
> as a follow up.

Renaming the function can certainly wait. I'd quite like to sort out the 
flags though as the new flag is being added in this series.

Thanks

Phillip
> 
> Let me know in case you feel strongly about this though. Thanks!
> 
> Patrick

