Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B15F39C637
	for <git@vger.kernel.org>; Wed, 13 May 2026 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696590; cv=none; b=cc1FyBW0jUdB2rDJhB6M4KoxzAAjtU2LfkCITxry4Ijqpm2FLWtnSbXJQ0O8hfWrhW/UGkfOo74I3rKvsQHId4MIIftWcfD7HOYez+3fB83jbsvJbJKIefrCl8ZbwYwmKoF5fmYLRHw/qHuEmWI7yu6FS4MwKJ0ri2govSB1bXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696590; c=relaxed/simple;
	bh=mxtvFVqmd7FPlLga73B7oOElv6yhgUaOKk+4nRdq8QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIadXhPEpee2xEomCkRfQbYQePbAY1GzrgGMM9Aec0Wz5W8K664/LVmkrZho3pn/2xLAtRjf+61x39039lLKdxN7be4gM2Rdg/U0ceqHKEZdkHLRCHLezPYtV3VZwVZhCBeedXYsbGA2tMYFsX4Rrj+dd3jXhwf2ik11B5BEi9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/9opMAY; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/9opMAY"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d7c12e48eso62955921cf.1
        for <git@vger.kernel.org>; Wed, 13 May 2026 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778696588; x=1779301388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iNrYK9icvrgXbUIweKR2PV19K5A01dR1s7vaoZCccfQ=;
        b=A/9opMAYpvoVUecDAojE8e8l3PKr50Vnyn8QilbferQe8Shrgjif4Ou5phD7le5ulA
         DRdEuMFEol6i9Ef0o9AISSyRAs2mMeVM+YXvnOoqYicqU7JWzUSfOFd0ELEpdrhioeVG
         38v3QPkzTGeu8mJPaqSd4nJEQq9SLG3f/C2QxwZKH4hhp+bT0DV7VF+ynKxD9aT2kvyU
         K5eZ0YCu4SR8ipY2FSqYzMJw2QwpiuuyPFtQJKKFjQqPrqw8b2TBrY9cJFvwoqHtlBM9
         T3vFFRn0ZmGQydqmobAiJokPh2I+JBfH3AZj6Cfvo5V/C8q30CyQNgdJ/usexWEAs9Bv
         qjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778696588; x=1779301388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNrYK9icvrgXbUIweKR2PV19K5A01dR1s7vaoZCccfQ=;
        b=AikfLmsakZy8TmdUioB4+iPQadFZx4BQtZq7imJPUKyyFCNDWoFcFlt/O9nEg36Zr9
         1K6OOZUv7fOz9zVlFh3kF6zCxroFtodIbPdafDSlXwL3zDy/hKz+JXoDnNrtWi5nfqu4
         Ptu7oKKs4dH/KmXXWk3qb0nEj01yIwNJl8lgvEOXMMzFBSKVRYXfUwvMA5t55uyUf7my
         vC4iysGBN9oRilje6AE/zuPdk/4xHNt4M/tyJna7vZc5vRsUZALlYqZ3Gm5I//Wj01A4
         JHAuUybsVee2avTH9NzaOv346ASa2Di+aloc4KEL9vFtWMDzjpyTrXW8vEc9vRzMb28b
         3Mqg==
X-Gm-Message-State: AOJu0YwfcvUrAx3kI2t/un0LzqWrKSb1a7vGlxhay2FcpoK5wrMckv5f
	9zYhZCYGaSLqUd7FWVNIVZaTxKDledD3KrTRKEK4Py9gp3VSC3a+GttYEarkr9NN
X-Gm-Gg: Acq92OG7AFlsBl4U7RQHIc78qnO744/613cMkGYFs7bw+6DoxFNwCXaF8hvUG3wChsX
	l94GaFOhJyX+6+1tLI5+nY8lNMZqxGutvlYJA+1WhCqdsKWXpYCldxxocb4gxApSb6219qzNds/
	20BbR5A0zKYC5jN4JNnLdDIoiNBNeCDU4Iw4PBH8D72FQWup0BABsIrBXUoL4IHqZnno9q2pkZw
	+KOVp/wkdjrr5oHvLmbcDnm3dOvSau970EKQRZbqIsFPz6DheSM7/RdsLnq+Ag9WnBB4lWecbAq
	9UQ1aDbPYlrsOG44S97ejZUWBjM8qxm8rpHAb6mQ0n9IE+GoJygSjMW4APungD9G0rPpPDKetSi
	S72iBQ4D5PdduQ7AtywYSMVxEeR+Aw6mZSDZPdeR9Jmhkq+3/xexPmmbPKHEFJD3tfRoYZiNe5L
	yY1YcIbCk2t16Pqel4yh7uQgz/TMDwZAhCdGP8jd1eHB4rfsXNhwNr5mZLnCHlEv8d1CCixw==
X-Received: by 2002:a05:622a:215:b0:516:35fe:5524 with SMTP id d75a77b69052e-5164155bc78mr9045531cf.5.1778696588177;
        Wed, 13 May 2026 11:23:08 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90b2db84asm2582496d6.29.2026.05.13.11.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 11:23:07 -0700 (PDT)
Message-ID: <b5098cab-48e7-479d-bd76-b9f17ce4a5b5@gmail.com>
Date: Wed, 13 May 2026 14:23:06 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] t/perf: add pack-objects filter and path-walk
 benchmark
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, karthik.188@gmail.com,
 kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net, ps@pks.im
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <77329cf8f45b948f3986d004be72035c75ce40da.1778523189.git.gitgitgadget@gmail.com>
 <agJ+ORhy0O6fpJJm@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <agJ+ORhy0O6fpJJm@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/11/2026 9:11 PM, Taylor Blau wrote:
> On Mon, May 11, 2026 at 06:13:00PM +0000, Derrick Stolee via GitGitGadget wrote:

>> +	git ls-tree -d --name-only HEAD >top-dirs &&
>> +	top_nr=$(wc -l <top-dirs) &&

(I'll come back to this)

>> +	>depth2-dirs &&
>> +	while read tdir
>> +	do
>> +		git ls-tree -d --name-only "HEAD:$tdir" 2>/dev/null |
>> +		sed "s|^|$tdir/|" >>depth2-dirs || return 1
>> +	done <top-dirs &&
> 
> Not a huge deal, but I think we should avoid having ls-tree on the
> left-hand side of the pipe here. I would perhaps write this as:
> 
>     while read tdir
>     do
>         git ls-tree -d --name-only "HEAD:$tdir" || return 1
>     done <top-dirs >depth2-dirs.raw &&
>     sed -e "s|^|$tdir/|" depth2-dirs.raw >depth2-dirs &&
> 
> (Moving sed outside of the main loop cuts down on the process count, but
> isn't a huge deal. I think the main thing I wanted to suggest here was
> avoiding 'git ls-tree ... | sed'.)

This is a good find, because the structure of this loop is hiding
a break when a "directory" emitted by 'git ls-tree -d' is actually
a submodule entry.

I've modified the loop as well as the first ls-tree command to be
more resilient to these cases.

Thanks,
-Stolee

