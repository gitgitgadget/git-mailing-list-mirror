Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70923139CEF
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737673539; cv=none; b=C/um03c7W0M5gf5AiQnyVMnVmKU4DiZzELqYpZEi2/CwigNZttAuXmcIW4Ov9psHlt6d8UJgk39CH4sDQeWZB+ZLgIADW9Ej4uILCCPnkAO2tQY+qclKCda5nAtF3Usp+/up3E22vDqOqlHGQpFj+SUkrZCl/ZrUHDBLyV533Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737673539; c=relaxed/simple;
	bh=wQpc8ghHK8cPRbAmODnJakoKfW+ITZfI3UjrJwKm200=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW9OOw8iN351D8ZfleeB+ku8Vco/eJWa5Y0d7sj5AVQqs3w/eCx/2Rq0mThRO7zG1+r5FBZUP48rvMgXWPZBWXH5htKwTx0sT/drIddl03BH3vNBW3ZICgrRvz788WBdk5rYqc8AqmRHSsaQlOsL5hUDpsyZirw2e6exsNKj9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TxyIIG/X; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TxyIIG/X"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e549dd7201cso2818433276.0
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 15:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737673536; x=1738278336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OvfUgxusFjv3Igsdj3Y5jp5YNkw8F+MjF6T7uUEiKbY=;
        b=TxyIIG/XivOp1Box9wChXTGzdibCC+CJlr2f/Zjp+GW/DayhNR9JlEJcWC1uCg6wtl
         OCnSMxzUOAu9Ud4JJCzJBIkfr3lnZcecflFLy9HJAa9eRMcApjC7Z4wh5PhtDcOT8s6c
         n4ynJaw0H09fuYhB2hsZpxb49yA1hfuewkHTbnzU0z0Lm9mTQp70qNqbnJtTHMuVXs8l
         f2BRMrI8U68qG5NBCD8qcXh2BqymPTE2h4r5UGcst9rtah5nlYZrwEHvc42rjaeiBDTZ
         qtrroY6xIOdR1X+9XNYmkvS2bnJ5gWjdENdJc9CGNNo1fX1y1qCSG31bwa+GwAPCdUEc
         ZPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737673536; x=1738278336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvfUgxusFjv3Igsdj3Y5jp5YNkw8F+MjF6T7uUEiKbY=;
        b=JxUrLP19RFWpCb3E2sx09OVFzvRW1uefoKLoG77G9fCJ8JPQkKaCHwmso+kAxx5fMZ
         gbFgf+yo7qj9BCEqUOZFLufKkcWIcx9XT9e5A02cgtv7CqCOrbKMsfktb1WD88uwk2Ym
         xYl6BI9n2wGchCnFVhsg79JolHg5rkqYNKwA3vUGoqCl2Shu9gD5HQljb4bjMobt7vjh
         eqkCb1kRFpJYt1D6XOLH95gFvF7s8tx2Xv/AxPkGa+vZ0FF6cEUVhDI+hI90CF0K5tKZ
         wJCYFYqsgmXAuJcPdHPWs4ipVdXO148BTwvt+RzbHA4uAzWZixtpUfz+ctuyvmQzbAZF
         ohvA==
X-Forwarded-Encrypted: i=1; AJvYcCW7TTS87yEfP9mt1WHUBxH9Nd5cmxOcow9IL6cBrLCXpTwr/xFgXisksTHQwTvjJyCcPZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMR0IUf2c9JpkOOqKdQ2hCOvWjVcydNe2vZt+UuhMhTL23JEFV
	F/kHFSt5JO2OrmrosmbfaMDBPsjBJzKP/Z5+uRS0bsans0FEd1qx93ZbkW68q/U=
X-Gm-Gg: ASbGncspAfYV6kyaoDrt8eJFXOudEKXscGMynlQJdFgsrhBZv+Wlj13bnwM7qXMUgla
	ybI/bLMdqPk4KLCWyIjn1BGrZQ/mKh1QuyOLF9WRNAzLg/1lmTo2EwrP7wQi/kHoM3hnbvZ9Q2/
	XjzGXfeHJEf5GbxPgRThVVD13lKWz5FHyXPmFwHuci+eKqAh2rm2Goasu7gfx+JMBKuVhIu3dDH
	ycMQz8kS61GiPKc+zuI1jiIUeymG9X8aTph2bRMfXU2eiiCPP7dLEr71ngXoSUElwBR2h8TFeMI
	TCP19FfL24gHL72NA3eouTKsy+vN+SI4XneQnrTIrtnYtU/A+Iqy
X-Google-Smtp-Source: AGHT+IGV/4SMnzFMNqJTvUPb2HDg96KFubsU/0+kdjg+8RF0kMuwCJX0oyd59Ge5U5j2pyFhRwyyPw==
X-Received: by 2002:a05:690c:6406:b0:6ef:4696:f1cc with SMTP id 00721157ae682-6f6eb6b288cmr229396767b3.22.1737673534514;
        Thu, 23 Jan 2025 15:05:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f757a4a8dasm1492767b3.120.2025.01.23.15.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 15:05:33 -0800 (PST)
Date: Thu, 23 Jan 2025 18:05:24 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
Message-ID: <Z5LLNMKSa6Y2zvHK@nand.local>
References: <xmqqwmetgdgm.fsf@gitster.g>
 <1331d214-890e-4b47-87c6-44f445172bb2@gmail.com>
 <xmqqv7u7zz8v.fsf@gitster.g>
 <Z5E5KdbwHE7fmiJx@nand.local>
 <xmqqh65qv6oc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh65qv6oc.fsf@gitster.g>

On Wed, Jan 22, 2025 at 02:13:07PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Tue, Jan 21, 2025 at 12:30:08PM -0800, Junio C Hamano wrote:
> >> Derrick Stolee <stolee@gmail.com> writes:
> >>
> >> > On 1/17/25 7:42 PM, Junio C Hamano wrote:
> >> >
> >> >> * ds/name-hash-tweaks (2024-12-20) 8 commits
> >> ...
> >> I am happy with the updated function that gives us better of both
> >> worlds, without losing too much from the "renamed from other
> >> directory" while making sure we do not lose too many bits in deeper
> >> trees.
> >
> > I had a couple of thoughts that I meant to share before the holiday
> > break, and haven't quite had a chance to get to it now that I'm back at
> > my desk.
> >
> > Let me try and find some time to respond to the latest round of this
> > series, and apologies for holding it up in the meantime.
>
> The topic has been stalled for unusually long time, so it won't hurt
> too much for it to wait for a few more days, but it wouldn't be fair
> to stall a topic further with just a promise to "try and find time"
> forever.  Let's say we'll go ahead by this weekend unless we hear
> otherwise?

I agree, and I apologize for the delay. I prioritized this yesterday and
left some review which I think you have seen since sending this email.

> I am not ultra-happy with the last step, as I personally do not see
> this different algorithm as "version" (in that people would always
> want to use version N+1 over version N when both are available) but
> as "variant" (in that there may be prefer to use variant N over
> variant N+1 depending on the circumstances), but that may be just
> the matter of terminology.  What's important is to make sure we do
> not mix two algorhtims up while creating a packfile.

Yeah, I think "variant" is probably more accurate, but I don't mind the
naming. I think having a unique identifier is important, but I am not
convinced that we need to introduce v2 and v3 at the same time. I would
rather see us unify behind a single approach to present a
clearer/smaller set of options to users.

Thanks,
Taylor
