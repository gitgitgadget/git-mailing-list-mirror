Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D4B24B254
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736545830; cv=none; b=grcqGsI2oOAgMlv4g4pkNcxTlgMgSapAnejzrIESmRrIYUnvctLJHuAAVsLRXGH/sj9gqJZKgTz15TKAqHWwHCtzm8bUvpCTcWhkaYqwfm9BAPLcJffh7IAOn/K7z9IpLcyYXeZ6vZ1SobcW0cRYZ9MTJNMQuMDrNnYA/BRG8xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736545830; c=relaxed/simple;
	bh=+Ut8XOWSxW95tMqtCUgOr8yay3ALevIOKW9ZXq7B2ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxgKDBx/JLmtSplqahiLtIAx7U/zregD/eOuh0ZRNNIUekQFJndg1UJCihKTxHzTxiE86uyRg8pygxyIMvLYV8dQOwBqBDwUanz2vtzz2f8ijMt/J4L5kgFfNwULBdOIu7OghFkp69qtpQyhbmZCkOqgHUrogTnOluD8zNnAZhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=x3UxWWlF; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="x3UxWWlF"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e46ebe19368so3849186276.0
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 13:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1736545828; x=1737150628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qVZiZ5YuvW0A8wEPln/VN7cB3fj3lbbV3UFLnahH0M4=;
        b=x3UxWWlFcwyS4lWA0MQ51s2KrTvE6AHA2E+mRSMh41aFk162g5318rqT3hRHCrOxsI
         jW8b28GNPaiSmFRtRqqiMyPpN6SHiaP5SPQRRCLdFLVgy5hw54vL38N+hAEPB4MwHIsE
         uts0n2Z3BVb1krq18nAFVsYm5dabdniI8t/hk/gBYVGJ94d5THkzgeL4aDhacA6/hKdP
         E/DsZPkb0Nv/F4OGr0ZMjaKzrZaVBnnqDk5bNFfoeei/nvgYUlsd2OjJ3hz6BKjBjzvh
         gbS7N0BOPJryZwr9gViaNLhQGNc/VcjGP2+We8huL1MytMSxgJ3nKb1r8zlmnCOl9wjJ
         sp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736545828; x=1737150628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVZiZ5YuvW0A8wEPln/VN7cB3fj3lbbV3UFLnahH0M4=;
        b=Iw7RWHvld3y77L4jMcY2N6maqBqotN6Dl+fLciuL6EueAVXDYGxpRz8moUhn/HgICf
         xEhyCuWi19fx6XA4I1gsP4SQLmh0CsKliiFg8uy2AXINAuZUUUriZiDk9cIbI8A4GK9q
         8eAydbUpRL7osqGlslgjQXketUhlj8MieqB/JuMErfQAVJ8k7ci54P4gfT1BYElJOIy+
         UCxCsqn9wWE8FL3qzMrZQeOXGR2mWuRPxAiYlsJ8VGnMPBZY1CCoJVWkoHqv0/5RDNrd
         8NtFt1G/G01O9lgiYNXOBbnCCTA60ynfpNRqHmcU8epps3XQ3ZDX+K150Zallux2RO2V
         AeZg==
X-Gm-Message-State: AOJu0YwD2cRiDzo5E8lcYGf1h9qs27MJYTMEjJLQXU5Ere/lswXkT1Ad
	JYRu2Fmq8yzEl9PqZWuHfoRTy/T0hlos7Mixvun2Yr+LoLFLxRKipRp2xYBXtv0=
X-Gm-Gg: ASbGncsv+QumbjPFA8mB0SWFSNiaWQoDRyAJsdivxeUIfy2ortxTUNMwAkfx17IUG85
	0mkwAuGmA/oLbQoIdC/kAEsv/bMB4GMD64W6tswh5c2GSk8e3FmUXMDTICFsXyq4/m194uEuhc0
	7wIJ4KfxuW3UzNZbsyy6s4yCb6McV+i6/xhB9dvfuY92hR5HC7yYdmjuYZfUn7yJu8l5p1HcMwm
	2FHGwwM1k/Yz4vogB4nHa1jz2oHRLmHz7zSyQefAkIommNqtnBAOD4xrhtpoChU70BpPT1MKNCh
	kop8QJ/7KZstGoEqf7o6ODU/B+yw
X-Google-Smtp-Source: AGHT+IEflAFtJrbcDgYNXbdH72awKPAEjBUJo6Nr6Hoc2KGcN5fGVaGwZ1mzad42uOCARq1v2mOADQ==
X-Received: by 2002:a25:58c5:0:b0:e47:f4e3:87ff with SMTP id 3f1490d57ef6-e54edf22236mr6669768276.7.1736545827477;
        Fri, 10 Jan 2025 13:50:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e55a595dc38sm490932276.19.2025.01.10.13.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 13:50:27 -0800 (PST)
Date: Fri, 10 Jan 2025 16:50:25 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 7/8] csum-file: introduce hashfile_checkpoint_init()
Message-ID: <Z4GWIZkJOUa278VA@nand.local>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
 <94c07fd8a557c569fdc83015d5f3902094f21994.1736363652.git.me@ttaylorr.com>
 <20250110103756.GA1014709@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250110103756.GA1014709@coredump.intra.peff.net>

On Fri, Jan 10, 2025 at 05:37:56AM -0500, Jeff King wrote:
> So in the new constructor:
>
> > +void hashfile_checkpoint_init(struct hashfile *f,
> > +			      struct hashfile_checkpoint *checkpoint)
> > +{
> > +	memset(checkpoint, 0, sizeof(*checkpoint));
> > +	f->algop->init_fn(&checkpoint->ctx);
> > +}
>
> ...should we actually record "f" itself? And then in the existing
> functions:
>
> >  void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
>
> ...they'd no longer need to take the extra parameter.
>
> It creates a lifetime dependency of the checkpoint struct on the "f" it
> is checkpointing, but I think that is naturally modeling the domain.

Thanks, I really like these suggestions. I adjusted the series
accordingly to do this cleanup in two patches (one for
hashfile_checkpoint(), another for hashfile_truncate()) after the patch
introducing hashfile_checkpoint_init().

> A semi-related thing I wondered about: do we need a destructor/release
> function of some kind? Long ago when this checkpoint code was added, a
> memcpy() of the sha_ctx struct was sufficient. But these days we use
> clone_fn(), which may call openssl_SHA1_Clone(), which does
> EVP_MD_CTX_copy_ex() under the hood. Do we have any promise that this
> doesn't allocate any resources that might need a call to _Final() to
> release (or I guess the more efficient way is directly EVP_MD_CTX_free()
> under the hood).
>
> My reading of the openssl manpages suggests that we should be doing
> that, or we may see leaks. But it may also be the case that it doesn't
> happen to trigger for their implementation.
>
> At any rate, we do not seem to have such a cleanup function. So it is
> certainly an orthogonal issue to your series. I wondered about it here
> because if we did have one, it would be necessary to clean up checkpoint
> before the hashfile due to the lifetime dependency I mentioned above.

I like the idea of a cleanup function, but let's do so in a separate
series.

Thanks,
Taylor
