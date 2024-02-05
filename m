Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C08E1C6B0
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172757; cv=none; b=gVeBcY5TZWURCPZ4xg+74387vDy8FSGh4reI7/UOrn+HBCIWKQU8jPm1iAVCMmDTXwjypLAJsvS1MCbqNrNEOyF/7TUK8htVFAn9Bbeppk8jANkTv8D104QjmB5FFBfHGWvK0IQIu9QLWyj/9jKPkrg859aP903Nj9TdlXfYo3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172757; c=relaxed/simple;
	bh=FOXFwLme7MaLG3kSeYJc4Js659VDWlSofOrE05fAqN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwtPH/6APpd1Pdq4CkWOf0zCyqmwV3O1+dj/0b3RG6qZjyjDCw790JzSJ/o45iX6XoH+nNPOwTjyoL1vO2u4sESmFHcRWOOYndJbDlYfbpjQsfL9REcIq4epcD3dU1a6YnJimSNIGcZ65W0hPq2FBHYXS+l+o3SIUM7kyv7pRP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mx5BODal; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mx5BODal"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68c814135a9so18854746d6.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 14:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1707172754; x=1707777554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RHlYC0s7Pi/al0qRXZwDW3NIybGC9q9jVqzevhJWnLU=;
        b=mx5BODalvz3KXS0xotRL/0UfjvPoSo15SD+ZZR9yooJ5hltHeEatgxYsw8HcYmdHXZ
         WZfHzjUIYZ8VmEJ5MM82ykMep/2iaWjuNuFk9bxZtLYV9/z+efQT1vR9KW6c2ASUCLTq
         OsKHX/0fSNvhlTibCqqIj8n8lP3j6/RycxEkawMbAdFxvVB/eE1tm/eMoNsMfqfPc5F8
         omPU/C4Aeu3NLN8Kweo4LXAomVYOHnWFCXr1ALq31VGYMO4XQ53dcbcwZI+b4Vl0dSTO
         odE3lYpVMEqwVW4UK7lcaoX2YYXml6IPqk/36rXK7JZqka7XuR9CMttxuRbMuN33P5dH
         6s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172754; x=1707777554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHlYC0s7Pi/al0qRXZwDW3NIybGC9q9jVqzevhJWnLU=;
        b=aFrfYkwdOopA/oVESfYrMh/8zOZ/qzolNYGmvsNugIsFuTb1I+/KaqiVv8Qdw7PupD
         mzGrG/9ujf6ssjJjvnsy9Iu+AmNGkQ0joBK4J8Nd4MySzP2fyA/VACsz0WZecroeLFaC
         Wuf5JXAawt7VJWiYsvtCzOxDvM0c1eBH0YGlqf1xFO5VoAwz7J5Muh77BFJLII+aJOaq
         bLIhjkY6AFlSuG4kXFKQXCJqzzT1nu61jA76d80bNUhmFcxz6MWS9F8vj0Iv5KlqV3QL
         qEVEU7mTchxXN8vu8KfEOo3iCIaizpIPpGrQu/awhZ8fAFO4nspMRHyTPzHlE/Z04+z8
         dY9Q==
X-Gm-Message-State: AOJu0Yzf6VoTb4EMf65A6GxxynLH76g0NaJI8T5zlmeXLhOi29CYd3Kq
	oxwlhIcBFBv79z1OqHfeoUqjQdpy2TuTibakoQ2jnsz4sx23hfb7QY24XrCvl+E=
X-Google-Smtp-Source: AGHT+IG+Zzmj0EulS8PueYcJTsq8cl6kdzPmdiT2x6eao/LrdSOGNA6hao2enBI735ku/an/05mxJg==
X-Received: by 2002:a05:6214:300e:b0:686:9f2e:d984 with SMTP id ke14-20020a056214300e00b006869f2ed984mr442511qvb.22.1707172754342;
        Mon, 05 Feb 2024 14:39:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXEkPcuOjXGm6v2CoOq4yQa1NuJiByfR/HPCE8QiUYXypqYDacz0XbCquYX3pZR/6Paam1uFjef2n9dus2sM2cfKnUeJw==
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id me15-20020a0562145d0f00b0067cd5c86936sm411825qvb.79.2024.02.05.14.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:39:14 -0800 (PST)
Date: Mon, 5 Feb 2024 17:39:13 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2024, #02; Fri, 2)
Message-ID: <ZcFjkfbsBfk7JQIH@nand.local>
References: <xmqqmssirm6t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmssirm6t.fsf@gitster.g>

On Sat, Feb 03, 2024 at 12:23:06AM -0800, Junio C Hamano wrote:
> * tb/pair-chunk-expect (2023-11-10) 8 commits
>  - midx: read `OOFF` chunk with `pair_chunk_expect()`
>  - midx: read `OIDL` chunk with `pair_chunk_expect()`
>  - commit-graph: read `BIDX` chunk with `pair_chunk_expect()`
>  - commit-graph: read `GDAT` chunk with `pair_chunk_expect()`
>  - commit-graph: read `CDAT` chunk with `pair_chunk_expect()`
>  - commit-graph: read `OIDL` chunk with `pair_chunk_expect()`
>  - chunk-format: introduce `pair_chunk_expect()` helper
>  - Merge branch 'jk/chunk-bounds-more' into HEAD
>
>  Further code clean-up.
>
>  Needs review.
>  source: <cover.1699569246.git.me@ttaylorr.com>

Let's drop this one. It's been sitting on my backlog for almost four
months, and I don't think it's going to be a priority for me to finish
in the near future.

After spending some time offline thinking about it, I'm not convinced
that it substantially hardens the chunk-format code anyway, so I'd
probably just as soon drop it from your queue.

>
> * tb/path-filter-fix (2024-01-31) 16 commits
>  - bloom: introduce `deinit_bloom_filters()`
>  - commit-graph: reuse existing Bloom filters where possible
>  - object.h: fix mis-aligned flag bits table
>  - commit-graph: new Bloom filter version that fixes murmur3
>  - commit-graph: unconditionally load Bloom filters
>  - bloom: prepare to discard incompatible Bloom filters
>  - bloom: annotate filters with hash version
>  - repo-settings: introduce commitgraph.changedPathsVersion
>  - t4216: test changed path filters with high bit paths
>  - t/helper/test-read-graph: implement `bloom-filters` mode
>  - bloom.h: make `load_bloom_filter_from_graph()` public
>  - t/helper/test-read-graph.c: extract `dump_graph_info()`
>  - gitformat-commit-graph: describe version 2 of BDAT
>  - commit-graph: ensure Bloom filters are read with consistent settings
>  - revision.c: consult Bloom filters for root commits
>  - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
>
>  The Bloom filter used for path limited history traversal was broken
>  on systems whose "char" is unsigned; update the implementation and
>  bump the format version to 2.
>  source: <cover.1706741516.git.me@ttaylorr.com>

This version should be ready, but given how egregious the mistake I made
in the last round was, I'd love to SZEDER to take a look before I
recommend merging it down.

Thanks,
Taylor
