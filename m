Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90CD219E0
	for <git@vger.kernel.org>; Fri, 16 May 2025 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402123; cv=none; b=TmbLAGVdq5eyKC7uq23zHlfigO5QIOA9xSfvH9cqMbfLsOPvrgVlcB+3PIt5l+BuJFOGjeKoIlmqduHuoM8P81pz9m28G1WYi5cy6e+mdaSsKHlGWHGsCaW510fFCsMt4cWOQ90wj9urxMfHwdgO3NFIrv7X83qzePwkBpnEITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402123; c=relaxed/simple;
	bh=UUuwUDfDIBlGwLO39jdUeGL8c7I6rVSAewVwmETPluk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stVP+McRp0CrMcccUnbYhQbaQPXrDY0qXxRkEYiOqF9Ct3le3ptcCOJKpJ+3qQZNsZsCti7UgIldYBrgDYJRqAGSggkjzxE+mf0obxvqvhLVL/JPf7DosQ+RADtrZ1t1Zsvte0s9gJbNSEIT0F5KMq1SIRGe9iXSbPOw/p6xrn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XE3UvDUS; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE3UvDUS"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7080dd5fe92so18878437b3.3
        for <git@vger.kernel.org>; Fri, 16 May 2025 06:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747402121; x=1748006921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nRTHow4aNlyWUIWrBU4N39lKsWp9I03U7dv552bbDsM=;
        b=XE3UvDUStbFBzXXgwdf6QeQZhwO6nrxhwazPPUG+iKHHYP9dk/Nkb+dTZzH2/1M0g7
         3Eh87tE+IB9rgvhWV+jfRiM/atT+e5zmGzKy+nRd8SGz4WqJyY+PDAE/9Fi9RrBpQuKP
         MOy9ypTPvGG0G4k/7IARzJ3BxcV0HzXGsRIkZ+uhRJXMg7oFBO2makQajz6dHur0uJb8
         Vi+ZXU4LVlPss3N7bxrlVMAVI3G0EqIisvEYkUdWQhHAWxdya9/rxNsW31hZAoIP2EJ9
         LSL0YVOtwTqiZ43L6/2+qoPtEcPR6+HiYtsKx3HQMA1LSC4QyaLtr3jyOctzxYtyPo63
         68CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402121; x=1748006921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRTHow4aNlyWUIWrBU4N39lKsWp9I03U7dv552bbDsM=;
        b=IrGThM3s2CfMAiUXT5iDL760Iexixt8kabA3E9P3SShzmUqIBadrlZk6qwDYjSBxdB
         CuaR0V5BgZuRTo3XvHF714NAIxPVmn9e+OAy6NI4o+TXqGpWPYP1irC3N5CtZoco88cs
         KdlNoE7+SEduS3l4uuQrSEBI1wl9XnRkNT4YN7KPy8QA4SGbUwpEM928wW/kSHf5uVGh
         JbqOhasSpuIDkPa6wV+LX1Gp9hKxs5wypOccOZniFJxx9eZ206SegHUCAQXIWOxVyZ4Y
         MlcZX74IwbUW0So1RbRLOaQpAAtcgRyv932RkAuSFtiai0o2hZ5dagIAPj6a4qldUZSd
         KKQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/E5QnCuSby5o6TVuX2U42nw262HMBeoYmd7f7PwiILE9rlc3AnDqc2UyzMHV6rkhZ4/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTekwuJzJiL4bbRMvJvLm8l3/h/isCFQyWNrwD7yz9pJmk2Z6a
	kz8F9pGVGAFtXZDxYfvhQO0Dc5ATeyD08NALr163HPC0ZtyJ9B7AN3kz4pNLyg==
X-Gm-Gg: ASbGncteGclTss+hMy6IUk4U6CwffU2fz/Kv799iFFqDEHpoBzgwLlZmQBGWIJounGX
	Kwgsuq57Uw3aezudTEaL6s2/psh5pq/68uyxe6At0ShLs5ntJyQP5Nh3vP4U4kbJV4fKVK26elr
	SrDxxBrS4/L7h6xmjxuvE4WzkQSY1uHjWgs1ETx6+a0WXAuSpYq8bQw17cap30jin/I947dAciN
	vEQB1Gcz1VTDpBSwrCYpKGW0uZTQUZghc/+1IZpu8jXXF57drN6P9dVWQgoltmB5/ZZ+kG5HibS
	l9mGey2N6msUWRsVMAYvvNZIlNwMjuJ9MsufOUiRBDF1SQj5XKcegLspz/+jmilTTIj86u0n3oE
	h3YmYDHSsN0R35+Hi7x0IfDeStBcB7OMLg6E3vws=
X-Google-Smtp-Source: AGHT+IEyzLtY9PitpXqhVD5BRkr2NgRMA381eKZwGla/q4Ee595kGwbiyNF/dC4FbrrUygYbg+O87w==
X-Received: by 2002:a05:690c:600a:b0:708:bc6e:f48c with SMTP id 00721157ae682-70ca75e9b5emr55110827b3.0.1747402120648;
        Fri, 16 May 2025 06:28:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:9ccc:beab:105c:f288? ([2600:1700:60ba:9810:9ccc:beab:105c:f288])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70ca8547f4fsm4031727b3.119.2025.05.16.06.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 06:28:40 -0700 (PDT)
Message-ID: <6736f2fd-a91d-4ffd-b421-6670a0e028d8@gmail.com>
Date: Fri, 16 May 2025 09:28:39 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Integrate the sparse index with 'git apply' and 'git
 add -p/-i'
To: phillip.wood@dunelm.org.uk,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, newren@gmail.com
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
 <c1f7a9d6-4a44-4c00-bf26-6852819361e9@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <c1f7a9d6-4a44-4c00-bf26-6852819361e9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/25 11:16 AM, Phillip Wood wrote:

> This made me wonder about the other commands that take "--patch" like checkout 
> and reset. Do you know how well they handle the sparse index? They'll all 
> benefit from the changes to git apply in this series but I was wondering if they 
> need any further changes.
By adding these two tests...

   test_perf_on_all 'test_write_lines y y y | git checkout --patch -'
   test_perf_on_all 'echo >>a && git add a && test_write_lines y | git reset 
--patch'

...we can demonstrate that the changes to 'git apply' are sufficient
to get the improvements we seek for 'git checkout --patch':

Test                                   HEAD~3   HEAD~2
---------------------------------------------------------------
... git checkout --patch - (full-v3)     1.22   1.22  +0.0%
... git checkout --patch - (full-v4)     1.15   1.16  +0.9%
... git checkout --patch - (sparse-v3)   1.37   0.11 -92.0%
... git checkout --patch - (sparse-v4)   1.37   0.11 -92.0%
... git reset --patch (full-v3)          0.82   0.81  -1.2%
... git reset --patch (full-v4)          0.76   0.77  +1.3%
... git reset --patch (sparse-v3)        1.57   0.91 -42.0%
... git reset --patch (sparse-v4)        1.59   0.92 -42.1%

But 'git reset --patch' appears to not be fast _enough_. It turns
out that it has the same issue as cmd_add(). I'll add a patch for
this purpose.

Thanks,
-Stolee

