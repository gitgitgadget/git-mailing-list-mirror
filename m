Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112A2E1728
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781216; cv=none; b=ZmbIrtnatVRLZ4oopoMtNCx9jsREVPzh6U2O6pYgYzYeU78u6aF4QO0E3qHFR+K76aLiUV7PYXvBl9TgOYbihgH0oYQOWEZXn64kZ3KjoixchBQBuzdJEVeUgi0VXVROwo17j/H8KQ4az4ltFMGwLsXHvmVgLUdHGIIepE2Upjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781216; c=relaxed/simple;
	bh=oY21QcPCDGO4hhukCXoJXyIwzWfHlX4jqhS/SQP6lEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpZeYufd4Qsa+uyVjpVsRa3PGfbz46T8wrrw0nzODsQgd8aeHE9c8WzmDvTNrr3UYRDIOU4bsa8nO69zD1w/Fgd5IFpYrD5g1u3FMEIhroKH4KW1lQz2gXCTKO8P+fqYipyc4TG5DFlyjiwr2wMWyjllPe3GRK76KLUbPfCRMxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=JXcxRKUw; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="JXcxRKUw"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-712cba3c6dcso37221317b3.2
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750781213; x=1751386013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i+81pcjTd1/dxm/4K3OHVCkA6+oJ7Oz3Se9SyUz/9Ko=;
        b=JXcxRKUwH7wuTAJJcvB9PrGlXqfdAEKG0oXAeN+ee+9EHJGCAglomrSMdboqzTUsvv
         rftX3WIx73Y3C7kSfIpyvlj32m8MYHr5PFX76SR65UiCYNNRuYtU/g4L0H/2ldUkzJhb
         V39JL6LPAcPaSiVzV3AHRVkJTNfkOSNoiHEG4qW7gT0wQJ9em5GvwuqZC6PdLagVREYl
         +qUhk1QPJildpyqZP7S6KlscVsEBFNx3hIgsyhgWEZfH7V7NnMp54pe4zvbIAZdeSCu0
         JTP7NXF8eBEMpQLtlFVG1SS5AO+pktBbDLyoyB8eoFkP3D/U6rKz4qlKh+ymVE+7uz4G
         QT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750781213; x=1751386013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+81pcjTd1/dxm/4K3OHVCkA6+oJ7Oz3Se9SyUz/9Ko=;
        b=mJndSO4AbZeOMEYuGhVA8ZnL6meQQKZI6x36VSVleUHpn184KKNPCJNZ9ahOnXluvh
         qq8sYXHDooa7XOM9GlDP/gOuHLkXPvuy53k0Biw/+ixOIorUYeomcwtXhBF1UgxsXFya
         z0R/aVOjYLTFF2LKECQM6fUiOt2S+cCh+XZ5mJP6pck/LoZUplD0kiwWRoA+o0ifoMsq
         2l/cg9JD4j0W+M3BCXZlWpOdUNXf0a/S3X+BwbXuzXBXzJB9dyJdIf2lFLvBvRelYJSM
         ubQIBx8sgb5NffegKmmQsapk3hI2emMeAheS/U01m58lwIVMprJoiikiE2nLLG3zdGIY
         Ql5g==
X-Gm-Message-State: AOJu0YwGsoXXAl51woWUWRlyGW+kzoUZM3j3eu+t323BDBfOziUm26k/
	KM91a6XIugDCX8kZF4JeMqF5BUEg1IHitvzfhBJnx04tSky8tDpJp+EbPcuAJaWfiTpvZOMRFm9
	sx15B
X-Gm-Gg: ASbGncv9wKyfqQNwYF5IEke5I6eg//iJUE5+FlKZrAY68b1/tB9PQIZ6ajPyfUoSdIK
	TfXzguNCoj6R0whgnkMUaCSWTDcm3YBqPcmb/PpTQ3D73vNJOsaV8tSS87A4h292kJ87Ifk4k4o
	q0WkIabvYkjQhtFEn1WattzK6+zPFoW3o2US2dUeduBF7WpvsXZr9ZcpyyinxjoOhHFvNky0KtL
	WbGyKeD072AdkT0HwS8ESNYpfenwCw4AiSodf4aAQbJKxTcZZCq8WyUwY+LJ9EPcnZHyI1fiNZd
	uo03I81ANJEcXrczW1Cq+06siPJ5XIjvy+EEMckuq3X3lgLS7ZZfbORUD9ookP43FqmjdrPZjy+
	61hkIfPJvtwYdl2f35xHLfaZr+tCfpQGJpFh804clYu+A
X-Google-Smtp-Source: AGHT+IGisn3Nybrg8VgHAF9aO2JtaFuO19MmWC+u7XtJTGVi207mvUkI3FEeRZZQnmMBtVPZsNQ/5w==
X-Received: by 2002:a05:690c:708d:b0:70e:7882:ea97 with SMTP id 00721157ae682-712c63afd4emr247691657b3.10.1750781212927;
        Tue, 24 Jun 2025 09:06:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c49cbc5esm20525027b3.12.2025.06.24.09.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:06:52 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:06:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 1/9] pack-objects: use standard option incompatibility
 functions
Message-ID: <aFrNG8hmuktduz/4@nand.local>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750717921.git.me@ttaylorr.com>
 <8e7b2dacc77623ada5ee938de7a610ae15f49d8e.1750717921.git.me@ttaylorr.com>
 <xmqqldph16hw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqldph16hw.fsf@gitster.g>

On Tue, Jun 24, 2025 at 08:52:59AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > @@ -5050,13 +5051,14 @@ int cmd_pack_objects(int argc,
> >  	if (!pack_to_stdout && thin)
> >  		die(_("--thin cannot be used to build an indexable pack"));
> >
> > -	if (keep_unreachable && unpack_unreachable)
> > -		die(_("options '%s' and '%s' cannot be used together"), "--keep-unreachable", "--unpack-unreachable");
> > +	die_for_incompatible_opt2(keep_unreachable, "--keep-unreachable",
> > +				  unpack_unreachable, "--unpack-unreachable");
> >  	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
> >  		unpack_unreachable_expiration = 0;
> >
> > -	if (stdin_packs && filter_options.choice)
> > -		die(_("cannot use --filter with --stdin-packs"));
> > +	die_for_incompatible_opt2(stdin_packs, "--stdin-packs",
> > +				  filter_options.choice, "--filter");
> > +
> >
>
> We do not need two blank lines here, do we?

Yeah, it looks like an extra one snuck in and I missed it when
proof-reading.

Thanks,
Taylor
