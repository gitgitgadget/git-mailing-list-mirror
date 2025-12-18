Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39885241663
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766092418; cv=none; b=JAvXQh96p1WS5YQRYmaEIFtHSglBJKRWrty+UTt4SuW3uTXEJWusSSJrTO2Sh+5TBSJi0BOkqiGyQGc0uwRP8GWjeoaZY3DoSVfFjcyooOSNgsk6Sv+CSGMsngrBRYnG+y+ovqxspvQUsPQCm3HkqOjMLCqtr+2zK6Ps6ezWgKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766092418; c=relaxed/simple;
	bh=lxud37CqC0hQEXuIHsvUCliimLUVVvu6nmSiiJdu9ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WF/NNnJ1nzJCe2oRbWiAFWag+Xou51lyUOwn5lXxHmdHZMrIeJcFxJpme46h+31/23f9kDg7p8HgDdxZ30WL/OTCUj2UmwQnkuGyCPUpo9wHw2MUzDujF8hIDB64j2X8Adqd0kWREGpfK8OWn4+eZ60O6v2gTzNVbdH7ZD8C740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=OWnVZwhm; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="OWnVZwhm"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b2ec756de0so110809885a.3
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 13:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1766092416; x=1766697216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9M5ev6YLTfi9e3QmW7DlLTRZKQjNnoYmwKh7mh39ms=;
        b=OWnVZwhmWUfsfPlOOlRyz3veJaT+MOvjx5Ngia02ngdmVX4GurTPeWuapDPJlOLeV3
         Ha4zNzC22a/X1RQCIBQcQ+UYOQpuf7ktOLHlS3ugPnRkT0MTE0mlUbWI60k1FXpUHhx5
         1lvXpRNta8zArX2bsIHhHphyOSRJ3INhzZI3KHniNmzlqbEhj7MKCtoeFj+KCxjSpESm
         +7wxKhT4joFzP+jeGzMagL8OGKRgMDeC+HRr1nRHTj4r9enzGa/xyiV2yVCHjY6oYNsi
         /3H3VWwEd/sSKSPypbiT/DVxk/M0wo1Khcbzi0aEKdkvXVgX5HjiihgVsDiLA1taca0F
         MNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766092416; x=1766697216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9M5ev6YLTfi9e3QmW7DlLTRZKQjNnoYmwKh7mh39ms=;
        b=LGbGLE6MiWreMzdMRR0w3ptShwZK3bt2foT6thbKKQYCh013DxFO0U6/F2mfKHlQiy
         3ubwyyOqbZn36Mjwk5X9hY1v6eG4k0Y+UVK2skecYHjBssxc+TkLQjw6Fx4eDrCOngdc
         kMdTUI693QBDRsONqQT2Yq0STrcZxopfTRzuzL0y9e4LPxax8WVYKgIco/qkPq57bq4T
         0xP9N4bwfow44oC78zXfXjrF4tpxrFdB6qu9/leNYY6lm5HAhwZt9LlbNTsOkUOgjF30
         LtCLYY2jMjt9blwfyo703lI/TQM68yLfnfqR8yGVofKB/SpK6AxnzTcpy0Yz2vy+vYuR
         Wscg==
X-Gm-Message-State: AOJu0YxD5eyngBJOYFfA/LOVLxFDxHa6LMNGaAFSmO6h9maGiJVp/EZM
	o/D2LFgHxAo2yHlXY42DEUsInuNdJb7wVX4RbgyTROfAMkMPHtxodWaQHjn7ee/kri0=
X-Gm-Gg: AY/fxX4k3z+8TblzvHVMaMdPUusBbHBNIEkgdTef2hHAwKmCt8PK6ka9QPtMxA0kZ7h
	ve0HvznVGPAWpVSZloWxrrS/34wFLjE65pBywNhERUgjOitPL7UKJBYCSEfEzDFqIWyIsaUgn6/
	6LmfyPwK+zu+tPubLuiGgmWDoY1XhTfFQPQhXiuylWGau7DKp7lpdLf3SPuTSI6lQ2XAtvh1d4i
	CgMtql5rttfktF/A9kyz7wrcK2JJ4mh59lmd8Ha0OfEy/CWuNKbGYK+GhIL8hgH76pggo4umpRq
	/JQTzU7RmYfZ8EvLUj+GQeKSDtoyW0zUAV1PPMTt09y8yvhT3O6T/u3DXaY91WypgUVlg6+tbdk
	22pkyJ4S7kY1nlxwLPKvd8AyldiTYV3jrFTU4byLxKat4lcSPhhcjxqHa6XW/wrekaogS9p8e6d
	A2na0/wqNjXLnhcyyGRrpiK6OfkpviUJ87tuHhgejlTpG5yas55aXV5CyqZuqstU2O8D19N1Ftg
	H1579fU3T/Snwn37w==
X-Google-Smtp-Source: AGHT+IF8h3L+pb0aaiiivns6J7JKPYp51FusHOjAb7idY8swlZjVg+PQwAktOqW3f+B5uFg5wmg9sQ==
X-Received: by 2002:a05:620a:3190:b0:8a2:a5b2:e3bc with SMTP id af79cd13be357-8c08fbc8222mr166526885a.89.1766092416064;
        Thu, 18 Dec 2025 13:13:36 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973ef171sm28581885a.44.2025.12.18.13.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 13:13:35 -0800 (PST)
Date: Thu, 18 Dec 2025 16:13:32 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] midx: fix `BUG()` when getting preferred pack
 without a reverse index
Message-ID: <aURufIXsiNfPh02X@nand.local>
References: <20251208-pks-skip-noop-rewrite-v1-0-430d52dba9f0@pks.im>
 <20251208-pks-skip-noop-rewrite-v1-1-430d52dba9f0@pks.im>
 <aTi9M/F0sZzK/usA@nand.local>
 <aTk_-pvNA31ScZyu@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTk_-pvNA31ScZyu@pks.im>

On Wed, Dec 10, 2025 at 10:40:10AM +0100, Patrick Steinhardt wrote:
> On Tue, Dec 09, 2025 at 07:22:11PM -0500, Taylor Blau wrote:
> > On Mon, Dec 08, 2025 at 07:27:14PM +0100, Patrick Steinhardt wrote:
> > > The function `midx_preferred_pack()` returns the preferred pack for a
> > > given multi-pack index. To compute the preferred pack we:
> > >
> > >   1. Look up the position of the first object indexed by the multi-pack
> > >      index.
> > >
> > >   2. Convert this position from pseudo-pack order into MIDX order.
> > >
> > >   3. We then look up pack that corresponds to this MIDX index.
> >
> > I think the implementation of midx_preferred_pack() works a little bit
> > differently than is described here. I often get confused when working in
> > this area juggling between the various object/pack orderings in my head.
>
> Hm, I feel like I am missing something.
>
> > midx_preferred_pack() cares about converting from the first position in
> > pseudo-pack order back into MIDX object order. To do that, we convert
> > the pseudo-pack position into a MIDX one, and then lookup the pack that
> > represents that object.
>
> Isn't that what I say in (2) and (3)? Or is this about (1) being
> inaccurate? Would this sequence be more accurate:
>
>   1. Take the first position indexed by the MIDX in pseudo-pack order.
>
>   2. Convert this pseudo-pack position into the MIDX position.
>
>   3. We then look up the pack that corresponds to this MIDX position.
>
> In any case, I agree with you that juggling these different positions is
> quite something :)

I was thinking about (1) being inaccurate, but the rephrasing you
provided here and in the new version of the patch look good to me.

Both (2) and (3) from your original patch are correct. I was commenting
here on the phrasing in (1) suggesting we "look up" a position from the
MIDX, which is inaccurate. The position is given as the first position
in pseudo-pack order, and "take the first position" perfectly captures
that.

Thanks,
Taylor
