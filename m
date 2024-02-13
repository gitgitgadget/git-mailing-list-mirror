Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BAC482DA
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830099; cv=none; b=YzX4wqsYw7W7x1SJiySpu9CU47bgSn0jwaN7pqzmUQMcJO9Tu1RDo8VPVlgBZQBChKpqO10wmFsYpe/mcFv8pPZuPvVzglghm/zPwu44Y9YejR4bTkf1zxCgIlN3kBCtur16q9zL1Re0N2ZaSCcXmvSogPF+0l0DtBs8HxSalkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830099; c=relaxed/simple;
	bh=5fPr1MQasi/XXE5A3aGNBEt2+cEk2PEZuAv1gfuHbVo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=d71O48G69bXntNQp5K7ctVaYt66SSw8haShB5IIre2FmmQ+UbKIjH5FnaiN6LYRNUAwo1pKX6+pwI2tm6WQAH8FFhesgicO5k8aKPLq1iwdoA4enFip21DbXcWGPM+S4pBAQEnzmVrO2Alvykd/y1xCkAdWDG9aLzUV/0Us79Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5pgIdvN; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5pgIdvN"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-785d5705681so170727885a.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 05:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707830097; x=1708434897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nKYt0W+BXJhZ9OmerZk8kMwSghlJCerjL95D0sddtM=;
        b=m5pgIdvNeULrm3HSP/r8I9hQ7ORwoPjCHvVEQ9OK6O3UvR/HMCIPMv1MAnAdBoobrP
         Q8fVYdZO7RjfOJrreGOcnwwTFjMkVTlev0QENr3Ha+uUUWZy5EaTy17Q9y++vWOUsZ/w
         4n3/ZHnfww6B2DBRoFp/qnKSQghL78tue2SpL4ThWI9YA6mJpzynp+OfZYOMjfaeaBeM
         haP2Np7C3NGll/IqZM/q4sWPWWMusnFqWi50/dswO4JsuCK6gDj6+nV76VbnhF566KG/
         bJIA6RkZYTzVBFMH3BhltJI5/x+BNWUCn8BePmlrJkWExq1BF33TZaXY641d61s2+clB
         YWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707830097; x=1708434897;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0nKYt0W+BXJhZ9OmerZk8kMwSghlJCerjL95D0sddtM=;
        b=soX1z2gnVZLqgYxkheQiaEw7tKTAYJCjx1JvQVNHsIw8EOiVMxNShYtSLcEqodDDAR
         D+JT2MeF2n4pxpYlvbnwCg+P9rEr/aWYWt02MUlAJixFPU7uX93/l7RK0cJgCDiPxVPu
         tg54rCgYRY6Ewa6Np1ZJes9mqPtJVNxnsqdpptYhVYjZzu+S3x+eMQ8DTbmUol6zDt4s
         d4POPCwMs7ri5b/5qy4vNyFzvrFHr9a+MYel1l+zxjtddx/KbJdgi8fNvvNd+3rWYcDI
         8W2oR1boVvqsAAcdfXp9GGrNzbQsaN0HW5b2dgo5Z1XK73J1Kv1RdSTcxChgT4kmoTbb
         itfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmUAv01GaNpFVWLhrTWo/Skd45MT9UQ/cNXxYaNTxmRXcSIKVSWXfo5MBtvK/EtYejGkCUDAoaVUHqpjpW/tpSCc0S
X-Gm-Message-State: AOJu0YzO9l32c33BnCECELMi4HReEMR2ft0W0pJcvpQ/skja2MVgssXu
	Daiv5rkiPt2GuoZeS5llqRKUUKg13hvUyp/ELVLN4XQCalGuzWHV
X-Google-Smtp-Source: AGHT+IETrEpGfBWxzX7GpjU8R6c8kIfGuSHsg8CHf7WyaIs/zC0wcyEFa73TYScGgDuXcnBPlbsbLQ==
X-Received: by 2002:ae9:f712:0:b0:785:c97f:d29c with SMTP id s18-20020ae9f712000000b00785c97fd29cmr4264785qkg.0.1707830096814;
        Tue, 13 Feb 2024 05:14:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuPkbxl4LCenmx3ckB9+o8ElmfoaT3eJ/O0+Tjg6AUdiU0+UoNUxcR5/zlg8cOn/0RV/iZRCowJHBPlyTZo0jXfzRXycYpy5/Adwdo2/a+QOZkvAKX2Rocf5P/RPZgXwtdOE/8l0jkUBAKk09ri95RjIh4WJ2ZIe3dFRjFRzFXnSJFOHDqw2pPIJ5RdbRWq4lnsUKSJfdQ2npbU50fgQe8yE5mUJk1hMeGed5iMHyDNisjkZQBosl454hGmGF0tsI=
Received: from ?IPv6:2606:6d00:17:3855:44aa:3375:448b:8f34? ([2606:6d00:17:3855:44aa:3375:448b:8f34])
        by smtp.gmail.com with ESMTPSA id z3-20020a05620a08c300b0078717dd799bsm810508qkz.117.2024.02.13.05.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 05:14:56 -0800 (PST)
Subject: Re: [PATCH v4 2/2] revision: implement `git log --merge` also for
 rebase/cherry-pick/revert
To: =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>, git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
 Michael Lohmann <mial.lohmann@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>,
 Michael Lohmann <mi.al.lohmann@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
 <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-2-3bc9e62808f4@gmail.com>
 <7a2a0ed5-f9dc-42dd-886b-457641b9bc79@gmail.com>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <8384d1dc-b6c4-b853-9bf6-3d7ccee86d12@gmail.com>
Date: Tue, 13 Feb 2024 08:14:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7a2a0ed5-f9dc-42dd-886b-457641b9bc79@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Jean-Nöel,

Le 2024-02-13 à 03:33, Jean-Noël Avila a écrit :
> Le 11/02/2024 à 00:35, Philippe Blain a écrit :
>> From: Michael Lohmann <mi.al.lohmann@gmail.com>
>>
>>
>> diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
>> index c2213bb77b..80ff4e149a 100644
>> --- a/Documentation/gitk.txt
>> +++ b/Documentation/gitk.txt
>> @@ -63,10 +63,10 @@ linkgit:git-rev-list[1] for a complete list.
>>     --merge::
>>   -    After an attempt to merge stops with conflicts, show the commits on
>> -    the history between two branches (i.e. the HEAD and the MERGE_HEAD)
>> -    that modify the conflicted files and do not exist on all the heads
>> -    being merged.
>> +    Show commits touching conflicted paths in the range `HEAD...$OTHER`,
> 
> if $OTHER is a placeholder, why not use the placeholder notation <other> 
> instead of a notation that could deceive the reader into thinking that 
> this is an actual environment variable?

Good point, I'll make that change.
Thanks!
Philippe.


