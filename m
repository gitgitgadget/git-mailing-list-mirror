Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B3F139E
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 00:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788171; cv=none; b=cqizHHCHpwKICM2k9ie7JlPyK2cyI+0sPZCYi+PI6ILUfiXxk7ej3ygPwzQ54GcAzLzHnYNTzecOdgo8uOylFfq+fmtUdzzDJ6xluLLI6tOuJ2mhIdCckSSIqi1KEVwpamoYn/vNhsnLdtQ3hoJCXIVlM9IdFXxO7/6DLPQiv5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788171; c=relaxed/simple;
	bh=nbGCRA92AVuAWLDDRxRsl9hZUHignjGX/hClTj1HezU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPwK+BTRvTGIUSzqRYKPe5mlM+utlGEIlwf9zcGMJgXDFKEWF5pvOXiRh+J64XCjbj2uWA7aH6V9FJUFy9Kot/86pVxM83yTLSIFqpHxfXzRZeIxeRlmINfi1l3A1qgaYRq8R4G4Dh2kCbFxu2WoL6qfuzP41ODYAerbRHE53+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=V6FsA9u5; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="V6FsA9u5"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f6c90b51c3so24910707b3.2
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 16:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740788169; x=1741392969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n/PhN+kedCZ0Ghij6kHo7U08+0paiHbioTykIKa4Ijo=;
        b=V6FsA9u5XyLICQn4KSk1NzVok30msDtf68AD4VSqKyPrS+9ZbuKKcGYeGE07WrJPAu
         0Cvnln7WWdRVcU4vwqaenjQSZfi21wZLgOWo028Vwhdxxsuc+qbr+PdCBubevx/hTab4
         CEPkefEiMy14y690e+DmfLpHOtfctoiw5HimLfY95GZcIfooiEjs+mUASPyG/QiadNni
         euSCSJA+7atdkBcbOB20T0Av2vnZBFVTDA9WVhXi+C8rB4aaHLEuJaNpcYs+luC3cs9D
         VWr+7nFNzEfwt/QlXEhOyomjf94y9aVIOZsK7be+ZxBMOBX+nBfx49NxviLXwVxy/dF+
         L3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740788169; x=1741392969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/PhN+kedCZ0Ghij6kHo7U08+0paiHbioTykIKa4Ijo=;
        b=lxqC8YmtyugrS0eykC7uGt3ETpzDgSnzCfjsMz9Mu6Xxf3LyloBL09Y2pkpNYwiXhk
         TlELi36al36E8pLPhaS4MlYXnCG5J9S3o4MQZ+2ccXAmsWrau1as9bUaCQJmlo7AGb+s
         xnOFhWGxWTHDd5SvgXFp9nFDVUimAip5xlyYtJ5WjtvXCY9e4LCuE/fdWE9us6tcTGdT
         Wyk0v8wgqYMJn0gpT4uT6II4XgzTeOOY8l+kkkGNBh0ZSvjnQxta6vUkkeHTrNmaOzbf
         v5bgorINMajEzI796yvwIxIWp+HsLARdlHQnztYLlv0H9zxT711HteWX1Wod9VfFDltn
         Cdpg==
X-Gm-Message-State: AOJu0Yx7CbbbQPLfZuAJ4QlCn/g+FUIkj/9Am4ekL+0TCClvCBFdDcjf
	U3efUsyrv5euTI/fmq8ZMbriU5XXFuzNRo7pqR1ZiDWUkOOXEfslG31vFWE6dus=
X-Gm-Gg: ASbGnctdqqVFaaRWZ12767XfpBfGDTxVPM0XT0vKVKy23raYsuyTN6mhrWXV6/trs77
	9HvoaXweUDVXwaQpCJxN9aG3gsoXvq5s/MPC8e0GahtuJ5kB/BLLQZN1inIP9fzPeJdAlV2LZmP
	B0mzk0fzpmjxza+ljp3a53MPr1JWR/W6uIRq5CmJywv84HIWpzOTFZz3cIl3a2WKBCcEj4W2+3A
	zgAUuOcXpZkRkpbpQ3Lr4e3xl2Xx2d+GtmgwkKUA4sDJcOpIEdLcww5q4Zut5Ppi/AsJ+1Cb6dv
	OM9fAdeePlsF4t4zY3JUPFHmenuQUhPlRPDazoBSN/D6W7nuVqeXFEIjQ5fnQMrn1FKp+/lLiss
	nXTM6kX7dq7AvIUxc
X-Google-Smtp-Source: AGHT+IHLsdEAUMkNSiocMKITx3HmUgbmXC/BjLE/mTFP/HBNhv2XCvpBtU9Z8wkxaqOsiIt5gTgr1Q==
X-Received: by 2002:a05:690c:600a:b0:6ef:761e:cfc with SMTP id 00721157ae682-6fd4a1405a8mr72825407b3.25.1740788169014;
        Fri, 28 Feb 2025 16:16:09 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca633d6sm9523737b3.54.2025.02.28.16.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:16:08 -0800 (PST)
Date: Fri, 28 Feb 2025 19:16:07 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 06/13] pack-bitmap.c: support bitmap pack-reuse with
 incremental MIDXs
Message-ID: <Z8JRx1eY0YrTvNEJ@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <c8401fa0fbdbf1fe1422cb3105aab2cb8058f331.1732054032.git.me@ttaylorr.com>
 <Z8GJc6iDqueVgc67@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8GJc6iDqueVgc67@pks.im>

On Fri, Feb 28, 2025 at 11:01:23AM +0100, Patrick Steinhardt wrote:
> On Tue, Nov 19, 2024 at 05:07:35PM -0500, Taylor Blau wrote:
> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > index c2c824347a6..1dddb242434 100644
> > --- a/pack-bitmap.c
> > +++ b/pack-bitmap.c
> > @@ -2347,14 +2348,18 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
> >  		uint32_t pack_int_id;
> >
> >  		if (bitmap_is_midx(bitmap_git)) {
> > +			struct multi_pack_index *m = bitmap_git->midx;
> >  			uint32_t preferred_pack_pos;
> >
> > -			if (midx_preferred_pack(bitmap_git->midx, &preferred_pack_pos) < 0) {
> > +			while (m->base_midx)
> > +				m = m->base_midx;
> > +
> > +			if (midx_preferred_pack(m, &preferred_pack_pos) < 0) {
> >  				warning(_("unable to compute preferred pack, disabling pack-reuse"));
> >  				return;
> >  			}
>
> Instead of completely disabling preferred packs, should we maybe fall
> back to the preferred pack of the next-higher layer?

The upper layers aren't really supposed to have a notion of a preferred
pack, just whatever pack happens to be first in that layer's order
(which by definition of the pseudo-pack order makes it preferred, so to
speak).

But the base layer definitely can have a preferred pack, and failing to
find it usually means that there is other corruption or something else
wrong.

Thanks,
Taylor
