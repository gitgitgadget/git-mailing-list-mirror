Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977064;
	b=ccU1i6Ikn0p2k8tjQXwBZybMQFxi0r7xqZYgkBUPotpkx6cdhq+bXb4E7zcmQcgBN5TZ
	 +iPqpACRUamQjTQb1xrjTPUhJWcteZg6PtRZpqmT12ZCXrgo5RYVQwDQ3QHZtnHqv1FII
	 Dy5gfCeN8+lCzpmd1AHD2hWYMUjJpTTGVARHbRqBbp5bIMVQhi1/iVYUdOt3ZEny4K8+m
	 x8jlUUHJo2m0xQkdBc4HjCDw1BeJFeYMKtaSKuRax9QfHmbWs9v1i1pS4Oyf1mFVaG6lI
	 rRTiouRKiP0+xiq8Hf2X1dbYlRIsYM1xPzxycpYdXfSuW+J5dlAw7iP/0zfnSpPXN5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YBetL2534tKF92D90YkWH/dPxgbVXaA1RZt0MV8U7T4=;
	b=45UzQnVeubj9OT+2cfisnmDIZa7KCANtiyDGkY5w6ChRvYyFuCsePlPAsi0PipdTcr7c
	 oAG1W46AKep/M9nWrTsDJCvl8iZmLuFjwWyMfMEfC6LhxGFu4tGFNQJlVpybdrJB3lcQD
	 flVQFfshWrSicR0LQief3jjHHBaRqOS5D4sIuoD9XzzB4gB5gkMKHZSezqAz3xJ5eOssQ
	 i6J+/7yhd1WO2yLODcUS2Y8oKIuqay0VmFyubHmZGpkw/y1yj7keuRmIFWWSrLABC9ugd
	 fBuAO/sAoeQ9tuqkX16oIGun3qTsWmI3FUhBiumAkLoNP0TiOzXw5fbSjnjGaMvcVvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hl8Blnyw;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8451B606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 14:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8451B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hl8Blnyw
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-535179e995bso7176231cf.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 06:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793977063; x=1794581863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBetL2534tKF92D90YkWH/dPxgbVXaA1RZt0MV8U7T4=;
        b=hl8BlnywwovA3/EB8JmS/sRmuHw7BYoVrRYpn0UIIxMFJKUmdBiwBecXthPnNGKscB
         OkFgNJSVETGo6N9w1ss9Bb0YF6mhB6r8N3W1cCz+Yx56tabJCNdlNFoTKFJO8sPG39+S
         QxI+OxiG6caNkbRDjTNrPHxplffSK7AiRc5G0UF9rj9x7U51k02wx3iuKuY62E18E5e4
         hP89KFBuc+IdfNaDIvgW/bdxRtAe1Q0/FdOvSYOY+XAdVH5Ofq64YUANbeZ98fmzXahy
         VyzOTqJN4y4B6I8R2VCoklH77nTZpvrNIR/t0CoaTgpX/m13Qp2AdBkYawr46ne7qlaH
         i2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977063; x=1794581863;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YBetL2534tKF92D90YkWH/dPxgbVXaA1RZt0MV8U7T4=;
        b=CSsLAp9/FNe5K8+fQ64kufVY23VnqRYGP8rF/btboPQf3YayfhGce4xxSFuUugD3es
         kcqGYEKV8E2TfRmPNCJPfIZthSySTArN+teC//q2PdYsild8V/NtlU4yq+J25YxpNhYm
         MCOWlP9Y432+QKcCwvRH7p3yWk5Sx0P5pIfGzB/GtaYOf38oXfu/1x1RPiPN7TDZKM+6
         QodBJsO84NquW0ZZn3l5rPDX2k5IgHqTI+ZCgBJaHqt6sO+SJHXX14SVK/go/znhPoYL
         vu+43NKZbB/UZo5LD4TcVBFxxqLfbxLKkKgdBuNLY6smh0ImcE9IzBZvYrLTQG/ZdDk3
         pEvg==
X-Forwarded-Encrypted: i=1; AKwUvBwxkbyDD6dbaIHJeGhdwOIgL5pSIvi3zZnDfDPS8vk/GxkPUi4hNfdVnA3QkTNEMwLQaNY=@vger.kernel.org
X-Gm-Message-State: APuU4Z87pdP/gJlkpClgj8dUD4zTNoXGA5+V4RY7HgpiE4W3gCOIIbS4
	H5IuUMtYPEwuYbyZWASKZ1Twt/mbgnh3WDbrpgnkzpq18Dc5w1+IK7KxUloEaQ==
X-Gm-Gg: AYBFou3PFDWTDNEBE/b826WMr3psWYHbpEOVPuu2s5iYFq7bNg6w3D2cb6eGOZULBdL
	12RITIq8jVB7RhWe6v3k1DIDoZbaexFTrOLlRro54fdN8vAhIjsH7Ns1cGNFhqwIezFSf0J+3wC
	TPRjXb6WkAUDQhNF1kpsyZIlgRdYnKcfG3AG4L9AYCeOGgOeZx2/4Rq+SxEY/5Q7DLxrVLwdi8b
	GaW3jFUzO9rx49iRnoSGta4on5pQgAMIKd5qaxCxCXaq8CfVADWvN2y53drboYZp/AFNIUM4TCV
	q3SrUCWVnGB4K5LpCfoAofKB0AiaSdu+ClsPKLs8v+rG2dHcNz27rZfSf37tf+bl2yKVScz325u
	hUbG59ssNIRfW8Q4TYlfLmjI16tgLRTpKXl+MReRYpQCznY+tJZOOY8645tCYc1zmjq0i6SxZOH
	ZGh4fkP4YNKEpg6nkT6942Id2wHJDpRGdDigiK7xFKRiA6mkxZfh/NdMYrZgy7k1rfJWCDJ3iw+
	pQNxaM3Om86Ueejp0N5fZqlMR5rXxevv7/erS30+Dc10ogIrS1FYLmOobbzOeYIsdRXtQcxANPb
	FhNdhUYJxq9OVFwaJ77ETI86hejyD58u9iSZVOCF71ELym6Y8St/kyDovvrYgIsligDlpj6PuTv
	rFlhz//lj7YQY2W0qP75ySQxiP4e/Dl243Ud6/qUQT7QpJQkQBcZ158iulvTwi+X7EnqSIv2Aba
	uMq8JcQoxctHaY/mt0KoocG4Ue0i7RY0jgDAlc3y76LLgBERiQfUEcuRJRTSBDdGfIsTZUMxASQ
	w==
X-Received: by 2002:a05:622a:1c19:b0:535:2e9:e474 with SMTP id d75a77b69052e-54e0ffe4eb1mr40805251cf.4.1793977063334;
        Fri, 06 Nov 2026 06:57:43 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e26835bf8sm22023601cf.19.2026.11.06.06.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 06:57:42 -0800 (PST)
Message-ID: <25a32212-4906-467b-9b1b-301b38ca0e2d@gmail.com>
Date: Fri, 6 Nov 2026 09:57:41 -0500
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
Subject: Re: [PATCH v3 0/3] bundle-uri: do not die on unresolvable relative
 URIs
To: Aniket Gupta <aniketgupta3001@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
References: <20261105152842.566318-1-aniketgupta3001@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20261105152842.566318-1-aniketgupta3001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/2026 10:28 AM, Aniket Gupta wrote:
> A bundle list can contain a relative URI that cannot be resolved, and
> today one such entry makes the whole clone die. This series lets the
> bundle code report it and skip that bundle instead.

When reading patch-by-patch, I initially was concerned about the
behavior change. However, patch 3 removes a long-standing TODO
comment _that I wrote_ so I'm inclined to take the change. I
didn't see anything critical to change about these patches.

That said, we may have something for #leftoverbits:

How could we create a toggle to re-enable the die() if desired?

Perhaps a user _wants_ to fail on bad URIs instead of spending
time on an incomplete bundle advertisement and expensive fetch
from the remote.

Such an option could be a follow-up, now that you've implemented
the _gently() version and the bundle URI machinery could decide
for itself whether this is a hard failure or not.

Thanks,
-Stolee

