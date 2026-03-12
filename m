Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF5E2D2491
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347077; cv=none; b=OmyAzT/3gNAPAvJs2x2nGZT563KrPE1BxLtWo5qjAsOShbRq1r8CNL1nQJL4CJ03LAR6bvIudKOF5FycTDbQmz+2tVP51QzGp9IF1ePwX9vVWga0aNq0auFNcLJDuJvLgrammWKNEB7AXA59vppOBzFNlhrNouPVl0aNThLVyiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347077; c=relaxed/simple;
	bh=3MW6//uxsLvmdolaxRfkXp+IFuK0dbAxw01HHXhQ+TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPatTyEb8yfYw8TPLH3otLLRf1L7LbCf9iLLQXP3Mw6at2+/jAAuZUc06b3ejI5NhgcKFAXh/I9i1EzCQaUhPO9AqYp8s2lZniY4j9NvTFYZDAdf2sC7EmbLiQL9bKjA2YtgmFTEs5lve34Zia8JMI3mCSOPBMxOSRD74mctULc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX4IZFHF; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX4IZFHF"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d76c145ed9so1532411a34.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 13:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773347075; x=1773951875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E07Dj9BP8Y0Gl11d8+GA4ZkDoRASbuDfWoooWW4w0Dg=;
        b=gX4IZFHFkv1UIgbavAHaaLPNNbnVeeE6yOjQtxU5Wl+EhPpMGrVyTXzpgFLwC0TF7R
         DZHxnSEYqntaUt0Gn9EP6JZacprh7grlXrWL39a8y8AQ/ex62eQf6woJCxlPOS0afAMh
         MuoZe/mx1o0e3ImQ/1EhQdJYlDY8taafW5ShYi8FGg1zVvwj/EK6TBsqCqbRmy2iIiL3
         ANI6YOlcl5pas/t+hsBM1ozhSMnQTq78rqzqLQlu1ryg0LW6DefAATSJu9fYF8luJn9O
         i9zfr2M2Oa4u1qtoF5sWUW6vONvkUV/lqT78w+3bdkScpN+qXFid9LmNJyPm1RYRgyuu
         MsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773347075; x=1773951875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E07Dj9BP8Y0Gl11d8+GA4ZkDoRASbuDfWoooWW4w0Dg=;
        b=F4txPUwOF5AK0H8hZ4eDC52qZ2CF4/V4qO6FpWuGcQ6VvGsxsYL4wQ0G6OmIFqA8Gq
         j4eZu3QCOiCRoKrWFDEUwgY1+KtCD0IUf3yt0Yg9T/gxR/afJB6t8ijqxwH5AQDe1Vtb
         V7W3XDIFcqQgScTo67V1jn+8ZjoEdTzgOvedD+wWhzF6mESPxRJl1rw3EqUmBwlYC62p
         D87qMjcVzLP6Ws0GRrl0E335XqWXTHMlDP3UR+QZShOIbZtgYvax8Yf+9lCAB5HpMFvS
         aC5ZFZcLeysBYE8pI5Op1i+sGfXX101+MJZLanT14tQc5YhSydJIzsZFPhkEJwkM9o0f
         Jllg==
X-Gm-Message-State: AOJu0Ywv2ynCW263t/K3736iIZ9ch9u5C1duvfiMblGYS1tmG4Ft8Oab
	QoHXcfQ8OG9N5oGGP0APxD/AJY5XD2GU8EkwPVRLPuFuw5W69B+H+PEw
X-Gm-Gg: ATEYQzwV/LtuOxyx2xZnB4/DByh+gHvYMt0YFct6G204vwdhKBXNRozCWwMv8qUCUL7
	MkXjtp0CAY6Na2EXXeAkLMqk3XYWnOuRfba5KjzPP7me6h9T6EeGKX+jcCNF61qzDm9NRb2IADs
	JktHE3cdqbNIfYJGkpZG+mRuDGi/a8ctgvwqHcuzJ/Ti8ZLnqEmLg5UZhdEHa4/XURspNiw3F/0
	mra4EzHTrSXZVYWH4TRuoArWPtyq39a7C1m7vLVZq25k58T+3agfeqarnu+4BaBiddblFYL6r14
	gmltOVPhMTnBPGDHqwjBdqfFp/B/BTJDB0OOdp3NdwfbYebXRP9DbLK+kaQEIjNm+XXtc6tbkLw
	7pnbk8M+JmN/ep9x6QLDbzjvwdjyeLVKkEl+zi7sg/ajNcNGk48Em+aXnTUqfem5pQr6r2ztVNX
	mgGaAEqchzOp7/ivlq
X-Received: by 2002:a05:6820:169e:b0:67b:c368:137c with SMTP id 006d021491bc7-67bda9ecc45mr510079eaf.32.1773347074924;
        Thu, 12 Mar 2026 13:24:34 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bc9354e59sm3717010eaf.16.2026.03.12.13.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 13:24:34 -0700 (PDT)
Date: Thu, 12 Mar 2026 15:24:34 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, 
	christian.couder@gmail.com, ps@pks.im
Subject: Re: [PATCH v5 2/3] gpg-interface: allow sign_buffer() to use default
 signing key
Message-ID: <abMguEa0Lmga19Dr@denethor>
References: <20260311173147.2336432-1-jltobler@gmail.com>
 <20260312192228.481134-1-jltobler@gmail.com>
 <20260312192228.481134-3-jltobler@gmail.com>
 <xmqqsea4dclc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsea4dclc.fsf@gitster.g>

On 26/03/12 01:20PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > -	return use_format->sign_buffer(buffer, signature, signing_key);
> > +	if (flags & SIGN_BUFFER_USE_DEFAULT_KEY && (!signing_key || !*signing_key))
> > +		signing_key = keyid_to_free = get_signing_key();
> 
> Micronit.
> 
> I would have preferred to see an extra pair of parentheses here, i.e.,
> 
> 	if ((flags & SIGN_BUFFER_USE_DEFAULT_KEY) &&
> 	    (!signing_key || !*signing_key))
>                     
> It would make it more obvious what two conditions are required to
> enter the body, even to those who well know the operator precedence
> rules between & and &&.

That's completely fair. I don't mind fixing and sending another version.

Thanks,
-Justin
