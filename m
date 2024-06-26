Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA946181CEA
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405832; cv=none; b=ECLu6p0Lviy2dsoKZ7Ric2tJVcMl25+gImBx1EIHKVO9o2t2AGEF7Q5qBmiREB9+ns3MJVcDnWUfNAIKcAN3U/7D2HDxgAMobCRey/yjO9B08es7Zlf5wSvQZIz3jOkq8fB7fOZnynGC7Lt/l9pISoMf9RsMCgvSVGlG+9/rA6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405832; c=relaxed/simple;
	bh=fDmK3+3hoPoRM2K2fPHEquWcNrQUic5Sdoo0mNUn0YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdgBYvCwfr0gt+q+Di/nB4+S0Ds8ytR7RPMfAa5hf/R5tHiWogVhxFlU13ptrvElfMrae9IduKV5e29xKwcUIIDe7iIeL0NE7Go7sGLV19rGtsfYMMRYTVr4jkslRFiWJpuCN4hbh1RlXhAv+enehq6hdozSH8GT48KvlPa+Oa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kw0Y720+; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kw0Y720+"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e02c4168e09so6418621276.2
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719405830; x=1720010630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WliSqZyc58ZPrGZk+VpjxIwJddXjG0rTnIrlUD7QkQY=;
        b=Kw0Y720++rxFeafbXbXWCy378BdZFfTjyQkiAvYtXRoFpUaqBblIKr2C+qCtSVGSVS
         8E76QRoIwqw33aoaR70M8sACZdRD7TFvC7/SFYJQ1n1DCo+fggAdY6L0Aw9G9bA2102J
         jiB9p2YmD8TONXh6Iv4/9lMuGDzaOI4Py13of5YpkdmE4h8rlB/jM61ZYosSpqjFyImA
         XTC/dWp/2Aw1KhDhl1B4hp4/Vs5cVHPQLN/YmR0ZOoMjdLiTFfLWtkC2OqyzeDicCJxT
         rf9CuiQ+/YDJWzmAoLx+t8grcjDQIHaD4yFE04EAH4/c6nPp/lRFYuNZ6yDrlUZ585D4
         sexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719405830; x=1720010630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WliSqZyc58ZPrGZk+VpjxIwJddXjG0rTnIrlUD7QkQY=;
        b=RqiP5ZeheIfCZJ/z4OvAocnCuMjogND01Das7f9p3P3kFVakGotVy7a5r1huxsQoCP
         OGY/RWdHKwGOuYaafqcTQ7M1Bi9hyZ/pmSI9PL+r2adZ8a5SLmOcnsizTCGSSFdPK8/P
         x/YUxR4rr8Ylf5ynhgT+XazDuiMRpqa41uXg/0ymiWV7DlSmV3h5nZ9/ctDEcym6qTEL
         8KkuLFJGx2NnO/6bG/9zgWZ7cV8ocbn39gxw5PZI8eVFvZcF8B53+xmUUVdQ4wIQhXVn
         w6krPdlTaJd0PARuozTlO6EEPvlj8aZT7pzEBZS11ZltodyCedrXE/HOuZcF3y21uh7b
         rUwg==
X-Gm-Message-State: AOJu0YyidGvud+XsU2DhqKtFGACRy7WUtRuGhkydaGx2ScyoaPWrIutI
	NUctRfF9hvFXhHs1G8wZ10w90CitSvbOzRA3MjtdBD8iJ6X4YpIB
X-Google-Smtp-Source: AGHT+IFtnwQ0152SrKxrGxMFSJdPGSsP6Zw4S9qNZojyAwuCeZkL0buW6gyUz+FYe7RxsOskYsGwig==
X-Received: by 2002:a25:dc84:0:b0:dfb:bf0:59db with SMTP id 3f1490d57ef6-e0303fc13acmr11078537276.41.1719405829688;
        Wed, 26 Jun 2024 05:43:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:5cca:8078:1e70:3d3c? ([2600:1700:60ba:9810:5cca:8078:1e70:3d3c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e02e6116e96sm4280359276.1.2024.06.26.05.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 05:43:49 -0700 (PDT)
Message-ID: <21977dab-31b9-405b-975b-6d022b080591@gmail.com>
Date: Wed, 26 Jun 2024 08:43:48 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] sparse-index: refactor path_found()
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, anh@canva.com
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
 <7c3b545ee5ea3a0e6686594afe582fa1a19929f6.1718899877.git.gitgitgadget@gmail.com>
 <CABPp-BHnUpPgg_wP67q2eSB_j01urbEaPV2Dqk1L+gUfqbZtpA@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BHnUpPgg_wP67q2eSB_j01urbEaPV2Dqk1L+gUfqbZtpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/24/24 6:13 PM, Elijah Newren wrote:
> On Thu, Jun 20, 2024 at 10:11 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> In advance of changing the behavior of path_found(), take all of the
>> intermediate data values and group them into a single struct. This
>> simplifies the method prototype as well as the initialization. Future
>> changes can be made directly to the struct and method without changing
>> the callers with this approach.
>>
>> Note that the clear_path_found_data() method is currently empty, as
>> there is nothing to free. However, this will change in the future, so
>> place the method and its callers for now.
> 
> I can't parse the second half of the final sentence.  What was meant here?

I was trying to point out how this method looks a bit silly:

>> +static void clear_path_found_data(struct path_found_data *data)
>> +{
>> +       return;
>> +}

It will be filled in with a meaningful implementation later on, but
I wanted to establish its callers here. I'll try to find a better
way to communicate this.

Thanks,
-Stolee
