Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E35280331
	for <git@vger.kernel.org>; Fri, 22 May 2026 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489616; cv=none; b=YJwA0aTbqLkA1KA2HOIiK9eOSRa4cn2+Q6K70xziwt11ZXl5YQsbThjMAbnmOuQoVeKNyDD4jDk0frNWRqgtvqCL3YTzc3h1uEIS0haRXQ1PsOvoXFMehxRis8tRsD/gA9wwzr9pgpGECYNd2alT/SHxJXpV9qOOEXRCuLGNZIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489616; c=relaxed/simple;
	bh=duvzmIT6zaxS22luk3gdVqimnLk+7jmEsfgJHFsrlB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1a5yncMWmlO7vCtZnGvw4H38fIwdTQPWKIKaWPPoB5KP3s7in9ZxAJ/4Ez0Os7bX8l81FvmIuSQ+rrUFH/pP5sH6CmfPfMiiw4w8TCFF8GYS15NkrVSs0WXAj0kHrYM2NY7ZahxFLK/ecaaDv1TZlPciYYTjimkahV2i8a05bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=XxmIw98I; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="XxmIw98I"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65c21049dafso7136028d50.2
        for <git@vger.kernel.org>; Fri, 22 May 2026 15:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779489613; x=1780094413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDp58pAau1ND334ABwFMvdvVI6OZS/G3URDTcxV/dns=;
        b=XxmIw98I7oRl6q+2WEXcZ+RUsB/rS9VcDcXo7xmTWe/w9Tjl3bKFbVBonnoYp2NUm2
         rI6EDwLi0Q9yen8FOgzlrGFJjzwK5kfecwAk5mbhOIcbVVioSfe+143bKn35T17Bx4iz
         IOfPeG/8gxaV3KzIbRvBF0mBaGDw/72PDn+yGbhXKPqZEaZleWc2vpETd0kORhcp2FMS
         ODF808a43Lzx09JVDuOBiO6Z5b7LTcwsuIUPW8QCEBy3hzBlnLGu1YT/4Qn80pH5kB1X
         KGm96anuKxv42IBvs07z7hZZj8gn17wZ6GnEWKuJtdyG9B11ODXn1AQb2EM37DqEwCUe
         dVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489613; x=1780094413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDp58pAau1ND334ABwFMvdvVI6OZS/G3URDTcxV/dns=;
        b=rMaXlL56AXgUheWzfT73IED+iJU4tzX3orU+4odVIgQ+l9YYLmR9NzfwhsP49vvIYR
         MrhsJUnZJqHRPXkX0eW+/4Q+HVuxqNr/mZoy08fIi7IqS/7tlTdAiFfJZLVz7Dls5hwq
         DRQxvRcKvtznH3u9p5AqKlXprZwB37htuMG8L+4DbKL9rpqbaqfLjXk1EETM9fvQax3H
         LMr8XtlsxZCKjeD/ONeUKrOXFC4/kT5JfoLqs9+9YOmzrggbBbVx1zNvz9864SaXJHMM
         3CRRVlRwFhG7d92rhR+xVe4ZZ/4VprXRctyoEGOjJirCW/c9bt1r1BCy2Q0khsed/Mvi
         j2Sw==
X-Gm-Message-State: AOJu0Yx8MOELNZYkNuO+ARknpdFeuReg7w0z3rm1hshmhzputb8Jq6uO
	yJz04BKoCQ9xHPdkaWilANigfj40igi11xu0VI3FVKJ+edQ0moBFUcFJBUUkAAvQ1Us=
X-Gm-Gg: Acq92OFXR/8VFaQJI70OzR/6wYLZPDwNuMehRdjq7Lm4J4/Zo3wFA8gDBpuX+7+J55L
	KcjFQA7qvvSiDnwCYN4phXjJYl0Lo3O20/9saYQfJ0IJYaSoW5VL9SbKRO+bWJs6HGllJyRNpjc
	bQuHgbp0eOifUtwJdmBUSXSTbiy1UJ4GK+urG/wHcXw2rpw1I2SpE0Ksf7qYa9VqLdFB3USJUGR
	nEG9NHe1Jt03T5MZZltuhegERsSxihTnzqHRtCAcb4pub2FmmBjuhNbCVxnKwxO0vo/EZP9da4f
	MsYvfspfCHxqt6Q30om5sazXDbhLSPsOyiGiNrv03micq/NJzMPwsNdhq5F2gci7oq2LIIHy4hR
	a2Ey720wl133jF/J9ISMVE8GgphL2Fw9FbUbfkaRQWk9Kho4kLz9gkFd4qJLFlaZKP/ieCiSUDO
	0VLwN07kxBIApyjWkOd6iMVgz50aJRHr3rk4Tj9rqtuk98/L1WZAEWuTUlNuCzdrcMVZJUowMYN
	0qOW1UmEroZuagxYq+UNbu9CKsOxdMiSugZntZeG3r6wcKaDZl+L35DbO8E5ckeF3xKNJbWzYXw
	bq+i9PZo/cyexK6x
X-Received: by 2002:a53:acd0:0:10b0:65e:18a4:3021 with SMTP id 956f58d0204a3-65ec992ca26mr4673177d50.52.1779489613625;
        Fri, 22 May 2026 15:40:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38be2dc91sm14076927b3.23.2026.05.22.15.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 15:40:13 -0700 (PDT)
Date: Fri, 22 May 2026 18:40:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com,
	newren@gmail.com, peff@peff.net, ps@pks.im,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5 00/13] pack-objects: integrate --path-walk and some
 --filter options
Message-ID: <ahDbS+CtwsGx62Q3@nand.local>
References: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
 <pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>

On Fri, May 22, 2026 at 06:24:24PM +0000, Derrick Stolee via GitGitGadget wrote:
> Range-diff vs v4:
>
>   1:  0840110116 =  1:  0840110116 t5620: make test work with path-walk var
>   2:  d7c87545f3 =  2:  d7c87545f3 pack-objects: pass --objects with --path-walk
>   3:  fb8a0f9c43 !  3:  697ef716d2 t/perf: add pack-objects filter and path-walk benchmark
>      @@ t/perf/p5315-pack-objects-filter.sh (new)
>       +		awk "{print \$4;}" >top-dirs &&
>       +	top_nr=$(wc -l <top-dirs) &&
>       +
>      -+	>depth2-dirs &&
>       +	while read tdir
>       +	do
>      -+		git ls-tree -d --name-only "HEAD:$tdir" 2>/dev/null || return 1
>      -+	done <top-dirs >depth2-dirs.raw &&
>      -+	sed "s|^|$tdir/|" <depth2-dirs.raw >depth2-dirs &&
>      ++		git ls-tree -d --format="$tdir/%(path)" "HEAD:$tdir" || return 1
>      ++	done <top-dirs >depth2-dirs &&
>       +
>       +	d2_nr=$(wc -l <depth2-dirs) &&
>       +
>   4:  e77c8a6bbc =  4:  91845bcef0 path-walk: always emit directly-requested objects
>   5:  f4904f81e0 =  5:  fdb9361198 path-walk: support blobless filter
>   6:  f37467e46f =  6:  89726faf7e backfill: die on incompatible filter options
>   7:  133c1b156c =  7:  3884d4737f path-walk: support blob size limit filter
>   8:  0f517be8e3 =  8:  31b4ef0fa1 path-walk: add pl_sparse_trees to control tree pruning
>   9:  b4dc09ab69 =  9:  7d8f0aa036 pack-objects: support sparse:oid filter with path-walk
>  10:  0b1eed0790 = 10:  a68676d0de t6601: tag otherwise-unreachable trees
>  11:  b23244c4c2 = 11:  b0db73c6cc path-walk: support `tree:0` filter
>  12:  7e1e503361 = 12:  6845988f50 path-walk: support `object:type` filter
>  13:  a615b1a707 = 13:  d33d899251 path-walk: support `combine` filter

The range-diff looks good to me. Thanks!

Thanks,
Taylor
