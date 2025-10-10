Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B1C278771
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760136894; cv=none; b=Cn13ShzsbgU6qYTiUgTp7Y+4a7pwOsxYFA8HO1zud/t876IvtyI78fSwkhQtxxex2PNq82q6XU6NbqmqNXC7365LQlcqFXhrC8WDFcXLYBkhhRqaHRclUE4U55CVymdwO+FP1HHg3mAfdrSVizoghYrOT23fCfvE8ZT0uRIYeX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760136894; c=relaxed/simple;
	bh=Qow+BOcqQMEE0qsG7SYKgmQ5/VSs/ZxtrExORFjf/9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJwS1WtGDGyOUHEAPt8QxgYuWeX/b/+b69YSZdc0fwULQo5wz9A90fAXSS0gmF/5yMWedJs4ArTWJSY5Ajx8nNP7sBoIYGDxeXSWiwbEV2kF184nJTy2Ihfsmwid8ZyGQ04YAEEtCcohYVOwFIrVbnW3PdXPWJRZOBhnZja9Cv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ecRDwy8S; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ecRDwy8S"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d60528734so24975357b3.2
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 15:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760136891; x=1760741691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0v2KKi6BA8zaFI7xYnV6frgd4ZYXfEbWaFM9fZwJ+UA=;
        b=ecRDwy8ScPfLYu0+EjLa+Ro5AjooHI/JlQqI11fFZtgBEsfeIqDlUxaNn1h5jfXnHv
         ru/erA+69Xxo/ik/op5m0QYlOhtLVT3aegCSXILM0yAbvDmPBOgV6LIDyd1vibqHDaPI
         CWS/7rU8jg71D+3hVX2XNe2YiW1Hg8fx8wVBnla06kLZpSMV415BrjpvojxDmuxRtuLy
         o5cmfs5RUJ7zGLhBG+5qy28vZEEykg8AotmoJkPknUv7vvF1VqddKa2/HKr46aMKgZRs
         fh3dIGUMJJCBftUHsA/kibK27jjC/h24038dvBc8dMKKtOAuPE7lU5ERj5c/xM/Qgna1
         96EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760136891; x=1760741691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0v2KKi6BA8zaFI7xYnV6frgd4ZYXfEbWaFM9fZwJ+UA=;
        b=XoJ2fcfzKYt/rJXZmA/eP8tnq0t6hRXdd4JrCJndb4zZIoi9nlIhWBpZddfjMy66af
         p0QhKiH0yqZlW1qXSX+M7Wcoms/+m5jve34iCyWE2BimsoubNAy7WiaX1xogpwDG/Fre
         iaoaSMhRlfrhIz10UzBf5SYM7RKgHkcwEoIuPrI1Rkvo3le7E9R6WL2TQHOA88rA9flW
         5XgrfVIhG67UrLK2xCUeeIsCD98FCM7W4xluW6VmdIcz/V4TOeiEUK4KpHXsNdWrrdze
         pofmI5KQxn76cPaXWi4xkkQUSLvO0OIchlFDjOzCJefbWBEI0iK7T6RViq6RYavM6U+B
         gupQ==
X-Gm-Message-State: AOJu0YynFcIBAr6gMxXPFHIEqI0cN6kOTgtBPkAcZRR4XI6y5FE7Gy0u
	xBMcVtJmYG9XN+xALCel56x3pGipV4GSYTksC7JW9liNkeHI7d8CsZ1z13OWLJeJlaE=
X-Gm-Gg: ASbGncvULDyNFakXqc3RSJ41VpdFPYIGBEiB/CWf5mo/3uYAq1MKLIgALXoXd+1Wsab
	R4VMHq2NiPlYI7FnyPAXNgxv+65ZVSWEFU9gJU3TQ80hWCX6ouQauachFk/XNZayfbeUB5atr5M
	E+heyRzlCwykEg5c3LK2+n7iJmp+JON53lBrc50UvT7i8epnTUDx5F7+/UrGJn13EFa54Z7LLQD
	k4A0jyWJJEsZE+LdnUGpb/KGNeAvN4SvWFdMofbCUWndSMxmmxO+5TzMFBtJklNFrfCsPpRnOZ0
	GULSmBLi3Eq552+TSEwgSU8sVCHerMaTo22LSh3IA7uZalKv9loIjfkCizK8f4IkzBYx8QuTCo2
	2w390QR2pfb20Rvq6r0HGYj9n3V3zklJeH8IvYpY4ih3eA7EE1c5hNBMbRx5K+7zeyXtYdClIyt
	1HSrOxo3Csk+sk8LGhPUClJJkwM/3SaOMsbA5wwbSXTOrRvzugT2S7G18=
X-Google-Smtp-Source: AGHT+IFa8PMrSFGyEGfd3sdPr1qb35dvfV2dMOiWOINif/ZvbaNsnU0KWX2U8zPTeWx/8QV+Jgihtw==
X-Received: by 2002:a05:690c:7604:b0:781:2a:9413 with SMTP id 00721157ae682-781002a9f77mr58819417b3.31.1760136891466;
        Fri, 10 Oct 2025 15:54:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78106e1e4b8sm8985287b3.17.2025.10.10.15.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 15:54:51 -0700 (PDT)
Date: Fri, 10 Oct 2025 18:54:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 13/49] repack: move 'delta_base_offset' to 'struct
 pack_objects_args'
Message-ID: <aOmOusrJ5J29wpml@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <06347b6ab23d5ab1d9a7945da67473b5b9e02ad1.1759097191.git.me@ttaylorr.com>
 <20251010055431.GE1965904@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010055431.GE1965904@coredump.intra.peff.net>

On Fri, Oct 10, 2025 at 01:54:31AM -0400, Jeff King wrote:
> On Sun, Sep 28, 2025 at 06:08:00PM -0400, Taylor Blau wrote:
>
> > The static variable 'delta_base_offset' determines whether or not we
> > pass the "--delta-base-offset" command-line argument when spawning
> > pack-objects as a child process. Its introduction dates back to when
> > repack was rewritten in C, all the way back in a1bbc6c017 (repack:
> > rewrite the shell script in C, 2013-09-15).
> >
> > 'struct pack_objects_args' was introduced much later on in 4571324b99
> > (builtin/repack.c: allow configuring cruft pack generation, 2022-05-20),
> > but did not move the 'delta_base_offset' variable.
> >
> > Since the 'delta_base_offset' is a property of an individual
> > pack-objects command, re-introduce that variable as a member of 'struct
> > pack_objects_args', which will enable further code movement in the
> > subsequent commits.
>
> Hmm, OK. It is true that it is a property of a pack-objects invocation,
> but would we ever want it to be different between the two? I'd think
> not, and from what I can see:
>
> > +		cruft_po_args.delta_base_offset = po_args.delta_base_offset;
>
> we'd always use the same value in both cases. It kind of makes me wonder
> if it should be in the repack_ctx variable instead, then, with both
> pack-objects invocations pulling from a common source. But I could also
> believe that makes life harder later on, when you want to pass just the
> pack_objects_args to prepare_pack_objects().

Yeah, we do want to use the same value here in both cases. My thinking
when writing this patch was that whether or not we pass the
--delta-base-offset command-line argument to pack-objects *is* a
property of the pack-objects invocation.

But the fact that we want to use the same value when generating
reachable/geometric packs and when generating cruft packs is more of an
implementation detail of repack itself. I like that that detail is made
explicit in the line above.

Thanks,
Taylor
