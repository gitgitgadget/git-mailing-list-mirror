Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445691;
	b=syEXHvTtuCbriFzjHBLOfh8hYfLuJVqlv4rQXvKskrFAxYNWSPAJxWm0U0W1g3Lzb9q6
	 QRUx6fk9xDWPmHrSP7Upm7R+Q9tRKckha3zi8pZd1y3wXuTohkB/kaQUlDR0AqYwf+29/
	 o2ZwlFTt/YEe64Mctaa7G84V8TSHnoo3El1AMVBazFxCqxX3wbu4J6cUn1WaxBkDHOSfa
	 ijlpxaJDzwHHK9sN9LPXANYSiTdIAzvnmy1zjeSi3Rq3JCkLaGn8AucwQGNTgUcPUydmC
	 TDSkadT1m3YDSV3Br/6VfEZ5OEKhbizZWmweQuSAjUKhEqvWNJXZqUdKGWT06K0FDLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1ZGQeiGotUDrjOiRTj3DL8RDMOKUDh0qOFQkyB7eqfk=;
	b=uaaz7DpD9whMGjyWmb13wtNt3iZ4l9cSTJcBXPLSktSGxC/zRpIzybW6RpOmgFkvK9SU
	 dHNgkWIgIu/+UZYjTmXTTduknNbHbx34u4wgiHRkrAZ2oiMmyhU1iJ02m3h0m80DjmOGd
	 lX8lixWaqQLNJOmXvYFDdg1mO+0onZuDKpep/fm6pfm4+cJQRgIOAlPsj01eRP3350Wex
	 tiPgQl9ysehGIJHSIHdSUVBitl6Fz9koredAolFdIt0WQzZJ/9ls6aNh3DTqFLb4XwNUF
	 j1VcN88SPcekhEGm/hh4w29ldwG7Zm79gzxF/yHeTmhGPJ01cwAYwTdWtrMBVbOFqVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v0PilYTo;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D813606B43A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 14:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D813606B43A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v0PilYTo
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f269e335eso427603885a.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 06:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795445690; x=1796050490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ZGQeiGotUDrjOiRTj3DL8RDMOKUDh0qOFQkyB7eqfk=;
        b=v0PilYTonExjfk7S+VIAvTa+k1jLfrUMm3DxpWyEuVltVyjFT1Tj/Dc+M7RNOyIwAF
         DhUIi2A0hBqnM3bd2SptsoT7MKMtoGWt4GNXZtWyCrihEsGYYExC7zTMmrIQL0F4lIZh
         joxm3lkgH9P2BbgiUHyLPdOvHMN/6yoZig8wO+cYv0j2YpAkYtUkDpINLz7KIH/DqUFM
         b1hkBGM6yvr/iUyS52jjCeId86uf3liGMFfPPijuUP7nNj6KG3ZJT1v0iRr+tJmLhWex
         t/BdBLEP+qKRLjun5rXk30Ea5x3s0nfVrSHKgo/a6WeVAoslNoMPPpZPVSzQy7m1M7/+
         zu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445690; x=1796050490;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ZGQeiGotUDrjOiRTj3DL8RDMOKUDh0qOFQkyB7eqfk=;
        b=Hk3fWgyIzBo4bb4eO2eMOsNkaTVnkz3n2gQ/6hrsunnQlBnaGNJ7WBqNOJug6iqPNh
         oHLwytCyKLgB0BcCvGCS4NV8S+zqBPk1hYBGf5omT6PFcEaGfKW6mAvbrfzUXlUWCk6n
         DqRu3f1/MUzNeBL4aB2NEEE7HbMaQHz5xrXaIocWK101O5agpUlsNwD4NSdK+eMdqKA1
         RmuCx56i1NBMNIqcb52STVOTuR1GHcvHpLHTHBNXMgwi5I2eYDPDj16Sfuao0DgXsAVO
         cIoVaiTypol9Q71kHpijV6+qaBFrCPHfVqDkQAi6Mj3Xw6HGE4eT1DlGVGMevEcUSf+z
         dgrQ==
X-Forwarded-Encrypted: i=1; AL+hErEi3EFef2JF0SbPu6WuWiV39yzg/kNLD+715RklZ08mu0tLFmcB0EP8wece8LT3tGExvs4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wjGOGF3PGQwgcIq90Xa/SC7BRzwNf3ERgPzjWxFkWzoCRGjWk
	WxBhaswl6pB8pXJuAEivCJ/t1jPBvXSNp3PHxOrnlXkc+bzRKghZBwvb
X-Gm-Gg: AZFdTZcMmFNpBUKa4dhAgcXiiE2FA6dqlhL2Ep9yK+cJyuKPU90/x5ZPxAJUUpmKrck
	XoH0xfwyanlYjFUtDueod7yLHUMoJR9LEiZupVc7X3NJ9Q65biQGFHbnXMHXv0t2qDHbABmHX3w
	7mgPFpW+aXPNVRkPyCOIwpUt7nf3w2l3JnSSZnG7lGGo7s6fyp1VI82OHscJCSx8+v1SClfmTSc
	dHgO0ya75zy6LjqrLw3YSG4cVxDuyVQoHN6ch7BAyNip1sbTqQxRDTvy2tepg7wS3X1wcQ1UChR
	RjNyI9E5ijOD+S4B9cb+bOGRmIKUYyKIdoGO8g4eN9JEpthZfcw4GUk/bgjZ11Vwq9TewieWoLN
	HIMOFPJ+HS3u06eVop0Nq1oc5/4ihCS1iSBVgx/w7acg09oKQq8D07ZenGZoa4u7CeiUdAS5z8F
	tbcAD8N8LjDXwo7AMZbYVoKOIqGZsQ56YHnzx12mVx0I9wML09hLaCCbqKxFaCWpiReHahfIoi2
	+Iyy4AGG033SgwLQ68p9Ggsic4js9v1gg+xyxAbiiuARIfY9cWEmYkmW4y73Xbr0nyj2VKvXSt2
	Q+kLDLd+t1iw79yu0JGutSiTDdfEOnZ0NajrOSKiUYL5xZY2xc1zzBaCbioF5WcE2qzv1rJ3y8f
	8sOycfSWd//VFgpd4SxcXUd7S/OX8fptYvzdrHunOtGkXc2qTs5B0topwwDH7gbNt7jkf0d8ay8
	oOn+FA0LGks8Iimux7/NNBO+KSm8JAM+c21EuxqQITWtj8md+TsyhuFE8=
X-Received: by 2002:a05:620a:2548:b0:93f:35a7:cd4 with SMTP id af79cd13be357-949bab3c74bmr1908832085a.67.1795445689862;
        Mon, 23 Nov 2026 06:54:49 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3ba04bsm834047185a.24.2026.11.23.06.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 06:54:49 -0800 (PST)
Message-ID: <41ffffc0-9d77-40aa-a15d-edf7925936b2@gmail.com>
Date: Mon, 23 Nov 2026 09:54:48 -0500
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
Subject: Re: [PATCH v4 0/3] bundle-uri: do not die on unresolvable relative
 URIs
To: Aniket Gupta <aniketgupta3001@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
References: <20261105152842.566318-1-aniketgupta3001@gmail.com>
 <cover.1795415793.git.aniketgupta3001@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <cover.1795415793.git.aniketgupta3001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/2026 1:44 AM, Aniket Gupta wrote:
> A bundle list can contain a relative URI that cannot be resolved and
> one such entry can result in the entire clone dying. This series lets
> the bundle code report it and the clone carry on.
> 
> Changes since v3:
> 
>  * Patch 2: dropped the part that hides credentials as Stolee was not
>    convinced it is needed. The part that names the URL that was passed
>    in stays, as Patrick wanted. The patch has a new title and its test
>    no longer uses a password.
> 
>  * Patch 3: fixed the commit message. Previously it said that the
>    clone carries on with the other bundles. That is true only for a
>    list that a server advertises only for the bundles before the bad
>    entry. A list given to --bundle-uri is rejected as a whole. In both
>    cases, the clone fetches the rest from the remote. No code change.
> 
>  * Rebased onto current master, no conflicts.

Thanks. This version LGTM.

> Stolee's idea of having a toggle to bring back the die() is not part
> of this series. Happy to take that as a follow-up :)

I agree it doesn't need to be added here.

Thanks,
-Stolee

