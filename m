Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A0717C60
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382948; cv=none; b=ABOLM/kXMf6ck2u6clUvh/7zFCjmOSb4/bVDmWc3SFmVkCQn54v617RmejN1GoRnQcIw8dLtqI1RuM5bB76+M58tMl3/+Yl+OG86CTewPWjrW3aJ/YyJrnvjlEyzxIWWpwWI7pHLm87Uu5eJWTrtH/rxY4NUu+2FT7ZVfqmLpXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382948; c=relaxed/simple;
	bh=LW87kfN/MF/rvX0tQaGZV9UAlQdosCgKxrDcv5gh6ro=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ETraTBZ+/+EpRUD+Uq7undsgGSQckBt5qhZVG0huk4R7iKeHYe0HTV3HUu3BubbI4hNbW8Ft8PhgFgnUqgoOWINm9x2AkD3axECLOnPChj9PUQsLSW3yEHx3V6BjkNEwZqMKFcoHfV+/5xTZo6fuR1gRqZNHjH4aSil7q8o3OQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNT4Rybo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNT4Rybo"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41c1b75ca31so7064985e9.2
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 02:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714382945; x=1714987745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ANYwxzOreeZtHtTyLzgvR1GL4XoS+xUNXMCiNQwrIo=;
        b=dNT4RyboQarcpYPYv+694Tx3k0GWPF/6fNqCZZnH6DZAWI37TIB7j52vGW06efU8wv
         uKC6fWgQN7/ZxC9B2/2+fG0p4hvMmNMoTDkJyDzZpZPSmE4kTbI3qOzs30GzUp4Ng7z9
         akJ/jFM3LZxdQp8TrjHjkNi9Ip127hIR8BXGd4diYwdiRpAOFppCXH56MKfpiJOYdjq1
         +QjqfrtZYBErv5+JX8IlgmhEFKalyRzsCcHNztYUHp1FV/U7ZfWRFqXY4tcKe0nDPohm
         TWuI3xzv58HJbFZH64eeMp+ccRgnC4whjgAmnYHQj0eEN5LKeZT1V1ai4Z8ft0XB1P1O
         34iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714382945; x=1714987745;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ANYwxzOreeZtHtTyLzgvR1GL4XoS+xUNXMCiNQwrIo=;
        b=jkSPQ/7GgR0U2qRQnSyPG7W2E9CUuIfDijyZLGI7GzPStJjPkvWRZSdQoRq60gkYI/
         2b3zPVs4WI0iK3hMydbqxnaVT6bgvIwCkmAfUWFWBOR2YeIu0gW5UgVhVhpubF5YzuVC
         OyyqnTTLT9cn4b/wH+lD+oPuLwfNS4kzR01g0in78etDGVruCdXdeN4Ozi4Z2WW5jymu
         ZSEgryyj/qsVIZgc6kcsE6gQyx98g3+PHFD5jZ1HviSMtDFOJtSFzYdIRJ0J6uwFwk5M
         CpOV+YAyMbsjPiUDqkataXUSyk176eZTZ+/ewGwj+o7svG8Y7UeCq/ci3TkYoIdKM2NP
         0cMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4FkSvQKGkVha8vzdnocHbzMWctyntI1QxTD0l7GU+nuunWLEP5NPUO3GhPtCafZC6+vjpXI1D1Sp4g+IIJeb+39up
X-Gm-Message-State: AOJu0YxOeLXeiNK58HS6OaP9vl8yL5y1NeseLofpiJ5fSB9UXe3ZeFOq
	pQ+TQcRR5vgWeyU+gZTV0lyhqwvHdwZVUmmQApptAa0l0oRYQq51
X-Google-Smtp-Source: AGHT+IFTlqU+VvM7sweAgqetCokzSz6lEIjDdNL9HWCttUOBa7DcjSWyHcwmC6gfB8uq/gRhOXFBug==
X-Received: by 2002:a05:600c:1c26:b0:41a:c170:701f with SMTP id j38-20020a05600c1c2600b0041ac170701fmr7911536wms.38.1714382944755;
        Mon, 29 Apr 2024 02:29:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b0041496734318sm44781473wms.24.2024.04.29.02.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 02:29:04 -0700 (PDT)
Message-ID: <ea3ee800-af0c-46e5-9032-391d82a4f046@gmail.com>
Date: Mon, 29 Apr 2024 10:29:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/7] refs: accept symref values in
 `ref_transaction[_add]_update`
To: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Karthik Nayak <karthik.188@gmail.com>, christian.couder@gmail.com,
 git@vger.kernel.org
References: <20240423212818.574123-1-knayak@gitlab.com>
 <20240426152449.228860-1-knayak@gitlab.com>
 <20240426152449.228860-2-knayak@gitlab.com> <xmqq1q6rc44n.fsf@gitster.g>
 <20240426211529.GD13703@coredump.intra.peff.net> <Zi9GIN1KrfIEjwRz@tanuki>
 <20240429075524.GA3908618@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20240429075524.GA3908618@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/04/2024 08:55, Jeff King wrote:
> On Mon, Apr 29, 2024 at 09:02:56AM +0200, Patrick Steinhardt wrote:
> 
>> In any case, I very much agree that git-update-ref(1) should refuse to
>> write refs with names that are known-bad. There should probably be an
>> escape hatch though that at least allows you to _delete_ those, or
>> otherwise there is no way to remove such a ref in the reftable repo.
>> Well, except for meddling with the binary format, but I doubt that
>> anybody would really want to do that.
> 
> Yeah, ironically deleting is the one thing you cannot do with them even
> right now. ;) That is because the supposedly-looser refname_is_safe() is
> actually tighter.
> 
> It would be tough to loosen it safely, since you don't want to allow
> deleting arbitrary files in .git. Or worse, escaping .git via clever
> paths, symlinks, etc. So I think at most you'd want some kind of "trust
> me, for this command don't bother with ref format checks" flag.

Currently "git update-ref config HEAD" fails because the config file 
does not look like a ref - could we do similar check when deleting 
references at least for the files backend for arguments outside refs/?

Best Wishes

Phillip
