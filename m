Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A809518E25
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344422; cv=none; b=OUndXCOQmEodZZfUifDSpdqwmm59lPdIuoMZ3aPVLMUTrEhSXIDW4R0sJSf2hgJMGJ7SmItMEBb8AztuUwfmKYLfGf7HKksUuPwK6P3I+pS+tNUFled7/XX9FG+nG4XLb1NcvaMpKmxP+hGwhvw9r/twTtFTpTLXSypvKTlKHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344422; c=relaxed/simple;
	bh=9ITX1fZKXmgG6OouVHWyc7hr3cPnWL+SPxolCwMcCdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p476K4dQCRqtj6dFB8VbCdVACulZ4d2YeO7vb2kbr51TO4xp5G+r93MhgDSisUBsl0YYxYXUN/CKXTrMX3QBJ/J2xlzr4j4pPWljl+EvOayY6A/zfy4yFYEZwtp42o03yrqFcMQX+L7bxUOJq1ItXYHf4J2UDDEiYQB1QUp7pnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=vdZBkY7A; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vdZBkY7A"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7be6fdeee35so1095506585a.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742344419; x=1742949219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KCtGAJJlRarM+9IRsI+EU7Tjzducis8lFk0kkMjqdpk=;
        b=vdZBkY7AVslAX2YxtXhnDmbPGb+0IGlaKix63xn9crBfwVkO35E3jGFeW4uCgq3Ndi
         ld3pEuqswMgcmsw29PJb6X9aMfK5tLMpZ7+APQzWwxVMGsZw3dIPMtiQlhXiEHVNgJ9k
         YUs2iTFYcXIxbfKbJun05IsO0kMXVUKQ7X1vNOTwmvmfyr2xTj6B9q6qUUMi8eGQhUrJ
         vrSqY991kp3gONEher3JUsQx0Hv8dKu0vnPM/YI+XntTmk1D2pTI6V80pTedINzkt3Fb
         1pHkifHRPyuGaojHrHX6k85zjtn3X64xF3jJ0ZV8S/D5Si/TMtE+s8Tzsc7b4MVKQvHt
         RHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742344419; x=1742949219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCtGAJJlRarM+9IRsI+EU7Tjzducis8lFk0kkMjqdpk=;
        b=C95dBNdT5384SMrTVAA32ZyDr0s7IVAxLiOPKxr+dTvBoTmpQlK2cv8MLgw7Sv79fY
         B7qx2C+8juD4MgZ+2S9TX6CvcuJhQwqU0KdQcSHFFrpo0+SKxThNmZDCK3Zlc7g83EVO
         JQD3gUDgPVDXoqgGLDIqk0sc1Y62jk+84R/lVRGknXjnocDBdlZozrWDP6w+iscpD4dU
         btIQz2a8fUlDJt5Rb7nJqewoShnT22ZgCnSF+ortSnhAbAe9aDkMDTPaRIRMQXmAzEBv
         SBCE9KOY3qHQA0mUADAFh8NS+JxTMrHSmV83H3A0pJ04sjUf5oPSSG63ypQdF6YslURd
         jj0A==
X-Gm-Message-State: AOJu0Yyfo8n99QbsYTItg4TQhwuOLIjJk8zmhpNaD+qaEGpAKtIQPTIA
	rLT2lrO6oGv3tFyaLeoZCHaJ1nvE+QYXJnaXu72m3IT08L1jxGXo+558Iy5WDk0=
X-Gm-Gg: ASbGncvdVM7nlN1EIcyk1kX0ysmVH8wzosTq3GSN8S7nv6lBMwSaJ4wdtWzS0StRxJg
	FJ7/zI1yt1bO+NAv/vel4CudzuFG3eEiNRluW23GcW1kAthUPWJYycL6SCRld/rWf2ElmJ+/q1+
	ppRXnzd+fYnGe7DsvIeNlOTOCGmlqjPMeC4gXtXE8b3du1MS+ca4QzjeKVeoIv3vYVJ3y7hZOI0
	CdOTDg9ZfX1WmFZ8DAlIxsD2TIICN5r5/uXtOnoN6MEp6kTZtPfEH60cKtMDFljFMPCjNjOOuRo
	z3uUYdACpPJPC2fVeM5gONxAi3BgKauybH+AosIXHdszu95GD6mWL8fy3+Uq8HQSp5L4sOGz27/
	4gjeRD9BIaRXWoMmH
X-Google-Smtp-Source: AGHT+IFh/Pv8wkKoaXKuW+L90btJG0pvba2K1b3zGJdt3DyqyJmfTwv5JESHk3b+Ftr3rYWXuUf68A==
X-Received: by 2002:a05:620a:1aa3:b0:7c5:4de8:bf65 with SMTP id af79cd13be357-7c5a8460e2amr131641485a.36.1742344419477;
        Tue, 18 Mar 2025 17:33:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c9e0c7sm785846585a.58.2025.03.18.17.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:33:39 -0700 (PDT)
Date: Tue, 18 Mar 2025 20:33:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 10/13] ewah: implement `struct ewah_or_iterator`
Message-ID: <Z9oQ4moLVKh3+vul@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <cb08ad6a62092b9521a11c0524f23bd8831c0409.1741983492.git.me@ttaylorr.com>
 <20250318014417.GE1471939@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318014417.GE1471939@coredump.intra.peff.net>

On Mon, Mar 17, 2025 at 09:44:17PM -0400, Jeff King wrote:
> On Fri, Mar 14, 2025 at 04:18:50PM -0400, Taylor Blau wrote:
>
> > +void ewah_or_iterator_free(struct ewah_or_iterator *it)
> > +{
> > +	free(it->its);
> > +}
>
> Hmm, I thought this was going to be come "_release()" based on the last
> round?

Oops, yes -- it should have been. I could have sworn I made that change,
but I must be hallucinating. In either case, it's fixed up in the round
that I'll send shortly.

Thanks,
Taylor
