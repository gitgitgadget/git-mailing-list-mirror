Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CCC482D7
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450881; cv=none; b=MTpxR9/HtuboA2pJjR3Q/HjLeozQi9MJGkvemGn/vsFqMqCNCOj2XAYc9RqKt8VjTRiGGyeNRtoGkEsxbSWug+a2W+jvmzyaQU5hjQRJHMcR2TZxud3mKNR8YbWIviJIRFmF73811wk/lauKMkWOmfm38a+WoIUYOiDe3MbBjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450881; c=relaxed/simple;
	bh=X/dqQxXsoHdP3IE/ri0ax3KF6iI9ft6seC7fTsp4GHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2Ex/EOZSey5tJW5Ewuq6L12AENgwou4hnPLB6nmppsihvvkqyjJQWozoiomcw4uEoSr/inGgZPqDvu3ElgkOGMpVR4UtD2ejNoTkf3+QIaMHalSKaftFooCDxICYuRTjL+2/BWbPRVhYwGUSoNI/pxIAdlxJq0uVXJZeYYSHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RazFwuWp; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RazFwuWp"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c2dee9d9cfso2237661a91.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720450879; x=1721055679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TEJM3DbWqRNszWK6tmzbd44n0pBjlaqqq7fjtr84wsg=;
        b=RazFwuWpqtUzEZOtrucfW/0n73s++7US19wkoB3g+2EX/w39MR+7J+HVovNv1b1UAV
         BNCDMFxqoyUPm6/S5/GDnKcsnpYfpLMqnN+rLREsa3HV9rI2Rg+WtdHB8BZDPTSCy1il
         v++tMUMRteZ5emtuWm6gVfrEVNd94Ua1M+fQLmy7zo6ZUNA7PXNwYxXKhuDf4VfGhEHc
         SqtLBUSeptY20Vfxf7npHFqCKEHzROy75GWD9VGIEoBFubvwbIHQiMI7k4dX64f7v+aV
         v9mCzleMedFOd1+57gM+kzXiauqXkXQ8mO93byQ6uNwJIcZQ68IoacG0P4b3U13a725T
         67eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720450879; x=1721055679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEJM3DbWqRNszWK6tmzbd44n0pBjlaqqq7fjtr84wsg=;
        b=u14aJTx0zHMwq0Xa4GkuA/ocYWjoRPffpj/uEdw/bCPGoiAxd4q6n0ZPmWUq+b2LiO
         qVZ44aaBHwKnbl/Jpfz7FEcGPuSUrNtg8kuhP2dJsX8QsZSDOOIEl9kwYeEeFol8Mfu/
         lUKotrgP/hcJSwYRNdOsgJdqbA5VjDSIvE6zWBoetrMYy2iHUHQ4uOaq3q/xruqze4ui
         YQVwXfgAEzlx8RADg2i2nYrJz5KIc14ICxkk6G5yVPMPxDz2FbBcCzBXEEqSy6vVDx98
         7BfKjUoD6cgqY6txCWnnLHPL6JNKJvCq6OuN6m++WJMQ2K/rbJEwbNyynFpuRWuKC9es
         ypZg==
X-Gm-Message-State: AOJu0YypHeC8kP0+HAUjHu/7o5/DwLy1mTrVpe8LxWsaXbAzNbtsIXOR
	aQCnAzBIfmqvTXOj0UAWhuLqJvsBNEi69o9sn7nY+X9q9j2kIi0X
X-Google-Smtp-Source: AGHT+IGkdGiCrnxY5fRARO6U8CMV/Zlt7Z05sGiEjIRbirj3b02LhytCcfV5J1nYWTIUBWtNMYVMgg==
X-Received: by 2002:a17:90a:5106:b0:2c9:75fd:298a with SMTP id 98e67ed59e1d1-2c99c81ec3fmr7007021a91.42.1720450878875;
        Mon, 08 Jul 2024 08:01:18 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa66582sm8242366a91.37.2024.07.08.08.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 08:01:18 -0700 (PDT)
Date: Mon, 8 Jul 2024 23:01:17 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v8 2/9] fsck: add a unified interface for reporting
 fsck messages
Message-ID: <Zov_PaaxF1Mbp_dP@ArchLinux>
References: <ZoVX6sn2C9VIeZ38@ArchLinux>
 <ZovrFCzRg06pq5eI@ArchLinux>
 <CAOLa=ZRPaiHK+NezigXEyWceriHZ7rb6msR51zcit9X=8rHFyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRPaiHK+NezigXEyWceriHZ7rb6msR51zcit9X=8rHFyQ@mail.gmail.com>

On Mon, Jul 08, 2024 at 10:36:38AM -0400, Karthik Nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > The static function "report" provided by "fsck.c" aims at checking fsck
> > error type and calling the callback "error_func" to report the message.
> > However, "report" function is only related to object database which
> > cannot be reused for refs. In order to provide a unified interface which
> > can report either objects or refs, create a new function "vfsck_report"
> > by adding "checked_ref_name" parameter following the "report" prototype.
> > Instead of using "...", provide "va_list" to allow more flexibility.
> >
> > Like "report", the "vfsck_report" function will use "error_func"
> > registered in "fsck_options" to report customized messages. Change
> > "error_func" prototype to align with the new "vfsck_report".
> >
> > Then, change "report" function to use "vfsck_report" to report objects
> > related messages. Add a new function called "fsck_refs_report" to use
> > "vfsck_report" to report refs related messages.
> >
> 
> Not sure I really understand why we need to do this. Why can't we simply
> add `const char *checked_ref_name` to the existing 'report' and
> propagate this also to 'error_func'. Why do we need all this parallel
> flows?
> 

Yes, we could just add a parameter "const char *checked_ref_name" to the
existing "report". This may seem the simplest way to do. However, it
will also introduce some trouble below:

1. "report" function should be exported to the outside, we need to
rename it to "fsck_report". Well, we need to change a lot of code here.
And we MUST do this, because "report" is a general name. When exporting
to the outside, it's not proper.
2. When we add a new parameter in "report", for all the "report" calls,
we need to pass this new parameter with NULL.

Use this way, we could do not change "report" function prototype and the
corresponding calls. Most importantly, we could let the caller feel
transparent. Using "report", caller can just ignore "checked_ref_name".
Also for "fsck_refs_report", we could ignore some UNUSED parameters.

So I think this design is more elegant than just adding a new parameter
in the existing "report" function.

> Apart from that, what does 'v' in 'vfsck_report' signify?
> 

Because I use "va_list" parameter, I want to emphasis on this. And this
provides flexibility that we could add a "fsck_report" function later.
There are many codes in git code base using this way. I just followed
this.

> Perhaps it is also because this commit is doing a lot of things and we
> could have simplified it into smaller commits?
> 

Actually, this commit is very clear. I just want to provide a unified
function "vfsck_report" here. And let the "report" use this function and
"fsck_refs_report" function use this.

So I don't know whether we should split this commit into multiple
commits. They are just tied together.
