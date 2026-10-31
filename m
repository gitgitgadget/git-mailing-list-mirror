Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793458240;
	b=LSADSVWXOhUraQTKxobxR/NfEdNQx1sKy/HfA4HpX9MG3/q06yNCDmc2pYx0bbzcpboQ
	 JdgSHPWAjv62Q6XBzsA2XLXghOpX8SyyAckDJtaBCNamO5PgpHkcwaAdNR4wyauDfaRar
	 kxmwIDnJ1TBmAz8UY2vrg9V/jLLSyE0VhSNWzUA68i83Q8zuk+GRI+ddF46R3Ttd9d4mv
	 +yj+4onhjIFkYNtgYYZmHC8x6bhx4GiPTK3MsmEkVHQjbqr6a/IUBH3xxtwFnO/cbpaDp
	 F6EKehFzIuPu7LE/zBkL9+VBG9xW5wNKqAczOqu45pVt92u1wnz2ccueNOcnUNW1nvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793458240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Kym1aScnBssjhmiAfCKQM4USbHVFFnV5NUbYvgppvZQ=;
	b=K1L5ntdEVELARAx0iqFGwcQV4tKjLzVTzXfapbBK2ZzYVPzfS1kxE/3RKQErRNmQ0SD+
	 JRsG7BtHwapYd3aE76E4ho+FQV38FyNMMwNPdKbqsXPk3eIzR5dVYuho9J597kPswhlRf
	 RzLhXC0A7X238Yoz7YcaagHgRHAZW1I+HZVe+SXyzpb8a1ek1MgaRtaUS3/E5P/QSmdZv
	 dq3mS5WyV9s7Erflltmpza3i+dMpcSRLcgVMvXcZjbC1LdF8ezf465v9nHpz5otIRBFo6
	 Fm3UbLKmHN5q+Q52QE8lEyTQTbeFpP4JvF257thZZdiVpWH9ZgZiAI4PbRrNyGZeX2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HhBVOO4T;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353EB606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 14:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 353EB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HhBVOO4T
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so14014865e9.2
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 07:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793458238; x=1794063038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Kym1aScnBssjhmiAfCKQM4USbHVFFnV5NUbYvgppvZQ=;
        b=HhBVOO4TwMQVjVMaWxuWZjh2qeFboDgYgdhjdpvzmU97zd597eXMktqSoXtQA0EmoE
         BMA2PjnRSdPHVAYflfoKcIrLpcJmALDTKO8uOdVNyb1oGgkjRjPU1Hhj6faTRgI4HCeI
         R/Krbr4snCb9jaP1GeqTReXi52Mw0BvlSJCpdp1INE4qaeUp548G9PbPuwjulhdmOqka
         MhpCLg4sxlq+uFk1MusMIIprk4UAYhBrb4z6XJXTsVqN+VejouxtzNG70hE6rv7df/oL
         ff0V/HEzKDFfyjck80JkI127JIsAhilS6lG57N2+TlX6B0g9r55DNzndnmX/dbW1n2F+
         EUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793458238; x=1794063038;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kym1aScnBssjhmiAfCKQM4USbHVFFnV5NUbYvgppvZQ=;
        b=htuQsEFBjZe5fEoAGnEILrqeoXiMJ8MajJGq1SM0I1+KTauS2B2iOnw1GOuDRsdO+9
         SsbMsyQDlbvlReF/ewvGJjyP9YUVzN6xkvnKpJnVkePyyPJs+Vtr9FBro2ePbXwOHPPf
         65lun2iDztPEo483WDKp4uGhooznaqs4vWV+anFgotXJ9cPI88CK1CPQbJN02Sde1I1l
         s4v+RCTdXDE4ehE9sK7lrwksNUrMPQnJ3sfaHbk5k3xyXbfZIntFWxeYxRCYCh9WpFbP
         dqakN3yrJO6DYtsUI4v2Fp9YmPRMfl7NyieF/sZC8sgT6a3vx24f5Zmpng5rf3ZYsloB
         WvWw==
X-Forwarded-Encrypted: i=1; AKwUvByBuJH/bUQIG7zS5s/7NGFwZwZjjMaS78tGv5tTdNLkzqODZR4NE78na90hix4mjhIsZXU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhpNkij8wTWo1b7FTF46cx+0nw4wJ4//ZQWkEKuudwGmgZdyg3
	KEPS27yh/IZaykRgrKDl8l/A+GKaL0K6EVK+rCUl9CI0/7Hx5MdLR2OU
X-Gm-Gg: AYBFou2sssA++ozBQf+Jx3jbZ+QAM1u7EYQOgPBr+AZmslbX8/PaQRy7691blQiUTdQ
	wmwFVH7AIlRmsGmv8VxHgol5Wc16XeFbDK8TFoNYGqsqvrhC5bXq5PXttTxmep8iVrgl46GeMyt
	xCDGyZ3Z8yPOKAdZVA+bv4su+0jxx2pdGUT0ZflW7TyUzGJrNhjZX4oGAxdsvhLQRcSNgEqUFD5
	zJo0PgoKAfXtxHfoxfOsMf+tm6mEVW4FzduI2m4PLO9mdN0brZ6A+wlt9vOkJWN42JMSh/YKXHd
	QOElDrxfucwHd3lzeNfemcaE6k+39BE7wC2dd0+gg0f19aKmYim3lq6WEPi1M732flVGbyTAWDX
	9j+m1tinXzqx43qYdZlJCJt+4A5AJyEgoNwWgHxRpINvHtlSBjTPQqPehdi4X1tZqq/L9RLc/Lc
	iGR37dgEesX/FQvbLK88DhJAKj30JCJBqqb5dhey3j5X292l23fGDogURzTm+KP9tL+L+UdlvRJ
	dvZiTHcZnf/YzGcjBvhM+FYVh/VfJPB63PUVwWprWLjAxC0acLipnIfOF4w11OTHkFGQNYGP9Gn
	M5JY/4Ux2lwpuJSwQbt1EnobDnbAtuVpiHRQJGZe34W+/CAqiDaxCdvp0Jx8Q8Rsk0dQqPdTREP
	1o0LEg+g=
X-Received: by 2002:a05:6000:4b0b:b0:48d:db77:d124 with SMTP id ffacd0b85a97d-48e6e2db9e1mr12189331f8f.6.1793458238428;
        Sat, 31 Oct 2026 07:50:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723b4sm9560271f8f.17.2026.10.31.07.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 07:50:37 -0700 (PDT)
Message-ID: <97b9f962-78c4-43cf-9782-4d479b57f103@gmail.com>
Date: Sat, 31 Oct 2026 14:50:36 +0000
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
Subject: Re: [PATCH] sigchain: recover from concurrent double-pops of the same
 signal
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, phillip.wood@dunelm.org.uk
Cc: ian4hu <hu2008yinxiang@163.com>, git@vger.kernel.org, gitster@pobox.com,
 peff@peff.net
References: <20261029141521.164544-1-hu2008yinxiang@163.com>
 <4c2728ca-5511-4c30-a2ef-6c32fe7a3e9e@gmail.com> <auRZNlHezwALJOD5@ugly.lan>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <auRZNlHezwALJOD5@ugly.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/10/2026 08:45, Oswald Buddenhagen wrote:
> On Thu, Oct 29, 2026 at 04:03:18PM +0000, Phillip Wood wrote:
>> On 29/10/2026 14:15, ian4hu wrote:
>>> I left SIGPIPE out precisely to keep the "upstream of a pipe
>>> dies of SIGPIPE" behaviour that common-init.c restores.  The set I
>>> plan to block is SIGINT, SIGHUP, SIGTERM and SIGQUIT.  If you
>>> think SIGPIPE belongs in it too, I will add it.
>>
>> I think we want to block all signals when we create a thread, so that 
>> all signals are handled by the main (initial) thread.
>>
> that wording again does not address the fact that sigpipe is different 
> due to being thread-directed [1]. even if the outcome is identical, it 
> needs to be reasoned about separately.

Oh, thanks for pointing that out, I hadn't realized some signals were 
directed at a specific thread rather than the process. According to my 
copy of The Linux Programming interface SIGBUS, SIGFPE, SIGILL and 
SIGSEGV are all thread-directed as well so, to ensure the process is 
killed if we receive one of those signals, we shouldn't be blocking any 
of those either. sigchain_push_common() installs a handler for SIGPIPE 
so, in principle, we could end up unwinding the chain in two threads, 
I'm not sure if that is likely in practice. If that is an issue, maybe 
we could set a flag in the signal handler to indicate it has already run 
(though I'm not sure it is possible to do that race-free without 
something like atomic_flag_test_and_set()).

Thanks

Phillip

> [1] https://stackoverflow.com/questions/21718311/when-multi-thread- 
> program-receive-a-sigpipe-signal-because-send-which-thread-wo

