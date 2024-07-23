Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B19914EC4D
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741028; cv=none; b=AcGMY/7nHT35g2LgwFPssQbwZalYqc6rpiouiVPMFcr3DEkeSJej3W0KwwFQc5/pNqAVkiAW7GYhe/pEdFEsfLGQNUDBCbu6quZ1JUK2naQ0Dq7PZaPFDphy2hhW3p96aE6etn4pawYQ/VH6BNu2rfulVfrY8MsL5FtpBwwKHnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741028; c=relaxed/simple;
	bh=2Iyh1TA5hHlPO9I3Y0fhJFO2Fhuv6lxtyIcSSODRUM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIb8eMv0Wc6DcC3RgdJ+vdiuhtfWpS1SJZ7h+nDBRyDgkjMVpjRoCSlevCuHSS/OcCXhhY23wB+Zpz8xk6OnzFEnWzxJFPhy5h01dpSImcdYwmeLGK2E75GKVe+dzNbgfCR3f3ZXVJR95cfJa3uWyjGdsMQt3WrDFQY7xdsQQ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGgeMdEr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGgeMdEr"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42660b8dd27so39497655e9.3
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 06:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721741025; x=1722345825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d91mps6EqbWya+UiWp34HxG6Mbc1KTLU0almOo+Uplw=;
        b=RGgeMdErtdCaZDRdMW7qBOK6vjwavqu9MNm7hxB8r82ZUiybevDSpTJbZibvogiiVa
         U7FlMxTlbXaoEvlR8aEAaxNLtNKy3eSMJmkEwpwjqgOPc181jFdt3MAe7cgt1Ap0vw8+
         NPC/tpPTzKUSkRAgZLH84idq+/4oG5NzcWqfmW7AT9oBjx50jL8p5bE/qK2hyJVOdb0N
         ylSLISHNkiPZNukRmjObTjcHrzDohSRJO+DwSJ+hrn0R3R/MvNOMXcPf4JKXA1eTKHqm
         UxfS8clNDnf06uzVUcC1vvybmpvdQhg94gxX4TEaXoW98/OkW+KXUfs29VybFJeKzFLV
         fAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721741025; x=1722345825;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d91mps6EqbWya+UiWp34HxG6Mbc1KTLU0almOo+Uplw=;
        b=ALlpiYHVTweQfkUBsiF6czQqrXF08Ff8wHAsWTepVmAftVvSvR3LDvC1pUeIv5BhWf
         EEclfjMeL9agydz88vBLrVdE6/VdKCMIrPKOwhrRN8Swj42hbizYCffstGpLMPM4Ed9g
         9s2DENa/C7So6Z6kJ59F1XHSPUxZsYPlSlKGZb6aMT56XaSjcaFrGEiNwPnpQmtlpFAQ
         CxNJW4Ti6/gHr8WUWyHkve5mv/E99BdyBxDEDZZaYWN9Q13Dh8XfWWbBT9QyTEQtF37P
         H3uCRix1fTWAcdnSeBCXDK3IXI1Av6+Q3bfcBDBxwgX87xlBNiHa10iuLgyBIxyoarHe
         lZcg==
X-Forwarded-Encrypted: i=1; AJvYcCXOmySwQ8E8hEl//n5g/a1ca1OC1k2szR2DZf1Kzc0c5amOw7qgpzky3oCNS2goAn1XuQX2k+CuWrpzZW2LQ3q9KRIV
X-Gm-Message-State: AOJu0YwcPvEdvLO/jCvbyojylQUVaRtG2L+xxLWTWS8OiazYs7LXIlKH
	f3XR+v3MFk2vwaKOVq5H8qRnV0x36qxKCpyWBz/FHSD+gorv8mty
X-Google-Smtp-Source: AGHT+IEPTvUB1fv1vVWvZwBK18m7bAEaGsc0P+okcVjfB1ROtgjjg4Sv7OH271tA4i+pHreIC98+DQ==
X-Received: by 2002:a05:600c:4451:b0:426:6ea7:3838 with SMTP id 5b1f17b1804b1-427dc569a28mr72003165e9.27.1721741025396;
        Tue, 23 Jul 2024 06:23:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1? ([2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-427d2a721b7sm197030815e9.27.2024.07.23.06.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 06:23:45 -0700 (PDT)
Message-ID: <55857c83-2181-4dcb-b354-f9f7e77cd6b9@gmail.com>
Date: Tue, 23 Jul 2024 14:23:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Kyle Lippincott
 <spectral@google.com>, Git List <git@vger.kernel.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
 <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
 <xmqq1q3lb4me.fsf@gitster.g> <Zp9PfdZtWJBp2xgl@tanuki>
 <71aa553e-9b10-4bc7-9c7d-5414691db79a@web.de> <Zp99icyrc0rdxg9a@tanuki>
 <0af06e8e-e1d7-4cf6-b968-5dad5f4fef2e@web.de>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <0af06e8e-e1d7-4cf6-b968-5dad5f4fef2e@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/07/2024 13:37, René Scharfe wrote:
> Am 23.07.24 um 11:53 schrieb Patrick Steinhardt:
>> On Tue, Jul 23, 2024 at 11:25:29AM +0200, René Scharfe wrote:
>>> Am 23.07.24 um 08:36 schrieb Patrick Steinhardt:
>>>> There is of course some magic involved with how we generate the file.
>>>
>>> It requires magic function names and generates code using a different
>>> language, while for_test is a just single new control flow keyword,
>>> like the dozen or so we already have.  So the magic employed by the
>>> libgit2 system is both broader and deeper.
>>
>> It is broader, that's certainly true. But it feels more self-contained,
>> less fragile and easier to read to me compared to macros.
> 
> In which ways can for_test break?

Using a "break" statement to exit the test early will exit the loop 
without calling test__run_end()

Best Wishes

Phillip

> 
>>>> But I think that would be quite manageable, and ultimately all that the
>>>> developer would need to care about is writing a `test_foo_something()`
>>>> function. Everything else would be handled by our infra.
>>>
>>> With for_test all the developer has to do is write a test with a
>>> description, no extra infrastructure beyond the existing unit test
>>> framework needed.
>>
>> True, but it feels like it is an invitation for writing unidiomatic
>> code to me. Unidiomatic in this context to me mostly means code that is
>> not self-contained and thus cannot be run standalone.
> 
> Partly this is intentional -- I want to do something that the current
> idiom (the TEST macro) doesn't allow.
> 
> It's possible that reducing friction will cause more sloppy tests to
> be created.  I hope that the bad parts will stand out more when
> there's less boilerplate code.
> 
> René
> 

