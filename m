Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960935A938
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776797511; cv=none; b=tML5hfNMfp9Dw9EIO/gvxOo+/xh43IevGZ6i8fQZFfYm9T8aE+CcSO4xYRgT/j90/bPf86PZR5NT48pfSYYhDZ34zcwe43yzXHp9ci8cA+XgxPSeMCGwZUzdj+7ShcpgKQLanuzhQQfXxuAl5bDv9MTdtAemg9qmR5GOANApXWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776797511; c=relaxed/simple;
	bh=VgRJ3LgipCgF+K9uGpFGhR8wn9fsHAuUUmYPpeYHpgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exDq78q/tPm8oHPs25w0zmxUxvRjS9wNGv+OYtVVhwxkE3R/ENLGr8Vvow+W2N/4vZmQaan1rzOpX0hUbsihHy4aCYCcaydWRuSAdCcpscVIsJOb7WSl+rwvd13E1HsgARCLI1ZKCbM7AQyzrosJY0KFQbO5UO5TtvfQA+LVH44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=oSLfyo6h; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="oSLfyo6h"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40ea36b56b7so3526474fac.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776797509; x=1777402309; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9DaKe9KBQGe9OeyCNuABUl2GFzr1AuwlE/M8EdtlZ8o=;
        b=oSLfyo6hOdjfyA04tSTAK1vgC7e1wBEKylsDqYmZdEmK4Q2KsSKzn9g/fVT55DR3Tz
         7MkSCvOHZ78ErhnBYvQ6eh9XoKKUdQmmvF+32zjFfE9XOHtEpBMiT0YkTgrqvyKdjCQB
         NUVJKp8EsRo6Gmjlc228Jt9KIfBziDsTAp4s9fgMHGsl01ke4tQ3H08BaRaU2822glkw
         9Er8Gc32AIHHHteW2dauAxuUxMiHmkHD+iVzwi94Ef6e+kvF29zh2RsYC8r8AwVjeVY6
         gGdDHO+7EZuNlGRf9Jl94I1BgS4L6pUAqC13aG1YCfk0JCwXRylaY1S0q3qVZ/UvYHWC
         feyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776797509; x=1777402309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DaKe9KBQGe9OeyCNuABUl2GFzr1AuwlE/M8EdtlZ8o=;
        b=Vj/llpJUklXFJyHCxgcADLPLHSwowCkywHPVKuV4b0Xsfy/d3b6UV3O+pXSYcd1/pp
         12DFEIz8DPHTL20oHPHyfaDZ6KDPUmU6Gv1pE8hQP/LtxQ6Ffed2xNk0fUc0OkARq0Uc
         S/guyws/M074hpyU965yweJ836Qduxq/ddU2g1zSURf6gGoSdJXAPOtrOvqM9l3AtGTt
         ArTMaL7GKsalmrUk3VVjmtGwGknEm6ENBfhyQGZO7LUfDrAjC8tUz/CzJguA+6oqLdZn
         iSHAwCeF//rxf/RVkb1jlY0Z8gLbjFg/zGc+Cn6nuOo/NYxSyOiAg1EtiTUZ6hzYXu0N
         Uu3A==
X-Gm-Message-State: AOJu0YxuYOvbiRurP4tIwJIl1Nnr9XRTT9LnJMx5BNO17sz+SJIWRfmL
	bWokgeD23++bwiVo+GMdgCDR3Y+iQXKo3tEkxRCIcgsnK8jm06ChHykVAwJacqCOrVM=
X-Gm-Gg: AeBDievU1dBFAoaZrgOfN+IrI3g6JtSHPH8RaHjjx4tR2McXhBMiQ9a1t5Wco0gqLVV
	agm41r9lAPxmWzR1gucfADsYzTpmF4fv6LP1tIGMdrAllz9ruSGVX9/rhMH5Una/RTvXrmCKFh4
	QmdS2kBYoYtKzFoLCBBEHrAxTFJEHp2GQlFIycX5aqCvGS7qxkxT4B7lZzLuaewDdNiLvXA3ID1
	kKNRPuyK3xLjuHoWSUk0Axal2yUHSRnby2F/EemUJW/GMvHU9dCBl/SOBI9Hsibc3feM8hUbcZZ
	UTddqxF/bn+0tNkIzpvK2KZ5S9ybXX+X6TT0Jpy6rBX0lPVryPgDqB4hLbYYNQ0ubhA5ItGPuEP
	0YldeESN7MlZdiVEKUrm+At6LVAKRA4mjI20txhLotNWOvWCCJxhE0qq4q4Be1DQ/xPp3kp/61F
	U2XfK9mLKGxMlxZvg0XuUpsP5FkKNNbuHQHK8cJkMhlfm6QzK8fR9ugvhy/qGun1RUqN3ScoZf9
	82b5IXwLB84uteRIbCPv4A9JzMa1GAs9evlXxCt0EYHZULrW0MYCqcwvSwRaurbSxMZiiXYei4k
	8GPDtNwly7FGQc4QKBYIRbdoEooQO19BsFkLVg==
X-Received: by 2002:a05:687c:20d0:b0:409:a4d3:a30e with SMTP id 586e51a60fabf-42abf21f475mr11431126fac.2.1776797509474;
        Tue, 21 Apr 2026 11:51:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b9304b7f6sm12734559fac.1.2026.04.21.11.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:51:48 -0700 (PDT)
Date: Tue, 21 Apr 2026 14:51:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/8] t/helper: add 'test-tool bitmap write' subcommand
Message-ID: <aefHRByiRJotSIEB@nand.local>
References: <cover.1776124588.git.me@ttaylorr.com>
 <d5ef6b959fd7c05c73bd33aa2b394558320aceac.1776124588.git.me@ttaylorr.com>
 <CABPp-BELG+poD67JCojze=bzYsWr0UvdXb2Vai=eEY=2CzaGCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BELG+poD67JCojze=bzYsWr0UvdXb2Vai=eEY=2CzaGCg@mail.gmail.com>

On Sat, Apr 18, 2026 at 05:24:04PM -0700, Elijah Newren wrote:
> On Mon, Apr 13, 2026 at 4:56 PM Taylor Blau <me@ttaylorr.com> wrote:
> [...]
> > +               bitmap_writer_push_commit(&writer, c, false);
>
> $ git grep -h -A 1 bitmap_writer_push_commit -- '*.h'
> void bitmap_writer_push_commit(struct bitmap_writer *writer,
>                                struct commit *commit, unsigned pseudo_merge);
>
> Not a big deal, but for consistency, would it make more sense to pass
> 0 for the third argument, or to change the function signature change
> to accept bool instead of unsigned?

Let's change it to pass "0" for now. I think that it's fine to clean
this up in the future, but I do not want to make a habit of changing
many "int/unsigned -> bool" signatures each time we wish to call such a
function.

Thanks,
Taylor
