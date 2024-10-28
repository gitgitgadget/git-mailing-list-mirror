Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14B4186E27
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133494; cv=none; b=iyZD9rx8bxlo65of8d9JP3p+bFHIkv7EvGKyJlKDTwjrOpmEVfBBQreAUG+p40piMU3OCJVW0+mX5TXv/HS3UVh07FL5wr97/p7YT4+WBOluO+y2PHw/x+5E4wtinKEswr5zgctEJwBgni2O04Iu4LtSEO/rMhH/fand96NLUgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133494; c=relaxed/simple;
	bh=mJdvevvsJiY47yGOYBjciNNy6pS5RH0HRTk366k9eGM=;
	h=From:Date:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgAUhmdm0wcg+9QCjbflEdamb48V+Wj8koZMHEmffecGloli+eX9K4sZ9D9c1hXvwHGexb7OFqwU6eUyjvqNbFiMqxyLl6C01uArJqZuY+FgbpZsDt5i2NDVDf/ovCX8vEa8D9v4J2bR2pNIer9aU5ASpMA2LoYvB5XmAbT1qjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ngIed3nN; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ngIed3nN"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e29267b4dc4so4617338276.0
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730133491; x=1730738291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXbULzGi+M1GD79KseRp1g8Wie1a9olP7ahUJoMej+M=;
        b=ngIed3nNJI8b6ZqhI8Q/NG1JcTpZP5x/NP84AxsjypnykHT9DrbEUC5rmA4VmtGfch
         PI8W/dNvggo/rE9vJVEFrXTs3h2rP/juHxHrB8w+1nW/lXlp/k9qxtM3lEZqmmDOcryy
         nDJcXGU/nQU3G/t4g7xE/0OCGap04a3grpBAEwd+cqgW6b2GO81MpjPStvKdUGPx9s3h
         jel3Sa3A4BpWCWRXCaiNt5fFC0k0sQ3bfbKJqjqdld/MPFR6Nr4Ffy+djY/5HovCLsom
         kRXJbyIQiuAgEA+RpNWlIMupV5l8Z27jZv4O15PsayiUGmfYV7nBpBJw1YKh7nm1KTzF
         phuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133491; x=1730738291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXbULzGi+M1GD79KseRp1g8Wie1a9olP7ahUJoMej+M=;
        b=C2Wyd8f+rn5lwpvA7tWUzwAX0Ef6OgDXjQUq+ptleydQyLu/oAgDyQ0eRcHU9ihRQw
         AZQjzQL5gyJV12yhQ5/noNX7avtuUqwUd0M30SXZ7cQwpO0pvK6wZtFYI74mQDMAbODf
         ppVDOfIQdPJgJqIsTrtXZfG7ofcgE77Y6yEuWTdFaTvIvH+B99y6+1p/dFyI9slShQx9
         Ymu0N3/C8Ch5pcwvvOaIbMxknlK9990XQRC0ubowYI04HEmFyb4iHRj8FdEZFtQb8HMz
         RiUM1QfVzbnkGPDLQSZUzZlQPRRII9kH9J2VuDm52flQtDaFk54lEAKhZLVdQDfM5zQZ
         biOQ==
X-Gm-Message-State: AOJu0YzH4qmXCeeWfQVK9yocqTWAzmW4crknLg7zQ8KRa1PP+s2gIdmK
	KsdVg2XtCaRNj89yK4sLYRf0y9C6TAQO9DZKcRO1EtfDDs8nkSKLJ8YPJmo0ET7GHwdhARDhD0o
	PZRw=
X-Google-Smtp-Source: AGHT+IHW8biS6afNdKc9Uq8/xbHW1+vM+OwTTFc2wgasRLc/KgjnHjCODogwTNvUzDAXFOoobgk4cQ==
X-Received: by 2002:a05:690c:998f:b0:6e2:ada7:ab3e with SMTP id 00721157ae682-6e9d8b3c758mr96693867b3.30.1730133490503;
        Mon, 28 Oct 2024 09:38:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6bdbffesm14984927b3.38.2024.10.28.09.38.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:38:10 -0700 (PDT)
From: me@ttaylorr.com
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>, To: Karthik Nayak <karthik.188@gmail.com>;
Date: Mon, 28 Oct 2024 12:38:08 -0400
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] config: make `delta_base_cache_limit` a
 non-global variable
Message-ID: <Zx+98PYOONmoA4A7@nand.local>
References: <cover.1730122499.git.karthik.188@gmail.com>
 <89ee3f48ce982236dd7841fa1a5cb15aa256b901.1730122499.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89ee3f48ce982236dd7841fa1a5cb15aa256b901.1730122499.git.karthik.188@gmail.com>

On Mon, Oct 28, 2024 at 02:43:45PM +0100, Karthik Nayak wrote:
> The `delta_base_cache_limit` variable is a global config variable used
> by multiple subsystems. Let's make this non-global, by adding this
> variable to the stack of each of the subsystems where it is used.
>
> In `gc.c` we add it to the `gc_config` struct and also the constructor
> function. In `index-pack.c` we add it to the `pack_idx_option` struct
> and its constructor. Finally, in `packfile.c` we dynamically retrieve
> this value from the repository config, since the value is only used once
> in the entire subsystem.

OK. Perhaps I am not quite following why this change is necessary, at
least in the context of the rest of this series. But let's read on...

> @@ -1604,6 +1604,10 @@ static int git_index_pack_config(const char *k, const char *v,
>  		else
>  			opts->flags &= ~WRITE_REV;

Not a huge deal, and not the fault of your patch here, but the
if(!strcmp(k, "pack.writereverseindex")) block should terminate with a
"return 0".

> +	if (!strcmp(k, "core.deltabasecachelimit")) {
> +		opts->delta_base_cache_limit = git_config_ulong(k, v, ctx->kvi);
> +		return 0;

But here you do 'return 0;' at the end of handling the
'core.deltabasecachelimit' configuration value. Good.

> diff --git a/config.c b/config.c
> index a11bb85da3..728ef98e42 100644
> --- a/config.c
> +++ b/config.c
> @@ -1515,11 +1515,6 @@ static int git_default_core_config(const char *var, const char *value,
>  		return 0;
>  	}
>
> -	if (!strcmp(var, "core.deltabasecachelimit")) {
> -		delta_base_cache_limit = git_config_ulong(var, value, ctx->kvi);
> -		return 0;
> -	}
> -

This is safe to drop from git_default_core_config() because the static
variable from environment.h is gone, so nobody is accidentally reading
an zero'd value.

> diff --git a/pack-objects.h b/pack-objects.h
> index b9898a4e64..3f6f504203 100644
> --- a/pack-objects.h
> +++ b/pack-objects.h
> @@ -7,7 +7,8 @@
>
>  struct repository;
>
> -#define DEFAULT_DELTA_CACHE_SIZE (256 * 1024 * 1024)
> +#define DEFAULT_DELTA_CACHE_SIZE       (256 * 1024 * 1024)
> +#define DEFAULT_DELTA_BASE_CACHE_LIMIT (96 * 1024 * 1024)

Adding DEFAULT_DELTA_BASE_CACHE_LIMIT makes sense, and I assume the
diff on the line above is clang-format noise to keep the two
declarations aligned or something?

The rest looks good.

Thanks,
Taylor
