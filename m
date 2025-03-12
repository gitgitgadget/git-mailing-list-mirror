Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11390145355
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741816170; cv=none; b=tVWvi57reJEmUEegoaX1g+7EBoly5jK//c3lgq8SFAys+mbRb37o0slA78gXpVyGpvz/IHmFntyEKOfF8ITLLuASW/k2WyEl87cYzH7eyHHwPl80xMawz3qSt+4dLADEY0Lvtw0pqY4L49UnuLvzD88q4jiltY0dV6MK/VKT/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741816170; c=relaxed/simple;
	bh=jcUt0sFil+VQs71FcUW0aB22bKMlT3bYw2gabqovKJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2qFoorI+VqFNic1oUXXl+4hizbOrLMA4XiWIO3Q6vFXJt7TGIAsdclkjB3n9aXA8G1STJCo0Qpw3ogHKLLA9ik1P78oiR70ox/0VRl5DuFikfwdTI4R/3RH+5BaA7JLETR35nhnvlXOft5/IA1MU0/hgH84YsHgFV5VmpvAV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BrVLV4HD; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BrVLV4HD"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fee63b9139so3560567b3.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741816168; x=1742420968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Io8udFT8Bf8KxHfS0N7qKo8rdGzZhsoGGWQmeh5xopc=;
        b=BrVLV4HDgjBaAz4Niinxpq4ggNnW0M0lGD8E/VE1oohqPziHMF+LavtMD7s61vlbyp
         xxfJ2uwNlK3zW8VfV3IKUZf/9wZHn7fKo8ijCFQ7x1Yrf+pmjPM6xmVPeDDByBdULx2+
         7EfY6mY7Vbqa+edwSzkQcWkSzdYTd8ywbiVyso6mb74Snh/j5zIPMoAlTULDHs1A7aBs
         +NLhSeo18uNVq6MLKoV5BVVERqToT8p2jcP6XeEyOzGP5XEd17Oyr/mAmxXDeB/qzD6Y
         O3vx90b3J2GnLu5xLEfmW8fp4fYmjACfrJxfoLlqswssdC1V38FAtjuDFvwwFySJqB+5
         iBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741816168; x=1742420968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io8udFT8Bf8KxHfS0N7qKo8rdGzZhsoGGWQmeh5xopc=;
        b=Kcr2QHihM8qwMo7ZA5Ir6qdZEICLH4kNz1R2EAgaTVODnaaOJhcx+wXsnFVp9EyL9M
         9pmAh+fGlxl75QCndfb8+8zShtTZ/t4LtdfH7X3LB37u8WrrAIgCb/IrCYc/P07GrsNQ
         BQtXxXEHzSzIwOShExU8CwBZEiymAFZcEjnTNqDYUZQugHNcBAfDCt9eT5/AsK//MZqy
         z8aMPCkKD3wRVDd2pibyuyYuYnT2iBO5UQTbgxTLuXu2priz4W5QcCx4hrUkEadyJhy7
         wF2JsgzwbQ1jiYTqGHpS6I5xNPeaXKo3IiuN1o/8rzugtD/jEqDvR78ARQBqYfAvmiah
         y0Jg==
X-Gm-Message-State: AOJu0YztAuCeblLWvynhPT1sAbD2OoJzy0/SeAKBKjngdZik95EMvcAr
	Ugx/byaOveBdv8QsaRp4WfU2raX1V7bd8ZrZsSqlhw5ktRqn1k0xhtDqq28o5UMRZd9jEfLHmNe
	NsCU=
X-Gm-Gg: ASbGncuLg1dYPAFdEj4vNxKB7SPXkO0GWYBMHrXea8iZJxz2Q9DKNd2kuof9kAmLobA
	JRTHk3ZC0YnsXHsnkZljqAY3fDeErVmYxNsfm0K6hlEOOYw45BW0iU7lfkC3P9AjY2ih33w14U8
	1WJIrR9WwhoFm7LrG1pgQqgHCt9cHkYhRj/CFzZKwZ1Azt296juM5a9VydLhZyl9zPOpanDN11L
	1epx/b0ivxc+q1t/SeRh95D4BcfP0sYlKTQ+nVRg7JJXk2nazboK33k9b9looM1WDARS3FNhTXP
	kjwAjL+Y8iZeSaHtVHhUNbxUgVoP4CqLVLKymwlNFJUNmlptCBNNULsYneU7MW3zuN8+nQfsx2d
	SUEl8pWO9704s8AdL
X-Google-Smtp-Source: AGHT+IFnlhaXC8kycnQ4aVE9fVfiO42e+oATtJdn2d8oUgTTkSW3c3eDED7/Yl37mLS97VT1cEfoSg==
X-Received: by 2002:a05:690c:d1c:b0:6fd:a183:f6eb with SMTP id 00721157ae682-6ff2f71b7bcmr2317727b3.15.1741816167995;
        Wed, 12 Mar 2025 14:49:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6ff1d7b148csm5297677b3.102.2025.03.12.14.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:49:27 -0700 (PDT)
Date: Wed, 12 Mar 2025 17:49:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 0/9] fetch: further ref-prefix cleanups and optimizations
Message-ID: <Z9IBZmh4Cr2jq7E4@nand.local>
References: <71075837-D0AA-4F01-9F5D-CA10BFE93B63@ca.ibm.com>
 <61147be4b9a0ee76f1fe0f3376d7316205da350c.1741389941.git.me@ttaylorr.com>
 <20250309030101.GA2334064@coredump.intra.peff.net>
 <Z9H8uKevHUxasE4S@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9H8uKevHUxasE4S@nand.local>

On Wed, Mar 12, 2025 at 05:29:28PM -0400, Taylor Blau wrote:
> >  builtin/fetch.c        | 46 +++++++++++++++++-------------------------
> >  refspec.c              | 22 ++++++++++++++------
> >  t/t5516-fetch-push.sh  | 12 ++++++-----
> >  t/t5702-protocol-v2.sh | 44 +++++++++++++++++++++++++++++++++++++++-
> >  4 files changed, 85 insertions(+), 39 deletions(-)
>
> Kidding, of course, I am looking forward to reviewing it now.

This looks great to me. I left a few minor comments throughout, but am
unsurprisingly on-board with the overall approach as you and I discussed
this off-list a week or two ago.

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
