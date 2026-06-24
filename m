Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6A3368D5E
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308093; cv=none; b=mR+5/F39hxofGmZqr1P8YVfjjIkEXAxV9oa+ZYGvdKo1qWtjs5viubSGTIOLUqbQJ14rt93GUUQaz1V24xLY2gTKz059NXAOdrBcq1ScOryl+T5DXRWCW2hEDwHtmSsNEKm/A1P1/oUvKqT2B5mOxkf7w96PTPgDj3k25xYx2Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308093; c=relaxed/simple;
	bh=zCpuOoZhSRa9DfDBds7rv/e6s7qZiO5fsjkVqTFQ1yY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjf8xrBVJ/19tvHv2U/DxIB0vaZyOFUYSieB/+mBqlMJAW4ctM011z2/05ii/Jot5owsJfjbwXVrGwWrmLBXncMSqXNXqGl8ZUW5OviDmSCW6W8AuoMN6uty/Q9dPvxK8OZwQfZETwBDxUdDc+ZI8Rt2eaMLs0tLU5m8CMD/kqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiLS1DF/; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiLS1DF/"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-517907feed0so20563891cf.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 06:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782308091; x=1782912891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZA/0SMUjRFX6sGffNpJT6vPQylYpqa9Y2BgfrHfXEI8=;
        b=EiLS1DF/DtynAUzRSQWU49XRyMfFEyKy282FG2krB3ouMVOoBCG+sNYUO8lXxnMOE8
         znX/Wu7yeze5+QCPHVRLmMxuDO1hgC9U10+puCOA5mjnRJCIE8CMI/vzL3hTY9D2Ena6
         UrSg9VOvbF2+DlQUCTov4fg/2gvwsKQZ+kB/vt88+CUeprWmlLBFAgs8VYSQJxCSG/f8
         Pdlm8VZI9EcOQtPHCR2s91wnIF11bXEJe+dREVDdpJjhkArRfBkCoCnT5uGagmOD3Cj9
         nAzxHQhi1/hD7lq5BpChQlmMFB1v5ucGbWpBuy0LwtC0kxiVQQH9C7I9AlFt9+Ks7GLV
         hZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782308091; x=1782912891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZA/0SMUjRFX6sGffNpJT6vPQylYpqa9Y2BgfrHfXEI8=;
        b=QdvvceivrpWOqgJol99Bc4u/DFtiNXPzFFXkaWY0W1Mzq6Ssk20ZwdGIu67N+ZOpL5
         3yxoBw196K+i5D3yEyqN4SNrgDHiDNs5LAc8npoZ7JODIY4tsKujQzg/riMi/sI7ZbXS
         3f0IJxURxMjs0Ozd6DwOSdiDMEKw0f/yJN6Sz+L0E4aip/UEutCjS7dcWO0luNrEy+8v
         Xwq+WLT00ki6M/UkVSBOLgEe9IvIcXAu/Gpw052BT7CsSLVxOiyrxTTRn7vFzSneLKHu
         BzciCleagyKypQ/azTx+54IqbhYgvAD4lP1pD6UL3s6ZC/zko0JRhQn1egTjomOHazwj
         mcGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+93BBblu2XVzm4fMkU7OTn3TXgK0c9rSPFy3AuurGJHtk7XQ4HSjUMvco7d9Kqe5YbN0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwteiTC0zBrA6oewqriu2zRtKc91CzxsmdOSdn/pPkRbkzkUqHv
	O/y2nIVo+RmdCnY9Msc84oLDYZYg2/15UCf3vm2j4Sg1iGJy8W1bk+6Q
X-Gm-Gg: AfdE7cnXWu7mfXBNQXyY0r6cMwaWd6Ov8cfqeEkZkvImGnMiy9qX0x3FS5aHw8OOfsd
	zSC2y8aUOo4IdN7+u+J7WFOMD4GGJpgRiv4iQBSsFpspEClpM9hF5RiBZqf9Y37yjWO6CRHZbcC
	bPtmL2I8Psb9f/Io8G1tcH5Eu4PHO7DOC0O785CVT1RqjQ+L3U1jOLWbbzRm62S2S6rxT/D7G1W
	yXSnR2y34ofq4OSQwUs4pam9MWqGhG5fZX7JM99VS0Bv8666R2XXxzt09/iaw5FcSqUhQON+ymV
	QShbTTE51tAXT6EVJ6yCRMRFyak8a4xMLJHwF3eJPvr9G0zBH1O0rnzD5pRhDZbtDU6VVCd8ssj
	ZFgpQjEoZ9QyC1fyolHdP9Qk3pagbUNJORJFhoocVHiTeTdUK7rR1FEDV194+8WYcuMGQOrqRog
	b2MLPZPpXhV31Av8cwPepBhocReoaz/dSkG+dJxd91TXXoTJXY0Llj9gmMYA==
X-Received: by 2002:a05:622a:2606:b0:517:90b2:8801 with SMTP id d75a77b69052e-51a51b2e7d4mr107534791cf.21.1782308089694;
        Wed, 24 Jun 2026 06:34:49 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a514b4f5dsm47218821cf.1.2026.06.24.06.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 06:34:49 -0700 (PDT)
Message-ID: <67c00a9f-2aa2-4e83-9c0a-317ca589b232@gmail.com>
Date: Wed, 24 Jun 2026 09:34:48 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] commit-reach: terminate merge-base walk when one
 side is exhausted
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/2026 8:14 AM, Kristofer Karlsson via GitGitGadget wrote:

> Benchmarks
> 
> Step counts are deterministic (measured via trace2_data_intmax added in
> patch 4). Wall-clock times are medians over 10-20 runs with CPU governor set
> to performance.
> 
> 2.6M-commit monorepo with commit-graph (baseline v2.55.0-rc1):
> 
>                                         steps              wall-clock
> merge-base --all  (across import)    2682391 ->  53521     7.26s ->   88ms
> merge-base --all  (1000 apart)       2659607 ->   1106     6.98s ->    8ms
> merge-tree        (across import)          -               8.11s ->  100ms
> 
> 
> git.git (88k commits, commit-graph):
> 
>                                         steps              wall-clock
> merge-base --all v2.0.0 v2.55.0-rc1   72264 ->  44589      82ms ->   49ms
> merge-base --all HEAD HEAD~1000         9873 ->   3817      19ms ->    9ms
> merge-base --all HEAD HEAD~10000       72285 ->  41523      80ms ->   48ms
> merge-base HEAD HEAD~1000                  -                 9ms ->    9ms
> merge-base --is-ancestor HEAD~1000 HEAD    -                 6ms ->    6ms

I like seeing these updates including the deterministic steps. Is there
a reason you don't include the step data for 'merge-tree (across import)'
in your monorepo case? The wall-clock is substantial, so it's not like the
last two examples in git.git where there may not be any difference.

Thanks,
-Stolee

