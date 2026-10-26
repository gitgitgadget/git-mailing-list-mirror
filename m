Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012536;
	b=aKWO97Hy51JBhqPXH3YMcU0rRXAX5SabXIy/JAVCc5E7qhNTTdhyqYKYF8Ez3ulbIaDa
	 DPv5yzYX4KGne4DfHB60ZrSuFEar04g9oDboiPhsAJ5Ysqkdhuz2CUAzKhoAuEcR77GYr
	 0K7AOoXiR8fKsb5icZahwr3gLO5X5Lj1PgriTVEyD+EZaZ1RxI0+ANPRY82jjnWKCdvPK
	 ScSLqEDhidjMl0kyGTCdyMa72Y4I3GO44RhraVuw6bUbs85/t6z2MBgC8pOCRtRqSTYjK
	 spKEK/P4FL9jjhc1huCx/X6Ql+yS7KEOS0Q2VqlMhwY0/Qv4RPplADIV35XCW5Is/AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:From:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=oPKwjGT2ybMyyJ6KgGiOU+6dXRwldUdkpqXI8Rge14w=;
	b=nan+eQBCruCw8ZMg/P9/kWqM3plQ1Xnkm64SHBnm9NV9ll4FuP+jwfNnuYCB2p9cUznX
	 a170I8qbUhgnxkKhng8JaEQVEcMuZFS+RYVlInblGspptympNfcPoubbua8xhcmGGzdbS
	 KNdgYYPW+aBArssfT/t2E4T0inlkqHKocBXeV5jI34kK7iLzADBebNmxzYkXEdHnEf78c
	 S+15DE5shFYRGPKEwGwWtSeSNJFTliJAyuo3wpAndHA5X2v3nvxTbCZoE8XeJd76YPkaJ
	 +Ca7JAJWwO9PbD77z+Kukb98ipzow7wsZE3x5jPwMcgrbrL+y+g0h39zL0s/lUwNonA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CHcg67VD;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F2A606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14F2A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CHcg67VD
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so1782128f8f.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793012534; x=1793617334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oPKwjGT2ybMyyJ6KgGiOU+6dXRwldUdkpqXI8Rge14w=;
        b=CHcg67VD8LXIjjVbYKi2e3TSE7FgkzDCjnroRGI1kpTFk4ne579Q1x8kIH+N2H7M+H
         aGULmV4OpRPjCMvw6jtUFTrGtGuXx7HCrXJtfax7Ph2tqenoHL79ibz091O71oUM14+3
         5qVLMUz6VCZVmo5/4dNcC5FQBelJFjE1o5TTcE6XsK/VRrkIBfZZftLY2DE3Sp3WSm64
         +4JPzU6W5Yt1zMFmjMoHWVNBnkTjBqfFULegjLSTq5bckC0alKjYkVW6HjnBas1iB6yA
         bBRjj0zbqK8pkcifRBfqu7AxS+MgsCx9ga0p8Ai9MJg/uPMi0QnJ3OY5TRmDgS88W/oC
         A1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793012534; x=1793617334;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPKwjGT2ybMyyJ6KgGiOU+6dXRwldUdkpqXI8Rge14w=;
        b=Ah4kEZESzaZPW+p921SXwij7iCVUO5DVaL5fQWW6Etan8f/D2NWwtUsY/Cjes5Y4Ls
         HXvyhylrcaDqUNUIokjgwdReUOSXTw7DWYzbqZLjpqMpSoSQLHBUfv17rCMBS7mxjYu7
         32GA/8DAmFYMkV6dkGwIKLRPfvw5UH9JziNcn47Jb0FYxTOKUQwjlD4slrGzcdUcOB51
         vZhLLdQora5kUz8TKb1HjeCO/YZZ1fnUWpl73JTDeWoWi4CfHLYOJjNPvrrSQ4HQyyPu
         Bl7ObFg2uhD9emfU+4PW4WiRY+xxuzI+FbLBfIelKZQfCVG2o7Ol50+f4cp1WDstlvwj
         eZxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPQKtAI/KMoI7tNY7OZaAjeOWdZ1QojTUsJYU/naneHwQZf43rC1p62ZigyHRfFHXorks=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHcYMLMxnEyWFsgZ+B1NaszYeioEIuVWtHNjIekMnTJdTyrKuR
	V0efiPwbx7c+kxVdUNq4HiHP4Hjl40TemVzlQKjoQ0/9KyJy2RDxt+dx
X-Gm-Gg: AYBFou0CsOjYYFSwhTBCgjQO202JvN52ScpZoxeytHt7Tb2MRI6d+mG+L0dEqR8jAoA
	K0DfT06h/6+udOGPcuUwJVotSJycRy34AxMocYTVU/efaAGvyyF6iL6LzijgIzmTx0HIleGM9TU
	ajZ849ND5RrFzuTCi1ClZIx44cRDCYwa+m/US1q2rwHFXZm35zQLEHoEBepTfvT/HVKArETAAqQ
	GNYX/zFY3NBEionaMoqGOnB+AJ3qK6gwkW1NmtQ8CE+vC4D7UJwm2o+o9ubgg1pbMpzhqICe5GJ
	SC2HSXH5HuK/K0j2P7fHLX9u2sy3HcEYMVx0EcAfbfQHqj2CuLLRUmPCiT8f0QCjFIti16P5uzy
	kkjIwN3B9UZsaqWA7m/FmH7sAll/CD5HxNuSVEm6euv3Pk70oWRqRZvqxpzSbJiUXfvw3hSdbGa
	n+SfnV8t9C1Rl7IvLyshW3rgW6dLpxIE5S4cOHSoSch2YqpkccHgR4+YbwdvF7jA4daIgjGI1lP
	rUJfK4b3Ng3eVzwtaa7uBZTzh6Xm6439rh79K80ojFzWNwstmH+fb0euoC++XKkYAw0NQHYI0LF
	mK5j/yEKtCBwvPPny1APT9ZvYAbHh56QAA==
X-Received: by 2002:a05:6000:2003:b0:48c:54ec:ea3 with SMTP id ffacd0b85a97d-48e3eb73c36mr13992941f8f.13.1793012534184;
        Mon, 26 Oct 2026 04:02:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece13aasm14683095f8f.58.2026.10.26.04.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 04:02:13 -0700 (PDT)
Message-ID: <74ba33b2-60f6-40cf-86e9-dac95876b1be@gmail.com>
Date: Mon, 26 Oct 2026 11:02:12 +0000
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
Subject: Re: [PATCH v2] worktree list: add --branch to select worktrees by
 branch
From: Phillip Wood <phillip.wood123@gmail.com>
To: Jasper Mayone <me@jaspermayone.com>, git@vger.kernel.org
Cc: gitster@pobox.com, sunshine@sunshineco.com, haraldnordgren@gmail.com,
 ben.knoble@gmail.com
References: <CAPig+cTZEcn_5TG0iMVJJym8Zhu1KYP+y9Oc1J=JJgDYSzNSdg@mail.gmail.com>
 <20261024165311.57387-1-me@jaspermayone.com>
 <e08fd267-7017-493f-8f1b-d8dfb568b5fd@gmail.com>
Content-Language: en-US
In-Reply-To: <e08fd267-7017-493f-8f1b-d8dfb568b5fd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

One further thought ...

On 25/10/2026 14:47, Phillip Wood wrote:
> On 24/10/2026 17:53, Jasper Mayone wrote:
> 
>> For example, to list
>> the worktrees whose branch is merged into origin/main:
>>
>>      git worktree list \
>>     $(git branch --format='--branch=%(refname)' --merged origin/main)
>>
>> The --format is needed because the default output of "git branch"
>> marks the current branch with "*" and the branches checked out in
>> other worktrees with "+". It uses the full name because
>> %(refname:short) gives "heads/topic" when a tag is also called
>> "topic".

I think you can use "%(refname:lstrip=2)" to always remove "refs/heads/" 
which means we could simplify the implementation and just accept branch 
names.

Thanks

Phillip

