Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F4A1DF254
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778383; cv=none; b=UCPc82t7Hy6pYt7neTPUwn8V5fIKrSzv0a0Xp/rmPnwoIA0pmLp7MzGRBgI2xZrWMaz5YqQeAJyp6/T1Wz+PW5ePfYS8TZwoK/AE5CidkUPHNiB2nxwJm95F5QwUF+hICWsVcY94BrhtpkC3DfBRF4NzS/XMMdIs+lxdk+kp3rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778383; c=relaxed/simple;
	bh=2vJyJ2VHPn9H0xmyimj6+jJaLTaBkqP0MzTMmzR8muY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBnv4qCNhb3CtjM8QHzK1wN9Bn/ccvdt7iNjRr5J8Dz+GeczVl9ABzPxy/kbNmESuA8GaHDq7bu5w+dcF3vABqzfsq9JTlpM7BloZYWdRrSWypmysUtW6dR5qTax2vnvNohQHZ5CjOwDuCOWRpQzfpYaPPDJNKdX2pFSaXWbDFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=IfQLMQqf; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="IfQLMQqf"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8c3414ad279so203787139f.2
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 12:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759778381; x=1760383181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gV9ije84M7D77lqr9JHW+19KqgoDiT7OvbXvXHV3fZg=;
        b=IfQLMQqfv+0u1KR2m+bBgnklV08kVGZ5CvkzuRP+zIKd0VNSk+6w8DwSJm7wfOok+B
         dwSLu6xBqMarVmla/UIIg/FeLeqirwe6bSayrwVVKxmt42vgXT+QuExzNISnh8Du4Fhv
         VhrOC/9z7zn25/T5kHtpuy90C5QEsUy+ZeZV3zFRVnDaxthJeIXWGAa3H3l7NYe+G44L
         uuSEbQOF0utTtD/f/eRggHV6Qbjp4QXsFGeG8ttaiDfqRK5uYI3FkQc1DmcaZ/3GQFJV
         Wsx/JyoWVZ8uWqnyUGkFB33y29bS0e1yMmxSXk4cL+kn2LxOtZkrRi/J/TneAyf1coK5
         bQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778381; x=1760383181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gV9ije84M7D77lqr9JHW+19KqgoDiT7OvbXvXHV3fZg=;
        b=VNwUMEusvFTdzD9Do2P67AxhLQVXlzP2PNqbhvhRL0Z0lYQsSKX2vwtpfMD1UK85BO
         WMVJvM4Trb9dii6UEOnQZBDVSmyTfVwK7FHXlD7FkIgpy4+woHgEVro00roSM2yR34eD
         Z1aTH/SgIZ8OlNg5A4XWRYl3I8Usm2jnrp+iLmiC7vKzcR0zvEulh8AVqBv3zcl/3pn2
         TGlVkFiSxPa19MbV3qhffltd+ozrZzcU9Wllt/2PDbHTYA6mNavh3k3cfSFzfrxyB4MW
         ax7niDqeCrnHsX7xVNiU31J/iGtSXGYZb9oRLeH5tTos2+ihSnf+ZYh+lQKLId8mUeX1
         8HhA==
X-Gm-Message-State: AOJu0Yzn7AhPIekvlHmsHu7Vlsnz5wwJoeMpVlRW78Xo2oWEMIaHWxK9
	hG//IyPzwdKKY1mPS2gEmDNrQuQH3tKMcmSe+j0+r4OjngaXv6zZ9SgSXzNb9EfsZ5GgJMzkE4V
	r9cr/rWEaNw==
X-Gm-Gg: ASbGncsa8/Tm9G1wxe0jBpN7Y7M7ZkvM/RkQrLbknG/HWC7VwP7fqzqQSN7QQNU58vo
	UNLUt/+qHErFt7gtJD+d6dVNrA7MIwykcVwrkh0++/8yS2DDgojKbz5G2EpzgUXOvz/qfpEpCh2
	WLpK6g9sB7P3YzZhvcI6vO2CM6dxG3gKO5j706Bg5bwjJoOZUX9nIZ/uqWd1ffuB9PXtlQy3Bb4
	4GhHgp/j8GtZE5QhSowRQWYC3KPZYvJkwGhbNZLhSophSbmiCdafuYbZy6B/UKOQWuYb8VJM28h
	lmxnotlleQE5o74SE2a5x1+HuNxDyCNf/ZFO279ZvXh7utKE/vurh0AHBzn20oxefSUlFJXlkC+
	MraQb7JyCMnJOl6pcyP6+TBTRnjWvbz4PJEXV/DLiLEluOnLJj/rroNTIzoRfn6PkXu/lww68it
	Q2oEpAKaksk+YMTxOyVLSHcPZPFkATEU++lPDEOAHvEzxvoAaD0Q==
X-Google-Smtp-Source: AGHT+IEg00B/vlf/8/fBuB2w4eRZ/KfhDAo6g79WVPTvzr78Cu25vt3t2q5a1F9NXmLqGkNPDgqh6g==
X-Received: by 2002:a05:6602:4148:b0:917:1d3a:d29b with SMTP id ca18e2360f4ac-93b96acf46emr1773337239f.19.1759778380692;
        Mon, 06 Oct 2025 12:19:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-57b5ea31448sm5262377173.29.2025.10.06.12.19.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:19:40 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:19:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [NOTES 06/11] Repository maintenance long-term goals
Message-ID: <aOQWS+ZJdXr73PE0@nand.local>
References: <aOQVeVYY6zadPjln@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOQVeVYY6zadPjln@nand.local>

Topic: Repository maintenance long-term goals
Leader: Taylor Blau

* Taylor's talk was limited towards the end. Could expand on that future work.
* Constant repacking into a single pack was historically the major problem.
* Doing that less (because of geometric repacking) helps, but it's still a
	potential issue when it does occur. Gets them 98% of the way.
* Future items were geometric reachability, ?, best effort gc
* Previously during geometric, used to accumulate loose objects too. 6 months
	ago they changed to an approach where the big cruft pack could be excluded
	from the midx.
* Challenge would be to do a full complete repack without rewriting all of the
	midx chain.
* Because bitmap is tied to object order in a pack, need something like
	tombstones to not break the bitmaps. Need the tombstone to know that we don't
	have the data.

* Unitary midx idea - Taylor designed the chained midx before he figured out the
	repacking strategy. MIDX and pack index duplicate the data. No reason to
	de-dup other than for space saving. Could even skip having idx, but plenty of
	old git versions can't read midx.
* brian - there may be other implementations, such as git lfs, that don't use
	midx and object id mappings in pack idx v3 aren't supported in midx either.

* Nothing preventing you from having two parallel repacks, one that's geometric
	and one that's trying to do an all-into-one.
