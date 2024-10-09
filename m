Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8FA282F1
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488833; cv=none; b=J+zlUR8NY6nKjozc/jTC5jM5W6wMHXAnIh7A+TdwNtAP6XciIOJSXLX8YriiICsu1/11MvL+BqwWmYQnfnaB0IRpduPIoEBuXAw3nmhWOT8sAf4uBaTsD2yjh7m1SsytFhJiKyn5/pGdoUihbyugZeBaRroBLXPC+Z9knoz/iHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488833; c=relaxed/simple;
	bh=3xG1bz4UuvsvsoGznkLf1Mh++AeydPsdBNl0/RNtOgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKqt+WBKQwtlL+UTQP//ns5XS0er/HT4jobXThPZMGEocEc7y90BmvC8nMYR0ZEsFoA6kYpcefzdI0V1oWlIUp6gu2NlDdgzt2P63DJOfbdQiBxqYLQaW3pyNBPr5GPulDMF+ajwYFAtXLjWXvx8SHbPz8YVST4SsQwV90mQSd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnSVlRny; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnSVlRny"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-716a5b9ee6fso443893a34.2
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728488831; x=1729093631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3xG1bz4UuvsvsoGznkLf1Mh++AeydPsdBNl0/RNtOgA=;
        b=EnSVlRnym3gpDX0e9coHicuNlBGTXO02QA+AEdSR5bc9lKdFpxtBs44haNejAAhvvG
         /fo+ao9bN3B1sZ9E2nw5/b/H8T6t1+t8CIxNkdGbi/0aj8TzptuCHAeGUun+qtndpkTq
         NY/1DSM7pvfKYRrwVo2Uf0Zo+faO+xKu2cMTweLYYtg6ggLgBg2fliQduJBeI+tdWu4F
         QeqLJ5iYz46QnCufTR83Vt8LrAsYKyff5++hrdkYtEbFP9iLPUQP/acKagQRWSQ/mtqZ
         7JmVdxeBchQcqEx7baqbv2m2GgXQyrMrJdk8SBsCYQN517IBCVAn806y3AU1b8C3GY6H
         2sPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488831; x=1729093631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xG1bz4UuvsvsoGznkLf1Mh++AeydPsdBNl0/RNtOgA=;
        b=HRtdWLLzrVuMGQ5H9FD9pIjsKVElsfljcKFzPvG9mvR/Vumo8UpsBbgq0m1MVUee9X
         vVF9nqsub38S2Pv2pSaxQRoXX767O8OIJgf36rc57brisyJSvNF0o4psBz+StW/ArLMG
         5kYu2Oi+wGF5psBRgP4+GulP2Sh5ZNvBYnJ3oweegKTRtuwfmVDsVZD4FV8BGoT9Y6sr
         QHk7yqIGkCvg5aMRKaVcFz/7eigjJn+A4bBxFiPyvZlEXXnXTU85DXBA5zOh2zxzaraT
         M8UGbtK8rZugoWJIM6FLyY1WZZDJNwIP7eMYBDq/BO7CMwhE5N9eaRpTvaMQppGTjYmf
         LSjA==
X-Gm-Message-State: AOJu0YxmP5vmzyEA1Ml87+ea0VRTH4MyTitW1uQIz9lkrHrlHeZFUVmQ
	XmZ5gEYGG3HNJ2yV9ZKinMd/Sc1QUhjm7gqmtPnb47QEZwhw4IHk
X-Google-Smtp-Source: AGHT+IGmT/J6sjms+Y2C4t/d2/MFUdHWg4iqOAOy66OPBhn15wl9+MPPxn2q6tFdtCoUFpLywo40fQ==
X-Received: by 2002:a05:6830:f94:b0:713:8387:9f07 with SMTP id 46e09a7af769-716a404f9e2mr2354676a34.0.1728488830796;
        Wed, 09 Oct 2024 08:47:10 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-716a9841cc2sm62748a34.66.2024.10.09.08.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 08:47:10 -0700 (PDT)
Date: Wed, 9 Oct 2024 10:45:45 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] clang-format: don't enforce the column limit
Message-ID: <zmqyj3v2h3hswoujpz2er5luvjipjl3i4ts6xjdeb43wp42xf2@i5xee2lsmriz>
References: <CAOLa=ZRvFBhageS65uE5enzLBz7H_CAvvnEcPsi_QAi0exRx2w@mail.gmail.com>
 <CAOLa=ZS+naxOzJUkLLOZk++WVZ2dt3eQq9VmW+G-5O1ZLgggUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS+naxOzJUkLLOZk++WVZ2dt3eQq9VmW+G-5O1ZLgggUA@mail.gmail.com>

On 24/10/09 05:55AM, Karthik Nayak wrote:
> The current value for the column limit is set to 80. While this is as
> expected, we often prefer readability over this strict limit. This means
> it is common to find code which extends over 80 characters. So let's
> change the column limit to be 0 instead. This ensures that the formatter
> doesn't complain about code strictly not following the column limit.

The column limit does lead to quite a few false positives. At the same
time though, in some ways having a tool point out all the instances it
occurs does make it easier to review if any should be addressed.

If the goal is to have a CI job that we generally expect to pass, then
it makes sense to remove it. I don't feel super strongly either way.

-Justin
