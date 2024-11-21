Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7428A1D4323
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229850; cv=none; b=o+qRvJc5J1R0MuzpF1PKCDvnLMaC2CAzdYwrk21z84SnNMlWexPMt8DEatBAo4ttEzbu7sht6RVLRbtSeDnyeCBSNbQMiWTOze+rvqmhyoUkQJhepsGuReE0EWXufJfHciZI55SOfBRj+dc+7Xz9Ny1BGewQf1Gio7N0TKR5QMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229850; c=relaxed/simple;
	bh=ezHEBf6PWUVAdvJuQiiKk3fr+umwBYpvYj2cFqM9ToU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTiLALHHsf5r/QxP1cyqCytossTTk05Tsi7CfnQK2ups6odHAkwG1Au1Zqb5UxVYKv++cK+zv8QVnLKur3JxV0MTCNvzpKBzkfQfnpYBmnGuAK2RtdZHtqpge+h8RIVsR600kPEfb68dbeGaqeySNm8KEcn2WcxYPZWxaDpSHpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=L1a8wXvg; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="L1a8wXvg"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ee7b886b5fso14878797b3.3
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 14:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732229847; x=1732834647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AIOeuHiAK5sFq11OlrvHsW1dQyfXWOFZjtDFFmxQsho=;
        b=L1a8wXvg2rScnivgn4i/AoUeuQg8b9l+66WbBKU8O4D0jUbI2gvqeURgbBaJJ6yDiB
         NIv61WeGE/Zr1WGC4IwyRHqBHjCGl5gE4Jv7NddfXPUFq13Qn0NqYkzp2SVGvbWKXkLL
         20HDN9PN8hM5vMq3zl+fYdV+SrJ8p2ABmgwkcdvCvhAzgol6Qf2380bvHzBG+1jA1r2P
         tyWbNnbklsggEo4iVL7lqQlyuPAzJ5vNByJEi+iiGK+0VYiHuniTgFxA9gfj/9aBGTrk
         ub6s+wjl9410WT2jKcAs/WbYcJ0n+Hl6gk2+npXINZm0tfPS7JhNSmBqWfM6NMd16KD9
         JsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732229847; x=1732834647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIOeuHiAK5sFq11OlrvHsW1dQyfXWOFZjtDFFmxQsho=;
        b=qD/evVLmhgxqImtG199KWrGtw4G5pP8lYqkJQED+QU0+Hn2hztcPXvu75sZACK6w43
         VAxRtRZQ75ky0TCJLEFuguu+9Pyp6toszKbggCRRSnkIyLFa+DWn/JAHqU7ePBC0/C/c
         c1qDRh2yrVDgyQDUkBoNploBI/dhC/DtPdX1+DlZJ+X1Pp0jS87TUWo+JBmhqK+hOcaT
         LHkg2yM8f1Lp8xb4OYU5xIpSyf0P418QG/eNG5tQRe34rjMzTW4rhMT1UKM9RwYEn4bo
         Sa6Tr3L1kdtsPilDxalCFM+tFLP02ZltJn1GM0kODhIisztgLCLuPfzhZjiQYdBDnEST
         ZCsg==
X-Gm-Message-State: AOJu0YylRvkaDySLAnCbXG7p7jLsf2iDWjNLceMxfDQ58oRAtJs+VNO4
	Gv5+nDrc/5NOu6l7g/LfRmFYj8RvT+Yn4/IG4EXaJSlAS42U9qZ+bjRVx5O/X1Q=
X-Gm-Gg: ASbGncurFZ06GcHG/lIcnG42ulGbeI3CiO5nTHYZaKXN57cNxektrszUtjI1kbNlzOm
	bRCzdb/yt3aElY95hP+slfPXwwVIEMuHGNECHO9l6bZUJ6I9t8QGE3jcuDSUPSijmaeTHma5dQ0
	pnzSozFzHGZ2kxO/Cp22mjCITFWEQLXroobDL+RJEQb+ACHCxaLlHHHamXv2I5Uxi5ldkJFOmwQ
	KNHlcNfjON+DHYu4TviGiwS2C9D5LQxi9WHIAzJaJR11BA+w5L80N9/BaxWTVEYGT1cUMC0PYA3
	igrTzGwYeoUSJ6BXv3joDQ==
X-Google-Smtp-Source: AGHT+IG87eIuenA9iMofAP8cnkj+Hmz2MLl4FvOJJayM49Q4D3RRUxtnspNyTCW1PnLpOx1W096SzQ==
X-Received: by 2002:a05:690c:768f:b0:6ee:8363:96de with SMTP id 00721157ae682-6eee0a26d30mr11062647b3.26.1732229847404;
        Thu, 21 Nov 2024 14:57:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee008cd94sm1769127b3.95.2024.11.21.14.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:57:26 -0800 (PST)
Date: Thu, 21 Nov 2024 17:57:25 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
	jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/6] PATH WALK I: The path-walk API
Message-ID: <Zz+61fat+vGgb+xL@nand.local>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
 <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>

On Sat, Nov 09, 2024 at 07:41:06PM +0000, Derrick Stolee via GitGitGadget wrote:
> Derrick Stolee (6):
>   path-walk: introduce an object walk by path
>   test-lib-functions: add test_cmp_sorted
>   t6601: add helper for testing path-walk API
>   path-walk: allow consumer to specify object types
>   path-walk: visit tags and cached objects
>   path-walk: mark trees and blobs as UNINTERESTING

My apologies for taking so long to review this. Having rad through the
patches in detail, a couple of thoughts:

  - First, I like the structure that you decided on for this series. It
    nicely demonstrates a minimal caller for this new API instead of
    implementing a bunch of untested code. I think that's a great way to
    lay out things up until this point.

  - Second, I read through the existing API and only had minor comments.
    I read through the implementation in detail and found it to match my
    expectation of how each step should function.

So my take-away from spending a few hours with this series is that
everything seems on track so far, and I think this is in a good spot to
build on for more path-walk features.

That all said, I am still not totally sold on the idea that we need a
separate path-based traversal given the significant benefits of the
full-name hash approach that I reviewed earlier today.

To be clear, I am totally willing to believe that there are some
benefits to doing the path-walk approach on top, but I think we should
consider those benefits relative to the large amount of highly
non-trivial code that we're adding in order to power it.

So I'm not strongly opposed or in favor of the approach pursued starting
in this series, I just think that it's worth spending time as a group
(beyond just you and I) considering the benefits and costs associated
with it.

As for the patches themselves, I think that cooking them for a long time
in 'next' makes most sense. We will want to land this patch series if
and only if we decide that the traversal powered by this API is the
right approach. IOW, I don't think it makes sense to have the path-walk
stuff in the tree if it has no callers outside of the test helper
provided by this series.

OK. I think that's a good stopping point for me on the list today, and I
look forward to your responses :-).

Thanks,
Taylor
