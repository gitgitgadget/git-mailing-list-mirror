Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C613515F6
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157598; cv=none; b=QpUT25uaiOlYVuzJxqbZFdeYX2XUW9iOlQr7Oe/SaM+E9X5hd5D1xu6e98HcRRlSMvNVBqkNKbH9LhA1iH9b+1MZ0DTL4XmIfn3jX0aFLXyaLSZzg/3vr2IIvRdFacyOO46UKPU+pfyp5b07NElauoU8KLP0PapiMttpXezPX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157598; c=relaxed/simple;
	bh=WVHTVnLPvHqvD3CRG1TZ/+FyE8vWWRUld09fVGvWKYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAWPQUgMrt4r0JlceRUs6rzstLGE3Iot7PryPuMc+UlSzSflq0EGgBrMzMFOq+mx3wTZgbEv1p/8bbbREbrsgAkPd95f3jQCD1ZoEC0JGEBF1M8g0xiTTKiNOX1jcoR+cIudeGDusaSsrtPBgkgkG2pZ+LFB8lQcEBVSLnxDXXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rNG5vGNZ; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNG5vGNZ"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4560d6f82edso1068251fac.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787157596; x=1787762396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bs7TxxmImm2QLVTl6bAApC2IjMG+zsR1zNZNoA98ikc=;
        b=rNG5vGNZcf8davDatPkCRuFhLdf254qEMhjS1EM7ndDgj+OC02R/WRghCWjn2rM2Ge
         Vs94TavWcIxAZnWxr5Xg2f6xG9czEw5twSpMxiBG8MZKxgPLrASY2Y2/Q7/ChEoaf6Y1
         i/9WFwRQjYu3GIwnt8yXO6wqvwfS+THf0VJN9JlXCaGWAvDk3zfRsLfccI3GTF2IX3HL
         svCSi9NO4/ah9eJLxR2jDnFBvhUXVU1teqzvantkD1Kf5/41pd/VAv92zKk+W+Zw14ns
         Io93HB+8kX767CaMlkXCPDfGsRpch1e1nmFf3e07slCOcQc7SLjyfi4s89q0hXKgadiq
         M8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787157596; x=1787762396;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bs7TxxmImm2QLVTl6bAApC2IjMG+zsR1zNZNoA98ikc=;
        b=rRAcPF4uiow9LD7eU9UaIak3i30Aj9SfQAx2vYq+/vGSAiQagMRuu4wprqnHk/GFDr
         Ue7Ppbo99FiWxDlBeDpzzeiEb1Qo5QF7u8jL2yX0QT9XCYdPCZblx6+V9oSzMwpZvEbA
         +Z5JxMza7AhoeNqjoHBuG2sGYpFz4r5RRVUoUCnmhMZZ2zmIafU/P9jvu3CU3FDkqb9J
         uCIWe2l5n0LR62SAeuXOKxuNUJlbUSGIIeOziLFOtDIP8ufzDY59zw5rEis+rMmMAq85
         ATDq1u3RctbM0tsBB0IsPsmfV54tig4yReWYaGzSAlWNOIAsIVQkduS7dLhhPU4IHmx6
         NoaQ==
X-Gm-Message-State: AOJu0YyngWw/6UD2bmXKeh0cvywwhKHOD3Y3xZHI2ys1cPEsYKpH4KsI
	mBaWwKyKyt312n+NlU4stR1ZAskt/YMbeW/Wh0tROIXxqryPXM1N0qLzN2prhg==
X-Gm-Gg: AR+sD12Mc5mOP13sUE+n/IUlL3eG5oxBQU2pGTNBdbZBNqCFtWV2DKGfQ1fimZmpY3L
	CDNNZDeChkqac3tPxynyixWN/vNhgOPH9ALmBdTTSwMTBQHX5jtvSP4dKpA/ErkCT1VWE8l8n9Z
	Mx+LysadU2CVkgDXkfdCm1E6abR/5yx6E4p2QUPDoqStD5dLAPG0VvRDM5Bsn3Mpn1KPfsB2ixa
	+91zbWJI52tesq2wng9HkA/2H90+RqEylFEsOjPXtNJ+qIP5x9RlHq16GXXClIeD3UyPCIUw/Hx
	vzzrfBebQUbjxOHyoYXH5Alv5A0u7DaaZoU93T9S67E4hex7ci7suhtT0oPKEx86uoR/FlJoFFY
	BKPmWz2tlYLrLJSDm9RNBcyxmbEVFfTSIgL3pCJ0U3UDNLgIvV1AWNY2IwJrfZamcYI+0Vcc2iC
	XPgIgmZnd+ch+aq1KBOB1NowKLp6DSHFl5W9rvyoUH8QLKPrZP/gMXD+5o7yuRusV1
X-Received: by 2002:a05:6820:162b:b0:6a3:1dc5:3570 with SMTP id 006d021491bc7-6b13c63ea50mr4398741eaf.31.1787157595632;
        Wed, 19 Aug 2026 09:39:55 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13cb9f1d1sm2297148eaf.4.2026.08.19.09.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:39:55 -0700 (PDT)
Date: Wed, 19 Aug 2026 11:39:52 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] reftable/stack: move list lock to `struct
 reftable_stack`
Message-ID: <aoXaDW1Ifjys8HTr@denethor>
References: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
 <20260819-740-optimize-reloading-the-reftable-stack-v1-2-6bf5305d4e43@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-740-optimize-reloading-the-reftable-stack-v1-2-6bf5305d4e43@gmail.com>

On 26/08/19 03:19PM, Karthik Nayak wrote:
> The struct `reftable_addition` is used to modify a given stack, as such,
> it also includes a `struct reftable_flock` used to obtain the lock to
> the list file. While the scope of the field lies within this struct, it
> doesn't allow for optimizations to be made on `struct reftable_stack`
> itself.

Hmmm IIUC, there can only be a single lock for the reftable stack
correct? If that is the case, it sounds like `struct reftable_stack` may
conceptually be the better place for the field regardless.

> Move the field to `struct reftable_stack`, allowing us to make a simple
> optimization around avoiding a stack reload when we have already
> obtained a lock. While this is currently possible in the write path, the
> write path also contains multiple branches to reads which only work
> on top of `struct reftable_stack`, and we would miss the optimization in
> such paths.

Ok, so if we know the reftable stack is alreay locked, there is no need
to reload it since it can't change. Makes sense.

> While here, remove an unused header file from 'reftable/stack.h'.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
[snip]
>  struct reftable_stack {
> @@ -18,6 +17,12 @@ struct reftable_stack {
>  	char *list_file;
>  	int list_fd;
>  
> +	/*
> +	 * Set while an addition holds the stack locked. Used by
> +	 * stack_uptodate() to skip reload checks while locked.
> +	 */
> +	struct reftable_flock list_lock;
> +

As mentioned in the log message, the lock is now tracked in `struct
reftable_stack` and the rest of this patch just wires it accordingly.
Looks good.

-Justin
