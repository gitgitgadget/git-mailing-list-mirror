Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8492DC79E
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020597; cv=none; b=aoi06bsOIA24QTZADT6rK4yLBVewyU8jiL9+9bKLxbdofxG/YY2t0OejctkjBWvJ15aokOigYwcON3prOecYh7P1QYBkhtXYLN3hH9baLA/j5pCYFUMGT351SVHMSqMqflv24SXIVUkHx9ECSlQkppmhiDC2Das4olIb+uoiXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020597; c=relaxed/simple;
	bh=40HGD0b0I1Pcoa4xjyVRhxXDOLw3yqVIWoeVSGafQGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8DkDuP6fFlfjrrKYjajW9fQWmzuhWMYApHSzBndQQUSLE3wmtYKxzBy86lMH7xOn2WukmAUAKqRZ3TrbkqzoJVu3Rs4tb1s5P9n6zaUOhU5QAx2/05gqeeZ7d5zQ0gU4HoKa8jR8/2vVyi9xTVBPtoP47mKAVKesVu640H3LKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Arm2aCSr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Arm2aCSr"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45e03730f83so24840415e9.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 04:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758020594; x=1758625394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8CJJWizTRudNdl4Zm4HcGgzoBNzhYe9NcYunn+EXesE=;
        b=Arm2aCSrasuUf4kKTQxELYI+hv6YNvNq7+ZanYdTbWOL3qZ9lw/6PpLfK2QvbgEVo+
         EaAyF90zrWKABrH+n5m67XPhd1QHeUjSUe7hgwlODQLnVhtjvhsLNsrgwafD6UqnUiCm
         xSoLOCnXMYZALwbArxuHfwsfHODtpysiPoHAKeakaZh+fJFYNV8YVAenE2d+5s0rPW6m
         /oHuy70TpxxqTqbZbdoyhYOpjuVO9U58znzNko/F4vodEPXEBG3FcwRBZwS2QFUlrVG5
         FdZAQO99GW1VcWDV16c43nLcqJThtghbRHMao8K6bgqGcEctaufhGfBzV2UVZ0ll/n5M
         vkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020594; x=1758625394;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8CJJWizTRudNdl4Zm4HcGgzoBNzhYe9NcYunn+EXesE=;
        b=HnKw/bam1adVfTLih0xE0mXPVQb0mNRNdHaJIcyy5mEUK0/eolUn87qtl8yW5mxrLX
         ies+GBpsAZJNEOZyRghLbPRpZTnZZqpCyo58E6cTgiOSHj/SSxNF9HDh3yDytNkO8ibG
         scuxQzQzFb2XPn9QZp/hv2W4Ze7cJdE7c9UHP8RsYhNlAxRfqEs6ExFqW9FmcNJnv6Pi
         +qjikXQrEZKNRLZQmVPALAwhB3CVGyIZbmi3i+gZi31fRU0ApV74aPqFykRoVEAGPyvs
         j85JzlgdfugGNtM84VcuLVRnnSW/pRqB167Y3RzQhOwSlzR36TBuTC8GCUBE6R2mfNMd
         OMkg==
X-Forwarded-Encrypted: i=1; AJvYcCV/I4Z84DkXVm8b9bsOp0+lKHelJruk3nfes4bepTFwKUbWev/ZhFycjOxpcDd0w30K1E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTAO3747RgSAH+R0JQlgBf8QcOq+83LITYxDdQpX8MftPPiiU+
	QIdX3zB9qAm/+yc/0utlB5URSP/JyThyjuzcQ9qAhLFX/s/EAg/qKw48
X-Gm-Gg: ASbGncuQBrV0mElgS2Gb6QCHPdOhfqHNXBS2x5NA90AOaDLBlJKg0qcXfLym+JQhBR0
	Tx0c1W/6TW7cib3c0LhU/23yeaB1fOrYBF8Vsb6Ak36Fsvcq77JlmUD3jCCgm79sp39Ysl4B7Mi
	O4T1HO52zagcDEwJWrKfBdu36KfjC4pCrC2V7LKRuhCh5CSv7bK7WPwiGBZPmZY0MCg8UhJ19VR
	CMIFYkT37S0twjbAVeXstBnDvUWUZ/6cczFjb2V3wNb4iKPGvj+2uWoBGfTxH7pU89qhVDT/T11
	A+ywzwmGVgapi2UMSyGaQlzUgzRt/iPcZiKD+6PZs1shHbQ1G88PxI7PsbWroxKPAvV0gUz6STt
	XnFKqqSLwstgJsbEaidEDoSIqRqGAnoc9ll5dzXFIY1TK5iZMfLBFHPtP8C/ByqZNwZh/nD9FEx
	g=
X-Google-Smtp-Source: AGHT+IGDaLe5EOBrktE99Vj/20ikuovvUfZz6Wetj1KgiW9XewYU+L+dUwKOFLfJNPYCs9BSnv78wQ==
X-Received: by 2002:a05:600c:58c1:b0:45d:e0d8:a0bb with SMTP id 5b1f17b1804b1-45f21214d99mr105955055e9.23.1758020593556;
        Tue, 16 Sep 2025 04:03:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e016b5cbcsm222099205e9.11.2025.09.16.04.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 04:03:12 -0700 (PDT)
Message-ID: <4b689f92-5277-4e57-b4b7-8cc241ddd664@gmail.com>
Date: Tue, 16 Sep 2025 12:03:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [FEATURE] Proposal: git stash --only-unstaged
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
 "J. Dettweiler" <git.vger.kernel.org@dettweb.de>, git@vger.kernel.org
References: <89394e50-9077-4a7b-b30e-afd1be1a40e8@gmail.com>
 <18A45EC6-2D2C-45A2-8802-0E5060539398@gmail.com>
 <9f9e49c5-5612-4e6d-89af-839b353506f1@gmail.com>
 <CALnO6CCsFuYqo-q8D1g=vR9q22+Cy1MAgk1Ld0cD1wFNjr-eSw@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CCsFuYqo-q8D1g=vR9q22+Cy1MAgk1Ld0cD1wFNjr-eSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 29/08/2025 14:30, D. Ben Knoble wrote:
> On Fri, Aug 29, 2025 at 9:06 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> I think the example works but may generate conflicts when the stash is
>> popped. One can argue that the conflicts are unnecessary because they
>> could be avoided by popping the unstaged changes but I don't think the
>> example is broken as such.
> 
> Thanks, let me try to rephrase: the example makes no mention of
> conflicts appearing or having to adjust them. It seems to heavily
> imply to me that no such conflicts are expected, though as we
> discussed upthread it seems unlikely you _won't_ get conflicts if you
> do

Yes, I think if you edit any staged changes (that is the lines that 
differed between the index and HEAD when "git stash" was run) you'll end 
up with conflicts. If you edit a line where the index, HEAD and the 
worktree matched when the stash was created then I don't think you will 
see a conflict. Overall conflicts seem pretty likely, so maybe we should 
mention them in the documentation.

> [...]
> I suppose my main complaint is nothing about the example makes it
> clear that's the intended use case to me? Hence
> - we could change the example to mention conflicts and/or use case
> (smaller patch, punts on the problem)
> - we could change the code to accommodate the example as written
> (using ideas from your script; harder but bigger win IMO?)

I was hoping that we'd hear back from J. Dettweiler as to whether the 
ideas in the script were useful. It would certainly be better to update 
the command to avoid conflicts if we can.

Thanks

Phillip

