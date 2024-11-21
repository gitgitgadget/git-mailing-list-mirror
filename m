Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E52D1DD88B
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229063; cv=none; b=cLeYV48I9K/iXrxl4xlmldqgQ/1DZMMBC/KyO5a6X3T755Ivagsscsy7qYAPGh7/pou1JqE/eUIE0rDHrZIBkeIxqOeMhcE47HGZ+9ooNaT6LYmsfW8N3razSiFbOI0q0y7sQEicPYDg7lnv0jj71o1KE6bB4jWCcH3xggZOrlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229063; c=relaxed/simple;
	bh=zZzqqLjPD789MHQElRzrwCBzudUv32hQpxRXw1RksR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrD3C3tkDhZ3d5lQfFQkwSNjzhWJEckSE0bihh0T+SqpREG2fEr0SGmkaw0XKTgjt8qQusp7t51PHkPCBSa9wtossh+ixc3ocKeIIcugYG2tOxB7JX6fzON1V3p5F+hHkA6Lw3i/Qjs+NAaVebkgc5mNseqrkK901nzFMpP10eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=uyewZ3Sy; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="uyewZ3Sy"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6eeb31b10ceso15576677b3.1
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 14:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732229059; x=1732833859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uVA8A6RIUbW27rXAzITG7trqks67yjcnsy9R8B0M3+Q=;
        b=uyewZ3SyPY1FRbqb7kkHMPOmSnL25KUvMHN4D1lnalGfnoFT/n5bpUEWd2YFNZR0JR
         pjLMPmqUYf0hrSaiUHZdktgRsHYeUwjfaCDz2AQiNciy54MxjkPEVdefUv0lKq4mJ1c2
         NTh9i+FdrQIe5haz9O6uzHZwU2A96DbTx9rZ0CShEHIEOZiCTEPYCgdRsllci/6ujeDF
         OQBz4TI+8AGY6gnA9TdZs50qn0y4QLLFRCxnyb6EfsZeAbtYC1Ed+NoxkI4sWSzHhYJD
         FqjCdWnVbBpIpd2B2RCMIlJJdZi4woNQkaEgAc8AaVrFv0TRqX4Gqm8uOvTIzoUcvbuL
         ybsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732229059; x=1732833859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVA8A6RIUbW27rXAzITG7trqks67yjcnsy9R8B0M3+Q=;
        b=MiWKOcqn/41+feA2uDRBeTCW36G5YHzwbPJvdLv9OTabkn98jA70BflQYW/MBiEFJn
         wHOvFbhRDKCn5LqfExARWbrlDSDxlkw58+/BN67QyeGDBzZHDHqO7NoSq//10iJWQHzX
         KpkeZAKTV4WcjlUd2/J79xyENQ2vupxD9L2V37Nm0ULWy/ps/jYqiSNm265QezEB5SPS
         lv4lNMCUW1ZS4o+fXvBmr7FzAhMVJjOAUjyfXyz2nDWTDQwjkMha4OYUMFT9PKmDGMh0
         uy60IaJVMeKSP3y0notsxyhyGJ4loyPv9yA0Ow2uk1oeGdtCGkHhkpmU3qWZeUFNk1uR
         koGQ==
X-Gm-Message-State: AOJu0YxwCtCy3Be8/nl9q4cVfG5QL6QqqMeyqiQw7PzOM06guAwo5DRl
	EgRO3NxxCJldUv8lrPYI+ghUMiHGEVSnIvK1yZ4/L1BBtBW2Rrh1EjmcYKqIh90=
X-Gm-Gg: ASbGncuOOuiiWCLL1CVakBNdGaDn8jCyVaCszLCwlfSvA2tvQJ5et1wHv2sI1rJVWzS
	ItI/aW7t9+pYLgSqB36tVAGLaUf/zq/d2hbhNLe/cLP08y0VhUf5T7jp00SBa+dL2LpXSuHUmib
	21i0T/0yIE805T6CHyde5A7oZZ/xUUcoYo/a23XkXs1K2W5detZWhsZyKuXqBT85HIFtVBVlWDM
	ZJzFGYF9/Dlb0n7bcJOblhjqy5KQmENi0dlnIKceBPtMPsMLTJKTqSotu3fM+o8qulJSn04tZ6r
	A9G3W6bSpSG3PZ8hHY0dOA==
X-Google-Smtp-Source: AGHT+IE7Zs8v8/tyaV/Y0AiJOTDhR+D/cWmh009Rg+FHiE5K67DPD0gMMr+MGRJYbLv/YfCkVR3w9A==
X-Received: by 2002:a05:690c:708e:b0:6af:6762:eba1 with SMTP id 00721157ae682-6eee09e988dmr11013827b3.20.1732229059515;
        Thu, 21 Nov 2024 14:44:19 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eedfe15295sm1757677b3.18.2024.11.21.14.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:44:19 -0800 (PST)
Date: Thu, 21 Nov 2024 17:44:18 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
	jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 4/6] path-walk: allow consumer to specify object types
Message-ID: <Zz+3whunQkfLX0A1@nand.local>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
 <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
 <83b746f569df932452d8d102dc29dda0859c4ed2.1731181273.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83b746f569df932452d8d102dc29dda0859c4ed2.1731181273.git.gitgitgadget@gmail.com>

On Sat, Nov 09, 2024 at 07:41:10PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/path-walk.c b/path-walk.c
> index 24cf04c1e7d..2ca08402367 100644
> --- a/path-walk.c
> +++ b/path-walk.c
> @@ -98,6 +98,10 @@ static int add_children(struct path_walk_context *ctx,
>  		if (S_ISGITLINK(entry.mode))
>  			continue;
>
> +		/* If the caller doesn't want blobs, then don't bother. */
> +		if (!ctx->info->blobs && type == OBJ_BLOB)
> +			continue;
> +

I was going to ask why we're not reusing the existing property of the
rev_info struct to specify what object type(s) we do/don't want, but the
answer is obvious: we don't want that to change the behavior of the
commit-level walk which is used to seed the actual path walk based on
its results.

However, it would be kind of nice to have a single place to specify how
you want to traverse objects, and using the rev_info struct seems like a
good choice there since you can naively ask Git to parse command-line
arguments like --blobs, --trees, --objects, etc. and set the appropriate
bits.

I wonder if it might make sense to do something like:

    unsigned int tmp_blobs = revs->blob_objects;
    unsigned int tmp_trees = revs->tree_objects;
    unsigned int tmp_tags = revs->tag_objects;

    if (prepare_revision_walk(revs))
        die(_("failed to setup revision walk"));

    /* commit-level walk */

    revs->blob_objects = tmp_blobs;
    revs->tree_objects = tmp_trees;
    revs->tag_objects = tmp_tags;

    /* path-level walk */

I don't have strong feelings about it, but it feels like this approach
could be cleaner from a caller's perspective. But I can see an argument
to the contrary that it does introduce some awkwardness with the
dual-use of those fields.

Thanks,
Taylor
