Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FDF331EC1
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781878571; cv=none; b=eYfpUybdw/YeEvtg+wrbRQzGYXoP4jLAGmujv83Kqllw2bqhiHzYiXlq8VLNPy365BGGmo4KO6GV6gn8vF1ix/5Hijm4xOxzy2a0m2tdHg68rBZBLjH3yDFLIAer5zTSZoanQGf33Ih2E+snDO3pRofti5HDjf7JZkyfpnrRoMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781878571; c=relaxed/simple;
	bh=Hdn7Y6qhfSVJsQexaXZwNdSNmbP0ieqKl5J8RV4zKMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N36cKJYsmrrpzMo+zz55wYQlkHdZAWVA8Ks4gKl140I4blR9gGBLBdoLbvLfRLvm26nLhObrGckCSHD5Z+fMuDgTi6U5pXTqGdRclOHeyplFF+MIFf/HT8znsKrxFmXsKkwKecWBFfHaEdbMK22fzZyDInAemglDqtGP0zI8Pfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=G+2OcTxj; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="G+2OcTxj"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7fe8bc0a01bso21332947b3.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1781878566; x=1782483366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hdn7Y6qhfSVJsQexaXZwNdSNmbP0ieqKl5J8RV4zKMo=;
        b=G+2OcTxjdprZ7vrm0qAHIt9wbPbsi10Fjhs5Sc7ZmfzRk6eiH5zf2FIKR/tCrqlxg5
         H6CSmrAChI9DhMRpTJWUS/E4Ftjucir3X+/XbC1o/KabrPOsfTPeOjJowt5oZki6WVL4
         RpmVzYAZlct6xzUhgHnLPzaeXH2wZxj+rilxJqLxKkzbZj1M1zEUUD5JdR/0NyybjdXK
         Y/xSD4Q9VJYWxf5bLl8TkWVxFgPmCUoXZor4X5vGMnVFhooGvA+5ApWf8tOUuc87fwVl
         pQgYEJwGfdBtpdSwrCsTLVZMTKGZn0Rsas+ujxPwIEuJ9iSJQEG8pF/mw3plbLqFCySt
         17nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781878566; x=1782483366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hdn7Y6qhfSVJsQexaXZwNdSNmbP0ieqKl5J8RV4zKMo=;
        b=aSeu19zdb2c4Z0mBxs+gNKveGMG/w9WWTAeLIDfZoZtxAicndXJ3+0UmUllSnMZDLV
         6N12KjqGibsjPTwu+bJ8KqJs5jEvlGRg58UKpH/ZmaCB2ZKsCQVdc2VDya9oAV0Qdujy
         vLoOIifNDjHMogznr+ic7IzKRAfI74kQBneWBz9Fo0r2mZOY3fZTfUcxeCAuW6a+NjMt
         sUrmgzXSaX4D7oDbwd6PonHhbcrnELEEvUfDdL+aNV4ddGbXmapDLPOtwUXyKz/QQvhn
         n1Rn+gXNQIyn0o3K/DMu18n4tHKyKSiwh5h2jWigE5pZ/goWMks95vtUKRpg3x+KC8lU
         sTvw==
X-Gm-Message-State: AOJu0Yw0DKdp8iDAxHrIMkd8YmA2N3mHuSONxnLieBkAPlnuL/7O1MPE
	UfimbGN7GamgEAtbem+lL0q+BlgYfdmNw2yKQLLvOWOFJpejlioQC9vl1LaY/d7omhz18N9QfhJ
	U3Oz2Q+o=
X-Gm-Gg: AfdE7cmRYPAILonJeafc9MI3e3wOsuXCSvqfT84a/6ml2aGY7gk4p3ecMPU9ExBToj8
	Of4OQOG5Z3KsX0p1XtjFsw+IUkGFSmRYlBH25p+0kx2BrMLW0pIRoBNbkj/qbdVFNwpqSf4LuQ1
	7D/4bdFsp7D5FKGHgOgf8ecaqFWZXqs3oNUi4rjEuXQnaWzaaZYh0751sARo2mgiqFVyFaHPJuR
	8V7pO8EgctvnejAiBGyYidoU+NTNerh1vUHbvfuZS0mc6XJBIHyM9W3O0wOe79I/HgTCH0K8Ijj
	JpC4A8D3KZfBSrhbkhOWDs+XellVcQ3YNu43tM+A19hcb1lCiYShWymYY9aWGB7MT+3iqQjvLBy
	1RlNi3qMeGOkpbqWus5fG2Rynn5MVuDTvOt7qhT6TiT+u3qAqfMmSN1eNdXCFfUMAm3a6+U0PSn
	hDso0IF+O2uFG2V6kPuib7dNy6exbqiqkwpLJ2XZDqgtCXP3PrGZ/VclagAGJ2oQ3h661dGwP4y
	wLlA1vj/VuRpnLOxwfFK/ByE0PsahAMS0cWEgYxWHlU/AQ+sznQv9bzwgY3nXXD1BBaBnQftiUN
	jiO2qQ==
X-Received: by 2002:a05:690c:4984:b0:7fe:200f:e7e0 with SMTP id 00721157ae682-80138141211mr37290687b3.36.1781878566333;
        Fri, 19 Jun 2026 07:16:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8011d00eba1sm11778557b3.26.2026.06.19.07.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 07:16:05 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:16:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/4] pack-objects: support reachability bitmaps with
 `--path-walk`
Message-ID: <ajVPJGXuhugDcT+A@nand.local>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1780438896.git.me@ttaylorr.com>
 <ffad584a43ebf3cb2138e8dce7daef84ab72712f.1780438896.git.me@ttaylorr.com>
 <6e4a8764-3c56-42c8-a87e-40a94c6c34e9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e4a8764-3c56-42c8-a87e-40a94c6c34e9@gmail.com>

On Fri, Jun 12, 2026 at 09:03:41AM -0400, Derrick Stolee wrote:
> On 6/2/2026 6:21 PM, Taylor Blau wrote:
>
> > As a result, we can see significantly reduced pack sizes from p5311
> > before this commit:
>
> I mentioned this before, but the pack _sizes_ aren't changing in this
> example. We are computing them more quickly, though.

Thanks for pointing this out. The paragraph following the perf output
below correctly explains the results ("We get the same size of output
pack, but [...]"), but this one is obviously wrong.

> Since we are testing --path-walk on both sides, the change across this
> commit is that we are using the bitmaps for the "counting objects" phase
> and then potentially using the --path-walk algorithm to construct the
> packfile.

I'm not sure I agree here. Because we are using bitmaps, we're relying
on pack-reuse to construct the output pack, not --path-walk. I mentioned
in git-pack-objects(1), but the combination of seeing "--path-walk" and
"--use-bitmap-index" together only means that we will use a path-walk
traversal as fallback if we can't get an answer by relying on bitmaps.

> And I wonder if the test setup creates a situation where we are always
> reusing deltas from the underlying packfile, so the --path-walk algorithm
> isn't doing anything to help with delta compression at this point and the
> difference in this patch is that we are replacing the object reachability
> calculation entirely with bitmaps.
>
> I suppose what I'm really worried about is that I'm hoping to see some
> evidence from a large-scale test that demonstrates that the two algorithms
> are working in tandem in a non-trivial way. I haven't seen it yet, but I
> also don't have evidence that they _aren't_ working together.

Your thinking is correct here that the test setup intentionally creates
a situation where we are reusing objects/deltas verbatim from the
bitmapped pack.

I'm not sure what "working in tandem" means here. At read time, the two
options mutually exclude one another, meaning we'll use bitmaps if we
have them, or do a path-walk traversal otherwise (or if the bitmaps we
have are somehow insufficient to perform the traversal).

The goal of this patch is not to demonstrate that the two work together
at the same time, but rather that we can write a pack using --path-walk,
and generate reachability bitmaps simultaneously.

Let me know if you have more thoughts on what "working together in a
non-trivial" way would look like here. If there are ways to improve the
compatibility of these two features in a way that yields better
performance via either smaller packs, faster generation, or both, I'm
all ears :-).

Thanks,
Taylor
