Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D55734B1B0
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028497; cv=none; b=rMSgoUIyJSlsdToRrLhe6tpNiwRf12BnmrPwhOOV3UldwlwFQJ9vAwOkKZ8Fca+/Z2bK5J8IBOeXxdm+N3W26csROPv16rv9CbCjvn1eRxRZjBgD14pppw+wCzp9QFKwNNq7W5DSpGZ1KyJDcRnNm2kDhId6/mFOyQ1+w/dHVk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028497; c=relaxed/simple;
	bh=DfHVExcsGuLE1LlsMtD7IcLaiqEzpdi9MZ1Y9LQ6EI8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DJIaWd5Jjg1m2lnoC1Ab6oH8oycLFMuf+Mms3roxBv4GIhQM7ohuAraSmRLnF3npdWIPHeYEbWJLvUT8+Z0Gx0rBwUNVBgXCGe1qmnrtexFAChGd4fshxXPvQzVD1LLgi98bN7EYE5c51IbuvXoavMhXvlS0hDj8qUgvzfujXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+KKs9yC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+KKs9yC"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493f45e20cdso25375015e9.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784028494; x=1784633294; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j5zSOA/DwuGgnQgk/zRQNHBkSGy/GAFOHSQ2R7Vg2RY=;
        b=D+KKs9yCCcJYhC8Ak87KAjBedp47pCidZ5WU2gm4eXQiajGeAa1KWKAH703QaFYx62
         y/UVejrHXSjV95+VzQv0B5G3MXUv2cm8jLn1Q2hk0D/fLyow6UVP7/H20TIRvl+rcpoe
         WTXzFEpNrcGGLNyc0BPAEO2RGmRi2Eli8ocYB1f/PywOQZfjb9orl7fQziS2lGyRC1B5
         F3gESt+vU5YkyknKF8RRF8C6l3EU9Bni3bDFLMq204YomViGk8px1bCHKQTk99UCXLck
         KTrvGoCzjcEXb5j6ujX02P6gjfc/CLZsEluooYwAP2b+3CLdM8U2NUHnfCXbiVM/KpDI
         ip6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784028494; x=1784633294;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5zSOA/DwuGgnQgk/zRQNHBkSGy/GAFOHSQ2R7Vg2RY=;
        b=dxPAK6OAVG49AsZMe9o6ta0seChfNdUoIeFDdkAnJzcXfrSOai2JrnLDXZ8BO+a7Hw
         XsJT+NhnoE42FaLv6xeuOB7G/kJDlMz5QhwoJvGxQCwzF+47koTY9t3X9gyGq3qjUIgY
         /7YMKCjrITrybD4S+dnwP+OqIITX81UB3MxgAU45ivx8EXrUb+E5RbEQGVG1uhzzfwoU
         TPEWHCo/icgxU6DY3CVVo8Atdyy9LwisJYOSTCLqZxAW0Lnk01yvlOnw6XEu04wWYdvi
         4GfkaXy5eZo+TWECZDCvQFOVb4Il1ahUWM4VXwO0L7CkY//nQqpFXhR39WvqpYzAtCjF
         KsrQ==
X-Forwarded-Encrypted: i=1; AHgh+RpsBT6cJMsooaHr19FmiNEqA6Ku/qLHzMLFGCTv+4jLas3wY2Sb3tPjxqdrrLaPrHL69wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUypQjRCIgtM7wRdz0Cl/+QrBfRhR89ra1zD/F+9Lr6dP+6CWy
	g9ssYueecmGEvbXW+Rp75fz9LoMEv2kCWa34Ue81MW63Vqk+XnfIsVw/
X-Gm-Gg: AfdE7cmxx3aVyGREqGkRfHQuGCGTRjeA2pEaomk+nMa4m/0YfpXQNl1+IPadk9+rlyG
	YzmUStpWBlzk2SpBVLuu179d79MIgAXpaM+zC6Dt4MAMpUDj9CWVc6YnAq0RGCQdz5YSsotoPMS
	kOynExILymXl0WD2WDBZunZEpYjgifk4WmkA7qGwDLnVkie9D2V40tTZdBxJkwEf97JZQH3WjrX
	qp22b9M7fYbCZa/B60Yw6Dw4cbJAHuemVe2WHw8Pi9U3Ig+toyVH1wmTIZ8md2cF3GVcgG9eF1h
	g4LB2BNhkyJI4luu4j2NdD9f7vMhfBgIciB22ojuC0RdWWD/CVPGsbsDKZgWSTrBVb/QMjxa65T
	kTkTqIQH+qepYI0T9CzI2D7CqfrGtajnKHj/YPAvCzl0TM6+A1hgNjLwW2Q906Lz8FvG/CxQlfH
	AAxZatkshIubuVCc1pzRdOXRfP0reoyDotueGXWu0JVm9oI8ppKVZ6LPt7bsmFuOuwhIgt/bKYh
	Ev9Hob87irYzOodmuWil9foPkyeyQzVcw4EiS9Mn5fwf+XcbOtkQFCUykvbgSX9Hbp5pVbjeCck
	HGWM0CbpvIzpH2VCXVtvQRze5fZtOxizb0UPSerM1+7AyWTwDL5ICBdFYCSmZA24slD7ow==
X-Received: by 2002:a05:600c:3f07:b0:492:7083:e5a with SMTP id 5b1f17b1804b1-49538a1757fmr19809265e9.31.1784028494265;
        Tue, 14 Jul 2026 04:28:14 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508727fc0sm67598255e9.6.2026.07.14.04.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 04:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 13:28:12 +0200
Message-Id: <DJY9BJ5QMT2G.2WA49SUCRRB3Z@gmail.com>
Cc: <chandrapratap3519@gmail.com>, <chriscool@tuxfamily.org>,
 <eric.peijian@gmail.com>, <gitster@pobox.com>, <jltobler@gmail.com>,
 <karthik.188@gmail.com>, <peff@peff.net>, <toon@iotcl.com>, "Calvin Wan"
 <calvinwan@google.com>
Subject: Re: [PATCH GSoC v16 10/13] transport: add client support for
 object-info
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
 <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
 <20260710-ps-eric-work-rebase-v16-10-66e07b58a8fe@gmail.com>
In-Reply-To: <20260710-ps-eric-work-rebase-v16-10-66e07b58a8fe@gmail.com>

On Fri Jul 10, 2026 at 6:41 PM CEST, Pablo Sabater wrote:

[snip]

> diff --git a/transport.c b/transport.c
> index fc144f0aed..3e0a6558b7 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1,3 +1,4 @@
> +#include "compat/posix.h"
>  #define USE_THE_REPOSITORY_VARIABLE

Hi while working on another series I realized that I had introduced this
include which is wrong. I didn't notice because strangely it didn't gave
any problems on the CI.

I'll drop it next reroll.

Regards,
Pablo.
