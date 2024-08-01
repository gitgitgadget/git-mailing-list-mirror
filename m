Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1474E14A0A8
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542466; cv=none; b=BqS8/AH3YRZfF9LYnej0J0lZZzMdebFzwA/mtOnO70pGiO4GtwQle43yaaiCNGY+93nFsXr94TIDe2FvXNo6yQs3Ste9McYv5gC3OGVt58QgI+BPYtSQbbvtR0W/DMQ2CmMAWQtDHliqVpA/D9pWDgVOfFaNI/+Mz0BPk+5LmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542466; c=relaxed/simple;
	bh=dLh5X/J8Prl6MuFrxFRKcjJkrZO2NUJdWbrMyax6UrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYNhQJckt3F8GQA1uqVO/rjc/t8vvcMr046Z5s9PGC5FkmG4l2QKrqpbLnwLdtysOOVuwscNSTpCKnxuQh8pyybotFGAiTkIvp5V6Wla1ZlSs+dCOfIX2SNX2RwCAhZgDmwZR9VLiRD4P/Hi3GeU80iqGO3j23FvtLn1+hXAewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qWp7B7Tx; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qWp7B7Tx"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44fe28eb1bfso40649261cf.0
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 13:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722542463; x=1723147263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vMnUY7dP/R83FAog27Ym2lLl6BbzuwWVdehc1vSN+V0=;
        b=qWp7B7Tx9LxaOdbPKfDpX3AuR2Ui9gSiy+sGby1Nag069tlZ+b4ZrmmS3vX/96LgrP
         l0BWkyJxNzQcQpTnfjbq2tEnecNWtpR17cCqEGOhj3C7rT5CwXi3CB+YpsaeDB5nWI9g
         gCICJmlDRHMarCPOKyA7BSjRuPpqXz4Dqt6Tiz1puW2/OU2TEPcXg6f7hKkfnzi55Qba
         6aQNJQBrs+i8KxIjbHgiw0iOeLmpVba0DXa8I9pCXbCsjg941UdDxLkepe4sP21XGL1E
         4R8NBqhWI6HIfHHl2fy8wwSBlER4x43nRbACGQbntHuwQP55tqMEojKnDQzFT1jZ0TxG
         3RpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722542463; x=1723147263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMnUY7dP/R83FAog27Ym2lLl6BbzuwWVdehc1vSN+V0=;
        b=MT9ZXoJiCE20nZg95v4fxAgIe8jncbXSS1udqiOKmTfKSOv2c6lvBcQ62qhbUBVQow
         H3+geZJsY6zkJ9qQhUHsdPn7wu9g09xfBuDStrfxS3sTKMVDX3AwLo4p6lUPAKYmvlqK
         VgDZfd5GtzhtxQL+hg46jbWxKwbPuOe22llBHh47K0SwK+tSKH39jLanR1JwUAMunTOh
         WxgPwUGPwcar0y83Msi2kj415grQyxhHbtHweqMax4lezD0gIwgkvEOr3n+RxAB88IE3
         29/5P/5HcRq/u+PJ/UEUSQnJ8w5NxR+pE/S+yZJgq95qBmaropzuZrdxdreL8favun6s
         Kdxw==
X-Gm-Message-State: AOJu0YxIJ0R63SL9cNROu5l53AoWISze23I3L5AU817x77rBUs5edlS7
	Qmg3upCgNn2sUkOryfwQr/+KE9zqZETtzoHWyD/O1le9u9BhcV2H1+5sJMoo1tk=
X-Google-Smtp-Source: AGHT+IHwJ3NxHO9egaE+XcIpkF8MTPTmx94/9sBlUcdIuqXr4D6kN57e8QjIGm4J/OibyAMMFxUy2w==
X-Received: by 2002:a05:622a:648:b0:446:4c01:1f7a with SMTP id d75a77b69052e-451892857cfmr16185971cf.33.1722542462828;
        Thu, 01 Aug 2024 13:01:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a6e6980sm1895211cf.48.2024.08.01.13.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 13:01:02 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:01:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/19] midx: teach `fill_midx_entry()` about
 incremental MIDXs
Message-ID: <ZqvpfRJC7+rCMwWV@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <2b335c45ae7832b886ef9adccc2530e4ca53d267.1721250704.git.me@ttaylorr.com>
 <20240801101215.GJ1159276@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801101215.GJ1159276@coredump.intra.peff.net>

On Thu, Aug 01, 2024 at 06:12:15AM -0400, Jeff King wrote:
> On Wed, Jul 17, 2024 at 05:12:25PM -0400, Taylor Blau wrote:
>
> > After that point, we only need to make two special considerations within
> > this function:
> >
> >   - First, the pack_int_id returned to us by `nth_midxed_pack_int_id()`
> >     is a position in the concatenated lexical order of packs, so we must
> >     ensure that we subtract `m->num_packs_in_base` before accessing the
> >     MIDX-local `packs` array.
> >
> >   - Second, we must avoid translating the `pos` back to a MIDX-local
> >     index, since we use it as an argument to `nth_midxed_offset()` which
> >     expects a position relative to the concatenated lexical order of
> >     objects.
>
> OK. I think this is correct, but this would be another place where we
> could use an nth_midxed_offset_one() function if we had one.

Yeah.

> My thinking was that we'd avoid walking back over the midx chain again.
> But I guess we don't actually do that, because our midx_for_object()
> will have overwritten our "m" variable, as well. So inside
> nth_midxed_offset_one() we'll immediately realize that the global
> position is inside the midx we passed in. A little extra arithmetic, but
> there's no pointer chasing.

Yup, exactly.

Thanks,
Taylor
