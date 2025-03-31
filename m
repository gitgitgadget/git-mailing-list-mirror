Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12525214A90
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743443415; cv=none; b=JF4bejjmKndKwVkiqBJ+4YgmW9SjohJVkbmrazKHhpY8SFJMCNmK0vbYNkhatKKCwgj7pSPaHFhvZm+b72befIa8c0inOyWV5bbSAZxialHhl03IeJx/6Kea4ADZKeyXezGTC4PbmyuMKdqV6L97Dl+YhG9fEimlJzgD5Swz1Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743443415; c=relaxed/simple;
	bh=OfJ6+FOnYrRE5iSPtpuW2upohGxCYEhl3xP9IG/RBic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgOYGhGAaoyTxWu03VlrLOggYtsYuR9Pn9YdErerTCwJe0h0FpJPm4eNty3eKl+cI5nFwonsRX/RF6mO6bU2QpDPDSWj80aC7/WA0R3V2tl/2Qfx5MZS5d+48axTB8gnul/DAZ8PjNVdLQaDjbhheM/EClOWNOxGK/dsTpODC8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY4Zz7pz; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY4Zz7pz"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2c7e5f7f0e3so1299215fac.3
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743443413; x=1744048213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pb4wCPaQEE2wV3gGSN5UNgTUStueEOTDtfimPhTTe3U=;
        b=mY4Zz7pzLh4sHVasTmUC1gnlR1lr8+NJNgA3Yt0upKfMPIki9b7bAr7wsiJitiLvc+
         /1O81oD32XRtWC7mb3V8vO9csSE8edsAZQD+p0yKX3C0FYpLpJjcZOs+pA0eZaBHVeXf
         O2aGHgOvWQ+ts19xHxxjbkPZJOML6smEcapR1g2nMbOiUyHt3yMFJD1GaKeqBMqn0dIV
         tnsSY0NornzY3vFUKDiCcg13M1AHpbI4LaBzWYV0zdCeNZrAyDorS+vNp3xMuw6Z6WQn
         SN18UbaMz+kGlTWmByRs0kqFTRefT37nlZb8m7EWKuJjKqQ5FKBx1GA8JQ/ej+QkcRfE
         tEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743443413; x=1744048213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pb4wCPaQEE2wV3gGSN5UNgTUStueEOTDtfimPhTTe3U=;
        b=bDTvaqgq+uzkHZY3X3noGG5cq8hw7s8VpXOOlBFRn8G/9aAoNEaQ19gZpyNRBzjIrH
         TSarLVAR3HDWtZ5j6L0GmHW4D4DzzZTPFnViykAo17tVQX2BsxVhFTl7cv6+TTgIo13a
         oD0NUD2eBBoM//9PTpi9tR4HzwJTQFq9AahnMpp9R8j6BuxZY5g5+rmOgPoLLtKa6ILE
         nQML6FbtjHi1S/u/p9TY4ARzagxQuTNbOjFFNm89Acc5AOpL374b/hLetiCHn0RTh3wi
         fYhx5NTP7mXlAFBthr9CUquW82rU+w9AZ7e+g+e8CgNukcCTZHY2c42Vr4LyyGtGfqaI
         YLQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnZEqgBAPnr0S1H7HdTTDXLFMylwrtpMMiAi2ZIYFXQBXUpqLv9jipM99/vwC5rLH2HGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2LTa14BOOOTmDajAXK6fHLo+vHqHsrVu7TiQfCHdkG3jiQR84
	Y4R7/s9pvGF5Eiy7zqqccYLqRKH2sZCu32YXWpASkZT5LrgTQu2O
X-Gm-Gg: ASbGncse9pFLjqZMKjq24L+8zbV24kX+3L4KOm4CBZTvgk7QkG4kmT7kuP3xnpj4hLC
	wQ/IcCgewgwbuVp7DK/hj/GJIxuxdvaFD9LEk/5EBRhN/UYWs8vRw0am9jscLIvAnuxiaBsaROw
	m1OXs70PJBTMURddlqM4F2GtRPNShO+ObI2ygzGseU90nrYltHxnm4IDG1+xhg+QxYGB0EkjeZh
	+J8QXgCtp7grduw5Q27fgWcCGrHYLAU+AmAAzqQjEYKG1RC6Lrdv3hbAJ57A0A/FZMZwKcW2pDa
	DddwTpUWzaXUTKPtFQZ9GOUS1GWi1VfCYd1R8g==
X-Google-Smtp-Source: AGHT+IG7XLa77I6kUN6gNm6rSIrH1ENmIgfV5igHOsPKYhnPCgsVNHSvM5xOYKjU8o9TMxyNLay0iw==
X-Received: by 2002:a05:6871:8913:b0:2c2:4c92:77f with SMTP id 586e51a60fabf-2cbcf825a94mr5427441fac.38.1743443412861;
        Mon, 31 Mar 2025 10:50:12 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2c86a856e16sm1930946fac.37.2025.03.31.10.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 10:50:12 -0700 (PDT)
Date: Mon, 31 Mar 2025 12:46:26 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	christian.couder@gmail.com
Subject: Re: [PATCH 1/2] help: include SHA implementation in version info
Message-ID: <sqoplw2bek4xngjaq2ss54jqcn6k5hvltric2en2niiqebjfth@txxq2ga3weud>
References: <20250328170121.157563-1-jltobler@gmail.com>
 <20250328170121.157563-2-jltobler@gmail.com>
 <xmqq8qoodq5u.fsf@gitster.g>
 <Z-pCG9d7Rf9SMuXJ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-pCG9d7Rf9SMuXJ@pks.im>

On 25/03/31 09:19AM, Patrick Steinhardt wrote:
> On Sat, Mar 29, 2025 at 04:36:45AM -0700, Junio C Hamano wrote:
> > While I agree with the objective of the change, I am not sure how I
> > feel about the implementation.  Given that
> > 
> >  - The code here, and probably the existing code paths that depend
> >    on these SHA1_$WHOSE symbols, assume that only one of them is
> >    defined;
> > 
> >  - The "git help --build-options" is not an end-user thing but more
> >    is a developer thing.
> > 
> > The thing I am most worried about is that it is unclear how the
> > order in which the SHA1_$WHOSE symbols are inspected here and
> > elsewhere in the code are kept in sync.  What happens when, for
> > example, SHA1_OPENSSL and SHA1_APPLE_UNSAFE are both defined?  The
> > above code will report that we are using SHA1_OPENSSL, but hash.h
> > would probably use SHA1_APPLE as it has its own if/elif/endif
> > cascade.
> > 
> > Perhaps it does not matter, if the build infrastructure ensures that
> > the build fails unless one and only one of SHA1_$WHOSE is defined.
> > 
> > But with the way how this part is written with an if/elif/endif
> > cascade, it makes readers spend time wondering how the precedence
> > order here is kept in sync throughout the system.  If I am not
> > mistaken, the top-level Makefile has its own ifdef/else/if/endif*
> > cascade.
> > 
> > I imagine that making all of the above not if/elif/endif chain, but
> > make them pretend as if they are independent and orthogonal choices,
> > would make it simpler to understand and also it will help us catch a
> > misconfiguration where more than one is defined, i.e.
> > 
> >         static void get_sha_impl(struct strbuf *buf)
> >         {
> >         #if defined(SHA1_OPENSSL)
> >                 strbuf_addstr(buf, "SHA-1: OpenSSL\n");
> >         #endif
> >         #if defined(SHA1_BLK)
> >                 strbuf_addstr(buf, "SHA-1: blk\n");
> >         #endif
> >         #if defined(SHA1_APPLE)
> >         ...
> > 
> > 
> > That way, we wouldn't force future devlopers who are plugging new
> > implementations of SHA-256 wonder where is the right place in the
> > existing if/elif/endif cascade their new one fits.  It also allows
> > us to catch misconfigurations to define more then one of them at the
> > same time, if such a thing becomes ever possible.
> 
> Another option: we could ask the implementations themselves to define a
> symbol `SHA1_BACKEND` and use it here. This would automatically ensure
> that any implementation must define the symbol as we'd otherwise get a
> compile error. We could also conditionally define `SHA1_UNSAFE_BACKEND`
> depending on whether or not we have it.

The SHA backends get selected in hash.h, so we could conditionally
define symbol values based on the backend that gets selected there. This
has the benefit of centralizing backend selection in one place and the
printed build options could just depend on that.

I'll implement this approach instead in the next version.

-Justin
