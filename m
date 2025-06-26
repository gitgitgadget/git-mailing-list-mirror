Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608B42F1FCD
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750899654; cv=none; b=sa7LMv1fne+kevlycLo/ZhDfAVVbA6R2prl1Hmkwpb473WseNiPeG4tcnozjWwPB1P3U2AkDUDQ5Gj3rMFBJujVcYcT3zNEN4/eCYgM+dW2d4Ho6AOnRaHJY6ascvOJbEMwFJxkvSuA01FoBUE82laV0p1+tuhqtMYYHueWi8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750899654; c=relaxed/simple;
	bh=RB8Brf3+Fo3h2/w5Zzma8CHPKrQzDjNXqHtNf4qhXkg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=l26AlZyg94MBUKMauCBfXsVxtuSlQMy8oe94w3OgbvGciRElfXt3PLJBcNhDRrALLOHmD67hg5jeHgXBdBxjp3wjSsI3kWbebBs7XYeoHjc2u9X6ZuKy3HBf1wMro9Bq0c4kf8Z7Nv0qGy91Ev/P0JU4CUI4TlrInv9NgTwz7rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBAgrcA7; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBAgrcA7"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2e8f8cb8466so67399fac.2
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 18:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750899652; x=1751504452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RB8Brf3+Fo3h2/w5Zzma8CHPKrQzDjNXqHtNf4qhXkg=;
        b=NBAgrcA7nCHB6oD248+tRQx9+TKvbs1LK2+7HIjX5HgtYquMpvmLcN+NYkBEZ2oeCm
         coZv/ymiWvpTFSOCIQ9dyZvYVHeVoB6b5SLTmkir0Ol62pCdZ2IW98Nh9tNlBNMKXDLM
         EiZ5BP8C4VcnnpBED70/zXkoZabbkleiQDZVTb+MjGFo8O/I/yXd4WUKFBoUaJzBtEXD
         JhtXzpFHGrIb0+QUU2WMc1Q/0HV1grg7n4Ilp+b8xBIO1u1thghJVPsuj108hjN+KS5u
         s55f43XFGn2WFoeTPgu39H+m+yHlmeipDcDbig6oVVqH/Q7nIHBP1NzV9vmPCMDVpV5Y
         4IeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750899652; x=1751504452;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RB8Brf3+Fo3h2/w5Zzma8CHPKrQzDjNXqHtNf4qhXkg=;
        b=PB0sRdTsGq0thFd42bF1nU7BYBK90qdsWAcgxwtuNafqBAxVTSxtXM6zSm3gmpkiFy
         JjmKNsOsjHX2AIBxnWveN1AL+ee5g4Kr2JfiIYSgaAejwSZm8plsUCbW9lAW0JoldvTU
         sxzb1reMAfKNrgBJ+jtDYXEtnXGIrE2VNAKril1H/gZgZaLE2s3ymxXvIjKJzCs/XkYt
         kXhMeJl75/5E1Ol/cPv6cmWTjCEDY8WWMoT+3FS62T+iNd8HcUscXuG6pjN7P5hlaiIl
         zy/F+Jl6u8/5KK7pJyDgFXj6hx+0vhD2IY/yLZU8ebbpORYx+pDi5WqBLwr7t/QFH3gf
         p3LQ==
X-Gm-Message-State: AOJu0YyR+e8n+LLFGL6KK/A0TK0IpXRS2lqUBQoylhJ5RkCcv+jc9q8n
	IvVTJQkAwH16tUlkYZdsGK1nQQbI3ILhjHDpnkcU0DeCm0PL6FyvLH20E2DljCbmTkrjdjUXope
	Zpy9f40tDm5pCacQ4TGnRuGG5d4u/zqN6mg==
X-Gm-Gg: ASbGncs26FLyqp6JU0J0K5PVNv+0yFiLn8eGjhieuU0QIyI7X6gBY0bDesc6mVS3CyP
	ZdHPCTziexSjMne4tQ/pRe9ZtdfEaHcSEKLdjG3uOjHGKl92xqj7rPFJTea12VyjHl9FOEjzo3D
	RdOsXARRlSdR0qLNM0tREzltYXh1+85mD7ang5UKZSkm8=
X-Google-Smtp-Source: AGHT+IEHff0Z9H/F2bakY/VU/tF3C5rbYC7rkzA3P2aysqLrYCeU5vz9yvJFJanOuGGc+IrZD03/ZMDsZ4oy4RIWwPE=
X-Received: by 2002:a05:6808:d4e:b0:403:519f:95df with SMTP id
 5614622812f47-40b05730af9mr1491893b6e.1.1750899652419; Wed, 25 Jun 2025
 18:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ryenus <ryenus@gmail.com>
Date: Thu, 26 Jun 2025 09:00:41 +0800
X-Gm-Features: Ac12FXyeTrBNRSMUOmB6xvzXmB77P2pY2APH0KVbRBKtXJwn1bUsvGYFFC3kaUM
Message-ID: <CAKkAvax27W-0qSff2rcmU6SR5sXsqSRms_37gGkfnfwU13ZCrQ@mail.gmail.com>
Subject: Re: [bug] pull --prune could not delete references due to lock file
 already exists error
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

maybe just prefix each lock file with something like a unique sequence number?
