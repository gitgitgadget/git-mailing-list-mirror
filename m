Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132D724EAA8
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 22:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126157; cv=none; b=eI/5BJSQ5mFl5zyz5MFIigitPhDu/gKrVUmg5j0EyZikmFTLJQq19qwX6AA1E92O5JZU7DQcJa/97vdPUiGWP1/p6cG3vn22JscW5UvmRyWVMsNQEnuk1X1CYEekoO1MkcqTb4iXlCJNKvOsRVI5mTnGiK+NX/WINfbsSYXclok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126157; c=relaxed/simple;
	bh=eq7RaOHNwqTO1v5fyyWQoHIHrrHpS5hFoRaO/Jup0IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT2oyjlLP8CiRw2hCTq8Z+c5W05rGhl3JBkKex+SW56WCLCRBg/j2OduAdsHqCxK56yA6IdVB3OsM32RwbQPN67ulu8TJlsgbakEiBugjZDEG5mbmN5Fswf1bCqG7NaPhqydqZ0rv73XrSMvfK1rIBZBXYkttKOTJ4JSpKCdYlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Jolzb1n3; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Jolzb1n3"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e46ebe19368so5080572276.0
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 14:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741126154; x=1741730954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjVIvh5/jWglSXnYxa6FvC6spJ2atic4CWqZLy/0JOs=;
        b=Jolzb1n3LpZXK8fN0IDPSjKKjfEE0N/RRbRqENvykg3nJkd4y/b1tNt0YClQTLTs/d
         woJhD2kpfK78mMaW/7XqXOLdtBP5alnPCTvBqGBJ9gc4NGkkwlb5tA6ZbZ8yXfQ3Epm1
         Elm9jlj3UjikpM4zyM0M8gzVqgw24llXRFhNaUxfJd1shpPC/TRmoaTTv7daHjU6lwNs
         ckYSsUO4Syy+JxfwCYBVFNNMsz2YAEoy6k6FGVU960IPg0VbA2GhiYISUngXROeVi5m0
         MY/3Ixpa1uC9rH8GyaMOD+Th56JMhLePVpIlR1Goa0Zi0jbylFIKFKUmdAdQilx4kkRa
         Q3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741126154; x=1741730954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjVIvh5/jWglSXnYxa6FvC6spJ2atic4CWqZLy/0JOs=;
        b=ZK4ilUE9FJ8Tj6FizKSVLWMUQlzIxWmPvocD8YFMcA8jdhaXUlGCTlMAnG9QcdtaI7
         VZZp+nBQWTmtT/vRX6MUT80IbtnY2mZmtUtBLIXEmt+nfusM0HfgfcZe6/jcQIsJHeeU
         OFRCoWoOCZ7x276rWe+YNr27SIyjtUzm0psHKkjFW0lcpT+B6ONuvgc8msGMkbzdgyA7
         0uomnwcUwAl9ExXQLs+/aueCIIiVTV3Fl33IYX3pv6HgcKl1i7itDpuP6Yu/8ww73mv3
         MpuP+wFPlddo3EJ+sECjA1vqfrscjtxRYcNmTm0tGeknUORP0KJhs3a1VlaMAeYqR7d7
         DJhg==
X-Gm-Message-State: AOJu0Yzp50NxqqHU+NzEJxCmCh0WiJ8TlI0pBbzZ/VLMNBCygShhzRzC
	BnPLdWFE0f2ifm8MhpPznfN16hqZxxDrGfZxRb1s1LGVKJUNkZkli5nxqp+URPxA+0bXUHroGlT
	R
X-Gm-Gg: ASbGncsXEPvbeP5Y4KQFybi+7G9Yl+rMV5W8SAFvcJ0K9qBvjYp/SaudnlGXmREmtNc
	Uu7N48+zc3/9WaAhmwim36Xy/Rf+7II2lzU5GuI7RpbrL/gsgGqW/Es99FyBmNDpFEYPZWBIAd2
	XQvHFwvBYXHaNtJcfBubj1gxk6JbfWfyvhjS2y2bScabZL7nwfjH7bhWwscwxI+3mp7Z8UJOvAk
	J+C9Pspd8Cgn3Par2mmG1NHsk+6rUBHUo2LfWJiyCWWEucU8EQpw4CMa9ekQcgypClGe8ehTI3M
	wIOcUxOZnWSUUF1ij0JmjIOKbTC3Yin3kKfm45LV9y0fcPRWe6rVFjavPWgb/MhGJInxWUbkfQd
	hP1cbYJcMjteCJuWb
X-Google-Smtp-Source: AGHT+IHZn5YAZBfPVwrbtM/QuakCdzcdtWwI3Mf+TIm7lfvBqTSt6Y801K9jciVSeYUNsyYerpUV4Q==
X-Received: by 2002:a05:6902:1207:b0:e5d:fd9c:f4b with SMTP id 3f1490d57ef6-e611e1ca94emr1285030276.21.1741126153862;
        Tue, 04 Mar 2025 14:09:13 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e60a3a1fae0sm4015549276.7.2025.03.04.14.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 14:09:13 -0800 (PST)
Date: Tue, 4 Mar 2025 17:08:59 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	"\\ Junio C Hamano" <gitster@pobox.com>,
	"\\ Elijah Newren" <newren@gmail.com>
Subject: Re: GIT-BUILD-OPTIONS can override manual invocations
Message-ID: <Z8d5++1dNdo/32uz@nand.local>
References: <Z8IX2bMJe+V80idE@nand.local>
 <20250304082901.GA1297837@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304082901.GA1297837@coredump.intra.peff.net>

On Tue, Mar 04, 2025 at 03:29:01AM -0500, Jeff King wrote:
> On Fri, Feb 28, 2025 at 03:08:57PM -0500, Taylor Blau wrote:
>
> > In 4638e8806e (Makefile: use common template for GIT-BUILD-OPTIONS,
> > 2024-12-06), the project's Makefile changed how it writes the
> > GIT-BUILD-OPTIONS script. Prior to 4638e8806e, the Makefile would write
> > the file itself, but post-4638e8806e it fills out a template
> > ("GIT-BUILD-OPTIONS.in") with the appropriate values.
> >
> > This has an interesting side effect when running e.g. the t/perf or
> > t/interop suites. If I do:
> >
> >     make && make -C t/perf GIT_PERF_MAKE_OPTS='NO_EXPAT=1'
> >
> > , then we will still try and build with the libexpat headers!
>
> Hmm. I am not sure what this is supposed to do, as I would not expect
> that "make -C t/perf" to build anything at all. It will use the working
> tree version built in the first step. So I'd expect your initial "make"
> to do all the work (and either fail or not depending on whether NO_EXPAT
> is set in your config.mak).

Oops, I should have used the t/interop example instead of t/perf from
above. I agree that t/perf doesn't build anything. The buggy invocation
that Elijah and I noticed was:

    make &&
    make -C t/interop GIT_INTEROP_MAKE_OPTS='...'

> I usually trigger a build of another version using arguments to "./run".
> Is there a way to make that happen via make in t/perf?

I don't think there is via "make" (at least, I couldn't think of one off
the top of my head), but I imagine if you set e.g., GIT_PERF_REPO in
your environment when calling t/perf/run (and didn't have it set when
you originally built with 'make') that you'd run into similar issues.

> > This is AFAICT fallout from a change in 4638e8806e where instead of
> > *not* writing e.g. GIT_PERF_MAKE_OPTS into the GIT-BUILD-OPTIONS file,
> > we now write it with an empty value. So when we run 'make -C t/perf'
> > with a non-empty GIT_PERF_MAKE_OPTS, t/perf/run will source
> > GIT-BUILD-OPTIONS, and override the value of GIT_PERF_MAKE_OPTS we
> > specified.
>
> But yeah, I can see how this would fail with:
>
>   make &&
>   (cd t/perf && GIT_PERF_MAKE_OPTS=NO_EXPAT=1 ./run HEAD^ HEAD)

Exactly.

> if the GIT-BUILD-OPTIONS value takes precedence over the environment.
> OTOH, wasn't that also true before 4638e8806e if you did set
> GIT_PERF_MAKE_OPTS? So:
>
>   make GIT_PERF_MAKE_OPTS=NO_TCLTK=1 &&
>   (cd t/perf && GIT_PERF_MAKE_OPTS="NO_TCLTK=1 NO_EXPAT=1" ./run HEAD^ HEAD)
>
> would fail (or more likely, the initial one is set in your config.mak).
>
> I think you're "supposed" to do this:
>
>   make GIT_PERF_MAKE_OPTS=NO_EXPAT=1 &&
>   (cd t/perf && ./run HEAD^ HEAD)
>
> Rather than rely on the environment. But of course none of that is
> documented at all, and is just convention and the whims of the few
> people who bothered to run t/perf at all in the first place.

Thanks for pointing out the subtlety there. I agree that pre-4638e8806e
it was a bug to do

    make GIT_PERF_MAKE_OPTS=ABC &&
    (cd t/perf && GIT_PERF_MAKE_OPTS="ABC XYZ" ./run HEAD^ HEAD)

since the GIT-BUILD-OPTIONS values override the environment variables
when the ./run script is ran.

But it feels like a regression that in addition to the above now:

    make &&
    (cd t/perf && GIT_PERF_MAKE_OPTS=ABC ./run HEAD^ HEAD)

is broken, too, since GIT_PERF_MAKE_OPTS wasn't set in the original make
invocation at all!

> I do think it would be nice if environment variables took precedence
> over the sourced GIT-BUILD-OPTIONS for "./run", but I suspect doing so
> is a little tricky.

Yeah, I agree, and I think that would be tantamount to also fixing the
pre-4638e8806e behavior, which would be nice. I think a good middle
ground would be to continue to allow environment variables to override
options that are unset in GIT-BUILD-OPTIONS, which definitely is a
regression in 4638e8806e.

> > So I think a more robust fix might look like only filling out those
> > lines in the GIT-BUILD-OPTIONS template when they are non-empty, similar
> > to the pre-4638e8806e behavior. Something like:
>
> Yeah, that would fix the regression. But I kind of feel like your
> initial command is already skirting the edges of what the original code
> was meant to handle.

Hmm. I'm not sure I am following what you're saying here. How so?

Thanks,
Taylor
