Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0E72CCC9
	for <git@vger.kernel.org>; Wed, 21 May 2025 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840859; cv=none; b=UYPCJrM0sTZPyalQ6sIYxgggpQu5grHPBiiE41DQdLWLLrF5BRBgYYZF+Z/amnoWmLiA6OKWhPu166VveWLQAi2KYyWpctAjYtXof4sDMuuzlTMvdp0Y7l9/GPd8MlHfeLELygnSr2hX8Xr2rgl6wV8xJMw7FJZCs8JfdP8V84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840859; c=relaxed/simple;
	bh=jvduN1L59I75nD7QiYvqQtHkK2AQbydmvZkb6Aga37I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JSjoCSKsJFCS2OFsEbdqCgEWwFYvAdcI4x9/CTmhXSdfiRAZAN/8D3fHusKxIo0Yi0oe+a27XMhHAaPDWSYXY++4jaI7Nv+Mrf87jq2EyfKRGbt2WwFh9zCIg1Qr9tlvsnjTksLTHbeIctu8PVHvMUE6XhIcxu2gus06ZegnlAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meq4nkDm; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meq4nkDm"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a375e72473so1949282f8f.0
        for <git@vger.kernel.org>; Wed, 21 May 2025 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747840856; x=1748445656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/JK8pYijjzQ8+bos6on765Hb/MrgvWuJ/ECApo/ODY=;
        b=meq4nkDmruo2EM9fRiDyA4oi32HbuBzIF3tjlhd2XpYiK+SNXg+dNKMfVlw/PfjbOB
         gElsKD84aA9X1CK3mBhrH0BlB9ojh1uQmtoIJZppT+Km8pqWlzkfweM2YyFdzcuZkeoN
         tW//iCWHpym7BLQelw1vYPyJKNLuoNJcwJbR7zxiPNucvzolWW4OJkm9pbeV6HjptqHA
         FwL5o4mCK4C1t+Fi/wkjuIH50nbRTOH+KR0RLtfgGBM8T4YzXf5C602hgdhf7Xa6qk/j
         JFyO9Ve1RxPUNFDebKwl58G3fIniqIFbCRcD/6eU4LTECddpeRcAbbSI+d8a0Ia8k5zk
         RUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747840856; x=1748445656;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/JK8pYijjzQ8+bos6on765Hb/MrgvWuJ/ECApo/ODY=;
        b=xGDWwo8PCuRtC6nkksqw84p3ZCz/UzrEczLs8Js1Z/EcGdKsls7uVxRFZba3DIFxVS
         7wOClUDRGhV219NxZaKF95yHg25vlkFKIG+bJwAxnB2aWP3F40NQmjvVmYdUC+9nam2w
         YgqRTFZ3ooGcyFsiJe0dEoMod9uhg2amConhz5FqH1+KuvBFBjOD3HcVgBJ8DOwfSPFo
         9B3bpzHLCplzNzl2GBT59bYSe2NyiimkfCxduz8g1/0hYIkR5Kypdb0CXfuf0hOkP3UA
         MSFxSdMIZe2M8xpybq6qar3L5tIcmt8XNi8PveACk9pYTYuzDJ13kQrmDcAbXPbI8S+1
         r72g==
X-Gm-Message-State: AOJu0YzaUQo/sCYoR8vnU6U5oJ3x8r0Pb9tckQGoca42sSZoxRroNqHD
	i/Y/50hxF7i43cnQPDdEq2uXtSyZwVHdv4odBBW/C5TooHLB+IQrxJJe
X-Gm-Gg: ASbGnct20GtwHk8v6dL9SWB3Wzm9HMsrDEjazBdOj4yrYka3UiTph277AsCx6/85wUE
	izoc3q7EfNt4C0+5Hr2MYbqbCFM53hgi/rK0giDfbezj21ZdYWFQ2awaUeTKMiy0DgQTAdyeJuM
	GT0QpBpvWEJaj5IlYgosi/LtmkzjRtZhB9UPc2lAjRgJUgmwYXRzCuvRpaFQEcAll0e4J5aejRj
	ylgbf+t2/eF9aBi3bh+9BD3BYMOha4ruZFPD2ZS8Cy4pZIWnQ9+KWNM+4MPfOb0SF5+HWRodVrn
	VTCA2TrWzGwBK5ylmNiX7W2bUxFZcidjomXyBB0L7Rdu+75MxzWSknDJlMl74hZXLKgr8Oj8L4N
	ITJ3eVWSpqv5zcYUttDhHgVQnvdI=
X-Google-Smtp-Source: AGHT+IGMU2niix8Ixk9zknMsuHMSXYoUWf9cCIiVH4s+33/JuT2ERAUbd1chQLmtgFCKFwOtgu6now==
X-Received: by 2002:a05:6000:2387:b0:3a0:7d27:f076 with SMTP id ffacd0b85a97d-3a35c808dafmr20783499f8f.2.1747840856171;
        Wed, 21 May 2025 08:20:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a365bc0b5esm16277346f8f.9.2025.05.21.08.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 08:20:55 -0700 (PDT)
Message-ID: <46161e73-f875-4d9d-a344-94dca2a7b01a@gmail.com>
Date: Wed, 21 May 2025 16:20:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] midx repack: avoid integer overflow on 32 bit systems
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
 Taylor Blau <me@ttaylorr.com>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
 <cbc5e69b908cef3800569abe79cb9c107f72bfec.1747753388.git.phillip.wood@dunelm.org.uk>
 <CALnO6CAMqVvHbY2sR_+dt8vYHxDn4S7f4B2jq+HcMEXx7SLj9Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CAMqVvHbY2sR_+dt8vYHxDn4S7f4B2jq+HcMEXx7SLj9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 21/05/2025 14:10, D. Ben Knoble wrote:
> On Tue, May 20, 2025 at 11:05 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> +               if (unsigned_add_overflows (total_size, (size_t)expected_size))
> 
> Style nit (only in case Taylor's approach doesn't prove better): I
> wasn't expecting a space between the function and its argument list.

Good catch, I'll fix that

Thanks

Phillip
