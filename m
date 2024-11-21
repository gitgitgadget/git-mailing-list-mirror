Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4821DE3AE
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732220148; cv=none; b=XjaWiTpHPQ/UZgWhZ16jPKe13sb1BdagI+V+Wl7pXpGvu+OHSLzGT1WQhMBCimrDTrL1H11sHdqw6RvU3zf7BhAp7ISuRftgYgap1x7YMnvPTrcY/yDLHcihNqG5Cd8d7/gfmE68oeSJ8vleO9fQO+M3gIVo366XXtn9FGX7xWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732220148; c=relaxed/simple;
	bh=WV9qoKYv+mj8fnVgd/uQ39jNBVDst38bRS3qbOCkF7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oj58Qwi2weBMQg5JLlIAawOFQXgNikZaGAyVofunfPUPogv6je+imxXJFcYFFYFoZxju2Bmas0+Vl8mxLKgOUTv/ehTxd4OnN0F+BQffOFtrG3oNQemVFPSWw/ThGU8GE7SoI2xKNWgKfEj8Y6OnN3sgIwdJGmfA7WXToe//7IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Vudyhp7l; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Vudyhp7l"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6eb0c2dda3cso16439327b3.1
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 12:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732220146; x=1732824946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wu2ih8+zgZUJrpjuE/U3CZewvB8KnhJEbrRWT/xS4aU=;
        b=Vudyhp7lgBSiwgIjM0LDiyFVaMrHJTdKt5sZKNSR08CrU5xfEZoiXj70ZNRe9bJjI8
         REU9W84gYiOUPNrUU1PUDQ7QuPbyhFdhoJLDO6dBXvikPvLp0IXG3Lkqp14+gdPojAEa
         1rwp4Tko/IyJ38uwdaIWdgIZJQpCkIhEJnHehyQmJLC8XN7xRiTJVKgcMy6f93fyiHpc
         t0qivHyoo7/H5XMfZiB9/JjJk++o92nqJrKsAb5kFE/qSuXbTwIRxa4iwVvOvg5yxHm+
         KG0UBXxu7ipsi0HtIU7reMZHFwSu4hI+CG8F7503YoJSg+2QQuYhMIQZR7385V0N9Rz8
         ydYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732220146; x=1732824946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wu2ih8+zgZUJrpjuE/U3CZewvB8KnhJEbrRWT/xS4aU=;
        b=LvpFyDAKVRnkvOG2Y518Zi1Ku0U/ALN36PEcbvT7CCWQIikd3gZ3zO6h/a97Zaf5JF
         gr2NLVlZuuSeRSBnQYQOj0c0o6yPNJDF8XGF/hcHI1QZ0tizHrSqvyjecctVGzuS+FaU
         77S65mBx4QuW6FFpj8joPEzx/VMEX2DNPPaW53PqMt2ZtY2Vgioc2qzCTzRVo412aA3y
         0FDMbEDFTs2A+V3RT2YUzzR8J2gt0z60qvNYl3M3uuUbu+6AHo8cp05OKl+bugTngQ1t
         tqJw2KdMm2mg8OqKZJHkGbXVfE30Yy9xsk8E6bEOkdCLNAxnRqIUhlCtBEsp05i1QQbK
         LXNw==
X-Gm-Message-State: AOJu0YwajRKSDNXk/I3V4F2V15sW7ALaNeAp59SPz2NatGjkbicpVjKQ
	Xe4o6o1iw+RYS4vmIL1SPaw3BYiCtEGyaSrZaluo0bDPAH1rD00wGEIJSe4JNVs=
X-Gm-Gg: ASbGncu07WZ8QI1cWNe2swhi1X6cD5mSvymUH2lWvSjgwsxix1AOiMc7nwAulkB5B1S
	7IzUNAIIzeF9xqvimNh+Xw9CLGWJx+zsK+8Pf+htKrD4csFii+PGGrmch1R0fOi4Bh1Yi3/4RhO
	vUobSdV6vAJB3a+U/RKMqnaqmf39ddoJDaee4U4Nq5ZTW47PahKz1gvpYC4wmbNJKwB8tmt+Gg7
	AjU+cTXnLloPXJiE+KrvDThk6R22tHHglG48NJqFgjZJFmIMQXOrA0Bwms+PBMmGGs/cSGcazCl
	sbWDoh9X8t/vy8sbWd+xDw==
X-Google-Smtp-Source: AGHT+IFpo9hS7d8Xj9x7OkXh5bKMBtSZ3GQYrJfqQjZ1AdV6UolVMvKmm3ky4lv1OlUHTg09RQdMEw==
X-Received: by 2002:a05:690c:6213:b0:6ee:74c4:7cb7 with SMTP id 00721157ae682-6eee09e82admr6567797b3.21.1732220145827;
        Thu, 21 Nov 2024 12:15:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee00823desm1063817b3.79.2024.11.21.12.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:15:45 -0800 (PST)
Date: Thu, 21 Nov 2024 15:15:44 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/7] pack-objects: add GIT_TEST_FULL_NAME_HASH
Message-ID: <Zz+U8IyHqBNRIn6m@nand.local>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <259734e0bcea952c2c09b0fb3a017e139922b975.1730775908.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <259734e0bcea952c2c09b0fb3a017e139922b975.1730775908.git.gitgitgadget@gmail.com>

On Tue, Nov 05, 2024 at 03:05:03AM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 2e28d02b20f..75b40f07bbd 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -30,6 +30,7 @@ linux-TEST-vars)
>  	export GIT_TEST_NO_WRITE_REV_INDEX=1
>  	export GIT_TEST_CHECKOUT_WORKERS=2
>  	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
> +	export GIT_TEST_FULL_NAME_HASH=1
>  	;;
>  linux-clang)
>  	export GIT_TEST_DEFAULT_HASH=sha1

Hmm. I appreciate what this new GIT_TEST_ variable is trying to do, but
I am somewhat saddened to see this list in linux-TEST-vars growing
rather than shrinking.

I'm most definitely part of the problem here, but I think too often we
add new entries to this list and let them languish without ever removing
them after they have served their intended purpose.

So I think the question is: what do we hope to get out of running the
test suite in a mode where we use the full-name hash all of the time? I
can't imagine any interesting breakage (other than individual tests'
sensitivity to specific delta/base pairs) that would be caught by merely
changing the hash function here.

I dunno. Maybe there is some exotic behavior that this shook out for you
during development which I'm not aware of. If that were the case, I
think that keeping this variable around makes sense, since the appearance
of that exotic behavior proves that the variable is useful at shaking
out bugs.

But assuming not, I think that I would just as soon avoid this test
variable entirely, which I think in this case amounts to dropping this
patch from the series.

Thanks,
Taylor
