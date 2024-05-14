Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DC2181BA9
	for <git@vger.kernel.org>; Tue, 14 May 2024 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715723112; cv=none; b=mmgeYidKJvncff9/CEm+0dLNHPVJr/nbW0SFkyxPFDpQCPhyo9Oi9r/hN9ID2ZFB3cercW7FTUbeKFfQU2dvmppV08UjihSil6ckZj9nUyGI4JH1zIZgysZXmOTZ0a83plnt3XNqejNXPZD2ynjU3fPY7al9rfHkwPR2jsHlkbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715723112; c=relaxed/simple;
	bh=NMRq3NHS1RaBochdsN3G36zY5ERKhVn5/Vu58VumJWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9GlCTI7JJT0ryPZrUcvz4kpCtvMUSSpv3j86zvw7QiBT4yM0RFZWEkD3p9Hpngl0/J1wWE72ES41PdtRTZ8gLuQ7ZiOC3hStFa+K72iUlrCBqSu1yAd1foRXcxETnLC4U8ysmv0wvMnfLpabOdS5Tat+9T+9wnSHnKQQtRRDaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=d7/0C6T8; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="d7/0C6T8"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c96a298d5aso3387580b6e.3
        for <git@vger.kernel.org>; Tue, 14 May 2024 14:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715723110; x=1716327910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ctTM93g9328HTFHiDkK68ww2Vqq3Cz0oDYIxWT5y158=;
        b=d7/0C6T8QxdsfxhsM9aot4cNI/0Q6oY1SIV0MgMjAIi9PAKChjYAHAxOV61COyFQjq
         Vqq0yoN2mJ6zawYwoO3XSmapFeMo02+nmSzl+OYFgHGAOYL7g+lOOv6tdV3GHJwfTCph
         1KBKfM8klzK/NjhjE7/nwbbT5ZufkIcu6z9HeMmsCLwAhXMB5YIMiYbl9AyqH1kTaIkd
         qXyrHOv2+blfNzE2csjw+yK79uWwzXv2di1PGjy8+gBNtHMshFLFpUGbXvph4e4RA1Vb
         d4F0D3513XNjo3Mk3S+/WZME+5pubJD/KxP/RxqCjD9Upe9jyXyYv2c0RZIwW3iU/EKO
         BREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715723110; x=1716327910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctTM93g9328HTFHiDkK68ww2Vqq3Cz0oDYIxWT5y158=;
        b=jayK57GjmkYzLaASMu/4eUmEqHNHGlW0DHZ8m3e0+T2uWyCg6wteScJ+iEDMDaxVfl
         VOWhBs952hM/FzedB2M83eCRPDT3hUD/V+9rypcC6ScRxxIHU022L+Ts8p9aMj+n4oFJ
         pBgvz46+rpRz6MlENiOMxNdQxBLzv99BKWm8w4tKONnvMgSkbRdr7At+h7x5f39sMp0R
         KBTEs4dfI7woQZSiJXzLG5Rs0LuYZ2lUZyOZTR0pAcx7gvwZZnZG2we7c8Lld1SuBItF
         syZl5GqgVBmASWnxI1RCxGSmQN2mYGzgTfisPVqkFpt+ytNk2SUo4HcZ4DYCxQpvp9pf
         D5CA==
X-Gm-Message-State: AOJu0YzX4ypUWmcplNirVDawmFNweWILuuf0VxoQdyjxLyPnEe51eLgx
	cNoxGl7aJlkypfVSnq4wOioSJy7RBAAC27w1fCOOhcZuvfmut3+cl4oZaYT2qjE=
X-Google-Smtp-Source: AGHT+IFbCnfgpewjjJ69oa4lOKzRGoR9TiJpPbw6r+3IHG4EXr4iHlGmnM0ViohwloXTXBB9sYgMWg==
X-Received: by 2002:a05:6808:3ab:b0:3c9:68bd:5786 with SMTP id 5614622812f47-3c9970cec70mr17883134b6e.45.1715723110123;
        Tue, 14 May 2024 14:45:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf340b32sm611934185a.126.2024.05.14.14.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 14:45:09 -0700 (PDT)
Date: Tue, 14 May 2024 17:45:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 06/21] builtin/config: check for writeability after
 source is set up
Message-ID: <ZkPbZGPq6xFrhngN@nand.local>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
 <7ab99a27c16718ad4dff1f7862e80c52b48c3812.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ab99a27c16718ad4dff1f7862e80c52b48c3812.1715595550.git.ps@pks.im>

On Mon, May 13, 2024 at 12:22:28PM +0200, Patrick Steinhardt wrote:
> diff --git a/builtin/config.c b/builtin/config.c
> index 0842e4f198..9866d1a055 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -843,7 +843,6 @@ static int cmd_config_set(int argc, const char **argv, const char *prefix)
>
>  	argc = parse_options(argc, argv, prefix, opts, builtin_config_set_usage,
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
> -	check_write();
>  	check_argc(argc, 2, 2);
>
>  	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
> @@ -856,6 +855,7 @@ static int cmd_config_set(int argc, const char **argv, const char *prefix)
>  	comment = git_config_prepare_comment_string(comment_arg);
>
>  	handle_config_location(prefix);
> +	check_write();
>
>  	value = normalize_value(argv[0], argv[1], &default_kvi);

Nice catch.

I thought about suggesting that check_write() could be inlined into
handle_config_location(). But that is not a good idea, since we only
care about calling check_write() when we are actually going to write
something.

In the spots outside of cmd_config_actions() where we explicitly call
check_write(), we do so because we know we're about to write something
(e.g., from cmd_config_set(), cmd_config_unset(), etc.).

But in the classic mode we only want to call check_write() when the
action selected tells us that we're going to write something.

I do wonder if we could set some "initialized" bit on the
given_config_source variable so that it is a BUG() to call check_write()
before it is set.

Thanks,
Taylor
