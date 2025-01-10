Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A480C20C01E
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736511311; cv=none; b=Xh/EVV8NWGfWV+BVirD9via/FUWRgGTAeN/Xhkre9PD//CPOYt4AK0jI8zjbU7gWQC3Xx5caGlfQv5vDuzFRNNKAFu16Qvg7Nzl4/2RS3TskkCD6pl2m2+TtD7NIkF1rnhBlOtA+nn3Ma7o5xwY0RH+q3ewXBONwAyjfXljpqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736511311; c=relaxed/simple;
	bh=mDXALt3WzEzb3q4CrVfc85x3SoPXcakHX0jX602WTvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DohlWiyiu/JP8Q3aZQ0HWt7QZeu3XhfHVoVtvmOY5bRTSVjavbjRCO4756Hvxntz5Bq6azE6muw6mXg+ioHkRv4nPunUXCDfuFr0Shq9CvjPNcOHQhRGKfuYbgDFnklg+QpDXWsjNcolypAyMfDXJ3w4Oiial07pSKyarDzY+ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mh2mEcvE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mh2mEcvE"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21636268e43so40316405ad.2
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 04:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736511309; x=1737116109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BaLVRfXsLW92jIMDpM20ZU3wR/IpKo4he9EZHE5cMUw=;
        b=Mh2mEcvE+DS32S1Jh+bdwdxQQDbi71OO3WFPnztL3P0fZ2fBpyY08uHpKj6nPVluAn
         Zf2jniYu/TdeSMO/IavzW3kRvE+3DOFtboRWXwSVTbtOhrAHdFC/c0am8+3fV81sTMXp
         qjRF4eFPCMddgV/lxH2S1evPTojzFGUDLqK4aEykQh1G5cEUqxCzaV3/M3Ixjjwr3GsZ
         LkmhB5g2MXv5CZfbbBtv7pTsC7xi4hEa9UHoAVZU7DMyTZIwblJP+/xJ0dfDGux7ZG7N
         ErddeCKt3i5Qhq1t6NILk2wtxj2g7QYUkrB4A016w1F/+7bl49+fYhFmG/8uGsdfXHE7
         YdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736511309; x=1737116109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaLVRfXsLW92jIMDpM20ZU3wR/IpKo4he9EZHE5cMUw=;
        b=YyPdIPsOQTKyVfqFufy1pplNsozft4znk+S/sNj0NxMwZJeb6ZnHi+tU/DiIIWIu09
         BEXDFUNCdXRgUzvu69CV9JoxTl1UNfRnY7i4DNlrFS9UnNh2JLTcWpJNpyb1h/Ap3rqL
         jOoZyoEXi+9ZIi1FJFBug3fOBLj1Yqq6Y8PoxATFXXm99lqX3ya4ll0nE1XKHd1Ubpw1
         cOmIppd9SLv30ua82sCDJpM9o6vQKFP3asCl0pI/9IWdTwALsI3hJmjJHQ/gBO3ft+G5
         E6RBaEAMDqHQEAmBcyQDL70IlfQseHEAsS90YuqOtfWeX9Woi/S9rKdEW98XjdYX+F3s
         akZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKQS92e9kAuYudJywdbBnmjBRPWMBFyuHxOnWXQUcOccQXi1abFTkzUd75AdvphpRuDNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJCBi4jN92Z2jUwk7Zj9SALELBN2rgLPGHTPxcBWn/PIhlcgtL
	Pglvz3w9qQdaPim/jUr00Xb6cR6xVDEvMPA1gt2bIDM97Za93kpf1aY3wA==
X-Gm-Gg: ASbGncvwkHOHEmO5oupdPNozra622/eJh6d7XPDPxoSunzK2UNx/YS6enYiC+A1ECTn
	EUYhmq7YMmbE7AKzfPoV7FR7/9cNfc+iiO73kMp7eoMZz7cjvrHzI+Hwz4r2euYYz8PizjmQBLC
	YC+7wSMRQWkRw/n2Q8Nge3/0S96DDCQIdoQYIhY8w1JDyKJoXvgDWBKsnLxw6ri232OpxLD49s9
	ZFReCUiIESvJGdDnKjGtmbGDpw1qJZSVPo=
X-Google-Smtp-Source: AGHT+IGvl+H2GwjyWA/pljFOjfwCK2hv8yQ+nsgQ9PFHq9Ainl8Qi+pjqBh+FXZaFz17MABbFC/gUw==
X-Received: by 2002:a05:6a20:6f09:b0:1e0:d859:e1bd with SMTP id adf61e73a8af0-1e88cf635d3mr15713412637.1.1736511308587;
        Fri, 10 Jan 2025 04:15:08 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056a359sm1472935b3a.54.2025.01.10.04.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 04:15:07 -0800 (PST)
Date: Fri, 10 Jan 2025 20:16:13 +0800
From: shejialuo <shejialuo@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] builtin/blame: fix out-of-bounds read with excessive
 `--abbrev`
Message-ID: <Z4EPjW1jGAMFGfJ_@ArchLinux>
References: <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im>
 <20250109-b4-pks-blame-truncate-hash-length-v2-1-589c81a6ddb0@pks.im>
 <Z3_Dt5SpG6qE5_9V@ArchLinux>
 <2db1688e-bf2b-8f53-82d0-11c453a64cd8@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db1688e-bf2b-8f53-82d0-11c453a64cd8@gmx.de>

On Thu, Jan 09, 2025 at 02:49:09PM +0100, Johannes Schindelin wrote:
> Hi Jialuo,
> 
> On Thu, 9 Jan 2025, shejialuo wrote:
> 
> > On Thu, Jan 09, 2025 at 12:48:22PM +0100, Patrick Steinhardt wrote:
> >
> > > +		printf("%.*s", (int)length, hex);
> > >  		if (opt & OUTPUT_ANNOTATE_COMPAT) {
> > >  			const char *name;
> > >  			if (opt & OUTPUT_SHOW_EMAIL)
> > > diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> > > index 0147de304b4d104cc7f05ea1f8d68f1a07ceb80d..7cf6e0253a5bbd4d6e438e627dc18b47eac4df66 100755
> > > --- a/t/t8002-blame.sh
> > > +++ b/t/t8002-blame.sh
> > > @@ -126,6 +126,10 @@ test_expect_success '--no-abbrev works like --abbrev with full length' '
> > >  	check_abbrev $hexsz --no-abbrev
> > >  '
> > >
> > > +test_expect_success 'blame --abbrev gets truncated' '
> > > +	check_abbrev $hexsz --abbrev=9000 HEAD
> > > +'
> > > +
> >
> > By the way, I feel this usage is a little strange as the user side. When
> > I received the report mail from Johannes today morning, I feel a little
> > funny that we allow the value of the `--abrrev` option exceeds the
> > `GIT_MAX_HEXSZ` in the first place.
> 
> See the explanation I provided in
> https://lore.kernel.org/git/c439fcaf-11af-7862-9c3c-18dc0842b57d@gmx.de/:
> When calling `git blame --abbrev=40 HEAD.. -- <file>` (in a SHA-1-based
> repository), the OIDs are prefixed with a `^` and then the last hex digit
> will be cut. The reason? Git wants to align the text after the OID.
> 

I have read through this, thanks for the detailed explanation.

Thanks,
Jialuo
