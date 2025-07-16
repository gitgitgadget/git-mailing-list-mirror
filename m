Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C51264F96
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676203; cv=none; b=Sc4Am3Ojdwxhs+zLyTvi4dWgcfECqX8kL+INq10lIHnZDxsgVSvk4GL1neqBu9CQH7QaX3+pibWE0IKau32YGWZ6/gU3Joe1oBN7yQE1axIFPAJw9+Kh3k41Bth+8NN26vrh9w4sAVZ59qVVL+znRagE/wzdM7UVgUjZcl8KlJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676203; c=relaxed/simple;
	bh=tl+eVl0Ecq9Ql2p/jbVsk/rNqQxIdqnyyuoGLva0QGk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=psx1kZz2SzFowovwNmnGh6F4ufz03Tql/X+zIh3btwWEcFCk9QjAdJh8w/NAY4Pac1pI3f89GYRCQTYJd0KbIf1M8DIFGgmXjzPNmu89KS7uHBBPvBnmFsSzYp+UMMjtFywsv2o9u1HvcyX1Mlu0XtFyTkpLKUN3RmG0pHNoTxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cronAAjp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cronAAjp"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4561ed868b5so24263185e9.0
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 07:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752676200; x=1753281000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Liw2Sffq+jMmD+hlt9c2HbCA02Vsn/CfCzaOoXVCcps=;
        b=cronAAjpTlIQI+9l4ai/LtG2tdXeXPrCbXj0v818dsnbjb78j60uX2usnDz/2izZX5
         0XBDWbcaPVM6A4ytMFFW6D3XmHJS64dtelqdTWLFJnwjPNOnhn3n4ouFKnTsF9xutjky
         AeSj7dEvJ+wCO0HObF7EUK/UnKm+d94EBFsyzbvl8DJ2rpvVE+dxb8rf/JwdyNxAS8pZ
         gnRNBrT0C+7ot+ZIvNWvtLBxikGdUxVlY6Xg9HNloR5cKfmccOglbenh0A05ncSA9rsD
         I5ovGDM6YJnQmGPW7OpN8TaZSQKB1dg1/xKjdZkCoUz0eL+jNerjhcJB1WrwPHIiPYM9
         0QKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676200; x=1753281000;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Liw2Sffq+jMmD+hlt9c2HbCA02Vsn/CfCzaOoXVCcps=;
        b=EYBF4M2ir0l4uBuBekMpACdKXQjhI0xXvD0vmY8hlp3j6gIuk+/EVnCKAFrL2zrzAO
         dBZyI07bVxdIeSZZg6iLzt+7EKbTUdgWIHs71d1y76ycnD0rYP1TcQhS71Dl+X8Ta7Vz
         xOOnIE9Rjo0HQ9cDHSGXowvc4jbaixOLov36pXgTeND7rkeDgvz4Q4udM2l6e8r0lZYV
         cUeMFkWhjev6c+BMuYM2iHLRMaSfq3XUXenm3dmKwgRMQJn4CWf7bsm6uUTBE7PFG16X
         ygt2pk2GtlgzUKVRTwpa0UqJJiK8wmHNvNTddDhNRkBOvC9XSyb1sya+swPs/jXH5yqC
         RZlQ==
X-Gm-Message-State: AOJu0YweRNaF8wDqf5qqj0W3jbBO5oo8uWNKzQzI6jFDP60asgTlwtWb
	oABJEZe6VfO/jvuEw2sscAGCUx8+2O0k6bfbh4yYeVFMzUSwrMRRmp2p
X-Gm-Gg: ASbGnctAU3/s7QW5Hl3d19xHTg7t2AtX0T9QxEBAUPiDhXSElPD7eQ6RKfsFRBWhSFO
	GgYJ5xNNceurxFyjbdZmr+pIuos+u+9ukPnkUazqZdSf/a79hx8n6ouNBWjvEE2hiPsd00foF/0
	JFX/p8EeJRsHT/GL1PAaXRQniiBdb5Xhoqc9BGxpQGrQlpqfNX5VAanJ0Uf6uul5kIksulSvH7n
	S06UqZ5ypU8/Dfj3lYiqLagQStMiiJIBeH1FYO5ZmhrkHWBXAUULBDnn8VYoEINkFfsZg38dZzt
	YLKoCbTpfqziA4KW2V9gLCkkn6LBJN8CAkmv1frJX6pK0OiLfkm4LHvDR8+kW7Dr6niaYOAyFXv
	jyrdlOcsDV/Bck9K87zjL0rOo+bquSw/MJTVZRHIEzEdy6aOVG3xt/2MeL55G9tcU9Y04pT9Q4M
	o2O3YNUeOQoqI=
X-Google-Smtp-Source: AGHT+IFxB5u11IjtR+NZN27M5kv0t9pSz5he6uubyQAaNY+gFr4VQTqx6Bpq0pZPH8hOJsiOXO4KCw==
X-Received: by 2002:a05:600c:1c9a:b0:456:2bd9:5126 with SMTP id 5b1f17b1804b1-45631b2fb3dmr18275205e9.16.1752676199744;
        Wed, 16 Jul 2025 07:29:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e802ae4sm22682965e9.13.2025.07.16.07.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:29:59 -0700 (PDT)
Message-ID: <ecca4252-1c29-4661-a454-a4cedc28bead@gmail.com>
Date: Wed, 16 Jul 2025 15:29:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] strbuf: add compound literal test balloon
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <7ac55a5096c261b706f47ca239c381f71db2b67a.1752499653.git.phillip.wood@dunelm.org.uk>
 <xmqqa556x2z4.fsf@gitster.g> <aHYXJ7EmRQE1P5xe@pks.im>
 <xmqqqzyhifrr.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqqzyhifrr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/07/2025 17:24, Junio C Hamano wrote:
> 
> That sounds good.  I was wondering if it is easier to keep track of
> things to add a new section to the CodingGuildlines document,
> perhaps like this?

That's a good idea

Thanks

Phillip

>   Documentation/CodingGuidelines | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
> index 6350949f2e..dd3dbb9c57 100644
> --- c/Documentation/CodingGuidelines
> +++ w/Documentation/CodingGuidelines
> @@ -298,6 +298,14 @@ For C programs:
>      . since late 2021 with 44ba10d6, we have had variables declared in
>        the for loop "for (int i = 0; i < 10; i++)".
>   
> +   C99 features we have test balloons for:
> +
> +   . since late 2024 with v2.48.0-rc0~20, we have test balloons for
> +     compound literal syntax, e.g., (struct foo){ .member = value };
> +     our hope is that no platforms we care about have trouble using
> +     them, and officially adopt its wider use in mid 2026.  Do not add
> +     more use of the syntax until that happens.
> +
>      New C99 features that we cannot use yet:
>   
>      . %z and %zu as a printf() argument for a size_t (the %z being for

