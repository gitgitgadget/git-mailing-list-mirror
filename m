Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795845822;
	b=wMwAEgHfU6KIzXPhdCW4kLlvTm+2IpLapdRqYAwEWuOKUWlZ4pmajhsVuvBgcZvG+mdD
	 LdrU5xAjNSRUyK2fTuD3NXJ6Tf6PLT+RJrXvlYaPD28JRMMpIW1SRqDzYnAAPII6wR+1r
	 VJQPbrRCi+UvZDEPvASilel8X7m7/tj7jk2Qd+j35VrBy33111RG/gUp/yIQCBDNjmkEM
	 O+bndEwsA+LMN84YU4T21VfLrHBh0BklP2r0wRsBtFuWzKoj0wL4HR1QoHSU4qNQhIl6a
	 rVaNidG3B3hpZgrPQbqzXO7ULMPdu7/ydVblNbCRJQ81dulw77lmnkVHY+JVepMbShQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795845822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=AmYl2Byl4c2B41uRU1VM6Vq3m++14BsUbjdgRbX8x10=;
	b=t8fFx8DC7Rp+QjBRwp9P3w0i7Z97DlRUoJ+ZgVKO8fETy6Wc7vosi0lTIcxY+1SwPjOd
	 68B6Y0LH3uULEJI5gcaAZMdxoTk9DPbJTXw4yTCocSoIyBsAOdZHSkux3+2ESHDkbyQfQ
	 iCj6UjHZP2wNJ9Pw7JVKZYzXVYaENhdbjYRxHrdhj8bpkL9JegBiJJklGX9F0UWVLixj2
	 t/6vNUNzUO+Ekk2GTON5TeF3wHD6HXMttcyoXobwLs1IV6g2p+K8p1+k2kG3HVgENVJc5
	 fbyZNOyqX/wFPc3twWmJLjc6q0EzYsbm+P2P/z3EHPiSx6S8UejtZCppM8ERYYaaPEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pq2NH5Qn;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8D2606A31C
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 06:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B8D2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pq2NH5Qn
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-38431138772so11547242eec.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 22:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795845821; x=1796450621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AmYl2Byl4c2B41uRU1VM6Vq3m++14BsUbjdgRbX8x10=;
        b=pq2NH5QnEibbxnN1NiMkPU4r68B1gB64dV8hk+poYhvpAM7dLT9I1H6AWTMlYaGH38
         JdCEXdnnybyyESabJI/SOrDocjrikmrPFyfKGS7kPjrV1ye7ulX5tDy4qco6dkqGZ5R3
         GiKv/X1NOsYFZVjTbbT7fUOezlGe0gAV0E/zD9GvT2PHfkJXhyVKSHtsZHGlRB/4R5SO
         6YjEJQQsin44IS/+SGFCRmbk0CQ2Tmp5+QosrKyjKamG0qck2V+0OOGTp2fj+73ZYdy8
         C7NTl1KIpytr6Rp/VkmZPVIu+EY5XW1VR3pGoKiQc6rQmKyERlphyUGRBVyvMGryS4To
         FsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795845821; x=1796450621;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AmYl2Byl4c2B41uRU1VM6Vq3m++14BsUbjdgRbX8x10=;
        b=yWjZsUfqAN51sgyYez70quVtto2xejV+xu2Tn4Oait4cEglcq74awJxnLXXtCpPLC0
         JEYFLlysMRAjfrrGv15zrzvKHDGORgt5ICRF6idX6MhfFIpQmiJ/4bBzc/EXnRNzGIRB
         gW5tGxStqNOud/FwJh7WeGZ9tCCgLMlxU2DOWOnRWsm7iOdSbj4+kCqEA/9a2uJHsjnO
         MAfPR/vU20Mmosofmb5vRYR2QdwD7nrI1qabSGWmjsB5kx+3exrid2QgrvscJmrfUru8
         WJgfhAAMQe7z0XTTkK3jW3FCNbii/WnvjfaEr9X4A9V2LBJ4djkTL6DGDg1QGXCVI9jQ
         bcgA==
X-Forwarded-Encrypted: i=1; AL+hErEgVjOsbBjSRum+mN/YS8Ntpm/98YczYlTK3XUXUvHypBbU2cBuOjYt24Xj/lB0qm1w+uA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jjikWBT6NtsVEWlsTt+85tiLVQGiMYcyW5hB/Pc4UP+pEObvQ
	gCP/ANgWVUPrfkV+DfA2wkYIBgk/fiMsc9HGK84pboSIT0S+1WHjjflp
X-Gm-Gg: AZFdTZdmQb5OuZAThhVAJIFco2my5sYBxTGsIXnLcfdD3LuRK/FGXFoaRVhtKHs6ipG
	k5PmOpdqG3v4LFezzqqWV2nBGFf7tG1yKvZdCjU5lzKyPF0GmRT0ZVSjxROevDGAVez+gx33yzG
	uppaZME8vjel3RKMb4nXrIpAYTG9UwCNFQsFnFvWQpQ6IGyMMYa7/HqlYK73AgRcfFX9efPYNmK
	5rI9oIMAT3Os39LjPG0nvMz3QqnCvi6XLy6vkEdjo+SGuWce7K2xDDRH1HSj6DlztokqYFUc1H9
	30QpwFRjqOW4TaKI+ipmp/OFzwPxk2HKNQhE7b3NyAJkc4A7JfZ1uH6jGTSrN00jqbST9SbI9gx
	Ml040hcTMrNNwR03xJzcyjIttxhf4XY/aAO677m/ZkKkTrHUacwmFfzmOD82wQt7JdIR0XbJgWo
	M9yAKvEP9oEIyGZs9i+evtAGpD6I/H0wAXlTkAJ1qNgfULn4KTqNmU+XAudZOqgd1+ZZezk4q3r
	Xd818HVwBSVLS1Kr7DSwfdP5T8hl4pROKtCGHov+YYYNn1zmWYd2inYf67JAxfw+II9C8zOba+L
	m8yStge95O7fb1FbXhH8oRUYgQ/ZQrfA4kzlf6KAsJ2pzfsJY7ILSBwOlH9ydJEG3iesosfP9cM
	8RBqk4wIn
X-Received: by 2002:a05:7301:fc18:b0:36f:2e77:93e2 with SMTP id 5a478bee46e88-38570f27031mr25734070eec.28.1795845821386;
        Fri, 27 Nov 2026 22:03:41 -0800 (PST)
Received: from ?IPV6:2406:7400:12b:ed80:211c:a254:fe90:c295? ([2406:7400:12b:ed80:211c:a254:fe90:c295])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm95333398eec.10.2026.11.27.22.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 22:03:41 -0800 (PST)
Message-ID: <a079bc60-c064-40f3-a5f3-2723c9b572ef@gmail.com>
Date: Sat, 28 Nov 2026 11:33:36 +0530
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
Subject: Re: [GSoC] Introduction and microproject: fetch --filter error
 message
To: Krishna Abhang <krishna.full24@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, karthik nayak <karthik.188@gmail.com>,
 jltobler@gmail.com
References: <CAM6E118xUJh77z++XD_z62invya6_rHSmjLKUPydDELRsOffyw@mail.gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAM6E118xUJh77z++XD_z62invya6_rHSmjLKUPydDELRsOffyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krishna,

On 11/27/26 20:14, Krishna Abhang wrote:
> Hello everyone,
> 
> I'm Krishna, a 3rd year student at VIT Bhopal University, and I'd like to
> apply to GSoC 2027 with Git. I have checked that I'm eligible.
> 

Good. Thank you for you interest in Git!

> For the GSoC project itself, I'm interested in promisor remote fetch
> ordering from the 2026 ideas list. Is it likely to be an idea again
> next year, and is anyone working on it now?
> 

That is unsure at the moment. That idea is part of current year's 
Outreachy proposal. If we pick someone for that project this year, it 
would not be present for GSoC 2027. Even if we don't pick someone for 
that idea for this Outreachy, there is no guarantee that the idea would 
there for GSoC 2027. It depends on the discussion that would happen a 
couple of months later.

Generally it is better to follow what the "Note about getting involved 
early" section in the General Application guide[1] and work on other things.


[1]: https://git.github.io/General-Application-Information/

-- 
Sivaraam

