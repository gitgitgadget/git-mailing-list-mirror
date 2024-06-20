Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B43D575
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718914885; cv=none; b=Rtyr6Rcq7pYpzFDVKlRe3PVDL2Om3voINkSQv4wuLyMVfhfcC+Et3pxu9tv3ED1H99NzacQwLG9Lh3bDO7GHD4Ps27H9+jIl3B2DrwMUVkkSL2I/t8ZEsUm4en6sSXjhASTTiJDpb4r4AqCmvKV68yzQlFGLbx6Es4/ilIGMGJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718914885; c=relaxed/simple;
	bh=9gziqUE+jlEsvMx60c+sGsFoRWdBEMq9UEjKUfafR3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2ucYDORJ+siStR6P+m1pE7XbSGb0dSJDfbtLD0+qZM4MMDQw8FvFHCsJdj21OPYCv3JTjnxmV6/WH0FBu29RHbzcNE3RE/7su6Oet1J9rtbRS3G6cvFcbL2Fm4JEM2JmzPbcLDHfVS8sdy56cUXgYGMd3y4uqb6AT3ZQSRoA/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaVyLrqX; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaVyLrqX"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c9d70d93dbso851390b6e.3
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 13:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718914883; x=1719519683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/xWndeJmtpzqqbnFGjyHDqnv8QRk817N6B2V4EmiY0=;
        b=LaVyLrqX0ZMvg7vlhDFZlb97GxUkvrmab9uwFY6Mo5WT2/YS8IJAb5/zoZRGA/4Din
         grhurXYNF/9gsN1tpTlFVnyCIdAbPjU6twawBYXTNwWMJb0L//eQNQTKiI0rvRPClXnu
         NoXDWE6IjDPc1Ly6dey7eoIBvr5xm1SkjvLwu8Hn+WMYZHxwCeU8acsJPsX8SfP7/HHN
         2i8YOYPCauxAGA/jOpsfDPwGF27hrzkT0ym3NBd/51t7MVU2oLBup/a7eiI0kX9zA8Tg
         eD0ywHg5Hf3m8xzFYpZoMwf9QBQWh9iY6V1r90h8B8Gd+dUPs7m9jA3gQcHgJOolpIX0
         eQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718914883; x=1719519683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/xWndeJmtpzqqbnFGjyHDqnv8QRk817N6B2V4EmiY0=;
        b=krY37FtukxW8KcG9+IIIGzcqjbBHi1zls0OdSmR/kk7aaF5cF4iS0ymtSTjPnTaQJD
         KPP6GndrV9tGiO85NtAXT1ksbaXUIpWJl0wpEsIgAnbuEGzOgoumo5FTO2J+/jDq2hDq
         PBT/9i+ATbwwGxlh+pzbzwGIOJhSbrg3OfTWVlU20+uclXtSGEy8w5PFopUnL8HsuNgW
         JEwbyvZR6JtcrdlO/SlfYrI2nb8XUnsfmecSq/sCSc8H7w7bpdtvUTUwT/idM2ttN2Lu
         XfFQ6lLA8SMPar0HzDzmxTxTZr2+b4GhDAnyAK3ZrUicGtoUSRUZQtic431d/8bGaLXL
         CqDA==
X-Gm-Message-State: AOJu0YzArOmqsJ0S++/yUenDUjnwL5whkNOfWg0GJifIWz0a7brYncy+
	DgP3N6NkOnV42ttjL5TdaAVF3S7klHUQNZN9uNZY26ZKzzaKhwPu
X-Google-Smtp-Source: AGHT+IGaVW03mUNOv/mPLkuC8TJW4hWBp58OeGane6kPB6JPa313WwEqutVSeb8NCzd8k4TJS1bmvQ==
X-Received: by 2002:a05:6808:13d1:b0:3d2:18c1:bf1f with SMTP id 5614622812f47-3d51b9e22a4mr6766254b6e.33.1718914882567;
        Thu, 20 Jun 2024 13:21:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:e99c:9edb:49ea:616f? ([2600:1700:60ba:9810:e99c:9edb:49ea:616f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d5345e3a4esm31068b6e.54.2024.06.20.13.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 13:21:21 -0700 (PDT)
Message-ID: <77974c37-b82f-42fb-848f-e060495c4f49@gmail.com>
Date: Thu, 20 Jun 2024 16:21:20 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] sparse-index: improve
 clear_skip_worktree_from_present_files()
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, newren@gmail.com, anh@canva.com
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
 <xmqqiky3tofw.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqiky3tofw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/20/24 3:16 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> While doing some investigation in a private monorepo with sparse-checkout
>> and a sparse index, I accidentally left a modified file outside of my
>> sparse-checkout cone. This caused my Git commands to slow to a crawl, so I
>> reran with GIT_TRACE2_PERF=1.
>>
>> While I was able to identify clear_skip_worktree_from_present_files() as the
>> culprit, it took longer than desired to figure out what was going on. This
>> series intends to both fix the performance issue (as much as possible) and
>> do some refactoring to make it easier to understand what is happening.
>>
>> In the end, I was able to reduce the number of lstat() calls in my case from
>> over 170,000 to about 6,500, improving the time from 2.5s to 71ms on a warm
>> disk cache.   Thanks, Stolee
> 
> That's impressive but I cannot offhand tell how big 170k (or 6.5k
> for that matter) is relative to the size of the tree.  How many
> paths are there in the entire tree (i.e. "git ls-tree -r HEAD | wc
> -l") vs the number of the in-cone paths in the working tree?
> 
> If 6.5k is in the same ballpark as the latter, it would be really
> good.

You're right, I didn't include the full context here. The repo has
about 2.1 million paths at HEAD, but most of them are sparse.

In Patch 5, I detail that there are 1,841,997 total sparse files in
the expanded index. Thus, the previous caching algorithm was already
doing decent work and calling lstat() 11x fewer times than the naive
implementation.

The new caching algorithm improves this to 6,521, which is a 282x
improvement over naive and and 26x improvement over the previous
caching algorithm.

But what you are really asking is how close this is to the optimal.
I didn't include that in Patch 5 details, but I was able to look at
my notes and see that the sparse_path_count data point was 1,962,
meaning there are that many sparse trees in the sparse index before
expanding. Thus, the 6,521 lstat() calls are 3.3x more than the
absolute minimum required.

Does that help answer the questions you had? I'm happy to provide
more information.

Thanks,
-Stolee
