Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794580676;
	b=i/x+UU/82laRIsliAP9J5M4gPUNhXR96EOBn3ngigCN3sXwhAXq6qSpYW7B8Soc/D6u8
	 yZFJQm8LbEdfwxILO4Ev33EVVqXqIqhaPp36e/CAumrhUsnzn87tso1AtVXpk8S9ItoN3
	 kcWPizeHAXyJxcYVlZZn4Vn9isr3jWTZDGXf6Dhy8ZNMVexiUvDY4sQrZLqVdQoOb2rUx
	 u69hWtLy3rfKoWR294TZuwRzNO++48BJOhHKwK+yeANycrzc9CdcU7LwaAvMjq2CucGTA
	 jKK6/DNsnhXEuvb47KOKVZ2kQN0fAwDLwm9LkzuWUoU2zlGHU3n/Tno8u0b4O8ZsG8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=odMBUMzrWesjfkPeQxdw+Rn6eebLqNPW1JrG0IoU5QA=;
	b=pxh6LqjafrVt0R4QX+vM8j/MVmVMbk8KHpGuq22x+G2K6jihNmUOjCfGEwhlBbKCISu+
	 3SUZc36Xd+q7vngNZzf/5vJd8JE3NpLphR8KpFDKaQYaQXO92RDI3pzBgjQliJW2b1cXp
	 Rs9F5d+esXG2K+T54J40RyhXev5e8GlLAIlb5javJk3txfRfMpZFzkfQNXpBO9FvrtLbj
	 xPyfUbdouor9Eyre/jxlyTsw2vicUCmOw83IM0KV++gX227DTSu0NSYQobvE0o9ib8pza
	 t958kxWIba4wfNZGmVmk6aKwJFTej9DQMYDz7ky7mq2qpDQi255YDe0waQ43fxYl+Hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ar2UK9bL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E011606A32D
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E011606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ar2UK9bL
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e98798cbddso8787615ad.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 06:37:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794580676; cv=none;
        d=google.com; s=arc-20260327;
        b=neuNFecaz8YkXqf8HH9R4h9bsVa3ba30nEhDRyL2KLgA2LVL6d2wJDLNiXxs1v9Q/a
         W+mSVgq3jctojpIGHpmoV+rnEf/Xi0qHAYaF0Vy+tFPh33lPpQ3+QKhlBhou1zas7G9L
         +nzWCHVfwqccLZRDGL3yC/H8u6sGUVcfrUN0Ws27v7j/AxSrTDnTBEnhKpNK9uEh9RlO
         iiBYtLK2DVAWHaWX6sM9svi7sjlZA1Hs4oSU2gfbIkG+BDoJYciYZKPF6/CzBJW1PnRv
         P6geoGIfvWC88BuhAtllWIKTjOd2QzBBR5SjE6FVc5J8XXVCRWV/x24+85QWnFKstyNN
         ulWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=odMBUMzrWesjfkPeQxdw+Rn6eebLqNPW1JrG0IoU5QA=;
        fh=fwP2EVn8Of5y34drDBPZsK0dvp8/MYy9PqJnq5AvJWU=;
        b=pO3lOL+HjJlc1bDaCcv5iMYpavEW+5czAy8HxTtWHMkXbEMGXGe4uh4aynsaIGfvQL
         fWQUCFrMEemNSvrjnhOeiGOJ89I5kthdkZGm4+QDEiWO0o3M0V8hVGYuUJSqm6k2KUpK
         gIOEpbndFwTl1k+eF5VwiMYYvtceUI6rtZcuV1OVPqQk/IQzIE+g5q8WLrAzcI8iMckF
         uMtTDxqkmub8R+7Dl+lJurS7EpTBN2MdIMVYJryKahuia9g0uvKVXctbst4SQRZ7EG7H
         nBRYHVLu5nkLq7ZgUeqicx1A/gi9QDKUR4FKwCswmZkPuj4seF2i1HC38dbsBuQXStbN
         P7bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794580676; x=1795185476; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=odMBUMzrWesjfkPeQxdw+Rn6eebLqNPW1JrG0IoU5QA=;
        b=Ar2UK9bLtGWj4+56jTa1n8FxMS9xa1rqxg7uEhUffZxp1dDHSYYqIxkwWrSim788eY
         UwG+rEEAAGAYUUJcp6heIY3yEJjzUfRIbOu6G9OTN4P5XOzdpeAXMEkUxbzkAuPgqMMe
         4TbM4yzgyzqz7yTMvwaWT818L67uYVB00uB69GhBhC5tgxpXb3AxKxF6m+zK8nxvTb26
         0nqkpdVfslEbFcu9y6JTRM0WJTh5boesg7pKz781sFf+kx+diVsuqnWWvfTzIJ73lqLP
         kBQ09i+l8J0q/cVyiQA3ullprzwDst2wnq5oyjEYmjNzMQcQ+g1Cs0y0uLVi+fgIuHMD
         Ieyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794580676; x=1795185476;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=odMBUMzrWesjfkPeQxdw+Rn6eebLqNPW1JrG0IoU5QA=;
        b=jvWbQ1XFMCnFwN+U4ygJ8sKKpmdalSimie5ahGWT/nn7iP8Pjxl9ZWEpKqZFKGRxSH
         j/eap0Yj8OnCeVd/h4wWE9RITlehUxoFRfXYD3tdhxEKAil6/9YiMj+GvX5SPQwxxpHb
         Ckf5hWP5aXHX+uFBC5D68VF/GvNtZYMoXN2g54+58W6Z5Xpt7xxtkAup/28EJty7R0kD
         XpaCMkV8wyyiFyNGEVmnACdj/BR1NmT1vv07AC7NMqRUd7Aj8HenJ2Ph30BHR67nCcBa
         Paf3qsFH4u4/2xBUzgsFWKQwzB6PyGfrlh1rszrQve26G9iaoih+3UaZXGluoERUcSAQ
         TdTQ==
X-Forwarded-Encrypted: i=1; AL+hErFByrmN2Dgur3SkFPWJ7utkX6gKz4BEYs4VxJtxi0O5FFF3t18UbMXvH5Jz3b6K203dZUU=@vger.kernel.org
X-Gm-Message-State: APuU4Z88Yob3C7pNIvoZgS1aC6WGkXthhkWw+ofhVImxLPu5Fetd25Pt
	LIoTUPABhgbdxAprTRdT+8hjkP6xmjMIHfvxAFxL1/it0VKZdztdC0L4lWa6NzeUZX2xDTppST9
	Y8vhOd4TsFXRYzt/40U9BgCP5/3TAJcjcgZEX
X-Gm-Gg: AYBFou291NTVHbSuZwvVDGugd58TAcKtRYwQy3BVILJz9/eCX5654i2j4I+J3zoBxnN
	gNKlr3m8RSbsIflbl4Z9yMDdfqPIQL/z0IpWL41dJxrmqJX8ic2UeEAoUVzkt/PSA5XzX+qJQrj
	EtfSajEJAE7630ULwAC2I9ubvgKH7IXBM076I+m6uCvoZIks47YD2SMDKBzhYCHnVJ5QyDGJ4oA
	pZ+ecjvpl0+/9MNH14WTkpOt8iPQMLijIH5UFU/T0kUL4ysuG91DUy7TBWSYENQxYqZiY6mZGyR
	4A/2Xllbug3eVqLfvj5kntYNfBjjiPACpSVG2zQMaFvFPin/2A1G3bJNkPlhSMBvVZiz5N9wn6d
	eGyvmltCn+uE0Ky2rcVybjoKse2j+FuBjTkgGsrRWKe7WISYXWi1xO+meC3GDqY7BGZwpyAA=
X-Received: by 2002:a17:902:d486:b0:2e9:d0fd:639c with SMTP id
 d9443c01a7336-2ee0e0dfe13mr28162615ad.55.1794580675985; Fri, 13 Nov 2026
 06:37:55 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107150433.17540-1-husainsitamuwala21@gmail.com>
 <xmqq5wy89rq6.fsf@gitster.g> <1c124d5d-790b-4d22-af22-c53573e6d2ec@gmail.com> <CANRKfoCTtHrZ233nZyYQod6JJsNXve+Lofia7=8pnum6oEPF0g@mail.gmail.com>
In-Reply-To: <CANRKfoCTtHrZ233nZyYQod6JJsNXve+Lofia7=8pnum6oEPF0g@mail.gmail.com>
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Date: Fri, 13 Nov 2026 20:07:44 +0530
X-Gm-Features: AclHuK9QTG4bxBCGGuoOOCWFwa1MF0gSruRl8sfZ0DGWLUTto3sQbbzw08Vn0NY
Message-ID: <CANRKfoBw-+J5Dhb0ONGdWRU8wv6v7TBzGxQi2nmaLrDJbB_Prg@mail.gmail.com>
Subject: Re: [PATCH] partial-clone: document promisor remote fetch ordering
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kaartic, Junio,

Junio, thank you for the review and for queueing v3. The comments on
the redundant sentence and on threading were useful.

Reading promisor_remote_get_direct() and try_promisor_remotes() for
this patch made me want to keep working on "Implement promisor remote
fetch ordering".

Kaartic, a question: from the project description I see two parts,
a client-side way to configure the order and the server advertising
its preferred order. My understanding is that the client-side part is
the smaller first step, since it does not change the protocol, but I
may be missing context. Would you suggest starting there?

Before writing any code, I will read the earlier list discussion
around 8808e61fd3 and the promisor-remote capability, so I do not
ask about things that were already settled.

Thanks,
Hussain
