Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D07D23373D
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771341632; cv=none; b=TtFZRd4Y+rOVy4oWMEpVyGYVVLmyeTnkxNHBRRZEEfotyOxx2IFH9H7xAJ+j3z2wSvz0UtesKOBTcdYsQlwNkzcSHCM1DbyRluQCcpTIyi5q6D/+bkuyFST1rCRvtOcexHmdwtt61Y5xkXHHo6UmaeEJ50Xtvp1RxHSJ3eyRFQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771341632; c=relaxed/simple;
	bh=KUD2IEKJ0KE+HjO0eo+IY/Le1AB1EdGV7defBiX7dDY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GVCEFdt2xcULYRevFqmnbNYBhfApmhW97Bo59HEbwxg36/sC0/nUNR5BUnxR9WiYJPxrySqkK9KoOWs5ccGZY2+UcBjUovYbiEudktCPkE5icBSeyOmJphpkdAKF/qDFtHS2x+N1EW26y0sRP8FGkVmTv1ugJI4r1Q82iGGght0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKwykksD; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKwykksD"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48378136adcso23078055e9.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 07:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771341629; x=1771946429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N4JY2RDkc6YZOmNNaXvgq8wFdy0P7cBVofI8de5AWCQ=;
        b=OKwykksD1haF9OQ+Kb3KDMKPVhm87UeNm7DnCLKuN1ZcqdjTP1nWU2yNF3eiVmJIrt
         xNVJWpjr/7+OtK0hW3l2LRazfE/O6zVhudPSpjfQxGbowVG5MtWx7wdo95AgI6IB+Ge2
         tRMd5KoBSVe4egCdSxRsgrXET+EgdAFBnOb+ysFJUFPn9vusD1GoyCUp5Qc9C+FSk3lR
         kkeK1PoNWJ8Wbs6PWxe6uox8qcZm+qPPgxqlSNutcb/JsPLiUR59HqrPujmLSTEYSZ8Z
         1zYX4FoXimcB+z3nm+bs/fG4ptg0x6coCFJVbjgW5MkbBL/8ArwiCzs3KDcyGufL9Zn1
         Y9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771341629; x=1771946429;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4JY2RDkc6YZOmNNaXvgq8wFdy0P7cBVofI8de5AWCQ=;
        b=Oim86gR73kn29kSt3SuPo/nfCbh1iHCOnpoNNrEy1e5UDvcDeaOUvk/7KojojbKmCp
         AxyuP9aGLcs5/2CrPlt/yutv2aVUH3gGyByVdrcC1IT8IwaP38ZHY+YwqxRFFFdVsxJq
         E3J3RScB8kEyZ0rSUApPqilr8T4P7mdZGI4/j4Rk7AeeMt3OPjq7M+cWbQNDQF/1AqH3
         Hb/tp+vY+FHQmxLUTHJIaAhloqL7PPEA1/pTGUv6ZNJS914Uru49Alv+HzW5XWoLM+oR
         HGWbfZ7NnxPPnbCRSFKePdyBZPFyYe6VVW16wS3/xlq6Yv+dJFX0YqpLEC7suYaOjIcx
         EKqg==
X-Forwarded-Encrypted: i=1; AJvYcCVH9mktH1ugHriK7HjPgBYDmQAce3ltBRkP11/kt25zJPyEzoLxtw1gcuAiwdU2IhCwWWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQDI4uxhk+Q33zFF1rz4CtAbBt6iSVhL/wGcYwS0rqZTDdTgMp
	dINRUhutBAhguOSS4dlHKkZXF0z+iEed3oMFqQ8wDCfyn1+/nf8ligXI
X-Gm-Gg: AZuq6aLTyUCPA1w9xmu5PpFxaPHSSEbwkvr0KPt3DR28qX8yVt16gOMh9wyyTmXLQog
	qPZg0LloOa2b0m6qhEC2mAhS3tF///lvAmSpgNTCoadWlj6bzpR8sj3kxAyNpTPwXXQ4pEDyGcC
	rE+mW+xxpFWF2eAB8jdoIl0eI0kMM3B+cJndfSu83eTkWGxraSrhz5/mMG5hyhx6u3UA8938I9H
	zep1tj89pfMzDxBZiXxTlAFN+R7NbyTXvWgNJsPmVnn3uXlucgg0uU0MMeY2equFGpqDd1Gcde2
	6I5E9STA5G1OXlI7CAtMj8JPzRp9FPxTRV0DWAQTughJdgQU3R2R1CJ5jyWDHHvTR59u2nr8D+h
	27kXyA7mC1D4xIu8EErSiLJa9McYaHUAr/6t0uG0VSlcmTd7U9GbL5489FHV3n6s1sw0B0KasZ7
	NHzWThJwduvdKTi/EqYGa17Y844ScEAfPkGge20Lwiy+nzi1aSvkIP4ZSRYOX54bTQMu5EBUJzf
	9uTBw==
X-Received: by 2002:a05:600c:6389:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-48379c1f4d3mr211484235e9.31.1771341629255;
        Tue, 17 Feb 2026 07:20:29 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370a63afesm111699505e9.9.2026.02.17.07.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 07:20:28 -0800 (PST)
Message-ID: <0619603c-278c-42e3-a186-a674a124a451@gmail.com>
Date: Tue, 17 Feb 2026 15:20:27 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] wt-status: avoid passing NULL worktree
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, karthik.188@gmail.com
References: <89c78ce2-1783-416d-9ae5-ef51f6bde58d@gmail.com>
 <20260217101950.15731-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Language: en-US
In-Reply-To: <20260217101950.15731-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/02/2026 10:18, Shreyansh Paliwal wrote:
> 
> I wanted to just check for my understanding: the NULL usage of worktree in
> get_worktree_git_dir() caller, repo_git_pathv() callers and inside function
> add_reflogs_to_pending() is intentionally left unchanged for now,
> and is meant for a follow-up once this gets gets finalized.
> or it is out of scope wrt this cleanup?

I left those out as they're not needed for cleaning up wt-status.c. They 
can be cleaned up separately if you're still interesting in working on 
that. It would certainly be worth removing "the_repository" from 
get_worktree_git_dir(). The others are not quite so bad as they don't 
use "the_repository".

Thanks

Phillip

