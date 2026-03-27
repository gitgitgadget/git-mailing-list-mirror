Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648773932E2
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642604; cv=none; b=eXhOiRKG63lAzK+VpeZUQ1fzkKEkB0+0X/svvR/iYw1o7X5xBafVD7JrpIM+Tb1pkXMKWKyY718N0Nxz0Zqbyi87H5LDvLxyA5bjWJlo7gFPu4z6cs2gArcPSxJeBA4wx75cXF5sIIZB6BTUv00SrFXIwL9d/CjB1prmtFbQeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642604; c=relaxed/simple;
	bh=pZT4XFtqrItk1icf4b/6RyJOEY7RUWArBhKyqsczg0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgrVRQuavpg1M+wH9PBy5bt4SeNdyYBh0zKveqsxstkjxklenkvPQXp4h9LQthUPLGOxTefE/KU/IydSohxRW1R5lkx+H/JZ6wEiUtyiBaRd1x/+Y2JWWTeL2RKTJT3Lh1Zu5j45rZwLdzjrHZ2eaczi+w5ZE1eV61FAkjIhMDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUOa+Mwv; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUOa+Mwv"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50919fc3a14so25338161cf.2
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774642602; x=1775247402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wRJAciSBwcFEoNiyOGf8PNhBiUIPt+IBn6shU/EVCc=;
        b=JUOa+MwvDiV883HL4JKCmWIWkNm9lIEH20M00QCvzCcLEgM79HGXXwSW9IZnLYNmYV
         0SVGAwHl0vWJz+RAhvqNF+yksSsepoXjTjSzpYu9k1pg2w0VUOjd28cNYk1cN2L1/SUo
         0O7MXjZTszOpwUA52aY4uau/9Wf7poF68tG6D7+3Ip+k7jVmHcWCyNwmcLHB9O3N+uuG
         ElHOEm6A30t78agc3SESWy98CnU8HhjpsrHS4Z86LXyt8q0YdACSrnppRwN9MY/01A3V
         PTzePPWQ0N5O7+weLtRNUdBkhn7OeyBriNizjJNp9yWhunMgxNmSuA+HIdkF9dBOlVEc
         T54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642602; x=1775247402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wRJAciSBwcFEoNiyOGf8PNhBiUIPt+IBn6shU/EVCc=;
        b=AoZzMG+ys/Sq5Wfqq/Z2DoBjT2qJmtYVMdRL2Y4R61WcBI8E1EpHesFSrQhQ9QBlNA
         foEJo2Agj157Iw0GgRF+jVcRxtaZXLbekDvNYyjgp6Hk8FIbcNZOr3Qatzec3V+Sp1GJ
         m09VgfP6JUxXpOw/YhHOS/f+O2ALOsflOg1Lf4j9zrXWX83FXS4U36ETM7r9AVqa63un
         UyPvYzF2lGzfyttHkkWbSZ4BbJA3u8UVY3Q2cyNqeQB299sXVeNA8mwIIBK1ItKWBDWl
         QCYyefVUx0mi1xeRjvBfRqxPrA5QTL4a3JffMTBingSEvFiKHMH4qQLVBl+aQsTNQ1mn
         rEhA==
X-Forwarded-Encrypted: i=1; AJvYcCWHoVFnMCXYbfCWK9GYFH3cXBVUL+cVltoMhLOvlo2DeoRbhi+9J/j+k+2nZYu7P/SvCM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg7E/8asI5YHZC5TMd9daSrIRjB8rf3/FRgv/N5YlAEWjLa0lA
	8R+3WRq5QaxDwn0l3Cef/dz1uEXgcMmcUSjSsI3O/+GtFyo3hknwdohR0DS8Pw==
X-Gm-Gg: ATEYQzx8iAfKvE7TFYMlxDFuIU4uVezVK+Lp7JT0QyOispnJDO8ZPm6cjevJzoeaUBK
	MhOu+wJK85dFmpV2ISNUVZZ580c+EoTzKP7ei8nAm7i1hyiuSWXforLrv8Qj4Fn9PLdw1aKKoPM
	iDTHxwmw5O29dzBCYE6QcWttycfcU/D3TDJXt8PYhemDazl2vRzgB0FwGz0YclRboMnO52jBxnH
	59zA9m9s0+mQcEZdUtKpQIh03CahVPqnS4igRNZyQ7qOLOzDFQHp01HBGMJx2ZR255stsEg6VkD
	uh//UsYvr7MeByFwUv1ORT26bVc6WS3BSURtIg/nUkE2k7m37wS4l4qgvx1WDGbDYExuJyItkMm
	GOC7hE+xYrIX80+SwjZSGIfIU1uBhKpXBoCf5f5emdt1wUywcjZsdR+RYnx0Hwetr/KpJL2zWsD
	HM02RqIVwsjZjjkV/8+ud9vjy3zlIi2+0A8W/uM+d1GpBOhqfWCYdGtYG40vkw7wShoZDPrw==
X-Received: by 2002:ac8:5889:0:b0:50b:2875:fe26 with SMTP id d75a77b69052e-50ba397837fmr55259151cf.60.1774642602199;
        Fri, 27 Mar 2026 13:16:42 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecf865ccesm1024016d6.39.2026.03.27.13.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 13:16:41 -0700 (PDT)
Message-ID: <af5babcd-34ad-4933-a4dc-8c9a9fd59bd2@gmail.com>
Date: Fri, 27 Mar 2026 16:16:41 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] pack-objects: handle excluded-but-open packs via
 `--stdin-packs=follow`
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774641999.git.me@ttaylorr.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <cover.1774641999.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/2026 4:06 PM, Taylor Blau wrote:
> This is another small reroll of my series to fix an issue where MIDX
> bitmaps fail to generate after a geometric repack in certain scenarios
> where the set of MIDX'd objects is not closed under reachability.
> 
> The main changes since last time are:
> 
>  * Named enum stdin_pack_info_kind.
> 
>  * Refactored how we handle reading incoming packs via stdin.
> 
>  * Fixed a nasty case where sorting the packs in order of mtime happened
>    to work on some systems, but ASan detected a very legitimate bug.
> 
> As usual, a range-diff is included below for convenience.

Thanks. This version LGTM.

-Stolee
