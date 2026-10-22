Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792676751;
	b=sCYHNB531yLZqXBhJiLL4ksooML4dzTsa6NhnIaoVtGytoUphTV4CVaFq7llgJPOFlXx
	 m+Cjf4X0S/FFTs8SlguK60xj32ItgflKx9s4M/Jgny8ndJ4BgtTFJUcS2ANFlZM1NLIPB
	 J5DFJ4uAzUNj/HRJnAb8auF4hP+vuuCvxKCEgvsrb3f0kZJoURRL8ltAzL4DrGFZZnxyC
	 SxW8EzUpdmosKI4Jo6RdWYWGWpbuFUUzLy0yUdmj0HE+f93OxluZhxUudKEmfH/8WiuuQ
	 jbqZK1QNHh0AVU3LlAyo2A46qbEXdMiOlaQmP/dIHayywNFa2sm2jlN+1e9tNEZNSHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=6seDJ+CGbANw27JhQXKP3UY/ko3Kh9VnaYgzFw7MXpE=;
	b=4Bjj7qXkGuptJ9JWG3HQtVKQchL2Ogum1lylfQsXmORjUsfb6RW8HbjHJJxtK69Jy9gF
	 4D4xriiXq+qX53QuKY5/XkAFaewDNyLMoNgEcnbp5HzfWpdT+KtypFjQ5wSWTZrmkUS+9
	 c6BczIWJ3+WWOvfErtG5auh3dvHBw1S/7KZA6InWaaBVeLgQ1v8jm8Z5Kj/SAjC4uDYMe
	 3g4mx9PMuPntAWsTtVLWbYnIWR+jlstFHI3ObZFPaLA5KtHwQXxlMJ1L8LkyiWn7D044x
	 o0ctba+RLMQnu/Yn08Vhb2q1Nr+kD/XC+XI4e6db22bhn3ONkmI+0kJZqRQSAUD3ikw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TBEXUNcE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C0F60A6F53
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 13:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11C0F60A6F53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TBEXUNcE
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7ccb2ffe333so275161137.2
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 06:45:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792676750; cv=none;
        d=google.com; s=arc-20260327;
        b=ohWu4NAfI++IkQ4HMoMXgDZL+ZrU0+UqhoU7QPJx0oimlFLa/RGq4BrCOoRfseTaUM
         bNdaYftHxfrd/XPzIx5ni3bGOUc/91jddr9st+us+uRHvf2RElq7kpndRFC5Hqv9aJG4
         hR569f3UWjBabye7YsQMDND2lQriodqCuTPsQePPd8A6uacMa5GTFSreDZLjggLMbF5b
         qLhOIbJkORjQVGV0j3OwES/AIb9OnklGFBYjWqs0BM0X7sKSHKAY5p/+F8UXDMuzFnwN
         lLe/vJm3hf8sEMivRwKAbGxDpQBAsyRdb7RiP6hE1SuJvXFV3t9/arHA8+z110kvVWpJ
         dIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6seDJ+CGbANw27JhQXKP3UY/ko3Kh9VnaYgzFw7MXpE=;
        fh=/j+vG27rf687elonHcL0kgOXGizcEL1Ld9TZlUvLLDs=;
        b=fprIZBYidNZHJvVztuzUcMxensci9HXg2l3pUggElm5K4/Qwvg2nEdUH/Gmn/otcbf
         2zxz2hBFg4far3H6JT1jBFodPT1lY1+QBhtJ2oLDOKbDU7bYKXOmvi7FE970hhCDuXe3
         3uQrowciqO2Al9F91uFew1tcPAAje4P3vw1Xwdb3sf1KXrauSvoTtzbf+iL/E89PDJz0
         bfRX5+0b9FwvEsbOX7539pOarN8ZLGqTLEQ+z+TLtrYAHPKH8KZsUXaKG0VbXROcniFP
         rjGPzb+as2fq3Qy1nhfdHQTnjJJ/yHK5cmNxxuLX2iefcgRL9+0lq7FGenetxoXWd/Jy
         UHHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792676750; x=1793281550; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6seDJ+CGbANw27JhQXKP3UY/ko3Kh9VnaYgzFw7MXpE=;
        b=TBEXUNcEyyF6ya9jI6gu7pczoen+uNY8SnPrZGok676Wsx7humR7UDG5Ug3i0Rl//P
         OiFZKLKwbaaSTXQUCCI28ky0zWRKtFSmJMH/FAQpmvSTENgInPDTbBf1RVW9+TnCrAY1
         uEWeyg+49bAugRO5wFrxWmwcMwSO94X3Rns9pnaKcufBXURRu6aU74Ao507omdrlwf3r
         W7faLd7/fK/8dEFFx85xWxIlCyGPJNluU/agf0ksMCMA0bKrd5YayHGmLohU0SbdiDoo
         /QBj08HrK08rJ57ZzvvRec4ena/FfIRqTSpXOlW8JNEyh+p5XdCPQpMFNlXyUh81dlYI
         g3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676750; x=1793281550;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6seDJ+CGbANw27JhQXKP3UY/ko3Kh9VnaYgzFw7MXpE=;
        b=nYB6ka53knubmHrLFqmK4ZwkZVr6wycE3xdYWckGavSfWz2F7HbEGXS5PXeJAScR4B
         S2NrHm2KMPnVqOPLg9/8phdkcriRtYWuFkmebht/3rraJhjZpBQzzM6fU8Z58bpYrV5r
         cqQrbIvBXCD5+rF3oFlEDLRzVmtrw9oMNry5c69vVX6bYVa6ak6wQRvTYO2Qukp3tR/o
         0WDClN4OVBHrdl7hAwnKfNCgu22027kM1db1JJJ84bGpcXE01v9Lxs2eLiMcp8Ji86Gt
         /ttreWyknmejzJFbHCLo/xVWQVIgVSMAW+q8zoVZZTxGyc4Td6kAhajHBPUQrdFEfTtU
         +iTA==
X-Gm-Message-State: AFq9FYIvyVQWNCpm8CT6ev5X13SiXsDdzQfzh0e4Vd1ToigFH/3qDCMA
	Q99JokF7LWbS66p5S8E3DU9B/wkgwecyBiIvv2LoQfLW/R9/gsrCS2dnngLVQuyo8LWSXqtC4TN
	sFM3nalMpsnqmKv5DK35v/OpO53AYcTg=
X-Gm-Gg: AYBFou04GImcFTfaahAAmxW1M9hqZ4SdwsXMpsBVUFxTZcYw4Yg0F8SNzSxdkf4leH+
	SBFM1g9JAshj3dXK1WxjlADg4L/8KZQuY78BNZgExgc6/6kywo1SdXIaScAvleVRaYvWpkQs213
	PoJBoDVVq56eWRiT4SzyKc8Qe2bMLmP2nnuILK+YASF04zgWZdQLaPj7ID00+ZFwapR2P5eh7g8
	3lORgxudlJrJz0nKNgFrHBmxUm3vJKERsR5y04hCWJz1Rl+sM08iNcr9DvKa2SJM4chwidcJn32
	vXA2clPuGTZTtl1gTEIAAU8HQYwe86X6tpEXf53eyC9V23krUDnoEXYazN071JZbo9Mi4hTry/2
	PT/ZV704JnF+LIvvQiDZY0G5yvDFQ9QoBDQ9kjO1biRoXtaN500LkYtHIWX480TA+zK2vOYo=
X-Received: by 2002:a05:6102:5489:b0:7c3:e156:da3c with SMTP id
 ada2fe7eead31-7cc926634bdmr2242462137.15.1792676749953; Thu, 22 Oct 2026
 06:45:49 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021151253.3689-1-azuama69@gmail.com> <20261021172458.6373-1-azuama69@gmail.com>
In-Reply-To: <20261021172458.6373-1-azuama69@gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Thu, 22 Oct 2026 19:15:38 +0530
X-Gm-Features: AclHuK8h7ne2Akm9R0xQP9Bt-SEaS_13Su8koIM5yDPseEbT-AxB4RNZbjJTx20
Message-ID: <CALE2CrQuHhP6_p+9iG2SdZn8=V-Oy9oTtBu8xKd7FUyig4zBFg@mail.gmail.com>
Subject: Re: [PATCH v2] rev-list: skip --grep argument in early scan
To: Azuama Odinaka Maximus <azuama69@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Azuma,

>
> Skip the argument to --grep so that it is not interpreted as an
> option during the early scan.
> ---

Can you add a "Changes in v2" section after the --- here, summarizing
what changed from the previous version?
Also, I noticed the "Signed-off-by" line is missing in v2. Could you
add it back?

Other than that, it looks good to me.

- Pushkar
