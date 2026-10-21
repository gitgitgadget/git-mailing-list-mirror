Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792597370;
	b=EQRPQvVHtXxvjsvs0o355gYJQpLuVvTdWgQ7QiHrOW2xFJVMGmEXbeETInEM19aDOGoY
	 h7KW7ME6K+sghcsqqMq3ahoCTXemq0+R2SvTPfP4tRETP4jAUK5I9bp+o2mzg6O8JAc8H
	 xVj++mdLre2Tg+VN46R2PkVWCauk2nbgoGL4/Vc3nmZ0HC9m6s/i7PTm4NCd1Rd97e52c
	 oI0L5Rt2RiW+Mp203SxMI+VQVevZ8LyCtV+JgoOJ6YtKnvRRvTJFTcqO1h5sO/hO0Y3Gc
	 z39Xiu4v69ZaqoFkKFs0UXH5qdJALyXVbeFmPYL++tbcjYsXApK4Gcn1dmjuuDZ1q8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=Hwe4wx55Qw3c9y5HfK1Q+FrFdWUJVRvJt2IWUXwMh7I=;
	b=z2TR9BZNShaUeC8zYpz+yr2FV6VO6GQNn/PLysAWB7mi+9Cn/ErEiD4HLzVt64A8wBsP
	 bEqESkr5iweBXTj0pEau0+LI1u7DHNtoOvU9iosNLWmBcpjd086ic6Lj/ms9G7pnWsyy2
	 iaBAFP7wc6H3UtEx7yjq2B47r+V9iGE01ubcC5fuYg45YhU837okvUZTXMJuDSZFLmxXB
	 UnWvmaPEfmPXIu6wlJ0UaR4jgbNcPnDeGlQMKmmMk8Oza7Ax2Ynh8FyiwAkeKyzQUhgCF
	 NFRJAWRLu1CeHkg/CjjAR+9WRxS3Fy6MQC+J4jTy1RLvkBJ6P2Q0RNfxSzdb5f0gsug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=spndHo+4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F68606A31B
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 15:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19F68606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=spndHo+4
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6740e7ae219so767081d50.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 08:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792597369; cv=none;
        d=google.com; s=arc-20260327;
        b=C7evMPAC3hx3SbLEWTIxm5LNDrIvd+2bf0yGHgVl8mpaQ1+vsQifmQjZLl3n6wgXtB
         i+ATXWDfofxWN+2nqFaXFsnLa6C1rH0rU3WuCgbqweXx0FXxnMejNfiHBnwmAcp4Gl6m
         rq9Y2XQbXEP2O+zkbDPBMbkkd5EySg5RafvezvJYPZaTGOX2/JqBw7Ar9gBVRE8GZlil
         nC823etfwJkJjCdxY0hHWZGNbJXTkBIosd7CNBJH5W/1NJ8p+tfd9HnM8Fj6edbeWZaK
         37L67ab1lo76uIVRAUkewIJ4KJ1Nk3/5l+zphdK2sywctkD4eUxUk9z2KFvp1wbJ8tEV
         2uuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Hwe4wx55Qw3c9y5HfK1Q+FrFdWUJVRvJt2IWUXwMh7I=;
        fh=/j+vG27rf687elonHcL0kgOXGizcEL1Ld9TZlUvLLDs=;
        b=FaUFkMWsjQvYxPE0SL4M1CVnVivEnh+93fVlKDgMHwyc4WXQjprhrJbSMBTZmxPAkS
         ozKbMDW+L6lu38KSj5snA391XS/gnu5QeAxf582GjSy19NahjJuyYxzPjMngq4jRk1+A
         F3f7WYuACdq95btYHxb0YAhKCpAwLbBFEP9/B8XO4OLCNi6e44G7O7iMIr8gwxLVU6LR
         WrL/VIMz2mzgnR8RS7boNP/1PiUnm9nRLChDvYKkLZg6y9WHuC+4U1Zus7bC4yrindd5
         CFgU9AC1groU6UvMORRVa2g1WdWb4UGYHvQ+rsIqGzPUgxUjjxEBlJM3eqLDt6xsnO+O
         3V+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792597369; x=1793202169; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hwe4wx55Qw3c9y5HfK1Q+FrFdWUJVRvJt2IWUXwMh7I=;
        b=spndHo+4kVCb8rHHpLYambzRFEuYGfVHlgJHxgHpWXF+8ifHTwAFOdppPjtY8N0jkV
         psTc0KCSleTZskCuL6fyR2GgVE6aF76StF93ZMJLgVZrFXC0CnFKRQjqlVnaq1pajlFk
         +hpMAijF4587hCHHKqq8kqJykYFYSrQfpc8an7Rjfzq4c2WpEWNcrlv5PVyoXDMlNJMT
         s9+HI3XH7rrbgr7dK6M+ftivdiuOPdB2v1K4MEVrEX02D/LJthfUqoyxIFRY96s92C69
         +tkwcNtUoN5Ho20c6JKo2lsDHkHfSpUFC52dNGhNhKkzZF8lLMEDWgDolUgOg6/h0Gkt
         ohUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792597369; x=1793202169;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hwe4wx55Qw3c9y5HfK1Q+FrFdWUJVRvJt2IWUXwMh7I=;
        b=JvzcqbTET09d7CL8LGGHehFfXn4GRLaw3XJDKYYlKx0snVqdiRBlXovblzuIRA7XFX
         3mHOeokMkmn1xLxv24nFztDNRSKofIio/T2fHhQ/OYbqsX5AAt8baOeNntSomzerZR3K
         n5X3TTgyrnBanYe62s82AIQSvewrz6I2QAlw4yXzUiJeH4VdOIyiSUZV4fBWkS8bY7hk
         q9oEMWCDWQ6wH22hiUAmAWLTNSLFnk6U0jAdXWW2ga247jT+PRpkpjfv0DQ4Gcf6UZAH
         BzK5oA7zAWfW7llBV3p/+0R4wKHBQ+EHZtEphQ2EeRduQ/9seNgos0ExeEHJHlIZAr3Q
         yBbw==
X-Gm-Message-State: AFq9FYKiyNtOd1oy5INlV8876P0ENJ9R8k9+aql34KiOCFHeEW+rBVbT
	Y0IzwdPMayBtb9rqAr7iZPDUDDJWefuWzbL7sSuq/Tmqx00KB9CniOWjOl3qogIt2n8w3XdpETC
	jSVn47sZDM/XE1WdFNM+jzCJSfQ+1Au2YRlvbA/c=
X-Gm-Gg: AYBFou1g1rVVjleVdLDs1ezO3ZvdgI72ENcchv+UTBk30/yck48CiqBrvk6J8S93pDf
	1b77SHbFNc8ttq4lC/0Iq4JhnJ9SZjSu3Z42BRFe3Dpo9eY79cETdQZ1ZhJijoVe5FVWFxo58Mj
	FwGv1hqMzwoL6/lNgAF+g1+MmMhw9VTXWwxcnaJ48swYTFas1W+pNqA7HUO1tOoQ0XxscmKj+Vw
	YewVxgfeRJHoimYEquK8ZnirWZRiLkxgEUdfJSeMaSYLYz3t7MONTUt56CovbKeiVQ3CyCtItX/
	/BtvltD4yzh6ok3Ir/1OAZGqYy9zDEVhGeDloSp52bEJOmz+wfaoyvEmJgvLZxaMigVrItvG8Ur
	6Wn2qOpVmPbF/ODLCW5T6gXpqmSRJnh5YugVcZI8Cj09idvaXGjZzk2MjaG5q8fVVJw3ik7Q=
X-Received: by 2002:a05:690e:4142:b0:679:2a5f:52d6 with SMTP id
 956f58d0204a3-67a1fe8bfe2mr85304d50.91.1792597368849; Wed, 21 Oct 2026
 08:42:48 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021151253.3689-1-azuama69@gmail.com>
In-Reply-To: <20261021151253.3689-1-azuama69@gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Wed, 21 Oct 2026 21:12:37 +0530
X-Gm-Features: AclHuK99JBx2k7YobnEtXjppxBXQJ2FbFjjzt4newj8eLvO5YHvWS2V3y_MgSFE
Message-ID: <CALE2CrT=D8P6SksOyBudiF1En+mshxw=vdVU6KLApT0AY_ExsA@mail.gmail.com>
Subject: Re: [PATCH] rev-list: skip --grep argument in early scan
To: Azuama Odinaka Maximus <azuama69@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for the patch!

One thing I noticed is that the commit message doesn't have a description.
Could you add a bit of context about the issue you're fixing and why this
change is needed? It'll make it easier for others to understand the reason
behind the patch.

> +               } else if (!strcmp(arg, "--grep")) {
> +                       i++;

Also, could you check if the first scan needs similar handling? With --grep
--exclude-promisor-objects, the first scan might treat
--exclude-promisor-objects
as an option instead of the pattern argument to --grep. A test for this case
would help confirm whether the fix covers both scans.

Thanks!

- Pushkar
