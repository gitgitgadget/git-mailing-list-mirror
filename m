Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F16374160
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776204594; cv=none; b=KtFGYqGMbOSoUuiZUvnffP/STUqg+nADSWbLZ9XMBI8yp3QvPX8Hyc3eSPMws82HrpA/D0IoYrJrJWMw2hAcR0VTmHzHwvmUH8gX3y652LqVDHtvMN4Y2EfKtyqNSwU82HBPzwH7LiapkHYLSiK7SvmqqQlCNlvbgZCS1E16qpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776204594; c=relaxed/simple;
	bh=HyRSYOb8vLSN/AQaoiiwiMkEW69rt3Lv4/WkR52BkKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/4TD/jWYRL98Bg/8fJNuyBpQXZaCyg/beyik2hA/xqQCRvLKawD9kQKoBse2yaFjVB4jX/xJ4hyPXahwmFVMx/0mDDeg1iTgrMaT1PQeEY8tIn+PkoRZDeG+L8lPYikC5zsBTPo8sxNMqsaAVNY1XxRby5HmzCjE1YKfaTCo2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=bliM77F0; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="bliM77F0"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7b4ee3a88e1so14968957b3.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 15:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776204592; x=1776809392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGB1lqmMR78E81O+7AX9UkhUHarTn6FgCIhig2JMZ7U=;
        b=bliM77F0uB5buExp62EYmqxloV8WyktB64tifC/emXNOFfuwds+O8SF/MG1Ugzypuh
         0rs6fkp0X2KV5CkCsAJGAe/C+15ktIp9aM2K9A/gS3pyY5bqzS1rU80BCpGbvBnJNg4k
         Sj+n7SpRyVjNehrzRd2tC277PcNC4RPgxY0e2fPeCoW3e5RGCLrTn14HdkHMp66XXNGI
         kRTaWg4wOcEnj4FPpPvDRKLzyX6h/sB+MKfFGiI88btMfZtFho5fv09DUZkDZwfU0mVr
         avKWfIJ4GK0Z0a2cPNFAMSagwIwGcaUAgW/WgW0ikZzn8GJB9cbElOmSfzQ+EgVAXPN7
         9hMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776204592; x=1776809392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGB1lqmMR78E81O+7AX9UkhUHarTn6FgCIhig2JMZ7U=;
        b=jFuZ099VNrFGxJaIfaPXp3qXK4vYDcxTWIt0TDVzP42jo1g7ywFwktBdi2/6vtqe1n
         GSnA8juXz4Hj8b+0CykjKjG2EDId9j47iOKFLxnbWaEk8QlKNW7TEMjEUDeteED8m10P
         69FdZXZ8LE0+X91kFvP/VHhQmlEbMv5QNgHlrp/ycAEFxSyadVzEfDQfeQpA6w1KsJgB
         7pa/ste92GW8puAaRo33cOc4PW4nXVi0pfyByAC5sa+CLC/7Iaf4FRNQcqW/NkL2OQyM
         cnyc539Ws0grEV3DVmlb9GM1foVgHNy2iBNyEeds/ovfkOC6Btl67QECln+/Ff7VqvIy
         L4mg==
X-Gm-Message-State: AOJu0YwHtPssHFHONj8l8VLU8QKNECs+fFFLdlBBgHkgZ+h3YD8Z0MLh
	0TkBjdNORcqd6HMHlLFgTIXoSlQZ8I3VyFQDNTue6MQvh3RmRgL4PfPd0G0JlwZcSPk=
X-Gm-Gg: AeBDies6I6GVkIO93Svi9MilaKKd5K2z1ArnOKvqbkCTtGAlaqyQBQz1v5g/j/fiLkQ
	hGxwwWThBH93D9JBeOIEUcu44QPzlYuiQ+WvUEhYIFkjVB+fE4M+lhKcIRXC8J1XmaJfLw0wChG
	bVgC6u2fr7w8lMfkmHmPAVyaYPx6//s7NftGPNcO+cjwGn2bd4mt2iKVkwzRerpcDgJs8Az8MEY
	PxtMm3JWnu7ym+AKqucwaS6l1iYW4XzfIif/aZqDqzZ5MG2zBPVWL5/KkZjUsD9ICdR6WcmKo/k
	P+DQjY/06mlZ6WvOCZ5hoKxio/0oXNQi/h0VYE5j1fZbb+L80hhdjUFWrSn9XKA9CwJLbLX1AB2
	tXq5QR0FPXF9sZRAi+gL7YfGgQDBxHH5dB/3d1FDjyMt3vrSTvS9bvENLG7mwgOh857x5+l9zMw
	u0/vj0FVkPz4v5SIglMqXqeWJFZTSKGhylf+lU5L+TXzL0nKMJmcx1GLEcb0SOHyRqVxkLpmHkr
	4Ob17VMfNY8FI2eFPYA6mEIeZj+Zj2Xkq4rHMqmTYQHOFy+aZs0Hafp1uDBb/t8nmAyXqGytKSK
	7kdAsT1+rC48cBCD7HLXcs8Tw3I=
X-Received: by 2002:a05:690c:6309:b0:79a:b0c8:da68 with SMTP id 00721157ae682-7af6f32a538mr227090787b3.10.1776204591858;
        Tue, 14 Apr 2026 15:09:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b7662147d6sm93017b3.5.2026.04.14.15.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 15:09:51 -0700 (PDT)
Date: Tue, 14 Apr 2026 18:09:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 06/16] midx: support custom `--base` for incremental MIDX
 writes
Message-ID: <ad67LgVcCeQubMbO@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
 <6b42d284b79a25e97d506e22c709e4dbe6fddd58.1774820449.git.me@ttaylorr.com>
 <20260407055753.GA714878@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407055753.GA714878@coredump.intra.peff.net>

On Tue, Apr 07, 2026 at 01:57:53AM -0400, Jeff King wrote:
> On Sun, Mar 29, 2026 at 05:41:06PM -0400, Taylor Blau wrote:
>
> > Introduce a new `--base` option for both subcommands to specify the
> > checksum of the MIDX layer to use as the base. The given checksum must
> > refer to a valid layer in the MIDX chain that is an ancestor of the
> > topmost layer being written or compacted.
>
> OK, that makes sense.
>
> > The special value "none" is accepted to produce a root layer with no
> > parent. This will be needed when the incremental repacking machinery
> > determines that the bottommost layers of the chain should be replaced.
>
> My gut feeling on reading is that a chain based on "none" is really just
> a non-incremental midx, so we could just write that. But:
>
>   1. I don't recall off-hand how expensive it is to convert a
>      non-incremental to an incremental one. I.e., can we just rename the
>      file and write out a chain link and it becomes incremental?
>
>   2. Even if it is cheap to convert, I can believe it makes geometric
>      repacking easier to think about if we just always think about it as
>      an incremental midx.
>
> And perhaps (3), I am just wrong that they are the same thing. ;) I
> haven't thought it through all that carefully.

In this case we are truly writing an incremental MIDX layer without any
parent. So it's logically similar from a non-incremental MIDX in the
sense that there is only a single layer, but it is still an incremental
MIDX nonetheless.

We have to write these as incremental layers, since we can't replace the
main $GIT_DIR/objects/pack/multi-pack-index, so that takes (1) off of
the table.

> > If no `--base` is given, behavior is unchanged: `compact` uses "from's"
> > immediate parent in the chain, and `write` appends to the existing tip.
> >
> > For the `write` subcommand, `--base` requires `--checksum-only`. A plain
> > `write --incremental` appends a new layer to the live chain tip with no
> > mechanism to atomically replace it; overriding the base would produce a
> > layer that does not extend the tip, breaking chain invariants. With
> > `--checksum-only` the chain is left unmodified and the caller is
> > responsible for assembling a valid chain.
>
> OK, makes sense. If we are using --base we are doing something clever
> and weird, and the chain tip should be left untouched. I guess "midx
> write" would never delete an incremental (it is always just adding one
> more to the chain), so we don't have to worry about that. Presumably
> we'll eventually write out the new chain tip from the caller, which will
> then have to remember to delete the now-orphaned chain elements. But
> that's kind of the point of the new geometric approach, so it seems like
> things are falling into place.

Yup, that is driven at the 'repack' layer and will appear later on in
this series.

Thanks,
Taylor
