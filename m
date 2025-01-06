Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7F4BA34
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736191082; cv=none; b=ZB2l3lRt5UBLDHFqxIplTkXlHx3lZtIEjIGwbBCAa5zU/RXW1JiUxjckSTmONd9837IFvRiQHWGajxyC3aBRq8Qr3sYHA/AdycaTMtwB0bpN+La2Mmje2eSSh8Le0DBOe90sgM3Kig0uE31nPZ7Plr2WW70eeGAY4g1IzMh+ml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736191082; c=relaxed/simple;
	bh=gEmthX74wcLo/n9U9B4ngejlmg2IAJQGbS4o6TDJHH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVNW/WMTm1U9e8M+7/rlfoDP2aPfs6gaFJk7Y6QpENGKFVxk6hjwVEckIvj4z8yXqmGhZmBSo5cP6Ty8G45njSrCVlwPKooLG8qSE/2fr8+dqzXErFxusIwHYUaQPg0/lTUiPSgNps05HjahON7dczeDJhfq7jQI9gxyltVrtDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=XRHKdC8d; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XRHKdC8d"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e461015fbd4so14409864276.2
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 11:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1736191080; x=1736795880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SqD3isIj04c1xUuNMd2Fp11payUkPZsBAzImsLB7NlA=;
        b=XRHKdC8dqYtqGmQs7gUuznLLRA9lBNu+sO2AgBVS+DQRCKKgUCjWTvbYel6aFj5eyn
         kW2uSCyXo6J/27OXuAFcSD6wl6DycZB64gbdgbIgbIpyobUHM9Oxe4fNe3mQQtTE9/lY
         z6H9VKxuFoQa3umjnYG0ebJtgNfKgn6P7nhvfovvwNnBNBzrrFUaNexzvmhjVqinnDPH
         uzy5x1jYnMJFA3IkvCEhYBcnxG492S7yO0lWy2RgyHLwGzBkBlPX4TLFD6jeQw48sTfj
         /axJNq3vUuiwZomGPnJ0pAqg7PEAANvpDE+V2ws7QYhwtB32V+OfbujxLolMMjeNeaEw
         BZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736191080; x=1736795880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqD3isIj04c1xUuNMd2Fp11payUkPZsBAzImsLB7NlA=;
        b=UEP0DiNJLTrMdoC8Vev/xYUQz4ZR57MobfpRPXx5PzVPVA83bPAmqociug86Sn5WWC
         e/AgN3Au1iJqnvNUHyqwJMKEeR+3kJrfT8GUguGZWNjwr7lM8Qb0N8v9TQJhFvzRpsDp
         4DCNkxD3LD3TGxYw7sA10e3PeTFXhRZ4tqGzHVaL/kpXKjs3WZSYIteIsjH8QwORr7Ig
         kNsBX/VaqLfi1G11ilmkISgENyB14HS9l1knAV/SIrs0wFpl5ZrFmi8y3FKDMePWIP65
         UnIi3bADREBlftT1chfdpikSImjf35ygYWRJ+VOKM/LbTUoE2Q5LRpMUBO5B3uoZMUgw
         ePhg==
X-Gm-Message-State: AOJu0YwUt6o3vygYLOj/ew/8xMbpXcL0n2/Zg/xC+j8L44PsRkcUDDnP
	R5A/mo9uBNhzrBHqiIeJIGw3aLsEhBL9YwO2eNG2e3gcmroNwwD4EiU61hCUA54=
X-Gm-Gg: ASbGnctasOO5NVkB+32CZYTZl1zMFij2NJTUWaQuB/yn4yNuvzCNjkl6deJUllFk8mg
	f74P0KS1PuwQYAtXBTv9LAjttkTgWVRXqMW1BC91go36iE9CW9H7hlHsIb82lL83d/KkuBsFkUm
	GSQQ87NDDSBrLG65pSEIFYfzRRnVxqmmKX1T0CUgUPOfN1IC1kw9LF0U0VXE3YsofKp3FF1qeXv
	BbPhh9f7frvvzvSVpPe6wwbKxsS4oHMjc5jY6MuALANWZzmeQOB9kTn75m1BHLbhXVN3xbVrBpB
	9aGC0Nug5Xa4Z6RQxTuv11f8l0ci
X-Google-Smtp-Source: AGHT+IGbHEfiBZ5PY0HooyB0KGd2rJgEBp+C2HqMPhI6jq+u/jSH5QMsctJu7V20PLnpE8jKvje5DQ==
X-Received: by 2002:a05:690c:9c0d:b0:6ef:81c0:5b61 with SMTP id 00721157ae682-6f3f8115166mr428992357b3.16.1736191079822;
        Mon, 06 Jan 2025 11:17:59 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e743ff00sm85500947b3.32.2025.01.06.11.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 11:17:59 -0800 (PST)
Date: Mon, 6 Jan 2025 14:17:58 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/10] builtin/fast-import: fix segfault with unsafe SHA1
Message-ID: <Z3wsZjAqbfI/EdVe@nand.local>
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
 <20241230-pks-meson-sha1-unsafe-v1-2-efb276e171f5@pks.im>
 <Z3LNVzw9UlS7SWqe@nand.local>
 <Z3fhK1ACzJfVehM2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3fhK1ACzJfVehM2@pks.im>

On Fri, Jan 03, 2025 at 02:08:01PM +0100, Patrick Steinhardt wrote:
> On Mon, Dec 30, 2024 at 12:22:34PM -0500, Taylor Blau wrote:
> > On Mon, Dec 30, 2024 at 03:24:02PM +0100, Patrick Steinhardt wrote:
> > > diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> > > index 1fa2929a01b7dfee52b653248bba802884f6be6a..0f86392761abbe6acb217fef7f4fe7c3ff5ac1fa 100644
> > > --- a/builtin/fast-import.c
> > > +++ b/builtin/fast-import.c
> > > @@ -1106,7 +1106,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
> > >  		|| (pack_size + PACK_SIZE_THRESHOLD + len) < pack_size)
> > >  		cycle_packfile();
> > >
> > > -	the_hash_algo->init_fn(&checkpoint.ctx);
> > > +	the_hash_algo->unsafe_init_fn(&checkpoint.ctx);
> >
> > This will obviously fix the issue at hand, but I don't think this is any
> > less brittle than before. The hash function implementation here needs to
> > agree with that used in the hashfile API. This change makes that
> > happen, but only using side information that the hashfile API uses the
> > unsafe variants.
>
> Yup, I only cared about fixing the segfault because we're close to the
> v2.48 release. I agree that the overall state is still extremely brittle
> right now.
>
> [snip]
> > I think we should perhaps combine forces here. My ideal end-state is to
> > have the unsafe_hash_algo() stuff land from my earlier series, then have
> > these two fixes (adjusted to the new world order as above), and finally
> > the Meson fixes after that.
> >
> > Does that seem like a plan to you? If so, I can put everything together
> > and send it out (if you're OK with me forging your s-o-b).
>
> I think the ideal state would be if the hashing function used was stored
> as part of `struct git_hash_ctx`. So the flow basically becomes for
> example:
>
>     ```
>     struct git_hash_ctx ctx;
>     struct object_id oid;
>
>     git_hash_sha1_init(&ctx);
>     git_hash_update(&ctx, data);
>     git_hash_final_oid(&oid, &ctx);
>     ```
>
> Note how the intermediate calls don't need to know which hash function
> you used to initialize the `struct git_hash_ctx` -- the structure itself
> should remember what it has been initilized with and do the right thing.

I'm not sure I'm following you here. In the stream_blob() function
within fast-import, the problem isn't that we're switching hash
functions mid-stream, but that we're initializing the hashfile_context
structure with the wrong hash function to begin with.

You snipped it out of your reply, but I think that my suggestion to do:

    pack_file->algop->init_fn(&checkpoint.ctx);

would harden us against the broken behavior we're seeing here.

As a separate defense-in-depth measure, we could teach functions from
the hashfile API which deal with hashfile_checkpoint structure to ensure
that the hashfile and its checkpoint both use the same algorithm (by
adding a hash_algo field to the hashfile_checkpoint structure).

Thanks,
Taylor
