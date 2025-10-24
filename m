Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407EF73451
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 00:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264237; cv=none; b=tZXTAfH8/RcqGY4T3bVWRatN4bZ9LBR584+gjZ9zAguWznEyt5YiToYd832jGNGPsZpTv7UKBbmwNABzSieyEqEbqZeEcjygJPPuxdDNJ5M/H1+rSl89l0OzcG1azsviwtEuszaAPr7Yf0p1HkQnG/mShRRVjCachwrIeV/tnIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264237; c=relaxed/simple;
	bh=NLNzbfqER1yKoSaGBdfhLfLFAzYX34dtvTY+UfknU2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYEJNaKUFlsR4OoL0lyckYHx8yDBz18TJXWa+DaayD4rbxwzjjPrlO1FZY+1eLtvfxlf0bVbH6aVhCoL1twOCWd+uTT4VGrmePUeiknNum4AlZbOscJ3l4cT9PZJ+UKh0GvoIXZ2TMa5b3iBW5A4N/b81d3dDApiKJ+75kIa1RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=L+qKMhRR; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="L+qKMhRR"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-781014f4e12so17427117b3.1
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 17:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761264235; x=1761869035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/kNrUdYbzHlCz651/QAksR1PrE+VUUOQF9JtgLy/88=;
        b=L+qKMhRRMXffqAktnK21rx7OY1nRk/HDPzf7Td790FOqfVh2GPDSx1iYEn2jaD03G2
         Ny6NjQdIXvC3nUepK4ePlPRgkC6Y/TJyNM4JvbuTO2dTGFgEdqTC9+kK30e4OZu5/m1I
         6zTuf2xRAIJO1ilpz6FPoyFr/T5PnzZxSrHXmbnmHvqNyXmVYwNnxIW0Fz80SVhLONoi
         YU8a3ZrUYYElYOcAuCeM0cBhJFdCLxhnNIKW3Ga5EF7qF6ufCVay8Foj99xTYs0tVbfh
         I+qCfVRnzUccHhuCXCIUAMGNaVeysqOji1nRCWqGXOXyXM2dkI9U8C6qbq2fVf85NuQ5
         rl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761264235; x=1761869035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/kNrUdYbzHlCz651/QAksR1PrE+VUUOQF9JtgLy/88=;
        b=e0BPDlIx/P6wGzM4zVvqjGz4ehOITt+L5hlkOxeiDDID5spubFKaW0enY956Co2y+3
         QgPryWITNK1eBNOqBRPeyqthyiZtrz2m5ximd4BGo3JPgNQ2Yi3znnprhB5H5DmPhhgv
         FJaBzzEnJ8DVVR+pXaA0jwQ4/sqlRVhh9u8f8ytNfFX42m9iqpM1dA0Z0UzY0WE6M6LP
         Uryv7o6K9137h1wzpJwAOPA0jl9Y2fiS8SptsdFqGLzZlG+YXVpMbbZ03brItukxWdlS
         e29hT/cxkwOUOBL57WAf7u6uIo8k/urm7L4p3vQ7p6nklEeOnOJRFg5fEZz44pWLRszz
         Uc8A==
X-Gm-Message-State: AOJu0YwRqPbD5OdAI/DX0ZZzqtfJ8dRiZEuY0fzS0zV1d9lU/zFCWQc5
	9Ffg1zj3ep/bw2yW5GLzkfBHY6io1Rz5K4eVTWeCTLhuRRx1Gu7IiRAlRV3QdRSqFTU=
X-Gm-Gg: ASbGncsl9QCjXi+vK6Fd0ZUTS3TMMmR0+MvErpaK+P3tbgAAP7p8dpNWTSJW3DMEoqR
	t22ZsuR91sJyt+0Ns9lzzm1AIQ22fU8HyWcHHvJimoL5J54y7dheVpiRBWR11heIoiW+SkJMcIs
	tjzkjucMPo2gerymYp+j9C6WnhB2zzu7EsprOHbA8mb/5UGHIPsNngTE3K8Vf/J0qZdDvcAgafP
	dBJS4/rZ05bEgZiUNXYK+VUr+pgcVuQWdtbcztAE/EYplKgmB0magUhcHI/ouX0HV16L2wbDca8
	KXXLoPnkKkicKDWnUSljgL2ACGbu80hLR+cbBNh+1gb6ksJ4Iyi9ruZ68jYSveLkOocqwXuiUnM
	PPUo4r/BJazbeYgibiIBBjAPSqRBioOw923NXdTVO5c4Vd9NgB2b2uZNvKuNIMkZ8k7W8KL4UrI
	jFH1FqvE6WC7faBButfRftKFg2MhGQLBz5/9yqcEwfQDX3UVXv2kQFPdr3by3XYvqDD8/nCJ0l8
	64HnRE=
X-Google-Smtp-Source: AGHT+IElC623/pMG1MlNMVncGGpfkt4MPkLAlOErxGVC7mAQbARkUgpiPBFpH251phS0xJuiQhzoNA==
X-Received: by 2002:a05:690c:6811:b0:784:8b82:98d2 with SMTP id 00721157ae682-7848b829c9emr149445417b3.70.1761264234994;
        Thu, 23 Oct 2025 17:03:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-785cd6cc5cbsm9510987b3.38.2025.10.23.17.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 17:03:54 -0700 (PDT)
Date: Thu, 23 Oct 2025 20:03:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] last-modified: implement faster algorithm
Message-ID: <aPrCaSOA/dclWye5@nand.local>
References: <20251021-b4-toon-last-modified-faster-v2-1-f6dcbc26fc5c@iotcl.com>
 <20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com>

On Thu, Oct 23, 2025 at 09:50:14AM +0200, Toon Claes wrote:
> ---
>  builtin/last-modified.c  | 250 ++++++++++++++++++++++++++++++++++++++++++++---
>  object.h                 |   1 +
>  t/t8020-last-modified.sh |   2 +-
>  3 files changed, 237 insertions(+), 16 deletions(-)

This version looks good to me, thanks for porting it forward and
cleaning it up, so it has my

    Acked-by: Taylor Blau <me@ttaylorr.com>

As an aside, do you plan on upstreaming the blame-tree cache, (which I
imagine would get renamed to last-modified cache)? Just curious.

Thanks,
Taylor
