Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700126;
	b=KNZK9QpUzYrBUYpIPcBhTNJc9m/v3ImAVsLMkq8DnltsmVussG02rvjMTEdZvtYzKUyg
	 lUFHZSNRMwspzcn4pV1jtlvydP7jpV9VqSSSXcPG17Y+fNXwAWavXOEdlmkw+t+U5KMxj
	 73PC7HLpCf87o3fOb0SRNyWY+hQTGbTeu8Dc7qA8XPcphluPA0UsIbBVFhAOYC+7doJF/
	 s3IQ5P9P6PsLegbgePzkcNJh9x7uaLEcEPv5vOyXlWi/7i2fXsiK2MSlbouPNap9xfC89
	 GJ99UjWZti1ql8rFcyQWdQqQQJKzTgU/M+DZCxInJAe5kM1p91WaSsFmxEnMLUyJcUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UQoqOo39Wi3yhF7ON4t2AOHS1GsgRhOd6z7gL336BCw=;
	b=3xz6kp3yZJK4MfKijJSHvFtRziajx0UmdtSU0g/9Ijy8SCdUonFPP2CtRah6Ytu9HjhW
	 IWpfDJ/ctvlf1Pf9KMhTKDSRA8I0BJybuIc9Za+xrWDEpyF3duRBSLVgECArpx9IAW6xu
	 xeUtiqYd3pfiBjkZkLTTjplyn6vbMszxjku+BLLyV/b8TJ+zyUQP9nvHNqNZMRqcGhT2I
	 NGuwvHvVv/DIihaISjF+krMM3j8+Y2eOtCLRxkWyAKfnLnO+NuUu89JEMplPJEaULJqkq
	 RH79c1L7U4wrvqnWAp/7qA5ERt4IASTl1++IjnPj5ahXz8j9YZ99DkCwQliPO+tzs2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JhpLfXYM;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D710606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 13:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D710606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JhpLfXYM
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a2af4c8d00so6662918c88.0
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 05:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795700125; x=1796304925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UQoqOo39Wi3yhF7ON4t2AOHS1GsgRhOd6z7gL336BCw=;
        b=JhpLfXYM4zyk/qUM7fHk7tDfgRuRncBWqc9EkAbfIoe7Lt1yP5kjZB1eyq/vZ0wU8n
         9noZCgHFxjA4FuEW1rvsLD4YZex97wq3dQ2UCFme3Y4WijFLQyhnO1PHqaducmicQujY
         Y87jhhCx4kKHFYv7kpRp0MdVKhG2ZhGUL+zoJRqitCKSXOdIEzrxsyyOabKc1Hy9gclJ
         2dKdn0/9n8NebOc6PS2nFd/UCAfXgWrg1Av81ZaXju87pfavorl7Ik/HsK6gG0CN72yF
         TCCscv9mBeKAj9thgQ+Y4LOef6iClrl9UMg2LZo0M23mw8m07/KZVi2j1ZbFL8xa2rjD
         XKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795700125; x=1796304925;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UQoqOo39Wi3yhF7ON4t2AOHS1GsgRhOd6z7gL336BCw=;
        b=cq0l0yVLSILE/OOy+YeSPIIZOiJS0R0FgHy+BTe7kkVYfsMzAxzpIadJEFnPB4VlC4
         IS7WQHeqZe2OCJVqTEf/rdSinVegb+0+lEyxE3wNv7YmQG0gWz58pn56AGgl8JWPRj1i
         UfTppDInDc6fEE5eFn34iwe1FiUTTixyxsy7t+E8T/1Z4FUvgBAYaIHfFMpiun1O4HPR
         11bKtCGE1WRQOf7KaxoztznLvvX18zjWLgrmtO9m4KYuk2+/WcHID+9YIRvZmyqYhl9I
         vhn9j8K1sqigZCPRM0NQEFziIAPJNv4aY9m6GL3//sv4wQX8DlJyxS/wSmXZpY1JGvnp
         mQog==
X-Forwarded-Encrypted: i=1; AL+hErFa8vMWiixjHAA6kXKj7Uyj2Cs805SX+aEtBjT+xA3BMyJZNlIGfoDLKvu30Atqpq3k+fQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TZIPZ/ciXO/02RihUsoovL69/GOXmEuj41PqVnUhu4YuAm9QG
	Ng0nywVwWloTeo9balI9Av+WzYf/M5rrrpMEV4sMzvVy8L7JxUJ8EzWi
X-Gm-Gg: AZFdTZfT+7nxFpvYBNl/EiF5o5d1A61YwnHNtbTkqf3nljfnmbgISRwDAXc9TzrprEE
	U3YzRiodyJ53wsjP/Z/7HaAbZX9stYsiMWABQ2IGQMHoEG5+qQeWp+b/WuKKhOIPowx7zOI+1p+
	YOmWCmyIVACQ5EznItR6EKsv6owjqhhC6IwS/JoWeFQuBP8KGqFgHYpSvycDxeSkCYhjM5BZqQp
	LDQz7KX0kg1/U0MCB41wKmdaGYXlNLXWu14B3LNmzmhk6ci974APpgFR1G7RDKfHoSGqIBAMVsf
	wIcXDfQP+5yvovZE6HrWWpV/j3PzB4rhG6B/W+UZz74H2xzKMcRseY11zlUpWHqgbie+hR8ssx8
	RMxTQ9IKjPa8oPV+cBbYmgykgft66hFErEKX3wjnqY/y8V3cGT+ux8efOvCoW8bbe9Aqu3Of19A
	F0m2hy1adNnjEQ2p4WUhQH1JuxHAnGwEBP/SRUcBrfKzC9OqbjQiIKkZza/aFjDu++9CsUUxiOI
	/k3IZK7kG7yXm4UQF4xt9upaJvPp2ZqRcMhrvRRZ7YpcMbwNY96pW6kpF31dGZZe6cyHVdI61ig
	Or5RCgR3rdnyp92hfJd7wl1sXrouXUB+6SAlyWt+T42Pig==
X-Received: by 2002:a05:701b:260e:b0:1a9:c52f:655c with SMTP id a92af1059eb24-1b556900476mr23742523c88.36.1795700125352;
        Thu, 26 Nov 2026 05:35:25 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556829d31sm81288331c88.9.2026.11.26.05.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 05:35:25 -0800 (PST)
Message-ID: <e799304d-49a4-4eed-aeb1-f58ecbbdb75b@gmail.com>
Date: Thu, 26 Nov 2026 19:05:20 +0530
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
Subject: Re: [PATCH v2 02/13] loose: rename repo_add_loose_object_map
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
 <20261023072559.3204273-3-christian.couder@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261023072559.3204273-3-christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/26 12:55, Christian Couder wrote:
> 
> The pointer it takes is not a struct repository, but a struct
> odb_source_loose.  Let's rename this and we'll use it in our object
> database abstraction in a future commit.
>

nit: I wonder if this needs a rephrase to maintain imperative mood.

Not a blocker per se, though.

Rest of the patch, LGTM.

-- 
Sivaraam

