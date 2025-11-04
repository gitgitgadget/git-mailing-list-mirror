Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4D92561AA
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273176; cv=none; b=CWutJ70K0nheg9SwLI4M+Y/UxOjXS/RDIjdyKmNPRdU2O/BdIgkm6OW5udgDywRp3CC560ScsXXlXkkgGQjUswf8PfTCk72VHpI8qYyXSFrOC9Ri9EWQCVcw76WMTWUe83k6OsjQSqwG3kIcqOvLJnMRzSnl1YMxSl01LYbw1i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273176; c=relaxed/simple;
	bh=PCM9WoPj+zCmvNehi4kkXOxboGBX+KKA5D6+4NzCvdk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=p1p6v2eYv8vmJy3oTg99LabFkMsczNltos4igRCst+ITp+gzpprDf2age03mP7v/GXasEHSPTIQn/INkmyJ0llO3idiV0ZPtXVjkH+va6iN4+5YFtaRLHXij/ZSSSpMD2IbJOQkBQd2iCxe3GBJ1E3KJH0lfJkDrrcqHNfQHlCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NI05pDZp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI05pDZp"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so46351155e9.0
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 08:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762273173; x=1762877973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lJ8+xmf+95FAsLU2wSDAFo9Nckfbg4DoMebzdJamVl8=;
        b=NI05pDZpIduDwf9R+IIaielLmrQHxxzemV7HSyF26IWXa+lAIwDZ8OUz7Y9WEbKfjZ
         /dr/QO5szc/IvvjSu7ia/0P0oU5MMDFWvWyUFlc4jF44ZfyahDwiySK+ghJ/9Vptl0Jq
         EeHjmab06rI/t0dwBx4KcyqGHmrKfJL1gzXnYdVmgX4zdof1pEzHrj6uSiFb7zXjZdJi
         FRyxNfa6wbsCPX6JFaQqLD0NlAGMHO58RtiyR8Ay+XY6ZHf5S2uQE4cjdEA6Mx9VNdio
         jfnHVC48eCdOElrfFQfgOHG0az8H814HjEMMsPpgZMBAZ/Cg2vWY7kbBbnPwfMcFdyx9
         VVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273173; x=1762877973;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJ8+xmf+95FAsLU2wSDAFo9Nckfbg4DoMebzdJamVl8=;
        b=cN3fn7ANchmc2d6F8nJd9QG2wIK8aWj7Iq/I+B5ha1MilQXHxVZUtVHnMcqi2hh/2B
         Fr8kF8dVljjQ+Pkxi7YfwF2umlaGSTWIRfoI9E6H/1uE5kh9BIeIDVX0KTQbbiHay7p8
         gCQP4jyUcdnmRo7W9h0Jmo5Q5sDR5ykchxoqmXZxsVfdmXJwW89PY2iLdS/K9LFEFb3J
         PMd/lSS3tTQoxZXP7qyOV3QtizdcJAisNsYFqIFPImat3yVc8QlK1oFgotbrSnSOP23b
         kT5ysMDoPflbc3j6k575P21ftRR6/PWCIULge02oSn2e2uTTSjjeUIX2e+F1XaeoOqIZ
         +ggw==
X-Forwarded-Encrypted: i=1; AJvYcCUXDpGrqTpvF84xC0+do4cAM537edu2B4p3VJnoBiHo/AA0vfgPSsG8ATI/Ox69xHhPEqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ooqX7ttSExYPT7nnKYKR7OmcJtuZYJ+GbOlMtU8jweNtln0t
	icqcjMi7pnXxuFShwMszQ4uq4B3e/9/nTZnU6YEePO6tipu9BbFF84wE
X-Gm-Gg: ASbGnctUZG0T+zuprqxyZxIOKnbu1gV2O0ZiQf1MdEMpRVeLYPasheMe5wCR597F4zN
	le0pt9Z+VbR1sOh1qIFPqpJGEG/b0X6Zn8v/+8EMGPErze4xqZSv6vlyMRw0ByRalX5MNhAw5uj
	3nh5t8lTYPxvEb/ZYB1inMUP4vifhT82pjt+bNqx30yyn0osroV4Wa/zMRe7u7hJEaLCGrVFH36
	JWgQF66cGsHgkalGIvkWY34/nomJUnKQ6XnFt0T7fOfDbgHicZp3w8Y1V66eV5tweGhY+G5j+Ss
	jSBg7P/b8840K6onfC6Y+HNQgEXkUophp3rvM11ig6NXYKkAh4KQKE7toL4pf7j9sbcMTn5QWuZ
	wkXaMrpkRL2t7+Anl5V74d+QKWjAiqGhe4pFMea0HT4rDHbvFcJfyGD+E4GP8QXEgtJH211HRk1
	aVF00SuJeKKc9x3vO4GIHmpjJFPd2F+T7ZMudf+Gx5a9B/eEd4xS1Hx48uN79eCtM=
X-Google-Smtp-Source: AGHT+IEI+bRRsd/XZqonlvRvNU7bmMXN0B2n6r2JKIOLNSRlbsNppBeJ0szhjNjcpC0TP77UeVSdDg==
X-Received: by 2002:a05:600c:8b72:b0:477:55ce:f3c3 with SMTP id 5b1f17b1804b1-47755cefeccmr23669635e9.5.1762273172774;
        Tue, 04 Nov 2025 08:19:32 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773d81cb03sm217052275e9.13.2025.11.04.08.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 08:19:32 -0800 (PST)
Message-ID: <ec8d1764-649d-4edf-b0ae-a19ead5f6f9a@gmail.com>
Date: Tue, 4 Nov 2025 16:19:31 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/5] parseopt: fix :(optional) at command line to only
 ignore missing files
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Taylor Blau <me@ttaylorr.com>,
 Junio C Hamano <gitster@pobox.com>
References: <cover.1762100242.git.ben.knoble+github@gmail.com>
 <9ec696eaac647aa01466b101129da2b12ef5dbd5.1762100242.git.ben.knoble+github@gmail.com>
Content-Language: en-US
In-Reply-To: <9ec696eaac647aa01466b101129da2b12ef5dbd5.1762100242.git.ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

These all look good to me though I agree with Junio's comments on patch 
3. It would be nice to get at least the fist patch merged in time for 
2.52.0.

Thanks for following up on these

Phillip

On 02/11/2025 16:17, D. Ben Knoble wrote:
> Unlike the configuration option magic, the parseopt code also ignores
> empty files: compare implementations from ccfcaf399f (parseopt: values
> of pathname type can be prefixed with :(optional), 2025-09-28) and
> 749d6d166d (config: values of pathname type can be prefixed with
> :(optional), 2025-09-28).
> 
> Unify the 2 by not ignoring empty files, which is less surprising and
> the intended semantics from the first patch for config.
> 
> Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
>   parse-options.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/parse-options.c b/parse-options.c
> index 5933468c19..6211b55a83 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -226,7 +226,7 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
>   		if (!value)
>   			is_optional = 0;
>   		value = fix_filename(p->prefix, value);
> -		if (is_optional && is_empty_or_missing_file(value)) {
> +		if (is_optional && is_missing_file(value)) {
>   			free((char *)value);
>   		} else {
>   			FREE_AND_NULL(*(char **)opt->value);

