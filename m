Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BE5471436
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461129; cv=none; b=YMsTZncKaRFgs8B+pZQT3wuKz8U1o5glxuafgywfuOteRivDorNyhz4ACY2Kyt3w3LXrzMnjRRcUPwob4GZs4a1ZBETMmompZQejGsR9lf7EPe6CzWkn1vmB7SMngb2hmDTmhrg3dPov39cnUqZ/pIlux20yqHO/DNEsxF2e6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461129; c=relaxed/simple;
	bh=rNwRXk7R7jMi+RwhG/Q2aBafOliGKLhF7joJjyPTSos=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=srf4M6TgcV81DNONLqEBjLZqn2s8hTAUSn9RWTR4yRa67BqknggN8NuuPEc2Km8TrmKuH8SNKljAiFARlGnjkAEed+I8canka/LQEyC9Ukh69l7fCwDwIbG9GtmGWqycdbQDKm2cRIjigDs/lYfa74k5aozcaV1RQk1zRTu0YTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2aRbi5b; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2aRbi5b"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea34ef4so16878a12.3
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 01:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789461127; x=1790065927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hAW02PZiicNsHfxMvoImmNEvvNBe4I0eWM1wXBigiR4=;
        b=I2aRbi5bo1+s2XRL6neUklkUGMshJHGC/rP3NGFcTc32ME9zK33+VsOgNAE1dTwNvG
         OCBB1l5ALh0l6i1gGZZDDx6GS+CvaxZO7mMArIBjzYfBtPG9kaByXQFQifjHwgUQY1mL
         LNgyidHrbTHeoXd2DrSY1kZ9zoJhqh2S7h7iIe4wxAsNLu86iE67dn1A6aKAg+aerXDB
         FHWMesFd2LxCFy04U122PbxDBLCrUz5x2NMDP8TMSv64iXP6r1LvujzNzimRhoip85Cf
         LlCl0begDJxTFAlQ+PtDu1U6F5BO7TWBvUofNof9FY3mLxF9KDtw3R34wwFzej8oJG3k
         Z0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789461127; x=1790065927;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hAW02PZiicNsHfxMvoImmNEvvNBe4I0eWM1wXBigiR4=;
        b=jPS0sToeTK3rMATgzWCzZcD46E6u2squOQPa+K+d+9o4r1ck1kp8a09FWuaLC1uMRI
         Sb9CXF4H+YfWnKuh5izWcy9D7IbgyflF+HHEnwDit1R/igIQi+erMXxlmOmiyFLfG4H3
         4IsiTrfDmOsAPwciKvUHT5gE81NnM6GLHcJ17F3XBhW6YFK+iqkzLyPc71NgQ57BVgVI
         1NMThRRZ9pTxAx1zLCywyni0pzliSn4seX/HvUQQ0Cgd8VqBWe9XKqn9RDuQYv+dd3oN
         Dl9AI89758vYOF/NpOcGM7Tu4XdTxm2O3bbyrcZxaG9UxFdLms7bQHFD6u31h7OIVpw6
         Bv4A==
X-Forwarded-Encrypted: i=1; AKwUvByU2TEVDrX6xIk+NSOLKrQR8HDSNZLMq96gv50+04JdYg00TOaFTmfTY2yuX6W4fKNsU1A=@vger.kernel.org
X-Gm-Message-State: AFuF++lGevFQAo4M7VcjlJ/FloaRb8atDuoi+W1VDk9ak5DrkiYMObJw
	AjGbsv9KM/aS+dp4adOpJ6jDciRhzpwarxQb2wjSEkBcob17mBt6G5jtOat+mnpz
X-Gm-Gg: AYBFou053+IClz3trrGJPFYwXBtE1SoBuPVtOgV64eBOMXqIX/d8hWK+RtYPsANOrtd
	5johNMLq7dx+YSETbbr5BzpxM1DDTFHxe4cGvbEPj6bG9070XwqWGGtS8mdnZVGtgkulS1DQKjr
	lzzvTiLct7v27UpmflhGpddyJwqnd97XlnuBWazIDQCaE5PSr6lckmP1jAeGqBxA7AUvjwO5tZU
	kleMSDBwPh3JhiVBHHoKTZrswW/6uJL9FSLE/I0rZQ2ea84P/P9lRRIYq7ifCO55FokgTQA8BWp
	PBzWljEZ7e3XSVyY2Xga7xdJ8c0uy89Jf7tXAS93AKRQ0FR4DPpXrEpJx12GRs4gPNFyfD3iGUM
	cGGij5Yp+8/21aXke0hWrnijy4ayjf9K10xs0zE6FUuI1V1mdA6YSsiNpFxIIGnp0e7TNKt1FMW
	8oZDTMiklr4Wl95Koow8I2cKL8lUqy8+MMLF46luwIQU6UsEqKAc5fy1e4OJs/nJj4YvUxLJUwU
	aJMIpPsDXuosRs=
X-Received: by 2002:a05:6a21:7484:b0:3c3:88a5:83e4 with SMTP id adf61e73a8af0-3dd5282136amr408669637.10.1789461127476;
        Tue, 15 Sep 2026 01:32:07 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4cf015csm35233038eec.4.2026.09.15.01.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 01:32:07 -0700 (PDT)
Message-ID: <d199ecb0-aec7-468d-b145-c10903d9fba8@gmail.com>
Date: Tue, 15 Sep 2026 14:02:00 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Sep 2026, #06)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqv7874nm7.fsf@gitster.g>
Content-Language: en-US
Cc: Jeff King <peff@peff.net>
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <xmqqv7874nm7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/26 01:22, Junio C Hamano wrote:
> 
> 
> * ks/history-commit-leakfix (2026-09-10) 1 commit
>   - builtin/history: unuse the commit buffer after use
> 
>   Will merge to 'next'?
>   cf. <20260910160254.GB251185@coredump.intra.peff.net>
>   cf. <xmqqv78df57r.fsf@gitster.g>
>   source: <20260910150021.348548-1-kaartic.sivaraam@gmail.com>
>

I think the code for this patch got a go ahead from Peff. I just sent a 
v4 with Peff's concise commit message. Feel free to pick it up in case 
its worth it :-)

v4: 
https://lore.kernel.org/git/20260915082943.117985-1-kaartic.sivaraam@gmail.com/

-- 
Sivaraam

