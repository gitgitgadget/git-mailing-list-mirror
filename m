Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0645E27FB05
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027314; cv=none; b=jFVZUK6qkzFyRZVBHzQ4lTAgAGQiwtQ63eoaOOfjyFIB27GH/exN/Z7zhzP09qW86DbiBfxGB/ekLNCrwre4ixxjsIobdtGrSjKMy+LKZLvwMhFkRmMKP/wRZPd309HMm3g/o4zSYNdVJIAXD2p9r+mAKhvntJWU8LqyvJqNR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027314; c=relaxed/simple;
	bh=/YkTIwsyiqVgNKlIO+CdVNQVH/kOccwYr/WiwstZyl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyZcvQm4kDxm6a5Olf3ksRV8zGPIS56XA+wrIWv7o8DeCT3I8zvHeAsr72qsS5lYi5Ma9TgaMwWCHAC+Mweu5mKV7ds4gAGRjso4166dYWjat2FNMVqu+NGZ2Po/2UYCbcx7EK8anwWgxyY12+ATzzM86c2pDkLkBMlrVakG4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqjXl4MB; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqjXl4MB"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89c4468686dso23578766d6.3
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 10:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774027312; x=1774632112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GNFSHCl9unWVqn9EmYVBFFxQZdoXFmWffx/Eqz4Y7rc=;
        b=CqjXl4MBlrNwSMsRLaWI12PdkquavWQjXm7d5HPTyIErcNDdAb/WGKEI2VKJs2CO7Q
         KcuqL8gykdNK81KHBrc8TCbJ6ODB1Sf0NxBQB4I+k7YpSM1LPfc+7bt317Rx/PAUUlB6
         62XDKaud3zkIeH7wuQU8ffo1JGWDPsiVJvG7dDDY7q+HtyCo8WYKxx1aPDHcnySlBWHZ
         KVakdm++hEKH83LjH2yreGiUAc/qfK7hogo3BZhku9o3P5I4kxtupKDO4j4s9lLMAu/B
         EdE3/hvZtXtpNvr9TSXmUhEYEP4vPQY0OugOoTbTloD8ojgQe8s5Mut/Ii05iTXXDOk9
         rddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774027312; x=1774632112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNFSHCl9unWVqn9EmYVBFFxQZdoXFmWffx/Eqz4Y7rc=;
        b=B2NQbI4IUrzjrxq7xP8VykPPHWiCvq+ObKOxpaaHqSY8nIRb+5HkXMkqHL+3bbWEOq
         ILQjaLlq00dXNoj4hhrComMUPU5m7M8TUYj85GAotvWDZHrWcXny9zIUB3UqpF7UlPDc
         s3xjXlbj8xWu7dBZ7XiJS5e1wj/KGsVLtZ8wPcIiDgnabeUeTo44mC5F11jKYPfv6TJ1
         5C0LiDHrYFtZmQRMUloZXF+Cl/4er+SV0abzxVtGOYO7fBqizpKG/ziPxYIWy9o9cMq/
         j6vquAgWskcaRRN7EbmJfRj5cxJl+Bw7vsjYPVRAq1AG95h87I9Zb53vQfCt47eyiw94
         16Ww==
X-Gm-Message-State: AOJu0Yzk9YWh942RuM3g4BVXzqFLmbqrYfx0P9n9PBM6c0VKYfGHG77+
	CBHj2fcU+LOi3I3HkS+/M330uoxGDsPTEIccPsrieVkDbk1ltmM/sqfdNzRCdA==
X-Gm-Gg: ATEYQzwNzW/1fm4Z3YjtpxUrJDnCNKYc/UPRQ21RwQRaI4IuL4UBmFJ0twi6ugslK+Z
	KSqbIs4DG0iKH/ZBEiw4EaMzzlAC31CorIytEbcIEXB5vw1QVluPP/2YxE9Puz5os6GqgcnFw26
	J7yKdI7djPHBcxRWLA6R667byeDwzqClKjHSNCwGee4HJ042NqjYxMzqCY1+Iddx26zXkmgHWeo
	LqXMwVZbw4TgNfXnBdd+SFljBmorXIV8gWPRBqHIwxQidlpdcBxt7j2BnzddLfTQrUGIF6Z2syp
	7hgrGO7nVe5THjjJ3HSUTb0JzmolIDznAsrDr3SbgkTIgugItJs7FMpComhVIPrjL6zwvJsnlk5
	u8EW8SBThij4II6K9aJ/GL6YYIfGho9dmmGY5WRN7OFh8llPyg6hr9ndNmUfYlGP88e71adyYX8
	9HDbd4Orn+viKf88aHD98eBlnQPaSJeBWryznysRcQetnfFjbxDIEUMOxhGj6lqIsb7/Gyww==
X-Received: by 2002:a05:6214:3d8b:b0:89c:6295:cdf5 with SMTP id 6a1803df08f44-89c859cc1a2mr58037626d6.9.1774027311762;
        Fri, 20 Mar 2026 10:21:51 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85210812sm25007646d6.4.2026.03.20.10.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 10:21:51 -0700 (PDT)
Message-ID: <0566e178-4f12-4647-a257-29631a769b49@gmail.com>
Date: Fri, 20 Mar 2026 13:21:50 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] commit-graph: fix writing generations with dates
 exceeding 34 bits
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20260317-pks-commit-graph-overflow-v1-1-e6bee22cd826@pks.im>
 <xmqq341ykzyc.fsf@gitster.g> <abueHjVHCztQtL6b@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <abueHjVHCztQtL6b@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/2026 2:56 AM, Patrick Steinhardt wrote:
> On Tue, Mar 17, 2026 at 12:39:39PM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>>> this fixes a regression recently introduced by myself in 024b4c9697
>>> (commit: make `repo_parse_commit_no_graph()` more robust, 2026-02-16).
>>> The regression was found by GitLab's tests suite, see [1].
>>
>> Curious.  GitLab's test suite runs pretending that it is way past
>> year 2600 or something?  
> 
> No, but one of the test repositories that we're running tests with [1]
> contains such a commit.
> 
> Patrick
> 
> [1]: https://gitlab.com/gitlab-org/gitlab-test
 
I'm glad you have this test! Thanks for bringing such a data shape
into the Git test suite with this change so we can correct problems
this way in our inner loop testing.

I agree with Junio that the code looks good.

Thanks,
-Stolee

