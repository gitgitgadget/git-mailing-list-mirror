Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6D1C7B83
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543511; cv=none; b=IVFCXXWY5jljpSEC9RqhqZOOQbgiu52Zz9Kl82U++KIifxyv8YF6r56CKaIdOpvtGQw7/ncKPQy7w7Q//hrW0c0UfwrrkKEcPTcpfSjn5nW++ntyetboQGHTRIPebQgWWg8u91smpnND+eFsV5Hbc8lvrDXLcAMZ31D61jhp21I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543511; c=relaxed/simple;
	bh=lsBWLX0HrTkEaZ390aSupR+URKJ3h9t8OQVYB8/Kqgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5MyiKtmn+kBeLipl5qtiTjn90YSpaKFzSGM4MWVI+LqKB7F/JRLwewFtoA3ETTRNmApMYPk35ge8Ssix1ixzNTAkeQtBMi46LGnA9BQaXbsLaQ3JJMbxQOsdacgG4jUpCe5hNPgLmZ1DoLP3iFAhKe5+6SSYVfogRY8RcPfJ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=OPPCjw0a; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="OPPCjw0a"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e377e4aea3so45389777b3.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729543508; x=1730148308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lsBWLX0HrTkEaZ390aSupR+URKJ3h9t8OQVYB8/Kqgg=;
        b=OPPCjw0azZya60vjOF3r6kC8zxlcB4GJJG69f9Y04cbe43LJOYKXvcdi6NM9yl0FiA
         nhAXUPrXpcIYL7tLq+oprpC4EPiqBTEymXAkF2OstV70WYGQpl12hGU+GOrctkMTEHWb
         rbUdPcZ5g80AFyGh6R6YlaWsJBmnXWN28SqGA0U/gNLw9qcJzF2+6DP8EXkQIoedOvFy
         FWU2d5UQ348N2gguFeTNPBz4gXPYL5ve6wmDY6CpzJlOpFLpWiFJ+5+AkSDM3mpDMMhB
         tG0Fp8kWbi5EOGCrJJApqkdOS+qIMDgs9vu62f+rPU7MI9OfLSZP/Eoj4FubK4VqAVUB
         vOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729543508; x=1730148308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsBWLX0HrTkEaZ390aSupR+URKJ3h9t8OQVYB8/Kqgg=;
        b=e/50PdVjS3NjY+3zRHhjEtbSlXR2nsx/R59t4dIpOXZNwAhzDazJfAThPtbIQO8MTo
         36dvX2+2QKFICE9XUCjIFQ0Bjds2BvdM9mrzFVG3RYUe5HidH4nRaGzFthhNQ8/Mzq7m
         XC8cZRNlmUuUV3B7tmPy7QhlGtY1K/iW4bIgQVMZ8EGhBBCUvyFzftE23rrv5FciVAg6
         DaEXtHE2ebtiaec9JbHoKFpkTxSbsejyoDwLi4KxcgbMjuQf6cgt6UPasjg2XishC2FT
         V4MOVivVnmIA6joMjUVg+YYIf3vOPmIpapbl2BQKpC15d+paOJkC3Gg8cZAHo/fBoXoM
         gVPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6SDAyz5eyIxrchSjRpOxmlp0obhGJQX1PWsnPo+rj/G8mvmkWH2YKjWbln8u6gqjhrv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIN0txgYrQvbcom9vGvAcUdH9JEcNzm+y3GAn5pB39/hMkipss
	GoHqQ7fdQ2gcyedZYV+l52Oh+emC1GP1+OElXVg1JjThmG6HC2VTqDTNAbB7eBk=
X-Google-Smtp-Source: AGHT+IEIZsYTbqPgpaPs1Vg1LwEoJt1HuRVoEr6kQtjvZ67zLjiPHC4i5BAiIhKyGRQ95Pc2pziTfA==
X-Received: by 2002:a05:690c:a:b0:6e3:2b5e:918f with SMTP id 00721157ae682-6e5bfee6b41mr123643567b3.44.1729543508643;
        Mon, 21 Oct 2024 13:45:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d6f999sm8095677b3.143.2024.10.21.13.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:45:07 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:45:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Victoria Dye <vdye@github.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] ref-filter: format iteratively with lexicographic
 refname sorting
Message-ID: <Zxa9UvRo9HcBM3YW@nand.local>
References: <a873ed828ccae426214cc8f87610df97ff9a269e.1729055871.git.ps@pks.im>
 <ZxA6I67FfPe4fV2F@nand.local>
 <20241017024828.GC1858436@coredump.intra.peff.net>
 <ZxCShtdTlv7t5fYy@pks.im>
 <CAOLa=ZREg3xuaT6mbM8+Havn3regZDhK45kGy0+Fw8t56c7Mpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZREg3xuaT6mbM8+Havn3regZDhK45kGy0+Fw8t56c7Mpg@mail.gmail.com>

On Mon, Oct 21, 2024 at 07:36:55AM -0500, karthik nayak wrote:
> > Mh. So we do end up using `refs_for_each_fullref_in_prefixes()`, which
> > may or may not end up collapsing the prefixes. We do sort and dedup the
> > prefixes via `find_longest_prefixes()`, so we don't have to worry about
> > e.g. `git for-each-ref refs/tags refs/heads refs/tags`.
>
> Tangent: This sent me down a rabbit hole, I wonder if we can do better
> with naming, `find_longest_prefixes` calls `find_longest_prefixes_1`,
> The `_1` doesn't help at all with explaining what the function does.
>
> [snip]

This is actually one of the examples I was thinking of when I replied to
you in the other thread. find_longest_prefixes() is the entry-point, and
does a little bit of setup and tear down that is unique.

But the recursion happens within find_longest_prefixes_1(), which does
not want to repeat the same setup and tear down, hence the split. I
still maintain that _1() is a useful convention for differentiating
between the two, but I'm fine to be in the minority there ;-).

Thanks,
Taylor
