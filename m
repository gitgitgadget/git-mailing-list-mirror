Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1332AEFD
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 01:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430996; cv=none; b=DeMroiPJGS0s1Z0kPTIERmoDBHSR3J72XEjzAi/VqpYfRDbqZFHvxsnJ+UnibdTj/jyYewwyRcnh+uIYmPaqVywaCZn0Zi2Mn4VfgOOa++ELE9l9VQscXy3oU1R2QFfkfDIg9EXtvGHpEq+PdKDcn76oYtReG2cADUuFEIKHqVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430996; c=relaxed/simple;
	bh=GDz61pwsrd8OKNRdjn8rI0u+LEhPlzEBd6NYQPuPDDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uhrx73ddwDsfG4GHAQLj6CKG3VS8g7iqaR0lK9OEifOsJPyqaf5eAswt0fiEIEZdcV7Q8gWyu4/nq4Kt8bHQDeMnvSF3Uv9NQEDVFmgO87dH9OUe3IOk/rIYfUkz1gKPsON8ahel/Ebpe7WXaG0upzsuRGH9L4KzHkaHbHV4Mvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=nvMbIT2+; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="nvMbIT2+"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e566327065so13087085ab.0
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 18:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756430994; x=1757035794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fV0T6tAHA9195Vi+6CYA5t6alJdn1QJ5k0ORbQaHviQ=;
        b=nvMbIT2+7b9FNn3ykdL0rqo9Xhgnnl2eY68QWQPi7MNGlSft6nW/xLMz5uMkProNmx
         ohRAoBKMIHICWYB/fCFxqMSFf1y1LDdMwYAkUnC6BmYk7fhqLrOkcK7JkCX8Y3el6Wuz
         L99/6Vj70JQwfjBHvJKp+wEFZqpoj6SqpMURnb7N5cy0qcYZhKlx1AXVHK7/pVuEhoqo
         8pW1qxusZ680RXUyv7Q9mzMvQeFYbxSGjq3HZSd+uf8AhwxnDIPoS9ETfPkawfBtqvSa
         QhQSR4lw4T1NGX0G751DrSdSAyyujXPdaeVuEXNf1tNAfw1x9NmV3Et2qXPL3ulcFFDe
         77RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756430994; x=1757035794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fV0T6tAHA9195Vi+6CYA5t6alJdn1QJ5k0ORbQaHviQ=;
        b=m9ncMqdc8WQQT1vUefl/ZcRpNTUWCy4umSyIczhd0Une4C+w+lOCcrAaAlYsmV6SjP
         72IEn0kAsCqIwobUJTEHieC1li6FuiZm6tve8pI0lXoYVkEzk8U/aCfPVylcTDbcZFSb
         he15O59U+4/dPPyaKyL1PM5rLxSzM8uvGEdM5mmUvEy/hOA/6kZc8jEfO7L2sRtQDICW
         H/kXqLrCL29BSKd6qIvglNgpQNwCVGBrGHoHG2mc74RQUxSDLjFKhKDyhkmRPfmUg8bh
         MFD8KxpsIs8y0PvNzVhLQMcIXjSvD1DllVxEarHBLK2xC4NtFCvRFEvU+X0NWUwfV/mv
         In+w==
X-Forwarded-Encrypted: i=1; AJvYcCUUzWdjHp005tKveMN7HdYpwBMIZT6Vbw2KCSR0xohgrvPLwa6G+JUdJM9TI50YaYKbUkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRSl7j4BykFaizl6oK07B/pm1vEPM65vxQh6BnzHklFtFpekLd
	B7D8gB7/qPpWuqCgRML3QiR2NAH7o9qiBjr+8r8tBDwfKMnypUNBKNQP6stxOVmtZSI=
X-Gm-Gg: ASbGnctMskrxsu6ZVBI/LhFvWWyogztCCrIqtkMk7vKkpRkxGYdHQQ8ayWQsbRdUFs5
	6QU5eaNgCnuWYxT4LixBOf+/1fpi91ON+ul1bvQQB7kf6EovsUdSMstITA6Z6zHovTRGw1bmIZg
	SL5wYRgeIZAliJtdZW9yu8Yc+6z2DLB/0CPZNofCqX8Rk/mNfaAagzRplOjWDwNQ/r1s8LaFxuL
	WvuvjebgJdizmp7fPgjz6SY46Z1OBf/xpuRe0BZWJDhfwoJt+vKuLtzthb8MGvT4U+hJK4Ds+l/
	+ikC/WqL6CfKn5JTyzbci/zh0ZtdHQSjdTx9EMkBpJFZe6kehEVJUXsuVtkdduuk63EJD3Y6p8U
	Ra3+MO64o3JbRsJ2KKLMrzaGE3wrdLPjwPQF6pzk7JDGgLPhwLCGH8o8l7jTA3p8BOXA0iZgDNY
	oyFlupW/m2NqdQBKaVEjQwkLroWDqj3/xu5jju
X-Google-Smtp-Source: AGHT+IEs0ZEdPYQ5a1O1kK5hS6cf7zXpJuxORWTfIR1S+KeXx8CsTsR5aiTgmBbsY6O3KI5WruigWg==
X-Received: by 2002:a05:6e02:1248:b0:3e6:7ac1:b8bf with SMTP id e9e14a558f8ab-3ef08858899mr126134975ab.9.1756430994389;
        Thu, 28 Aug 2025 18:29:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-50d7bffd133sm172930173.64.2025.08.28.18.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 18:29:54 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:29:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/5] midx-write: use cleanup when incremental midx fails
Message-ID: <aLECkfDqFVgNA1xh@nand.local>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
 <a5bee036019a044273f93434f9e382a4cfa6533c.1756402795.git.gitgitgadget@gmail.com>
 <xmqqwm6ntbjt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwm6ntbjt.fsf@gitster.g>

On Thu, Aug 28, 2025 at 01:51:18PM -0700, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Derrick Stolee <stolee@gmail.com>
> >
> > The incremental mode of writing a multi-pack-index has a few extra
> > conditions that could lead to failure, but these are currently
> > short-ciruiting with 'return -1' instead of setting the method's
> > 'result' variable and going to the cleanup tag.
> >
> > Replace these returns with gotos to avoid memory issues when exiting
> > early due to error conditions.
> >
> > Unfortunately, these error conditions are difficult to reproduce with
> > test cases, which is perhaps one reason why the memory loss was not
> > caught by existing test cases in memory tracking modes.
> >
> > Signed-off-by: Derrick Stolee <stolee@gmail.com>
> > ---
> >  midx-write.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
>
> Good thinking, but may I suggest us to go one more step to adopt
> even better convention if we were to do this?
>
> Pessimistically initialize the "result" to -1 and let many "goto
> cleanup" just jump there.  And have "result = 0" just before the
> cleanup label where the success code path joins the final cleanup
> part of the function.
>
> This is often the right way to make the flow easier to see, because
> often the success code path is straight forward, and these error
> conditions are what employ the "goto cleanup" from many places.  By
> starting pessimistic, and declaring the success at the very end of
> the straight-forward success case code path, all other flows to the
> clean-up labels do not have to set the "ah I failed" flag.  It would
> eliminate the need for patches like the previous step if the
> original were following that pattern.

Alternatively replacing something like:

    error(...);
    result = -1;
    goto cleanup;

with just

    result = error(...);
    goto cleanup;

would IMHO make the code easier to read, though I agree that nothing is
forcing us to remember to assign result in the first place ;-). I am not
sure the pessimistic initialization is better in all cases either, since
we have to remember to place it before any "cleanup" label, and make
sure that that does not regress.

So, I dunno. I'm OK with what is written here, and I think we could
certainly have a separate discussion to perhaps have CodingGuidelines
take a stronger stance here.

Thanks,
Taylor
