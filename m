Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D753213B5BD
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039474; cv=none; b=dm33zh6YI/X8j/JCji2qaNJ1T/gNlKPYVLqpxRRqhaongXOgD4MAtKHYgG/fcaR/j2aqFdUYzFepUSRAhtoBI6aESpNmkrxGacMoWcqwvCU+04eRH15Nr12j3b/qa4aXVS+g1ZAZd1oeoKmVKUQHJrxPjyOs1LrU6jGDMB4iTdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039474; c=relaxed/simple;
	bh=E2ZbRCOX876WDxd5fCWQ4jBgQhsGI63OOMcQsOScpSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPgvvZlVK14XPK3JFMRc+/hC7QREZHyn5iFXrAOl9rKouyu7HlETZXyeP5MH0Sm00IbKX/Tuf4aiC34lzoi+lWLi6fyjnWwgYkLUEKsbuGkzd9ShfZNoC13z3JSfOXePot/OTDwIpbBX8so1NCNXNQdCn9PBf08Q09H9FxcVnms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9J5cKf1; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9J5cKf1"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-389dca7bcacso2211735ab.1
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 03:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721039472; x=1721644272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s4jYEcF0AV4gf+O5GkaMYbgMKflsOsJU7VEhJgTqWvM=;
        b=V9J5cKf1q5qTpRDMXxDnANN6wFCEHKrPCGP5CMOEssQS8GzQwENo7HwZrnEiPRwFzu
         EIh3qZLH97Ejoyi6NoX8ORSuIAS28jOlTgO52rQBfJN0JDx+3n2s/uGJDJgXvOLF9EZ7
         k0R4+Rr7LeWdMtQKUELhuDrUQrBpWZ84ozPoB5QczA9cbdERqmmvg2iocis6oQn7lAuq
         NR9q5vzCSnv1TlnPD+kEkc+5Zv+wVsFBkEWs6XtpVlqxrMT1MNC6h+qBZed5WE+DfDL9
         /qNPa38rQmN6qDVsQsBecvpHaFWXL8/WT3IOzmyJaqkkyAmXLOEna4iTXQnKDYd2UoDp
         ZieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721039472; x=1721644272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4jYEcF0AV4gf+O5GkaMYbgMKflsOsJU7VEhJgTqWvM=;
        b=ajgndD45KMSIk2CcZGOVNK387qBtaAxBjWZOGUlUFPh0+PdnQheQocmvD09HFa91uf
         VwQtDW9fnCXvcQmBsiCV+mUgozBoFeguBYd2lhY6qHUc7ZVgSZ3SLM0bKsd6mVNq2GnQ
         69HMZ/v2gBo/pG7eps1/DXJwE2Ho8CZLORgs32Bjkz6dNr2flpwoAtfz7ACdzddHT4O8
         VtRoWk1kUSKjybf/VWXxkdbOIvrlRHeDo2h/AorPaXk/Kx4c0EsNB4ViH3kUEzqtVKuX
         v4fmI2Kc9gC7voUx9SkxniW68gPa90iMDHRhAoHArdRsX1r8fjCrAYN5+TyAf91W7G+V
         oAPw==
X-Gm-Message-State: AOJu0Yz5RszCBP2yIqRWXzBLcXoJqCj5LN0mYBkfC75MsM8cTkPLwje2
	xpQMU4ggnv6ByDLTp8oSEwenEgoGfv5PKtu5baI9S3JR9AHk97SKBokiW8pO
X-Google-Smtp-Source: AGHT+IE2JI8Ui6STqpj2j+Y13Yhgs3fVMKFXwEENsS7ZoaAGLAVCz/hWXAE/htwSevfd6oh5yQXX2w==
X-Received: by 2002:a92:c7d2:0:b0:376:3907:4912 with SMTP id e9e14a558f8ab-38d1781dd5emr84390525ab.1.1721039471808;
        Mon, 15 Jul 2024 03:31:11 -0700 (PDT)
Received: from [192.168.0.4] ([61.246.51.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7d2cfsm3987176b3a.100.2024.07.15.03.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 03:31:11 -0700 (PDT)
Message-ID: <c61a88c0-a45f-4d8c-b9f5-bb5853362709@gmail.com>
Date: Mon, 15 Jul 2024 16:01:07 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] show-index: fix uninitialized hash function
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20240712142326.266533-1-abhijeet.nkt@gmail.com>
 <xmqqbk32oc7g.fsf@gitster.g>
Content-Language: en-US, en-GB
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
In-Reply-To: <xmqqbk32oc7g.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/07/24 21:05, Junio C Hamano wrote:
> Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:
> 
>> As stated in the docs, show-index should use SHA1 as the default hash algorithm
>> when run outsize of a repository.  However, 'the_hash_algo' is currently left
>> uninitialized if we are not in a repository and no explicit hash funciton is
>> specified, causing a crash.  Fix it by falling back to SHA1 when it is found
>> uninitialized.
>>
>> Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
>> ---
>>  builtin/show-index.c | 3 +++
>>  1 file changed, 3 insertions(+)
> 
> Nicely described.
> 
> We'd probably want to protect this with a new test, so that
> regardless of the choice of GIT_TEST_DEFAULT_HASH, the command
> should behave as advertised.

I wrote a test which build an index file using a `hash-object |
pack-objects` chain.  I am not sure if its the best way to do this, I
would appreciate some guidance on this.

Another way I can think of is having an index file sit along with the
tests in the codebase which will be read by `show-index` instead of
generating one on the fly.  Thoughts?

Thanks.

> 
> Having said that, I am not sure if --object-format specified on the
> command line, or picked up from the repository, makes much sense in
> the context of the command, especially for the longer term [*].  The
> command is designed to read from its standard input a byte-stream,
> which is assumed to be an .idx file of _any_ origin, so ideally it
> should be able to tell what hash the incoming data uses and use that
> hash algorithm, without being told from the command line?
> 
> But that longer-term worry has nothing to do with the validity of
> this patch (but the lack of test does).  Thanks.
> 
> [Footnote]
> 
>  * Perhaps the file format does not make it obvious what hash
>    algorithm it uses, so it may be hard to auto-detect without
>    additional code.  But if that is the case, it would be something
>    we may want to eventually fix.
> 



