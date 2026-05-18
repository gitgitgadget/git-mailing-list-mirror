Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156F540312B
	for <git@vger.kernel.org>; Mon, 18 May 2026 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106848; cv=none; b=mCdaU/RHaKMIrRznfRZ+fdy3D1FMt11KiQsNY7DgB2QFXrsxFG07s627LgHc96fdRsRhg3sgtumefiTIY2De3+UBGLzCnul2dY6vAQzkaWcfoDdao9z8LVrglHHgZOivEm3nIffpp7tlKYsJe5TE8cPEDxm3mpCJcuiKV8c4pqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106848; c=relaxed/simple;
	bh=ibc2oz/vqEpVsujMuFoJRSi9q8aCdFZUHfeR7Km4bmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0W6l7kGdXmqrygCZDfzYz/Eh/ocAEfZCmhokyMzmEp7fZwHK+sll52sYdpKpO0LTtSERvN2xXeIhYa86NjM+AMHHnrktbeSJrjNVFU5gUsROppOrgqB1v6hHDjl3m0tO1FxAZNgwwpbsps2VmlKvufgrEfoES6bPaXP2u50PPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrj8QpW5; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrj8QpW5"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9118b952e2bso409542585a.0
        for <git@vger.kernel.org>; Mon, 18 May 2026 05:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779106846; x=1779711646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oSzXXui0MTjPzf7RUbuu0LQiaCBfKeXK2lot0wp3+U8=;
        b=nrj8QpW5fTElN1U64wafMizL8h6DuX5XWA/VHdVZ+HsGbl25cGcb6L2y8ccnhXay/l
         s2cUeqOqlPLqbQBLN6AYIyds08bapwW7iJXR2lOwEVqzRVKjP05fiFllVkrgwbF2348b
         836duGNQjABDCAh8/azYpici/q9xDyNRSNGJ04R7gGzzccIsV2ANslqxRyqWe7eeXwVU
         gLhQfXE3Kd8Yr01CMuvfQiajC1d1P5x2pbyW3HQG58OvlW1RNPZYG8HFRmzEm3J4pAVa
         ZqGzv12vT/Q5khu5LHZaFwFxN2fTf8Z8etzyjcQVPVNjjY9MvXmY8EuDhdX5votXxpJN
         2wUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779106846; x=1779711646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSzXXui0MTjPzf7RUbuu0LQiaCBfKeXK2lot0wp3+U8=;
        b=Q1vBgHQQna7mGRG6Mk4/lFy7AMbA1iUZG7bwPSp3JMGiyb5eXnYdACjDnxP5PEGPZZ
         lHnSHV7CA/rRryERFuqh1TF2wx45AfAiSnpNYrzFVP5H/uRO9Aun2ommiTdJ2YR/ibbY
         /wvdraY8hxf7RouMyob15mWSWZIvY6NerEHXKWsiMutae114VCXbfZGiwTVy/hRrtXJT
         pO1Tmtdv+CQNgjusKrPs9txZU1dPFJD+KYNKBqlQcxyiFTOSspqJQbmA7PKoy3zqxVqm
         283Oouqk/utmxOrEAxWB0UoIoTdI2SFbD9TBFZRZVQV0PQh3IElMXuIqGq/D7M/9Y5BU
         pSVg==
X-Forwarded-Encrypted: i=1; AFNElJ+kl8ZgogxuduRcp24YFHGJ8xx4YvNim3Xb10Iy0H15EY91ECtdS+y9VzE6ZxbRCmd3KvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu6Zx72xgDrbw5G9Ke/fChlzqHZz01gKP2kopyiIpqIrzjhvrL
	hGB7+GLCE1RjWPx+SuztSgN9JTrHG5wNXxDFLSLqrz7e5gDYDIMkpTOD752kVbyZ
X-Gm-Gg: Acq92OHU5B73hsISusXYR5hCHh3rJTF8JAvtbBtp2sshi+Vv6F5P566z6z/OkiNXVnA
	t6H6c6o2bpjNxfN1YyuIQ+1eTianSLIYABUHUX6rw7CYCRDeDflho0R3lmI2HeeAl9SrEti0aZP
	zgtuIZRY3I3yttHVhnyUiLgL0Zu+XcpWZ+WIRHQyHp4wHTVZvoxN4EeLx0d5xcGGa19WEJ6vp6D
	IhiFY/7Lab1CWJDIZhXEeXVYakB6w8lspua+dvcczswldg53RdyRa72GRhxhAi3ygT8hLmhNYtO
	VQN79lvUyKA0brWceBGqo8tcfx6ZJJIhTiw5+lgXeWnxiZN1rnnJabmSqnz03kY53JB5D4efiO3
	2FOx4X8nlpGv81WvknKmupQnfwLKGwxu4hACiOH+sJ3Fz00SD+cbwDVldVgdsHjKAr7pU08dTkA
	IY3Ui36iWiuzw/4gIJO5H4JwMqx3MOGOicQougedry9p7kj5FHKT7VGJq2lZPOFNTp/icXxg==
X-Received: by 2002:a05:620a:46a9:b0:911:6136:281a with SMTP id af79cd13be357-911cc4bc1b8mr2106573785a.17.1779106845927;
        Mon, 18 May 2026 05:20:45 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9114edfd3ebsm1341454785a.23.2026.05.18.05.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 05:20:45 -0700 (PDT)
Message-ID: <c5b333f1-0db6-4aec-a369-6503cb924e7f@gmail.com>
Date: Mon, 18 May 2026 08:20:44 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] merge: use repo_in_merge_bases for octopus up-to-date
 check
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>
References: <pull.2110.git.1778566286543.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2110.git.1778566286543.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/2026 2:11 AM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> The octopus merge path checks whether each remote head is already
> an ancestor of HEAD by computing all merge-bases via
> repo_get_merge_bases() and comparing the first result's OID to
> the remote head.  This is more expensive than necessary:
> repo_get_merge_bases() calls paint_down_to_common() with
> min_generation=0, performs the full STALE drain, and may run
> remove_redundant(), when all we need is a yes/no reachability
> answer.
> 
> Replace this with repo_in_merge_bases(), which answers the
> is-ancestor question directly.  When generation numbers are
> available, repo_in_merge_bases() uses can_all_from_reach() -- a
> DFS bounded by generation number that stops as soon as the target
> is found or ruled out, without entering paint_down_to_common() at
> all.  Without generation numbers, it still benefits from a tighter
> min_generation floor.
> 
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>     merge: use repo_in_merge_bases for octopus up-to-date check
>     
>     While reviewing callers of repo_get_merge_bases() for a different patch,
>     I noticed the octopus up-to-date loop in builtin/merge.c computes full
>     merge-bases only to check whether each remote head is an ancestor of
>     HEAD.
>     
>     The existing code calls repo_get_merge_bases(), takes the first result,
>     frees the list, and compares the OID to the remote head. This is
>     equivalent to an is-ancestor check, which repo_in_merge_bases() answers
>     directly.
>     
>     Using repo_in_merge_bases() simplifies the code (-14/+4 lines) and
>     avoids unnecessary work: with generation numbers it uses
>     can_all_from_reach() instead of paint_down_to_common(), and without
>     generation numbers it still benefits from a tighter min_generation
>     floor. In practice this only matters for octopus merges on repos with
>     deep history, so the main value here is the simplification.

The code change looks right to me. Do you have any performance numbers
to share? Or was this motivated mostly as an opportunity for code cleanup?

Thanks,
-Stolee


