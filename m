Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CF5223702
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906525; cv=none; b=T4rJ0PkZYdGjffCruY+sZv5VK3IylZh55Cs2uGuq4da9XL8h3G46wUJyMsNS/9bHUcjXqzifNs4iWqtOcilxm6NLW+SA/JMuYBTN8RF3edjSQMX+/UsvmGqR+r3y7gJ9SXv5oXI18AD+eAxaq8O8m/SS6y9/DLmMaIR3JVqmeG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906525; c=relaxed/simple;
	bh=NY+rYc9q2aQghF+H/N/eS+WvirH0b6vX6CWmqhwMvyY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=T+SRpnql6LZTMilpG8ssXvAHxtytUmEcRbthhQcBLoCk4/nN3KYVUMofS3fZ02DfZRRKQM12SMsK3lK7WtsNp1oo9aruQqyfPTkLCxmob9hONMNKgYCwVNTbLF1vBJSXiucYL3jBERkpKABFSm6qdNr16Irm/IM2FPURE1Y0Cr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STw7cv8f; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STw7cv8f"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-454b1d0a115so10963395e9.2
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 09:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751906522; x=1752511322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/hZaGHMxU8srXOWlb9lx+NRLR1VaoStaa8Pkm5cVF2s=;
        b=STw7cv8fEEtHhCA9WChBh2zZt0ZY3vQOIlvzc/zKONp7t0Wr8wnyO8LCiMc6hI1y1m
         4QwNAvbIc2j70tO/KkARU11gZUKtCngi9AM/10iPrk+gwqDQ1xgrPo+qr5zzaM+v/wHI
         t5lTfv1WUTTCm99E4FD4xhv6uN6jC6iBdU6pYbH6oAmBVeiZAnhOZTHCtC2n0pRhJgck
         XFPBuBPwuQpSJVocExCHLP/HbqOMzKwLyT/9uLggnIHTYOslqDQW31qbY4I6qazTBm6x
         awrgDvrtN5fcG+/EV2cGfwcPaE1BdxgM6MLq0SVCCUgxq1LWKB9wF9y5GNsjLwnCExls
         bDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751906522; x=1752511322;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hZaGHMxU8srXOWlb9lx+NRLR1VaoStaa8Pkm5cVF2s=;
        b=NLqFHE4yB/yc7yRecxf24Ty35adtDn+J3Af5a83Lqc1NtZt2prwZ+4nshDdoXB4TwK
         /7Yz6LON64u9AVM+vL8I+eQistcC24xcn0C953/NgXGFVekfDacG5ACme23CyglzbuBV
         zfNFhv/z5R8aCrKjHgOmsxpJ/CG9eHkl6O8Byq8mnxkvIt9RoFZkJ/dhC+RQunoFdiKe
         l0G6SZgIf1iFAZocS8IFXjeP5YMhv6ShsK5JEq0zyX3JBCFxuu1cFsG0LMxaWE4NLw5f
         ImgQdae9IdyrlWhA2GPEPBVmFqiJZNJ1Q1W8Su56h3tHk0qr7ZYLBu7yKsPE6rkxzt2q
         VBnQ==
X-Gm-Message-State: AOJu0Yw8JzIBWhATj/a4Y3/FETqh2ydyDjunDUtSibZTWoMA+yI1dr2c
	DhxIFpCXWITYfMLD+h2B1G0Iqg3oB6utuiKLTXZtFCw12JxShory0Bo5cZd0gQ==
X-Gm-Gg: ASbGncu0D2cOWKapCWSahEPUWmDPytK4nnU9U57P6uk1sV3XBM+U5s9Ft2azh+EmTr4
	QUtWGnqHVJmkeimyI+T+YangVJi6ECNBrR2WOX7T6dph3gU6ig1Fw/iqr4istTZVWgt6FH7S5EX
	zEOaUd06T01Q2X5Kr7QiIzHOZAWdOgKjXDNG8vUVXTH7Y6J18yfkGUDw/+YxJy5jT96stPo2a8J
	9VIdJ1Ycwb48WUx1rvg6eNzdiWXsp/3RA8PXie+GJAFBJPTmkV1UZoUAi1XjcDwz/nXhd2Bhu8v
	DrfEK/tdGmtb5ygg9AcBRb552PbvFLXy06WpF2EG+aj63lDKd8XiTWGWJayg/6PFTArTbMvzgqh
	8xMPsoQauNlD54Zin5SNB6vYjIMPRms/bzQTw/g==
X-Google-Smtp-Source: AGHT+IGP5Z3Get3GuOgokpEZ2kN4HlsrOmMe+eT/wY7hIfmr2SPaVeGSvcoiXqiINuMGn7+NrIwldA==
X-Received: by 2002:a05:600c:3153:b0:453:8042:ba47 with SMTP id 5b1f17b1804b1-454b4ea67a2mr115362705e9.19.1751906521868;
        Mon, 07 Jul 2025 09:42:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b16a3799sm116808565e9.35.2025.07.07.09.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 09:42:01 -0700 (PDT)
Message-ID: <2ae656ee-cf3e-42a7-815a-016df23ac051@gmail.com>
Date: Mon, 7 Jul 2025 17:42:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] ssh signing: don't detach the filename strbuf from
 key_file tempfile
To: redoste <redoste@redoste.xyz>, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Fabian Stelzer <fs@gigacodes.de>, Junio C Hamano <gitster@pobox.com>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <20250704230829.29696-1-redoste@redoste.xyz>
 <20250706173450.12995-1-redoste@redoste.xyz> <aGuNCGNk96DK4GzX@pks.im>
 <05d66f9c-78b6-4624-a0e3-32235df05105@gmail.com>
 <DB5W4LH0MI5K.EJ0IILQ1IWR@redoste.xyz>
 <7130651b-76a6-4eb1-93cf-c9e237d398d7@gmail.com>
 <DB5YM57RVQTT.35ZS2BA5SHY@redoste.xyz>
Content-Language: en-US
In-Reply-To: <DB5YM57RVQTT.35ZS2BA5SHY@redoste.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/07/2025 17:22, redoste wrote:
> On Mon Jul 7, 2025 at 17:26 CEST, Phillip Wood wrote:
>> test_file_is_empty will print a diagnostic message if it fails so it
>> should be clear what has caused the test failure
> Uh, okay, this makes sense and I think it will be clear enough.
> However there is only `test_file_not_empty`, `test_file_is_empty`
> doesn't exist. I will implement it in an other commit.

Sorry I'd misremembered the name, it is "test_must_be_empty"

Phillip
>> The way I see it is that the changes that are being tested are related
>> to commit signing as the invariant that we want to assert is that
>> temporary files are cleaned up after signing commits.
> I see.
> 
> I will update this for a v3.
> Thanks for the feedback!
> 

