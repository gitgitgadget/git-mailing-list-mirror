Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEE7190670
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426936; cv=none; b=JEQHw+kyEB+c5+h7jH6HR/vN8X5PqUEC7k8nMgtUE7ChAAPL4MjhHRGJS17O0Jhrl171fDdqUsitn654QcCrvApp/8WxX/Sa0wVBHLg5SO6oUenN+b2PqMOtXpOhtd0P6ni+VKB7geNbRT11gvIN3jurvp1McfJwERGJF4eusQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426936; c=relaxed/simple;
	bh=pgWB7Ossp2cs8kJxxyw236k+eXrfOKVoSgoTpUuxEl0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ntp1ZKfFYTGhDVCWJ/3QucShsWE+6OMClb+2V+y+wAdFPqkpRgtznifP6kSvDDOwlchbASykM+RpfLuMTBz76lJk1bPQbGAXKqjwz7HDLVARjes3/uR6xpIKas1KvWRZbIsVntFr0liN7ztkUqG3DfITlEpl5okCrFf7YjPqtGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv9cam4x; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv9cam4x"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-356c4e926a3so6299942f8f.1
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719426933; x=1720031733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b0EMJe3Le+CtEGGa/WEUUFGEnsZM5RFu/94heBB2KMs=;
        b=Lv9cam4xOF1nsApbHbn2ob4cgR1BtALnryZ0RsvTynZePkHDjdI2ZtvyBCt5EGmSZ/
         J8GxgCxAVE6+wbwdCxfSPRijqwrAx2tuz/T8SdyItnXTMfS24v/Ao06rqNv4L3Quzpcr
         lMb8RvXRArM9Abw5OZAyPiiJQjIwj7g9yC8RF//v65FutSatn7wtkXth71JebZXdZX5h
         nS7JZU9/6A5cBT+XuZU9ZyHgKD+GU5YBXptDqCPCxNarMndV2iStxMZeglO2AF1XSovD
         lG8SMdpqwOPd21zM9A4N+Z4f72P04pbUl0VzU/7LLAU0I2I34dIDDhFeFvmacy5uff4P
         wL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719426933; x=1720031733;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0EMJe3Le+CtEGGa/WEUUFGEnsZM5RFu/94heBB2KMs=;
        b=RLXhXaqJvmhZFRekqNxVB+NufpoHBxnqu/qU1V0GkaJ7Kb+QNw48fiUKzq6JFqoECT
         MkIEGmi/2Z5eMe6ZAYR/rAHoSNTbBRm+QfYNPy7a8oDWKQByi9CnOaQCIPhrhJdGrD6f
         IeEwsCfqQFkVparwjdRcf+I13amPyQUwQ2TQwjt0Nme1eZEY4qJOrrtPjM6JamKL7zKQ
         vgc3qWLNLAyhzoQRJ9k8F9Wr8CwaqE/aj1EdTH2AzonSA3JucGP4kMY4+PbOTk4O+1vG
         fN3lVdrpn4898J8U6Xp5wnO3xzfv48BVYJoHnAhU+gXuEdbVJonjyyCVBa45a5N1JqMx
         bGkw==
X-Forwarded-Encrypted: i=1; AJvYcCVxIITUPyOeTatSa7yDck0ILOedoyLtsjKPtQlua3xUqTjXADkqzE3tTxWCPlHbDqPZcdA3MbHa9d/WEcPNHCLt6NGS
X-Gm-Message-State: AOJu0YyzzOa7kzCSv+mqY+P/yJY1WQ/RP6fbtoyvPKVImfQgUd9p74Ao
	0HtNmhhuUWZjsdmeq67eHlauTCQDWGqN+4N3PvnGAEBntpSEEErQ
X-Google-Smtp-Source: AGHT+IHMwxnkW3tYksYBe2QXreJrHhvp6q4CJgvVPFlkovmArGspk3J/0nMdhCMDXsihtN1Yvxhiwg==
X-Received: by 2002:a05:6000:178c:b0:366:e9f2:a54c with SMTP id ffacd0b85a97d-366e9f2a65amr8430379f8f.47.1719426933034;
        Wed, 26 Jun 2024 11:35:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b8597sm16503259f8f.36.2024.06.26.11.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 11:35:32 -0700 (PDT)
Message-ID: <aa94be27-60a5-42d9-adcc-f25f9a8d6ae5@gmail.com>
Date: Wed, 26 Jun 2024 19:35:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Local git server can't serve https until repos owned by http,
 can't serve ssh unless repos owned by user after 2.45.1
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 "David C. Rankin" <drankinatty@gmail.com>, git@vger.kernel.org
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
 <xmqq8qz376fb.fsf@gitster.g> <20240617211513.GM19642@kitsune.suse.cz>
 <20240625072419.GU19642@kitsune.suse.cz> <xmqqr0cl6lxl.fsf@gitster.g>
 <20240625183411.GW19642@kitsune.suse.cz>
 <834862fd-b579-438a-b9b3-5246bf27ce8a@gmail.com> <xmqq34oz1shc.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq34oz1shc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/06/2024 19:14, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> ... What is happening is that
>> git-daemon checks that the repository path is listed as safe and then
>> changes into that directory and forks
>>
>> 	git upload-pack --strict .
>>
>> "git upload-pack" then checks "." against the list of safe directories
>> which fails. It fails because the safe directory check does not do any
>> normalization such as cleaning up "//" elements (as seen in your
>> example) or expanding relative paths on $git_dir before checking it
>> against the list of safe directories.
>> ...
>> I think the fix is probably to make the safe directory check use the
>> absolute path of $git_dir. In the mean time there is a workaround if
>> you're happy to add "." to the list of safe directories.
> 
> It still is curious why unnormalized "." does not pass "*"

Sorry if I wasn't clear. "." is considered safe with "safe.directory = 
*" but I was looking at why it was not considered safe when using 
repository paths in safe.directory.

Best Wishes

Phillip

> (which is
> not even a pattern matching, but is a declaration that says "don't
> bother which path we are talking about"), though.  As long as the
> value of that configuration is found to be '*' literally, safe
> directory data is marked as "is_safe" (cf. setup.c:safe_directory_cb
> and setup.c:ensure_valid_ownership; notice that data.path is not
> even consulted if the value of the configuration variable is '*').
> 
> Anyway, thanks for digging.
> 
