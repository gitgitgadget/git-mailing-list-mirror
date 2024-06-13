Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D6F811FE
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718320729; cv=none; b=qNYDI2ALjyWNsaapPdtrSXgk4sK02m6leE9dcDna7Wqa4s8malW7WbwhQXWsRGKtSmsUGdNhzGUhzmB+5l/kU2LFQ+JW6p04IBketo28+D82mc3kWaRy1EyWSkmjkTytrJVgiict7Y2M8LHjW+l7zzzzrSsuj97bOQHkMLfwjsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718320729; c=relaxed/simple;
	bh=1vD9DA2ip3Dvw4bUAfe8Rvag6MybLu8oHEzsiTCnTRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYinN9t34arLWuaEDy24DPkQx+qYbLx135AkrW/I/4mV0//yYmn0sYOJlNukrO152t4lqBUCr+UQ0x8Orsq8XrxASFN6J1byw9cfwoeCj+kHw8SuRMQKQXZbvE8WXyc7AmmuGlOsDs0hkmEADsOCbJDeimlj+auq7w24BK0LYuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f9a4f9923aso836266a34.0
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 16:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718320727; x=1718925527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vD9DA2ip3Dvw4bUAfe8Rvag6MybLu8oHEzsiTCnTRc=;
        b=PxDFiCjVsfGE2NvYqndz7wOzR+4/dKNdx7TRI/nA6Sz25Vyb47hEmUeDzYKbtVds9v
         CdFEa0KYPpj7pbhtojyWFrsGDueBb4/WnLeoTjWVyYSBqktY17omhKsEwH6+XUmOw+Zi
         UU0cGhCb4V+mYvxdAtlFCKdXaC7S1QaEzNW3mb3bvfk5MoyGMDtT7jozvUM72YAyu5j3
         h9KINsbuKb270Lj5qqO0owZ/CzF4K4UiNxSkN48H1YXxUN/p6Q2IWqCxJiktTPdyg1Ar
         CUbl7DJ1NeZsB9vX+er2NIzuySGuK3Hy3jgFmvj7CHz5wwRAICwlZw/eUA6T12TREOxs
         eETQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPxMFwYgr2jS+YhIxeRzip/9ruQHFm3W93sDzOC+yIGzVyjsccYpHD2LXwBd6aEjD1AuaJTZUoFCYBD589XPFDAHmY
X-Gm-Message-State: AOJu0Yy0gOua5/cxXD3NZncprAYsCzzhFpw4PzijfJtVFdHyQQ9+OBDG
	8QyKusrgJZL7FdYp8sJeekYQKHcIT9J59z5CVSQGjeD/gr91gThERqKZpEQ5QSRRHYck5ffXpjR
	UPoXRY5xqw0Uwq6FsWRv3287pMJc=
X-Google-Smtp-Source: AGHT+IGqpjM/zhr5VrOrVArBg5Nq0HM2PWa2JbVz77E5OZhKoDcjqrhjbJVxLLL+XnOx28Fbw95jxuKU2KwbanECAFM=
X-Received: by 2002:a05:6871:5d1:b0:254:94a4:35d0 with SMTP id
 586e51a60fabf-25842c0f9aamr1094931fac.48.1718320727108; Thu, 13 Jun 2024
 16:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718106284.git.ps@pks.im> <cover.1718259125.git.ps@pks.im>
 <xmqqcyoklo26.fsf@gitster.g> <xmqqfrtgk7ah.fsf@gitster.g> <b69449d0-46f4-448e-b80e-002a8b5c4e1f@ramsayjones.plus.com>
In-Reply-To: <b69449d0-46f4-448e-b80e-002a8b5c4e1f@ramsayjones.plus.com>
From: Junio C Hamano <gitster@pobox.com>
Date: Thu, 13 Jun 2024 16:18:29 -0700
Message-ID: <CAPc5daUpzc+FDTH4-ajjf6ctnchE5Z6mHVvpm0qnbPLup18ykg@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] Introduce `USE_THE_REPOSITORY_VARIABLE` macro
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 4:15=E2=80=AFPM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Hmm, odd; isn't the declaration of 'the_repository' from
> the "repository.h" header file visible at this point?

No. The declaration is guarded with USE_THE_REPOSITORY_VARIABLE CPP macro
in the header, and repository.c does not define it.
