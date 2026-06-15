Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCB53E4C6E
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781523863; cv=none; b=Nuxh922+Cn9/BEWYK9+SZfSlco+rdmsmVGlrC1QcVvU4RJ3/2GZUSmWh7LudEHqun/VmMEZJp0JAomIcGfjC2UpEk0YOJ3LVXJTmJsjG1opX69Jkml5xZp53694TqOaTDYs5XHbisU9ZXLND+aQlX6vc9pVKGObvJBU3Vzs2/t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781523863; c=relaxed/simple;
	bh=3v2adxhqFRsRjEn/Mo0e+NIPNg6QUDKz1TahHR3qAp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvpETPTPYHrjBEXeZu4zaBJdki8AeQKCfLKD7gP6Gro0HqEj29H3TsN1AD2xPSUHB9S893WVldjFH6KozCnCyRWNJSaDk5aGVR6Ss12YaHQl9Z0LU69Ny1nTOsBlGyqYJw1HXplaC4G3vCri9o1zyviQ7qsQiDheZXP08sSShfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbQeTbco; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbQeTbco"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ce9ddeddefso38880726d6.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 04:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781523861; x=1782128661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XN6JGpt0MxlEpWHldYlvEUcs7hduIpUiQ5gpFwH9WV8=;
        b=nbQeTbco8x6OmEbkfU5pOt0b8+MX+79WfLQRHDUTRDWImpWK8LbvhIomA/QG2Ner7e
         9pctToUsn9B82zYJIcJxcArkaG4N0Fj8VBMVAPZ/TbjHKVSrHbuzbFUYy93b3BmYGvGv
         4A8Mmw+CG1bASQqm/bfsl+zZMSX394YQmeRD44i9A8t78+Dx59kDAVpUoTgZMxytHsbP
         +sK5puNd4zAAZ4w94WDa7yBPkZ4kjuWVAPxCC2ED+RJb+gqyfStCDOC97UHHjYPn26gq
         /oILrQmD1wnIvbM/FWG2YwoHFvDbD2fxiUWAfWy1vxcfWZbXwtTFUsKHcZ6AsQU3bKpP
         jF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781523861; x=1782128661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XN6JGpt0MxlEpWHldYlvEUcs7hduIpUiQ5gpFwH9WV8=;
        b=CGXJFwWic2ReL8xBfqJUhRsD0Zs4neCCjUtioVpzQlk4SFdNZYwWxLhmv7gMPM/cWm
         u12HYUYjcLpRPHRMCjK05mTBWNNGbp5ITNjZET2AqA9yJDYi2C9Nh/jDROAAA5EBOXec
         DmIupy4cy1AE6L9dHJpFMZ96BgC01bU1uvuW0+KlmWykXDqjO9mknQgvh5jRGK6eWhHo
         DmKSs/CdPJW2pay8vJwNo7T4Fp40wVHWhi2Y8D6+KPY/nX5SRV3jRZiqMH+to0Dnd+ef
         SssluPgCg6avn0+mr/qzMQ4gdmzUaLJa338AnAuYRPL91fJ4xY2ATrOelNfF9CLY7Eg6
         sCKQ==
X-Gm-Message-State: AOJu0Yz2Ek0wBxDnRsNDAHorHXImgb4UuG05D+66q6DbmrFHPQf07FMK
	ANrtPMFpDGHtRe0STUNcLswNDxuVE1tmUpGM5ymf+BtILF0ocVnez4Qg
X-Gm-Gg: Acq92OFfQvnx7v2VsjrO8BmBl3lqiHW8TgfKs+JjCP67VG7dR/lLZMgQi4xqleD0KoF
	zlvSmBZA+dQzhG8QVvdNee3SIUrygtBw+jem3DYxP76q1G1xctHtnuWOq6hFMezv5+PboDOpZH5
	mQzLLZZgM3PVqnmrLg9w7AyYF2WbfZNwXHwjdA8AFwYhHzfQU1RJxPj4Yw08C9/0ed2+BQybq/6
	BU/lXUvjMSDgtEZQf7ZE9sjyU+tTAGylmDRFA/zhuMvusaGylzHReOp/sVPdzKJ7Ny2GFsVuL+r
	BzFyG8uCnS/Nci37nApTZrT0d1aGa6MiJRwdrkvHW61Awf1S7LLnPRrN/2yU+N40v9+tjxsBYsb
	0Jcp59sjTflMggFdbiYal73Myfb0ppHo2NhBv15iQoChq8jAMyGqvhfWax3i5Pllf9+pdP8JCGg
	+eSh321fiYCwP1bR4g6d+FJGh0Jesr+nrL/ekOhM5GUthgXNi+AV6L6zbSKmhkniPrdy8docI7U
	188XIt5b1WoA3mwisAGaVWyTNtAaXxBSRpn+7xcyJwvsQ+nN0Y=
X-Received: by 2002:a05:6214:1311:b0:8ca:16a6:3d52 with SMTP id 6a1803df08f44-8d32c6d9300mr246053926d6.13.1781523860781;
        Mon, 15 Jun 2026 04:44:20 -0700 (PDT)
Received: from ?IPV6:2605:a601:8115:5f00:2d43:d39d:57bf:41f0? ([2605:a601:8115:5f00:2d43:d39d:57bf:41f0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d304577d69sm109969716d6.29.2026.06.15.04.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 04:44:20 -0700 (PDT)
Message-ID: <09e50180-e165-48d8-a9d0-485283342f5c@gmail.com>
Date: Mon, 15 Jun 2026 07:44:19 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] commit-graph: use timestamp_t for max parent generation
 accumulator
To: Patrick Steinhardt <ps@pks.im>,
 Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.2148.git.1781420271100.gitgitgadget@gmail.com>
 <ai-zzWn9Ls6-j9h8@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ai-zzWn9Ls6-j9h8@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/26 4:11 AM, Patrick Steinhardt wrote:
> On Sun, Jun 14, 2026 at 06:57:50AM +0000, Elijah Newren via GitGitGadget wrote:
>>      commit-graph: use timestamp_t for max parent generation accumulator
>>      
>>      We found a few repositories in the wild with commits whose authors were
>>      apparently on a computer in the year 2120 when they recorded their
>>      commits. Apparently, in a century from now, some folks are going to have
>>      a really weird timezone as well (-13068837), though the timezone doesn't
>>      factor into this patch at all.

>> @@ -1669,7 +1669,7 @@ static void compute_reachable_generation_numbers(
>>   			struct commit *current = list->item;
>>   			struct commit_list *parent;
>>   			int all_parents_computed = 1;
>> -			uint32_t max_gen = 0;
>> +			timestamp_t max_gen = 0;
>>   
>>   			for (parent = current->parents; parent; parent = parent->next) {
>>   				repo_parse_commit(info->r, parent->item);
> 
> This looks obviously correct.

I agree. I was surprised this was the only necessary change, but
your message clearly describes how the timing of the patch that
delivered this change contributed to the mismatch.

Thanks,
-Stolee

