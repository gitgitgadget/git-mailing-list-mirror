Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA6EAD2F
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788933; cv=none; b=TDWBeOl/AVV41q/CEFhyT5F/YhhKYxUtuIp5aMju2lK4X/j5O2p8+aG2bvqNvHmoAzYucjB34SWvEMrc+a30Td1VViOhitI2LS0o1aSeD78PY8mexmfQn9+DMXcTq1p11E4XMcgxN8CC6jj/eJkhbH13exjN3Qn9atfmPN19zN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788933; c=relaxed/simple;
	bh=0T1CZfnObS0AXPzRfX6IldHt5saKKnuUebrq+gA7EUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvOgGP8eeC2kQk87BN5KkGqMTdRl8REuFC+ScNrgDWLjawekyKxkiMX35Esy74t8UT71buDdRmDZGktCgmIwiZ3LJe3E6kphhPv43e0LQrwtF5DOagPzffSKZPyFdhR3TLX2U1AxTmglRmp9t1yqXSki6AeBNjM/7R99RBEUOGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=MGvRTGRV; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MGvRTGRV"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6fcf90d09c6so23388107b3.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 16:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740788931; x=1741393731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+24Dva0gdRInsQE2ZUS09LHy4OOulGzlXZOxDwdWI8Q=;
        b=MGvRTGRVx8tEn1rNe3KlPyxN2JJAgTO2Pqcetv+MeZCJuqhN/bm6R++6WY5Bu5lQWf
         k0EVA8959sMYU39S/HcpDHU+a0VJS/KaGmz3m2VPiOw9Fl/QA9hlNv1l9mHOeDrqA1r/
         8Z/IDRnNka+onkzGLBihAwJPToXx34J8aHnEqZgImusXRQZEwNS3yf6tKVwjFRyNhWz8
         FWu2VtLiiROPn9KV63LqoEM6xRv5KFCd48ClWzz4QLL/9YxH4BLj0Vtp5jfm8JCHrius
         TarcSmx2VL4jb0UPe76SlCkogdMvQkCvlCDHjSSgIMCaRoECiIJogD5175zxPGv5fP7u
         Fl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740788931; x=1741393731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+24Dva0gdRInsQE2ZUS09LHy4OOulGzlXZOxDwdWI8Q=;
        b=g9Mb1g7xGJBE5O3zMCPJDqcB5BHLH52eWN3CYWeVS2ZWacWSX1i7v/iszxjagZY5J9
         +djwwn/7YJrRPsuctvhva1xLQel9oznCn6BK5yIudANftm8zWjeIRHVvRqftoWJ+Zkk5
         r2B3wm3rQUULT8lokToQLny5ABxIu2fNiBZNOYH0tbFHYUNukS5vGIljHjRxmEoNoJ0i
         nC466YFky9BTQcOOaO1Ot8sYAJ6+TqI7m2aj6qRIrDXE6g+yJUPjtg+kvJiIub3vzstf
         T0Eff6xZzt9RLqLsMjzpRI8RzQp321NqoMwhczmHuK86YJGNNJaBJKqR/ald0T13chdh
         KEdg==
X-Gm-Message-State: AOJu0YwnRaEX6qAtVdBBObc+TvyejGt82PNjJGPVXJE0ttOaDr8OQZgz
	FxU5gD+XhDd+wGqQ8NmCmxZBuFeGH0RLb++99gLKWpDx5EJhGh7LZgn6oqY1FXE=
X-Gm-Gg: ASbGncu0QibuvZfhv9GtrUy3xza11zCfoxKnRZaSlo424YTr5KAzFqYD+4EP3Dznfj+
	+t7pYIpyW2DR3Jd96FMF+IeYrfek29cerRbwL1UkHE52CiZG6qa+NfWVDwGV5gudJGR6LUUeX+o
	GCw5rk8pfKaOV7YM+ISYhM5ScYeAaznMROdZJwUdVkM7zzecuc7DHpt2eMaWc/2eot1QlY6thcY
	rH/qjkP84lBMyiLNNnCcxZfcXeGYYkF2lZWnNseECGQi/6SkPoWTbwmj6JmUDMIEm5KIWtjMRS+
	QhiKNS48ihXkyOz3FKL3pbgETx5kaI//iZFI6MsC39NF7+sGnl/wmIZ7sUNvV113NeZVCBTJ4vE
	OIkthRrWxqU23/3nm
X-Google-Smtp-Source: AGHT+IGh4uJVk0sDnJgimTsKgyLkYjA8+CkkjEKyuTqQQ2peScrmNvpJgfJBR6UYwQYYyhM/zcyULg==
X-Received: by 2002:a05:690c:45c8:b0:6fc:ed3e:ec3a with SMTP id 00721157ae682-6fd39496a58mr137657947b3.5.1740788931147;
        Fri, 28 Feb 2025 16:28:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca44374sm9592577b3.40.2025.02.28.16.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:28:50 -0800 (PST)
Date: Fri, 28 Feb 2025 19:28:49 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 12/13] pack-bitmap.c: use `ewah_or_iterator` for type
 bitmap iterators
Message-ID: <Z8JUwZFZ3yAv+AV2@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <87cb011e7fc283ef34f4554122fb901c1cd87294.1732054032.git.me@ttaylorr.com>
 <Z8GJhzdUtH5IB1Pr@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8GJhzdUtH5IB1Pr@pks.im>

On Fri, Feb 28, 2025 at 11:01:43AM +0100, Patrick Steinhardt wrote:
> On Tue, Nov 19, 2024 at 05:07:53PM -0500, Taylor Blau wrote:
> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > index 348488e2d9e..83696d834f6 100644
> > --- a/pack-bitmap.c
> > +++ b/pack-bitmap.c
> > @@ -1622,25 +1622,29 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
> >  	}
> >  }
> >
> > -static void init_type_iterator(struct ewah_iterator *it,
> > +static void init_type_iterator(struct ewah_or_iterator *it,
> >  			       struct bitmap_index *bitmap_git,
> >  			       enum object_type type)
> >  {
> >  	switch (type) {
> >  	case OBJ_COMMIT:
> > -		ewah_iterator_init(it, bitmap_git->commits);
> > +		ewah_or_iterator_init(it, bitmap_git->commits_all,
> > +				      bitmap_git->base_nr);
> >  		break;
> >
> >  	case OBJ_TREE:
> > -		ewah_iterator_init(it, bitmap_git->trees);
> > +		ewah_or_iterator_init(it, bitmap_git->trees_all,
> > +				      bitmap_git->base_nr);
> >  		break;
> >
> >  	case OBJ_BLOB:
> > -		ewah_iterator_init(it, bitmap_git->blobs);
> > +		ewah_or_iterator_init(it, bitmap_git->blobs_all,
> > +				      bitmap_git->base_nr);
> >  		break;
> >
> >  	case OBJ_TAG:
> > -		ewah_iterator_init(it, bitmap_git->tags);
> > +		ewah_or_iterator_init(it, bitmap_git->tags_all,
> > +				      bitmap_git->base_nr);
> >  		break;
> >
> >  	default:
>
> One thing I wonder here is whether we want to continue using the
> non-layered iterator in case we don't have an MIDX. But I guess it makes
> it easier to not do it like that because we have less conditionals, and
> overall the or'd logic shouldn't perform significantly workse anyway. So
> as long as we always initialize `base_nr` and the relevant `*_all`
> fields even in the non-MIDX case we're fine.

I had a similar thought when writing this and agree with you. We do set
up the _all iterators properly at the top of a chain (see the "if
(!recursing)" conditional inside of load_bitmap()).

Since we call that function for single-pack bitmaps as well (naturally
we are not recursing in that case), we'll call load_all_type_bitmaps()
in that case too.

Thanks,
Taylor
