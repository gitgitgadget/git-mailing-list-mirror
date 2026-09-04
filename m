Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CE937F31B
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534597; cv=none; b=JVqwkkzUwuCgXtoPTt7ziflZNkLmsvnPqU2Y1YxGkZqo84AO2iDlpuUBPNN9vDITDmcvwDrjSqRZI9KJIjMqMzqSdLcMb+M47f4GIZxqjw+WB1+yglJko+NAepq3eK7s+Y28pKOt2ApjW4cbb3OdXyieBNackiZedzhUvNjIcv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534597; c=relaxed/simple;
	bh=654AcJ7FjPDYTYiaZsgGX7n+mfAAMz9HOAM674F+4BE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hVGyFuJv7Fqm5PJekQd+GSD1Na4x10u3TG9tD/tsDOyM9NQHgJBeIr8YhjGDn8E/1hL1cmujvWM52Cp6UC/znFzwwdwpPgQlN4ahVL6ao+VOJpwnfmUvKLqdUXjyd5ATpffO+wH4HhY3pWHG3GpYYvr559rVsGoVEHZHk2sPUIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nP2z5U7u; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP2z5U7u"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b159850b16so1086998e87.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788534593; x=1789139393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H0QwtWyxOh3d1pfcWRB5Lbm0NzngTnZ6efbkhlk8U90=;
        b=nP2z5U7u9VQKAxDdUzGmBXTTN/+9lkMndcPDBMxjPKFv7+Wzs6JxUs2Qr5WYBlgn5W
         Z5SJeugGlLvEIuKHEVWw39hmP0l9J9beFso5S97DsO2xG3HV2fcbjlBe7+kPzh7Snst6
         F8Uqs+Hb5ApGpOET5iUWFx9DP9eZRMpH2Utd1P+B2p2pT5kdJexdI6Z0MiTQg7Txc+uq
         yvv5FJ7UH88Gq4DiMZpj1wBA0W6xnG0dyih/J+b4eT5UClquuTUw81RwlHL7HkEsNKIM
         WvnfcRAWth85nQsLvJUv7tNsUcZnB15iqDd1F1sEtOg2RYP0UZCgMB7f+gCL+wZaca8u
         dmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534593; x=1789139393;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H0QwtWyxOh3d1pfcWRB5Lbm0NzngTnZ6efbkhlk8U90=;
        b=Cr13uXD/w6gktVd0vBTY6HfYz5SpV7Re8xp/AKVLpBxzoK4NA1l8lUoebk8N5l5k0q
         Y0G9ar3YI1EfZuHtJvG11XoVKmSBWdrBaAvpLMxC2/TF05HCeRxfpFJIo8ozwmPLntTB
         5RU1bEdSIwUkj8kqAT8GnJL5AzOG/uxCIcVBPZHgAw/ASyQALPFYZxUdXCWtmycCTMzm
         yTZLaGWudXPrGmltvoLqnd4xQ8u6ckHMFuimRP0ZUGFZXCz7r5hbw8BGMBXObngf3ygL
         LQ5iIwv+aNncYLlno5eh/uGhSkv0yY7i6k7NxvebLxjXzVatuetY1DFbUJ6rp3DACWTt
         UnHg==
X-Forwarded-Encrypted: i=1; AKwUvByp0FdR3wgJ3A2dg8tUrtOIA165h+pNt6EDVE3Ou1Ki/tpqIqA1y63yW6Z/2CVyCgkk9aE=@vger.kernel.org
X-Gm-Message-State: AFuF++lJOD/1ZzlDClz/WXCVHhUYrD+wOC58NpylcK7aqVYCVFySCRA1
	iBiDQf6QF3if211sl+iQv4ce/khu7nUr+4+Y22mUxy0fIScixgGgUacL
X-Gm-Gg: AYBFou1aQexwZjK4ugdMhMx+W6PA0nypyJF29ywUyZEBt+Y1hD6/izYL8KmO8xi8RR8
	++MQ4sxobJ44Sf+op8q14wgEQqfluua1Slwqam68KWgLEdX7dnkgK4gGzRbK1xftelUzLUTX3wS
	pK/zkBT9T/VZ9xXaJRGtXlJx0EvOp/ktIEm/krBHroJ1eZpYH1c/aHwmJVbFnGwRfnIFkwysNFW
	8WG67iirlo1oAM/i16vZYP4iUoymPh8olPS3URXx2wLsHL3pnlmFrx0uP5Ps4uOKRH/cm4NXcB9
	DA4uI6Gv3e+KJr+Vp1EBlyXMrlXtimGN1aZOz/wgYXx6OwzxAS1ya1rK1HnFwVTYHPsg2HcczQB
	qps/gfkhiIzfXpRf4N9ddSPEc60ryiTf5h/VS6PxT1SmFnp+i8q3u/J6ErMj/aofDDVAoTXe4Uo
	UCkzUtDd9Kdxcwzv6owtwV55slKzz5YrpaxUNxmMwE1MlygVefAtGZsZl4S+ADr0CTrAI1X/oUD
	HfXzVgpemv+6lNXKAmfMcx2ytvJ1YQPekP3y5ucOiI=
X-Received: by 2002:a05:6512:224c:b0:5b6:425:4bef with SMTP id 2adb3069b0e04-5b61706a350mr1964527e87.32.1788534592746;
        Fri, 04 Sep 2026 08:09:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6166f6c98sm585054e87.37.2026.09.04.08.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:09:52 -0700 (PDT)
Message-ID: <99b6da14-e03a-472b-b7a3-81162dc74166@gmail.com>
Date: Fri, 4 Sep 2026 16:09:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/2] stash: reserve exit status 1 for conflicts
To: Harald Nordgren <haraldnordgren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
 <pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com>
 <ff4322180294c784bcd5f4e92b35e4b334324ddc.1788373743.git.gitgitgadget@gmail.com>
 <xmqqwlt3h1oc.fsf@gitster.g> <002b1324-0f7f-45ec-9f67-624a41801ff7@gmail.com>
 <CAHwyqnVp6BVGx3+UCqBC_gOCuyq1c62uNi1f7Wyfpxd1KdyM9A@mail.gmail.com>
 <xmqqqzjab2ho.fsf@gitster.g>
 <CAHwyqnW8sdnDcncpZpaMD8fmWaj+WJQxhA4G-Y+L5PTW=h3k6Q@mail.gmail.com>
 <xmqqwlt29l01.fsf@gitster.g>
 <CAHwyqnU2c3T_i0gvkqiPPM7UYr8t5bzynr66iG4Z6YUKqZk1Cg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnU2c3T_i0gvkqiPPM7UYr8t5bzynr66iG4Z6YUKqZk1Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Cc'd Karthik for a view on the CI style job]

On 04/09/2026 09:16, Harald Nordgren wrote:
>> A local "make style" while you develop runs
>>
>>          git clang-format --style file --diff --extensions c,h
>>
>> which tells the command to check only the parts of the system that
>> you touched.
>>
>> I do not think it is used in CI.
> 
> It seems to run as part of CI and doesn't catch it then:
> '.github/workflows/check-style.yml'

My recollection is that we made that job never fail because clang-format 
does not always do a good job of following our style guide and the 
output is not guaranteed to be stable across different versions. That 
makes its value debatable as I don't think many people (anyone?) bother 
checking the output to see what suggestions it made. It would be a lot 
simpler for contributors if we just devolved style decisions to 
clang-format so no one had to think about or comment on the style. 
Whether that tradeoff is worth it depends on how far the output of 
clang-format deviates from our preferred style.

Thanks

Phillip

