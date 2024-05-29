Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85408225D6
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717022794; cv=none; b=t42dL8Gwxsi4nVAps1lerk5TWqareVMkvIHGi0qMoQc80TOBFGowEplQBzXLBTDzpxtLl4wKtf3UwZJORrJrRWDDcVOwNWzONjaL8UHPT15cMdYCVn1g09D72zOKVrRzC+AcCyEA3RSgjV9RNQOub3ZE/kUoE/s1eEVJmj6ik1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717022794; c=relaxed/simple;
	bh=NEmiNuP22byoGfWqdvtRD4BNZ2pc8+OZ89funVvDEOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmfOggXGpggW8hcZ/kgsj41qkbnLVY1t5SkWBns9uYEtjMoXFoW7HjapOD9Q+lJ18BKPNVLIjoyq7rTLAL97VNfFpQB2IC2+eqWvT9c5mcN2a9u6jFcXxYNv0itCYJv4ANz66YxMhw0MvMTghleDppb34prCIab0UIxXdxTPGe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=chV7jDW8; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="chV7jDW8"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-628c1f09f5cso2075037b3.1
        for <git@vger.kernel.org>; Wed, 29 May 2024 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717022790; x=1717627590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c0HZaZX0rWpyqRL3w2Wu1Ki9T5vcZIHcYp6W5rHQ6aM=;
        b=chV7jDW8Rf8p8WMhS5UFoLS8c4IO2BGW2P6eoaaTqSO4U01g8vkExjTyXyPE3swEAA
         Wm7peo2T+g3c8aLPWFTdDT5hRpB5+YvyGi5jtf9/vWHizpa3nTyf7VoLAhMyyO0+TQHI
         ao+LYClbIztHmy4m3o0GEcARNnE6W7l1IpsAV081WC+5lDMbbs1pNklsuUDs5zORGI8q
         Llge+lz8Ax0MYbiBb+e4XcaWA84eGQ8VDksKcI47tMAcTUbWbgiqiTmEcE8O5/mjll9G
         JNxhTmq4pUJxP3Vki/4zbNB3SfW889k4QWITYaUuyi87xhkzgTj1Vxg2E4iZMkI3b7z5
         3JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717022790; x=1717627590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0HZaZX0rWpyqRL3w2Wu1Ki9T5vcZIHcYp6W5rHQ6aM=;
        b=Jnq8iO/oVkoWat1GXFBEC7ewUmPDmq3QSYbm2Gf5zMu30KGY72EgpGvb2JIMd7SWLW
         s7SmKzm0QO4fwmS8mIVAHTdaEYMBhlhsne/nDMs3moHHZNdCmWZ9LjZzzXXCAF5ynU7c
         pSd6vsYBPw73AOFsJZ0UpHgvvF51k1wqKuekLz0pGdSGF96EYzEtajYVTFvM9g/2Qo4K
         2pqsXX1vnx884WdvUD5AoYdIb4zRsckVs6pQfDtLF+vX541Mn7C8RAR3xO8t8EtlkHMb
         w1r3uIaITBx0fq1YesHUPFILPtG985Z28TTDpw9fpplWXB8fR2RrvKl+laq3LGvHKGFA
         zIqQ==
X-Gm-Message-State: AOJu0Yz5CT+Cqc5mEFvHgFEdQWNjrhYW1/G7z9Tf6YXGCZddIvKGnuHz
	Yw1H7gcSq3MFd5pUX3rZ2EZmlV8wld16sRu64BEljndSyzQGjIa/Ozli3cvDW00T0VemDL08drb
	c/0s=
X-Google-Smtp-Source: AGHT+IFWOqHLieodnNfZ/4+b+pjly2QPOmLturc1byTS1OskXGQyhKwrmBrsfozgjy+sDtT0+01hLA==
X-Received: by 2002:a81:a906:0:b0:61e:a66:bccd with SMTP id 00721157ae682-62c6bcc59c3mr5340777b3.38.1717022789374;
        Wed, 29 May 2024 15:46:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a27d401sm26046637b3.6.2024.05.29.15.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:46:28 -0700 (PDT)
Date: Wed, 29 May 2024 18:46:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/8] midx-write.c: support reading an existing MIDX with
 `packs_to_include`
Message-ID: <ZlewQ0NXmJTw4hWt@nand.local>
References: <cover.1716482279.git.me@ttaylorr.com>
 <61268114c6562ba882210fd94b3f336efcb5c486.1716482279.git.me@ttaylorr.com>
 <ZlbdxJmIBvgV_VIF@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlbdxJmIBvgV_VIF@tanuki>

On Wed, May 29, 2024 at 09:48:20AM +0200, Patrick Steinhardt wrote:
> On Thu, May 23, 2024 at 12:38:19PM -0400, Taylor Blau wrote:
> > Avoid unconditionally copying all packs from an existing MIDX into a new
> > MIDX by checking that packs added via `fill_packs_from_midx()` don't
> > appear in the `to_include` set, if one was provided.
> >
> > Do so by calling `should_include_pack()` from both `add_pack_to_midx()`
> > and `fill_packs_from_midx()`.
>
> This is missing an explanation why exactly we want that. Is the current
> behaviour a bug? Is it a preparation for a future change? Is this change
> expected to modify any existing behaviour?
>
> Reading through the patch we now unconditionally load the existing MIDX
> when writing a new one, but I'm not exactly sure what the effect of that
> is going to be.

Very fair. The short answer is that this is a prerequisite for the
incremental MIDX series that I'm working on. The longer answer is that
an incremental MIDX-aware writer needs to be able to consult with the
existing MIDX (if one exists) and exclude any objects which already
appear in an earlier layer of the MIDX. This is done because we cannot
have the same object appear in multiple layers of the MIDX, for reasons
that are probably not interesting to this series.

I put a more concise version of the explanation above into this patch
which I'll send another round of in v2 of this series shortly.

> [snip]
> > diff --git a/midx-write.c b/midx-write.c
> > index 9712ac044f..36ac4ab65b 100644
> > --- a/midx-write.c
> > +++ b/midx-write.c
> > @@ -101,27 +101,13 @@ struct write_midx_context {
> >  };
> >
> >  static int should_include_pack(const struct write_midx_context *ctx,
> > -			       const char *file_name)
> > +			       const char *file_name,
> > +			       int exclude_from_midx)
> >  {
> > -	/*
> > -	 * Note that at most one of ctx->m and ctx->to_include are set,
> > -	 * so we are testing midx_contains_pack() and
> > -	 * string_list_has_string() independently (guarded by the
> > -	 * appropriate NULL checks).
> > -	 *
> > -	 * We could support passing to_include while reusing an existing
> > -	 * MIDX, but don't currently since the reuse process drags
> > -	 * forward all packs from an existing MIDX (without checking
> > -	 * whether or not they appear in the to_include list).
> > -	 *
> > -	 * If we added support for that, these next two conditional
> > -	 * should be performed independently (likely checking
> > -	 * to_include before the existing MIDX).
> > -	 */
> > -	if (ctx->m && midx_contains_pack(ctx->m, file_name))
> > +	if (exclude_from_midx && ctx->m && midx_contains_pack(ctx->m, file_name))
> >  		return 0;
> > -	else if (ctx->to_include &&
> > -		 !string_list_has_string(ctx->to_include, file_name))
> > +	if (ctx->to_include && !string_list_has_string(ctx->to_include,
> > +						       file_name))
>
> The second branch is a no-op change, right? The only change was that you
> converted from `else if` to `if`. I'd propose to either keep this as-is,
> or to do this change in the preceding patch already that introduces this
> function.

It is a no-op, but I would rather keep these separate to keep the
previous step a pure code movement rather than introducing any textual
changes.

Thanks,
Taylor
