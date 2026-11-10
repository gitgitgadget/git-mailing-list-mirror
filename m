Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316948;
	b=tg87VS1blwePVV7hywIH9Um9CjWvcJVCCDgU7NddTvOXKbZklVLT53K4jz/CDbCnqfHp
	 R2etjjDVUcA3oz7TzkojXhXmJeEBhFkqOT0a9SrsO1PQLJR8iLFAYRK+gaC5dR6YJ4fQw
	 fCukgELb5yLOdDszLn+lpGaQG/8I9Bv4/iBQkO0xBeXA0P02cMTLkCYHtp7zpiTQnhVOb
	 6CnoJ9w9tfU9v/0xUwWI07w+wY4EqgPC7BiLPzA1VhWV7zSS2KnT6vKuPSIND0h1Y91UH
	 8IuYa3R/hahkMcWNkf7QQgwxND1fLT1nHbbxMpFrp240wJdq0rbdI71o43pSTZdJCOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=85dsXa+/nZx9RBcPKyZo1lyS4IWDN/bSFsLsOnIeQms=;
	b=1hQNh+8M80ycwMtj0tFqHUTM9RoQrPHV9Di9Nc/Q/Y1rksEUlRnNvASFVT/gxWs1c/yt
	 BwAlwdEJ7KAGJCTlC1NSqDgSt2Nx7OKuY3oGlQokJFEvcT99NO0Qm5fm8ehKGbmLlTt0N
	 ov9odkiAW8/z5ifgrnkYaFipvgAC+cnmireNr36tJ2TwCf6p1U4Z6uz8/TCOD8rUjtkdJ
	 1TqHmtaT9Dcx9UjRt+hZoGGqsouXQEMAeVaXQPkK1Q3lMF5n0MO0flZRYU34Jz23OthVx
	 lkVAELmajUrpYWkBoEuvW1JDz0VPcm/bY+oqyFeBG6YFy0lzoySl5+4ZCt7C1lMAqpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yq+vtGAX;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92789606ACD8
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 13:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92789606ACD8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yq+vtGAX
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-54f873cbe2aso20070721cf.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 05:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794316947; x=1794921747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=85dsXa+/nZx9RBcPKyZo1lyS4IWDN/bSFsLsOnIeQms=;
        b=Yq+vtGAXatdFs6NEDA/ZZhFg97t1tcOK7oS+5U1BA04ISuyB7Mx1I7c1rpNO1R7J9q
         aNyAxitzBBH7bd68GSXw9k8sLnf0b8D917iJYiLfg0PYQl8/jW6kh1Z/mA//CTJLmp2G
         oUd57cPodvA5S04tt/krfs1V9df7WiLUNWJbzVdy1DWnxwuUXaceHi+ESe5oRPSt4E9g
         Ocmq/312KTUloEL+4T2dki48Yz6RWnAKllpHEJlVmYuAdIYWMAhy9EjWcQOaTNeGuTk6
         oSeH5gq1/cH4KU6g/6Euru/+5TRRmNLKKqiRPr5Hy8THah3vfm8aLv+P0YVHP33OS2qf
         mAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316947; x=1794921747;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=85dsXa+/nZx9RBcPKyZo1lyS4IWDN/bSFsLsOnIeQms=;
        b=pKBSU7GzCuJnVSpSwthhtNndMN1ZZlbEhl1iTc5uv7aVh968Jzr1rBc1cka8WqnOtD
         rUV+fnKSzYEP+Uue/Vd8hUYe6PXuRE4BT903ejPK+puSTpL0d2p7/yU2NAIFzyVMwjVb
         PTyqJvn2qkU3ATk9V240u78DblsoLo9caFiHQI6k8TZNh3RbFOMtTe2Sd5qKoe6ycxfx
         bs58PvYxJbM3tEs1WVuvbEx5viZitahZYhMVdfi5wYzrdVHZaVVILAFmWaR2wbRWLp+b
         rlpKRnpmUKsA4QNliZMwx6/YTEnAOKD80lurFrblIV3WupAIhBiZIzsilrTAtKJyLlDO
         712w==
X-Gm-Message-State: APuU4Z9HtXvV88mUa4XhlkbP05fSVJiSMZcxVygoLqzsjTsp7TKQWT2Q
	6pFjV68MjdZ+4ToX6304rojJTYU040eBcJvYaDLg7Z39j1J+QaTuXdM3YiUuaA==
X-Gm-Gg: AYBFou3bxhsy9c7gK4OnUy7CAPrme2qQw452IlO7j41nFTt0p0h1LSMDSjrviMWPFNH
	Ag8jDpPKoj/JwfyQukx4U8m5OWsxBDH/IWcMuEJxz2PojZhkr7GLLa/fwiQXdbUypOywFfBJyYv
	NBjSY0pr1hMK3F3f373ol9x9odP1Wqjs9O7/sIDLjm1/0S6zUjtunNncVEUlYllEdJ4SOYf9f8r
	N6RRtyw5XdYRvmTNprHSFG9Tj7saBIKSBiC2TViGN/s2ci42qTLgpAIpsxTfcXG9jMTMBv+Nnzp
	ojjJB8kZmjnMR4fAOc0keCKPmg81uKFhABvfIQXkO/hkrXk10XPdb8lqvS/2mzuqc6J6+Nkqc9+
	Hni1Q7CClQPLnoIbe0wtwLvUUTgFnb9Ngv1wSl5hRkQglEeXj1heTQCa0FNlWDrvBeb3GUjeKrf
	jECPaipNMpbS/yZCzMjA1+m7y3QAuNZEp+7pZmvjrO6dHP2eBr6eF9md9sS2IFmkrnwBzHhIPPm
	739c4OvcfPwhKokmqI/kP5ONifyrd3D4NAyGmNa3qQle7IpGWeHw5jGSUp+8QDNqCBqxa+oaMRW
	tn9nfgvMSBe3DiL+pzB2B06WRTJ+IyB5i15h6bh/bVElGDcSJxSLLB80hDIJZAzSg8W+Dpfg7BT
	9CzDmOBbRqGVB6avh4eT2Z6HeYeJaXmJ/iDlYVE+NDKasuDGhlYgwOx2BpLG0iYrV8MZijyy8zO
	IMyz3hBt+kSoGYsiGonSjBjorcj8/oEPAraSNdZt3vXa8ImjJP6f/4DSY=
X-Received: by 2002:ac8:5c95:0:b0:533:2feb:9fe0 with SMTP id d75a77b69052e-5552771636bmr34537851cf.31.1794316947514;
        Tue, 10 Nov 2026 05:22:27 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-555091eb801sm24123891cf.2.2026.11.10.05.22.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 05:22:26 -0800 (PST)
Message-ID: <37267fd4-c565-4559-9c5c-01d58cd0426d@gmail.com>
Date: Tue, 10 Nov 2026 08:22:26 -0500
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
Subject: Re: [PATCH v2 0/2] unpack-trees.c w/o the_repository
To: git@vger.kernel.org
References: <xmqqtsltbfdv.fsf@gitster.g>
 <20261109205438.369060-1-gitster@pobox.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20261109205438.369060-1-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/2026 3:54 PM, Junio C Hamano wrote:
> unpack_trees() API serves as low-level functions to implement merge
> and checkout.  It heavily relies on the_repository, making it clear
> it only works with that repository instance.  We however can use the
> repository instance pointed at by key data structures passed
> throughout the callchain.
> 
> This is almost the exact copy of what I have at 
> 
>     https://lore.kernel.org/git/xmqqtsltbfdv.fsf@gitster.g/
> 
> The only changes since that version are removals of two blank lines.
LGTM.

Thanks,
-Stolee

