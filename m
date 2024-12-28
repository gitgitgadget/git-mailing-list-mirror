Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4121448F2
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735401857; cv=none; b=nPriXUCinPgfnVOL/towPfZLEBtlkUTzZ2HBDhiemnIUWlica4M2yd6MG8Pq6J3F6bhWlekY0LX58AEylKhKp3Xt6diUSLidlSZjjXfJUe+cSnnS9xBV9I4UsHac+biSUcW8r88IL5QyIskn46fOL27//gNQBVugIPL/h3gezlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735401857; c=relaxed/simple;
	bh=gN2s+jbTnC84NK+vW0iE0k9duq83/Ve7R+bcS9fx3Lk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uAlvW4ms2WUOihlkbYjfQnqBKpChL+zzyUn1q84m9Ex1crdMbX56u1CBUg/fhuRE38Qb222YL9s0UpMMZazEEiVbzUKms4e57PdJfJKZgkSo100eHEBDFr1I+XRRag/1E5MSTY2c4N3gb8fNS9ZIBfrK8/0i8awO+AS2mWhEjsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAxPqUBx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAxPqUBx"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso53756365e9.3
        for <git@vger.kernel.org>; Sat, 28 Dec 2024 08:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735401854; x=1736006654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a7lgpAd+pyFyTrTHhqgV7giMBSpfR+KN+tRGhNL+N84=;
        b=aAxPqUBxuB+Z+JZrD2kpHYrh5lZa/gO9UByTv739JEdvgBIclXv6PQrMeJMfojIwNX
         OgjCF3vqhj495DOq27D49PGsfxGGMoUNpUXyYDrXIBTBfsC+ivfgGeGuJJoq+ChZ//Ri
         3Pw13t7NJ0mRmRh/i+lu2L3Ypco49jRCkHydcerTwDQqgdmDhhFuNVU5Br1Q9JUYvggo
         IOspX6sj97wKRDfNfeI1ixNr+4DWMEo+FbMXXJ+rx5pVyHRqxLW9fw9O+s2k/aoPPvOP
         6pqkRSt7MlH9+aOMMUZwOqqlMAZc9ehh7Uo7Q19BitwQXLPhnR1oX7bgimAWoDmqEVZ+
         oQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735401854; x=1736006654;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7lgpAd+pyFyTrTHhqgV7giMBSpfR+KN+tRGhNL+N84=;
        b=E/49VXQfGD25RFim6p/OC2s2xfvGDQg+jQsHDapZOmK0RP0ZN1w/HoVobu3IlA3XFk
         3yus4APnhM7zYaxNXAnXJ6KtT7zPngcQvyjiEGRxKAVsLo0fJAMIczdunhKwp8ze6Pna
         UZxCavUpyXKjARdVohKVX0XX5LMhX5IHD43llbjyVSGMp8H+oDMfTEKHXeFyNzURqf0n
         IJG+XzK7JLQDICY+zhW65X6YJ/iUietVTJUOqdmSXB8f8PddN6FrHDdMiVsozwmwyn1H
         2C3lCxttx3BqumOs2ba+ivKSN3ZNKoEx+xOmXq61O41eslj0UwTANW6zhBVScLPBKpZs
         Dnjw==
X-Forwarded-Encrypted: i=1; AJvYcCXKk1sGhpI/SZmqzDwdNtX/DEnKmwU9hU/jkbuQxOJlHguTwaYpEeC4dP/2GQKWdafcE+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuVVHEot0N9dpm0fuUx8H95t0pvPSgWbknvw1jUA/RKaed0Sow
	6Ne6+L4mQBBc1p+ROi4MbTLJ3z71Vy7byBfAEvq3H1eBMyBdSjRd
X-Gm-Gg: ASbGnct9ByAmxw5lBuHY3qY9A6BQbkRkyXYC5loEFP+7BXu/7Mtng+NSVd8u0M184pl
	hmeDUm/bPG0E9GzpZxOW0BPr7Ph1YVJsxeTIOn4+ZlIVig+h6WymRzFRoQTLNd6lzZ1Ez+gisWK
	g0+DqNLsC9e1oTVoVL3LfqiZ8O203spiDxPs4zYByFdtK6D8gMA18dAJFeQDRlSG1EC6fKIRckH
	VSawNsZJ+TOx7sdHJwgvxvCygv3gt+Nsdzi4akR0Ou5QCBckDGKK/ZSyH1y/kPDdpCQm9uRP8ax
	h++jZjhuGXbTJU2VoRVVqx26luxIHJ2qlTA=
X-Google-Smtp-Source: AGHT+IE/GfDq+bnwn+XdyXVODyFEx2BOAeZU7ah4tuVLIESiw75GyqFfTFRaOWdn4ZYXHrLuRyQ77w==
X-Received: by 2002:a5d:5847:0:b0:38a:2b34:e13e with SMTP id ffacd0b85a97d-38a456cbf49mr6516292f8f.18.1735401853527;
        Sat, 28 Dec 2024 08:04:13 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847dabsm24906391f8f.59.2024.12.28.08.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Dec 2024 08:04:13 -0800 (PST)
Message-ID: <11a36c3d-d42c-45c5-bed7-0e40205d66ea@gmail.com>
Date: Sat, 28 Dec 2024 16:04:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] add-patch: Fix type missmatch rom msvc
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>
References: <20241223110407.3308-1-soekkle@freenet.de>
 <20241223110407.3308-2-soekkle@freenet.de> <xmqq34iaxh7r.fsf@gitster.g>
 <e396131c-1bd3-46d0-bae6-cd97ca9710d8@gmail.com> <xmqq5xn5urhv.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq5xn5urhv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/12/2024 14:31, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> @@ -1626,7 +1628,7 @@ static int patch_update_file(struct add_p_state *s,
>>   			else
>>   				err(s, Q_("Sorry, only %d hunk available.",
>>   					  "Sorry, only %d hunks available.",
>> -					  file_diff->hunk_nr),
>> +					  (int)file_diff->hunk_nr),
>>   				    (int)file_diff->hunk_nr);
>>   		} else if (s->answer.buf[0] == '/') {
>>   			regex_t regex;
> 
> I skimmed your "how about going this way" illustration patch and
> found all the hunks reasonable, but this one I am not sure.  Is
> there a reason why hunk_nr has to be of type size_t?

We certainly don't need to be able to hold that many hunks but changing 
it to a narrower type generates a truncation warning in ALLOC_GROW_BY() 
that macro declares a local size_t variable to hold the new element 
count and then assigns that to hunk_nr

> When queuing a hunk (and performing an operation that changes the
> number of hunks, like splitting an existing one), the code should be
> careful not to make too many hunks to overflow "int" (if that is the
> more natural type to count them---and "int" being the most natural
> integer type for the platform, I tend to think it should be fine),

Yes it's hard to see anyone wanting to use "git add -p" on INT_MAX hunks

> again, that applies equally if the type of hunk_nr is "size_t".

If we cast to "unsigned long" rather than "int" here then we'd be sure 
that there was no overflow as we only support files with up to ULONG_MAX 
lines so there cannot be more than that number of hunks. "unsigned long" 
would also match the prototype of ngettext().

Best Wishes

Phillip

