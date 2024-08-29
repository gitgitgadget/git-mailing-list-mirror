Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1BB14A4EB
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958246; cv=none; b=axNAxQiWrMOr6/n5Xhsn/7cjGbLckQNIuSylVNvjwnTVT8ZywsLz8UI3MtkY9eqVaPLOj4DHQ9NOr0oL1JseVAa7f91b5OhSap1fGl7+iHoIeOn+bzH69gH1Y5moEFLOUoNR6vEYeaoG+rsA9Y8NF/CiHwWl9C8wdB1OK5nZiL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958246; c=relaxed/simple;
	bh=NkNYqEJzNyU2Ak6YFHIAdfucdxMo3/ogtWHsffc/i2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNV4nt9HehX/oTiumqYz3wDrBMflF6+1fabGTiSNKhAUiVcH7TI1F1ujtXXH7+62Tdd+Z9E+uqCYWlFwN6mjqMWlVjjqqtCrDMuBWRgeMCcv1q9gc6VjmUn7Ch3/8fyWevP6s0v/Xk34m4qvtJO/EaNEvt5wJG2yNkzmA/uteXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=oNHHBAou; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oNHHBAou"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e13cda45037so1060683276.3
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1724958244; x=1725563044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NkNYqEJzNyU2Ak6YFHIAdfucdxMo3/ogtWHsffc/i2A=;
        b=oNHHBAoutgo9/YDrYUtpbRPMl/cCG5D94AZ5LgwcXcYDV1aH0GLFLPPrHOpj6o0X/8
         zmMBY4UnnxxWlAmcDOIgR8JfCGYa92K7L1KG0QpS2ARBeuTUwygdOdho267SIx0BpSh7
         RzfF57WRAdoI1UV8PBeBgcMCXDB/v1ydyH1+v+SjbYtbOUTvsMf1MlrfEpj8UgbvFhL0
         0zdiSHxM4oHc+4jZ9HIFdZz0Ejg74VqP1PmViSMf3IsJpYxknAwysdShsrkKWZHchJEX
         3GdEJbs3Fbh66XN4cl67akXZ+rHne/XDZxMx/ZOlt07Iup95tv5V0nonYufnCTg0IHTp
         cZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724958244; x=1725563044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkNYqEJzNyU2Ak6YFHIAdfucdxMo3/ogtWHsffc/i2A=;
        b=C/awWD+/2rtqSfjC0tVnAN7AoHDbPpWMzPyw+lyiTVD8nqGspiGbsClRS4y8cEEuC5
         P2hTYb/q2Lww1rB0iEjK5jGcPWzivEhJmmXkiZiQwfTXePfpZYZlfU3EB2TJPxWoeQxE
         Fhn0J7IucL58WpQEe+1jx1qJavOoHtYz7u3a8PYvxVAD3RWTFzcaYTlX4mYF8EnhGiwC
         14VgyMq1Q+tRz8SbjurjZH7HWWKCr1Kaxdo5ho0vrCFmsAhAbviKPKU2+KzPRVKPyFWA
         xQ7yEBSJhU6iZhz1+4dbIlb/rKJBQEyIIW/Tg/QAU3MIPZndaYYYlGii+Q4Ft3Hl00E9
         GJ5Q==
X-Gm-Message-State: AOJu0Yz3HVqrr1yUcc098aBppAtfrzMr31dwsEVYlutlarVCJ6D6dZAS
	/a1CUHjqwIqI16zNGDkJAy7MGPQ6uPNR2ROaQqN6ga68tqOaarKDWcPX4MBkgWUn35PhM3OHXsi
	3
X-Google-Smtp-Source: AGHT+IGELrH1jQjmlbooQsldeHMENG1f3hLbM3G3DD2ivTQn+TPE9dqn72svWFmigtYWFtuSmyVwow==
X-Received: by 2002:a25:b18a:0:b0:e1a:74f7:37fe with SMTP id 3f1490d57ef6-e1a74f73877mr440461276.5.1724958243818;
        Thu, 29 Aug 2024 12:04:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1a6266e3bbsm347659276.17.2024.08.29.12.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:04:03 -0700 (PDT)
Date: Thu, 29 Aug 2024 15:04:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] pseudo-merge: avoid empty and non-closed
 pseudo-merge commits
Message-ID: <ZtDGImCRmC0N/cen@nand.local>
References: <cover.1723743050.git.me@ttaylorr.com>
 <20240817104412.GE551779@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817104412.GE551779@coredump.intra.peff.net>

On Sat, Aug 17, 2024 at 06:44:12AM -0400, Jeff King wrote:
> On Thu, Aug 15, 2024 at 01:30:56PM -0400, Taylor Blau wrote:
>
> > This series fixes a couple of small issues with pseudo-merge groups,
> > where it is possible to (a) select pseudo-merges that are not closed
> > over reachability with respect to the bitmap's pack or MIDX, and (b)
> > generate empty pseudo-merge commits.
>
> Thanks, the whole series looks good to me (I left some comments, but it
> is all just walking through my thought process).

Thanks (as always) for a thoughtful review!

Thanks,
Taylor
