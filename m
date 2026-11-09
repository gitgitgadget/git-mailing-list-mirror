Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232007;
	b=3z8r0EfBgMjQJuTht97l+4s0mVdg7wgdAOTwOnHWQbBe6AB56vCpf4YP6gfUYwIlo4Un
	 luCj3IcM2zSgzfbl7m5aCgppWN4pZyoIRWcvAERqDQMo5a7MK03o8sMr2q8rWVwSUvCTr
	 K6GWebcDA6A4wcbUaRmN+BwROqoDb5i58n5F2kY6d9W4i2SgSTU9X1geoC5XNtuATUU5N
	 +bfOvzCE3SYoSGIriiZ7ixXL3zN0z5T5lzZmQLtWN5/mj0n2HPHpm+WHDa5s15NhOXuli
	 ltJ6j1CxzEvq7hGm4+6qclW9PumsSkNYBouMUn9Hf67xjLGJfP3bMrSQQswhYNtne0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=XiK6REatTBfoD50yWXvuux2xaBDtt7uwWqSCvjoa6AY=;
	b=2Fj0ayZhy6vnEausNTCpBS1WPv+zzL7w0lR1Bri/GYIFMAmwhK0OF4sKX/qh2jEWLwQs
	 QYhT42EkZ8VwhzY4XCuUnBWdStp5995C4j9hSApR5mDYQuz4RSmpLl6WVKDa7H8WJVxU9
	 3lWMqvdLZTRurWijyazW/OXHSJccpiN3ZJk6bRuZrAb/I9x66Mta+dKYAwqE14unoY7lv
	 q+Eg8mjF9qwij8Wrf+Cb49H8V6Rov+a4+wCSnDNSc/ZTzAsEKodbIlICaYGzr14G18R04
	 0zPYDNkDI1myUrSwUPLq/kJzKVof1bqE6DKWQVPtdkZsbJiiiCVGdA2wVCHrQ05s1kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RBtok7XB;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883A7606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 13:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 883A7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RBtok7XB
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-930c0f9c1b1so83040485a.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 05:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794232006; x=1794836806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XiK6REatTBfoD50yWXvuux2xaBDtt7uwWqSCvjoa6AY=;
        b=RBtok7XBZ0bZS31KTScVLAf4vRIuC54enJ+Z+FxqErY2aV8plrPrXPrk8/bTGXMmff
         JcLSi1D2Byi3uT4zIGx7CQTtV22BpaJNk77ciBiBS9vDDE4jUG3QwI+vsvYAWQ6cFCfi
         Gl0jJeJRL5EAiHSv7FHOUWFBha8T0Jgp7oXvVCSFV3cbPnzYD1TpANyKV8KK+MMwVRlC
         kXl6fUmRqVu8R7YlCF1ISs9ibZmYeYRDiXLQwETCoCV3TuV0PnwY7LdrEHdXU40slQ/q
         vfsfM3NXjm2I89oI4K+bdTs3xuoywDLqWkoiUGyaqhRo3OkTOD1OuZcYpY/e5eAvMVzi
         jnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232006; x=1794836806;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XiK6REatTBfoD50yWXvuux2xaBDtt7uwWqSCvjoa6AY=;
        b=dBL+AfZfp+qJGR1Twdp4fTwqCy+T12wj0mVtglVzZhoxlzyrX36UeZWz/GXIRVX+bX
         /Xg5KTtkhDYu+gXyJWauBPUAPq7EMzAolBJi2jyN4C8laJFQhJTV5EzTOiQtS1Aq/m/x
         sdM6HKxWgmNRT4akN8LEM9hacvtPdlwkP3ZEAYr4l4RSMiuRaq0dKnYWuKimEHOgvwU+
         m4mBzgXBEhP7yTUKrnT79DEXozdH1pmWFHIe4w+bAomlCAktu4dOfs2Vf16YSAOcxCO2
         mPPRZB+nkoSTwxm5TWNXRbLuStAQSxddDd0b0l2Xxsa3pJlBxu6/gEwFV4MPVIGlv3d3
         yu0Q==
X-Forwarded-Encrypted: i=1; AL+hErHZbDvC6JUDmVbzMlBg8x4rNY05Cl6B8b6umMk8q0/AtLHqsX2YCjiK/Y+zlzQudAVJYYM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VX25QGALeMlf1AZleYVFvd5lPIbl6dgqssLhR37yEAkgrs8YL
	dGlU0o9/SoLyAxUM2gpiIVsbLfncSCjRa3P3VsQf3X7B435n0Vy/a/e6
X-Gm-Gg: AYBFou2PJFhKkksVaK0bZKB+zDHxicr1pwdv1YYHZgGcrDE+H8k67x+jo63f+/zT1Up
	V/m3S5QSAXDEY3BlxYgC7Gb2NOdSoh1ENV0EQu2DZ5Ll/xbmAeWz1MnLVFdaTACYyIbFVMQB1P1
	CDzF8/KCHYvxcmLzn4HaijzMZEF1cL3P5JXZ71FFbzco0u9qnUCG/Z+T3QMhPX834YHMXXNVX56
	uN3m3jNtq6l5VvDoiUE1h24ycwASDPDnDZSRQ9dYVrf0nv7kofWdFrii7x7CrZI2Xwa83wqygaK
	oLk9D93YSxuvAP7WBLjMgBIPJbAr0DlJJoNa9bAFFdqQqVAiLO9dN6iDkSAXVEW7G+2sAJ1K7uO
	/X+RkSqn1XnKTJbhqFHhXKeJ74uEgCO++C8a0Dg2l8ZTIr6Ds9IyZhDGl7DKTzGMGYFJXh7P2Dj
	f79C9t+kzvOCV8EBBByfGK4W0BuzfZAqi4Bav0UdHyAh7vavpA+lY0C7peaPV79LdvrEQXE5Iee
	cmFRjx7sOuEgpMQHWKP50bAr1qOfH6t8MPOg3C6x4ahouInHLrTihexwRKB13HYMA+PAZSGMJW0
	qa8ogiPquCkv+wOMiYec0h1xIwOU3MPtWgZbje8ncggUyC5pFYdwMnjsv+09mQPAHM8DfPYkqK4
	wLtoyoXohy8eT+JkT3IGvl4paXthsZgqQ17H0v/uJwPCiAld8SiEvSMxIMnI6Lwr6mkRPsis2fh
	L76sS/KwiEPcFHxb7Cs7dw5xKAYrEeXLiSirn2o+afPLj7Sr834I68fA==
X-Received: by 2002:a05:620a:2686:b0:93f:5ac:14a0 with SMTP id af79cd13be357-947848f1c3amr584844185a.67.1794232006404;
        Mon, 09 Nov 2026 05:46:46 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91eceb57303sm42732986d6.4.2026.11.09.05.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 05:46:45 -0800 (PST)
Message-ID: <b3004724-3ed6-4b41-8b3f-eaa19a09394d@gmail.com>
Date: Mon, 9 Nov 2026 08:46:45 -0500
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
Subject: Re: [PATCH 2/2] unpack-trees: consistently use "struct index_state
 *istate"
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqtsltbfdv.fsf@gitster.g> <xmqqpkwhbfa1.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqpkwhbfa1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/2026 8:29 PM, Junio C Hamano wrote:
> There are some functions that call it index.  Make them consistent.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * This change is not necessary for functioning of anything, but
>    while writing the previous patch, the inconsistency was
>    irritating enough.
I agree that making this consistent will help a lot when mutating
the code in the future. Doing this cleanup next to the_repository
cleanup makes sense.

Thanks,
-Stolee

