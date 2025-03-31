Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D5D770E2
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743418027; cv=none; b=Tkb6xceyaKNS7C7RaUK0/AW+fuiuWb3rRGQ6lbzd2hz8EsQ//ItlWp/WIu6Qq516i3GASIe8DozCTmGIYNjx72yiiLxrLHL9jisrZK1nhEsfwh25VY06LdiSxTTCPha/DWSUYxbeFtoVR6t6B/QGvVgtzejC+AC/IgGEBRJ4q70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743418027; c=relaxed/simple;
	bh=Fhgt8F/VvXSiyzODE71puzRDT4XiiyLU1D75r3Zix84=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sGA/JSpcgdt8IOgOsNdJW3y48hCUN/Ovl+ZNZpTmZO8TwXdg63LVsRepvuPeiMKDmY4rEzDeR7YFsk6RdqVvxCzmSgKr0r/f7BhDYDC4h6nAf0GtoCq5AH2h4yJpHIndY4xf6NgcNTZgeFHVd1u2Sy8N0tDUxPVTLApiAO3gdGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LosRjFhp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LosRjFhp"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so39708355e9.0
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 03:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743418024; x=1744022824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:cc:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TeKY5/IS0N6D54x6xCupAs8msubmW3s3QN2PPiyHJiM=;
        b=LosRjFhpjXHCywQOz52xv832HQ4SLejUNMUDUr4AY2z2sNQBWENXPJzPbaZC3Yv3bs
         64wAm/mCs8H7PuPH9i+wKqjrTyKTnlq46BisfLWqS/ltO/5L/3EOxNpNX8ICtkwZ6KQm
         XQ6pXmNMOgBl7xZ9wvPzXzvrGi4U2rq8wICzLoiHetqSgZXZIqPYLPv28psgi/bAZkGp
         EYNb35ysH9FB3cLxLiL9wr5F4Y6Sw8JXN18mfTgsPo7zEsNomJ8QKs3WG7LhQ1QG9sQp
         2wSdUazlkQ4HGp+T6GEIKNaG4ynUlEik/sXmHUvgyf3v+kPGCoPjKNU3andCsSrVLmyV
         l78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743418024; x=1744022824;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TeKY5/IS0N6D54x6xCupAs8msubmW3s3QN2PPiyHJiM=;
        b=YBI4J62bsq8oRQTgLDNFzI3/1PrFHAgMnH5CUE1QhQ37PVZ5p6plVlmKYQ+hQKhalT
         6KwgfiF0Ff5b2AwXly88vSykhYze36Rkh3eyoGyJdm3PE5z6evmcB8TBLhnXbJ0ARsP3
         Lo0UYN4dYKk69VCX6TJyJXcVHj4YaIsMGZLyLM/jhQipCnVStqAveGqN6R4v5zfr1baI
         i766CERIarkWxzOoEQlDGESed5EA33AoAodI5Fj9PsMbBCp5D81A/Ivp0EC91OXxpBvr
         cacqJk3mXolLYtjotc9GciPXuurJ9+Xip7mvduqDRHg8u7eChNhUApe77y6MP+txLuyF
         YEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGf54n2w2RbexUWZJ2fxCX1iqvxQpkM+VO9kGLP76PPjQtdc0qnAqwIihrE8Pmslw2jow=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh21QVLIdX0C/ejjMSdJD99HdaHRkXoMbiBz3FwZxP16snvpHl
	7h5h2tziOswz21VhBUK/yL4uBinJN2g8qOKK/SqCQ82XGQDVWsyp
X-Gm-Gg: ASbGncuZGHf9IseDVJLCprJhm83fQaJ9q+EkGqx787mMdAKzC4e+AzGXiO3oT7tUJ7j
	X/uPD6jYgbV3tv2mfSjubdRCBuil0Q+Rkk92jQdg5dq0xa+4VhJU1ThOH+iXz0sivtU+Dwdp0bS
	ekF6Oorfo76FCKRvNEMYSLRIa+3/JqaPheJGGekIGc3+Fle3xyAURJD0QGPXIVHatY0gRAnWRR5
	ALZkOFhOotxN2bBYapEKQD9VPMsZjOxE4gTpiy2aLK4eFejfKLwS6fHmriwnalQg1f+Qpi8yejk
	1GePteqJIt0F8PpNmRYNLaZPwzmOyRYkIZUs+FjH7CzwYyowU4YkIt4ZaOSUJWjih2U3p//UXTD
	NUVBPJ0eOxr/mAwTBAUCQJlYketUjlA==
X-Google-Smtp-Source: AGHT+IHDqIUtjEe9trYiMevXtu4yWSy4RD3lMxvusW4q2EBw9jFd1ZZ7WWTISaTGUzzSlOwqbSQmxA==
X-Received: by 2002:a05:600c:4705:b0:43c:fffc:7855 with SMTP id 5b1f17b1804b1-43db6249861mr77276465e9.15.1743418023674;
        Mon, 31 Mar 2025 03:47:03 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:34d3:7424:2534:e481? ([2a0a:ef40:700:a501:34d3:7424:2534:e481])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efdff2sm161111295e9.17.2025.03.31.03.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 03:47:03 -0700 (PDT)
Message-ID: <acac3dc0-deaf-44f5-a568-2de3060fecf2@gmail.com>
Date: Mon, 31 Mar 2025 11:47:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] blame: print unblamable and ignored commits in
 porcelain mode
From: Phillip Wood <phillip.wood123@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com,
 gitster@pobox.com, sunshine@sunshineco.com, Patrick Steinhardt <ps@pks.im>,
 Toon Claes <toon@iotcl.com>
Reply-To: phillip.wood@dunelm.org.uk
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <20250330204339.191382-1-karthik.188@gmail.com>
 <72b19ccb-a6a8-4aca-b70e-b879ec15cff1@gmail.com>
Content-Language: en-US
In-Reply-To: <72b19ccb-a6a8-4aca-b70e-b879ec15cff1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/03/2025 11:24, phillip.wood123@gmail.com wrote:
 >
 > (the normal backslash escapes are > allowed in the pattern though so 
the '\t' is fine).

Sorry that's wrong, you need to use a literal tab character instead of '\t'

Best Wishes

Phillip

