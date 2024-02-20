Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F14B52F68
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401599; cv=none; b=cI7oxQPzwHQYgbKRJODlAP6yjeOGRazNQ2GXEMy+cdaRrqLZjMamx1BXV2Nc3/3Ql12VvqS6mYCw6IkyGcN018qY+Ddk8U6Nm8i1aouaGNkjpJzqjaLb6SiML6FKK6q8KHyV7UV2i4/+rTEh3O/WWQh+38HOGMekFn9YxzZEN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401599; c=relaxed/simple;
	bh=u/um/6pGF+ZQTsoOvLRSZdOxdxNlGecHFb00AbWkDyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svxX/huaEN1lwtAlQzbwErYayTrlHcQruYt7//1176fUfRyXICSWiRV5DM7bXBw/kIgtIHk68i6jjg3op8IAHRPZLO5f1PD22LO+JH6vd5Qspvoz8I9DBFb9qCC2O9X9VCYGe3gVWkyd/3ztqhDBagmTnadNqiQb75LmHQWnhW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y86Atayw; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y86Atayw"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-59d78deb469so3192537eaf.1
        for <git@vger.kernel.org>; Mon, 19 Feb 2024 19:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708401597; x=1709006397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lw8L9uxM7z2cXmTkkFudWDsXY+Ppo4PJZvKOCngq1QQ=;
        b=Y86AtaywZDXkBoMYvWirY/FDllQptt6i6fxJtXTuGZMwnhnxGReY8X0Fr7uMUCHnI8
         G6mDIuYmlid4wSu4vmRN8XEPEkM0r3F6nzMu2Hphy9wif/8OPoBl/n2vg2VkSpfu09c9
         1Pv/RKqS5qmQlG2Uj7vGw53NgAn2HSZgxku+L706tqUWrPQG+RLTKEpdO7DR5GwOKvHJ
         /3UQVYTC7d7x1iAH6jK2sVYDCAELjJKkvfJggxrUFnVSLneTkvCLSsbwDgQ6UqN4cvH3
         BXgrpqkoGPwZInFK/eej/EKux8DPWRDuFlJimpeE0B5WDtjb7mJ3Qhv1RZBFEmAPntfa
         6ZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708401597; x=1709006397;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lw8L9uxM7z2cXmTkkFudWDsXY+Ppo4PJZvKOCngq1QQ=;
        b=vUC3Eh+JjCtry/IeDClhUvwto5+sUjf5NdPx1IRJp23pXuVbviixCY7Sfwd+pRZj1n
         aJHQhqEhCqhlEU7piZPFJWOPCeftEbsJFvjMBUM+NvBTO8MzdUmB7Jfy/dIYeCRqspDA
         1tK3Bs0wHvhBv1dc2mEsN0XiMUz13qrLkNalHHMytiC7C5dXwB6g+FPQ+4w4EbklJK5y
         d+9YXxpDpQWBnK7w+P0gAlTBSefSN1SPvJuXqE2Nsdsz0lJTQ6R4aYyVtpb7EdhPXWqT
         O0GPb7RlPtHAEfbhWXLI39OYyrBvkKFf1VZICU+WA9YIC/6ScU2yaAAvVbkMPMrsNNxN
         oWkw==
X-Forwarded-Encrypted: i=1; AJvYcCX85JmvdAJ+eNWvd1PnUKxGaVFr3cpX0BmipsvMwnOezbuSvmHGOXwDYpkcM4y8RfdS1Kf/iFVuX++YRHLR4x5VgM2x
X-Gm-Message-State: AOJu0YwlNsnvolCzVjVz5gFyApMG7gzRHxAsiOnjgYQMFo6+d4i7cXib
	Fgcpcp0623B1FHBRj3W33nT03c86ewqb0ZjzRL6HVwFPLgQhXHQgNlE1siUM7xSYeg==
X-Google-Smtp-Source: AGHT+IGELpFdSX/EIJ70WOL26MBQyOMMo0lJXP5pKarJtKzNOnKIcRhcpa7FySna8/4zMmwJZmhJKg==
X-Received: by 2002:a05:6358:7327:b0:176:5a5e:4bfc with SMTP id d39-20020a056358732700b001765a5e4bfcmr17943583rwg.3.1708401597168;
        Mon, 19 Feb 2024 19:59:57 -0800 (PST)
Received: from [10.197.96.0] ([152.3.43.40])
        by smtp.gmail.com with ESMTPSA id l5-20020a62be05000000b006e091a254adsm5651425pff.30.2024.02.19.19.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 19:59:56 -0800 (PST)
Message-ID: <31135b8a-af7a-4d73-b3b3-d91ea8d3d5fd@gmail.com>
Date: Mon, 19 Feb 2024 22:59:53 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin/stash: configs keepIndex, includeUntracked
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
References: <20240218033146.372727-2-rpc01234@gmail.com>
 <99346639-5a36-4c2e-a5d7-035c3c1fda8b@gmail.com> <xmqq34tnyhhf.fsf@gitster.g>
 <1d66eb0f-077a-4a63-8acf-f383538a41c7@gmail.com> <xmqq5xyjx0jc.fsf@gitster.g>
From: Ricardo C <rpc01234@gmail.com>
Autocrypt: addr=rpc01234@gmail.com; keydata=
 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
 jjbjCH/5+g==
In-Reply-To: <xmqq5xyjx0jc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/19/24 22:44, Junio C Hamano wrote:
> Ricardo C <rpc01234@gmail.com> writes:
> 
>> This is an issue I hadn't considered, and I'm not sure whether it can
>> even be fixed. In some sense, the entire point of this patch is to
>> allow the user to break that promise in their configuration. However,
>> I'm not sure how big of a problem this is, as it is entirely opt-in
>> (default behavior should be the same as current behavior),
> 
> Correct.
> 
>> and tools
>> can be altered to pass `--no-keep-index --no-include-untracked` if
>> they wish to force the current behavior.
> 
> This is not.
> 
> People expect a bit better from Git, and such a callous disregard to
> backward compatibility that breaks other people's tools and scripts
> is a non-starter.
> 
> Users of such tools, whether they were written by themselves or
> other people, do *not* want them to break only because they want to
> use a shiny new feature that is advertised in a new version of Git.
> 
> The point of packaging a solution, the reason why they wroute such a
> tool or script that happens to use "git stash" as an ingredient and
> depends on the current behaviour of "git stash", is so that they do
> not need to remember they even used "git stash" as a small part of
> their solution.  And of course they do not want to remember that
> they rely on how "git stash" behaves in such a solution.  They do
> not even want to bother complaining loudly when such a change is
> proposed before it hits a release and hurt them.  Saying "nobody
> complained when these configuration variables were proposed" does
> not help anybody later, after we already hurt them.

That makes sense. Do you have any ideas on how to address this? It feels to me 
like providing this config option is fundamentally incompatible with requiring 
backwards-compatible behavior regardless of configuration.

Ricardo
