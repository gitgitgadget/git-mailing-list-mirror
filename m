Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9218C93F
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286086; cv=none; b=XKkv5Df3iCfMRUo4ZTSLms0bkFC32kpGc4x1iOekiLGMTTLAVkflSuhu9tC1FqWH83P0esk91BzuUPqtWlM0SokzAN9s3Zb6nJ3PTy4l2NPQpSaJZL1s7xBPIPZnpDtl7TK9wPiLL0nvGHOAeeC1xLZtsFCIEX0gDW4vXUA1Oqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286086; c=relaxed/simple;
	bh=aB+ojP+yFLBd7b2KsM2qKu8044qObPPF2J7FIom23sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpO/riCto/hYGXpEB45GZZ0Wt8YtVMzpMOtiEdCZZw6WJ/rrkR7UNCSGOX2k7b41glCZOPBdPtc0KLXkqBI6SqUilOoBoThl7aQkwK1Y+XiGCEKl2oJ2oFhxZdeGZL29nmmjWryJRQPpS2jjMoyZrofONjQbjFmXia8KY/2ZQec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JWmyf6VQ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JWmyf6VQ"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e2972a311c1so2641358276.0
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729286083; x=1729890883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfGzPPViqOzRNBNKKNze1OulIbiEj0IN1S8X0iMmSpE=;
        b=JWmyf6VQtcj4okEOcTsMSQASMk6fdYz38XPmmWRgSePPpeWNcOlg9HtxXghwnh4/F5
         BmnCMUjNfCzE1zB3ndZGG+UYxCoOfcpa9YarYXH3UWRjI409F88b0oBKM7SVVa5IZCVD
         eta9t5l+tiaAs7lUtjmbsjTlkcUTfP8DoDpEHpfIjZhtDH8qblVWAGIAxizJ7LGQrXk8
         oYzniMjKkT0CjDVkvYpOuG+9gtYpzRdH/YiCYgxH7MpXjk69EcC/pbN04xkQyJsdS0yh
         rjIGkrtVmgZDTCj1evLcLvTv3uSREF7OhyVyM6ZgS/vH2s/fPaSAXna30Dot/i8Xyzt2
         OQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729286083; x=1729890883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfGzPPViqOzRNBNKKNze1OulIbiEj0IN1S8X0iMmSpE=;
        b=fpsLHtLCgo6yEOUIAvviKOZx8t+DQHnuIhFCZAQkReGHAg/iCQo4aLlAusuaOlzNlt
         ezAOjB68jm2QYPP/tEOTRErDCVt6/6Bh7C0nDCnzkeR8sxOGA4rUYDd8ekKmaW/7QhyD
         J7Yvb5ih5jxAfDTvAsr3nBxw6Aqfje1g0r/XvUs6ZsSRPFn6GppwfyxaulQYFmix2KB2
         0Hbf72k0SQ4wOxM5hTiW3vQjaKwD6ByjuqE1UWp4Ju5Yge/Pet2rAzZ4QWsf+PlDmu9i
         NY4C8YAe+U7guJz/GZw7oYzWCDOtwaFXDZjyWCCFL/b3FWUIrrInpJcdTr/AtqcNoZAt
         F0Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXGbSeBlAHHuCZVu36e7NP1u4O9mV5MP635YjxLXn3N/9rRLoNbDcwz+Izsja8+BuLj7gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIXWqenqG6S/Yh/Pxz7fnLO2YjV9y/dIPRWaXFT5PFtM/4+qAU
	sKIEFoj/zga1A9X+twgqTLj9ULv9FiU6T6XWIzFRlgnwa1TtXd5ow8tMICDeIlk=
X-Google-Smtp-Source: AGHT+IG90OXO8lxZqUPbmr4QinjYxffFL5K06TG8YazG36ZXJ5rZ9Cm8p4TYPMz56s1JinwrzTNvfQ==
X-Received: by 2002:a05:690c:89:b0:6db:d217:895e with SMTP id 00721157ae682-6e5bfd5cbbdmr37690637b3.36.1729286083073;
        Fri, 18 Oct 2024 14:14:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5c00e4d90sm4765197b3.53.2024.10.18.14.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:14:42 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:14:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Subject: Re: [PATCH 2/2] Makefile: adjust sed command for generating
 "clar-decls.h"
Message-ID: <ZxLPwKdUywa7vlu/@nand.local>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1728903464.git.ps@pks.im>
 <dda9b8e033c2e32e17dff73cad43211dd355d3ec.1728903464.git.ps@pks.im>
 <87y12lbeix.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y12lbeix.fsf@iotcl.com>

On Fri, Oct 18, 2024 at 05:45:58PM +0200, Toon Claes wrote:
> You're most likely aware, but this change needs to move when the patch
> "Makefile: extract script to generate clar declarations" [1] is merged,
> because this line then lives in t/unit-tests/generate-clar-decls.sh.
>
> [1]: https://lore.kernel.org/git/7a619677c7af6ba8213a36208e20ab75c4318e38.1728985514.git.ps@pks.im/

I believe that is what Patrick suggested in:

  https://lore.kernel.org/git/cover.1728914219.git.ps@pks.im/

, no?

Thanks,
Taylor
