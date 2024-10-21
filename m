Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B325010A3E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547032; cv=none; b=k1C/K1EBl8pkPgdg/K1jKHjTo12th62z3xHDcRJDwk5rF+Lnr/CjRZqhcDrGIpGNEC1IrM3q0hoUjQ9wjip4OKRURceI3PEqOWDRsoYkV7zKu0turFWP6rDqzKNO8MGUKVj+iRNK1wqJikkmzrblH8kEhAn0e7urn5CgosoY478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547032; c=relaxed/simple;
	bh=isT/FtjiS59A4BsmrDgG2IepEP5XM4u/pWYY28SnnK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzNDwOjIFDEVE1c8KOAeePcF3zQBDwyakxbDG5XHeIV5PvYNdOKx8OXlmKCMP4yNuDGBN/aG79hP1Y+LIaOzQZ1c77vK0Yr6ylS+/0TV4AxpPHOKKiazRBzvLiTH5LC4kkJXCQZAjHwDSV0cv5YsRTL5c4IFmyO3bK3Wusu+JFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VZFKazhs; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VZFKazhs"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e3881042dcso44222127b3.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729547029; x=1730151829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OkVHxt75CXeLvBxL2jbbhmCnrSDpR12gn18sg5jakiM=;
        b=VZFKazhsRNo96XTL2eK+h1L9C7WP5F2l0hGVhdaXt2BvZ+z71p2FH47EDJBapS3Irh
         cQun0zQEm+awJcUepc0xI1GKXpVJmysoThURD5F/+dsXXMKaI9lvCh4GCGrWoODRCnEY
         m12kTvvqYt2/bqngfDt6tjqRvGhnolJ7CTVGDccLTFGCilww0p/FGfZ7JCdvbJUxlgcz
         Qub8aYgvipoW7ZrD8ZNU946vTOK3P3ljMgUQkdeaUDFJV4g1FcJKafob2ONxR0CsQFUi
         GmvgnocEHX0s7qIyaPsUAZxpcW+K8fz8cGZZfDXsZ/Ed7l+Vb2CEt3+XkniIsA+ZbgRi
         WmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729547029; x=1730151829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkVHxt75CXeLvBxL2jbbhmCnrSDpR12gn18sg5jakiM=;
        b=mT7HtcWNd9K71WsKL4+1hdFJF8PhT1ndsxJAKiX4baekGe35v//zXGuBm0kjKOdibn
         LdvT0t/Wl2+LxCZ5qaWvEMfwQkofsP/g7Suk4N+QkNt6eFE6/hhVGhpP7OESSwx7tq4B
         4Ks/1UI+sEB1ULv/syoSiGYC94JohcS5y6+XNFwy5fASP9+QRkYlIC/0rw2BVzybqmPx
         sBSCRdQTjhq82R1jru8wfsPjruFm6QrTnRRzeciyXX63EfyAGmqrcXP1R0r5AUgD9SeM
         Wf0k/MZ9Z7QQNwczUXJYRANTE3zS8BMixImxEtEzIPOnwY7xJDKbdToLcGYFvGNweoZR
         EqYg==
X-Gm-Message-State: AOJu0Yw+oYvK+sFDXm0aVhTQ9BzwqliRQowcJ1+uxiRmVbsCAgp8Og/u
	f7vw8IIEY4/9gV5WW5CuA/AKJVQIsI+F1u2ULk4m963LmMkNdfarwg9SDa0Mq40=
X-Google-Smtp-Source: AGHT+IEHTrgfm8J6ygVF9LpzMO+l4IwV1EoHnMKYXVmoXtrGbWnRL0gXtkh749DhuseapAOQB3iQBQ==
X-Received: by 2002:a05:690c:7446:b0:6e5:907a:5170 with SMTP id 00721157ae682-6e5bfee7accmr126667757b3.43.1729547029594;
        Mon, 21 Oct 2024 14:43:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d6f91csm8224977b3.140.2024.10.21.14.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:43:49 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:43:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 00/17] pack-objects: add --path-walk option for better
 deltas
Message-ID: <ZxbLFLDgCm6wLmB9@nand.local>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
 <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>

On Sun, Oct 20, 2024 at 01:43:13PM +0000, Derrick Stolee via GitGitGadget wrote:
> Updates in v2
> =============
>
> I'm sending this v2 to request some review feedback on the series. I'm sorry
> it's so long.
>
> There are two updates in this version:
>
>  * Fixed a performance issue in the presence of many annotated tags. This is
>    caught by p5313 when run on a repo with 10,000+ annotated tags.
>  * The Scalar config was previously wrong and should be pack.usePathWalk,
>    not push.usePathWalk.

Thanks. I queued the new round. As an aside, I would like to find the
time to review this series in depth, but haven't been able to do so
while also trying to keep up with the volume of the rest of the list.

I know that this topic was split out of a larger one. It may be worth
seeing if there is a way to split this topic out into multiple series
that are more easily review-able, but still sensible on their own.

I haven't looked in enough depth to know myself whether such a cut
exists, but it is worth thinking about if you haven't done so already.

Thanks,
Taylor
