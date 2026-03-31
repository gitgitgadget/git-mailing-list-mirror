Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC19451071
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774993395; cv=none; b=aCsjZ9IPJhRzfXSbqU5U4lhAk1coY2NHYxSxezSVwEqsOJnxRgWM7DqVyvow7VXFmornubv1GI+m02kEQAnzHaRJQWm8gLT9Lk/fPaVMLCUURUlwiRp+LKxe/ch+fKxOLU6Ye3NQdNiWtz38fF3UTZ3t/DPM7Eua3EiKyQbS9NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774993395; c=relaxed/simple;
	bh=gW5t0HUG+cbHh4eEDncJS0cwQ9niP7jgpdvNzGyn3p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHoK+GfTZ7FyTsQhV1OHnnYiLGVxvQEa9tGKf3XZQG+39Semp3ZPWnpKBDxOM6mo14eslfnmP0gfVpfakXdpqif8A0nsLlx5wQrtiL8noCPrEK2Sxw6NWmlF7+b5vMQADT0NJXeOARPjS6IQep53+grJhzUurjBUwPWJOmJb2/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=qGDphgFj; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="qGDphgFj"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79f8d6bc4e1so2086877b3.2
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 14:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774993393; x=1775598193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xy5UpqsXYPPj44vaaagm9nVSMkH9q9J2QBijIJSlo0w=;
        b=qGDphgFjZkCfeT4ikMHiKW/CG9omuKN0wAD2qqUi7eFJMGC+FQAVi7BmL78iOxYNsM
         /9ZtzRRQPEHRawa+GhfyjxQGqI7ucLmbx26PiKMn6iWDTWSJUEn0cMnZ4umaJRuFgLRf
         DaYMGeBcnNObORKJ+DbmQ+3kRXGL7Mam3EDPjodubhaM8tFZy4TgN8KfUKIWy4RyiXL1
         umlLmqCINf45Hs/nCe+lNAryt/q54EAEqAGMiNdqcRoE+8nReZm9KF65p2cy1dEucy5X
         +u/Vm+43wlNp8brJRQlAjXrkeuFSykXDP9th9Nrtl5SP4xxCuZiCuI7oiXFyGaCGiD0D
         ebEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774993393; x=1775598193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xy5UpqsXYPPj44vaaagm9nVSMkH9q9J2QBijIJSlo0w=;
        b=mOsbUyojnm8oI/9Hkfh00/0EgrKpqQuSlCbN+GNvDeJVQmSBrlij3MrBsIxeLfXBmD
         I093oSPCqOwogLB80IOs25FP7gCrKlivzE9+NhOnxD3yDJUX/4KDrg1MfkRBrxjOnrBB
         IV3gmJeT/de1H3YvIrCb/+kiwa6mmMc3eUADKKjLoYKoDpvnon1TdlziImx1umrTqa7R
         2PXq+PbqlFREWdXaHPkyoeyjrHMUccftE7yuNMEG1kJ+aKBvGz6nj4ktQYD3yVp2VrRG
         ri4ixQPpXzglro3rFT7mrSnBJOJ1//JykSrwq7JP9XA1DzfpJxqVYv5nxTJAondyENQs
         Kf3Q==
X-Gm-Message-State: AOJu0YyyB6Pa+k4NgPFOzgo8jOvuFeLypsMS7szfz2k2uEamevHpvoH7
	6VfQoo9OnKMAxbRDyOJ6aR+9VxXxzcKhINLTyDQdl58DPiGIPXKrhWnFk+Bv4USXh18=
X-Gm-Gg: ATEYQzxx8dziRLXkOiivtcOdIR+r0akygMIrlh3XqfxlowdkCGmSNXMZn68dxbjO5C6
	CilbrTYoi7qUnPEmSIOf3zmDGwWGIQ8Z5SukrZemk1nl9B5elxoWXBY/P+/jGwQXi/rbFB92r9Y
	8o9jN8tppqIf2QIkgPGbJIe9f3oju2I8WW063uVFK+0c7PWcxLvPE4iI75yTEMQeLaCudfjbJ5+
	22Ts40y428Iid+Mvgo/BcgWjTovQe9prsmBLvUOKmGEHVAp8w07gklRGtiDTA8RuMvcTVU6AYRf
	lqw2kAOco78asafsDJu/v0LRC26yx8Cekh4IQyTTo9etxZ8pQ0egKrQT3HrdZIS6POfNUHBQuwx
	yWYD+DaSYvYBauMLzP087pcqEVR+rs2VD1CgvIGZPnb9Rh0DPc0fEthBA0cS3Yiatwd/D3AZyCO
	I4ndYr/Spp5B1ws5mbZromxxo7jN7dDz6XzNd1KZpc8qmaOtnTt4j38IO6EUac7a173EQNb2K/Q
	MjVaOBZ0ATDcmXfgVcvG9qsGwn9iA==
X-Received: by 2002:a05:690c:c226:b0:798:dbaa:d989 with SMTP id 00721157ae682-7a211e4eabemr13672507b3.36.1774993392758;
        Tue, 31 Mar 2026 14:43:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb7721566sm54836987b3.12.2026.03.31.14.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:43:12 -0700 (PDT)
Date: Tue, 31 Mar 2026 17:43:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 01/16] midx-write: handle noop writes when converting
 incremental chains
Message-ID: <acw/79TEXFs2cZyJ@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
 <0c7a68ca5a777cce9c0c951643ea2220b1b56a8c.1774820449.git.me@ttaylorr.com>
 <20260330223346.GA41843@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330223346.GA41843@coredump.intra.peff.net>

On Mon, Mar 30, 2026 at 06:33:46PM -0400, Jeff King wrote:
> Now we iterate through each layer individually. We assume that the total
> count matches ctx->nr, otherwise the midx struct is totally corrupt. We
> could count them and double-check, I guess, but I don't think there's
> much point (it would be a BUG() if they were mismatched).

Yeah, I agree. The omitted context:

        if (ctx->nr != midx->num_packs + midx->num_packs_in_base)
                goto out;

tells us that if we get to this spot, we expect our 'ctx->nr' to be equal
to 'midx->num_packs + midx->num_packs_in_base'.

As soon as we find a non-already-MIDX'd pack, we 'goto out', so I don't
think it makes much sense to build up a count and check it at the end
even after we know we can't optimize out the write.

We could check that the ->num_packs of each of the tip's base MIDXs
match ->num_packs_in_base, but the MIDX internals handle that for us by
how we construct that field, since num_packs_in_base is *not* read from
the on-disk MIDX.

Thanks,
Taylor
