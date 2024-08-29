Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04891B7900
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957903; cv=none; b=quDGPu1wZgdEkiG85tlNLLCPwmQiddTnUVOvaBwbXN+XtbpVZL04QlCQJgYkLRmnTCBSF/KtCZldgpd/hEChS8zC86qTtSv3O6+tFTN9brvwwNO2/7S3IQoDtthQ45ou+u8PwXFywogGIUl3z7cRynC9mHX2DBWzfS2IXQ85+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957903; c=relaxed/simple;
	bh=BuI5R2RvoGAqJmSgkKYsbzytglhVKibXoMZh97goCRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqpdMp3Md48SzinXkkzwHoZ8dj9hrKrU7G+LaWXrPIJ2ZbCcHLGL0uMhfCgP4msboJFwXDVU0SVWVg+tfEkhp+DsydmnaCkEIDmgHkUoY7OxJqenYACxGnXu1v0AvDxhosa86BaGgg0u/z6FsPBWfJ/FMgY5sXE7hxc/9vVLr34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=iVGP5KN6; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iVGP5KN6"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5daa93677e1so590599eaf.3
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 11:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1724957901; x=1725562701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xI/sVT0hOC/6BmSWTLWvVLeP1ScgP51BDWrKg+Fa/Dk=;
        b=iVGP5KN6EvxyWkwwR/eZrHVcegr16WXVgysjzhJ/wHVHJEThtYo281FaP6SrOQPnbA
         WN3j3ol/RuyYH/fMhLy7AZuq0erZyGWuvb/v/wf2NmkpA0fzHgEtnCR4ZZnFrb8ghS+y
         +xDaSpB5S820uq6jWIb13joMUM3oNuP7wvW22/jA7cbPGO1Loy+QFG1Tt+86UzVsWhN8
         1xZuodnkJerkehy0+qEVu5OK1oX6gYtQ7mJZCZdqG5m5tPPzSUvMn1iUvP+kFiDX/uRq
         QH1fXNkQc6/1RlOZVfc55v/HYccbCMAW/wRKFSNSRbdI05oq2S0uAb/cpwHhMadBS/6E
         8YbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724957901; x=1725562701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xI/sVT0hOC/6BmSWTLWvVLeP1ScgP51BDWrKg+Fa/Dk=;
        b=n93znB9Gj4Djdmg6gpDhN8kb12GJP2WSLrevSQzbAd6TE1GW2bwMR5zxVV0qd71/kF
         G1JP61f+wnlJ3y71vg0lsROBcc0Zy1dvKPMAu5fx49MlT+nHlWOG4kylszpL/lgueJQ9
         EvNCHlo1kHDAxMOJgwAET6c8biCe3BFDJuJxv+etifjjnuWdgHpy9Hg5cphlaxg+PeRW
         oX6Tsp9ayljKqjdCH1gzvdQP75nSkAtAb59cIukYhOLmRY7xSANsTnP/ebSUMZNul0y5
         tNp4wBxmhLbIrlGbORjGguNeSgkSFmxEZ1c2itRSPjDvfg+bcU6bU/kZtghGNSEqb899
         llyA==
X-Gm-Message-State: AOJu0Yzmo4tmk0sQXGp4CEoQ679Ylvc4ipWgHLnGkLgcC3/exmi2FuqU
	x3kVA/AfRuzOSN+yEDOiFpYKUBnwmmCgdzIUz4kUp3Ou+k9FU6jlG9RP6dEC3RL7IDJuEX5AZNr
	A
X-Google-Smtp-Source: AGHT+IH8RWkedmz8z31a0JAbUt60m9X0OhjlAOcR24fZB7GeYWiK4/eePUE+KSIPFSRyiTBG61Npig==
X-Received: by 2002:a05:6820:626:b0:5dc:a979:442a with SMTP id 006d021491bc7-5df9789fb00mr4024690eaf.0.1724957900971;
        Thu, 29 Aug 2024 11:58:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c3f2e6sm7924326d6.59.2024.08.29.11.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 11:58:20 -0700 (PDT)
Date: Thu, 29 Aug 2024 14:58:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] pack-bitmap: tag bitmapped packs with their
 corresponding MIDX
Message-ID: <ZtDEy/teamtXMAbn@nand.local>
References: <cover.1724793201.git.me@ttaylorr.com>
 <1838bbcf7fe6daa58a7db78b81a2d08138fe176e.1724793201.git.me@ttaylorr.com>
 <xmqqplpt5wrt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqplpt5wrt.fsf@gitster.g>

On Tue, Aug 27, 2024 at 05:14:14PM -0700, Junio C Hamano wrote:
> > diff --git a/midx.c b/midx.c
> > index ca98bfd7c6..67e0d64004 100644
> > --- a/midx.c
> > +++ b/midx.c
> > @@ -496,6 +496,7 @@ int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
> >  				 MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * local_pack_int_id +
> >  				 sizeof(uint32_t));
> >  	bp->pack_int_id = pack_int_id;
> > +	bp->from_midx = m;
>
> Do multi_pack_index objects live as long as bitmapped_pack objects
> that point at them live?  If m later goes away without letting the
> bitmapped_pack know about it, the borrowed pointer in from_midx
> would become dangling, which is not what we want to see.
>
> "None of these objects are released or relocated while we are
> running pack-objects, so once the .from_midx member is assigned
> here, it will always be pointing at a valid multi_pack_index object"
> is a satisfactory answer, I guess.

Good question, and good answer ;-).

This is only relevant in a read-only path where we're generating a new
pack from existing packs and not altering those pack or rewriting /
deleting the MIDX attached to them. So I think we're OK here and don't
have any lifetime/scope issues.

Thanks,
Taylor
