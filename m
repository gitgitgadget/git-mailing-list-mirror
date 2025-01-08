Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E395786333
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364111; cv=none; b=PRgwlAUPbYNRlTxAOE4f4UvISzVYVoQrJFKF7iHC5GpBsn1NOv8Wn5Z5E3C7PmzeHH+eytTZ+E8Mb6tTROXAaZscfcIj3zQ1o3FJz67mhDWUkJgFSI1gC9Gh2cAp1XVclyp1uh9Awd2g7DgIMEKxr4NY1FahutewbVVgPN5yIu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364111; c=relaxed/simple;
	bh=9C1eZZGEcHJGxypReZDPkp3kojqv+3Vl6+RnqPyS8bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT14S7QH1NEr98qcTvp5pbiy6wca/OF1Qhb1ESZ7D1raGw27a4fvH+vCxdOq6teeoiWBRGpSSvdxj2cm01uSdLyQtNWBGEnHLVOuyc3GfqSEcu+JB8ViWvL2zXV/kjYtuEcn1IGEarTfEoPBQNC/p+NT2YGjq3u89JuBsA+MpW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cM8rynNg; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cM8rynNg"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e5447fae695so117626276.2
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 11:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1736364109; x=1736968909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bNgFgOzAhk9YNefuE0JrDgZMJ2qBgx1DY8lD7NogV+k=;
        b=cM8rynNgAwuKLB0FStLf3W/RwuL0BfdXXZqi+wTuzvINEpqn3Xz8uZWUYm448GYWmI
         gcSM9vQ0NaYyUwwJoH8m4XFG/hOPU7mrYb1izQzj1+whF7BXT8x7ZfUdiNDfeqeCVzCO
         dif+iphF00LsaSk2s2DEk1ICCgCjMx+mKtwCT3EVQIKfg8MI0faL72OLzk5SYnq3yX+s
         koabD8ehHrVCV/Od51PAyrxUfuWds8mU1uTjgFHCSpQvtVMA11tFq2byBMmz3EVUgLfJ
         g7ayTj+gggPZqytl37+mE5Gv1WrDKCokspYff2yP0lnmdtC7aAA/3U2EuFqX5mtePDEB
         dNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736364109; x=1736968909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNgFgOzAhk9YNefuE0JrDgZMJ2qBgx1DY8lD7NogV+k=;
        b=T+DXqkryrLNFQJ4rKEKPJ5mS1R2yfWzD+HXUvHdiDBE1DvbAi4C2Mz60YYTkj+esW4
         tFYkjuKUkIWINsMFvKpepe2kenEf33+8TbdmZMSB7cdCR663ptwQtvWcRsX8zL7L6km3
         CwebbPhFbEmNRVPFk3+3adY0GyuXP0e2nJaC0QZICf8tD3a38QKcl0GV7VzOeItZRtRE
         l3339uJnBgMuBFkTMXmUsx0g99PmNNm3pHIiWgsNOyDP9j0JN+lpnHxjdw2+KNUtLuE9
         NM65FmUCBKo6oT6uj7nlu+hLiMZ+AD65y7oUy0FTCKZFNH+CvvmIqHcKzcCSlK5uzaJt
         /CZQ==
X-Gm-Message-State: AOJu0YxEgDv81R7fOrsXNxGlDUXKLiTkCBib3FzKbsV4JQesA3dSIQRt
	uHMnamyXK9XLk0PdBQaLTonW37MB4e5p4/qt8aG+0CwVR/VCkPXU67L0DZmr2jS3VwYE6TgQOhG
	Jlso=
X-Gm-Gg: ASbGncviaw8VQmqZ/YBb7M/bUHSRzJXuhDK1YguFrY3+IqMxon5m7SLnKx3LiGFrhFD
	Nl3OD4dlcF43vPmZfM9cIy+JF9D44amM9wom54eTQcD6T7eE5A1ExOubC1/Gstwbzw/cCMTc5PT
	1qwxL5fPzZectE4LgVbJhJZjZGoht9X/jXe0teb/1aQLl0FdvrolXg5O+ssjGzXKTgEkDrLbof1
	99QKaN9EswO/vk12vIXBTMUNpQ6bgU9aSsKuhm6PKmzULWNhseTxw8jBPxF0fJSw2uWG1mmtoZG
	ZeAPGj9M/SqV98NS4kFU1MlEyTD3
X-Google-Smtp-Source: AGHT+IFzr39JyvTXB9I2aMdG5gmEBYKW/HxRDvwb9k8l4KLx6x+EV7c2JmMC3JGDZFvXl4R4fn618Q==
X-Received: by 2002:a05:690c:9a86:b0:6ef:8177:c322 with SMTP id 00721157ae682-6f53121b2f7mr35003887b3.13.1736364108859;
        Wed, 08 Jan 2025 11:21:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e7499c23sm93613817b3.70.2025.01.08.11.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 11:21:48 -0800 (PST)
Date: Wed, 8 Jan 2025 14:21:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/10] builtin/fast-import: fix segfault with unsafe SHA1
Message-ID: <Z37QS/MnGUZ7zcrR@nand.local>
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
 <20241230-pks-meson-sha1-unsafe-v1-2-efb276e171f5@pks.im>
 <Z3LNVzw9UlS7SWqe@nand.local>
 <Z3fhK1ACzJfVehM2@pks.im>
 <Z3wsZjAqbfI/EdVe@nand.local>
 <Z30YvHKjA_b6_xwt@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z30YvHKjA_b6_xwt@pks.im>

On Tue, Jan 07, 2025 at 01:06:20PM +0100, Patrick Steinhardt wrote:
> > > > I think we should perhaps combine forces here. My ideal end-state is to
> > > > have the unsafe_hash_algo() stuff land from my earlier series, then have
> > > > these two fixes (adjusted to the new world order as above), and finally
> > > > the Meson fixes after that.
> > > >
> > > > Does that seem like a plan to you? If so, I can put everything together
> > > > and send it out (if you're OK with me forging your s-o-b).
> > >
> > > I think the ideal state would be if the hashing function used was stored
> > > as part of `struct git_hash_ctx`. So the flow basically becomes for
> > > example:
> > >
> > >     ```
> > >     struct git_hash_ctx ctx;
> > >     struct object_id oid;
> > >
> > >     git_hash_sha1_init(&ctx);
> > >     git_hash_update(&ctx, data);
> > >     git_hash_final_oid(&oid, &ctx);
> > >     ```
> > >
> > > Note how the intermediate calls don't need to know which hash function
> > > you used to initialize the `struct git_hash_ctx` -- the structure itself
> > > should remember what it has been initilized with and do the right thing.
> >
> > I'm not sure I'm following you here. In the stream_blob() function
> > within fast-import, the problem isn't that we're switching hash
> > functions mid-stream, but that we're initializing the hashfile_context
> > structure with the wrong hash function to begin with.
>
> True, but it would have been a non-issue if the hash context itself knew
> which hash function to use for updates. Sure, we would've used the slow
> variant of SHA1 instead of the fast-but-unsafe one. But that feels like
> the lesser evil compared to crashing.

For posterity, Patrick and I used some of our monthly meeting this morning to
spend some time together pairing on this idea.

It ended up being a dead-end, since this approach only protects you
against changing the hash function mid-stream, and not using the
incorrect context type from the union.

That was along the lines of what I was originally thinking, and so I
resurrected my series to introduce 'unsafe_hash_algo()' here:

    https://lore.kernel.org/git/cover.1736363652.git.me@ttaylorr.com/

I got the impression that Patrick and I are on the same page there as
that being a good path forward, but I'll let him chime in in case I
misunderstood anything.

Thanks,
Taylor
