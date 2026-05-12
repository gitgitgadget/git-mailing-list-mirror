Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB49E57C9F
	for <git@vger.kernel.org>; Tue, 12 May 2026 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544610; cv=none; b=W+rnQc4QD2A0+GWbKMJ3cJnNSLWz9HZuhsTTNu8MrXVntv9+i84eIafZtTP9hBlTmLboBzFQipvmmCrP5NbpS/gzLpFmBvCknnNXo362kslEEIkAKxVv613WivUAntFaE4qv1xg1TfRalQWKvSLP1ajgevmrE9sipLrpfAC07Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544610; c=relaxed/simple;
	bh=6j0xCYK1BU6pB334M2zxct0GuPooL/5DcYdw/KpdthI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/UoDMknK9rLBMIeyP06qtStlmM6laXnWyPmXfYAsppYMZCBeBLz1leruZ4VqOQGOBwo/kgbaUamH7pQI5avsyw7ekdwzUJ/9O8E756Agn/yWvZss8H6neu7Bq/6/l2FnrYFCjdXeUX6S8+19y0kytZWAQnaS0cKPwRsrNG6/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=lvXK7Tol; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="lvXK7Tol"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7bde9d73678so52667257b3.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 17:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778544608; x=1779149408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zaa4hrhwFbH73d8xQf1v1z4voRb61033r6IRDETLrds=;
        b=lvXK7TolU01iXwFyyDDy37BGaiK3M39NEhL+D/7RjPFbFAtsO7pWVRHWw8X0GKu6cD
         dpuimtjHNJXuaDWfdcVG13IMZ7U8dus5vVth41B62L1MY6IvXd+UOs0A5VGZX62hZVqW
         GNinapUoU/VjfhrwSTnRlQkcKyr7ugMokcxtOHryoDGB1Dv1JR07PHM15EY9Dc8RJKeK
         9uEP+5s2+0EbxJL0FsuVXYDdSwZRt8tDLK89bg+p0QOWGSXX8+CVuNFx/cAlMycl5fdy
         8x0umC71aCKACkiiJgBVqCw6iPvGdzMfCaZCLEw4jdHyaJhvlt3eQpWdyc9xWaN3wC45
         Efqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778544608; x=1779149408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaa4hrhwFbH73d8xQf1v1z4voRb61033r6IRDETLrds=;
        b=TQHGEfLhSZ+1IW/DEU9ngxi3DDK5td6BPYUIGPVgW06DeDvYWO8Z2WR4sUeiSjPjxo
         Zyf9m1FPMDdOamvIdxvC742oTLE0eFZA+tyXsUCmSHzecbc7R3HOhqJg9/ccJf0eBE5L
         u6xfJIDIAfI0+0bMzfCZ9/zw54tBFXiswtjyyPsY6kdpjcjncIBdtPdJ/CfJLY8gL10s
         +LPx6U8g2Ukq6eeN15A68xx6xjJSfwHa20a4D9lHGq4TdzyUA2jla16P9XerBFdmqKxn
         I1g0X30NWLdBD8a2+2xQxzckwtAY2yfru7OoWkCVfjxeHPvn/FLLnqhApFWYIZxo2Ugu
         XDIA==
X-Gm-Message-State: AOJu0YzyVzNol5lkHAFeWFSMeY9tS1CbS71njLdqpAIrg+W8qz5KkdXA
	R9CmXxKE0bwT/Q8n9ZOZmVW1HistdUn+HsguXqdDQk1DPyt/nEM0t4frxY9wYylLW/4=
X-Gm-Gg: Acq92OFSrbbbI3fwShL3Jy5gK/5UHqoFje7zOCCvryRAleA+csrMsL28VnmjY3RWCtN
	0rvIE7pswShhyWJDvVS/jMt/PpNZeJnBFfzLFrMUl6EWkGPEDWeyYOyu3WCRxvKCskLmFh8tciK
	idmTArb2g7u342A3OuQ5iRLIsL9LNY7g6Yhaj3qCTd3GQ8U3B6EGc3bhN8LQzST0c5CJL9/Up0y
	MelFexNfS2z0AiJsqX4rtg67f/A8ZclEG7PUPdnNBVcZ7Qs3dQfb8+Vn3HJx4NjVvrfOJMtKmoD
	e3jclMtof9UMJICryghLkIyZEFz2e4PKdu271LIZfs4blKVTw9CeBAAbwdivvLim1S/NvJrG1OY
	tGomn1gWo1YvOwW3U6QOQBdWV1kBizWsv+pKWxzSzYLWxaBiJBM28am5zB53Aopi3KBlwHHgOHy
	xgRRubXwY1wwc9UKD3NjE8fesrmWZL5k8LyP3iYqZ4t/l6Q7vxvE6tKbNL4h7uQo5xGot5rxTbL
	5lxZ3GRDup24pgHG5kgSh7unc+wpMqthjLsh1OPO2Vzjk+naSK4jYrCREe/dKBnPJjbqI0u94wG
	KPTguFi5zI8F24QX
X-Received: by 2002:a05:690c:399:b0:7b2:9347:7ba7 with SMTP id 00721157ae682-7c50feb2246mr17758857b3.22.1778544607563;
        Mon, 11 May 2026 17:10:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66885907sm158714257b3.43.2026.05.11.17.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 17:10:07 -0700 (PDT)
Date: Mon, 11 May 2026 20:10:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/9] pack-bitmap: fix various pseudo-merge bugs
Message-ID: <agJv3lVbud9V7Vxy@nand.local>
References: <cover.1776124588.git.me@ttaylorr.com>
 <cover.1776801694.git.me@ttaylorr.com>
 <CABPp-BGkfavqezk2SV3+K6iF8MLm8j_=ijHiPDLmv_U_o_Ykgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGkfavqezk2SV3+K6iF8MLm8j_=ijHiPDLmv_U_o_Ykgg@mail.gmail.com>

On Tue, Apr 21, 2026 at 06:37:45PM -0700, Elijah Newren wrote:
> Here you fixed the order, but...
>
> >     ++  git init pseudo-merge-fill-in-multi &&
>
> ...then you immediately run git init a second time?  I'm guessing this
> was a stray edit made while trying to fix the order; could we get rid
> of the duplicate?

Oof, good catch. I'm not sure how that snuck in there, but it's fixed on
my end.

> >         (
> >     +           cd pseudo-merge-fill-in-multi &&
> >     +
>
> Looks like you addressed all the feedback so far from v1.  There does
> appear to be a new accidental double-init that I noted above in patch
> 4, but I didn't spot any other issues.

Besides that, I found one more spot that needed some love, which is the
new "duplicate pseudo-merge pattern does not leak" test added at the
very end of the series, which had a wrong ordering, and piped the output
of 'git rev-parse' directly into a test helper.

I'll send a fixed up round out now.

Thanks,
Taylor
