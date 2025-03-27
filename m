Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3CD1C5F32
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743112703; cv=none; b=ZR5k4jwNoNu9GebZr5e/6lvd5PX2YHaIGQGLeDDQAi1FRwxFtZv2r19LcrfuEK/mlZ3St/6GDVq1hncM3+z/0Yw3UHEz2rkULfvRWtT1Pioe+gP74ak8fVyTKhWscetGsMQYZk5FzonlxN72UQmBDNMw4UQvtsPDEw3yQfS2EIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743112703; c=relaxed/simple;
	bh=ZKXRv4dKtANy82nkptnSpoYK3pRCrvCcMw+c5zck86w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8IS8jEpkJsEU4Lb5YJoqM13QdzyQUL6LfvvfOlByaLtfiTyW45zHp36WtONpnZQlWtYwnpLq4HdUyvmDVtfd9LBVdyipUWZNYakzXdKEV/OuqdNdoQwIzzeb1++pN65yrFhFsGcdik2JQ8+4mVB/AHT+w3nFT4z3APL0P5WMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pIXd/E2L; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pIXd/E2L"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47686580529so15181311cf.2
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 14:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1743112701; x=1743717501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKXRv4dKtANy82nkptnSpoYK3pRCrvCcMw+c5zck86w=;
        b=pIXd/E2LCpRfDJkmzNGipRu/lT7jEKRtKcw5nDIxWyeifMfOy1jVA0wFPfzpFfcoYJ
         yUQZgYYOx9gqJ4Ya88tAV9+Bh6qTexffE3dzrrBpmQwoMPXu6kVnzqExy5p+6HgPg+8D
         Q/0FmdLqIumYj8pI68qqMxjkGY0R/HEBflQ1Tlyi++0jTOYJ0iGxnmtnHp14R/0yURYj
         jALBVkYHwbuWfLxmKRs8wMhbeb/snJYuwiVeka6bvqMqVcKcHVKipNENJ2u+1TFJ15Pk
         kGncOulXEVtBZ5ZYHurH01wrU/eO8VuVlfN9o7JYc6K54u0vCM7XGAuHmZKsCJY40yZX
         8lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743112701; x=1743717501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKXRv4dKtANy82nkptnSpoYK3pRCrvCcMw+c5zck86w=;
        b=Q7BhGpehK8Pf0WhtnmCFohXwJ3IGugClbLbu7ETELy6t38jEpgKIYJ7nhCaPDiHAjy
         vimyKCxRCLY+OL89VDJinQcfZEy2hUfiaI5XszBqQzlaM4M5vZm+keV2MYkBts2q5GDI
         yWQtUYX13LjmrKyvkgrnvsoFxPK+cY0A9ibYTLQp2ySQUk2QI7s5l6mbFYUf/bmYkEUG
         hXKJwpti5RuTFIahg8/BP44dBZK9Z6eagOTUZIKcEl0EBfdM9dkIqEVHtWQhh+2ZkgZO
         UWJrHcSWmQFl/kDOdTQ6DudM8eluniUW4jj7GQ0zWdfMzdZnq+p0a2SXKGZ6RUV20y3/
         rm2A==
X-Forwarded-Encrypted: i=1; AJvYcCUsmJSnshnVWXmrVIp89eSB9W3YPa/KI8FN7lyUTuRMXxUiQCRyag0bwJ/uzcL9VXawLoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy5bgtqxHSj3aZB0C9H3zFeiW/KjcjXetMxU5oI0/BOm2icUKl
	bTmV+TtdSv2gAHiCMN7MtA/v8lduKGSlC+CPZvIvEiuicKut9zBUwiqeBFTVyCU=
X-Gm-Gg: ASbGncslnBlYSlIV21jVXK6TNoVH2ESBrL97cHFCjqo7HrK5ogOpPMISriU30X6h3im
	Z9nkhR9MyViA0Uv+LlsV2iKROneryBEgS1UTqbH8qjllLcc3Tkx9EBPYdWIETYmbyzwHVwb8wc8
	QK6CYWxvvGeVfP00uxGeh1xZaFs9feDaZkHhixuT7IEfI3mxEjjSX6y5goh5JOHzirGooxOpNEZ
	PuIybBzHFtGufj98R+IcrGcycvrCPPmwSaXAOpSXMYQTa7Z7+M+o3hHVx80S0QFnL3ZNXlMtuD8
	rIJ1H9XCu2ExByKgNuyuENeRQaNlYDYLKV4RXznB2A1L2i/4nfjnf2gMRUmW+naOda/2tf9VmSd
	CsFA0krA8q5rpPdAv
X-Google-Smtp-Source: AGHT+IGlyXjcoMeordYQniM41qJCvam7KVHh9JnnhVCgQ7ru3i8dAVtjSDUnKnM8tRlhMPUbBJ9O/Q==
X-Received: by 2002:a05:622a:5a11:b0:474:f074:e85e with SMTP id d75a77b69052e-4776e2165d2mr94481941cf.41.1743112700711;
        Thu, 27 Mar 2025 14:58:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47782a7fac0sm2625841cf.38.2025.03.27.14.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 14:58:20 -0700 (PDT)
Date: Thu, 27 Mar 2025 17:58:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/8] Introduce git-blame-tree(1) command
Message-ID: <Z+XJ+1L3PnC9Dyba@nand.local>
References: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
 <Z+Rl43VR3ErE0Bu4@nand.local>
 <20250327063243.GB3042475@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327063243.GB3042475@coredump.intra.peff.net>

On Thu, Mar 27, 2025 at 02:32:43AM -0400, Jeff King wrote:
> The pathspec-trie stuff is, I think, still a reasonable idea for general
> use. But IIRC, the rewritten blame-tree you guys worked on does not
> benefit from it, because it ditches pathspecs entirely (both because
> they're too slow without the tries, but also because it's important to
> continually narrow the pathspec while traversing). That trie code was
> never run in production, I think (and I see there is a patch to narrow
> the pathspec while traversing; I suspect that likewise was never used).

Yeah, the rewritten blame-tree code uses changed-path Bloom filters to
narrow the set of revisions that we need to actually compute tree-diffs
for.

The general idea is that we have a set of paths that we have yet to
blame, and those are the "interesting" ones. IOW, if a changed-path
Bloom filter tells us that we are at some revision where there is maybe
a change to one or more unblamed paths, we need to compute a tree-diff.
But if the Bloom filter says "no", then we can skip the tree-diff at
that layer entirely.

> The max-depth diff code is also in theory a reasonable thing to have in
> general. But it is awkward to use, and not really necessary for
> blame-tree. There we really only care about recursing vs not recursing,
> but the usual "recursive" flag for diffing isn't enough (we have to
> recurse down to the tree of interest, but may not want to go further). I
> don't remember how that is handled in your blame-tree rewrites.

I think that's mostly true, but the blame-tree caching stuff that Stolee
worked on many years ago and mentioned below does require it IIRC.

> So yeah. I don't know if all of this is really a very good starting
> point. Taylor, if you can share the current code that GitHub is running,
> I think that would be beneficial for the community.

Sure. You can fetch from the 'tb/blame-tree' branch from my tree (which
is located at 'git@github.com:ttaylorr/git.git'). I owe a huge "thank
you" to Victoria Dye, who split out the various topics from GitHub's
fork into individual rebased branches.

There were many more patches on top that came after Victoria's split
above, and I applied those manually. The commit structure probably needs
significant clean-up and polishing before it's ready for serious review,
since this is more-or-less a raw dump of the work on GitHub's side over
more than a decade.

It also doesn't pass the tests in t9932 (and the test number should
probably also be reworked, it's in the t99xx range so that inclusion in
GitHub's fork doesn't cause collisions with new tests when we merge
upstream). To that end, I removed everybody's Signed-off-by in case I
have mangled their work in some way unintentionally.

Thanks,
Taylor
