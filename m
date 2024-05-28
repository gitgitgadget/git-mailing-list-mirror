Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30437EADA
	for <git@vger.kernel.org>; Tue, 28 May 2024 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907774; cv=none; b=hxTIn1sTb0ntSVlujfNKUauFq03Z8IsaaHqblhF9SFZ3+5h7IHwAQEwGZxqM3QSurHAzPGw4E9R4rKF4U1Ymw4Fr6tjqeUNu43tJkWi+6ntINjTZlaL4GiXXZxDu8cBsziHtKen9gZ0Ja7+Scua0I3ZSsNZygDl3AyYXhMJZGH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907774; c=relaxed/simple;
	bh=PCsrn/GV/HB3E8Hb/shwz95c5xChaHvtLb08RpRmrTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTa/hpUcs24NJxNTnDw3ZWe3Hospvv81pJVLQ9ut1pt9RGw8g1I6DKmQhZFl8bz3ukGT+TVrlVehmx+22LuDq7NjXk9Ye1bYMXaNCf1VsTRNtiKykwGiCCFsa2KHoY6Wdfmrn7jT2G5d3dYSfUxvzqGfyE9l5VkgHcJ7Q8qdUTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Owl39k9w; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Owl39k9w"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4202ca70287so4794155e9.3
        for <git@vger.kernel.org>; Tue, 28 May 2024 07:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716907771; x=1717512571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SrwEpiQp5VfPO9DhVaNHtvu4ulPgOEGW/3SdBqTzonI=;
        b=Owl39k9wfPuRU93DNlP/7388jdFbkylw1XnVfQM5UUzp6/4Uik9WaGr9XIa+ZxEnao
         MRH51EvDfaEYLh60oXVwV2MlWLlvPM+5K3nrGTd7Jl1H1ugHzKXJuHoaJsOq/RIB/Dyu
         gipk/Okxb03KoYnnO7v74oU0SqNyjNk/NqbArFxYYC5bs7OdtdineoQEf8/G1Nk1lAhb
         LCQ+mh8twj6xcF7hyAFPSVF+QcTmCtHzJgetehnPH6WVDpaPkGQzZgyCAjrPBRDdsbmT
         0RpgUZPiEfcvjeHpQdLBjjZ+TFOmkAmqXuQjKpkeBTB0nl2WhPTs67hl8iY+WqacB8jh
         2Pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716907771; x=1717512571;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SrwEpiQp5VfPO9DhVaNHtvu4ulPgOEGW/3SdBqTzonI=;
        b=n5dLI9yloEcEUhWZeewceWniMTPmbaQAJ0GYgydXOJ6Cj73qobdmZFqqoW+0ueQRJF
         Tnk0fbPNSPqhy2VhiOxRwGEOAVDfCs+F3J0x124WTa1iC9n628hFg12c5VSstF6j42gK
         /30ggNWKfFMBxLOYTtQYQFBvqngGDTfooCaPyLtktvoqeYmlHGz3UrR4MS5nsbGPDNFr
         hDXI9yXX8xbs4JoqcQ+tHvMvLCCl7zXk4mbPm5hOvDd2xbXyjJtALgXRxCnUKFxtNLhT
         3msSxKDhqHieUcP8zB0GBVugUs2zMJXmM9IbTMesaQI5Yw24EUl8PNMTfqdttlUqhHXR
         wZkw==
X-Gm-Message-State: AOJu0Yyx7tDIlqcDEB/O0/IG85igrxIaDPpI9PuQIC5DawUztt/RLEAD
	+S0/vi9+nFMUMkKQHRNMIpTRVxSbcXQGJDqKA/Yn/HmNDNeksYlM
X-Google-Smtp-Source: AGHT+IEp4YyWzueoUT8ezKlZ5QWhXsJS2+R9h1AwsGa9f7eIDZ6+LC1jHfstxRlett97W8dHONMbRg==
X-Received: by 2002:a05:600c:1e15:b0:421:b39:9ea0 with SMTP id 5b1f17b1804b1-4210b399fe6mr137759525e9.16.1716907771377;
        Tue, 28 May 2024 07:49:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f1410csm177561335e9.15.2024.05.28.07.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 07:49:31 -0700 (PDT)
Message-ID: <0c2addd0-104d-4142-969a-500aab39c90e@gmail.com>
Date: Tue, 28 May 2024 15:49:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] fix: prevent date underflow when using positive timezone
 offset
To: Patrick Steinhardt <ps@pks.im>,
 darcy via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, darcy <acednes@gmail.com>
References: <pull.1726.git.git.1716801427015.gitgitgadget@gmail.com>
 <ZlXkvEeR-PgZMitx@tanuki>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <ZlXkvEeR-PgZMitx@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/05/2024 15:05, Patrick Steinhardt wrote:
> On Mon, May 27, 2024 at 09:17:06AM +0000, darcy via GitGitGadget wrote:
>> From: darcy <acednes@gmail.com>
>> diff --git a/date.c b/date.c
>> index 7365a4ad24f..8388629f267 100644
>> --- a/date.c
>> +++ b/date.c
>> @@ -908,7 +908,7 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
>>   			match = match_alpha(date, &tm, offset);
>>   		else if (isdigit(c))
>>   			match = match_digit(date, &tm, offset, &tm_gmt);
>> -		else if ((c == '-' || c == '+') && isdigit(date[1]))
>> +		else if ((c == '-' || c == '+') && isdigit(date[1]) && tm.tm_hour != -1)
>>   			match = match_tz(date, offset);
> 
> Without having a deep understanding of the code I don't quite see the
> connection between this change and the problem description. Is it
> necessary? If so, it might help to explain why it's needed in the commit
> message or in the code.

I was wondering about this change too

>>   		if (!match) {
>> @@ -937,8 +937,13 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
>>   		}
>>   	}
>>   
>> -	if (!tm_gmt)
>> +	if (!tm_gmt) {
>> +		if (*offset > 0 && *offset * 60 > *timestamp) {
>> +			return -1;
>> +		}
> 
> Nit: we don't add curly braces around one-line conditional bodies.
> 
> This change here is the meat of it and looks like I'd expect.
> 
>>   		*timestamp -= *offset * 60;

Do we also want to check for overflows in the other direction (a large 
timestamp with a negative timezone offset)?

Best Wishes

Phillip
