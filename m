Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBC51AED41
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444035; cv=none; b=WsA32YIuvJFjNGWlJjLrvOASzYzi8mtQmu+ttenpZHgk39BJUTUL6+OzyhE9bHi0kPm8QaIKsVaXz7hIfgxBnyY/fYhqfo1eDjdrUx8I7P4ejaK9zjmcYDEt5vc62Kw+WhdXjs/0A5EdS4QDcT48X628/8UCp9D5Zxb4hemjVe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444035; c=relaxed/simple;
	bh=hbm8+zXgnEWZSP9Sk4c5EGn0UPNkI1m4CEmZzLwdkcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7WkgTpcDBr/ZftbTsSgug/8mINCvuktKK5JI2fXmg5eQ8eRWkcZFqPNnL3pGyQewnPf3HQauiRzaxgfheaqDgV6wyLk1N1aS0uNrF2nZyMkj8ZEiHXRdH8nxeh86JQZVsuWANnYr4fMiApE79qNUmvE8lx9xuDSVZKkjkJzsaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=PUdkPNF3; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PUdkPNF3"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b7a0ef0e75so34267676d6.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722444033; x=1723048833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FN2zYUEqk/5+h7HaadjdeIdtgZLymOnpLQnSh7jmxVo=;
        b=PUdkPNF3hvpf2FUFPxoodeZMR3e22SSY7R/cUPEP34WxOo38/ukTQWGk1OroFR/r1Z
         S5L1+yhCYdR+shV7r5ENZKgiOEptG774dPrS3NoLiaEflpw1hP71DI8j+S7qMvk5I/Qh
         G7vGGpEDLLxkdC9ER9FmIKySQapkymXjieja5U2sjQqqe6msX5/Ee0Ed34HpTQ4562yf
         0AQct2HE8RulQpTB0rO2yXDeLR/evv2xwmrh7Yv7X02mgNKTqFDSkm9n63wYYpio6VpP
         JM4LRKFYUfbCTAeTRG6EO1AE28tgI4GMaMAABxrHSvFYia1QGq4gCsA6ieS/GVk2YU1W
         2JNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722444033; x=1723048833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FN2zYUEqk/5+h7HaadjdeIdtgZLymOnpLQnSh7jmxVo=;
        b=C85vOE1nzMyzVMa4Fa5LrETePuoT44nHmxZnwGUATXlalaTjdKUnK7P3LTSLeVjC8e
         DD7Wo0MRJJyeHVaAlAh0/DiciBLaDd+drYG1Ol4TtySnDkSAwUxkvjk1nEuDKFlF7anO
         UJjsCAcdgEFgMq6O/AA8+tYGIWGVsmjbHM5+b5lOtamdVKUGY+5++s8YgBRZScAKqxHl
         wa39OE2xUqvRHzx8GcU+Q2f4koEx9WZ/VX4QTl9VIcD4aUpIDor3wEpMf40qwqLSBN/4
         gwmzXO85xiWIDtptI0bnZtYUTI4NEy0u7TMFIR/2kuexykS3uslAZGFEF0/kUdmY+KZv
         nVvg==
X-Gm-Message-State: AOJu0YxqmXEnosi0wLov82FfvAlIdVqXnNEndGQWaz6uo5mupkaXQCId
	prwhB9g+PohXPe3mW24Hiy8bgncmkwbz2PXvssnTmNNCRpfYuA8ioaJVzLJT3kmw/1iCHio571H
	+
X-Google-Smtp-Source: AGHT+IHv+J8WpO/mP4VagQ76Zw+XqFVkfowWWQAo5ceP2WbAPwXTEiCm9CMDmaIrRHPj90g8ohm6/w==
X-Received: by 2002:a05:6214:23cf:b0:6b0:72c7:88d8 with SMTP id 6a1803df08f44-6bb55aba1d7mr156398666d6.35.1722444032951;
        Wed, 31 Jul 2024 09:40:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fb190c0sm74725206d6.146.2024.07.31.09.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:40:32 -0700 (PDT)
Date: Wed, 31 Jul 2024 12:40:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 11/23] builtin/stash: fix various trivial memory leaks
Message-ID: <Zqpo/8HnUbgF5ZmQ@nand.local>
References: <cover.1721995576.git.ps@pks.im>
 <a4b3ca49c9724b79ca695d0db8e45be663a46434.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4b3ca49c9724b79ca695d0db8e45be663a46434.1721995576.git.ps@pks.im>

On Fri, Jul 26, 2024 at 02:16:12PM +0200, Patrick Steinhardt wrote:
> @@ -1892,5 +1895,16 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
>  	/* Assume 'stash push' */
>  	strvec_push(&args, "push");
>  	strvec_pushv(&args, argv);
> -	return !!push_stash(args.nr, args.v, prefix, 1);
> +
> +	/*
> +	 * `push_stash()` ends up modifying the array, which causes memory
> +	 * leaks if we didn't copy the array here.
> +	 */
> +	DUP_ARRAY(args_copy, args.v, args.nr);
> +
> +	ret = !!push_stash(args.nr, args_copy, prefix, 1);
> +
> +	strvec_clear(&args);
> +	free(args_copy);
> +	return ret;
>  }

OK, so this is the same pattern as we saw in the third patch of this
series. I agree with Junio's comments in that sub-thread, but also that
they are out-of-scope for the present series ;-).

Looking good.

Thanks,
Taylor
