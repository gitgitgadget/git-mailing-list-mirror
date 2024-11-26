Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1851A1CB528
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732620269; cv=none; b=e/BSSYQ5vlTEYlqFizaehqFMbKe6vC3RvI3LxCwnrZolWxOICNl/QFvF71D44FEtr5tqgJu/FCIPVOgb8IHm5ThTYNV5krrtBxaBBAEu4Ddzo0nceRzRG8wIqUi9UKwkkR2Ed40WLqoMI9a63IJELuiGXkC3LXo4/4yIASxCqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732620269; c=relaxed/simple;
	bh=5gvrhTtXxzyfxmKs4ovw7Rdj2RuYWJ17loV5oWd1qqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHwmz9+Vbwj9RbA5wn4qEAUPtyFYCbGTY2M/CR9C+njBcrSzBiXzYKDNP+WvC3LbtkG97BCY1fp8WSIztPJOSiJcndZGLy7Dg1eBTewfqXIDMYjAUNzrLqHa+jkRk4Eee0qmN8yv1FPWkyN9/69ILY/Z50R2U2GArP3ZMltvjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSix0gbg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSix0gbg"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-382588b7a5cso3502846f8f.3
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 03:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732620265; x=1733225065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+JtfeWsigbLYX9Ql3COt8s0uJi0u3lfLk+G/TXWz3Y=;
        b=CSix0gbgddBFJyklpxDj9sVkocZXgnW8IrEgHCYyNUWAYkHr7rf0ePWA8RfklYa90p
         B1f0KVBMv8aCvx3HHPYbQLKFZLCd/EQlrVPPsRALp7gSMoaxIIJ11FhdB6pVguPGAz1t
         lo63s6NEltL0klmRGa2qkBExECaQWIkJkod6lg5Mesw/0XnIZmM7oyx8Rh7d1KUzP6dV
         vm463z0FZNDh41kOu9+nYr2yE/uxONP+kWZvyCrLEVO8if4YCtR1puSBf55u61ywxlPL
         miavn1M8OGrxMWsQXfIMoCzebiCsEZV68UVxRBchzFqxrTrRu9gDJ0MVWO8I3zdIgyTz
         4nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732620265; x=1733225065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+JtfeWsigbLYX9Ql3COt8s0uJi0u3lfLk+G/TXWz3Y=;
        b=ukx4tqgII46n8vK8h1CH4seEQMXhIc7Ty+QyfZ0vopEjP3moLynaA/3wN9d6waNnhl
         0n+CP8KBjdXjvsc1ujtG7pvfxyqqSaFnN+5zlLUBMnsM86JNxtBKTs2h16vhsLDBYCT3
         5ABxzPmY/a+OcHkvLoO3LckGQd/rce0vLLliMc10CHWM7mCiDQwisk0dFyK0SKR8d6Ud
         gIB8uoU/Z3fUeAIw4tHCAcle/L/HFQvV5XkEpQW7k2x62/i14vlbsf3hyTYNArOiRsqr
         AtdyhlsMdaCjhWhM0pH7D16ZsR1poJmOhdLCvRIf9WciYiErAQ6TKTRP96YEPlj0qsUP
         U2NA==
X-Forwarded-Encrypted: i=1; AJvYcCV6djBaNXKMN0Puul432i36YTJvRgbFM54k7OojB2t6oRuhhc8Gh5qpvKGGiGmTQct/7eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMeUMjNSqua2r9y/g+OPIUnv3nM2XvYGQUMrKjTMyUCUAPxwYY
	JkrpmNBHCT8pIuNvsGZ6ty3iq8xCSdInOowX1jTAqRjoady29XBw
X-Gm-Gg: ASbGnctLJF0+bn3/G7Ab6AgugFpN+cz6wjH2Wyz2yIARWZa7XhztCw7SQgzRnHrMbRD
	repnzD+OlMWJ3YVc+en+Tn1g5qsAyf/pzBoaqsdWs9rhW22Yq7sYWILx2HrrSVsv7+qUBj4wEzX
	oBiuMmjIor+Y+bFXrKXa5+JH70+y9szfmpTvFNr2PsHzQ6ZkLeYrkay8PUBz43Bm3xkd+jxj8mn
	smAoWAVj16601wk7lIZGDfSpalpmvlggbmiw7gx0eh04xcA3XkjD1X+LqAjQ+kELSo6+KzvZV51
	T4kaX7WWphOfL18Jh6HevpY+iyirpPyvfMU=
X-Google-Smtp-Source: AGHT+IFfZiT+scCV/wk1pnh0GvO7y95VJzwjW91N+YLqIKkT7ZaH/eYETtx5DfPya7mS+38IevAWug==
X-Received: by 2002:a5d:5f53:0:b0:382:4bb8:e1d with SMTP id ffacd0b85a97d-38260b4d616mr13468236f8f.1.1732620265131;
        Tue, 26 Nov 2024 03:24:25 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6f7:6401:2998:7057:ffa1:ce96? ([2a0a:ef40:6f7:6401:2998:7057:ffa1:ce96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafe3cbsm12987507f8f.38.2024.11.26.03.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 03:24:24 -0800 (PST)
Message-ID: <da8e283d-e749-4faa-b18b-fed9c51b0fbb@gmail.com>
Date: Tue, 26 Nov 2024 11:24:23 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] sequencer: comment out properly in todo list
To: Junio C Hamano <gitster@pobox.com>, kristofferhaugsbakk@fastmail.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
 stolee@gmail.com, me@ttaylorr.com
References: <cover.1732481200.git.code@khaugsbakk.name>
 <cover.1732565412.git.code@khaugsbakk.name> <xmqqy1163ijv.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqy1163ijv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/11/2024 01:11, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
> 
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> Fix three places where the comment char/string is hardcoded (#) in the
>> todo list.
>>
>> § Changes in v4
>>
>> • Use `test_grep`
>> • Fix commit message (`)
>> • Don’t need to cat(1)
>>    • Also use `-n4` in case `-4` is not widely supported
> 
> All changes make sense.  Will queue.

This version looks good to me too, thanks for working on it Kristoffer

Best Wishes

Phillip

