Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975799;
	b=mbGqaJphF5eTW5qqlItqLoJmuqEf6bZsIvKdAiXe0bea0jOm7J+t+ZwXMMtGjNGkmLVJ
	 oFc9QGYmzkr3Uvb7Oyk29yZyHPUqt1tXaDYQ1Lvb5EtPmmCLCRJViFF7UKM5Cd/QUyhLZ
	 r56GLEzDcui5zVQlewouTr6Z6uPTSaqnWib+U6z8b9FX7LyXNDOLVFIT9O0D27JoCLn+2
	 rLqx2Np9nIX9Wu6SGct9Au63EE4HckQRSzwVKkqzPKk+R1Tog/kJuie5kZ7VLpUTkKdl9
	 aV5Tv5kLNjE3VIEKn94uVfzse4CO6rF+aCD+m0v+11fePKxMWS/ZJJOohFNHyQw7Y1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Bhj8vw7RASgIekVIKLa9upALsmg2j0H9ikSn1icBRI4=;
	b=sWQ96NOW0CJR9oamrkqDv3DnjaPASpmIbjW4A/60Mf1tEX82xKX967wLgLL+hBVSNdq1
	 7xKx4Y+4zC+0nkV2RW8l8GybYboJMYO6UnC/8xINFtgt8lMsUDywubtgbmWyhs/qFdxFN
	 +QG79KjOC9lQFOykV8VUdelfzOkFXYxdyar1ImZAM4anN5Rr9tpuxYg5xcOjat0cubT6N
	 GxL/D7z0U8lLwCaF5TMnJNI8jaDFvFSNiRFaqKPKVpeZ+iFdhxWQ8aJpDIc3dCeVfXc1r
	 XyPQIU/e0z//Q5JbYJ6+z8K40MM9IMxgjuvy8airgIajZ6vBW7Fvp0vR3Zcnciqs2tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Exoe0T7u;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74150606A32D
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 14:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74150606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Exoe0T7u
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91c847584b8so7717766d6.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 06:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793975798; x=1794580598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bhj8vw7RASgIekVIKLa9upALsmg2j0H9ikSn1icBRI4=;
        b=Exoe0T7uoZuiYDb6Y9PpKLdthm+38pr2dKJC1zj6Olt0D1rQAFGFLmrV9WsU/UPrjh
         7KOd7FHAz8bjB19qyPbPGK0TVvcjww9GJDqMoqAKG/1l87Un8WaFh4R556azWuIw39Qk
         6qrUMhpjN51z8xIWmlGQa5c16DeQU+4i4qa9GJ8IXTGHeNEnWX/sJ4FWaDRqN2itBeAH
         HxmN/8Hw2PopysioGzdVXWY4cqeSBLRSW16dxBaPd9i5yQ0SiY2jQjo3ELJGffHiQrSD
         FqNqVFVkjZ0vBz1Ze2LGxBb7WQwqOrbQiv4gbRhgAduTkJQyeOOKqwPeW7eN9oglL18H
         zwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793975798; x=1794580598;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bhj8vw7RASgIekVIKLa9upALsmg2j0H9ikSn1icBRI4=;
        b=vr/+Ckh7pJOoBB7dIp2hDpxnroad4f9Nw/bmA0ZyPRTW2sqWHo/qztNVx8kkOVOFxy
         hy3EF958u0GqRQJpDWSKV/f2F9FHANn456+1p6+jHMe+CA2KTMZiiHw9TRpVRNCoOtc9
         X2Z92nn+N5Bt6O04Ost0dYnmOUmT8SKHNcKTp+LaPc/jrFQq9yjs+zHqVqdcv9YEp24L
         XmZOKhdOpUDQ+5XBsIgzIDXpli54qQKbNeAevSNVUNjOU5etEnAQSU9l0JzQGiveWfmu
         mlU2UdMYyqjO8MF5eUgswzQQzPtBY1fKCAQAFGbLU5d8wSlDbW9Qko83pyoUI8nJyk9T
         /0hg==
X-Forwarded-Encrypted: i=1; AKwUvBw9cG1if1QA18ahCViP2iPu3ofxrKqhYIgCfZzo6D/SnJ/og/q7eVDflowMi7xogtohU3M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CgSJSjuyWmHbav0/yn4DTs6aajG+3N53Cp5keDqQjyNTcbKOR
	4D0PEG0b73AhE5Q2pyhvdGHexcWXgof3bk63y37v+Ykfw+yz8Rt7iQYy
X-Gm-Gg: AYBFou1HmtV7VB/WB+S30ayPdRvtqjLPiuCXtMoIYdpAjXb4wsfdO/jaP3eJy+TOz7C
	IMFB1Nd0jjc1RJ/HKI+XgS/Aoca1yjJAA11GKT8797LRizSafKyN54BZ6FwBa+NWwiMUDW8DEVe
	cofTR9pddP35GRWOOWKbd2GHes/Ti6aWwCbRt+0L3tonTaVf89NxFuzILyCkQZoZLUzvLV1mYz+
	ZC1PZdv8TEGm6KEU/HCjVPtWBEdSkhQhijkHg3O9rgqerDZPpDr/uNc95UEs89H0xXD8mvU6pox
	nVgoJz+9hh2gMVXkfIn1QSywfibtstzpRTonjrvzKkLxEr20GQys9fooeGJEFfkp1jo1BRwpHt+
	uGJCU9+3EOKSb9c4CH9gGz7/w5KulPAwYhOMviuxnGTOpMu0dBlEuYLeqm9TI87xy9JxILTGbHA
	avAHQQY2OF1nmT3bpyAudCGG8a4+wE4cyyHzgWmk6HpAC/nfhbOlXK9+aT5CHLw/jpVTkyF1nEf
	YvqEH67wC08JhdBobUCRSQHg6T3kwKj/Nx3rHOg0zzgCMABI+swcSHTq2A34d92/DcDCVfze9Oc
	Dl/Mbhw74RycEu00bZD+kSeQoj+/SRju9RTCvVUKQNAcnMUCZisLOq4/fH3XNSy4kfr5NdBsWJE
	ENfiaQS/ylqDWwTrjdaCWq94sEgv+nOlSbu7HFu1GRVirZ1/W754iCk+lb4uSM1h98wnjZpmsbA
	swYzeT1XD7ZO1P6ltInJv47b+HweWzAfdDWMAkgavig7Wx2gOBf0know/ssVK/qfoNB3hYo+bGE
	pA=
X-Received: by 2002:a0c:f40d:0:b0:91e:9e46:c152 with SMTP id 6a1803df08f44-91ea9620ea5mr34756896d6.6.1793975798231;
        Fri, 06 Nov 2026 06:36:38 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a64fe4sm21933136d6.21.2026.11.06.06.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 06:36:37 -0800 (PST)
Message-ID: <aa2063a2-3fab-453c-9f88-86861432eede@gmail.com>
Date: Fri, 6 Nov 2026 09:36:37 -0500
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
Subject: Re: [PATCH v3 1/3] remote: add relative_url_gently()
To: Aniket Gupta <aniketgupta3001@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
References: <20261105152842.566318-1-aniketgupta3001@gmail.com>
 <20261105152842.566318-2-aniketgupta3001@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20261105152842.566318-2-aniketgupta3001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/2026 10:28 AM, Aniket Gupta wrote:
> relative_url() calls die() when there are more "../" components in the
> URL than the base URL can absorb. A caller that would rather carry on
> has no way to do so.

I agree that we should have a mechanism to allow users to know about a
broken bundle URI and to respond somehow. 
> Add relative_url_gently(), which returns NULL and adds the reason to a
> strbuf instead of dying. relative_url() is now a thin wrapper around
> it that continues to die, so existing callers behave the same.

This method is good to have, in general, and is written well.

The only question here is if we should be changing the behavior for
bundle-URI clones from halting on bad data to skipping bundles and
doing the full operation from the remote.

(But there's more about this in patch 3, so I'll defer until then.)

Thanks,
-Stolee

