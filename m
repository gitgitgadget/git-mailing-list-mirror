Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA114A85
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887206; cv=none; b=qcv/V2qByGj3eo4LEtYM0iyCuLLEGi/kEKucKuMBAmnezwsFjZ7MImBSSRUZaTTVHRSlh4BiejFRj6Psp3TvpmoqafL77ZWcleyoP1bTZOaRwbtTq+wy+ewOfI8PCZsUwft56x87K9d+je1mBMhURRXHQs0ewasEyBXl/Lw6RKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887206; c=relaxed/simple;
	bh=bAZJWjAMgkxW6RKsPcth9288MRffrRMNGxY9gneXm08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIVAAe3xicn0xj//BUZwbQdSJ8GsAUZeVBwmdA3z/Vwe1RD9GZVBhp1AMT3fteT7F/oLzxehPEIoMjOfeQQ6OqkB/Lr3oPsSghtR5grE+M9RAbWyoOKkW3NrhfFThDAQRkGwjXxUTeoOygyeyDLZOJzbfeAcL9seRNm23qADxqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ErCYOpJV; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ErCYOpJV"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5d5af743b8fso5272527eaf.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 12:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722887204; x=1723492004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/kBjVz8nZvc/nyXRFW7HmILzjAqya+GCL7sjFl7LSLA=;
        b=ErCYOpJV9nxUyKMVDgXJe5Ivezll6GRNF5oFOECZ9Vw0ztfb2ZRVWpuKtM5G1+p6y2
         GxBBHTX55t5pdlEPaz8yZ4oOqonwIbakK468Y2FejswMhAyd9AYSGx47nIO4LnF4PaRD
         Fwrd++Zax8vLjuVR6aiXk7dKCJ58S1aKavCDvZbfv8bjAi8pw1B8CLz3FxqVrxQU6Z5O
         XxeueiSSIJJeCTRn9sjWfNbGqbI3yp0xvjaOW8r+V7ZuuMqxeBnsTvtTDK8tzboAj0J/
         85RNqqeG4hi70FedJXjirvBXbwtJSd4zedjbNNvK5xL2Ue89rqghzFC5+NM/Uf2AJOzT
         7+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887204; x=1723492004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kBjVz8nZvc/nyXRFW7HmILzjAqya+GCL7sjFl7LSLA=;
        b=w5mKmm/EgD85mgaLr/5xrm7Q/K9nWSTFz7otrEDUbu/AGnAPY6iQ11z0iyDIUhkdiA
         Q6MrYz09L1PzrQ9t+zymPQkjhAhQbQ90gt6f6ALBkx3Ipn/uau6TQOKng8lYek+7Tzka
         VhXjFlUmxpjwoP0HqmUoC8/wtjwdazT/EqfjegTzdTlPnl3fPyS3KJrvsrVavzowr51j
         8Mmz+ertfWyBDzEdDd5SloMxhVKMLHYOIMKk2BYRz8beqALRNCIRjnAvdORmqmQKfH7T
         sJVlsKCLGHWm8hUITLbWv1EqNXwjf91fFZ+rShzrLmqVR3+OJOo6kyG4+osCkkBOi0gn
         Oh8g==
X-Forwarded-Encrypted: i=1; AJvYcCWwAkVcI0SVdGhCWc+Uo3pI6vBbQNyQZPfcHh3VKrgg98uXtNFriJDtdkdzKK16nDcZiGXnTFg1i8RVdsvg3B0LbTqx
X-Gm-Message-State: AOJu0Yx2zwPlEpdqjqilrQxHtVtcjLRUBIveBB+/RPzcBxtcuGhugbd0
	Z38+8z5rkec18GhU3q0PrzyMG83Om0RFmGtGJwwtWPCLqzGNCScduSDBM/xiU+c=
X-Google-Smtp-Source: AGHT+IEMc7jxF3NdH/6OVnSHQyOzb5+OdxFP5EN3uUZ3yaL+XoVXFyAkYbCDpSPz3Azz/b2nnNuk6g==
X-Received: by 2002:a05:6358:6481:b0:1ac:f722:4c1 with SMTP id e5c5f4694b2df-1af3bac737emr921506555d.24.1722887204212;
        Mon, 05 Aug 2024 12:46:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a1424f3e4sm12938747b3.146.2024.08.05.12.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 12:46:43 -0700 (PDT)
Date: Mon, 5 Aug 2024 15:46:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Han Jiang <jhcarl0814@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] config.c: avoid segfault with --fixed-value and
 valueless config
Message-ID: <ZrEsIhWTgkdNn3I/@nand.local>
References: <c78bacfa8fb274fbb48f259b13f4f30253932f69.1722532013.git.me@ttaylorr.com>
 <ZrDH3ryOO0wIJIDE@tanuki>
 <xmqqa5hr55yb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5hr55yb.fsf@gitster.g>

On Mon, Aug 05, 2024 at 08:45:32AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> > Edge cases like this really make me wonder what the benefit of implicit
> > bools is in our config files.
> >
> > So... why do we have them in the first place? Is there even a single
> > good reason?
>
> There isn't any good reason to introduce such a syntax if we were
> desigining the configuration file format from scratch.  It was added
> because originally Linus thought it was a cute syntax, and these
> days a lot lot more importantly, it is kept working because you will
> break a lot of existing configuration files that were hand tweaked
> if you remove the support suddenly.

I agree. It's perhaps interesting to think about in the context of the
discussion in [1], but I think also worth having some perspective above.

Sure, this configuration syntax would not be invented anew today, but I
also don't think it's worth breaking existing configurations, even in a
hypothetical "Git 3.0" release.

In some sense I am sympathetic to Patrick's argument, but I also think
that having a bug in a relatively niche feature like --fixed-value that
wasn't noticed for almost four years over 17 [2] releases isn't itself a
strong argument for removing the feature.

Thanks,
Taylor

[1]: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
[2]: $ git tag --contains c90702a1f6 'v2.*.0' | wc -l
