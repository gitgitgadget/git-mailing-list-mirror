Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792439017;
	b=der0af4Gd+q+FlWbi4unkBN0DY4/oajyc6SdfpWlU82zbOfTp+Z2wkRHVZxkyz8S4Iu+
	 dYg86q/Vh9/z6x9SPjPRnT7q9W+4qvka89fQVaBcHDlxfS/cbvZni9jMpHqYyV4yvVpun
	 dIJ0L25Ui80EQGPKhH2NLELiRBVR+eeTWpmhyowHoCU9ZWFP1bvlBE1EzzTHGJ5WAvmUu
	 5Pq1bZ0V19r2XBqk1uCDHL2CIPTFLSd0mm76m8Ex7P0HRPEIzRvAdHdL8Av3HXtrHPVCg
	 v/RoAu/rOshJIz2yrJjHd8sBx6dB1YWNTPhR4ICM+8NEdVcmbqyb/vrz1/2CitwAYVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=HoANQWyvBJNi90TVZH8eI55sg2XWI2+CtZ/tLg6JGlI=;
	b=Q8cAPtRfeEhXRU8huvqSZw1a1z2RzAsBdz9tjadQMCLVrRk8PGmJi0Zu58s4iLB1A5N8
	 jBdK/vbSok6YnY/yDrwqfC1e8ocWYb3hAHjlDSkWTM2sVtDsrMY1SX0WwXcKEx1iiFEqc
	 1zJ+CKo4CL+Fv3s/PP6lWB5uYYM4/kreH95eSKA9JOmy9kzrBtWmomXl7wvwJeKO8ueb3
	 ApGlcB/jR01pVabQuGED5WXcSWO/2tJXDEmamXCiSdDPqqY5pIl/3MsMTUQbXxQZYEHTz
	 074fLIu8gQZEfKek2+cic26TEUYvIoaHo0tOER7/ndyS5pCW1Cae/6EglkJ3axQX9tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EwZq97WE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46362606A31A
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 19:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46362606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EwZq97WE
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-53c156ba662so1410617b6e.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 12:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792439016; cv=none;
        d=google.com; s=arc-20260327;
        b=KIbaEM75y06n2QciltGlghtc/nglStLe+7hRg5X8I1rSsDSof+02y45L76ntjTMcA0
         Xuq0FfTPU5XmYf6Z9ZAhU0RlsUhu04GdbBu/LX2m4CHUxO1Md4HwbH1HK5bjn9NY1VoN
         a1Rwkacl+CMmKYuNo/rbxEFLSR9NRV3GVsQSIDBK4yPzOEx3v1RLvgOYgrMZo5kuXMrb
         0pCU1ps6JYQe1KuwZNHmaq6P6subPLTWVSKa2pfTICPvBbE0HROOpFw2BYl69L6L8Am/
         3GR3t3KAinS6yss+Qk/8TpICuRlnxdIFWPMNoKKC1ht1Bib48avlKugzM5PHAfiJaSTW
         ANng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HoANQWyvBJNi90TVZH8eI55sg2XWI2+CtZ/tLg6JGlI=;
        fh=Tczw0obM6Dp6WXaqRz6LMjv/5C+9GaR+vl22Gr1KDWM=;
        b=oitI4i51lv3LpOjPN1UGHZJ0KUMn9+lqS+gpVD08VnivxO7FREoezQHEx6azYVLDwT
         90YZqBFy4uTIccGk+fj2OPWyPoRKSf9WXt4enojfWrWL/XgSvHpxy2T7KNNbCOiqLQo0
         YdY5MT6GVp7d+Zc8pFiaKxjjkHM7Tgw4ibCnqMGGOpxt/G3ESvkZglnhMEUCGBX7p2hh
         B5+6Q6M4D8Ex4jT2FfJDjM3ltmi3Lmp9QRebm8D9bNMKivMvbiiI2GzYqhXYM4nRS65M
         w+JR9RBwMe7TOWcM8cqV6ScYFiHvAE1trErlvZnInNcWgSWQNQHbj7vqZBHwWKNUlU/h
         Ur7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792439016; x=1793043816; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HoANQWyvBJNi90TVZH8eI55sg2XWI2+CtZ/tLg6JGlI=;
        b=EwZq97WEjq33PCcvj6Rcys5OJc2PRHAA4PFruJ7+D7z3tzRRgE1DlLVBq5ROF2T6Tg
         OiHtSYdxGiU1LA2cxj6WOEt4QTtMyPdkpyllSMoyF4Ps/76Gppc7QECxcL3D89gJ/EE8
         tZt/BA8pXLaKrbEEkcIoV7Y+XN2ONEVuC0qvf7uY4VGho2f6hgHSn4uF4oEK6aBmDEHL
         1O8hF6yLBkbYXJLiP7e+tTISLxiiOVsr+qSsw+c75Eq8LgzNHSYrRYRUsL+eo+qYCvrA
         vqmZJt1lNYe6MIwclqlZ/CtnYzOVWChQiGctJlAdwptTHpJsHvMlGsl7cUBUG+kvznfb
         Yd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792439016; x=1793043816;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HoANQWyvBJNi90TVZH8eI55sg2XWI2+CtZ/tLg6JGlI=;
        b=hTMfMYKnD3Y0cyWuQjUOJLOwfmDtDDmbAZl8mw9HXVU0RaT93cy0Wxy8AQwPXqVMdM
         u2kOzbz0HTJKZjsSGsPXOLMHhzAS1BPwv5IrsqjwfZ4RxwHDnREhHXDcwy8b4BqOGByW
         3RpNthsRV7VnkaZNwHapN+SRfCsoxlKCk7GBAXBb6I27jsBbNqK7w4xCXZdu2eFTCDGy
         Ux6kXl67bje8M816FR4y7N7Plq46zophtDvrgOluo6QwRGEMxi0SDDq2ub9iK47JHx2R
         s81koHcL9cZ44qduc9Nh+V5QfZL4LlPWNF+9P2KECPGZlOrt540me4+06qdY9sQezJ+G
         uJoA==
X-Gm-Message-State: AFq9FYKTafcAIQpXrHxij9xO3A4L05HqCDw5w/cxwmKh38BxCd7SVtpI
	+sx/5rfeqxfIuiLXt8BRNLDJSCiOgIHigA+XZTa0jsWonNfx5lYGuwmUjjkHCmA3wfRlHZYUJpv
	XtHQILgrE1w1BpcMCKcaUJuKvKN2RoMw=
X-Gm-Gg: AYBFou1TzoIWM7xLT+/JpLF+4h0pEAjwBhtQq/xfDlLprvaf8Ap1NfuIQ4y7hQQJesG
	o3t/eSuX6q+DCzLpg+2By+/5hvp3uwVq4XOrUbebr/me3DDniywlx+FGZX5Oi16ki1dZFPcAPwl
	GIZmKznXr3ICnfrqzZODZSmm5m1Je+duSb+CVCzse43RJ455dgURzduj9buN+Y649z2Vs2c5eV4
	GB87KA4EIdUA4cu73z6Inm8ki2+bV91wY9ePcIqusUyqiXBzwB5p1BXfXcDRUikelnElYukwe2N
	y6QU6Op0DZg3VLnamy9s5+hrcBrdvZyQoiA4+8ctsos1hSBHkMO079qcesMFYlsX
X-Received: by 2002:a05:6808:c40a:b0:4ea:18f:649f with SMTP id
 5614622812f47-53cc5b5ba80mr6837204b6e.3.1792439016084; Mon, 19 Oct 2026
 12:43:36 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018205305.2634339-1-andy.koppe@gmail.com> <xmqq33u165dp.fsf@gitster.g>
In-Reply-To: <xmqq33u165dp.fsf@gitster.g>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Mon, 19 Oct 2026 20:43:24 +0100
X-Gm-Features: AclHuK8BHLAx028PWwTe3DgitlHPqIvUWhB_9qheVb1FdXABvNevIjwY0vS2zJ4
Message-ID: <CAHWeT-Z5OhJLYx21V417DoL3xOQJj6viUzCm+04iDe0zu=jVWw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: pin cargo --target-dir to ./target
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Shardul Natu <snatu@google.com>, 
	Mike Hommey <mh@glandium.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 17:07, Junio C Hamano <gitster@pobox.com> wrote:
> Andy Koppe <andy.koppe@gmail.com> writes:
> > The Makefile assumes that cargo places build artifacts under ./target.
> > That assumption breaks if the user has a custom target dir setting, e.g.
> > in their ~/.cargo/config.toml file or in the CARGO_TARGET_DIR env var.
> > This results in a link error due to failing to find the gitcore library
> > built with cargo.
> >
> > To fix this, pass '--target-dir target' to the cargo commands that build
> > gitcore. Add it directly to the recipes rather than to CARGO_ARGS, so
> > that it isn't lost if CARGO_ARGS is overridden.
>
> The change might make sense, but these areas are touched by other
> topics in flight.
>
> Given that they both appear on the same line as $(CARGO_ARGS)
> appears, I have to wonder if we want to instead just add a single
>
>     CARGO_ARGS += --target-dir target
>
> somewhere early that are unreleated to these individual rules?

The problem I see with that approach is that CARGO_ARGS looks like it
is intended for build preferences similar to CFLAGS or LDFLAGS that
could be overridden on the make command line, whereas the target dir
is a hard requirement of the subsequent link step.

I suppose `override CARGO_ARGS += --target-dir target` would avoid
that concern, but also set a trap because any subsequent modifications
of the variable without `override` would be quietly ignored.

The conflicting topic apparently is mh/rust-crate-subdir by Mike
Hommey, which moves things into a 'rust' subdirectory, but is looking
somewhat stalled:
https://lore.kernel.org/git/20260917060415.2986259-1-mh@glandium.org/

I'd of course be happy to reapply the --target-dir tweak here on top
of that if it does go ahead, or for Mike to just add it there.

Andy
