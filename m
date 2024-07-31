Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148AC1B3F1A
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442662; cv=none; b=T+JtljLGwvlE3mb7O1XcXGPkYxY9uYo3u3pi8UTC1XBPukoEVpUYG6IgTMr3CxdfUZYrUcvsNT6L3oBosAcnl3NqlCWM8X5Sm8taXfE0CILUYWnjjRoVCYqNz6S1LXK+8GTbPnkTi5AQ6JJiYFhUTPZsnsm8n4+C/lfrfanS4KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442662; c=relaxed/simple;
	bh=RZ5BtpL5qy2dirSI43FTMiOJ9p1k+OAHe3RHas8SS0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj0ZfbreY5bRLJWhkh40LrbFi2yd+rx8ARhanCE+4HJA+2k4LU06dM5WJk6rc9Nipho1JDwYLvAG8OuGeX3+m93srXsUdiz5QZ2xvrcheWmyKIDEFRdk9FFxwEGcIBKkALX0pfFgLeF4LCAWo/4YIJcbyN/PfXRKvzmxwzixv/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ltAzE8nq; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ltAzE8nq"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44ff7cc5432so40659261cf.3
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 09:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722442660; x=1723047460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RZ5BtpL5qy2dirSI43FTMiOJ9p1k+OAHe3RHas8SS0Y=;
        b=ltAzE8nq6P6I/eic+Tf94vqA+v1mDCBwazcflWu+D7N9FhFp+MfLtdKodIGsAt6tbl
         YfZGv8DpWjN0Ja/XapU4Na95npb2nEgInY8RCgL5Z27NmgHg7x2XZDnWhSteEf81nN1Z
         77tbt7kN550ro5cWmhyY8T2v4SZJFYTpVzhzVj453vUw21b67Dgnhiem2HuQLRbdVyoO
         NbmfkqAIkPcXRERbzRDSd/Aqy9+pyD87yJhqJ76DXUHp5APnETtjJZJvHRiPhJetVyHu
         Pf+FDqP25gle+5fuvsezJAaTEdFSj5bsEv/ktIE4AS4XS5x6Pcyg4L8dpE2C9rttp4Fa
         Azbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722442660; x=1723047460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZ5BtpL5qy2dirSI43FTMiOJ9p1k+OAHe3RHas8SS0Y=;
        b=edwUWCpgVuiiMuUax6zo/kC7PBWsCL6ByUhQcIATiAJA+MJZVFy/vZcqxoIfabHRVH
         XlIqBLOz+sprvKKLkKgMM6V2jGDEijiNl9K7Olc+RuCbNxuibY+LSxZ7fc+QY/R4CERJ
         BumjGJle/uwVMdDfEehsAdb4jYntVSXYbIrVsMI8dRCTl/vCA6kfwgraJsA/juThYPB7
         SBF23KPY5aureyeizaZRL2nr5lLdo+SJxbTdyu+YG73jbbWddmFwr8cynEVYoN4ufb28
         xxGLppkFw3MDdUIasUrx9uFE1JRlja2LvK9tdnzr1ukmGjOYve4YDq/2ksB62UJIkTrv
         naGQ==
X-Gm-Message-State: AOJu0YxUdcHMFB+72/pHog0W2OOsa8KETqYkcSrWx+1q4SWKmUwppEFJ
	T1YyTKWaUU5JnjN+oSOKgqKjCc0UVD4DzGaFlNHaxwSfj8Tm0MqW/nH6U2ug4dY=
X-Google-Smtp-Source: AGHT+IHP8Rakfi5aobjd8t7+t78iqda9g5Vvl0p8Fs79As6fGd2vSIkLEdY43WS8APXcXQvi0CiTXA==
X-Received: by 2002:a05:622a:1901:b0:447:e38c:59f with SMTP id d75a77b69052e-45004f5d2a5mr177262581cf.47.1722442660250;
        Wed, 31 Jul 2024 09:17:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe81259cesm61314311cf.6.2024.07.31.09.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:17:39 -0700 (PDT)
Date: Wed, 31 Jul 2024 12:17:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] Introduce a "promisor-remote" capability
Message-ID: <ZqpjotriOdB3Hno4@nand.local>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731134014.2299361-1-christian.couder@gmail.com>

On Wed, Jul 31, 2024 at 03:40:10PM +0200, Christian Couder wrote:
> I have tried to implement it in a quite generic way that could allow S
> and C to share more information about promisor remotes and how to use
> them.
>
> For now C doesn't use the information it gets from S when cloning.
> That information is only used to decide if C is Ok to use the promisor
> remotes advertised by S. But this could change which could make it
> much simpler for clients than using the current way of passing
> information about X with the `-c` option of `git clone` many times on
> the command line.

I left a review after carefully reading these patches. I had a couple of
technical questions and suggestions of things to change.

But it's hard to have a definite opinion about the feature overall
without seeing how it is used in practice. I didn't see anything that
made me concerned, though, so I think this is a worthwhile experimental
feature.

Thanks,
Taylor
