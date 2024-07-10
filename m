Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D48418FC89
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607709; cv=none; b=pMqCD49Y643zOHJpftmyXenIvcgaFRIY86267SMA7ZJXqXqgA/UYGgNLO6PRcwNG6fFD1nTH2ijJ+n5VmqidyTQC3mbkdSJPYLvjfKCFhnsGa3VwGTxmTEVmvEme2xCd2QEVrTJ2i7oTbAuZ5D17nMQYLuvSgoL4C/KpEtS77Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607709; c=relaxed/simple;
	bh=HPPgzJ0P4r2mxRADaWXiOsUWu6tvQYuF7BsmzQ4JFFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzCOiUA/WVqxMTchdxLn+Ex2APR5+dKRC0FZ8KoNEKFZb5RIoveOcf0ffTuMIWNnFjVpsfgXHXkp1DKG00o9H8qABM+LYMqSkKwh3I+sHsqWOWCp2SZ6otcL6yCvWoKV/1Vy5TJIglNfgW+NAuLPXaWgn0xsBMwsIIlKqm4Rwck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiA8WVh8; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiA8WVh8"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ee75ffce77so74369871fa.3
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720607705; x=1721212505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:reply-to
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iaIKm93XWBw84D8XVOdQEgMPkB0djBtWArE98Xeu/+I=;
        b=UiA8WVh8egoWX4ni/vJlciAl+d48sx+pNZ9ofAfwmYt/UFoZzpOpqOSaL9Cc2aLwLq
         mVSJf9Tbok2rmbnLTxNksQ0nPNFhMndjgxt0A/XIzLLRPoKL+y8ukPnrXCVLCbmz+Oli
         z5hEPgKdXS4s1vfpt92Qs7F0EYJj7GZKCLVyd1QXOGZrVFtc1ywvHP4WJclLMa3prPtQ
         O72fQhotuoIzjfc9KbtiAKJ1cibBqlN8WwQvkjDafB0kiaECfwwfuaOUBwUN9fk0h9fB
         5vr2OlHBJqKyg2MN68bP8fuleSpACqDXl0DD1G2171Zf8WmuFhqoUlyF+QuErT2N19Sn
         S0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607705; x=1721212505;
        h=content-transfer-encoding:in-reply-to:from:reply-to
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaIKm93XWBw84D8XVOdQEgMPkB0djBtWArE98Xeu/+I=;
        b=Z+5zp4Qc6p9oR0Tho7PpxNJpzfD0B0ou15nYVR3aHI4AqMCkM0Rn7bODRkLEqolIcS
         f2ARGWVeixLR7IsXkmNGMZ8jPtBFkLONovM58soyAOIxssEop0YA7FMs3bHEuM/XJUJQ
         FIB0HzII9xeGnKd9iNBxbfebhO3HIFg4oLiZba9R/PbdHjGFHn+izlXUZNzhKJe19o5z
         WelgFh2YTvTmtEsTMQdijJ0Vgqy9dzaL7pcCWsTEA4Gjux4+jodxxV7J2BMCy2LQAvv9
         xwqJfwgsB3j3ajH223aTW44wv/zUT+xOuLM2dZ2zvRcUhxT5luGv7a7+sj9d+43I4BLA
         1dBA==
X-Gm-Message-State: AOJu0YyIlKbuDv2LhtYJEa5XysG3ZW+LRQrxta50g8DjfTTg06+XEEnp
	ve2LtRH/59wOc3Hgv7o44ObSYllAJniB/IcwFam/Rg8QT2Mpd9EUTFAFgMtESvQ=
X-Google-Smtp-Source: AGHT+IFQCdy+7JcyoJjDZoFgWR3pHX6Axyfa/GqVF+K8AaDm6xhmr+aQazo3qLaY7GJMkHusoEI97Q==
X-Received: by 2002:a2e:9b84:0:b0:2ee:849b:576a with SMTP id 38308e7fff4ca-2eeb30bb3b5mr39817571fa.11.1720607705133;
        Wed, 10 Jul 2024 03:35:05 -0700 (PDT)
Received: from [172.30.9.9] ([131.228.32.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a86ec75sm146567566b.191.2024.07.10.03.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 03:35:04 -0700 (PDT)
Message-ID: <2d76e43e-db79-4572-8f41-60fbbea10af6@gmail.com>
Date: Wed, 10 Jul 2024 12:35:02 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC] http.c: cookie file tightening
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>
References: <xmqqed82cgmj.fsf@gitster.g>
 <20240709234941.GA1525171@coredump.intra.peff.net>
Content-Language: en-US
Reply-To: 20240709234941.GA1525171@coredump.intra.peff.net
From: Piotr Szlazak <piotr.szlazak@gmail.com>
In-Reply-To: <20240709234941.GA1525171@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.2024 01:49, Jeff King wrote:
> On Tue, Jul 09, 2024 at 04:03:48PM -0700, Junio C Hamano wrote:
>
>> The manual pages https://curl.se/libcurl/c/CURLOPT_COOKIEFILE.html
>> and https://curl.se/libcurl/c/CURLOPT_COOKIEJAR.html talk about two
>> interesting special values.
>>
>>   * "" (an empty string) given to CURLOPT_COOKIEFILE means not to
>>     read cookies from any file upon startup.
>>
>>   * It is not specified what "" (an empty string) given to
>>     CURLOPT_COOKIEJAR does; presumably open a file whose name is an
>>     empty string and write cookies to it?  In any case, that is not
>>     what we want to see happen, ever.
>>
>>   * "-" (a dash) given to CURLOPT_COOKIEFILE makes cURL read cookies
>>     from the standard input, and given to CURLOPT_COOKIEJAR makes
>>     cURL write cookies to the standard output.  Neither of which we
>>     want ever to happen.
>>
>> So, let's make sure we avoid these nonsense cases.  Specifically,
>> when http.cookies is set to "-", ignore it with a warning, and when
>> it is set to "" and http.savecookies is set, ignore http.savecookies
>> with a warning.
>>
>> [...]
>>
>>   * I have no confidence in me doing http correctly, so I am asking
>>     from folks who have touched http.c in the past 6 months for help.
> I don't have any experience with any of the cookie options, but your
> explanation here all makes sense. It might be worth including a test,
> though the interesting part is probably how things broke _before_ this
> patch. After it, it's pretty obvious what should happen.
>
> So I'll try to comment from the general http.c perspective.

Hello!
I'm able to perform some checks as I have Git repository behind HAProxy 
load balancer which sets HTTP cookie to record which backend should 
process consecutive requests.

Indeed, if http.cookieFile='-' is used, git stops and waits for input. 
It does *not* work even if I do:
$ echo '/path/to/file' | git -c http.cookieFile='-' ...

On the other hand there is no problem if http.cookieFile='' and 
http.saveCookies=true is used together. Git operation is successful. But 
if GIT_TRACE_CURL=1 GIT_TRACE_CURL_NO_DATA=1 is enabled, I can see 
following warning it the output:
 > 12:19:56.280263 http.c:820 == Info: WARNING: failed to save cookies in
It comes from:
https://github.com/curl/curl/blob/master/lib/cookie.c#L1758
But cookies were accepted by the client and sent back to the server.

PS. I'm using Git 2.42.0.

Regards!
-- 
Piotr Szlazak

>
>> diff --git c/http.c w/http.c
>> index 13fa94bef3..86ccca49f0 100644
>> --- c/http.c
>> +++ w/http.c
>> @@ -1466,7 +1466,16 @@ struct active_request_slot *get_active_slot(void)
>>   	slot->finished = NULL;
>>   	slot->callback_data = NULL;
>>   	slot->callback_func = NULL;
>> +
>> +	if (curl_cookie_file && !strcmp(curl_cookie_file, "-")) {
>> +		warning(_("refusing to read cookies from http.cookiefile '-'"));
>> +		FREE_AND_NULL(curl_cookie_file);
>> +	}
>>   	curl_easy_setopt(slot->curl, CURLOPT_COOKIEFILE, curl_cookie_file);
>> +	if (curl_save_cookies && (!curl_cookie_file || !curl_cookie_file[0])) {
>> +		curl_save_cookies = 0;
>> +		warning(_("ignoring http.savecookies for empty http.cookiefile"));
>> +	}
>>   	if (curl_save_cookies)
>>   		curl_easy_setopt(slot->curl, CURLOPT_COOKIEJAR, curl_cookie_file);
> This all looks OK to me. A few things I wondered while reading:
>
>    - is curl_cookie_file always an allocated string? The answer is yes,
>      because it comes from git_config_pathname(). Good.
>
>    - get_active_slot() will be called a lot of times, as we reuse the
>      curl handles over and over (the "slot" terminology is due to the
>      parallelism for dumb-http fetch; smart-http just reuses the one
>      handle each time). So is this the best place to put the check?
>
>      You actually unset the options when issuing the warning, so we'd
>      never see the warning multiple times, even if this code is run
>      repeatedly. Good.
>
>      I do suspect these curl_easy_setopt() calls for cookies could just
>      go into get_curl_handle(), which sets up the handle initially. But
>      it's possible there's some subtle reason why they're here, and
>      certainly moving them is orthogonal to your goal. And in the
>      meantime, putting your new checks alongside the use of the variables
>      makes sense.
>
> -Peff
