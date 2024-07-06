Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8147F23BE
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720278948; cv=none; b=j03uy+fIBJrMR3SL2tEPtdrd7FnssK6QU5huZnqFXMO0/rvk6UaxuNZeSbQWLtcYRl20tJ0SqUnBG1nr9LXNgu0B2mTtt/3XfL95RNWYFcv3ir6o0q+tZzmf/egRgVkBVYbg0ox+51xr0PMv9AvBPZwDhkce99MmQeDk2yp3edM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720278948; c=relaxed/simple;
	bh=bColsUCaeIkMVYG7lBOKlRne7pfree5Y6O8l0eBIKjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKOB2R1pmAdH4dktt9CKnSVx6Pmn+ikLQ5lpKKbU2JylzKAxM3ymEjJYd9gF9I67QqAzoTRaRSaphBtwok5HZ5frDuTe7rBQy/A2ZZEykt2kubiPU4SON7NiYKkNpuSD8PrL7xDhJbEmgtp7OcB9nvuOw7UMxyJN4spX+5RnTN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Hsk/+y5l; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Hsk/+y5l"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e039be89de9so2487098276.2
        for <git@vger.kernel.org>; Sat, 06 Jul 2024 08:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1720278945; x=1720883745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMIpEc0uOEVCoVXU8kZkw3KVRB4ULEad18HkrgsYiSk=;
        b=Hsk/+y5lBRyOMgGKgPa8kxk+rsCLmCTxDggZf5SCNlGyi9oG0HcdzYrm0jj1yNWIIz
         Jcftkafa2tWrd34tIk2Q8ZRkwii7RLUaJaz6Eeon4ZAxqYEwUOEBnAHHws7l62Iwzz3V
         ELhpOUIDuyIorcdfIjele+l2JzvMIhIB/TNE6UdcL2rnnM9ZuIjgpi3213MX6pKNbFaz
         qi27UfwiXyYz6bRAoYYc2uHMHoMu2mSoxnnmANOaFtUGUG5bs7RJoMvp7eLlVz4wGtqA
         bDfn5xTxIkKrEEe4jMKZGW95zRXhgPsVF6ADm+NHeql2l59D0TGjLuL8S63au1GgMxhE
         Q/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720278945; x=1720883745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMIpEc0uOEVCoVXU8kZkw3KVRB4ULEad18HkrgsYiSk=;
        b=Ob2oKpumqYNz3jYy3UdGo+9KguQCrOULpJlJqewEZgPPqmmdG81SHEPDKtJfcn0QgD
         mOcdfWRYlig8KjdD5Qqd0ZV59gSl7ih0E32Dq1Q5Ohwsb6UGww3HWLYwakRZKv7DsGUN
         uoSZaaofw205priu7nkEnYIEKcUmFU8Pbu3kFCgeEnhLpGDW+bap2KQUdQUfACrTvkQk
         EtK9PQg+wnCqZCURhPPvXogV48tfA7fJeI0PZvCMS4oGD3h8LJTcK4pxgiUaqZBXLRJ2
         mBfT5xi6rAGsKOGvjH4Tti/1ZRHzhDyRJc2KbzOSMOCvY5Ty1jOE7RIT05PmcRzKdeYI
         vWaQ==
X-Gm-Message-State: AOJu0YwDETMqHwKiH+gMPZKPUOcvMADSkccqT0AsU8vbL4HkYY33clD8
	TBOKuWn4UepGP9VmLsQ8AoBwzA9t5SibKLzhbwxggQmCh4wTEftAdnhq4jf0PnRhKfd52ZFQz6c
	ow+Q=
X-Google-Smtp-Source: AGHT+IF1fNIH4ig+frPgTCeR7zOa0Q/85beIaqXkB9eaZkB+922KUmr73/snC7N+S9yiYvuz+d4jgw==
X-Received: by 2002:a05:690c:7082:b0:615:20db:4a4d with SMTP id 00721157ae682-652da44dfa9mr93717147b3.35.1720278945379;
        Sat, 06 Jul 2024 08:15:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6511c6804d1sm14240367b3.85.2024.07.06.08.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 08:15:44 -0700 (PDT)
Date: Sat, 6 Jul 2024 11:15:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Subject: Re: [PATCH] config.mak.dev: fix typo when enabling -Wpedantic
Message-ID: <Zolfn81ygqfw0iOK@nand.local>
References: <cbc9446b1b0f2453b96aa9c0d89b9ec086a619bd.1720205457.git.me@ttaylorr.com>
 <20240706063143.GE700645@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240706063143.GE700645@coredump.intra.peff.net>

On Sat, Jul 06, 2024 at 02:31:43AM -0400, Jeff King wrote:
> > Causing our Makefile (when invoked with DEVELOPER=1, and a sufficiently
> > recent compiler version) to barf:
> >
> >     $ make DEVELOPER=1
> >     config.mak.dev:13: extraneous text after 'ifneq' directive
> >     [...]
> >
> > Correctly combine the results of the two "$(filter ...)" operations by
> > using "$(or ...)", not "$or".
>
> ...why don't I see this error? Based on the bug, I think that we'll
> always pass -Wpedantic, even for old compilers (because our weird "or"
> will never be the empty string).
>
> So I could understand if the symptom was then that when you have an old
> compiler, we feed it -Wpedantic and it complains (though the fact that
> nobody noticed such a behavior makes me wonder if we even care about
> such old compilers now?).
>
> But why does make complain here only sometimes? Does it depend on the
> version of make?

It seems to depend on the version of make you're using. On my system,
'make' is GNU Make 4.4.90, which has the more restrictive checks around
the recipe prefix in nested conditionals.

With that version (and the pre-image of this commit), I get:

    $ make -v | head -1 && make DEVELOPER=1 2>&1 | head -1
    GNU Make 4.4.90
    config.mak.dev:13: extraneous text after 'ifneq' directive

, but with /usr/bin/make (which on my machine is GNU Make 4.3), I
instead get:

    $ /usr/bin/make -v | head -1 && /usr/bin/make DEVELOPER=1 2>&1 | head -1
    GNU Make 4.3
    GIT_VERSION = 2.45.2.746.g06e570c0df

I think other factors that might be at play here are (a) whether or not
you have DEVOPTS=no-pedantic (in which case you'd bypass this entire
part of config.mak.dev), and (b) whether or not you have a sufficiently
recent compiler.

It is tempting to just want to rip out support for older compilers, but
given that ebd2e4a13a (Makefile: restrict -Wpedantic and
-Wno-pedantic-ms-format better, 2021-09-28) is only three years old, I
imagine that some builders may still want support for older / pre-GCC 4
compilers.

Thanks,
Taylor
