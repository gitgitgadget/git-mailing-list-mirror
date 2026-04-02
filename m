Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C77529B224
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139977; cv=none; b=rQvxxb1TntFeskTrvchheG3oUGwRBLq6hf1E90p6rDn/3onhkEiHWzyXpMWRl/AtvPT5oPpY4Swe9RQm3+wwUz5s+Ztr4jhmDsFvJE8B/pECYCAc85gziXkkxGQPy8+BpQ26Av0pked2URjkbsR5VfRSxWVPBOjBoRootUYPoRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139977; c=relaxed/simple;
	bh=zXtch7j10lz0BjOvuH5osHBRyD5rVlulWwgEgO0BnEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scZvP0MGkLUIlvS9UKLSMI1QTAoOyYS0mTM8y+pa3CCWhtS3GmSfESDJQ0oAN00u3QMaOS4X8hBSQXib+ThboYbwZwDdoQHPtsbs6weyK8jD8rl+iTgi0pOcwToj73tSTCLCJyPOiL53xEgULWM0p0/xq+Zy84//1UWSo7ZEs5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXe//OwG; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXe//OwG"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56b65ffbda3so854037e0c.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775139975; x=1775744775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rsdFHxf4bH1EQ/BR9siWZkG0zCw61MdOKmmzTymnGi4=;
        b=WXe//OwGxjuopq10+FKYpwJqiNR7Jtm3HdYS6RfBp6gNMlzVsZcyl4KdCC1+2pEIBD
         hd3joffUufCQ5mODdZrre1YzKAW0dL3rM00D+MjL0ravL17DUuwr5pemvYoVv9AO6np0
         69Y6Dqt+S0lHyU7M51i9tiaDWUg4uJEm2TpLBFtSi/1Q3+hmNcr4eJla9BxXYxRadIYu
         yXMU44a3VoRbnBuegOhbTIz+PF/ZXwlXIU9m30skd4SeQAhehKHa2n6rR0cumJzVKlmR
         f/IA3kYDeQbajoEGFo2aExLv07CXx16G1SlY5WsBVYCdQ17ILLtz3CXZz/iechS1Nx7N
         u+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775139975; x=1775744775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rsdFHxf4bH1EQ/BR9siWZkG0zCw61MdOKmmzTymnGi4=;
        b=mWStWoxSJ6jmHaiJi3oZ160bX4bPJxIdsom35iR9nxImpt7+Wtmq3jrfa1Rk1HgUCd
         KnTDoa7xoC1Ejt7qQ0oKM0Q0ZM5X5eUBa6tHs2yng9RPIrRqRRxTiXaY+GA8Cz3H/Rve
         igqEB6fKIVHFqlK4UU+nc+Hqh+UeGeuEmg3OzLfzgW2RfH9Bh2BehO/u3RGDncKV+FIn
         XVslCqmTXQCbtWdQZ8gK2bs2GOoE/N+sUiEI+J4chR44UckavVhyElIWquqnDwrNej38
         98IMcFVFA/L/V0rpX81FkaHANUifEwRmafteVeV8LxGh2aw7DPvGzZKiHpMk2hXIiVpb
         mqfA==
X-Gm-Message-State: AOJu0Yw+vXKNlK/QuCony/ki3cFOFUgQV/jIy6sDGd7LGF07sNZbGkxA
	1RZyO2J+1+/rS/d6wBk1bdFw6jT3mHVd294uV8xpGym+QVjj9xfHJizJ
X-Gm-Gg: ATEYQzxYpBMe03qFYaYI3VMzd5h+IuNJ0bzC4vlfQldeZETtUKakO0j26fZkgnLEqJh
	+E/HqMA0isCmrdpjoUoFj3L34wB6UQhdlPK6RqcaIEjpjAfYMY6R1RaUZGJWf3ntcMVKSvqdo+0
	9EbtEyJ739+S1CTWwGkaq2R/gsaT219E5uFyI7j5J3CkIhsMX/x0EXn0V5r41jv3MfwESFAp70l
	jYlg9u9/1JET8ov7pB+65nWbq4SYfBVw2MHkyM2yBZmb5Dhn698/1ahmEhZot0x9LToklr8oLt4
	tlmOpcXh4zkUO/NjHj5hrXvP1HiKTS8DcY4hmhq51vLZRLcKakD+Vv3LNGavafr8JS6N1H0/vNz
	SqycPNl5BKok+0NhYClnhWLF4zQAcP0VJFvnkPCtgjaaJrKxET5N9I0mJeGYYFsuLHMkB67W4sX
	ryZ9C0Y7iS0+L2Wo0COoAMEjJeo1E6onauk6NvY0D/748ogfDsSkhrXEVTnmtjIUuu9vlnLAJzD
	/QK2403UyrFQxBsRY2b4bQOtdIcSe+OGkhsLiZNMX7HWpIgV/+nOkbyqgg=
X-Received: by 2002:a05:6122:2783:b0:567:4e8a:fb13 with SMTP id 71dfb90a1353d-56d9c7fa9dbmr1361185e0c.8.1775139975362;
        Thu, 02 Apr 2026 07:26:15 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6b4:9c00:4872:ad35:e6d:aa17? ([2605:a601:a6b4:9c00:4872:ad35:e6d:aa17])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bae1117sm3459361e0c.7.2026.04.02.07.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 07:26:14 -0700 (PDT)
Message-ID: <fbf03f6a-c746-4b6b-81fb-f3eb4b2e2f0e@gmail.com>
Date: Thu, 2 Apr 2026 10:26:14 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] read-cache: use istate->repo for trace2 logging
To: Junio C Hamano <gitster@pobox.com>,
 Jayesh Daga via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jayesh Daga <jayeshdaga99@gmail.com>
References: <pull.2253.v3.git.git.1774891667.gitgitgadget@gmail.com>
 <pull.2253.v4.git.git.1774895886678.gitgitgadget@gmail.com>
 <xmqqpl4ldqyi.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqpl4ldqyi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/26 4:04 PM, Junio C Hamano wrote:
> "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jayesh Daga <jayeshdaga99@gmail.com>
>>
>> trace2 calls in read-cache.c use the global 'the_repository',
>> even though the relevant index_state provides an explicit
>> repository pointer via 'istate->repo'.
>>
>> Using the global repository can result in incorrect trace2
>> output when multiple repository instances are in use, as
>> events may be attributed to the wrong repository.
>>
>> Use 'istate->repo' instead to ensure correct repository
>> attribution.
>>
>> Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
>> ---
>> Range-diff vs v3:
>>
>>   1:  5a8165b05d < -:  ---------- repo: add paths.git_dir repo info key
>>   2:  9bb6d0fa01 = 1:  c99d731efa read-cache: use istate->repo for trace2 logging
> 
> A range-diff with v2 would have been much more relevant, but the
> patch below looks super boring compared to v2 which is very good.
> Just replacing the_repository with istate->repo and nothing else,
> which is exactly we expect to see from the patch title above ;-)
> 
> Will queue.  Thanks.

Thanks for putting in the work to create this complete
commit. LGTM.

-Stolee
