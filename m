Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011475;
	b=0JSYxn1Dk2SHMDThUzW0c9YelmC8g44BOszoU45bVF0XxjDu/7sbBV1ph78lgYPXeHFF
	 eN7VqFme0kBs5seXqp0nZwbaL/tWF0x5/FDgqG43zTpUH6focCjt4mfFMhJ7g5AS009cs
	 20qPAHRs3SdNldNPtzSWQ2RVfTL0R1lx6RDnfUP41gyMO/V3sC0BAkEU8QNpFJGt6nI0o
	 yJITu950FkvmojNiWPave0SlY4vtEwX3SdUkb6gTD5cX8xHqilfmns4O+0koaE9znm8UA
	 zIqcQNJ+KYCL7xbTYJutFliDD9nAfU63a3sPum7n7PYllWFXjJiNJkPP5x9GQjp/ryA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WWVXQ17Wzd1SjDMfbXUr0sPe3f2+prK9Obcyh2nSqOw=;
	b=CGGnOEDJTFMidY03G+8+QQYfOpYB8gvjz4mwgYcjyZLkUWWlWXeqcM+IPFEdiBEzuBhK
	 gdhbDk+utbWwwHlqWEPm9iMI4x7ATjqB6a8muCfpxjA7O30WVI9eS9rDWwHpUvf7YeH3y
	 2nEBpLx+QWSYzQ8qDYbd2hmV4y0g3urqvgNg6fPNKYLCfAe9B2JhO4mhFX5XA2uVwSho9
	 sG3MjY4fPmyBeh8qSAMFi0WBEuwTr+Ha5/YHVk37Cstp0SU7ctKp8PlYSVqdS4G4gCCeA
	 RKyEuw26IGjCncEBsXBmUYX1wbSaJNblcyzOMZp8cdXV6WaGOdH8oylrDVJjvEOJumA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WZg1A+Ak;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3FE606A31D
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 10:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B3FE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WZg1A+Ak
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso17894025e9.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 03:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793011474; x=1793616274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WWVXQ17Wzd1SjDMfbXUr0sPe3f2+prK9Obcyh2nSqOw=;
        b=WZg1A+Akgb9vnNQ04st815R4++tltFJJg4e4si95l/SPWmL2m8ndE0hIiyyo06WKBM
         Dt9aOdQfL8n5dsy2Lwwcz3DEzdyAz07Da1W2tDFZKPc1+MfDMcsPXxD8rvHCCZsIROs5
         /QbO8mhde32xkr32i+mBCU3xIFUeFNSMaslFhBUrEN30nP4m0qhqYtAI/dOLPgfwd7i/
         FOhrTr7nqE+J/ylx/wK4Av9/jsIn5SXpI+eOshcwpnIPcqwD+0gLOhCSEGVTpNGZREDZ
         +QHbFZ+t/+bs76bo8maUoRd35YOJIukE2ZBSC8iQ9s/xR5GR/XeiOJPWmQ1B73hzc3SY
         9DPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011474; x=1793616274;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WWVXQ17Wzd1SjDMfbXUr0sPe3f2+prK9Obcyh2nSqOw=;
        b=aBjgWcHiAFdbnT3H33uOp6uoUq8w0XmHpGnNbDgqqB/3gFOFxlAjXFcN+nF2WIhxyE
         xMugbkSSVxb0s3xJJ7HtHISgJCoeXSnpVfBJHDO6OtXOw7/M/mIh2f0RKFgmczRLpHnK
         Z0cPE5hCE+C2VynmU3futV4xXQ/aEcZ8+mOOc9OUnU3nbeXVmOTwM79fo2wW9U1uj6JU
         Or3nzL1iDmyqn+9UDEGchLALV8g2IS/8oCBCtMoEGefX5izi8pDWjQLH32ZW5AnfWhCi
         4tQaSKlmGlHjMmkscChWNN5rCLJwp0SQ2po25ucKP+ROt+VcDRxdTcxudmf9VWtbgzq2
         MlPg==
X-Forwarded-Encrypted: i=1; AKwUvBwYFFdKeim8d81VDEjYqM8bmRrCQAFo8r9RMYwjXfP5Mmnugd8YOfVqgLpWce8H41B4IVw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKcwpIwIUmQnG4PoOea9IZj9AEMVTh/zp++Nu0s18V1g0NOu7g
	oSM1s1FakqAsiL4qiVPgUL90VZpHZYSH3GuNZ7eWbuER3ye0uAhQJDlWCIiwiw==
X-Gm-Gg: AYBFou2fr0e+d80kTm5/66e/ydvy8RECw4X/H0mGiCmHKk/FKoaoddvghcEl6yRENOG
	R8rBUvFL7pvjnwOJ4bNCfaRIDbjamB6s/O07cIjS+VfSAbLmfmE2Xxb9THvCOMzKPDMcU5EKgeQ
	vzuItOOcYzZZ9S4T/2opiShMTbNw79/cbkMlnx9qA18IjahaLo3gCEvgovgO67llDg16PUMd9Xm
	UcUHik/C3gluds7Ntiv7uLxbvTPZg0hMbJNK0OzHAGhzEQ0ZwgMDHgpuEhtt7n7pxVgKpC22aFo
	+sUhnCvxjAxyPE7jfoC1z73ZitdyPiKraeJMlISzjeoTyoxwBwEopWLE/D2P4BG1kKlAIVpO+7w
	WUBfVKHRXNmbvQigbMwWbGx6w4SVEQNT2s5FFu+pNAQgj64/yr+7aRaKD55gfzREJPnI8/R03Jq
	wxxtm8swN7jAJsIOx+1qFZJw8cuIQjmkk2dkWOfkQpGiI6N7EOv1yGLj99QBKy9puLeDlX12Os/
	Ab5VUYyvSC9DOpjE9dsEpKaUdK/C/ymPpDtS1jsbCks4NuvNO+EGdmzG61HTWWpHE4hR9BEYa9E
	DhiPcKGgvVPhraAKqcoKXbLfjMgXC7mSyQ==
X-Received: by 2002:a05:600c:a306:b0:4a4:fc8c:cfd9 with SMTP id 5b1f17b1804b1-4a4fc8cd1edmr64261075e9.25.1793011473742;
        Mon, 26 Oct 2026 03:44:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a74d7f18a3sm9197415e9.1.2026.10.26.03.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 03:44:33 -0700 (PDT)
Message-ID: <af521f7f-b05a-487e-9972-b8cc2dc02ef7@gmail.com>
Date: Mon, 26 Oct 2026 10:44:31 +0000
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
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
To: Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
 <ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
 <CALnO6CAhUNRMf=KZmY6YbC-5g3h8DE6U40HehGwbcRTPhDasrg@mail.gmail.com>
 <CAHwyqnXWxiF6NLh3e4yGq6_y+=A+-_PwKF7D9DJJDxbk_0vF-g@mail.gmail.com>
 <CALnO6CBAEB8=FfZfde0OWvfLJikVkXQ8itP9wZpGHxfxK+y_LQ@mail.gmail.com>
 <xmqq33ttxw9h.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq33ttxw9h.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/10/2026 22:15, Junio C Hamano wrote:
> 
> I just encountered a case where I wished to configure both refmap
> and fetch at the same time.  From a second remote (let's call it
> "cabal"), store any branch fetched from them in refs/remotes/cabal/
> but I want to fetch only their 'master', 'next' and 'seen'.  I'd
> want to be able to write something like:
> 
> 	[remote "cabal"]
> 		fetch = master next seen
> 		refmap = +refs/heads/*:refs/remotes/cabal/*

That's a coincidence, I sent a message earlier [1] arguing that we 
should have separate config settings for "what to fetch" and "where to 
store it"

Thanks

Phillip

[1] 
https://lore.kernel.org/git/e6af5d1e-4ca1-48a5-8a84-5e0cefbdbc2b@gmail.com
> 
> And, no, this does not require any inferring based on what is
> checked out and what the checked out branch tracks.

