Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199F204F63
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251188; cv=none; b=nvRLRDwtft3gI1MGdXF0T/0R1G7SACyF00yoXe3xBb5tIMW3nH+vOkd0YtbKvI2y1GiKwqmIL1PxkJpurIIa+wSUY5DRUdeFM+d2SfY+e03WyGmeJFUA3Pe7BR+JlABv/km4fIlL2SuezIQ6NkcQ9kZXcULCG6sGavwQipmHTiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251188; c=relaxed/simple;
	bh=dXLKbCoad2VToh121fyPV6oAWttBCjZ6eMXYBN+w6Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q93Wllh98SEfSBMREV4w+2gHLPQkl9m/BM7CwAJjquOMbo5drkz4AB4RskoF5HZ2rm6BN7HOrdsCYzsRvLrNyh3OIqJmBFXAa5wsDwXwdvDqdddDNH6KR3atUU2jrkme4OAstenrJYgY3nVJGeO0Ku/rv7TF7O6J6JiJd1qBYZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=zqtg2VkP; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="zqtg2VkP"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c59e7039eeso7764185a.2
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 15:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742251186; x=1742855986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tjlfbmMbyHZ4ry2yURrNWoTbQm/eI4EE+2pZKDq/VQ4=;
        b=zqtg2VkPgWw0p+29S1RCnp0UEAk8FeAWzIvIO90Y/2L0WjGD5MQo+7o23JqiJ8XDnr
         H20C1Q0FaWucFP582LKVezGLpzqz1sk0zH8zIEckZUHkzvSOWpp6PAaBkNe28ZrijmcY
         PFT2oSxHf7u4Cf5K+oOUJgD/x0s7XOOx8vlsPdiRAI78sCH87E222vDIfUddvqqd3wTm
         5CZM7jzXZ/R/wp/JGajoemABhNjq6ys/LfLDKwl9oJ8tTdKzNfJ440IOUIbBVBc8OG7G
         rKqwyPuhZGvX7bFEGCU7cTc8J9jZ0S01hZHfHMDaMPLcScoxP2Bgaj6oGdSZFi8JEScP
         JjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742251186; x=1742855986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjlfbmMbyHZ4ry2yURrNWoTbQm/eI4EE+2pZKDq/VQ4=;
        b=ebS3Fy4QgxrwpQO7B1yl3iyjW4URmfvv0gBbWaNAaNkI4N4icMFDWNV1dr3Cu4cQkK
         N9TgEiXcz7f/fIUtzwakJg1audDI02V4sLO9FJ8E5UXrkQ/hTrJD2/3h1BdeicO2zF02
         S9ICwIVZT29cmX4RWoyHRE4H9XBI0JCziDf297If6QIuTGk/ZBFCWlosedTrR/KAUVYG
         sI0vYm5IMrCvSv6hFvPLTRlhchW2R63A/D4TXlezuN2crKPb+/ByyN4/T+AbpcQVbxzN
         8QJ4v4P3eJjANgzcCw8xgalGmkZr9bhpHk+T34w5z7Wn4zkUPTfPGJk/zof+Rnsv3JZI
         BhtA==
X-Gm-Message-State: AOJu0Ywh90XqomkZtwLlCz1+tYsGGlWB/HhdSioPggam3C4RBH++waj9
	EA29DSRY/UocrNsEj9eRNLVC3lhzZIy442iWc9xlrDE0NuBYOzsO8wxky8+MPJw=
X-Gm-Gg: ASbGncslFc1MEKuV3i1hj7tbwZJlyzV811UBQFfzHbvlG+rk2f83b4uIn9DoehMaJPK
	JDOi5d1zFPCaR2K2hNjpoXegMK+M361eoYd4j66H4J/BwhbrYKsEf5jOuITQntI7pjdX8+K/eLj
	e4Bi1shKwwp5RMn0+E9BRPHYHMXxjlfbjny5X/AObY4ZH0mXCyQLXhxgL2erfACi16odwupkVbZ
	fd/GLhmVdohUeQ/E7SAM5jvk9rxYhxNH4DmgVWbZV1oj3aduGI6bVFSkTckDDOhUfUw72wQqOtD
	9KkRReE+8tHWXZvO4mUyXBA+/oF12e2KslHlL6pkAk0IQuuB3qSmn+hevrSFbqu1IVluspYqRpk
	CHeEojccOUwXmMhfd
X-Google-Smtp-Source: AGHT+IFXMInpd2TOGYBGW96X6oKt7Cd6hGmtmhtVmLKwbADxzKYbcUqhdaI0fHXi2DJhWYVSUUQW7A==
X-Received: by 2002:a05:620a:2787:b0:7c5:431f:f5eb with SMTP id af79cd13be357-7c57c7d6ccamr1927332585a.20.1742251185825;
        Mon, 17 Mar 2025 15:39:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d6fc89sm638464985a.87.2025.03.17.15.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:39:45 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:39:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2025, #03; Wed, 12)
Message-ID: <Z9iksBa4g2bUkX1u@nand.local>
References: <xmqqh63xx23f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh63xx23f.fsf@gitster.g>

On Wed, Mar 12, 2025 at 04:26:28PM -0700, Junio C Hamano wrote:
> * tb/multi-cruft-pack-refresh-fix (2025-03-11) 6 commits
>  - builtin/pack-objects.c: freshen objects from existing cruft packs
>  - builtin/repack.c: simplify cruft pack aggregation
>  - pack-objects: generate cruft packs at most one object over threshold
>  - t/lib-cruft.sh: extract some cruft-related helpers
>  - t7704-repack-cruft.sh: consolidate `write_blob()`
>  - t/t5329-pack-objects-cruft.sh: evict 'repack'-related tests
>
>  Certain "cruft" objects would have never been refreshed when there
>  are multiple cruft packs in the repository, which has been
>  corrected.
>  source: <cover.1741648467.git.me@ttaylorr.com>

This one can be replaced with "v5" of this topic, which only fixes the
freshening bug, and punts on the --max-pack-size versus
--combine-cruft-below-size debacle.

I'll send a separate series to address the latter shortly.

> * tb/incremental-midx-part-2 (2024-11-20) 15 commits
>  - midx: implement writing incremental MIDX bitmaps
>  - pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
>  - pack-bitmap.c: keep track of each layer's type bitmaps
>  - ewah: implement `struct ewah_or_iterator`
>  - pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
>  - pack-bitmap.c: compute disk-usage with incremental MIDXs
>  - pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
>  - pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
>  - pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
>  - pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
>  - pack-bitmap.c: open and store incremental bitmap layers
>  - pack-revindex: prepare for incremental MIDX bitmaps
>  - Documentation: describe incremental MIDX bitmaps
>  - Merge branch 'tb/pseudo-merge-bitmap-fixes' into tb/incremental-midx-part-2
>  - Merge branch 'tb/incremental-midx-part-1' into tb/incremental-midx-part-2
>
>  Incrementally updating multi-pack index files.
>
>  Expecting a (hopefully minor and final) reroll.
>  cf. <Z8JSreTnEFlocYQ9@nand.local> <Z8JLbxBQh7XUpplz@nand.local>
>  source: <cover.1732054032.git.me@ttaylorr.com>

Thanks. This is rerolled, but it would be good to get some review from
others that are familiar with bitmaps before merging. It's not a very
long series by lines of code, but it is rather subtle, so the more
careful reviews it gets the better.

Thanks,
Taylor
