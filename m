Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578012;
	b=Bvk1oZJJWP3WymTRJZJ235e6R6fYY+7CD97dmGKeo/nCZTL4ymVp1CxyS18t4SexxELe
	 iE6RplD/CE3gGdWMEt4l2YhPw011KMfHIcF8uIGsv4QNx04IfYPxuEK55e6ARFPAebwya
	 DvBA4YXucxOVl7OKSl4waYev4YtdNSnRGIL0bSiDhKgmyQjfx2uYH9rrwc/kI7PRf6Uwx
	 vp/BlIUAjuaHfpe/1A8i97yetn8RFaNMfS1b55Aqr82oX+uHIzX7MpYkheHWNmFu83Z9s
	 fyCPBop3Z4GZOZfnBT1HHkYiDLRcASYGjmiY55YGoyWO4jqjXIhWHQw+gkF1I/c3pOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/gXecTR8pfwqTTklaZ9IceP3/dCc63wl+qvvpK/VSiE=;
	b=H1eh3YLqOFe8qllmXEscOlguc+KnhZ7GLh3KexYqSdMLzvgFu8BTv2ehYbpu6qFb8QQb
	 Rrsru2fdVn7GdlaLwSHjzVzdv6i5HXuvn7YcIi3pJShH2orx2IqL3sDTnRIVcGS2ilrfJ
	 U4LIdtrk9BT2u9F8KSMG/OEdHohz5I4YvfQOHlCPwOIsLRhMzQ6EcbA6ZpWqegUwmrvgj
	 hsR+1eWczU9B/edFn5zG4qUmhKs055o6yUyR4nnIMkzQGEghU7pcKlD9+gOzQUqv580bu
	 L1jv8I2eq8niMXc4KsPmYvjZc42bxKdJ+V1zF202xUJyfPMFCC2lOAC0f6t8OiHqQbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q0WJJhII;
	arc=none smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A4606A336
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 13:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 475A4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q0WJJhII
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5c10dc41270so1395391e87.2
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 05:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794578010; x=1795182810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/gXecTR8pfwqTTklaZ9IceP3/dCc63wl+qvvpK/VSiE=;
        b=q0WJJhIID7JcX5H1diDl+h8bZowmg3x4Iucc0PiPc8yjM27a2cf7s8JP/yurA4WAMP
         72U00EYLEFpp/PF9byFbSVjzZTItGxNXjOfF1JN4bEkNwk2D5aySz6B0QVAjs/iYKZbX
         F7wTt6YNLb5pkEENYCbfvzoXoLumk1r4yxoGfVxYzAnWJYcQJmYA06YoIajJ3oeEjF8Y
         Zs1IJsApBkOUnbRaMnIntBzecbEaVlWXpKizx6skF/2S3zNLPiZzlB3qWCiv3zH3fTRm
         BbJvrDaqIjoiymz8DeflSkFsF2HHEbm8zh2/ZODD9I7HhoLlf5MyqlZhvSDlQNrp1OsI
         YzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794578010; x=1795182810;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/gXecTR8pfwqTTklaZ9IceP3/dCc63wl+qvvpK/VSiE=;
        b=BNGe9siP1oxnFRvgp9tuO4l8YgBymq7IJ+XnLKhCiuSSsm12EjU80NzsYocpFT4J2W
         W+nbF3QwzLRcH5Dmh7a7x+9xuhs8UAm2eALZQZFYmJalgFlk7McYNHkRjOmXCIkTTkQM
         KH1EJS65qxat43UxRIyluHN4E+YQUBuVSm1c9eMDw7t3u3ZgpeWg08fO2yrayl+aHZQ1
         I9p+GLDqYk0IZ2CHDbcrBeu3YWCr55MUfRKPFQDwAd0mDqxf3ZbGvbJjshqH0VWTsF/3
         4TSY9H6qUatBTnYFzgE9AE8MyvQAx2uWI4LCRGs/ewigvhNz1lvDnL8M7kyNop5NkenZ
         rlfQ==
X-Gm-Message-State: APuU4Z9CJAhhBvpIC7KIymDf4Ki81p60hL9mDiKjMXkCzvlvmclzmM93
	Yz7aGFM+0PAJWB089HrNDP/qYC61u0WRqEMDN5QwQrk6KzfE02nCoHaAzWEjpRho
X-Gm-Gg: AYBFou0S1IJ9mDlj+AAsKjexxrsShXEVbqDA8ShtHP/7hTn+Aq0xWogBDa2OtKpIXkm
	yGzs7OI+z1UcMESgAx3TftzMCS8EMpiZoo3qas4/TzvxYxiGbMsr1kVApFAKCZ/7oaPRV9j4s6M
	plUpzpuLoj0xeGP3caHxW+c93N8MLl5wYPgHFJTKtAv0byGlMZTjj4MKVwBQEtUkzw8lvWRgaXv
	pfbSeDhvEEddE5wCKaeZQZ1GoHDkbGsik50StHsRgnEQuQBseMR4w7omrbx9I3V+V5yw8yA1X9E
	5F8DEce7y+uLetAJ4u3RpsMk8PlN36e3TqxxaOoxUO+yCAFoQqEXDcldGQ+OTcMtqa1xZfy4zOC
	56qBsxuLMQugwkH/yyGXmEdThX8ARZjUOaBE462NcLjPy/1++uu3P745DA6lfHK9uQgZteSJ0PQ
	dSsk6XpcfmUmsLrIqEQ3g+UOfeB2qRpaj8Kps+aC156Kw4Un5eFw0o3kZdd+hfDgzO3oAtJu2AL
	vpoPYC1i8NlKdRcaKSCxKxai1ox3i2FY3/BP1wQ0UAMHbJC3PPlGS+SbaWKC0Vg3BQDsAbsCkAc
	cHMST8rDYVFbUwIMRLBIRbQb7q+CgVcjc7OGPI/8cfle
X-Received: by 2002:a05:6512:3d0f:b0:5c1:528e:1a9c with SMTP id 2adb3069b0e04-5c170b32ac7mr1036944e87.52.1794578010135;
        Fri, 13 Nov 2026 05:53:30 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17133371asm747246e87.21.2026.11.13.05.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 05:53:28 -0800 (PST)
Message-ID: <1c124d5d-790b-4d22-af22-c53573e6d2ec@gmail.com>
Date: Fri, 13 Nov 2026 19:23:21 +0530
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
Subject: Re: [PATCH] partial-clone: document promisor remote fetch ordering
To: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Hussain Sitamouwala <husainsitamuwala21@gmail.com>
References: <20261107150433.17540-1-husainsitamuwala21@gmail.com>
 <xmqq5wy89rq6.fsf@gitster.g>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <xmqq5wy89rq6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/8/26 04:25, Junio C Hamano wrote:
> Hussain Sitamouwala <husainsitamuwala21@gmail.com> writes:
>  
> It seems there are multiple people sending messages with words like
> "promisor", "fetch", "order", and "Outreachy" on their "Subject:"
> fairly recently, but are you in charge of herding these folks, or is
> somebody else helping them?  Without knowing if there is somebody
> central coordinating these that I can ask about, it is hard to tell
> if these people are making coherent effort to achieve something
> worthwhile, or if they are just randomly banging the door.
> 

The patches surrounding promisor-remote are coming through because we 
had proposed the following project for this year's Outreachy round.

   Implement promisor remote fetch ordering

   When a Git repository is configured with multiple promisor remotes,
   there’s currently no mechanism to specify or optimize the order in
   which these remotes should be queried when fetching missing objects.
   Different remotes may have different performance characteristics,
   costs, or reliability, making fetch order an important consideration.

   This project aims to implement a fetch ordering mechanism for multiple
   promisor remotes. The order could be:

     - Configured locally by the client
     - Advertised by servers through the promisor-remote protocol

   The key challenge is designing a flexible system that allows servers
   to communicate their preferred fetch order to clients (to ensure
   optimal performance and cost management).

See also: 
https://lore.kernel.org/git/CAP8UFD3kd=6QHp2oB+t+g-2D8bY-Oe5+_Vk+RJeaCa_xhxGrsA@mail.gmail.com/

I have volunteered to mentor the same and Chrisitian has mentioned that 
he'll help with the project. Feel free to ping me too in case you see 
anything around this you need some help with.

Sorry for the late response. I just thought I'll fill in with the 
context in case it helps.

-- 
Sivaraam

