Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405831;
	b=gDaD6twzvixC+V5udNG/2t1Zz7EpA092R67usjOoFQXlgxKnkBUaX4ViPaGCrLHNoM1J
	 /ZRXIF7MGkMma5daH/ExLhCbrs3Nf8WtZX+QRax205A8lnJht0Kv8w3UQ7SyF/D+zikNM
	 9gHCP9JXpDfiRW+SKTp+f7sgxKEwzOEq5m4jUPmsm3fIZV50iDmam3B+NGSHUwkZFssH0
	 no7dMdKW71R0Zm7gVsz6Oq8DraD5yaJ1pXLKnMYPZI8H82d5aw1GH3mcO4LaDQpsy5nAl
	 /6SI8f2b9acEjOVhys8JH0O/xaxr2I7/auXOmNmtCTZmWRWxOfIk3agtr9HyG3/fpMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=kq3WD8xWNSy5+4irC2HM/xHrrzJx2Lzf08RrQfx5/gw=;
	b=i6OS7FEI/CZ3lRrWbnuKxUuPHNhJ9DooN3/CCW2U+ccw5a4AmTbxoZrcKmxui6SngVnp
	 Wmt9UJwBtuVZmJdw9Hx69Azaen8XW4aLdZolDYQDhylhCX9lp7m0CsaVmWqJrp+WI0cm1
	 KRvBVQB1WH4ZpxBqu8tU/NsgM3uCL5aMpBinqNLlq5xgzPVCSbv3jU25n2WwZMxOvK5bT
	 emwf0UNVmlL9YLajRWPOrD5qz7VfaUpDa9cI6XVO0YnNOUwvNT3vAiC/aF4ow2uW8D2y3
	 Tv4HKrtKDpmmPiwtzRRXAkAAh8Dy7P36t7NCGn9+cyJfC8J3ooijXdzUTGfydboweig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ll6LrCRF;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF720606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF720606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ll6LrCRF
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a210470b49so26485845e9.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 06:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794405829; x=1795010629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kq3WD8xWNSy5+4irC2HM/xHrrzJx2Lzf08RrQfx5/gw=;
        b=ll6LrCRFPS1si6/khTjnLKHK4nj1My7oqjutiXmB7qSPbxGw2Dz8iY70J38VfOUKXg
         zLeu2U8PhYFXcQ1ShLoyovvvPcGL5WvfVDW4P9UtIflJWe/nkN9vPdyn6i8OeahukE4C
         2t4LJMxFZa4cbi3wmEXtraBqAUJOHVPTu4q/qupBVtTVL8TxRFLQqVwJMNq0kfz8RHE+
         yRhtAE8m7woWFQbX4qwIMU3kSI+RDCZRPUCeLcAlOLANKhlIPp9FBnMv6iiMaYqHPhNs
         N+hZAvLOu49Qe5sZA4YtucbOwH+2eiZnj5VqzbypKm1Lc6Dtn10FoY295H1JmCzyu/A7
         XnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794405829; x=1795010629;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kq3WD8xWNSy5+4irC2HM/xHrrzJx2Lzf08RrQfx5/gw=;
        b=R/C4eKGODUHD16Hex+BcUHfO2dB34dqDc17DnIZKtu2YxlzkJrcGXCAHeA1Ec6gnL+
         jMlczMNMmjnzb3fECPCGjqiMKh4r0DI7737HA7pmMqcj+rANSum6PemaHzhOlBmlu7PP
         p5CGwteGF6Ae8vnbVtrcvq+KE+fRGT5Bq2Br24qGQh6hoDHqhL+omjuhVZiP8CYMr94+
         bFSP6zJ6OW/0E3yRT4thh49ZP2nEMLqbfjETCLJsMBdSVohtJtTvBkjpiSxKsF4qyNpr
         lvEShBEhRuDxONhpfA/6JQquw0CPo3+Gtq7P1H7YChCp4lnX7Ft3oI84WY/pqoJoQ6d5
         U9Fg==
X-Gm-Message-State: APuU4Z8asyGI/mH5XT1NPTaUnnllrQrHfNybIUwQlg6Jb1dCW/BL4V7P
	hjrhLr2KgsKuVc/BZSsoZCm9GbMU8hnTETaBhYylHBFhGLRe+6ihfTKa
X-Gm-Gg: AYBFou36jBLx0kXS+bYgxRpVG8CLJMjDS5fr+stc7S2K0hbDtE38FDr04X8c0QpF68x
	zixslBqOOKwx+T1Ji4ahFV+3/00bikvYd22avcPxd3Cg9O6wrEglK0gnxjfN42k3GT3bltnXA0z
	Zj0z62dlvjotj9atzpMweNfV6eJzhWAenMO8YkW+3f/4ziWne4maT8ofRvzTr3tRUmGqZwft6RJ
	c8UP67nsCtVutlSXcJyQDay73J+uadBsl1GJMg8RzISeTPq+lOpFJOEO+JHRv31VWBC9NvNnriu
	UFnH6vSUY6dpUJOtZWaF18eIwgwxq/ZlQRWtCoTvcIBZEieWhrwT4arBPR6l2or1nkHaA/YEImL
	U++uoojbzac3vjCpsEj25idWxaA8b1u6l1oZOe5utOg81w2fdC7BrXU6xHA7Hemx4lu+c3OD7fo
	lpTvi0hiqjqVc8+v3UlhQl+kG7W3yVZDC0w+favQOL3XYhvHmZ1K/ebMgwm2Opt5Fg7TO8i5u1k
	50HUKxxQtNYwR9cqfaQ202KbWKPpCUpPiosKAQs8XNCIe/Pszef7IM/pG1xOAzRSwSYFPQcFSaX
	ZKc8pQy9p+IEO4QGlMmpr5AW6/p4M5xh1wLLzCLc3tjrV/YLR4uIGZu9jGMajLAkh35hpMTxVO6
	W1x2tk3OI1Q==
X-Received: by 2002:a05:600c:4e41:b0:4a3:59c9:a754 with SMTP id 5b1f17b1804b1-4ba0939db52mr44290275e9.22.1794405829268;
        Wed, 11 Nov 2026 06:03:49 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:1921:262:1f9c:7285? ([2a0a:ef40:724:6601:1921:262:1f9c:7285])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0952ab18sm47188275e9.4.2026.11.11.06.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 06:03:47 -0800 (PST)
Message-ID: <5756583b-4845-4fda-8e56-1ad2a96ba014@gmail.com>
Date: Wed, 11 Nov 2026 14:03:54 +0000
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
Subject: Re: [GSoC Patch v8 0/7] repo: add path keys to repo info
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,
 phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com,
 Junio C Hamano <gitster@pobox.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20261107160100.122243-1-jayatheerthkulkarni2005@gmail.com>
 <9582c0da-7aff-466c-a510-ce5a10054df4@gmail.com>
 <CA+rGoLef6b35hjJAcO5Nm57NiyDGK-iDbWO2MUMeoKVCkbRf5A@mail.gmail.com>
 <f7489c12-8529-4d0b-b820-225c9ee4d297@gmail.com>
 <CA+rGoLc0Mc82fTL85t6BRcGUJ8+S6cFfu0kzpxqUyjyShQW7UA@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CA+rGoLc0Mc82fTL85t6BRcGUJ8+S6cFfu0kzpxqUyjyShQW7UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 11/11/2026 09:03, K Jayatheerth wrote:
> 
> Well, you are right, it adds nothing new per se.
> I was replicating rev-parse without any benefit in both these cases.
> 
> Same logic applies, I will drop both these patches.

That's great, I look forward to reading V9

Thanks

Phillip

