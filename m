Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794670534;
	b=apFepNqdoZZ8aYp5Mj0DjVajAIzHT82XofLrqI0kowNLd4TAkO1yg9IlDpzucXwYY2CR
	 vCTJOSbfh8HcL/x99Dr/nrITQvUy8aBJsaQqSwLe4bUfzyI+/ZF+nbbRV0h34jcaGCTgs
	 WiESsl1pk1pL9tcRDxBvUUNc/PJlekuc1ddVL7+LtYIFQg/EMyzhQdhiPNIX2zN81dzay
	 elDs155eB69nw0TERZugpzD/oS87IhySw8zvKMotkvRfE9V/Hzb2bFb9eDVb7LBKvKa9N
	 bezRK66qsdGQ1clAuYhW8ISkotNxxUERrtP2v7GuWAvctUff7mteTjZUhNihM3WmqNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794670534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=iWoMJhLW68DzpCQC4rAcWi5JHOLqq3qPT/uSGiNiHes=;
	b=vER2rAIKD6O6tDlQjvH994BKb0k+VasR8W1F3WI4mYmqy3NR7vM1Yr5vonEPL4mNghzX
	 xQXlAyw488+9GnnwtkzAvOuluPo3kHGzXRhrWdwLJAyC/9JvhsXnbhTnVSwPVR7WxdWbA
	 oTxzQxzR9lpnLwc0AImfoiF52LZoS5IOlf5k2Vnqabw5SyBFkqQPjuSb62/jB6VDAezFC
	 kYUtmWdIkZBfqL281Dgt82umK+N18M3d6zb0qAgK+UOnSkoLputOGZwpulqe3oGdjqFZz
	 awPwsUOGM5myZWPyiPPTWQQKK8w5/8+fF63POwlNbiw5ko2zC2LObYkbuSK6hVeAhaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PZYpuBR1;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6956E606A327
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 15:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6956E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PZYpuBR1
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a2af4c8d00so4207433c88.0
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 07:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794670533; x=1795275333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iWoMJhLW68DzpCQC4rAcWi5JHOLqq3qPT/uSGiNiHes=;
        b=PZYpuBR1qoDEEGZmyVb4qvsN4DJqVlXjc54iVYDiDqGi1JuGn6IhfL2nDHyBlpSlaW
         Y+yqcq4d+Z0LQQ6qpD/8Qtr5aUWxQJA4JLVfEwnrI5ypgyuWesQ2mug8l4Jj4mXHiro7
         lDWCEyoOw5MI7br9+C+uN0egZO/VHlNlJLNHIGeRInse1n1B2Mu27w++KG751AI2p9mc
         XaOADIpI7z2zdyWjKPUEljPxY9K7o8YTLtYmiuKOnU1IKbAkLZwjS/HloQI4oCBB+O8K
         7/+uKdJ9KnCkP7jRQ208AnGw39QJfbydHUD8cpQVNhCmNYvWQF8clG9z3DV655dOO5Ft
         JEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794670533; x=1795275333;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iWoMJhLW68DzpCQC4rAcWi5JHOLqq3qPT/uSGiNiHes=;
        b=rp0WX93SxUO61RpmdVogO9xGmpGRYx5JAdaOaSejN41D5EI4NMwXwDv9Yq7TgJ5RFw
         JuLLfC9zOIYpcpZcTF5y5GeHWz5mMTExwz6Cx6wIzBbk8bMVw7nqwwqetXQN+zkpS55u
         twmkSrsGXiuwvb2hC+Om8H3BYtFK8R2IBWRweZEkmiut19t+jS0w9QyuD0lu0X8W55pD
         fcCfGesc7nRc9GniVBMEAc990DxKGijl6DGzcFT25HlyUus3QBcfB+lNtF/C0k4LcONc
         SUle2+48A9bySrsAYiBQ71wgWRKQDI5Omnsk2K48Yz67FAwQVvtAOIWQVjrfKWh2bBth
         p2PA==
X-Forwarded-Encrypted: i=1; AL+hErG2spOMiUGtPYMolY5uBMysfW1VSEuvfCkeNB8rS+g5qGxhd9KzA4lzEIA3OBRsCDcp+xA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9iPJW0BhiZaEUhl6d39mEBYmewE+d1tYRDyT+yTuSJniqBuDgo
	lBScYWKrH16AMPJSY7tcxK9BRLhm4fbqhQvCeE44yuvnTYmYRNDPdnD7
X-Gm-Gg: AYBFou0t0dqHA9IRH+8C7xzAG8S04d2KxtGpjyJD1MY94V5Dck/mg1/pCjK2G09+FLd
	/1vbV7l3K6YU7DGbXJ80VQy2n/Iqhz2u8jgFAoNnzIQ6ndpaAvPB/3m7QlHvd8yY+bJfZrW9kNf
	GZ52raMueuae+WFE6n6iksR1x7h9TRHJErQgk05JYPTzwBzyF9JL0V9zeZmPY5jetjGyAbKDAPZ
	MH3umZXsQKLKLM8P+/H/wX1cOgUb1nKdzCYtUJbgNSjCeAZw3j6T1mKmlLDReKFjIJVIEQXscDz
	FmYzHKDDTOhTyUvK8rtmDcETB2oiutjhZ0rLiTVC1HPsHCLTF5p+IBUyg9mIGfMIdW14+S6t6YW
	5VjTtnCXazc27L+WvWPAgTXmF8UD4+HKx2uPkWn3GeWvM9UHn5Ydu7+4coPcOrCuDtWdtou27nj
	uiy/eaWuXpwEY+bBE5GxNP5AR8SKw1oS5yOPC/zo1xNb7RycUFqpFljHKr7A9AvgmAV83tlmsc0
	4sST+TBJrhu78E8sJ3TWh4riLgiojUY1PKkF9b7isdirtoB6IvgoUiqfuTZED5xfBghLRjV40Bj
	EKAAwVBPkY2MuNv9AHoWGWxbWKJh+nwwBB2Hc9xeVql8F96n4zjBTKw6UZl1v1yMJc1A1dF8A2d
	2rjTo6H+B
X-Received: by 2002:a05:701a:844c:10b0:1a2:2da2:b278 with SMTP id a92af1059eb24-1b5030e2b35mr6205880c88.14.1794670533509;
        Sat, 14 Nov 2026 07:35:33 -0800 (PST)
Received: from ?IPV6:2406:7400:12b:37cf:a789:a247:8b8a:69a4? ([2406:7400:12b:37cf:a789:a247:8b8a:69a4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50309b2b5sm14387171c88.1.2026.11.14.07.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 07:35:33 -0800 (PST)
Message-ID: <df581c51-97d1-41ce-8e7f-030cff8446d6@gmail.com>
Date: Sat, 14 Nov 2026 21:05:28 +0530
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
To: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
References: <20261107150433.17540-1-husainsitamuwala21@gmail.com>
 <xmqq5wy89rq6.fsf@gitster.g> <1c124d5d-790b-4d22-af22-c53573e6d2ec@gmail.com>
 <CANRKfoCTtHrZ233nZyYQod6JJsNXve+Lofia7=8pnum6oEPF0g@mail.gmail.com>
 <CANRKfoBw-+J5Dhb0ONGdWRU8wv6v7TBzGxQi2nmaLrDJbB_Prg@mail.gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CANRKfoBw-+J5Dhb0ONGdWRU8wv6v7TBzGxQi2nmaLrDJbB_Prg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 20:07, Hussain Sitamouwala wrote:
> 
> Kaartic, a question: from the project description I see two parts,
> a client-side way to configure the order and the server advertising
> its preferred order. My understanding is that the client-side part is
> the smaller first step, since it does not change the protocol, but I
> may be missing context. Would you suggest starting there?
>

It is indeed good to start with client-side but considering also that 
the server-side part needs to be introduced later.

In any case, this is something to be discussed post the Outreachy 
results are out, I think.

-- 
Sivaraam

