Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AC03F39F6
	for <git@vger.kernel.org>; Wed, 27 May 2026 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892835; cv=none; b=BRpQmd3TCZp8XUI0xLK8o7PYnHsC40//x5ExfWfpKLRv8Wx7j3xY8J0EskBAbU87uXggPVeHh6p9lubnTLdzwQ+qAT/4zXPPFCC2ovH2X4vN/JVIDWCGMQmcIDXk1sZkSB54+yRgFKwZtf/UdNe2mtdCGPY2mlIQouhttXCqKr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892835; c=relaxed/simple;
	bh=gOq31ij03vh7g4+8dA3hvPIvqLZLy1aKhhAQMN3nyHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdaf1bJRQTZP/qMNX+Htg9F/bRQvSZ1gm/e35IBdVG2TFTXfbycL1xtEkm5pn9kBtBS2R4gBYxPAZmsTVGsrhfJLKn7Ee6C1Ne7ooyHfsb2JARQawr93/pK7r8j18WNXFD3EldKojLEgkwGGi9aAPQsSDh9bQBuZjNir5pMryaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=kyKFDmOf; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="kyKFDmOf"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e634c4b74dso2668129a34.1
        for <git@vger.kernel.org>; Wed, 27 May 2026 07:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779892833; x=1780497633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wtj5cuclm2ef1xW7m5QVT+2hlktba3iEAOV1Ih7SBV4=;
        b=kyKFDmOflr80w0fsT1jwhkYgrHBFooWzM5aPOpXDmN4s0auwq/ch7eUHx44525o3T2
         UAbybV1S2rPXeRc2bAFY4XAk3023w7lHwdf/yIor2RbdqNEE+3W0NYPxleUSjaKuOegP
         VPhlWBf24s7Q3rEQIWOKAeLo/PTcGA4zzZe4RCs2ZtoB4asx3527f4rSz3DMQYzMeDfe
         1fDKJRr63UALWC+VGjQ/Nkm+9D7RfDXzYsD8No77fApGjNc3XZHbyHdU6V/mrqvrk0id
         9n9utK8XFarZraQgByh2ZJQZjenNCzOtSWMkJ+Q3L84vppVAqgdD0D32SKH3zZxZCKvi
         PKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892833; x=1780497633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtj5cuclm2ef1xW7m5QVT+2hlktba3iEAOV1Ih7SBV4=;
        b=R7g0Mgz8wF+FFn3MzWU+NUOxmuzB2Kt3Vu022fREzDzRQmGhEjeTmGMhgPvx1RlPZD
         tUHgC7gwBctZ7+AbsLYOh8wFXtVp4Io8jAtD8Mt0lL0zGY//MLP667yeGkZcSYDavhMV
         DI57jKHJsX2bZA9mmy3HpNawXGka9yzc7SO9TIIg4KrPNuJSR+o3Uem/mALE7XQJohBg
         lunv0ZN4XpKMirlOr/yDSE4rJ651eHOPJxMK170iVKunuefeV0vn8/xVmh4cqROJNdY5
         ORRDKz9Oog6qOTPyD27zNx68oXPZvDyZ1eZJGIoFjUwVf1SIW4bF8R7NUydXhW0okDfI
         /tVQ==
X-Gm-Message-State: AOJu0Yzrp3AII0cb3JY0bxfmuL6RTJVwl6bnK3iKVL+FseS/PqiB+njs
	4+8u0YRK2ZTnsjK0/WZDcC0mN+JqldkbS/BkN7vGgDpc/ZpG5ylDUl2tk+dWoITI+Qg=
X-Gm-Gg: Acq92OFBmXoPsTKDgoRJnbcFc9vbe45/7k+qgyFvrQ5T/3+TyMZCUl8cxk9y8UebsBf
	ff3eixL5IiJEN9b+p1+FwylQ2gddqs+K2V7lyCFfgJv2ZZgUDK3okERxtYDabDBel0oDie9Mh3K
	pZNOUeqnUYN67OFKtIv6tYAj3rDv7VUuiry9DPIpqaTweNRnYEqP5SrVJiHmRfsX7j8ygg44W+I
	Y6ZrACSpYER/d+bmPan0FTYM6PW+kVRNAWM9cFVnBKsDi7SKvIe7Fe7SjYgO8bh5rYgz0/WzXaj
	zVNviAs6SzyFajvHoOt1W/4bJca3HHx9fJjac1IkmimxdBia3FR1JNqzT6JG4TtziIEXCS8MDaB
	d4g3Qmql8Cgsmq7JbYSEQMoRy96ZbDVC6SMMNuEdiOPhFdKfE9ssQSIYB+fnjTe2F04tivISOa2
	s9MyhsAucZGcM/ExfZjwhUajI7LobOBBIfFPmk47121khs9ocsm/ixVcAXUpKODySSULxh0OPA4
	z3pRbfltMzxMCQDOUwEe54jK/R5COKmSXY+1gP203KqQ+t7v8r7LOcGvZDBTll3RldluRe0dyDt
	hnc9nwAWkekTsnsQmJdTUpdCmwc=
X-Received: by 2002:a05:6830:452a:b0:7dd:f615:a84e with SMTP id 46e09a7af769-7e5fee240e4mr13508656a34.18.1779892833052;
        Wed, 27 May 2026 07:40:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6065e7cb6sm11922875a34.16.2026.05.27.07.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:40:32 -0700 (PDT)
Date: Wed, 27 May 2026 10:40:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/8] pack-bitmap: reuse stored selected bitmaps
Message-ID: <ahcCX+xAKFOL8HcW@nand.local>
References: <cover.1779207127.git.me@ttaylorr.com>
 <6e1f6bef5f641481a6a875bc215b35fc56cef80c.1779207127.git.me@ttaylorr.com>
 <20260527092412.GD981444@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527092412.GD981444@coredump.intra.peff.net>

On Wed, May 27, 2026 at 05:24:12AM -0400, Jeff King wrote:
> On Tue, May 19, 2026 at 12:12:41PM -0400, Taylor Blau wrote:
>
> > Building bitmaps from scratch on the same test repository from the
> > previous commits yields a significant speed-up:
> >
> >     +------------------+-------------+-------------+---------------------+
> >     |                  | HEAD^       | HEAD        | Delta               |
> >     +------------------+-------------+-------------+---------------------+
> >     | elapsed          |   562.8 s   |   324.8 s   |   -237.9 s (-42.3%) |
> >     | cycles           | 2,621.3 B   | 1,508.6 B   | -1,112.7 B (-42.4%) |
> >     | instructions     | 2,348.9 B   | 1,436.6 B   |   -912.3 B (-38.8%) |
> >     | CPI              |     1.116   |     1.050   |   -0.066    (-5.9%) |
> >     +------------------+-------------+-------------+---------------------+
>
> Oh my, that's a rather nice speedup. I can reproduce here on linux.git
> (~47% improvement).
>
> > When `fill_bitmap_commit()` reaches an ancestor that was selected for
> > its own bitmap and processed earlier, its object closure is already
> > stored in `writer->bitmaps` as an EWAH bitmap. As a result, walking
> > through that commit's tree and parents again is redundant.
> >
> > Teach `fill_bitmap_commit()` to notice that case. For non-root commits in
> > the walk, look for a stored selected bitmap and OR it into the bitmap
> > being built. If one exists, skip the commit, its tree, and its parents.
>
> I feel like this _shouldn't_ be necessary, because the idea of the
> current writing code is to go from the roots up, following inverted
> parent pointers, and passing the bitmap up as we go. So whenever we
> visit a commit we should in theory have all of the ancestor's bits set
> in that bitmap. But I remember that the simple-and-stupid approach ended
> up being too memory hungry, so we pick some focal points in the graph
> and then fill them independently.

It's sharing within the non-first parent history that is killing us
here. I think what you said is true in a completely linear repository
with no merges. But since we only pass commit masks from commits to
their first parents, we don't reuse any already-generated bitmaps for
common points in history not shared between commits' first parents.

> I wondered about "c != commit" here. "c" is the commit we're traversing,
> and "commit" is the one for which we're trying to build the bitmap. So
> we would not expect to ever have an entry in writer->bitmaps for "c"
> yet, but the conditional is just short-circuiting the hash lookup.

Exactly.

> The rest of the patch looks obviously correct. The trace2 bits aren't
> strictly necessary, of course, but some metrics might help with further
> tuning.

Yeah, these were for my own curiosity as much as anything. I had written
them as a temporary measure in order to write the "[...] there are 1,261
commits selected for bitmap coverage, and 1,382 maximal commits induced
[...]" portion of the commit message above.

Once I had written it, I found the result useful enough to keep around.

Thanks,
Taylor
