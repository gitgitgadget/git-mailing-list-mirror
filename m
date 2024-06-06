Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB6196435
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687964; cv=none; b=amBKprWYMTW+CVXbpJj3CH8KylN58S8z7RbXHNWHIJw4QpkS3bKgdi9Xk80JwsGdSQaDB9rj2rcWgviZLzLC9Ckx8kjhvjuKQYXL4gNuaYRPPXtQxBxhMaAGzPry+LfwrW8OvHMpJDMAOW56nVTNWejf9TCzm7P/PIYravV5om4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687964; c=relaxed/simple;
	bh=jJyUgk/8rIhijIWLG65AFv7DVXDepqg1R3pKoxTiQrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwACoL14GJprjyBnWCz0r0q0RMDTJyTiiIZ5Cw1e30uuGTT7NHibg5tzgbSLbNiqFs44LNuUUhVQ0QF8B+RJWH4r8kQnefPZRK3UXcy/AG+mhHCbXs+arFvmSOT4jEh4TPsJvkyHE/IRGI90S9+3fwQfwb/SIKYePHsMsfnj8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUqLZiH3; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUqLZiH3"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24c0dbd2866so562446fac.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717687961; x=1718292761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LCSLmyNNkbS3wP+pKknP5Cli0oyDp8K0ixkX37ywwGU=;
        b=OUqLZiH38cNq14x/hnyqFvhxvoZUHBIr1q/P+dD7h5BlcXXxDqoN6kL39DJUJteW80
         hKZ0rbWmsI7PnFz3Gk9nTzVgJH4giKkqZBtkbt3sJb7g7hZaEWgDCbhBi77Dfc5zLDi5
         84dCSOSvOF8AVZrjFlelWUjs4+CpFpLuUBccE0szAHKPxR0VQv0jRpyN19O9F9OBdgjG
         fJcgP3gPU7acT9nNQCOxN4hssDrDs5FgWOUc6abUwoI2FuPpfVDNygx3uTusyEE3w+9J
         6VAx+NEzGIW4Tb0Q/VRxz0G1Wl9opJErKHtpvXhfnhtwfs2eZrb72r6irFKwn8oqt8Eh
         MGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717687961; x=1718292761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCSLmyNNkbS3wP+pKknP5Cli0oyDp8K0ixkX37ywwGU=;
        b=d+eNDSXjL2X3GYPpSP7eYB6hAZ7h+Ib5eylOoAFqqCxUXeVEjeKSBr+mssN7iLrxBq
         VvpGWht02Bul5xCgffqZAwPzajNwITFXeRuslfu6szb8897D26UIkyHdbwSB000jHp+r
         Xfh7HHZCKxbovvh0OqKED1nGR5WkrSYPUNH0xOy/mZ6DtUmfCoOX6JAkaVlYztHGOQrL
         kHrgAZqBmc458q/ThYZvy6sXqHKQddfU/i61Dv9aNfmJsqjtr/3h0FKE2ASIUoUBSQ21
         5S0PO3tNQPDum9m/4p3XK+vT4TAeE7LJ8dnioSUmzvRFmzMm/PLArp/RTcNm0h1t+sTQ
         MhaA==
X-Gm-Message-State: AOJu0YxlHcqpIRjYiHWCfMbbx/Zl1lhCK5k+lKEzP3OGX95kPg4kwUgV
	b5+4omSy0+XGMe0QJe0dXm3IjKGmtOoJF5vRQyMt1puRSMNmavpb
X-Google-Smtp-Source: AGHT+IH3FGb2Go69PS8fwbQ0lQqjA8yhmbeY9pUIiDL51RbeiVxnY1cbYRFYxcO5blmaJo/jCcDm3w==
X-Received: by 2002:a05:6870:8995:b0:22a:5ffd:5e40 with SMTP id 586e51a60fabf-251220ffb84mr6621555fac.59.1717687961547;
        Thu, 06 Jun 2024 08:32:41 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25447e2922asm404435fac.17.2024.06.06.08.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 08:32:41 -0700 (PDT)
Date: Thu, 6 Jun 2024 10:32:33 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] ci: compile "linux-gcc-default" job with -Og
Message-ID: <crfguam2loy7nrwenirbt3rub3vj52nvhxuvr5foyx6sd2weez@vjnnzrmc6scc>
References: <20240606080552.GA658959@coredump.intra.peff.net>
 <cover.1717662814.git.ps@pks.im>
 <bdf0e40a770c57b63e7519983d37b97a85ce07bf.1717662814.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdf0e40a770c57b63e7519983d37b97a85ce07bf.1717662814.git.ps@pks.im>

On 24/06/06 11:31AM, Patrick Steinhardt wrote:
> We have recently noticed that our CI does not always notice variables
> that may be used uninitialized. While it is expected that compiler
> warnings aren't perfect, this one was a but puzzling because it was

s/but/bit/

> rather obvious that the variable can be uninitialized.
> 
> Many compiler warnings unfortunately depend on the optimization level
> used by the compiler. While `-O0` for example will disable a lot of
> warnings altogether because optimization passes go away, `-O2`, which is
> our default optimization level used in CI, may optimize specific code
> away or even double down on undefined behaviour. Interestingly, this
> specific instance that triggered the investigation does get noted by GCC
> when using `-Og`.
> 
> While we could adapt all jobs to compile with `-Og` now, that would
> potentially mask other warnings that only get diagnosed with `-O2`.
> Instead, adapt the "linux-gcc-default" job to compile with `-Og`. This
> job is chosen because it uses the "ubuntu:latest" image and should thus
> have a comparatively recent compiler toolchain, and because we have
> other jobs that use "ubuntu:latest" so that we do not loose coverage for

s/loose/lose/

> warnings diagnosed only on `-O2` level.
> 
> To make it easier to set up the optimization level in our CI, add
> support in our Makefile to specify the level via an environment
> variable.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> 
> I was a little torn whether we really want to name the variable `O`
> here because it feels so easy to set it by accident. We could rename
> this to `OPTIMIZATION` or `OPTIMIZATION_LEVEL`, but that's quite a
> mouthful.
> 
> Alternatively, if we don't want to have this variable in the first
> place, then I'm also happy to adapt the script itself to pass the
> optimization level via an argument.

I think the variable itself is fine, but for a name I think that either 
`OPTIMIZATION` or `OPTIMIZATION_LEVEL` would be a better pick. We have 
some other lengthy environment varible names so I don't think its too 
bad.

Otherwise, this looks good to me :)

-Justin
