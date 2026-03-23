Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE86A40DFD5
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774225906; cv=none; b=pZzLtlXKsagyMourvjbmej5XbUfUzojmekhxqJdoVsiQ+hHegkzy95tLGRk6I9T7Qt3QYyP6GBgGZpzdGRFHX6Pd6nGxS+QnGemQeVLou9HA/lR+SQGLiYl4y2cQve/My6gZYNAYvaoEZh/8D76vFaclcN+iOgziZ81nO9KREuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774225906; c=relaxed/simple;
	bh=T8tXD/xWTM88MulviL2pM9tZQIB0wQ9fLBbJix109aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVJ++s0f+rO63tjw2wVVZ8oWfKZWDVumAYpr7SIHyRtxvcb9AUqf2o1QCu77PBAGI6DEa/z1y+AAW4izRoYRRyu6HJSlhvScWs4bHLCEMr+O1G7kBCf1u+7w/zwFAQa8WBOu41HX5xxVW1/xI1d2geLyRA5rg1lIjtlO9L4N6Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipn44jH+; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipn44jH+"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50b2ebca625so30850401cf.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 17:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774225905; x=1774830705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yhF+CIAgOSWfTE8rC1j3gXP7GPrBBltRoInDTi96hHI=;
        b=ipn44jH+SI1fDrbI3eiJ+pIvZ77LERhAdb2cryN8moLqhmWVWLHYXc1U1hQdqPEGuQ
         qUSpzCLqZOp0Ko1wT2Ol9/gGOn4b5yuoSn27tteIVrqXJRP0XwbJ4++ZJo0Rl6yssQ82
         g4Efzwl5sjQfrGePrvVNmm5UZWvzihbkx1QRFedKTh+PJluG4hRuNIKWnCYZFdvhqfay
         376Pjw8fEh3lWtLrb2O7BRvoap5u/4Q/7Hovhhka2bcgRbYNIEdkK9adEwN0bWWxA+HK
         dynrcoSAHx1ahH6i0Tfi6SVNKb3Suq//6LOyDYoeFj26uxO8yK87KvQjhpfRZYsUuQDW
         ixTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774225905; x=1774830705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhF+CIAgOSWfTE8rC1j3gXP7GPrBBltRoInDTi96hHI=;
        b=TzLHc5z2GEMui2KgWW7CBkDempitTeO6BcmxReSWENLmV0HveQRMMMdfm8oAkhJ3Q4
         cd1fU9fGJBGpqfdqUPUFuldlRAq1HIlxsKe7XoDq86FmYqWgo7z7TqQitoQj/PS7uXu9
         8QJ6RG0dYQTdZZnq4Ld+QAJPInILIVTXh8Ew8ecqa1WVUJnZxeHGjiSmYFVWcAEUAEdi
         dxNTDRaEzpCZfJ8EF3luCuqL+V4y3ETcuTgCIj0b5yVBmqUmEHjkzf4nv7x0bopJzo+L
         y1nJRxrb5OljAzWEJBRuHZibaLHpEqC9UKfQP3hatR64JLwLvWjBK8RMksabRxOkDaQl
         nlpA==
X-Forwarded-Encrypted: i=1; AJvYcCV99gyXTdYvCznLVEE74Mh9akZITx5N7gXv0ENpyDyxQi7qbPlU00wK9fbbjn25fs/QTk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Uf9V/hpsyj13l1b598Sdpkae2D/GSfbePqHt/tjwdAxd0G+C
	pGVZkyL+YKNDORGsmF0rWqN2zQmWmyq5Owx7Yhp8hBGxWB1ySjiUtZPt
X-Gm-Gg: ATEYQzx45tvhFv7fY/KaWkcGuXZvyrLqwVKaaodlW4AmXknwyvp0sN9lRaTfrW3k9xW
	J8OOxC8rVXeNPDoDqx5obi1bnhb8UQEIPXpT0gG9Lp7TEhDeWZvLLPm9wgtoJD/Xke7Iu9auOfV
	OLHl83cnn1HkD9bp8MBim3l1HyTTheYhdkVfSH6Hg28esmD4Q++6DnUMwFtFrePYUQtXBjiQ8rz
	47Mo6LcLG5frqhdaULEV+kHijLbwNLb2u0Uxb6yHmKckaP88mKEHqZJrqa+qXwjjrh7F0xssG2f
	ZHmA9Ebxj7ngPvlp5aQRPgMrFr7RIVh2ak8V+HIA6TNHa5/OVtgcocJhaWduUU2NJDFbr/aRB0J
	CM/VReJHPpwln40J+8C4o9917FPA4gOgbfhuADxdXaz8eCzKtNUQ9rG9BFFLPdd5UZsHQpdvaa2
	NnUz3NeDPhmlzNh5e0G+vTxeHAkTtB1jGf9u2R9fN7hp5M2FcgJ/wXfxBRKxSLyzdMAJDxojJIK
	U0IPHbQ2Ejk+6UVeq1UQZ3SRDOn6iVugh2qTDtELGdByQYSa8PMC79PWgzmyA==
X-Received: by 2002:a05:622a:a6d1:b0:50b:4a3c:8917 with SMTP id d75a77b69052e-50b4a3c9321mr68086611cf.24.1774225904629;
        Sun, 22 Mar 2026 17:31:44 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6b4:9c00:dca6:e357:abdd:ee2c? ([2605:a601:a6b4:9c00:dca6:e357:abdd:ee2c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c8534995csm73249416d6.33.2026.03.22.17.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 17:31:43 -0700 (PDT)
Message-ID: <b038752f-c950-4620-8d45-58741a5c9213@gmail.com>
Date: Sun, 22 Mar 2026 20:31:42 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] backfill: accept revision arguments
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Koji Nakamaru <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <dc6652c84c8d37b124eb76c2a9cdfdc4db4a149d.1773707361.git.gitgitgadget@gmail.com>
 <b0a73540-bf56-4c6d-bc67-b94a824ddbf3@app.fastmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <b0a73540-bf56-4c6d-bc67-b94a824ddbf3@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/26 11:37 AM, Kristoffer Haugsbakk wrote:
> On Tue, Mar 17, 2026, at 01:29, Derrick Stolee via GitGitGadget wrote:
>> [snip]
>> diff --git a/Documentation/git-backfill.adoc b/Documentation/git-backfill.adoc
>> index b8394dcf22..fdfe22d623 100644
>> --- a/Documentation/git-backfill.adoc
>> +++ b/Documentation/git-backfill.adoc
>> @@ -63,9 +63,12 @@ OPTIONS
>>   	current sparse-checkout. If the sparse-checkout feature is enabled,
>>   	then `--sparse` is assumed and can be disabled with `--no-sparse`.
>>
>> +You may also specify the commit limiting options from linkgit:git-rev-list[1].
>> +
>>   SEE ALSO
>>   --------
>>   linkgit:git-clone[1].
>> +linkgit:git-rev-list[1].
> 
> Should there be a comma between these two?

Good catch. Also there shouldn't be a hard stop, either.

Thanks,
-Stolee

