Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAAE1FDFA0
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548182; cv=none; b=Wv3ZyeaDyqrFNB6vFo8hGgfCN7m3EJ2gQASY8pLfkZnKiNuG2k2FOkrZWKj+KO7FFmaB45+c9SUBHmlYAEPbvlbtMwPQjWkCuyiSn2w7rQm2B55BFawoA0dIV4goRbPFd4gbfjmFaF1Fvsyh4R4UAsZNS+OXfesjmHuwd6es+Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548182; c=relaxed/simple;
	bh=BVAXXSGr/ruClbjWapcV/UEC6lS1BLKIh54cHmGWd3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TevpOhgBUZdCR7QhTxrYvGSnHK27hr1V51J+wyDrUMjSdEii5CqjKZtdY8gFUfx5VjPbzwxdRSCw8j/ZbADaktjn9pNXR27JfCJEgXwCPNIEKzuBdyVCGEOnvzTL5xvRqhjoMfB+dXIZkqRU2LijqZ45E8SBVZ2Y+v3wsFDsgTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jLUFA8iw; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jLUFA8iw"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e297cc4b134so4813904276.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 15:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729548179; x=1730152979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVAXXSGr/ruClbjWapcV/UEC6lS1BLKIh54cHmGWd3o=;
        b=jLUFA8iwlGNQPjr9HojMUE72EYNTj9CeHByZCiLTnn8qeLn/tpSUA4LEnUqr/46xsk
         42fE6ywhvwa1mLnTFv92bTwWePMwbPTLSsFW6d3XwhB038l31O4ovFeYUHYR6XEYQDzs
         qfFSWi0xZIb9oRZ2pUTN8TL8ZsFQ/VGaJd2imTVJ/EKQ2O6AgrDhe1ewcZVMerTcRSKX
         vUac8/TVE3+/a0qSJkL2Fp+vzU0FJF/+P01L42VXOP9cT5TEydh1eMVvWs/2TBRsWsH3
         anHchRJPt9t9CH+xMkLu6nBZk+zv/lJierSvhv6YGuTO+Pt+nUWy/Vxj7r6dh63+vbn8
         964Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729548179; x=1730152979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVAXXSGr/ruClbjWapcV/UEC6lS1BLKIh54cHmGWd3o=;
        b=dxYgbsmd3P+0gvvvew6bjjt9rF2R93qYw2PL2QPHZOtZXGOGfANrxE8yYg3+jbdOlG
         JrK5/NzL9m6JiqUTUrlNt0rx2OfYEUcMD19QKms6wo2G+MYydYJooiF8GgLhBlNOvGzb
         n6hrhiVKpPqK36ox6YGaHjJElRRE1qDtwR/vz2sAjiozOalDiWxhVgE55j9UU3fLjdZi
         8+cTEL3M7nw2flk/lSf+bBOX1UTl31eFOBb+8azH9QPRckeaEYoUQ/h0tGz/k5evAXBS
         /ddTvW6IS/Eill/4rZANxeQizScXu8d4RZh8OnEiRtP1rq1oLGNaNTBn2Pqekq2YhtKl
         in2g==
X-Forwarded-Encrypted: i=1; AJvYcCVNhDkdVSthS5fHSJNHjenekPSEOvcNqBZdB6xzv4fdxpsn6q2MBS3JvLz4jIW648F8cfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeYosM6l7QSXJwNbSaCJP3RWJz8pLqRXSdySJbWe5PnJ0NoBrH
	bgg41tlklb0m/e84XbHcCOv2w1NR6VpT8CdOS+rJyF7SS35It7J/IgZ3E3QUriEwcIl4gz6u79q
	q2po=
X-Google-Smtp-Source: AGHT+IGeUVNHzO/duH2q86WikdZ+/zv6+y8cTK4dXImQX3avXdcuFk0k8qjcpTVHnLWJdPbnD/O2AQ==
X-Received: by 2002:a05:690c:2f0a:b0:6e2:50a:f436 with SMTP id 00721157ae682-6e5bfc0ddc8mr81780787b3.36.1729548179419;
        Mon, 21 Oct 2024 15:02:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccb44fsm8428617b3.80.2024.10.21.15.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 15:02:59 -0700 (PDT)
Date: Mon, 21 Oct 2024 18:02:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>, GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] meson: fix meson build on 'seen' branch
Message-ID: <ZxbPkU+P8HUwVUDj@nand.local>
References: <12325bcd-fc3b-4d2a-9ec5-20fa2b50297b@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12325bcd-fc3b-4d2a-9ec5-20fa2b50297b@ramsayjones.plus.com>

On Sun, Oct 20, 2024 at 01:54:47AM +0100, Ramsay Jones wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Taylor, Patrick,
>
> I tested the v3 patches on the base mentioned in the cover letter
> without issues. In the interim, I noticed that the v3 patches had
> been queued on the 'seen' branch. I tested with make, as usual, then
> with meson (on Linux). This patch was required to fix the meson build
> (just in case you weren't already aware, although I suspect you are!).

Thanks. It would be nice to have this folded into Patrick's branch.
Patrick: thoughts?

Thanks,
Taylor
