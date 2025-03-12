Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013111DE894
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806302; cv=none; b=Zc8msG4UppnoUqYHQbOVopxi7TOhKbu1m8ZXkCVzrjnu0cBrBG6skLg3pPXK6yjsE9KII4VhS3Ib2ky6RGLM5lu1X/k7JCcAo/gyWvt9m10lCz+HUkgvQ4VwoM8nY+Jw3jSp4fvMHt8tczD2Ph2S2Gg9gmYtxewnhTxcXtrutLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806302; c=relaxed/simple;
	bh=mYdn+TrVUr1SMgTllC551JX3s0sBtyTgJH0+3KX2ckA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XO8/6MrdCC+HZ+izqMHRsDMGPZVvDWtAAqIB2vnimiPeUORkEnRqfeofcTnBQDjlp0Ow579jJVgotrCXd6XnMzo1rPr20bOnjOozNy2hcJ6VTVoy5Lnb0kkGvxQhHCeTGMuCboI0Y31KbsWdGyOhlHSP1EOugSktVW5uAALwBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lhCUzg10; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lhCUzg10"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e634c42a296so168453276.3
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 12:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741806300; x=1742411100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+plCl/5BByer82T/+2dpv0rKitRNM9CbGAlniC5c8uk=;
        b=lhCUzg10P3KRsHpD6BHoKkFBTqpHwcEkgVsCirEMR/L2FBo+l3QTLDzBObnewiNJKN
         DAFOEAwyur8bYtZ/XiDVpffoEjghMnc3rMMPmyP+rvbnl9J3jmrH4IPNkRP1WWwo1fYz
         XSA9KG25wVNiOpXMhPtU5czwmUKZxvGgkSbI0Dz56INTLLkl98HUG0a0zJsAAortH6C1
         yMJqbUfSARQ62S4sx1ZRXBosjCMEt+s9UvlysdzsgZpUl56YJFTfJYIbdHBQ0eGrSvtj
         t4uaZSmH+CWwAf6TPdUthWsesFkiEAWzQBVIey2Gn6H8Y1RWLckTXsJLuOdWEW+yduLj
         QOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741806300; x=1742411100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+plCl/5BByer82T/+2dpv0rKitRNM9CbGAlniC5c8uk=;
        b=Iprbac/pWzmsE3da+1YuKIjKNyJAQHRf9PNaEjyCFeXwLr4iAHkPtrz2okiTIlZfOf
         DPkCO2vh8VOHiSCKpK0/G6mnftU83EMGsG6JBgE7kLq2jcBj90Y3DG8hDNS5+Pv2oHpH
         VRH3Qn0t9FIxqvJSrmeJuOsFgl4bag4vFfXCQKIZeKxFupQLfdUYMC/rw3r3EAY2hpV6
         cl16jfm+/NdJAcFtORPjm+jb4FNmT5nE1qFTZo67d8wIMvkgwYzz+RuvFIn5JAuPIWDo
         QPaH5qMJZPYmcRxjyxZ500Cfmsd5kSWhu4PqdJ3AsSS0G2xPj/qpilnsDTyL2wQ0NUXL
         L8Xg==
X-Gm-Message-State: AOJu0Yw1vG/OLBrfnCVeB1LE7d7dQWkSfypwdY/bRKJn/6Qcjj9GV00X
	xaNsvuvyzrBs2ylT0WCVtcYz7Iw0EXGqopw0AKyWaoRbDGmGnTAuPc5zFB+6X9w=
X-Gm-Gg: ASbGncujaZ0LCHqOQisfPIlmZDBvmSFx6wo5xSp8jOCTTuw6/0F1G+JVedgdJns6xcB
	dSg7NPrVWqxrZWSnCm3bPZ++X8/KkyT/DcSpzuNjPcgSYPw1UY6E+S10caqdPTdDSPnOOVJd1gP
	E5D6ou/XNOih1DZu9zFgKL0Oc+CPGA0xVyUUJpiGKtxQP+hTdoc4cZ2GRcYzRuBR+r9mmBrJXal
	s3uelrPMnsg6Gwtt64tB+kIW41cJLB8XUvzCYILP59rSiZMkTL9L3ZX5p3jMHlDUcH/5qWGOESD
	dVP8qKuaFX2ghMmcnNPunVkGV5kwSUKdYEXqf9Xup0m2poUVqaurUmu+ijdQxXxSRcRDWt8zQka
	WwAbG1c7vrv3mpmw6
X-Google-Smtp-Source: AGHT+IHCaviROwC+5Z73oUsJTZ/NYvxoD1nPaPuHV/YfYgJyErbXb43LVdRK1640qqGABMDK+MNHzQ==
X-Received: by 2002:a05:690c:d91:b0:6fe:d759:b187 with SMTP id 00721157ae682-6ff0925f1d9mr112704047b3.24.1741806299814;
        Wed, 12 Mar 2025 12:04:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fed1104aa3sm24402097b3.98.2025.03.12.12.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:04:59 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:04:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/6] pack-objects: freshen objects with multi-cruft
 packs
Message-ID: <Z9Ha2mFXpojI+aIR@nand.local>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741648467.git.me@ttaylorr.com>
 <xmqqr0332un3.fsf@gitster.g>
 <Z9GpQqm4YBvWF7Ff@nand.local>
 <xmqqfrjixfwe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfrjixfwe.fsf@gitster.g>

On Wed, Mar 12, 2025 at 11:28:17AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Tue, Mar 11, 2025 at 01:13:20PM -0700, Junio C Hamano wrote:
> >> > This series resurrects the first patch from v1 after introducing a
> >> > behavior change for 'git pack-objects --cruft --max-pack-size'. When
> >> > given with '--cruft', '--max-pack-size' now allows pack-objects to grow
> >> > a pack *just* past the given limit by at most one object.
> >>
> >> And what happens when the last object appended is very large, like
> >> 70?  Would we end up with 270 when the threshold says 200?
> >>
> >> I still am not getting what you are trying to explain in the above
> >> two paragraphs, but in general, "give up just before" would be a
> >> better choice than "give up just after", exactly because the threshold
> >> we are letting the user to give is the maximum.
> >
> > I think this is similar to the discussion earlier in the thread, but let
> > me know if there is something here I'm missing.
>
> I think the only thing you are missing is that max specified is the
> ceiling, and "you can bust it, hoping by a little but you do not
> know how huge the error is" is unacceptable.

I agree that in the general case it is unacceptable. I think I might see
it slightly different than you, since for cruft packs the idea is to
bound the working set of what you're repacking using the size of the
resulting packs as a proxy for the former.

Maybe we should call the option something else that makes the cruft pack
use-case clearer. But in the other thread I came around to the idea that
this case is too niche to address completely, so I think we can discard
this round as a terrible idea.

Thanks,
Taylor
