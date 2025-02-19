Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924391C5486
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 23:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006747; cv=none; b=BdxJ93YxBR9y7MkYz+IFpdjYpmjWJtWvFRmla0Eljifl9cIot9QqbxGlpxP7WaqvaOqySDcxFCZScs1E6Sx9af09NdK0f0GYVwaymbr7hnnOuR88rG6p8bA6NDzMbHFsM5ZKv0V+6xCzp2mbdzsAE5xzGMv+gCD12LpCVfd7L3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006747; c=relaxed/simple;
	bh=EviKSqsOsbXnC8AcaZel4ZbHXbGC/JMdpT0K4neflZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6tGUaZFDZ8p8UVyRZgSyjbPfHD+nHmzUm1QKfs/xjpVwqucfxFQt5RkOgUsYU1yasVfP4mWd7vu0gT9lwVvpKz4JkP6rX8audhuyxfLhrQZZLuBeIijjIz55tPRhZRTrnc2jZG+Ar9v4iyP0mSZuUBjWOFIT6vGs8hYAMUPPCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDSQGCrT; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDSQGCrT"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2bcceee7a5eso137245fac.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 15:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740006744; x=1740611544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OtHGWgkAKu1+Kal1TCIbKDSF0vDoYRN9zk8nTZe0NhY=;
        b=aDSQGCrTcGooiVmRNr+KWHeirPFiY4RFgMtBY2xE/kLyN3nb8VbGPxliVAn9uhGjRh
         B8JW0S7sQMdSAo+rL/ieILbfGRSDc9mGAL/z8B+nxldb72cKUF5soCalclitbj9SIvzO
         bM8A7bApE08h8wIoY+4umMMTrBDD2CBv2lxOmTMivab7WRx2ol4FKcCxIjzwlIoS4jXs
         yv0QyPSWwjJ0HxmCPbLkrCnhFXUzdw52P17SGree+SvF9GMbQEagjWqUR/l69jYhB6ga
         895pxJVPpMLXXpyZg68VnL89OUNgJbKsWFLMshDoa8oRPc+8SFsRomkrJx33+XC0/lhK
         exJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740006744; x=1740611544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtHGWgkAKu1+Kal1TCIbKDSF0vDoYRN9zk8nTZe0NhY=;
        b=sXLZmc0T2xycx+ngSPCdKMthRMmD0UAJx/L0eiRTvmG31j/TvdnFpt77AOA9YNHBq2
         yL6AJ4eDXp6nW2cpjcUGU6LZmMFEmkBoQXpw4tSoldw2/7Rnx+CgIQgoNJRs0ts/Wawd
         iEhPbKRUjeKDvUo5+Gth8+kstXLM07WBkAbqKvi9WWplPAD46YSO/MOsdCVIpe+nyQ18
         O7Lk+49fwcaYeRIQBmLLvCgq0ROpBWgPU4Z2d/FZSMgl57vbKTLL7G5BFw/MtGF+n+Ya
         hGHZPtgLbXhQlNPBBDTuciqh13CBGmeOa9P6UoOTZPaOal5etDzObpLHC7HotvvCtWRy
         bs4g==
X-Gm-Message-State: AOJu0YzIcHJ7EAYRM+sM1rYMHiob/e+d4ZNteBlDN6Sr+sO/0r/XvAtr
	cmzp1gga1SRyRMuVo+eKafUBpn8QjR7kZYVJGxF7SsglmwjfoZnx
X-Gm-Gg: ASbGnctFYXVbvMLJUbwGwiDO1zVSGCZ7fpquoF/kP5VTo5XN5yKH6cDBg3DEJ5Dw2p1
	TQVORNm70hzaL5SPHqXIMA9wxgHBxFGzjleHRxM/wU5t20fD9K7qPK+DUfvmIhnm7lEJ+qyn8/O
	6ECccRQ3AKfvBmqzkjJIfmfc+JIwG1KWXmUap/AcYC7krweFbWqnNH4Rm5xVEJlz+B68cIGSFOL
	pQ0fJD2+LhHPTIiF/5ESyh1WmGPd/5oX+/rkG8HItWBBmi6Pb0eiXt50kNQOgXknTgBc/38qT8t
	eoSVGuoY
X-Google-Smtp-Source: AGHT+IFjjepKu/Zu5BqSAV6rfddc82N4b5Z4im5uiwaJhiR3k/3Y01yNIeGIiveWR/xoKtCJk6WFrA==
X-Received: by 2002:a05:6871:6011:b0:288:a953:a5c7 with SMTP id 586e51a60fabf-2bc99aaadbfmr14561826fac.14.1740006744531;
        Wed, 19 Feb 2025 15:12:24 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2b954869433sm6011605fac.13.2025.02.19.15.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 15:12:24 -0800 (PST)
Date: Wed, 19 Feb 2025 17:09:15 -0600
From: Justin Tobler <jltobler@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, peff@peff.net, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] builtin/diff-pairs: allow explicit diff queue
 flush
Message-ID: <ge7awzyjvgcqy4m3rixrgvizckksvc2zee37f6qpn5o43jkznp@wxur5rh5ecbt>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-4-jltobler@gmail.com>
 <30c13b14-945d-4984-bb49-9fd93a4dedc9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30c13b14-945d-4984-bb49-9fd93a4dedc9@gmail.com>

On 25/02/17 02:38PM, Phillip Wood wrote:
> Hi Justin
> 
> On 12/02/2025 04:18, Justin Tobler wrote:
> > The diffs queued from git-diff-pairs(1) stdin are not flushed EOF is
> > reached. To enable greater flexibility, allow control over when the diff
> > queue is flushed by writing a single nul byte on stdin between input
> > file pairs. Diff output between flushes is separated by a single line
> > terminator.
> 
> I agree with the comments others have made about the documentation. I also
> have some comments on the implementation below.
> 
> > diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
> > index 08f3ee81e5..2436ce3013 100644
> > --- a/builtin/diff-pairs.c
> > +++ b/builtin/diff-pairs.c
> > @@ -99,6 +99,17 @@ int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
> >   			break;
> >   		p = meta.buf;
> > +		if (!*p) {
> > +			flush_diff_queue(&revs.diffopt);
> > +			/*
> > +			 * When the diff queue is explicitly flushed, append an
> > +			 * additional terminator to separate batches of diffs.
> > +			 */
> > +			fprintf(revs.diffopt.file, "%c",
> > +				revs.diffopt.line_termination);
> 
> As the user has requested an explicit flush we should call fflush(stdout)
> here to avoid deadlocking a caller that is waiting to read the terminator
> before writing the next batch of input. Ideally the tests would check that
> the output is flushed but I think that is quite hard to do with our test
> framework.

Good point, this needs to be explicitly flushed. Will fix.

> I think it would be easier for callers to parse the output if we always
> printed NUL here. Programming languages generally have a function that
> allows you to read all the input until a specific byte is seen. If flushing
> always used a NUL terminator the caller could use their equivalent of
> read_until(b'\0') to hoover up the output (using '-z' to do this would
> change the output of --numstat and embed a NUL between any stat data and the
> patch). Using a newline as the terminator here means the caller needs to
> look for "\n\n". That string occurs in the output between the stat data and
> the patch and can also occur in the patch hunks if diff.suppressBlankEmpty
> is set.

I was originally thinking that, without the -z option, a newline to
indicate separation between queued diff batches would be more
human-friendly. Always using a NUL byte would be more appropriate for
parsing though. I'll switch to using only a NUL byte here in the next
version.

> Now that we are calling diff_flush() in a loop we need to set .no_free in
> our diff options and call diff_free() at the end of the program (see the
> comment in diff.h)

Indeed, will fix!

Thanks
-Justin
