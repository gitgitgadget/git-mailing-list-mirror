Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F893B1AB
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754345105; cv=none; b=nMhZiCvtHWmGIJC+kajDq+lmol0RDlCOERU1yG872sjLnRYB1/Tuyx4Vy5CbC32Lv6avSlLxzqRBPmWPRU5M3pHvvb1jpDLRnSAVLAr8Hlynntzb5kkxFNL9LssYbu+USy7hDOTCggP76u2wjYOKMh9zeAtLcan/9XrJJ/YbI3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754345105; c=relaxed/simple;
	bh=jPLxvWV9JKo+tesq6eGCf/iOMvJH/b8MdHOAGLVSbyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rthhxX38GKqsPd/mEUUc5sjgGurVrpoAI64SgrUZaOlsWpaXUoIjKYIoMzvo+WOn+pWatfvCwOh41svT9cDMmlsaUQ0CSZRXOKbR4C8fro1hty46EOhgKYZzzG1j5eTANFFpHX+zrUYLpiunLM8bVAWh5ba+rkRK8OFsyJYPXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Gde3KtUK; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Gde3KtUK"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e40d006105so23006975ab.3
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 15:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1754345103; x=1754949903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xSALSjD/FNtmxjvbQshMLCICqkK8t++jRM/N+FjJdNc=;
        b=Gde3KtUKootD0Neghd0YT/X4e17ZRJzfRHUXn3PVzWSIa1Hiw0gXhPvxJLJ/8T6rvR
         aDCRdUyis88thMAtvt44jwyOn2Zbb4CuPSbCz2gkcP02hs5Xq1nou3m82REgxz+32evL
         2XYUwsIsNFXEpuD8z+zwXURaZIBSfv8kgfugu9BBK7hCEHjhP/x5be2opJnj35VLwKqY
         upBkAaAj6bi3JlPFUvURXXtAYbz2f9XOjCofiyL22AMGaNoy1F8J2i/91Hrrh9QSmOUR
         rYur0RDX45om4r3ez8FnZFBrmVe/bA9KQA7FQ4XKqYEfqR/3vFjErSVIpeLPY2rlW2Tz
         iykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754345103; x=1754949903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSALSjD/FNtmxjvbQshMLCICqkK8t++jRM/N+FjJdNc=;
        b=mwzyVp2F8mJ9zv5Tj+nptuLxapSA+YqQSVJo7aOyJ+4jIZHcleWbCH6dF5dXXc4Rrt
         Tzhu3lpeYGnEMUXJ453Brf2odjFzAs6ASvuOFOj+2Co8jiXJoI4KZfeqte7PVxaDjENr
         KOmnXpx0z7xrGr+643z8oC6AzAK1nJ7XUNJyfiuUcfz+QeUcnEY+9r8q25EBjo2nKlMG
         G1HbfJaUGQL31YglVTTTUcxCiVHeDjd/ibeidlDMRGKTGE7zRtz9nLVCjWsvOSjLOlxp
         +Pdm4CXD1t+JqSUWnO9MDwQh21icv8JCD3W8mLmWuBWP46fkE2kQeUTvq1vt/ukZOTo/
         SSMg==
X-Gm-Message-State: AOJu0YywMSZRFQVxU59pPnqeBO0KcK6vOz+cZG1G48S6v/pkh+sCNvtS
	4FwrPyT9ylOFFv4j9a8f1VVTASQatcn+Ou61OUrecjEfHG2jV00/fVlTGyEuYzxOsomMSH/Hd+H
	I5a4e
X-Gm-Gg: ASbGncsGeTvnpD88KUseIrcvjHZaK+kIQM0KxuFkwOk3ZZZu1u2fb0FKTEHGh/3sZUv
	G/w2VLAoBHuSUlaOLCfoAMZC6n4S+DQG5q/eQU/ghtYYYyW36oAeAj6turfyET7pg0veACI7ZVB
	ocN4HD7C4SpwCY6jC+T3TuRAK5F2pM9gR3AHxwbUONpoVfQ2p0wg6YIM3fbt+evaJ/LMvWAjSJu
	2A1OSq8EuT2hRiC8P0mH9aQ5Rp3hY+HYeNEfwiLp8FJuw7cVxVly4byedwd/S+9qQxvs3WaKANv
	SsTYH5TqwdtYuhqTXj42VfiTQX+VH8AtY7XWoZf5PG232xS6NH0rm58D1asRG+yJJdsisQjD6LU
	adOVqGl9XcC51F3Z9VtFJZavH8xdqTO3cUr6i8S76f6nzn73jC+CLuvc1WSEq2hwesRuGJA==
X-Google-Smtp-Source: AGHT+IGF9TWmahMfD1cvAH5VntSR5OIim1J6TNxeJ3FqYwB7Txym1VeFEbAMRd3oFDoPsWC14ebk/w==
X-Received: by 2002:a05:6e02:1f06:b0:3e2:9e9d:a978 with SMTP id e9e14a558f8ab-3e4161cef34mr229988725ab.21.1754345103161;
        Mon, 04 Aug 2025 15:05:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3e402acc102sm44425155ab.35.2025.08.04.15.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 15:05:02 -0700 (PDT)
Date: Mon, 4 Aug 2025 18:05:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/9] commit-graph: stop using `the_hash_algo` via macros
Message-ID: <aJEujQnssKDNBWPW@nand.local>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250804-b4-pks-commit-graph-wo-the-repository-v1-5-850d626eb2e8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-5-850d626eb2e8@pks.im>

On Mon, Aug 04, 2025 at 10:17:21AM +0200, Patrick Steinhardt wrote:
> We have two macros `GRAPH_DATA_WIDTH` and `GRAPH_MIN_SIZE` that compute
> hash-dependent sizes. They do so by using the global `the_hash_algo`
> variable though, which we want to get rid of over time.
>
> Convert these macros into functions that accept the hash algorithm as
> input parameter. Adapt callers accordingly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  commit-graph.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)

Very nice.

Thanks,
Taylor
