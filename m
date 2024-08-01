Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A01E4A6
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722539013; cv=none; b=XQuY5w+b0334Ytr5QovdYvrMikclncw5vhNUcTQlA1wW7tlc71NTsABzJnPMmAjSM9kVktp8P4+JPCmWNlImdTM8gS0d9fuu2PIMIftfUeuuL0KodzG4u8pdS+I932k+0B0+FizispWV/ls37nENh+e49bqa7wCp07si5LT0WQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722539013; c=relaxed/simple;
	bh=Nu0ZW0a5NOfBh7X2shHdbbfyzGj4K1IU8kJA1vuZXMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kyz3WzCqPJX4KRRje0r0Wyd7hbM756D41ZP6b7nFicKN5NSeFhlx8jeScPnIeN2dXuCcsYuf/SY+Qf4U/zGwHsRWPoaxkJGm1Lna/VmssJSDz5uh/L4gQ5c8YGDp90c4VxOwLFL6A90DJLMACxm8qIDA1ClTRpkd7GucifDf2Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=AyEuewTc; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AyEuewTc"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-65fdfd7b3deso59643617b3.0
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 12:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722539011; x=1723143811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nu0ZW0a5NOfBh7X2shHdbbfyzGj4K1IU8kJA1vuZXMk=;
        b=AyEuewTct4AG3bxTUVlYBZUiuWZLZLo4Lau1y1pVJ8kzGCZ2mIjihF+5DfRQQ7wm9O
         qO5dQDim7ufk+bFCdQ6wEuNiEfihyr7yFtNMBuY0qs3J7P5Rw3zjYJuFspOp1cPPb8H4
         2Nbj3LGjT5Xp1ubYfiX3AiWFcAYCcS+Tulq2GwB6TfzuyfnXorxP3BnbOgKgr24daAWV
         C1wkveUaWrWQqoQL/WOVnXjmY6g0qkOVbjPh4EZcltf82KyxInZu+5NtAzt74kGK3Q5Y
         K0BqPxPW3zowkCoC4gaTI258t3SW33j1paR0Pi/cJZEisfHRV1dW1C84slozXPCmPEVg
         qzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722539011; x=1723143811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nu0ZW0a5NOfBh7X2shHdbbfyzGj4K1IU8kJA1vuZXMk=;
        b=YQaqeyvSYxdJBuC4m/pNjh2TLpHRPaf6Ji+WSvkyDPne6TBJ+cj85TIwbSpJvPAxNE
         QitKMnLnNlYYeJ8VH7ZG9spG2DNjFBaJZYWLKQzotedOijAOo2mleMkGPnxfuS8jouWz
         B32EOT2Y1B0kPy0QNKnu9GamYflp2nnV+9p+cBH0eQS5tZE/YlJQbOBCRx89mhDX5/lw
         DI2fFIIg26iDVQm9firyId03kr+UR+E4FleIv3lfAliS75uJolahlnkMU6LO1/um2WpU
         +slvXTh2t6WSQxkdEdDSyukgHhniEqudcw3IBqrLYkhxepn1S9sDyrdwSP3GhoOOM7mM
         qgWQ==
X-Gm-Message-State: AOJu0Yx19T6J1hl0bmUtH1Ax1linuUPnr8Pctlskb6qIgeIiZqKgIp9q
	ZzBFZXI7PUVKosQO2pBqjDt41GphCxZvii+jcQ39qD3xGcKR6A4yb82yZzTHoVk=
X-Google-Smtp-Source: AGHT+IFEJLDKQIvasbwktl+p1APJkoNpc/JIvg0vdZeN4QiASCSB4/1udJAnaTTmL/by0SQOnnTLqA==
X-Received: by 2002:a0d:e987:0:b0:650:672e:9c64 with SMTP id 00721157ae682-689629826ffmr12200477b3.33.1722539011197;
        Thu, 01 Aug 2024 12:03:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-689b0c71185sm469347b3.61.2024.08.01.12.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:03:30 -0700 (PDT)
Date: Thu, 1 Aug 2024 15:03:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/19] midx: teach `nth_midxed_object_oid()` about
 incremental MIDXs
Message-ID: <ZqvcAQABDIthFUPH@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <ec57ff434900f2b95e31fbdf854b5ebbf46b5c78.1721250704.git.me@ttaylorr.com>
 <20240801093805.GE1159276@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801093805.GE1159276@coredump.intra.peff.net>

On Thu, Aug 01, 2024 at 05:38:05AM -0400, Jeff King wrote:
> To some degree I think the proof will be in the pudding. If you missed
> any helpers, then the end result is going to crash and burn quite badly
> when used with a chained midx, and we'd see it in the test suite. And
> the nice thing is that most of this is abstracted inside these helpers,
> so we know the set of tricky places is generally limited to the helpers,
> and not arbitrary bits of midx code.

I think back in the old days, I might have considered experimenting with
GitHub's fork of Git to build up this feature before sharing it with the
list.

But experience has taught me that it's far better to share early and
often. Doing so gets you the benefit of having many eyes on the feature,
not just from individuals at GitHub.

Selfishly, it also reduces the pain of having to change some on-disk
format that has already been widely rolled out within GitHub's
infrastructure and similar, but the former motivation is much more
compelling.

In terms of "the pudding" here, I think that marking this feature as
experimental / incomplete is a good way for us to push this forward and
build up some real-world experience with brave users via a tagged
version of Git. Then we can refine it until we are confident it has
graduated the "experimental" phase.

Thanks,
Taylor
