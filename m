Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB2423746
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726114; cv=none; b=PA5KXJV0uMqw+xC93Ef5eNMHXb+Z+ko8Iwm61jT3vOICwWiYoP2Cruew7iRnzzSy7/V8nHqeqocn3Bmcqb6fJZJuuqHYBCp4mCXrhrMG+cjnrduyn/Ua3OfjqmWtRmAG6fRLz3chrdmMiNc4AoWToLA4Nt8XBEH5DHPpLAcT3Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726114; c=relaxed/simple;
	bh=QCkS6paFMLBHbmkQ/GQF9FB1YzxvTpXAntk1iqXFgAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALTjCFI0uQPXMs3Ipyo5MqZ55WuxFhEaDIEkjk7iwmUsbJtReAMp92mGBreKd2YLId7brqXQ/Bdyj+n2K9Yoa6RzTRN+UySPfwmIXsbzbRNhdpzwD+aNllY1oVjZeQ9rIRmlagJgtN5ULVnmWJXT8Kr+E1nM+Z2p7pgJ9GKkQVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1rDp52u; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1rDp52u"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a9e25008aso40011966b.0
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 02:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721726111; x=1722330911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LmuAQVo/fOQ33vJydt9NdXe9/lOI87VFN9qG40Ag64w=;
        b=i1rDp52uiLLWIXe3zMq+wqBHlFMRByYAYoR7MYBQYq8WQnmdgzybfI45JPH93S2EuL
         H9dvRHcAxkoQFjnnHPJijRBkerqE1UfHVg/JecVEDxstcA4sQitumuKYW9uc/2G7rMBT
         UMqRP8x8xbcTk6lTfUKFlcDI02uqdtBAG8i2eACWSApJ345686gqWvfXXEok+oeJbUc6
         WNbstQblpipzRERQXrqUVD1IGNyxb1S7rZIaNzJFII2qxX0LVeqNehmcaP1ACCsu+NN+
         WADSvx4CpRhBs0CmH787x/USbtJcX1hTUYvirYggkyxgtBgE1ZY4l4mbrWNCmBvkaoxb
         VURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721726111; x=1722330911;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmuAQVo/fOQ33vJydt9NdXe9/lOI87VFN9qG40Ag64w=;
        b=NiW0DRkZdl8gW8ZzJA5B8ketqJA5Dsctxadpyi1iX3rlZv/UOtSOzwgcMoJ+VkodJz
         2Gnb8CW1kTMZDjuhICDgNoPf4fLtTbDAs8c4KcFCjC4KjRvv8dUk4ePVIaFnIvDePIvA
         aN1UPbL/242gSQfeolc6uYIU4M2it83QFSa/bcYs5ooHUoUdafkmfjQzuXPUAG0/ujo3
         kN+NutTBVYepYcrD8iIpFPd7Sg8ZYkfrIxNNjiqnNFGg/x2RjfRyiuToMUqSfcIWM4BU
         ycW3ZC0ZvIMwKbSXJHERA1RFgJEnBfW+XnPq/2bTuBJ/j2+T88FRAYCJg2SNpPZ15+Vx
         X3SQ==
X-Gm-Message-State: AOJu0YxgL0bMEFoS2ntt3/DPfWB1DRd0qrJpEej8hdnikTEuO+IHokPD
	Sjal7qxu8OJMHIu7YspflrAQOUAkTyOuosSXFWBxgUrRxBj/O9/3
X-Google-Smtp-Source: AGHT+IGAJot8z51al8oHZbG9mhgkgyv+Dicy+loxTcfIzbDp3RYU9DR2oQ7TipC1lmgD0oKgTGMN5Q==
X-Received: by 2002:a17:907:7d88:b0:a77:c26c:a56f with SMTP id a640c23a62f3a-a7a4bfe4b28mr594043066b.3.1721726110685;
        Tue, 23 Jul 2024 02:15:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a9fe99a67sm27751266b.168.2024.07.23.02.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 02:15:10 -0700 (PDT)
Message-ID: <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
Date: Tue, 23 Jul 2024 10:15:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/2] add-p P fixups
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

These changes themselves look sensible. As rj/add-p-pager is only in 
seen I assume you'll re-roll with these squashed in once everyone is happy?

Best Wishes

Phillip

On 23/07/2024 01:39, Rubén Justo wrote:
> Rubén Justo (1):
>    t3701: avoid one-shot export for shell functions
>    pager: make wait_for_pager a no-op for "cat"
> 
>   pager.c                    | 3 +++
>   t/t3701-add-interactive.sh | 6 +++++-
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> Range-diff against v1:
> 1:  c3b8ebbae7 ! 1:  15fbf82fff t3701: avoid one-shot export for shell functions
>      @@ Commit message
>       
>               VAR=VAL command args
>       
>      -    it's a common way to define one-shot variables within the scope of
>      +    is a common way to set and export one-shot variables within the scope of
>           executing a "command".
>       
>           However, when "command" is a function which in turn executes the
>      @@ Commit message
>               $ A=1 f
>               A=
>       
>      +    Note that POSIX is not specific about this behavior:
>      +
>      +    http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01
>      +
>           One of our CI jobs on GitHub Actions uses Ubuntu 20.04 running dash
>           0.5.10.2-6, so we failed the test t3701:51;  the "git add -p" being
>           tested did not get our custom GIT_PAGER, which broke the test.
> 2:  f45455f1ff ! 2:  b87c3d96e4 pager: make wait_for_pager a no-op for "cat"
>      @@ Commit message
>           "cat" [*2*], then we return from `setup_pager()` silently without doing
>           anything, allowing the output to go directly to the normal stdout.
>       
>      -    Let's make the call to `wait_for_pager()` for these cases, or any other
>      -    future optimizations that may occur, also exit silently without doing
>      -    anything.
>      +    If `setup_pager()` avoids forking a pager, then when the client calls
>      +    the corresponding `wait_for_pager()`, we might fail trying to terminate
>      +    a process that wasn't started.
>      +
>      +    One solution to avoid this problem could be to make the caller aware
>      +    that `setup_pager()` did nothing, so it could avoid calling
>      +    `wait_for_pager()`.
>      +
>      +    However, let's avoid shifting that responsibility to the caller and
>      +    instead treat the call to `wait_for_pager()` as a no-op when we know we
>      +    haven't forked a pager.
>       
>              1.- 402461aab1 (pager: do not fork a pager if PAGER is set to empty.,
>                              2006-04-16)
