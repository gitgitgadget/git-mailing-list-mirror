Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF5B134A8
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290393; cv=none; b=m5XPmOElvq3T9vHm1kFA+4GGpqSHNMwMnptj6B0KrzYdinnPKLLwPBI0FdecngFFUlHp35JGP0fW/NA0cbdmGwS/Fpy/djgzLgVV3BCo4NkCf3OMakhICTJG8xZYdBwOixeYYHxvTv9naercASt4ZfRx1m7890v4aqg3xfW1qjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290393; c=relaxed/simple;
	bh=RkdK56WydgFm48krD195ssuzmMW3zZryjhlmHeld18E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFiz4mKaKSvABoFD9SDylo98rPUOxQJFDoslgMOzLL4VU9l/rDcsjYTsfpqEMTmewmt08UCcfhLUwLBc9oH3zio5SLhttYQm8OrDV77cGyRgyko2oWXetc8Hqh5aI9EJg2v5YbS124aBdQRn3OSEJMnk0peb3SYeJ5DeJBjsZh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMEImMkt; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMEImMkt"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2965e10da1bso1257727fac.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 07:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732290390; x=1732895190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HPh4DTv08BavG570RhIeYlbOMjvQPnHCi0RMJRWSiyo=;
        b=UMEImMktIKD5OZqXyZ1ZQmCxKtcxHZMolupl4FpaSMcdE0zm5mFHECnU4d/dumiAS2
         o/b7Dfgxg9lPYL2RjLNKLmjl4h59tvKoOOTYNhyTH4YkBiD/FAFxxbveLPrGK6mPr6Ce
         PbgQtlV34gQN8Dj7uLYhn9TrmwP41yON38XIEhw2uijpa7koh1Ww2TAKessDcBp+SXji
         9FPi8NJO/ZWiAi6oHZyQC9CIkVG/rJ8TqV7mS8lyzmze5xPlY9YYPxlAFR57ZCijnE5e
         4LBLkkXTpugPLfHym1DEidxHKqTSwh35rfQauVm9U3fOkrlveko4m1p/Gm2AZQ6Uovf9
         Qgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732290390; x=1732895190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPh4DTv08BavG570RhIeYlbOMjvQPnHCi0RMJRWSiyo=;
        b=WcM2xo/faYEI05sO/gLFyUpPMRypvKGTjMAv8lLVpFXATHnEjbSQIbzwbEjM+EEepE
         8roG8psGC9JpJgLXez0EpqHocPT+LPy17d8vZc1LbahEUyjDWhxpWrPIh30Fw0DwACJO
         JSrpJ123J/ciyXlHsrz4WroGvjHRODSVWgor2kVIEtvBGevaTSu/4kTenkM5V3k8vvig
         z82pLcV6EZnEwNCzW0gq6l5tO9B+g9KYmUU3FUjY/fq/wvMtO7YeMDNdbke6U8CGXeOK
         8407ipr/IR3BXgrZdzRU20iNhedOQby3HcKfMq+yhqjyj6LjebZnIlDV07wHucprEKBh
         OKCA==
X-Gm-Message-State: AOJu0YwOR9w6O77936q5jJKlZ3loPwYSle7sy/SbMrnVmNDpB+9yVSbF
	Cw1yanypG5xe5b88zitVHQ6uyw7zj5fDxJXJpqBZllhgisrcsHRdLcJweg==
X-Gm-Gg: ASbGncvAMhPbWhqL4Ot4XDyAZHl0cAZk5IYZ5si+GeKvFpAlfqcXj+GKx+qB2NbgfR7
	PFWZODwXKU6Z88+VJY8uOCEPVtKH6RyHGX5/1bOJyd0U2bPZ5rb1Zgxss4jsHNdAOPhRc6GQ4xn
	RKU5nWdQznC3lQsyXvwOjIsoS60viWAAx0F7YNC4mDriF834LjdeBtALUs4Bw5IqG9HdXLTSRBJ
	ERFY/ynf3IzkrbPtvYfM7wkVsgoF8qq9qvMDbeoQL4=
X-Google-Smtp-Source: AGHT+IH/gdPOce56HWzmIzitZA3gboEwjvLDp2d7kFI5L+Ej4HYn2is7tuaf9Hjst8dQ8CDX24jIXg==
X-Received: by 2002:a05:6870:b491:b0:25d:ff1b:3793 with SMTP id 586e51a60fabf-29720e6dc2emr3311500fac.35.1732290390259;
        Fri, 22 Nov 2024 07:46:30 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d88f849sm604875fac.49.2024.11.22.07.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:46:29 -0800 (PST)
Date: Fri, 22 Nov 2024 09:44:33 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] bundle: support fsck message configuration
Message-ID: <4icigeb6n75pbxqmpp3uynooef7dff2f73lxmrjjmppuz7hibo@bwb3tkffnqop>
References: <20241121204119.1440773-1-jltobler@gmail.com>
 <20241121204119.1440773-3-jltobler@gmail.com>
 <xmqqttc0cawy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqttc0cawy.fsf@gitster.g>

On 24/11/22 10:30AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> >  	if (opts.flags & VERIFY_BUNDLE_FSCK)
> > -		strvec_push(&ip.args, "--fsck-objects");
> > +		strvec_pushf(&ip.args, "--fsck-objects%s",
> > +			     opts.fsck_msg_types ? opts.fsck_msg_types : "");
> 
> OK, having %s immediately after --option-name means that anybody who
> is adding anything to fsck_msg_types is responsible for starting it
> with an "=" equals sign, but that is in line with how existing code
> does, e.g. receive-pack drives unpack-objcts/index-pack with the
> "--strict%s" option with a potential value for fsck_msg_types).

I was considering making it the responsibility of the `fsck_msg_types`
consumer to conditionally preprend the '='. This would mean that
fetch-pack, in the later patch, should also be updated to not
automatically prepend '=' when parsing the config and be adjusted
accordingly. This does feel more intuitive to me, but I've not sure it
warrants the added fallout and complexity.

In the next version I'll add a comment to the type definition indicating
that any value for `fsck_msg_types` other than NULL, is expected to be
prefixed with '='. I am open to changing how this works altogether
though if we think that is best. :)

-Justin
