Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EFD1E1A3D
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792336160; cv=none; b=F/2K9iZaULTUEeyOVtrLMdnZJIGhV/bV3FDrrkhOLVf30+SrU2DG6r0sZRBmIPSBfHAQLRPMwnQvFfztJax4hfGBkWlq4aZw9kACRgIxD9G6oxt+DUAXk9Hv6i64nj6lROYrIe+KgnRgDxIuLAENRDleXJxApmYsFdAtis+OrOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792336160; c=relaxed/simple;
	bh=SiGR6GEd5R3sCEAGBDlVJx88F5eQxZuvtSxQD8S9KQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJRqAldvFEVOaz4QR6XBMtXB7nI1OPSTv1RvXl3IUlRJLmsIu8/QcXCMKnExhbeRt3/+C1jBkMLXVHlqQYyOqMA0pctGnwc5tLcMwg75t9CYQE9Z9XKiRFDyZlCP9NhDL8pq18wGybuJZLyXFtTUq5hKAFnk8LbABvZD6NlSKrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAJ7jR8d; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAJ7jR8d"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e0d885929so769529f8f.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792336157; x=1792940957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FV0LNwyLxqetLy6Xnu45w4ZUQljlxkUNMmvkdMyDF5Y=;
        b=jAJ7jR8du9rP4NjktwdOYbUy0MgiTvhcpakEYXJpFxdjfYyQgfemmv5xIEl/Az65wq
         5itQcVkXjERIFdbAGwBjMuGPXq/pQvoggcC+/RgXa4FoURmv0VsxhRMl5YCNRtlggggC
         pj/Mgm5iLUwDNl+QEi8lSSDElazgIgBaAZ9ZcXYzSm2TVdkSKqiGjBP+wbYelrviOuDt
         vICw4fHM4IdI69zH5vSB/ZRZyVacqnzTe48vEjNCsqtw/KBU5ngu81vbz2yqjjkEsuh+
         2tRCqRktFHFqt7FIBPv1fN/CjDN9oGxW1c0oZplw7RaNZkIKRSsog0Nr8Lnhg0tOFLnf
         4JcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792336157; x=1792940957;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FV0LNwyLxqetLy6Xnu45w4ZUQljlxkUNMmvkdMyDF5Y=;
        b=ZtFCJkJTBvv+S0uzWJD86vATlripnuK74z4p7RBS2jIQUf3imnd8Nm5bICG8Itpv1l
         mbHnMPGOmxjofGWPSWlZM45NZ66adNDdrS/Etlb1ahVAKkbvyf9dYUOZYUxSGdBjwVC5
         CVUsFHH3xohLUkKkwPa0jhQUAEUGmqIDIF6lxpiVnEWgW+NQNK/3J6qmSaWA2swfrysO
         015AQQfRJu+cDiTTbZCLb0uu5hz6edamyyeKVM4yTQVRzzU4eWS3gxwEH0kffPcUEi7e
         LL+QV30Yjd2Ovjg/sOoJfdCm5+fx4r9Rnd8iDaaE3L6C7KSKGp1GU01QI862u7va3hPo
         T49Q==
X-Gm-Message-State: AFq9FYIUfxuG0pgtVgLxSq/wUBCU4SO6iGV+SpKm2YlvipElwOFC/CxR
	1emM7zuKf5l7Qs4coDDSbfwi+WQD8hi42TeLAFo51RCDdREzHksdFU1G
X-Gm-Gg: AYBFou0G83f843sZ3fhywGC2+olV8JuEB9+C6lKwPsemC01qlsWuPtsiMBJAqVjLMCK
	YWgqxu6fX0EgIFB8h5SIFaL0WVFIJRR2Q9ZFan6iQVMNzSLj3meDvluQEWpRKt00DgRPeVZszn+
	ptDnbtICBc1STwYZPvI7wcx31rDeUS6yehxfIR1HkC4wC0OJoPHiyfSumReASRyfH0Nt52sSRR4
	+t+VRq/EHp+670VTiTogkRIaHj1HwdMbsxDMxcIezax/d1at9ueLuaVFyN8f57QJSmn68Ul5oo0
	D85PMbARR4BGae953Al4eMgeqoQzUDDo2fGo63Gy5UVgvs95krLZrhnNcYRNeGsMblHciMCTOr6
	RgnrDXpBk4l6tbo12hByw1eR35UcX6y9AgdUHt36owJfjTGlok+cvfKIje6BNFvqnJ2R9xHeU+2
	gnzPUBmri9Z26qeThN6fpzu062vW1Fau6ZPQRSL3f69Gk52TkpUhJQIlXlA0+G+L0JvQSzj3cCm
	p0+/0qnt9y4gMT3E/GONhne08uwqpTUrHC7thvv0bEpH64ba1DA
X-Received: by 2002:a05:600c:1394:b0:4a1:7bd4:d07d with SMTP id 5b1f17b1804b1-4a1d7628895mr110673245e9.34.1792336157187;
        Sun, 18 Oct 2026 08:09:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8af2fcesm225260765e9.8.2026.10.18.08.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 08:09:16 -0700 (PDT)
Message-ID: <e7719810-0e47-4031-a35a-9e1fd5727be4@gmail.com>
Date: Sun, 18 Oct 2026 16:09:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy][PATCH v3] builtin/var: refactor to use parse-options
 API
To: kerylefondji7@gmail.com
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
 siddharthasthana31@gmail.com
References: <20261018145222.579-1-kerylefondji7@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20261018145222.579-1-kerylefondji7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keryle

On 18/10/2026 15:52, kerylefondji7@gmail.com wrote:
> From: Keryle Fondji <kerylefondji7@gmail.com>
> 
> Hi Phillip,
> 
> Thank you very much for reviewing my patch and for pointing this out!
 > I didn't realize that `git var` had already been converted.>
> I am new to open source and to this ecosystem, so I am still getting
 > familiar with how everything works. Could you please advise on where I
 > can find a list of available microprojects or files to work on, to
 > make sure I don't pick something that is already done?
There are suggestions for microprojects at [1] and some additional 
guidance at [2]. The test conversions are a good way to get familiar 
with our test suite. To check you're not working on the same thing as 
someone else you should scan the mailing list archives [3] and/or see 
what is in the "seen" branch. In many ways the main point of a 
microproject is to get candidates familiar with sending patches to the 
mailing list and interacting with reviewers. You've shown that you 
understand how to send patches, respond to comments and ask for help 
even if this particular patch (which looked very sensible) did not end 
up being merged.

Thanks

Phillip

[1] https://git.github.io/SoC-2026-Microprojects/
[2] https://git.github.io/General-Microproject-Information/
[3] https://lore.kernel.org/git

> Thank you again for your guidance and patience.
> 
> Best regards,
> Keryle

