Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5418E389471
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782550998; cv=none; b=Cr2vtTYARskqdvdGVYGIwFdLGSSAP8amkuoeVs9Whp+AbwGYPwzGQNvFpF9ds79iu43owXZM2h5RRA6mhDiKCLYhv3rYZwnh1WpV/FXzUgdFmgENYpUQqPdo666krHi/r5kkxHN/+IIlnIv/UY5+DkglRwTUGLkAM6V/IGqCaLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782550998; c=relaxed/simple;
	bh=vqQJoA0FzwwfJ+RDi2Ym8KmS1ea+0/q3py/A0NNpGoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8WUnBQis+Tz2HpN7H4J7l/Hw35dpq2Zg5z581ab6PU/8uEzXwkT0sEcqw2cxQVpzd8Uq3W/UaiycsSRfuD10WqW0qyOUAgd9xD0fdYEv6XWZphIbsTDyhnliEHJ0gHtgMqwjjVLwPQ7uxq0CppOBl/1Zw5/+RL0HX4kMVdstYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRdYeiRX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRdYeiRX"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-471eeac43bfso119608f8f.3
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 02:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782550996; x=1783155796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vRNiGFIoVLKqWb3xgx7DAE74hSPXeAsb6DCRgJiDKrE=;
        b=YRdYeiRXxESXI+cC10HgzbVsH2rGtAVtyNoPKcqi/dVMJ2r7EMUhZKECD8Ee0mRSi4
         crei6tGqhTsUjB1HlesO29rRN1Xkh9gfAJCQWCBwLqVyXmESk4wV9LDZnIvrK5cyEdu8
         3ZKD3s/mHr6L88U8awqmydCr+U5RBThKIfmZ8rTPQJQj/gQLOmTG/jMem5D5oZpQKGJJ
         1gkJbfE+1MP2mcCjpM+6p6nVuZeheVhbeFAmUQ+wom3eoKEORGmpWfOPzFV7PMVeKgEL
         YV888gF5z8EWqo8jrSGyo39ZOO/SnArp5SMvamj0tYiATFSr2I9lI5YTvTfxSySEO9N6
         iv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782550996; x=1783155796;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRNiGFIoVLKqWb3xgx7DAE74hSPXeAsb6DCRgJiDKrE=;
        b=ibrlLdWnsMj2rfoD7FmAkyogvDWoE0gN999QU+Ex3cy9SQbcx6BigItYeTIfDMiv2Z
         cTkpdu9yDZ6K4Tue5JRcqRZMwm1XhsHdf7R8Js11DgvyJbV+Btb+Wz+Vj/Yg0Nr1Xfnm
         dHBCeQknf1Bj/ANcU1lz2vydAk/eBOMc2YugTdJ+Rwh9Wdfa7N9hDweiciBAzK9gJ3fx
         ctbGbF1uE08q1mENudwbrL2SVYKfMVasYpV2OooXfTHDXemy9ekMZQT3giLG8Fjjd/+f
         pCVtU1aRwtI9vP07Boyza2Nf62rnJQ3f/NMfV9O4iairmGISXU1q+Hs+wqY8uiVCUsCz
         1lww==
X-Forwarded-Encrypted: i=1; AHgh+RqEpJF7N6WxFdtuOhK4GhUYXiHOGmlnHUgYTCe75m6GahZ3/mIFBfSlQai4JyabP07+zUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1eNizEdONI9hPDRkpw6NLUj9jDAzElnty00JznBOOvFJMi9O1
	MN7EjPLKVLBc+9FSAwPEWJznpTg9b1oQStL48dq559VcyYIMInxfywxZ
X-Gm-Gg: AfdE7clNSKonhO82EN74plJRO4phSAlpyfW2M3Diat+21l6LKfKdTZ83+wxPTcamgvQ
	P89UrzqCs6u9Mp7EEZDwVbWuMO/j8Irc7hnVSBS1v9moToADf618lJdpfsoNOzGRkzwIzDf20P4
	ybJ0tPWYS//ypzqRrTVtHKOAi5jAf0ThRyHUEu6TM//+jBUcXITPnKnlimOIfIFoQGS27lrFtmU
	/6P01a2RUbP9xuHmt9QqtagqiIb/wKWA1UedI5EkTjJIL6z4VudR4qrcyAngg/w247wrQV9ENQ1
	0TSt/oeYqXzodG8cGt+SRJYWWXfrvavxtn1kPL8L8/RXbaqkVchMp87CD+5PukWk4wRnyQZLdhu
	Wito3BLAe96n9UhAGotXytU0UJh3kmYcyMQjItIDyilYcCaQ0dyPsfkltxmk9qavaZ3FpYtOs50
	f4PQcqcnGMY7PdgHynYfvwmEHUckjLuCWI0JY5ncFNG0riwzuTznSwVZHwLQ2iVOKFytY=
X-Received: by 2002:a05:6000:4210:b0:45e:7997:8b7a with SMTP id ffacd0b85a97d-46dbf9bf99fmr15787001f8f.16.1782550995533;
        Sat, 27 Jun 2026 02:03:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46e95f3d71fsm15817547f8f.12.2026.06.27.02.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 02:03:14 -0700 (PDT)
Message-ID: <790bfda2-30f0-4629-9416-8324b29f68d2@gmail.com>
Date: Sat, 27 Jun 2026 10:03:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t3420-rebase-autostash: don't try to grep non-existing
 files
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Michael Montalbo
 <mmontalbo@gmail.com>, Denton Liu <liu.denton@gmail.com>
References: <20211010172809.1472914-1-szeder.dev@gmail.com>
 <aj90x3DsER5HASUS@szeder.dev>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <aj90x3DsER5HASUS@szeder.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/06/2026 07:59, SZEDER Gábor wrote:
> On Sun, Oct 10, 2021 at 07:28:09PM +0200, SZEDER Gábor wrote:
>> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
>> index 43fcb68f27..bbe82d2c0c 100755
>> --- a/t/t3420-rebase-autostash.sh
>> +++ b/t/t3420-rebase-autostash.sh
>> @@ -200,7 +200,7 @@ testrebase () {

With an extra context line we see

		test_path_is_missing file3 &&>>   		git rebase --quit &&
>>   		test_when_finished git stash drop &&
>>   		test_path_is_missing $dotest/autostash &&
>> -		! grep dirty file3 &&
>> +		test_path_is_missing file3 &&

and so it is quite clear that this change is correct

Thanks

Phillip

>>   		git stash show -p >actual &&
>>   		test_cmp expect actual &&
>>   		git reset --hard &&
>> -- 
>> 2.33.0.1279.g1a260bf8c2
> 
> It appears that this patch might have fallen quite deep through the
> cracks... ;)
> 
> But the issue this patch is addressing is still there, and the patch
> still applies cleanly after almost 5 years.
> 

