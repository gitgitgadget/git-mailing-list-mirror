Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234DFC08
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731015368; cv=none; b=ebGfn8yRQZJuL7yyDL+zQI42LKvyLYG3Gm+tCkVjU4s398JgL92oxaQw7ZX8h0BJILT1sf4u9ttjmxRnbr+rr9388siVZf+IoNcQ3eOwEG56VNQ4KpyCwmr1UeYfdOSJ5N/zgaI3lXzwwIro6AUEBVUDjLd0ykXfJdcQyzHO70I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731015368; c=relaxed/simple;
	bh=g7GVLGWuDXnCi9w0rAx51h/nMzk7wYypx+G0lm1z9Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxzgDvzu/HbdcUR4/j0D2ox9XKDmGH2I+xUsfRljpJU9I7LTSdyqm7gTxx8s7CsR466GDRwC7VgQoHNcuZ9fnZLdXm0b3wy8VvqVO0NytH2jyImiYNMCvE1TDhtkSxr0Xbky8FlTB5J28Sc5EYKpcI49uA38WI5BS+evHitaQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DO4tCWj/; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DO4tCWj/"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e28fd8cdfb8so1463263276.3
        for <git@vger.kernel.org>; Thu, 07 Nov 2024 13:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1731015366; x=1731620166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFrgiMGaOEuGMP4qlEGpx+hnN6L9T+eq+d9fAKY5MyE=;
        b=DO4tCWj/A1wHHPSoi/asWHGeaJsvL7hMps3LyRebCneomJD+F9CBQwfYUAWBAFF+Fk
         JD5doluQDMvQvw6orQEp/9Ql40Ur1w+tt1PLnd5ifHrD/pCXU+DHBia+j1ygvs1h1+Hd
         YTJNn1WFcGsft4731+AO71LtEFXKqdToThXojj3nWtJaNGeK16HzLbt1kP96rQqJlMZv
         WQDb2sokjTB64FQDTkejwRM5srRiT8ydmjpZzfPgovBrOPTJVQNh3VL8qOeAyDYLDA7n
         QHDvs+1urrkSjqSiMTaLschrKspmQkH3VpDeNKkLGw5NUM7g32F+tGuY8gUzHMqJc8gS
         uqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731015366; x=1731620166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFrgiMGaOEuGMP4qlEGpx+hnN6L9T+eq+d9fAKY5MyE=;
        b=C2cfzTbPPT95dq/7OVK8+epvcSL985Carjgn/s2aQU8ZOANpj9g4keNT8MRYigQvx7
         fNyObGiCFo6TdVZcHdLqKgvzkGZaSSWsdOF62j70kYjsIPL0qghuvFiCscn1DRAYPLJl
         kETJ9IVm46GG5y78HG6mrzNxO+oiTbqS0mN8XU+KVOpayAzUr/Bk0fUeO/0DaD4Av8bp
         9p2OmoPSBGB0GpL3Ig/2+JL6uhyyVP4yOmTwSlan0a+cZHFMe+VU2g6c+usCc6kay7e4
         Md4oh6LELBazicVar7XlY7Ffs1KPNUTjaAI6Dec6NTBv2J8ugVizRV2DDCHzqrxhE2TR
         NMuQ==
X-Gm-Message-State: AOJu0YyDSI8lxA9YPrhO9egkiVd9yRC0LvWl9PBFUkPK84MXrVqbJ6mG
	vKvRcIxP841ad6/i2pMmyANRIck+vxLKCEqo2s+juEwGvyXUtF4Ej5AKv0OCOLk=
X-Google-Smtp-Source: AGHT+IGz78lwBqiXfa7T4qyvzfLlAqrEd8qROQzPYc6VpQm4N6mYUCCqFR9P5iY3ryDgDb2eu9y3Wg==
X-Received: by 2002:a05:690c:650f:b0:6ea:8a73:c0b with SMTP id 00721157ae682-6eaddd86cfcmr6567427b3.7.1731015365767;
        Thu, 07 Nov 2024 13:36:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8d543bsm4559157b3.24.2024.11.07.13.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 13:36:05 -0800 (PST)
Date: Thu, 7 Nov 2024 16:36:04 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/2] t/helper/test-tool: implement 'sha1-unsafe' helper
Message-ID: <Zy0yxDIgEmKtec/0@nand.local>
References: <cover.1730833506.git.me@ttaylorr.com>
 <20241107014737.GB961214@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107014737.GB961214@coredump.intra.peff.net>

On Wed, Nov 06, 2024 at 08:47:37PM -0500, Jeff King wrote:
>   2. You modified test-sha1.sh, but I've wondered if we should just
>      delete that script. It is not ever invoked in the test suite AFAIK.
>      If we want correctness tests, they should go into a real t[0-9]*.sh
>      script (though one imagines we exercise the sha1 code quite a lot
>      in the rest of the tests). And it starts with a weird ad-hoc
>      performance test that doesn't really tell us much. A t/perf test
>      would be better (if it is even worth measuring at all).

Yeah, I was sort of puzzled and thinking the same thing as I wrote the
patch.

I wouldn't be opposed to deleting it in the future, and certainly have
no strong feelings about keeping it around in the meantime. It just
seemed like the path of least resistance to bring it along for the
sha1-unsafe ride instead of deleting it outright.

> So I dunno. None of those are the fault of your series, but it is piling
> on yet another test-tool command.

Yeah, I think there was a fair amount of interesting discussion about
possible alternatives in this thread, which I am appreciative of.

I think that if nobody has strong feelings or issues with the current
implementation to add the sha1-unsafe test-tool, that we should do so
and take these patches.

In the future we can consider other things on top, like dropping the
test-sha1.sh script, having an unsafe pointer embedded within
the_hash_algo, or something else entirely. But those can be done on top,
or not at all, and I don't want to hold up this series for them.

Thanks,
Taylor
