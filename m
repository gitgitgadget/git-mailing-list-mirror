Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706050;
	b=BkwRhzOy1UCeCYkz/IotNBruVP3Ovxc3kdRE4JwGMTsTn64h8Qn3cESVD+AXT4lF6MhL
	 5wEQ6ylNn/GraJ0zq/HvGDBaVuLkUl9XVisL+j9jdwgrQkWXdcK7BP0eisU1Y/KRHZnbR
	 iNsiwzAcR4el4nIPRlIjIIz2lX8bMCeTiEjD8mLoV1Kqw71o55erjZsH3lVu0BNrupw7n
	 Q+c3NeJ+sOyCA41zCBrZb6dsq69jBu9tjKciNzzHAXoazGsbkCBvGY8fCB671qP0a3wh6
	 s1XloJj/OFkiygFmsSQR++c85jYpZD23U07XThoXM1LQghktXKSkH6cW9gn7qvsrOQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=alJmzUhNvNxQUwaA9PNv3u2FZzQFMRVn0Zt9o0V2YcE=;
	b=q9AueTH5LUjAVSz01dVBjYotZ2H/jJcDnm7X1insiRTqChoEEraqtVgHY+nrviLyy+XZ
	 7/UexXzWyVtisBiNEID2gOI4Te/CMvb8r/QmbE2BxgnVHCYhEYlJrVt4f3dC1hqdnE92m
	 X8EVuNqL0yj88QUbXQFamn6n3oJg+Yz6C8gDzidEityifGV73/6ygMF8sfKu60xypcEiS
	 qeI/flyVGVxp3MsI8CTUFpbUJ5q1cQfYkQAxzQzMC9XhnL7CE/31mCqLbf0MxDrt1IhNb
	 JHF/IEZAUfT34eJZT60mhTHw4eEoSjMA5l2Rw2hnah/PkX8fLYF3sZQ8xxKYCNgv18Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BU3B1yKe;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C18A606A327
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 15:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C18A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BU3B1yKe
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so4219184f8f.3
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 07:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795706048; x=1796310848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=alJmzUhNvNxQUwaA9PNv3u2FZzQFMRVn0Zt9o0V2YcE=;
        b=BU3B1yKeOVW5hD6mguUcWO+vXypIkx6JMNRzdxmGz/1ZmE6W8w9/OV7eaCG9CDDiLa
         GzgFE8lbC2zN89DQa/gPbCR1s1D2JqUzRhL5rHNvebnOT0eIZ095HfZPMk/9D5LtQgag
         xkuRCR6MjI4uRZ5MYEgBf1odxNlb8EToPyTlheGtdTHm9cp2bwL2Gm9XrIG+f1zlKQRB
         exgSgG9wxbYLQvWXCB2sWiZxHuyl0RblKdtw/tJpHF1tCPopWpFAp6Loob6ICIIpS8Er
         jUAmAFyl99At/srQasOHXcT1jgO5HNgkyuEv77svLqUwqSW/g8JETE20tTjrNTLb3qxi
         9nhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795706048; x=1796310848;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=alJmzUhNvNxQUwaA9PNv3u2FZzQFMRVn0Zt9o0V2YcE=;
        b=0iNkebsMWP+03Zo1gMdpAPI+9vItttwTcXx5ast7SKN34Cn5K2QzOXMPHg+P3nlPhe
         9uWV1mK4s4N4DYOAzajGHN8PxUaUxUeC2Cvx4piHL/pwsLV6XysrY5+epeA2VsZCE0jZ
         aNYCczsKbArs8Ryw9ep/eq69idebLiC8Yq/Bz6XnbuA00mUyDmb4s3DpP+7n67Pu7itZ
         gZWyxKIuAX0Vq714B8nOTCkfyrBdyYfCQT/4fgGfKtcfrKlIFpCWaypIQW9YqqLzE7KF
         KkBQpdAywSMpJbTpBKPImUV+mFa5to9qW4UFfvs2Rv62FCoj2eIo78K3fhINSAT/8ffL
         nigA==
X-Gm-Message-State: APuU4Z9MRk0XCv739I5Y2j1XCvDF7H5xr9nSpO9IZDYjlZtxhLDBw1Up
	I0rRWf0L/XlVrlk6hXH0X49dpW2EfVX/+Qpd9/ZErVKgmF/T5rUbUetG
X-Gm-Gg: AZFdTZfFBOm6uE9ORZEv0K0af/nXTvEMSSZxbE7TgPvXs2LApjTc4wno9p+t74Z9UQb
	XNyVT7HgDzGEEnW5AvVrmVpi2JL5IApLGecBntqexm60qTSa73RW69dZQuJSNaNRI01cZzba0bs
	FvbCUlrcjWrUYJQuXAkfKTS7PRr3VuPaTWD7rDSXbezUzIZTwNhEJ9zlPbTOcSKXDtM08yil5o9
	OrquY2CYkvs62t6iydjbbGY87XdInImgTCtpnvC0EIC7uj1BvpS1SAEodyCgiiCrhQcQXT7I+7p
	YzhLMEC7q2FNhJcsRIqxsltRuKb2xQ0Pm++OiwSj4C0UteFxZhS3VqT1bAjNoQFt9ySfK4tDIER
	tmunxCZzXaKDeV+JQpmI5i4VXGFfjNZAYYVCk/uiw/GXVjLKgdElQfNldA3YEUbMOjUOb3tnSK5
	CKSWCezpQIC10JlAUsYuxQzJnKeYwFBwVoo2SHFm6o1dg95kVaBUiq4+5tjMThRbE6PlGh6S2O0
	s2EB4fSIsXaV8OMFHKIcc/IxYu3koJziYe4MSV3V/mZSUHBYtzocAhWVs6kef2yCjEkc2EGLI92
	888rxX91DGn78X0VkqhAgiymiRVysar2rhcLJ2TALB1Vbola7T7ytg2tz3ujTNAvia04Btmjow+
	8ZUnKDugR3R/qD9eqCbThI7qLOEtV
X-Received: by 2002:a05:6000:41c9:b0:48d:fdd0:6ce8 with SMTP id ffacd0b85a97d-4abaab633bcmr41204240f8f.3.1795706048320;
        Thu, 26 Nov 2026 07:14:08 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b205443sm43387545f8f.39.2026.11.26.07.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 07:14:07 -0800 (PST)
Message-ID: <88b50b11-6eb1-47a0-b5d6-9183d977e871@gmail.com>
Date: Thu, 26 Nov 2026 15:14:03 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/5] wrapper: avoid byte-count overflow in
 write_in_full()
To: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Harald Nordgren <haraldnordgren@gmail.com>,
 Simon Richter <Simon.Richter@hogyros.de>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
 <pull.2253.v3.git.1795640149.gitgitgadget@gmail.com>
 <f38c7e71337632f2e86ef5716e90c776c491b762.1795640149.git.gitgitgadget@gmail.com>
 <xmqq33sowk11.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq33sowk11.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/11/2026 23:47, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> Accumulating the output count in `write_in_full()` can overflow because
>> it counts via a `ssize_t` variable which can overflow for valid `size_t`
>> sizes passed as input.
>>
>> Since this function either completes the requested count or fails,
>> callers already know how many bytes were written on success. Let's just
>> return status instead, so the total transfer size need not fit in
>> `ssize_t`.
> 
> This is a great simplification.

Yes, it's a much nicer api

> I didn't check what is *not* touched by the patch, trusting your LLM did
> the heavylifting for you ;-).
When I reviewed the last round, I grepped for '= *write_in_full' and 
'return write_in_full'. This round fixes all the issues I found with that.

Thanks

Phillip
