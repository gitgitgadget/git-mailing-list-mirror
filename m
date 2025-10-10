Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E012459C8
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760136542; cv=none; b=Ymgt6LfWItNvolAIrdpHybWR+ej2MsmpHW5FE+PBh8RnGOVwM6grot/x/czajr+JMIiyA/5nVcW8KWUnyVrVRl76rHI+ktY/n8Mst3gg2NR7rF+dZNGOKAW4c98QIJFg4FDC6AtpkOtYjjyiFFTyIfeeOgBdQsUhQM0LysePukY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760136542; c=relaxed/simple;
	bh=g42z+fNdG6f2dnKIpusIYNUw9Gky4mLmHTTvv4uB0yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0SMt6kwlqefmlkPKxCHDyEBmAuSQIvWhegqfDDogwxM2CHvH7JB/mE0TV9kSBWofDVsP194kd/7F9tqOf1u1b+Dl+ee/6nmJeyFUxhcm8b/X+d/VXqg9GBgKimvVd05Hq0oqkhfNnpA58dNsHN4brR4EUEutKUz4eLpuozWnfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=LuzQWvsJ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="LuzQWvsJ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d71bcab69so23935337b3.0
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 15:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760136540; x=1760741340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJlpnYcl2erlOE3fp5SLM+lwaHj/xkTKCOXQY6M/CJ0=;
        b=LuzQWvsJktv2Pc8NZd1lcow8rmT+s3pjhOmlHScksTbFlZqY/BjTU3MSnsFQ98JD2B
         z0PlrJlrTEVLp6++F+CbVjmWQdp4xch7F4JuhSTbwDPtSe3CekLuaD3Nzlv+/1jLa4r5
         Y2+cyZhaFBeO3mthqifp7hJ+wyEXKZeaRn3t/cuvd108isOGQ2xh53wuld8qPEKSFsfG
         EFEfyJbT5hDyzgs+Ku6Hm/Vz8MApPdX4whQeIbV5XIfsTJ5ECkq3iiYFi1UCjgloxPZq
         qjsAhnp4ZCipIjneZubYSTDMJm2nENoR1v7BlfVACyUreXlVdsGF84JPR6aqE+ki6fXz
         rYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760136540; x=1760741340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJlpnYcl2erlOE3fp5SLM+lwaHj/xkTKCOXQY6M/CJ0=;
        b=OiodWEhXhRPzefEZ6wIUwYBPAwBNMPWzHG2Sz0M7qvjZGsojvoCQSFAxSHi04Pgudm
         T/Er7YYqHPa9/NsKan2VDqV+T2o5q7BsimDRQcE79n+OgOj+1prd2vq+t3+n7TbZAJ8J
         pcCDwG8HAmc+g6O0jPoSiL4ihZ06yMZGnhal93Tpmv3taKn9CQh0G8KXx+JAAqa2lJRU
         9IoRoWoyx90Ax9JV1VBrjOonvVzjy7aZwUfUL0wA1xjwQ+B0eG3c5oziYR+iPCP3+iG8
         Eul4L/+BrekWFIAIj0BalM2rKtJVDZqJ/d0t7Zed11JQu4kcfFZBeq4eEWv6WCjBR1t9
         1GsA==
X-Gm-Message-State: AOJu0Yx9a6Pc5ioAs8i9HsSdn+S8e+sJrqo7ac7bjccGEoBI8Ag9HF+x
	X7mQoFGC0PXRblR1rLB6eYm5ZE7IKZDh84MIHLuZbGiSvd6xmX0o5UEuJjn3dNEoNB4=
X-Gm-Gg: ASbGncuC4uKTytWkdBCfKO59K7SOAFliziy3UB+sueYuRtsg4OqjFO00mZSJRT36YKo
	SWq5SAr0xqaSIDDNseDdNPcEgWiDGobRDaQCOgzGprMu+WKnhaX/jkXEIE0g34JA9tHrNlvLsST
	WbzSIVm447YoIAUh1NNavtINfL9VCmdMJWLPNPG7quEigmhGNrPag3xceTXOsjurf/gL1BVl3q2
	Z5ZmWD+93DAXNU/1K/BU3Gc+kqxVZcF6vE547HaxMj8dTif3Zv4atBDd24lzlGzKteXlImRL+o6
	JbA4kBZSz//6zgFjt1nQe2PFoX42K/ySMdYADJTR/8eqNrWt+5TJFqgL0bEgavUeGNk8VNGfkXf
	nXfXtmZGwNS0qdusPvkhQkmzuqAeOSha41uKfSxMkv4zHO6G58DLGoIDlUdjYexEPyuZl+JiheZ
	qv2BsNW3Bcs4Dr6bnUs/Ulsr6tUocJMaxMFwCBbK3kZotJhaU+s/MORc0=
X-Google-Smtp-Source: AGHT+IGoWhYFNiMzH0NwKdTHeaqsvGdPvaxMZDjW53NTMlaxql/RYoWyaDsuwlQ1fCxrp3kUrSnkhw==
X-Received: by 2002:a05:690c:6b89:b0:781:64f:2b08 with SMTP id 00721157ae682-781064f3436mr51972317b3.58.1760136539834;
        Fri, 10 Oct 2025 15:48:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78106e1b58fsm8982817b3.18.2025.10.10.15.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 15:48:59 -0700 (PDT)
Date: Fri, 10 Oct 2025 18:48:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 02/49] builtin/repack.c: avoid "the_repository" in
 existing packs API
Message-ID: <aOmNWlwG3WPNChKi@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <664a67c93620edf6727f0617f4dddce99901fcde.1759097191.git.me@ttaylorr.com>
 <20251010051955.GA1965904@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010051955.GA1965904@coredump.intra.peff.net>

On Fri, Oct 10, 2025 at 01:19:55AM -0400, Jeff King wrote:
> On Sun, Sep 28, 2025 at 06:07:18PM -0400, Taylor Blau wrote:
>
> >  struct existing_packs {
> > +	struct repository *repo;
> >  	struct string_list kept_packs;
> >  	struct string_list non_kept_packs;
> >  	struct string_list cruft_packs;
> > @@ -265,7 +266,7 @@ static void existing_packs_release(struct existing_packs *existing)
> >  static void collect_pack_filenames(struct existing_packs *existing,
> >  				   const struct string_list *extra_keep)
> >  {
> > -	struct packfile_store *packs = the_repository->objects->packfiles;
> > +	struct packfile_store *packs = existing->repo->objects->packfiles;
>
> I found it a little funny to pass around a repository struct as part of
> existing_packs, since they're not directly related. But I think it is
> mostly just a convenience to do so, and "existing_packs" is really
> storing an overall context.

Yeah, the patch as-is suggests that we could have gotten away with just
adding a pointer to the packfile_store within existing_packs. I tried to
do that locally, and it works up until "builtin/repack.c: rename many
'struct existing_packs' functions", where we start to want to use
"repo", or "repo->hash_algo" :-<.

> It could probably be scoped down to pass around an object_database
> instead, or maybe even a packfile store, which somehow feels a little
> more "correct" to me as context. But I have trouble imagining that being
> helpful to any new code (why would it have an object_store but a not a
> repo object?). And I can easily imagine having the repo available being
> useful for future refactorings.
>
> So I think what you've written here is probably a good path forward. I
> wanted to outline my thinking because I suspect the same will apply to
> other patches in this series (i.e., they don't always need a repo
> object, but it's simplest to pass them one).

Yeah, exactly. In general for this series I am trying to do as few
changes to the actual functions as possible. There are some (like the
renaming in the later patch I mentioned above), but only in service of
trying to have a clean repack.h (at least from a naming standpoint).

There is lots of opportunity to clean up the repack code further. I
agree it would be nice to have existing_packs only take a
packfile_store, and pass around the repository in other places as
needed. I'm happy to investigate that, but as a follow-up to this
series, since I want to change as few things as possible here.

Thanks,
Taylor
