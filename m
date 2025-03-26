Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A10C137930
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021336; cv=none; b=XhR/AMRCgCqmdUA49GobB8MO9Dy71sVWZOUoCE3hVynuYlXYgIi7OF7AZ4NXZH7rkosoJPQtnwYciAKH//rZs6hj6C7bbEPblZsn2wGsXMxXB7qkS4YaeBYdUXdBs7CE8aG1x9Pjd2iuDmIAnrk5hoIgGe4woH+k/9aT+CATQIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021336; c=relaxed/simple;
	bh=s6GWXtmQYpfVg3+uhvBJT7zBKGFpUmG/T/mSMsO3elM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FulJxN13SWy50dzoa1DGPbECC+BqAMJVIpohB+rKSwCBy7kDDcfySy6nqGMJDb+o72gv759c4bGoIMHJbrzJ4/cvxpna1kpOU0zcWDs2rb7BTPiEe2BLxS4dBWHSXhCWgliIgkY7+snxiUmmo7nyPFS4EdlW9+7BGLoHlrzeVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=XtbSpfNp; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XtbSpfNp"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c5e2fe5f17so28644585a.3
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 13:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1743021333; x=1743626133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2zTTf9MmfSaWen9Z4CZPRpjj1tbxRVHDtBpukfedrSQ=;
        b=XtbSpfNpu0d1KQeQEDbHnhqwPsNS4bLNnnpuXQ1H5uliOYsCwgNCb/p4aXLomR6zV0
         BgLIFsMqi/4+2uf2h8X7WmphQTDX1Y5YF+kEJDuNTWkHR0uUmBMEvgHldp7LFcTKFv5J
         a6chM/clTEp75bwXOtCoCgzr2wkTaQH0VGndz50fmlmLe11TRujEUK4H8tb/ozjoKohw
         fNo49Wm2f8WaSKwkbACeYx93DQo/ap490usNxTGqjwnkAJdWmk6IFe+w+FTLsRH+WNE7
         U4oim/5ZU5w873rrYXEflYg3b0huatPmMrF1KnuvqMm8joXf8iLAgNZ2vQ8j6WakCxeI
         VtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743021333; x=1743626133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zTTf9MmfSaWen9Z4CZPRpjj1tbxRVHDtBpukfedrSQ=;
        b=ekOt5g9kGpUiBVdfM+lhNb+Q7aRXIJvxG80OnvceBr5JfO8HdVN67J16uA3FnfQ8Ny
         akb3yYc9LdsFvsV/6bvNuVQyAtg4VN73lEUfOz2voQsY9IsXt1LfDpusPuffKNI9Np3U
         rGo9AcpUNPmyzhBRmRoVhrzwSeovhWmigzdqsPehKgonDjqz3zTBYWtLgDEEAm52eswm
         uGKHdF7P8UFm5SZB+71PMG5WEhqQ4HCCkZvMjQu9klAICp7X09wSE0/JczRbUoPRBvEc
         lZ4aP4mDHW1Aw5BqHET6RK8fYhzTtWbzmYHjLnLOKGaWMOIhic4D4AHgOOhUbFb9WlSz
         xKXw==
X-Gm-Message-State: AOJu0YzK6WAz0x3vDS9Ly6IXB+6GiMT/vcz2W7VYp3sA2/aMYp67NzS4
	mlAP8LgjhkKCrk/qBBrBK3Zo67Jw3Iw1zRxhlSoU7suXCiLNqXdI83+grxMrSQw=
X-Gm-Gg: ASbGncu88d96Vt9Ks1SjqWsKgucosnHXFU8ugcb0kHBuyJeePWjIfDDbpDgYSi7ec0k
	0DIsgVlljSByeGQRJLGFVw60CziuAe9eWW5GCfv1yO1WV1lTk5ngzNpDvmyeWsoLF4JMLd4OKPL
	lSNa/Leb93w8MIiyLkRar39nSwNsl8ZlENQrpSGFx1EL8XXfzF8fgu1zzmTWsL14CU1flDTwoZK
	n/LeWpEL1KfRrZW3wjAea2wAYg65BUBg6icTwvb4KnbspjatSIGhEkJoVlTLarUX1iHzYhSzKFU
	wFIxk11ovKabL9slKg8ZIqCr2a7cBfLKD2kMyuYpjxZPwoFvSK8hzl8LVjss1GMOSBsRO0CBn2M
	KtmjnYR/d/+l8Oje4
X-Google-Smtp-Source: AGHT+IFE5QOfB93MfthWn2C4SW7PtkvYHXbEPo2tw/fSqfbjt/IDtHXr/AcRUsoJ27xPp6pUyPbaoQ==
X-Received: by 2002:a05:620a:2402:b0:7c5:4a8e:b72 with SMTP id af79cd13be357-7c5eda82c6emr140925185a.52.1743021333203;
        Wed, 26 Mar 2025 13:35:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c5b93484c5sm804881885a.79.2025.03.26.13.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:35:32 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:35:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 08/10] compat/regex: explicitly mark intentional use
 of the comma operator
Message-ID: <Z+RlEwwTvFkUWwkT@nand.local>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
 <dc626f36df34df4897289e508dbf608512a93870.1742945534.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc626f36df34df4897289e508dbf608512a93870.1742945534.git.gitgitgadget@gmail.com>

On Tue, Mar 25, 2025 at 11:32:12PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
> index ec5cc5d2dd1..7672583bf7e 100644
> --- a/compat/regex/regex_internal.c
> +++ b/compat/regex/regex_internal.c
> @@ -1231,9 +1231,10 @@ re_node_set_merge (re_node_set *dest, const re_node_set *src)
>    for (sbase = dest->nelem + 2 * src->nelem,
>         is = src->nelem - 1, id = dest->nelem - 1; is >= 0 && id >= 0; )
>      {
> -      if (dest->elems[id] == src->elems[is])
> -	is--, id--;
> -      else if (dest->elems[id] < src->elems[is])
> +      if (dest->elems[id] == src->elems[is]) {
> +	is--;
> +	id--;
> +      } else if (dest->elems[id] < src->elems[is])

Should the other arms of this conditional have matching curly-braces?

Thanks,
Taylor
