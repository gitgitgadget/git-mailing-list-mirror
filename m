Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0432DCBE9
	for <git@vger.kernel.org>; Fri, 23 May 2025 01:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962141; cv=none; b=UizvAsQuWh5HQOE+gaxYS05sFPtPyJZcu58/Wx7RY6jCJCuWjZt9OjWlHT0XuoxJ/k3Earec/6Zu2S2qK6O8QZY0u0gAF+dNPzTb7NowhzbBtKDnPLi4IoyiafuNvY2h8ZQrTej+K9fvEBbytLYeJciOUcCK0GkPafdAlB5O8fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962141; c=relaxed/simple;
	bh=+CqltFAVsx4zyb6S5HUf7haKu5PY163XAZdLGYZyyfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0TpaBG32pJ+fOBWtg9j42qzysQJZ7od7PojtAOA3byaE454h/WlV4/JmQyiByDmIvNDk3CyJCB+TdzRYDYRCKH/avtjV6UgynqyTpda2i019+R0wehQlYMEHujSqu699sEvyEe9tIcEN6Qqx3eh70Xi7cEZ+PYjL5pezmaTCWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qCbJWTc8; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qCbJWTc8"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f8c3db8709so4962406d6.0
        for <git@vger.kernel.org>; Thu, 22 May 2025 18:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1747962138; x=1748566938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ri+BwJJtnJ7sI4GKqzcalEisFbeUswdVLrwIvzsWhTo=;
        b=qCbJWTc8YA6lYoy/qXcXm80pz5S4AlMMoqF4qTN2KE4wKUzxFNJQTGv4a3wZAgi7um
         Jx6X9tt3nWpIP+gPabPy/a20QStdooYFm2cwvTBRKYd0NX8QlTzo5/ucs2OE0JcHQEnx
         icrsEWQlxF+tjsV8Q0JnhQWXe0PysOkndqFpzmuCnG8v3VOhq9jbob51s5qEinPP48ky
         /0uGj//ifc0PZ94m2p8wziR7jhPi1XFbJiQFU6sOugRHRfZNotSVcMis4ZtVHXK4Hpwz
         q5Vpuv0LRjeOccXeF9JhDQfS7u87dH++Gs6jGOIMz3ztGApbtsenZBeQbmaXXzf6YkDW
         peXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962138; x=1748566938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri+BwJJtnJ7sI4GKqzcalEisFbeUswdVLrwIvzsWhTo=;
        b=bBhiAt4+4+orZ2QUldXWkpzdSEXXq5x/HqV4iYBlQMh8KTSUlcxZ2O2ZAf9+mn1Yyr
         BQmIzK+692Ve5Yjvupq852POl3+tF4XSG+O7nqRANi6xTmazOzeEjoz0rFcSY2QbaWRn
         NHugzPYraiULG27W+aU689XBx5xpC1XLEtk4jdf/dhz6NLAaVmfwKV4Aw7a5xfe5rQwE
         TakvNy5Xa68AfnVYHtXLSB5oMCUaM2N5DORJqi1JpUh6hTXUkNM/1zWlPYPZCeTO26HM
         0DYBhe3S1v1GhFUy11WHMQ2kB6BTJCR2gt6DTb98gmKUam/w2PVVb3+K47YQFZbtNv0F
         huSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw+uI/1hswcXu3pTQLZg/syRfVP5A2XDfviXH6GL4kqjUbVDuZ3KkRPJQ8GLpDYbaenBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5mFEDv0n1bG3Ms3ZvGsd9Ni4cY4RQTfTcn/msNTSROQFQ7Fq1
	JHq7GKuOM7UCf3dx/k+zJu/SpWBW9vTDzsE6dVd1PnGwdZqR/mkyPrFtG9wC7j+UzC0Zm0yTr8W
	/mtcW
X-Gm-Gg: ASbGncu9An0irlUdIMTdknRjjwLK9ZJzidR8KozWWBtgKL7yQvW1uhyG7YlHkpN4/cg
	Iblm/JBjg3dUynStcI6dcQuh/9dZCO7GctwE/T6knMYZNGGmU27JI6VbWVyFhoQ4V/K9WXOZdMc
	bV3R/9a0MzRkP2bHjZKzoAmkVvDwoj4b41RbNbmSiOAH9DwETsYj/Mco6VKYJD9UALzInq9KEI9
	LJQaSIn7vaF4YCpQlLJoBSQVBr3E4juDpitX99/CEJKgZKR61EiTFwl+W39EFvkWgNs3S3w8rOv
	c0jzbFB/ZHw+eMoXLqfhn79dUFIMXJ6GICwgYV0QgByb1r0DwarGCBzOgsl5Nsq78qLilXnbpEy
	773yaTMe4R1jTy4hVEF12b8I=
X-Google-Smtp-Source: AGHT+IGXfkRT03rwZUEg1E+bQE6SsXGN4kASW57LiwyndoZuvA+O7c8HhUMs1Cvoj6QjXdcMKuA/Xw==
X-Received: by 2002:a05:622a:114a:b0:494:5095:d2c with SMTP id d75a77b69052e-49dfb8dc361mr22653481cf.6.1747962127846;
        Thu, 22 May 2025 18:02:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494ae42bdd4sm107953681cf.47.2025.05.22.18.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 18:02:07 -0700 (PDT)
Date: Thu, 22 May 2025 21:02:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: Re: [PATCH] packfile: avoid access(3p) calls for missing packs
Message-ID: <aC/JDrF5uJh9XxXj@nand.local>
References: <20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im>
 <xmqq7c2gv1zx.fsf@gitster.g>
 <20250519065221.GC102701@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250519065221.GC102701@coredump.intra.peff.net>

On Mon, May 19, 2025 at 02:52:21AM -0400, Jeff King wrote:
> On Fri, May 16, 2025 at 11:34:10AM -0700, Junio C Hamano wrote:
>
> > > The reason why we do this is likely because we reuse `p->pack_name` to
> > > derive the other files' names, as well, so that we only have to allocate
> > > this buffer once. As such, we have to compute the packfile name last so
> > > that it doesn't get overwritten by the other names.
> >
> > I vaguely recall that the order of checks between .idx and .pack
> > were deliberately chosen, as we do not want to add and attempt to
> > use .pack file before its associated .idx file is ready since
> > without the latter the former is unusable at runtime.
>
> It is definitely intentional and important that we discover packs by
> their .idx file first. The writing side uses the creation of the .idx
> file (via atomic rename) as the final step in making a pack accessible.
> Before that, a reader could see a .pack without its various accessory
> files (and so not realize it has a .keep file, for example).

Yup. Or seeing a pack before its .bitmap is written, in which case any
clones or fetches unfortunate enough to take place after the pack was
read but before the .bitmap was written  would be significantly slower
than they otherwise would have been with bitmaps.

> > > All of this likely doesn't matter in the general case: Git shouldn't end
> > > up looking too many nonexistent packfiles anyway.
> >
> > In any case, we shouldn't attempt to use .pack when its associated
> > files are missing.  It is not about nonexistent but about incomplete
> > (including "in the process of being written").
>
> This shouldn't be a race for files being written. The .idx is written
> last, so the .pack should always be there. And the midx is written after
> that, so again, the pack should always be there. At least for newly
> written packs.
>
> We might see the opposite: packs going away because they were repacked
> (and perhaps even a new midx generated). In that case you might see
> a race like:
>
>   - process R opens the existing midx, which mentions pack P (but does
>     not yet open P)
>
>   - process W repacks, deleting P and generating a new midx with P'
>
>   - process R wants object X; the midx claims it is in pack P, so it
>     tries to open that but fails
>
> What should happen here is that R will fail to find the object at all,
> should hit reprepare_packed_git(), and will then pick up the new pack.
>
> I don't recall offhand whether reprepare_packed_git() will open the new
> midx. If it doesn't, we'd still find the object via the actual pack
> .idx, but we may end up consulting the now-stale midx over and over (so
> we'll get the right answer, but there may be some room for
> optimization).

This all sounds right to me. And we do end up loading a new MIDX via
reprepare_packed_git(): that function calls prepare_packed_git() (which
doesn't immediately return, since we just zero'd out the
r->objects->packed_git_initialized flag). We then enumerate the ODBs,
calling prepare_multi_pack_index_one() and prepare_packed_git_one() for
each.

From there we end up in load_multi_pack_index(), which gets a freshened
view of the MIDX file. If all goes well there, then
prepare_multi_pack_index_one() assigns it to
r->objects->multi_pack_index as expected.

> The code in prepare_midx_pack() converts a numeric pack id (referenced
> inside the midx) into a "struct packed_git" pointer, caching the results
> in multi_pack_index->packs. That field holds NULL for "we have not
> looked it up yet" or a valid pointer to a packed_git. It probably needs
> to hold a third state: "we tried and failed".

Yup, that seems like a good direction to me.

> [1] There probably are optimization opportunities in add_packed_git(). I
>     don't think re-ordering will help much in the common case that we
>     actually do have the pack. But really, most callers do not care
>     about these auxiliary files at all! We could simply skip them during
>     the initial setup and lazy-load them via accessor functions.

Nice idea. I initially though, "that's not right, we definitely need to
populate the flag bits, e.g., p->is_cruft". But that was before I read
"and lazy-load them via accessor functions". That turns those fields
into a tri-state, which is a nice way to avoid this altogether.

Thanks,
Taylor
