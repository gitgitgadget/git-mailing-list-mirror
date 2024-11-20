Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E651386D7
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 19:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732131806; cv=none; b=T6aQ+uUPuSCA01QFmWTVdWzaW8CA4nG7OQuPtNDanLNIPGhKx0Pzzhok/3BfXKM7ZO3kSEAMxptFAYDp/xriEVPmV8UrwUkWxkbfxtzcRA/omRJNtUZvjRKLT35GyDuiaDBtAgN0Nl80fhTzWtuWLPz2iivDf0N5+Ii5iknou2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732131806; c=relaxed/simple;
	bh=OZAi0rM8sM9KxGkP9IvXvgKxsMhiSYsWTDBI2PUENys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW0SXdkHLWQoga/3kKAOCzUSbUVYdNfflyQVpGvX5+a2E5jfLrTjvatFwa1hpFNGuZGAnGId1FyDg14NiVVa47bDZBwiuCdyOpaXQhbX03O4oUoOiu6vm1FT8D4umTUyatxJTl1x9HQvKsZhX4dpR2oZi4D37HY89rP65YCVRUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0G8R1CsI; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0G8R1CsI"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso96834276.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732131804; x=1732736604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTCImbGSdf2MwCxJhZhpgh30OLjWfc7pirGt5POyQMY=;
        b=0G8R1CsIJdOK8aZBdeo0oS66TLU+ncV16hObeGfERbr34TpkF0xHxuobaIaGNysLbL
         Vs0QDyWKZiNqO6xnvcFpDrNLyPjwrgG83d0Dew/gHRqA/wAOBixw1OnEggDivBZtfJNh
         0lMDje2NBR17dTNyCezcebglf4jyguQfw4N9bcGr/rMukKH9DZo9bj2jalEgpt/clm7f
         GYfeWee36Si15s7hXsFVbBWvZVdLc1P9+1ivCn7Ad1pK9Qam56hZA6ApwggpUBFA5yr/
         HXj21TY6JldMObS/USOOjnmbcbCttQG/8j/V99Z32p14zmUJd5LeFNfSvyGM0B1iOlgo
         yUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732131804; x=1732736604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTCImbGSdf2MwCxJhZhpgh30OLjWfc7pirGt5POyQMY=;
        b=hW5nSXCxRvnWGI1h3BVE/ebEUiZ0goWGsAi6OdVRLEQNVj/m5HzEM3AmXFLsDOD6Rr
         KyO53Z596txr+HllUqA05wdvG8WaRSTgDshxk9XZpJy4JZkgpumwm1TMvfIAJ0/X5nWE
         9w1AZR+P0463sauv9A5Nf7R7ABtqomHCZBAES6ZYL/9WTEKLr9ILPQvNbw3VK6WUz0PP
         lCsMuwPNJ5sEiAf5JNBsjgEO3vaniGS1WPdNwbCFJfFKIZ3EqDZZ5/UoLoceQLSWzt89
         Re5EAkmFMK9CdYgCYFGiqjGAOTQj2AeTRW8PkuTTDngotB2PWNmnPychktQy4sk/pwHu
         ZrwQ==
X-Gm-Message-State: AOJu0YzQKA19OrlZHTHRHytj2vqGq7CKVxfXOLsSvt9mUiAoiAOZIYcc
	0F3DoqehBKX9Mht4v56thkyIeyNxPLMZVTRjHUuxEyHi2PCWUK1jnRzmCQn8pWP4eYqwEGSJFaO
	J
X-Google-Smtp-Source: AGHT+IHfV+mPhdmlitVjm+7DgXyU9CrwvRzMytHSXamD1pz/Un4BHRpNafrjK0I/crAGO3/lD64FRA==
X-Received: by 2002:a05:6902:2505:b0:e38:81ff:dc4e with SMTP id 3f1490d57ef6-e38cb60cae0mr3382223276.47.1732131803798;
        Wed, 20 Nov 2024 11:43:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e80675esm3249758276.58.2024.11.20.11.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 11:43:23 -0800 (PST)
Date: Wed, 20 Nov 2024 14:43:22 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com
Subject: Re: [PATCH v2 02/10] midx-write: pass down repository to static
 functions
Message-ID: <Zz472iMq3nZMoRMf@nand.local>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-2-e2f607174efc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-2-e2f607174efc@gmail.com>

On Tue, Nov 19, 2024 at 04:36:41PM +0100, Karthik Nayak wrote:
> ---
>  midx-write.c | 57 +++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 31 insertions(+), 26 deletions(-)

This patch all seems reasonable to me. When reviewing it in this way, it
is a little unclear to see which functions need just a repository, just
a hash_algo, or the whole write_midx_context structure.

I think I might have erred on the side of just passing the
write_midx_context structure throughout the midx-write.c internals. That
exposes more of the implementation details than is strictly necessary,
but it does so to the benefit of making the code (and this patch) easier
to follow.

I don't feel strongly about it, and I trust that you modified the right
functions to pass the right data. I just wanted to mention it in case
you hadn't considered an alternative way to structure this patch.

Thanks,
Taylor
