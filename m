Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A7D14D439
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945879; cv=none; b=JIWkLYsbrb41rFT8XxvMTUv5w6kR9CUWK6WvHoJ2n0DGwbIlkU6g8pdznVCJxwh3K1SOL/JlQEdoLKVK2iqZDQU3UOTUU2E5rS8ToXEM7vLBGVdSQ93wWcTzi+AB8kgYFJKpaVPRtzHfx/oWz+G38QguZZcntqhnCdlPJC3czrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945879; c=relaxed/simple;
	bh=woaQj5qC7FQ8moQ0hdVrhKEy6jKXkM/YBFpF6RhpOVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAREVjrmXxgH0iOaxYMBoK8j4sbhrUXisKCYkGg0Km9InfXgaGdEfJJ6UdGZGay365YZuo+rXGC9FvV87PIg8QmsLXHGTxTWTtxadsXF/mz6vsIdhu6mHY5viHDAwl4OFpIKeIWEiI/KKV0F7sCutYb9B0dnzvFhEltVISZidos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=b7GGUE++; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="b7GGUE++"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e2f4c1f79bso40957647b3.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 15:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728945877; x=1729550677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=woaQj5qC7FQ8moQ0hdVrhKEy6jKXkM/YBFpF6RhpOVM=;
        b=b7GGUE++nCsgkm/T/t+MnjW+hLuJxxGYzjlEdcNNNdUFWpL4+xCORVFKaA/Jwjxcxc
         sQUx/q+j++2r2NdgO/M2vXkBd1HdeeAZSqgHJ9bG/cGogon3tfKlS0OCbpEYsVF4jiD+
         lettyAt7p7EVEu43smyqbrIWpjKAKKO/xUu3nA6nmfVhFrk85dp1JjhJjCg6VFVEEXG8
         T0EemgjkJQuwa9WYe3lrBp/bATcvqzuqRudmnaEcr+810L+BoCsSh1WGy18V29GWJ4ze
         ircLKT6Dm2X1TRpXVYeH73Ag54bD5zx1VKeFLmHiXR6yULUtZUBGZOP2POhADs+k9wG+
         Fe/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728945877; x=1729550677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woaQj5qC7FQ8moQ0hdVrhKEy6jKXkM/YBFpF6RhpOVM=;
        b=hGDQxil/dIAgS7bnI68byP1rTgt9ksKFN4n3FiGJtuv3isPsebx/XMGKF7zE8kYSy8
         R+f81d7T2wNw7M0NFG9e+EsNwlirmczwHG+RlG2QjcZrTN9/Y0BQsvDJSuu4jYCSOG5a
         BfOh84sAVCkxwzT1Wf4sJEqlTb4qzEgkuojoDVE95rA6EVEXWkVYHS1+4vy1extfXRgo
         lRe1z11UKA/EZGZiOk+EY8+XzdufvVoUR8ngTtg3qraUtTNq30Fp3MWOVBZPYjmGXBgi
         HvJw7gC5RyI8QQm9G5gIB+34rU7ZCM5ma/iwZaUfveoUklHfvYd6Mvcoa8IfpJ5mSMkx
         L/Nw==
X-Gm-Message-State: AOJu0YztHZ43XTOuZZBkwlRFCEu5QQrHnu7Lq3Ul+nExO/T0vh+zn9oF
	JFlfhW1Wv+UpNvuNcv/B30irFGp5I8wiKjVy4v/zbTsJOtzoWVPwyFh7YV2jy4w=
X-Google-Smtp-Source: AGHT+IG5WI3nqtozmeIt3kQ8Zgx9gRGDueetSEGWFSWWNZRkZTQoxSDLnl8iOKcbQFTtpPWQX+G22Q==
X-Received: by 2002:a05:690c:dc5:b0:6e3:3716:2d42 with SMTP id 00721157ae682-6e3477befd7mr117567137b3.6.1728945877384;
        Mon, 14 Oct 2024 15:44:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5b3cccbsm177077b3.40.2024.10.14.15.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 15:44:37 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:44:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/10] reftable: stop using `struct strbuf`
Message-ID: <Zw2e0w5bkDO4l/Qs@nand.local>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1728910726.git.ps@pks.im>

On Mon, Oct 14, 2024 at 03:02:16PM +0200, Patrick Steinhardt wrote:
> Hi,
>
> this is the second part of my patch series that stop using `struct
> strbuf` in the reftable library. This is done such that the reftable
> library becomes standalone again and so that we can use the pluggable
> allocators part of the library.

I reviewed this round, and it looks generally good to me. I feel
somewhat unhappy to have to force the reftable backend to implement its
own strbuf-like functionality.

So I think it may be worth considering whether or not we can reuse Git's
strbuf implementation through a vtable or similar. But it may not be
immediately possible since that implementation just die()s on error,
can't easily swap out the allocator, etc. So perhaps this is the best
path forward, it just feels somewhat unsatisfying to me.

Thanks,
Taylor
