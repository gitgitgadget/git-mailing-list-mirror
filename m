Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF38946C
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426642; cv=none; b=cCU866KuDmog943U7awYotcIkkMPR+bouIUeGk6UlJ1ZLLY9RXtza2OTagsFzKneTdf+5SetVRSzVWIF2IVu5LHqOvnwlwUTFFAZpcpwTRzmfkbtmYGThW/S1DesqClkr7as+aLK8oX0RAHdnmox+UP2hg+DNOWyFBQDUdjJb8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426642; c=relaxed/simple;
	bh=2431tFRq1vuHVMGBEY23kH8z8r58pjsjYpf5dYdKfrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDGapGfM60vKI5CwQJc8pZ7QNzWlMEF6pwHuQBr5BCgPF3tfu/dlQz0SuYs5U4g6C7ASEr7slKr8/upvewIRqWpsUME12vQSoL4S0oNGKcYDhPo34dr+LT5zmjZBOcGNRwpUvuOw2RNaPWochWtEW2eMdAm7Fryv/gnsB2Wt9K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kb7gt1jN; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kb7gt1jN"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ee4dcc4567so595314a34.3
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 14:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714426640; x=1715031440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nOX65HtLYYh/p7HfMSsh4pesC/udP6rmlY4NN/xTVpE=;
        b=kb7gt1jNRmx7MJyCQKapiQnJsJRvd3GWyjRb4soqkpYvcAxvd4Zse2J/sJk/1i3DSn
         W8wJOt1A3YU61QdlXFZ1Tn1WMcHBNtw/VZ2j7A0ZVhcKSRB0IORnbILt7/B474u60iey
         eHOg3vUH+3QHbY9dybPy78y+ziCU6AWpos6FdPecLEfW1yS38CQILqJeIAUruH4PZHCr
         5ZQrI/AW1N0+ZaENchBuuWlfZBmZr1fb4Qh2oNAUG4pzsFVsrH9q4kgAg43Yj4AHj4O+
         3qn+Q5uxGBDuRzkspIMwXmdfw+vf/b686/HIcCN9kMbuaHfeKOJHs3QHIeJIRaFQ2bz7
         Fpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714426640; x=1715031440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOX65HtLYYh/p7HfMSsh4pesC/udP6rmlY4NN/xTVpE=;
        b=nh6qmRwQ87XWgONCfppC1ABatjQpAMnS4qg97UQerBvJu3mLESVrpopFvW7YaYchu8
         7aLiPeQGbim81HaTgV0I79wbm/LfadRLxsTTQvf/PcR08zzR7/jXobNtkCxfrN19EXCR
         HpGWhiXjN4xnPlsFNHJO4MB3BKTxyZsOu5aCto5rKwO1ZmuvXKBVqSnRXVjwHSugcJxX
         +auKG3zqldSk4ENxgOcoBblm2bjkf5z+pRI5MfgC0sKeg/oRylxZ2ZU19+QonWU+ZWyc
         2hL8AgO3RblHysfbvUgGdYl2a8jqDeGjmbQmViFNOdYBcdr6nDmVshrS/v21nd0YgEj9
         /9LQ==
X-Gm-Message-State: AOJu0YwSGFS6BkpBYpfwtD8d8ykgJp9Txdnz5m9JR68SMIvgtN4/yT6F
	xGRGxhxepfZVwy7GhRRjK886Q1OQR3ux1a0y6cKdT3yp/71HQ566UQvsOK003xooB17ntCs+J+d
	J/xM=
X-Google-Smtp-Source: AGHT+IF3omDQfWHBtGcKi5e0iJj+68OI+m+QmOfwNNKPIPJ2SmJRG5YAYHn++KIc+bZN4mi1cHWyXA==
X-Received: by 2002:a9d:6a11:0:b0:6ee:2798:4b95 with SMTP id g17-20020a9d6a11000000b006ee27984b95mr5361636otn.10.1714426640704;
        Mon, 29 Apr 2024 14:37:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u10-20020ae9c00a000000b007909ec6a8cbsm4212920qkk.74.2024.04.29.14.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 14:37:20 -0700 (PDT)
Date: Mon, 29 Apr 2024 17:37:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Beat Bolli <bb@drbeat.li>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 0/3] color: add support for 12-bit RGB colors
Message-ID: <ZjATDKqgzYFJVDjj@nand.local>
References: <20240429164849.78509-1-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429164849.78509-1-dev+git@drbeat.li>

On Mon, Apr 29, 2024 at 06:48:46PM +0200, Beat Bolli wrote:
>  Documentation/config.txt |  3 ++-
>  color.c                  | 21 ++++++++++++++-------
>  color.h                  |  3 ++-
>  t/t4026-color.sh         | 18 +++++++++++++++---
>  4 files changed, 33 insertions(+), 12 deletions(-)

Looks very nice. The first two patches are trivially correct, and I took
a close look at 3/3 and couldn't find any errors.

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
