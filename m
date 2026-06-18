Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50F12F1FC7
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781792106; cv=none; b=XWFS+bZVrPVho23z69Ekl2m3Tjj3SGe8+QgQPIcrS54122kVy9J74GyaozJPmlMflDszChqksO6J7hrUkPNAoM/fxT37JuSeLlzBYKPai94S7XTowLz5d1B/GMbXxqSMegMB+O5JHry9wedHF9WeVRD1CiZMYXyR4j8Vx/rGzWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781792106; c=relaxed/simple;
	bh=8scxSyGrHbYVwZkWJnOTbKrfUJf3Sshc/IM7Hhf+iSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pntUn9h5DOqR9tgimKTFfmp3kPkRomU5erO11N5mc4hAEzTICjR+4vJBh2fzchNhTynyKfNNzNhwrGtFxr74IFhINQoiwy9EG+jU5SnHaNovgnAPx9+dOTmdpiGhBv1iVsDcnZystgZEf5lCFQB5WE4gszCcMuGYw5zYwnR39YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WK7huO63; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WK7huO63"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-69de9bc590aso829997eaf.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 07:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781792104; x=1782396904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJMaTrmoASv4ysGYpYq5+KsMZyH+TeknyKT3COaKJ7g=;
        b=WK7huO63S6fqUMgodwzDHb/mZkEiUPOwbYedmq9zm/3OGL4q2hECEVaep0rkC2jMGA
         H7XK0euXhRniszns61RLk5MyKO33GXZ6v1rHPKTOX3IfyI6dKVZJNaQgxTHcqwuld4Fc
         Vzr3tlVKF4UjyduRqH0y8QfWijccB71FkgHinetSl3BNgpbyZk1T16EUqrV13DHYZBVE
         a8PEggbxosJtQVppJsTIKbQ45YQSoJCMDcVONlPeVKwiUAvjN099LxgV8094toGq55ov
         TRqBPwN7+d9FI73AGf8jIWBN/TWFokMmz9aSvcbvsUdgEC06EtWRUIW3f2Mfq/1Iak7u
         d5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781792104; x=1782396904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJMaTrmoASv4ysGYpYq5+KsMZyH+TeknyKT3COaKJ7g=;
        b=Slnc3UqOK6O2FSqmd54D09TI17XP4JcXMEPBej9tqGsJRPbdXfyYVPS7Q6VRew9ryM
         +TCKel7ojXXgvGOmbW/u7/wot0a5lZGdIuD2X/Fhuai49Nw1fKAA28k5V1olZU9nAjHm
         uR+vlSyTrZCVXVMsM2KDRdndPiZig/KL9E+wqvGOqpef/r00HkQqKvhepQaObXM/Kbc6
         YWZ/iCWktMrVERonKlnjwc7txs87JslOsdCbrHrBXfTrGbcIDwWNDYXzHwsxi9ILrfWJ
         kt1ZRyJeJ8pPkIyGGEdPd2d0nzlxXUdnXgOBZ8Xi1XuPuSRaMptE8Avu4szcnz7hU8O4
         ygFQ==
X-Gm-Message-State: AOJu0YxrNzt2cJPAC1Je9d2X9VxuJq+Nm0VqzNA8PnQgCtqlJqX0KSxq
	MMu6dgZgZB0n5/BapyHxJqaQMmrgnKlRkHk4heJuWvSIZJyxlVhjanK4
X-Gm-Gg: Acq92OGLwHE/XwrZeOg5dIko25MAgZWORJuU4zVhIgbLnL0jfmxwdk7zzYJMVMp1SPv
	q0VoxMO3vObyZ/DG7YGDZ/glKF73WWN7Z4sviWaty8gmUO+jPKSlR+ONQt0+Q+EOoPJ7bVm16GT
	MO9VJc9WGCapMawnOYohdOURWs46R7ctUfnMpIsrc2NIQRK25Ynhx1YmwfA/73Ufcb75il9HvMK
	TMxjFOC/7fyupeyLFlRuOdK/RxC3kCm3iTmifX/tSvSEcHEOdeoD4i+Gx69dAL85EE9DHDmT5Fq
	NQpqhIG/OnBM3DZV3y5GeqiEaJHkshB68FXhdTk7ELKee7umNpnk7PNBYX1OovitWVFTZL7Qldf
	fb9H3MT+iWuG5xPHODMyFxFdRe6GvUHT1XQrmSSZbm1pUYSTP/PjUwh0/JnmMfe6HA+r1gbnjM3
	OvgFh4vg==
X-Received: by 2002:a05:6820:3085:b0:69e:df26:ad45 with SMTP id 006d021491bc7-6a0b60e289amr5886155eaf.43.1781792103584;
        Thu, 18 Jun 2026 07:15:03 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308afc539sm6795311fac.6.2026.06.18.07.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 07:15:03 -0700 (PDT)
Date: Thu, 18 Jun 2026 09:15:00 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 7/8] refs: fix recursing `get_main_ref_store()` with
 "onbranch" config
Message-ID: <ajP7W7KsXz4Wk262@denethor>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
 <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-7-f4854aa99859@pks.im>
 <ajLoiCS2mXP49eAJ@denethor>
 <ajOJM8EvGWWkYNuL@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajOJM8EvGWWkYNuL@pks.im>

On 26/06/18 07:59AM, Patrick Steinhardt wrote:
> On Wed, Jun 17, 2026 at 01:41:40PM -0500, Justin Tobler wrote:
> > Is this really the best signal to indicate that a repository ref store
> > has not been initialized? Temporarily setting the storage format to
> > REF_STORAGE_FORMAT_UNKNOWN feels rather awkward and suggests to me that
> > `include_by_branch()` probably shouldn't be using it to begin with if
> > its not reliable.
> 
> True, but we don't really have a better signal to the best of my
> knowledge. Ideally, we'd be able to use the existence `r->refs_private`
> as signal. But that doesn't really work as the reference database is
> lazily constructed, and the recursion happens in the exact function that
> would construct it in the first place. And there indeed are cases where
> reading the configuration is the first caller of `get_main_ref_store()`.

Ok, my first thought was also whether we could use the existence of the
ref store as a signal, but I guess that won't work here.

> My first internal iteration tried to make this non-lazily constructed so
> that we can use it as a proper signal. But that led to a bunch of
> problems where we now parsed configuration way earlier than we currently
> do, and that in turn led to all kinds of errors. I was able to fix all
> of those errors except one: we expect `git config set` to work in a
> misconfigured repository so that the user can fix the misconfig without
> having to manually edit the Git configuration files. But when
> constructing the refdb eagerly we will die early in such cases.
> 
> We could again work around that issue, but that unfortunately evolved
> into a proper mess that I eventually discarded as unworkable. I think
> this is an inherent design flaw: constructing the refdb requires us to
> be able to parse the configuration, but constructing the configuration
> may require us to construct the refdb. So this awkwardness is built into
> Git's design, unfortunately.
> 
> So I'd really love to have a better signal, as I fully agree that the
> above workaround is nothing more but a hack. But I'm just not sure what
> that signal would be. And this version here does exactly what we want:
> we honor "onbranch" conditionals in all cases, except when constructing
> the main reference store. Even if it's ugly.

Could we embed an `initialized` boolean in `struct ref_store` that gets
set when the ref store is properly initialized and use that as a signal
instead? I'm not sure how complex introducing this would be though.

-Justin
