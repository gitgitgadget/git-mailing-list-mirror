Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BE73D47C2
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 03:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782791015; cv=none; b=Fbki9kx9Ozk3M0xmwMz/lcAerWvag1E0wvrsHTl5UliU7To21NwLQAg/3T6MOmllGNkg4Elbh833XPqv2HicvPSoklj5UkxNxwb4OvfWHjvGHha6UB6qTipf7OgyOebv9fwpP0inEGyzTRowtNF65WBeF8VcZZZJuLSI9xRd3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782791015; c=relaxed/simple;
	bh=3NBIurCMQyEg1GkRxA+RM5dL2L3TgrgIPgEVswp5yDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5ipyUskohUAKpe00Fqo9VF+mupME1ideF1Oe8b1pRHcPAeqs5opQkdO7rWO2MADEI3DA0pUVl4i+hgEEAkPYA0vh18f7Ro7/zYhnCW8PGBzNZJue3BkPeM6Xa48DFdWoPth1ok5ohzWgePBcBrjJYADi2JZ9QeB5OA32aUSBbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkhlAmnF; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkhlAmnF"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30bc871ecdfso5324498eec.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 20:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782791013; x=1783395813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CUFS0yR0KL/44BYza/idBdjcKmEylzIlfiJhJKi/Qso=;
        b=OkhlAmnF7LfrS/9hz82676SXR+AwKjXtNLAgts2n3m0biYZq816cgi3LYHBmgs2/Gk
         1txrZVh+MlH1/qMot6wv/5dXic7HYncKJ+egcWEQhQ/xqXahiQNTNAMsyukcaVHxvaiU
         y1bAzwwIkC7QxuScvOsStnWW7WJ1jVcJF36uJJpVjI7XaZOxzppMNVEqe6MgYrPvAM6G
         w0nT2Sn02PSLyoEE9vUI0HTAjb76pcGtqATtwvAQVwgwuFwvs3yCM9TTihqQ2WAvgrmr
         6mJrnehDuO+poQiUC141FmoxzywppyyAOjUbu3oPJHS/N6vk1zfA/wL6usGpCbfZth9S
         wQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782791013; x=1783395813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUFS0yR0KL/44BYza/idBdjcKmEylzIlfiJhJKi/Qso=;
        b=O7GC8qjFNVqetJXPvKysfYnjIh2vPukb1n8Ez4CpRlcRUta9BnZYuXmffsSoCuX5UB
         mkFHLYSYpB5iitZUcU6UWZyAdB8n0Hxa/5fl44blHCIVRfeOcLiWTY1jB2QaDr5vqIs9
         YjCrtV+ZLvNJkId9age9F+IL0KDFMAnn+brpRU7Vp81xFAtQjq2zWoralXmLpedTgTkB
         lqyJDakW3iGVmnTiQdxgmpJkx4GfqNGPlFp+AbrWh/qQKiRg4ySXnemFN9PV3a3Sb7kC
         VPUnk+/vo5j7anERkw3hgXicmHKGAaJpPUbYwlgkuv9FYvJdEgxhJh+4r4LOcbdLSBY/
         rd0w==
X-Gm-Message-State: AOJu0YwuS1adrO+vVYiVGEAO5buM4DefLaO9P8gwoZhedBHkEkph2cTL
	Fdv1ANJ/GFbrU2qJ2QSF1Z9/uKxWEumh2nTohfhcijSyRYrPMgR6GJ4IrtFGwA==
X-Gm-Gg: AfdE7ckxlmJP9Ve5fQHyRfhNZjxtrvAxU2l2BgS6S1+cmJ3GP1ybcgOW6G8Aa4hzlVN
	RRR9xfefroahJt8/45QyltOMPRR/tDjHyg6vjzcTM+aaSGsP7BgGZekFUhYW9IJq5MnaYn+1F/g
	P08YTVhBD0QIKzB88Utjtf39VUyUSR/QsgQZcINt/rB+Fxw56QdMO8nA4K5VkNeDJ3rwoktFAzp
	+hFHTSDuy6gGONOSfn4WAk0lvoZPFONCGi1ZIX7PKDwZ69qOo/V9C/Wxkpj6LXSFOH61C8CKTBd
	REeDV4ANQUWSwgCcxxGkRJTN4jmnTI0c8sTDUQeEH0R5U5sATNHLDUeEzxUSgoNBaE7QNY0rc3D
	km+lzFtK1/S4/sfvnHuwvo+fMEo6l3i5oo3I+q8drwmafl+YOvIfL8U0GWAcvecjDxHvfxMvj48
	kGaqHWX4Ctm4VbpIaLoOV8UHHXDKv2EgF70Xl1DoHrDqJuGE9ehl/aELnB16wr4fX5dE8SKzV0j
	M0Ee4qe
X-Received: by 2002:a05:693c:2d98:b0:30c:55f2:1e32 with SMTP id 5a478bee46e88-30ee12f0fa8mr1322456eec.6.1782791013165;
        Mon, 29 Jun 2026 20:43:33 -0700 (PDT)
Received: from ?IPV6:2401:4900:9159:2e5d:6f5a:66cc:9f0b:a7a? ([2401:4900:9159:2e5d:6f5a:66cc:9f0b:a7a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee3205796sm3345882eec.23.2026.06.29.20.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 20:43:32 -0700 (PDT)
Message-ID: <94b0bed5-c86a-4291-b958-52f09faebd29@gmail.com>
Date: Tue, 30 Jun 2026 09:13:28 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin/history: unuse the commit buffer after use
To: Patrick Steinhardt <ps@pks.im>
Cc: Git mailing list <git@vger.kernel.org>
References: <20260614141600.620272-1-kaartic.sivaraam@gmail.com>
 <ai_KWo9o1Fhc6OFs@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <ai_KWo9o1Fhc6OFs@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Patrick,

On 15/06/26 15:18, Patrick Steinhardt wrote:
> Huh, curious. That seems to hint that we're missing test coverage for
> this specific scenario, as our test suite doesn't detect this leak.
>

Indeed. The tricky thing is (as mentioned in another thread), this is 
happening only when we get a commit not cached in the commit slab. Once 
we get an idea on how certain commits get cached in the commit slab 
while others don't, we can write a test case that would catch this leak.

> 
> So this doesn't really read specific at all, and I would have expected
> us to hit this leak. Puzzling.
>

Yeah. My bad with the commit message. The leak is not happening always. 
That is a reason we may not have caught this in the test suite.

>> I must mention that I also noticed the following comment in `commit_tree_ext`:
>>
>> »       /* We retain authorship of the original commit. */
>> »       original_message = repo_logmsg_reencode(repo, commit_with_message, NULL, NULL);
>>
>> ... but I'm not quite sure why we don't unuse the buffer after its purpose is
>> done. Kindly englighten me in case I missed something.
> 
> Did you maybe confuse "authorship" with "ownership" while reading the
> comment? The comment only mentions that we retain the original "Author"
> commit metadata, it doesn't refer to ownership of the underlying
> objects.
>

Got it. Thank you for the correction!

--
Sivaraam

PS: Sorry about the delay in response. Was stuck with some personal work.

