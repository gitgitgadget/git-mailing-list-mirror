Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D520C189B80
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200342; cv=none; b=kQb3ozGXFIqISiSD5frWrcVj2//X8PFnyU3+GfyjD3a/QgY3YRkXe5Ye38XSBMVbuBeEsaqzTO9fvqbpCX4k9f6lBxQN+0iC1B8ejwcHcaN9swaMHeYE/DyKP+AaIIfLplhrwcCh8ymwRAy6T6ZHrTLbA7oA7rSpQRNg0AxDG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200342; c=relaxed/simple;
	bh=BdVhgEScGiCi9AyMNUQsNgpNiSXStFzvNOJ323T9N9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vl6G4NTSz8kcWDiJt+flA+5G8dRU4rLVYFA7JHvCT5ClDwQmruNkeqxOx2oifKybLZi5jHf0c7JZeJSBscjwyJMe53QMAJO5eIWMB5WHxsoec8HeNntHOCoselJmCnSddhlAAypRBN5oBJnk8cCfM2N6jV/c9VCpp67xjT63Aaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNb/eP4o; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNb/eP4o"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4563bc166a5so199985e9.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753200339; x=1753805139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=llXtUsZ0FVyRTQeg9vQyPdU6wmDKZT5Wvu8KDxxKXiI=;
        b=fNb/eP4oE+0E3EXOcJKrLITm9sZRseG/Lj6SMmSW9WwwWwxgMugAOGWhmIL1Ghc9BS
         n0hMCXDOxGqC7ePe77kta8o6L9K9bh/yRhkna/Q+1mCstATKirawhsb4DcA//SSTlQdH
         JXT1p2BBVA+AzNzhpG7671B/wFahTqDuSQdKUkwefm+ZWv/OPan5Kf8yU/URHRAJIfK/
         cS+MEzhHpHBnv6XfGDLjjVfSOiMfCuhyqFMBxwH0BAIPkdurbwn77Bk0eDV/TlPokiwr
         rgH2sNUqDXo2YbYg+QNR/Sf/aqUhxAPfDY2hzvpbH8e/0ZM18ClxszI5aWxuotT1SstC
         7kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753200339; x=1753805139;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llXtUsZ0FVyRTQeg9vQyPdU6wmDKZT5Wvu8KDxxKXiI=;
        b=TaLzT1nsdWS4yDXSlXpP4xhZm1jIcX/UYL5OID/eMEGSzMHBUyH6hSzhMy7QS/TIRF
         Ua3GSumFRPM1e99DCp7Ci419hEyxzmFppnHDeannRSqlb4VTGjL5mZ9FFJvZCdkArahg
         cnsSK7V4JApEzxvK5I/ecoClQD6T6KWeenNb5g3qTvBQCujz3wEzaocdzTz36ZOuTwEY
         aUfvI9yIQnJcBN2A5dkPm0wje3vhCG9jLNxA88VZX2R2K2OqpPiyWbmpkCtT//hguGAG
         Evb6ggECLGruBKepzwW+siFvJ5Qz6yw9suYmP0DLMc9EACSBKbyWPganU8aDU575iRjG
         wqIQ==
X-Gm-Message-State: AOJu0YyG0/aGawaLParbIKIr5uK+nrSXyNOLSAVcifUWVf/i+lhc4nTZ
	LbOlV/2veSmO80y8eAZ919HLkmGVRj91exzv6rXOOyGif5Rk4t07LVLw
X-Gm-Gg: ASbGnct3zOYDhTUZt4z6TBY6vtKf6udAqm0Kyaw1YteB1gTUOHcjZCTCGaOdM4YuOR2
	FPHQEAMy34CRG70Z6hMm/b6JOKLwBwYcfLgSUYK5iU7Za0Tb/AmLaG7CKKLlzPtiM5LrHQRf0Lw
	Xe0+j/xnEZHoe1RWuVn4hnxLEtpRCAAd7gnciwXyAmhfKQPtAV/qQn1+JNVKpHG3qSOm/RsRr2G
	FJpl+WjkQrrQGsOOXoGVsKTg7u9E4vuEYKt+tgvVzEdK+VSKAMY8BrTgjv3qUNhRxACgX1h1sh0
	1ut+QAN7S7RSAtnvCv9yREKuoKLKuC94ULIHS5AzGPE7P83WEu3ZovqixNeuHh/XVhU8ScZWIie
	D1ZxUZDaKckzXM3Elp0irjccmKkZYxMJm1YV4LOGDMcSNZog8MU5mP/CIq0DAjX7radvuy3s9PT
	p2
X-Google-Smtp-Source: AGHT+IFRbi7a1eWcTphNKFSYzmghexGH2u62VnIdss/8LzxT9ptW0qQQIBDCsjLD8pYISwwM00CYfA==
X-Received: by 2002:a05:600c:64c3:b0:456:21f4:a0a3 with SMTP id 5b1f17b1804b1-4586271d182mr38812175e9.5.1753200338598;
        Tue, 22 Jul 2025 09:05:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b5a4253sm138050185e9.3.2025.07.22.09.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 09:05:38 -0700 (PDT)
Message-ID: <49703ba5-5f2a-4e91-b9c7-5500720d5d3d@gmail.com>
Date: Tue, 22 Jul 2025 17:05:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/4] Better support for customising context lines in
 --patch commands
To: Junio C Hamano <gitster@pobox.com>,
 Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Christian Couder <christian.couder@gmail.com>,
 Leon Michalak <leonmichalak6@gmail.com>
References: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
 <pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
 <xmqqfrepzdxd.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqfrepzdxd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/07/2025 17:50, Junio C Hamano wrote:
> "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Changes since v3:
>>
>>   * Update commit descriptions
>>   * Read struct properties directly instead of assigning to variables first
>>   * Simplify config setting / error checking
>>   * Remove redundant tests in later commit as they were replaced with better
>>     test(s)

I've left some comments on patch 4 about this. It seems to me that it is 
deleting useful tests and replacing them with redundant tests.

>>   * Change tests to use single quotes (this messes with the grep so was
>>     unable to explicitly test single quotes in the error messages, so decided
>>     to use regex . instead, which is what some other tests that have this
>>     problem seem to use as well)

Thanks for doing that

> 
> All of the above looked reasonably well done.  Will replace.
> 
> Unless there are objections, let me mark the topic for 'next' soonish.

I think we want to sort out the test changes in patch 4. Previously we 
discussed centralizing the option parsing in that patch as well but we 
can always do that as a follow up later.

Thanks

Phillip

