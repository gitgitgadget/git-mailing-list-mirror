Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792614813;
	b=fY3atS14oV52NPKawNllwgwFjpizPYeKk2fZzTX6DbC3UzHWvJmOhnVNY2g7ULHW200Y
	 NugtOfQnabRcJ589Rm9hIEzibYlDIaJT66Y2YQfmbewdZTM/w3uTnLQtSwaUR8BGALAQ7
	 VWLF7+PcNxw7obM40dtsyIXqN7Sn4uydnVKWwm/4ueAazykheDagDs3d31np7rk2LPSQb
	 34Da+3HtXSdh/jDgQ58zASSrL3szNHzYff1I51BjP0YQOyecX6FM89KaMNI0uHDwASFKY
	 4n6nQTS4mbbAl5ETfDRpaWcHGf0DrGxPkAv2CbRhawvpYoE33OwaK3NwKzLVppza1Nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=mHNq0Izuo1exU24dW/P+PnVqOjQXaB7o2Rx4ltACKws=;
	b=ytdeeiu6y7p8mn/X/YQ9JczW8cRSK8VWJH7Pacfft9Z/ATF3fLNvwMLSR/58BOr7XBY3
	 3BPxQgJR/TQdB33xkj8UnF5eBY4Np9wFMp9or14wbbXVKFcGjZ6hbrN8hvgxLDKxH7OZk
	 0MtuDqP1V5Zk7GK/mfNQ1/qeaR+JmJwmSqpdTGxj2evUxvvD3/739PJKfLkusVzb5+oii
	 kJCA0k7MgeeDSb+JBR9tAjKj3aBISEfmtgHt1IGynzB8kxzp/moM9i4MvZPXsTU/dwtbv
	 iHAvnw/7QSWakAl9f29plMCo/oJMdS4oEXkNP+SHAkVNxnqtQsiY8s+XRrnT95b/CEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TjaDghNr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2D6606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 20:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF2D6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TjaDghNr
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6de1fd5f572so533847eaf.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 13:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792614812; cv=none;
        d=google.com; s=arc-20260327;
        b=bQhwD3AYX9IR1/TfB+BgqA9/f/NaRtUCkysI22pdVCPBWMeDM4vJcDWQy1aLJvamAq
         13GYBYErpMEiDV6bHD2QrdcutIZ0rixCM/Bo1OJfHbYwxEY7EukO3FQ8VC1CgiYob4lJ
         /55bbPuw8XR9WcbPKs2zUkc0jDwIuj7C7FxbBv7qChaVV69Ab+WzmFx2saY4SWyYxM0x
         gvsQzW2dlJvcA87Lxp4WlPHBeAC+s5e/ZAlzumtlH5WCeEbPLi6pz6USiiWOQPtAJGvt
         bJLqvcR7Q0+uat6Rn9RTVGwsiFXfAaQe5TzOt0cQ2kPjRNOM5AfmYKkyhOmFivzdJTNV
         euFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mHNq0Izuo1exU24dW/P+PnVqOjQXaB7o2Rx4ltACKws=;
        fh=8/LjS1uJ58dEL5DQauw5WUcHah9WtaFwABlDy1dweIQ=;
        b=goaGXpBWteeW1+S/kaqdUEHfyDW1YvEFvNfj77s7rLTFIrmPL5ZVVoDlEgkAlzXCpd
         +zTqpHEBgDFCRPgfD13sGtzdXfYiTDJYPiUSj3koKAWlbIyNaFEOlWvhQIQDzAdmFZvA
         g113Q5f9ToQrSTCpK7hfWt4LNezSArYbkyZNZIZS2LtFXQQ/lxKV8l8LAEN2lwVzv9Y2
         VvlhBzIvtCQi14PUBSZCNmDArGdy84dttccqcTmjl/UjriW7fSdenMcq6Fy0vGIEDWk/
         oXF/JEV4rrhRPuDghnbJwJ9Mu3oGACjtpZs8dY+P9hOfuN/LsDN154Zf3bOYduk8NJ33
         Oj/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792614812; x=1793219612; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mHNq0Izuo1exU24dW/P+PnVqOjQXaB7o2Rx4ltACKws=;
        b=TjaDghNrtkyLAxhO+8FNGMJTZTU3mQCVYT5eUdZLKx6njEY0EapzmlWwfvsgMch4Qt
         oD81guV4W7UtWBiQERZXOTO+6a8um5o/Y1ro02kwxWvtUtJCRi9TFInxZlKoI+ayAMYl
         c5+kPDL3nWk054xNI48MA4Kv2Bp1Qel8LH6fGFxpWUeYLecvcZLYoe+HrXOZ82I6HI5r
         xXG75xun7iF9YshcqyYX1TLfsGvrI+GGmCDOU7/MZpjuGRvsra6r2xa1orKqy9JvQrmP
         3sFoxyvhaU/7GhnfJwCLRL/hCaj94TdUSr1mEc38rmb11qov50PjTMcjcn7CUFZTewcW
         mgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792614812; x=1793219612;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mHNq0Izuo1exU24dW/P+PnVqOjQXaB7o2Rx4ltACKws=;
        b=kk8Cqo6nTQ1sQz4xkJregDKB4jrJQD7KwQKjPci2x0E9hCkC/BORJQ4OQgxOXpOVET
         dfoTqiZ5veIOcNXFuZ/T1tS1pYxXaokru2bC34psgNJoMZA2iw2GKLUiFgP4Dn090R4o
         LUdkSosWuYevFqUDZeQ3rFwua6E2CUHasIR79TjUKZvt0M0AU3qzfKbeH4m1/tuxIHiV
         Hykgy3xDx2WhExN67bTWOK/qJWe/GPUghjZVVxb49zpAsLwtJX98VRoOAL2gqvgfXVO2
         KyepWYClLHrFhBAPn3OECXJ5z0bVSn6oJ5nJO2NF8t4iVzl1DWJsuG0xe1diGYRYYwR4
         PHRA==
X-Forwarded-Encrypted: i=1; AKwUvByLhKoe+HaVhUzEwQyJuQhd0xMF8sc3iGMAbpjHHHaVB30EBhe57g/K1aNlsjJSA6maUk0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJaMRRZqUmn2wsfP+Fn+M1wtKC+xaAO619oUjksBp4IsuQt/bi
	cOwqY/L3CQmmC8lq8v8U38Gd4ZlfUPofzZJh+1hLgb7Lzmu0DE5lKylPxesM27L713mu8mCtqxA
	PVRlXl1zPpLSFNIZP8gAwdoIgE/Fml0I=
X-Gm-Gg: AYBFou1AELuLi4LhBYCcYeWTy4lBJ5FWQylAiQJmrs05/6qsqkx1+6sbaGuTY4wvecI
	jKOFmBGrcEkl8apSx4RQtm+QyupwWEid/ZPJczav+/1aGb6LfXquAcfE4IBmhPBwn9OMoNTtrAb
	u2k19hp21ZdIaUbCwlooixuz27S32xvDO/YoS0gbUQ20xsiV/KXRsJYwnfW8wHwry9pl4Uf6fj5
	3WLLx3zVzz9JAYvbPT3Urqyozv9Wsky+QLvX6eQyTDP0q1qHLv3mq6EL1+wjqogDqYh/NQlI/y9
	dQ2DzvYlXsVrW+2CdXfbj0v7GC44MZ80Yqr5iYyH3XxwrNIog1XT9bDjL+13k6q2epxOyUGlF5O
	8dQpUyCqcTN0TqWLAiHTqNBZrGjUzFCSJz/Lw9uyASZysXhjoZFgwq2+pzbgczmXud6mfVOa1yX
	ZLS/2emQeqLtVCwMMaeTOmpMyMOfe8+A/jilZZlAkP0sB7xuCibzJB9Cg=
X-Received: by 2002:a05:6820:1789:b0:6d7:a13d:fd7b with SMTP id
 006d021491bc7-7093fcba6dbmr1673278eaf.28.1792614811901; Wed, 21 Oct 2026
 13:33:31 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAO=0-S64w=n47n6yfYoKJie2aFi+T88Sp_qPmFe2RW0xWEwcdQ@mail.gmail.com>
 <20261021110616.Wxkhc%taahol@utu.fi>
In-Reply-To: <20261021110616.Wxkhc%taahol@utu.fi>
From: Tanga Joris <tangajoris@gmail.com>
Date: Wed, 21 Oct 2026 23:32:54 +0300
X-Gm-Features: AclHuK93D3qHH4-r8HPRmHHtf5Qty9tH-mJp-KbLdf5U96NR2_ITVQSf2OHRCPQ
Message-ID: <CAKrRMNrrsa2iwb-0D=FfzNAwyLTJtLbVEN69vu7sBRWOKheZ_A@mail.gmail.com>
Subject: Re: [Outreachy] Microproject: use Q_() in builtin/checkout.c
To: Tuomas Ahola <taahol@utu.fi>
Cc: Muritala Mudi <ibnmuhyideen95@gmail.com>, git@vger.kernel.org, 
	christian.couder@gmail.com, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 14:13, Tuomas Ahola <taahol@utu.fi> wrote:
> You can reply to [1], giving a review on the patch. Perhaps you could even
> nudge the author to take care of line 1492, too, whilst you can write and
> submit patches for the other cases you had found.

Tuomas, thank you for pointing to my patch. I'd be happy to take
care of line 1492 in v2 of my patch. Mudi, as Tuomas suggested,
line 1405 and the similar messages in builtin/worktree.c are yours,
and reviews of my patch are welcome:)

Thanks,
Tanga
