Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D12B15539A
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720689523; cv=none; b=qpUshmIjNx+yqAqpVUMea7vHh/ErrPpf+Foj8+vAqzX/Q37FaaBbVmpgDw0FsAoP/KBD7MYQI85j3GHvHRY5Ec/ogma5OxZGPG+zsVqJL4G9tSaccGdWvE4o1rxf6dS7ncmPw5/cV/w/S0XR+xCX376ikJPbmVj0KeOEXsS81H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720689523; c=relaxed/simple;
	bh=9nsHVtSzpmMrP8gogQl2rv/z4qelLjZ5ZSGACPIYsSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfrUdqXGGSssb5TbJv8CoJ4IKSO3JzVoYVzBD6NfYCRSzjyAjpMCMXX7i1o+PLYzGWlt1CIbSF4Rnlxtx9Q+fDRdmP58f1cS6OmYKq4ABSXJgMVUiih+xb1/wVOHlqtBNpQ6LK6u/mi+maRAihldIkjLwXpdeGYQprp/JOKkjpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE0C0fQs; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE0C0fQs"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so898554a12.2
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 02:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720689520; x=1721294320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:reply-to
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9EfBrHxV9D96cCz2m89pOM0q4AyTLnfUBJabbw7TSBQ=;
        b=JE0C0fQsmAjWyZdyK89rsw0bOJiyR/q4y2ywD1H/0DCKD9waJVCgV8GIiCq7LZofx/
         ZACTyJcfBYaaxSwi/GeKPuX87ezkXkOzjjjQdSR0cuO3vvcvq40biV5+T4PdxoRKtJM6
         papU39j9+yMYuhHeDqcRWvUB7zzN6PIj9Snr//v5tMNJ7ps8RNQudpEVhPK7Tb8oVLFK
         jR1g34T5l19tUKsaXhDxiimrcwYMG/aRMmDPeietnp6QscHD7lLBdp6P1Gb4d8EocdWC
         f5dnXuXjAYtvqhqqToUz81jHsKJoqU1qWXE2oYwfcXIttnfugv0VCFIAosoyqtp+tb1r
         Qj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720689520; x=1721294320;
        h=content-transfer-encoding:in-reply-to:from:reply-to
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EfBrHxV9D96cCz2m89pOM0q4AyTLnfUBJabbw7TSBQ=;
        b=RHONseg8Eg6C7WUAQI1s05mVKRELX2P6tlO7xvnSD28Esi0BzytvhxUvORMZ7JvMW9
         cQTbkzrcXp1IGLeBtFcj0nDbMCvDVsrDLMcSl/XGAoqYknwwVjgE0sW7jo2xScm/fdgW
         XDh5VJAhegMYkKkL3293wIOmXbItibkypH2hgNPDdYvnmL3ryUDwqHQO3rhxlT3rgyPl
         RK1vKZUBnEmNAVUNVzopVBGY9r8bpQRLdl/EYy1t4yK6Lwi3wTs6jpGFnd/gTQBQXN+H
         cwfWtH0AkkYF0BAnkfBMtjLW+dlt1SILmJL+yCkEHNyk1eUZCwIIwa8C5dfkRxXMZ47m
         QtFw==
X-Gm-Message-State: AOJu0Yx5ANcZhp52oWfpd0l0GLPnSgjVvV59B7yTBIzjsl4nP9o1nsjz
	kmtdMTl3ooF9Mpj3qHrnWcK2cE9FTjaxKCbDhex9XSmjqxCC9Aoz
X-Google-Smtp-Source: AGHT+IF6NMxT/ROUavTyU4TYb4mqHEU2QZpdYuczDkalxYt1doNjoDTaXfankh50rjqjCo6dqjcgdg==
X-Received: by 2002:a17:907:9496:b0:a72:7f22:5f9e with SMTP id a640c23a62f3a-a780b88062bmr671909466b.57.1720689519374;
        Thu, 11 Jul 2024 02:18:39 -0700 (PDT)
Received: from [172.30.9.8] ([131.228.32.168])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff722sm235626266b.123.2024.07.11.02.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 02:18:38 -0700 (PDT)
Message-ID: <3f69ec61-1ee3-4f4b-a773-86cbf73a627b@gmail.com>
Date: Thu, 11 Jul 2024 11:18:37 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: update http.cookieFile with in-memory cookie
 processing
To: Junio C Hamano <gitster@pobox.com>,
 Piotr Szlazak via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1733.git.git.1719177846725.gitgitgadget@gmail.com>
 <xmqq4j8ycgjj.fsf@gitster.g>
Content-Language: en-US
Reply-To: xmqq4j8ycgjj.fsf@gitster.g
From: Piotr Szlazak <piotr.szlazak@gmail.com>
In-Reply-To: <xmqq4j8ycgjj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.2024 01:05, Junio C Hamano wrote:
> "Piotr Szlazak via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>   http.cookieFile::
>>   	The pathname of a file containing previously stored cookie lines,
>> -	which should be used
>> -	in the Git http session, if they match the server. The file format
>> -	of the file to read cookies from should be plain HTTP headers or
>> -	the Netscape/Mozilla cookie file format (see `curl(1)`).
>> +	which should be used in the Git http session, if they match the server.
>> +	The file format of the file to read cookies from should be plain HTTP
>> +	headers or the Netscape/Mozilla cookie file format (see `curl(1)`).
> With line wrapping it is hard to see if there is any change above
> here, but I assume there is none?

Sorry for bad formatting, I'm still learning.

>
>> +	Set it to empty value, to enable in-memory cookies processing.
> Is it understandable what "in-memory cookies processing" means to
> expected audience of this manual page?  I somehow doubt it (I
> certainly do not know what you wanted it to mean).


I pushed PATCH 2, this time without curl/libcurl terminology (i.e. 
without calling it in-memory cookie processing). Hope it helps. I also 
mentioned there that http.saveCookies has no effect if '' was used for 
http.cookieFile.

Regards!

-- 

Piotr Szlazak


>
> https://curl.se/libcurl/c/CURLOPT_COOKIEFILE.html has this to say:
>
>      By passing the empty string ("") to this option, you enable the
>      cookie engine without reading any initial cookies.
>
> But http.cookiefile is also used for CURLOPT_COOKIEJAR when
> http.savecookies is true.  Its documentation page does not say what
> would happen if you give an empty string to it.
>
> So, a casual one-line mention you added is a bit irresponsible.  At
> least you should warn against setting http.savecookies if the user
> chooses to use "" for this, or better yet, fix the codepath to use
> http.savecookies to prevent us from writing to a file with an empty
> filename.
>
> Also the libcURL documentation for CURLOPT_COOKIEFILE has another
> thing that is a bit worrysome:
>
>      If you tell libcurl the filename is "-" (just a single minus
>      sign), libcurl instead reads from stdin.
>
> So you can easily get your git get stuck by doing
>
>      git -c http.cookiefile=- fetch https://.....
>
> as libcURL will want to read from your stdin, while you are waiting
> for the fetch to finish and are not typing anything?
>
