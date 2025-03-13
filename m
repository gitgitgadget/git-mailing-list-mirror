Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC982686B3
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877311; cv=none; b=DOV73GzXvV7Lv39CzW/mOq9rdiTYnhrfaE3JlYpAPQlbkkhRGyubQWM3rX1c+hNVfx7yIabHIT++sHRO3+OE6/25xqbAoft321MD2fWdSTbZtHrt1jsbpkNWce2hIdp+5St1bLfeycb1qW8KUZLX3328BsGmzs6Y6zy8V9s+BEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877311; c=relaxed/simple;
	bh=at8pQGTR1TNdmG2oN1JVG2lfo1VlVdZGB0pUZbtkSb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5BALF4eM6MU2XQD3aC2rpnM9Ub0MuKw4RAE5P3kPs5L07E9qPjurAOiQ6fDL7H0V1LkJjFrx2nKYGBYLEKt/hxdYc2iGCEaPThTR27K0bRaAV/d11xqZ0STSUeI2wRDv1koszoduFX4meBnEE3AqrINghj0vPNKA4NezLLCsgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j58uWqIS; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j58uWqIS"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-601c12ac8d0so463707eaf.2
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741877309; x=1742482109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LawqL6m6SGQFTrw4Jm6mRdqlKC5lrLjSJKtTtRyKt30=;
        b=j58uWqISFNKz4utiIG1mkckoJy1xMH3iOKqmLko3Smx6DE9zyBoAOsvOBcMHnFtVNX
         q0QG63dmRfCFALe+Ya8Ga3fQ/LFFbQC5sKX/siWI56lTCi+19v+Z6jkKoyTzFN8qX9So
         m8JsUt/fOaVgDczL+r0nav2pkoNV/gtXeGmiiPADSvucngiijmMucXNUIJ7Gx8hWwAnX
         l08Fjcw07g7PsmP5pivJLM+6IMbviRmKenb+csr4ZqfyFP/wF5YziSByrJy9sB1MmJS0
         OrVP/Odm19V50ca9d2l4EJIrUsNxpfsFRoMbVvAfKHL5daSF0OaAmozB9pWKR3bGUXkF
         XeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741877309; x=1742482109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LawqL6m6SGQFTrw4Jm6mRdqlKC5lrLjSJKtTtRyKt30=;
        b=eIPXNEkn8wn1eUxU2wyZ9GeJQ4X6u30F/GgcgVy036dX2cGuHWCPxtDhERumpf0BKL
         qk7uGKh3K/vUBeHLh/64HPiHoxdmlJv2XujNxQF9aUKAJgoXo06BEalxrT/fnszZ6UDk
         WGNPyAZTN41u12jFYH3hmZQDOpJD/xGF95MWoFsGU6MIlXGmt8KN/vvqlwDUygYYcfVu
         rWCFwnXw8T7nY0tbyjuYqyO45PD3F4m1/u6mw1G4roCCKB0B+hLqbPPrrYoL1tDOy3AR
         yP/GIuNv5WsjuisVS5QBw/3H5iQD0tNz+EhAu1ag5q5YEC2ZhaHm/Kfe+G8DQXOA9ugj
         wcIQ==
X-Gm-Message-State: AOJu0YxPRGAL4xpG8Ae/DLfksCKA+2wtNY/SmF1L7QS9EJLFJEIm4aX1
	9nkHXDaGnpnWv6AJe2NW9S8FKBOPMyuGxY5QPXSqlrbwUYUnP0hr
X-Gm-Gg: ASbGncu99Lo1Mw5cOTumhinqix62RFdvoow5G6DvuPSTnWdbildTIUjRiagV0PdsP+u
	uqBI477sbvpqBjblosBPLpQbBtaZ+Q0K0R8kq/e0dvtwhZ2RUxk7DVgl/h955NlRN3HDHy1MJIx
	VauNIwOlkrsXE2Wlq0fy+jD0yymaYUX0nVKA7ovRoD2NmtEeDe4ZdDdyinvX3jt8Hm1vmRWfEII
	nxheU5XtidBb/DUXupYbH6+1GSyi353gWwP/vym8id7pDaJbl7nPNWu2rcSvRmgYhS6oF81yYHX
	XvzKQdHn0qqmfDhHMjvUM1VrNW2OKbDWI7m3Qg==
X-Google-Smtp-Source: AGHT+IGbhv3qtQahRzru8cDxd4HWvi/7CRgpWWNL4coXh9+oCJ70SFqpadJEodcMcXkGaakqb/dihQ==
X-Received: by 2002:a05:6820:260a:b0:601:b42c:6316 with SMTP id 006d021491bc7-601c1e2c9c2mr5685289eaf.0.1741877309109;
        Thu, 13 Mar 2025 07:48:29 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-601db67c639sm219425eaf.16.2025.03.13.07.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:48:28 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:44:59 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, peff@peff.net, 
	ben.knoble@gmail.com
Subject: Re: [PATCH v2 4/6] rev-list: support delimiting objects with NUL
 bytes
Message-ID: <e6d4eld6brhris7gmov6zwn2niywmlc3ik2aqoz4bquvpzwurg@g5mlot5mvrta>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250313001706.3390502-1-jltobler@gmail.com>
 <20250313001706.3390502-5-jltobler@gmail.com>
 <Z9LVxt8urwRXLLcL@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9LVxt8urwRXLLcL@pks.im>

On 25/03/13 01:55PM, Patrick Steinhardt wrote:
> On Wed, Mar 12, 2025 at 07:17:04PM -0500, Justin Tobler wrote:
> > diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> > index 785c0786e0..166d3cd19e 100644
> > --- a/Documentation/rev-list-options.adoc
> > +++ b/Documentation/rev-list-options.adoc
> > @@ -361,6 +361,29 @@ ifdef::git-rev-list[]
> >  --progress=<header>::
> >  	Show progress reports on stderr as objects are considered. The
> >  	`<header>` text will be printed with each progress update.
> > +
> > +-z::
> > +	Instead of being newline-delimited, each outputted object and its
> > +	accompanying metadata is delimited using NUL bytes in the following
> > +	form:
> > ++
> > +-----------------------------------------------------------------------
> > +<OID> NUL [<token>=<value> NUL]...
> > +-----------------------------------------------------------------------
> > ++
> > +Additional object metadata, such as object paths, is printed using the
> > +`<token>=<value>` form. Token values are printed as-is without any
> > +encoding/truncation. An OID entry never contains a '=' character and thus
> > +is used to signal the start of a new object record. Examples:
> > ++
> > +-----------------------------------------------------------------------
> > +<OID> NUL
> > +<OID> NUL path=<path> NUL
> > +-----------------------------------------------------------------------
> > ++
> > +This mode is only compatible with the `--objects` output option. Also, revision
> > +and pathspec argument parsing on stdin with the `--stdin` option is NUL byte
> > +delimited instead of using newlines while in this mode.
> >  endif::git-rev-list[]
> >  
> >  History Simplification
> 
> I feel like this last paragraph, where we talk about `--stdin` being
> NUL-delimited, should already be mentioned in the first paragraph.

That's fair. I'll move the `--stdin` part to the beginning.

-Justin
