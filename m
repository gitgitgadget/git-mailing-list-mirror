Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276315D737
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 22:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404722; cv=none; b=ok11XXhS7cXSnMYRSED4BPJoO8ZM/F0Rix3+7bxt4AqFHNpbN+LusfOcrOZxkQRKHuqey8Pu/gtbT05Mb+dJyfa0Epzc/yWtMzAmTNj02FiOr2HwQb8Spe7m2UCDEGGkONNLFxImWzhRmBOnGaykmWkGaGTGlMDJJnHlpMlfT7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404722; c=relaxed/simple;
	bh=Iypepa74TqV5TSRCwtMHRcaZXzR99mZJMceSWjOjt2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oi9up4Xnq43Ok/KndzZWi92h2xvOhfDfkDWF3EXqK5Gzk9ZsHcOjWITTOXxSyBpfQRv+Ww1rlEUjDX5PHUf+S3P3K0RkmWvFGYZutd+HevrFVYTeZn+YAXxOzAxAZeieHVSP+R7yHAqNWnc+0ixkjiNNaPQYBCVi385/2CpXZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=v0zfExUL; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="v0zfExUL"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78a5ec6a17bso43078685a.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 15:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711404720; x=1712009520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qr6YYupbmgUxmrUuRY62fZsRXs+iZFIlnQocj3mZJps=;
        b=v0zfExULU1ONlxp+YDyIw5J+9X2gzPzbgdCbc0ztWHwRuKvjP7x0ttvAFQEy6iNdXl
         ulhxkeQNEYpnlnhMC49jDObJI/id4VPjYKKtC82L6LkdxwhuKhH1qJlfU6cJllG6Excg
         Ksu9ciCU4V5eCBqUgElntaOu1YqTnPF31HqEBR0Th8AEZHmc7C7OJjs14J/tnSQXlz/z
         5BlI09m0d2yjf7x1cLFz2QGAU/oYj51rvoJrEd7x2Jey0aNs2zc3GRZysQPZDuVnLO7X
         SL+tgLcUUzQCSYvJG+KXqv2wchjsqzLQIOQ3+N2GvKv922/vtQs6fAAcTwPENPy24gYh
         a7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711404720; x=1712009520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qr6YYupbmgUxmrUuRY62fZsRXs+iZFIlnQocj3mZJps=;
        b=gYZTvV7oL32i3Ii2bXvR0W9si0mxHpS8qW2KjT8QnjTzl3dzfYo9jIFFggPpJhK+I8
         C05y848yGp/9oJ2hAhHvAqowQNBMMOnrrcYsXUmS98HYP7gLaPuz8y2gDpeAuYwF3Ip1
         kF8dp5OGALAfd8xO9nBQG6kK2qTnTieLurQQoPLV0m1Bd25jqLHmakARFC530t8a6mRD
         ItGmGiXFz7HWvGHyzeduGWzse4ix+vmNVY0brdaCPZvg/cNzNKIY/ZC2sIPieNuOxp/C
         JBNE6rtvJBm/GOfQevXG0oYaXq1+BmHZyVcOCmTMaciKvjlkkjKZM4R3KjP0ImgvlIxx
         +xGg==
X-Gm-Message-State: AOJu0YwwL4id/rTW8ZVIrhr84un8Ui+fHsWQzzyGWCBJSmzTp/HPaN6b
	5DiiBpGZxxs/UIdXPXQwJlUC3UfaarlpHXJZsHVJj+PEszUmYtzxQMicxULNato=
X-Google-Smtp-Source: AGHT+IFdf2L4cQAVFLxf+ftX0JC2iFYmioJBsUBMFuVlvK3gby8rAm9S1rI4OXIcWhpRSNPUJjUtKg==
X-Received: by 2002:a05:622a:253:b0:431:5017:963a with SMTP id c19-20020a05622a025300b004315017963amr8604153qtx.29.1711404719965;
        Mon, 25 Mar 2024 15:11:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ch8-20020a05622a40c800b00431662b2309sm496393qtb.62.2024.03.25.15.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:11:59 -0700 (PDT)
Date: Mon, 25 Mar 2024 18:11:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/11] midx-write.c: check count of packs to repack after
 grouping
Message-ID: <ZgH2rQYWbj+UkNIc@nand.local>
References: <cover.1711387439.git.me@ttaylorr.com>
 <f77e3167aad4b60c381cf1def2ee1eeb26218d06.1711387439.git.me@ttaylorr.com>
 <xmqqjzlqhwnc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzlqhwnc.fsf@gitster.g>

On Mon, Mar 25, 2024 at 01:41:27PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> [...]
>
> Queued.  Thanks.

Thanks very much!

Thanks,
Taylor
