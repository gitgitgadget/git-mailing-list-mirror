Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFDE355F46
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563123; cv=none; b=O89EO9jf3h4KkuRRiHHMOFO87QEH7qxHXdCdIs4W9vhFTis74fSx7F1dZp8/6jQStHEPK8HzGFKSmJcR9/TL9g2jWfdFA6kwkUEmZ1+EawGymDJ47fsbzVdjM88wwAPgYpyTCHaHPIio8vyeYVXs0oGwvQLeDMI3yk31FXhfb7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563123; c=relaxed/simple;
	bh=o24xjcVIIsjVxdfV0F6ZdurFocNRSdD4XiK6ZC97gtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owiVxhAXVB+5iPUOoAbGUoO2C8Zz7JFSBBr+3FMPF7ah6mAzjpyMH3erCO31gljkqs+g/W99+0pPIwRKaM2d3SsNUPwOzYjEGFvnoLq7ksrr6b5DLw8Pkms9ZiT0SUu6E1e+uXvMKKahUrGE/rrg63xTesYOLWSlW3ZcvvcF/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaUOc4eh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaUOc4eh"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954dff6536so24104995e9.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 02:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787563112; x=1788167912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2wn7GXpkjMhB+CgU3R9I7rGejYgF9oux9V30rYGM6P0=;
        b=SaUOc4eh59zZolqAji2swqJpV0Do/K/PF2sjj9wq0b/zzr9RWpK/V0afYcaJdY9B4x
         9IK6KrUklFzIHnJl+ZKRmts1S/umGOtP4poKgWMV62R0ND/0ebysVmyUF6CSbZQkpxxU
         YAfof6qEOBkNRIIWq9/AXOcg7ytfpX5v0H5qK53KXbw7+Wo1KmEqk2AJ6i9xS8T6SzDJ
         b5ZEJ4hPgIjNdjOaMr5Ut8T7fv92DUV2P99fRy58pTTqIoiQmaB3e7/owr7GXmIjJSAL
         DXETJMnJtyegFJpgfaI7eAx0Qf77Mwh306OruywDsKATj48AhTltC6ShsamufEFnbuYN
         Zn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563112; x=1788167912;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2wn7GXpkjMhB+CgU3R9I7rGejYgF9oux9V30rYGM6P0=;
        b=aFo37M5/r3HNmW9Ad5Cdh2WPYynMggwGIO7lkD4lFTN8NhmLZlVOVjv6z2OJC074vt
         YoDzh6CQnZHdky4Su1TjO2BGykcyD5ngHEC6X6UBJk+QVpgQA/ZNN0PJ67rzV0YbOHaK
         4NHuF8ZAmiozhWOET0/gbNayNGdNjyCHiqNt6jjsCGjyFCeGbDXtZJK5YXMfDGZkD0ig
         +ngPS4fuooqJ/QDOcfg59SZbY4xd7bdUYl6fjpuImVjvEhX/U7E9brCN9vY8BfWbLsof
         IZ0/zVsTYsEwMDA1obUNep2LRvTY3BfjovFMpvD0IDcxv6WJI0T/8lib9EQ5Kv6w1Cba
         vpRw==
X-Gm-Message-State: AFuF++lAGPYM0QCNd/fGi4ofti0i8AS7WVLeyTQ8CHBRpgK9ZV1/X+jJ
	7vvEeceS1CazOFBlLMP/H+duvGmQ9vCvwdKoJWCj8FeGBM/y27rv/9gS
X-Gm-Gg: AR+sD10qDzCIloCoFa9cH0tiv9Abm+BNT+bIsoBC4LWbLe5/BTZOVjiCw+AInshCI7K
	F7frUQUSBjYmx31v/1yXz7QYxiDg6PJJvLFSbH0qivdzr5omhL1Es8xIiHqntq1spehPFNyOHlS
	4SXXTo3yPdhUvC09GenkZXxHfslfQodhe3J1IfA2+12AUqPW5eXiUGyWPXXLJhRBUB23dld0eij
	gp3H09aVEz15n3EK8YYLCHSdvHKbH6Ko8ybnEDE/RNq2COdm9kReeQi4hOmsT7l3dPlG+682BEh
	7mSlhpMHH2hcFr4+RH+1P50Q7evtXlIHTmZkBThPMHjWeB7f8i5tmlfre1SJi/kf5GPlWAm+C4u
	6FqbJlTKhXEGV8C7qtlKXggWsqep+ylNybe1U+M+dl1HloYinXJQVDZD/9C+lPQDfLuDfF/59Dv
	KS0d+/Yi6gDDRhEcqZzbwOtDch6vgrjIjwfmjpm7qDw6mnoPX2kN6y3sEue5/KJWsavzfvUKCrH
	D/z8dxioPPvx4GANEzxM5Jp43cLM0Tvhn29hFHINs8=
X-Received: by 2002:a05:600c:a00e:b0:499:8b13:3a98 with SMTP id 5b1f17b1804b1-499b830d384mr297936855e9.4.1787563112275;
        Mon, 24 Aug 2026 02:18:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b90e747esm125699755e9.4.2026.08.24.02.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 02:18:31 -0700 (PDT)
Message-ID: <29ada18c-b849-4bc3-aad3-b4fdc09c81f9@gmail.com>
Date: Mon, 24 Aug 2026 10:18:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v14 7/8] history: create squashed commits without editing
To: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Matt Hunter <m@lfurio.us>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Tuomas Ahola <taahol@utu.fi>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
 <pull.2337.v14.git.git.1787249432.gitgitgadget@gmail.com>
 <03528d3b34c202b990cc42865a009a5786255b7c.1787249432.git.gitgitgadget@gmail.com>
 <xmqq4igov9h9.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq4igov9h9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2026 21:10, Junio C Hamano wrote:
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +	/*
>> +	 * Allow "fixup! <hex object id>", but not "fixup! HEAD^" or
>> +	 * "fixup! main". If the target is not being squshed check the subject
>> +	 * to allow "fixup! abc123" and "fixup! <subject of abc123>" to be
>> +	 * squashed together.
>> +	 */
>> +	target = lookup_commit_reference_by_name(s);
>> +	if (target && istarts_with(oid_to_hex(&target->object.oid), s)) {
> 
> Why istarts_with()?  "fixup! ABCdef" should not be accepted, should it?

I agree there isn't really a compelling case for mixed case oids, but 
accepting all uppercase, or all lowercase seems reasonable, or are we 
planning to completely ban uppercase oids as brain has suggested? The 
aim here is to accept any oid that rebase would, but not accept ref names.

Thanks

Phillip

