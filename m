Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C71C2F2
	for <git@vger.kernel.org>; Sat, 21 Jun 2025 06:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750487377; cv=none; b=ZEjSqOsHWE7+Mw08+98AArSz+oAFcesiLMo9HNI46ZCds2le3HS5i3HAVi9gi7iK/YdgmdM6wBjsNOonNkGg1RSzVVU+6BIvToCp6kDWOAvqajD/njxHo7plDrZm+gwaXmWLonGeM8N1SxdhZIvcxgbeTPUMutsbj2pVgzrEsxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750487377; c=relaxed/simple;
	bh=fXpu23o9Okd2ZZnt9CQOaY+buupbGx53f6+dPmbkya4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8bmtdXKxJsYaY+3piV5+XwS9fY+/bOV7OpjlC3iOrYkWATG7M8GE+5bnSVJBze56lumvTMmSDKLxVpDuCyj2in4+W4Nd7BKhYnJiRUxicPkeBg3kF3psGhfeWiZqLsXQvfls3os7RkPaXFeIOdfLuteLlYhtPMkbqYGJ12w3Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR+J0cZg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR+J0cZg"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23633a6ac50so35544155ad.2
        for <git@vger.kernel.org>; Fri, 20 Jun 2025 23:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750487376; x=1751092176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WdOQwPd9tp0N7yhM1f5b2z0GIXUX9yay7Vnq7NQIbsk=;
        b=lR+J0cZgN5DvDms6hKLiWV66Af9haFXQ4QhroD4fbuQljk92T67F81zL0RAkujL73n
         mX3Nnr8mKY+7Q690h/XTZjJcLzPNDvhZ3HhohyGhuas4kHc/T62L2f4gcVuJzXaE06vz
         EOpzcoMhVDhHJ9r6WMhewj5INuzb2mnQ7nM2IpBmJPRONKlOOCS7f6Lat4vN6oAvpFkE
         m0Whs1UqQNX5WVB/FkAPF43VtVxSL0JA3etolPbSLIP+vi8JBw7FzOEiFnrK0jK8mH1V
         VZslUNXcV5JfrjA/EDMxPdo++fOKMOdXBUh2jqc0lJxoeDvvDrRG4RHmLuQLrmpq8Bow
         HtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750487376; x=1751092176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdOQwPd9tp0N7yhM1f5b2z0GIXUX9yay7Vnq7NQIbsk=;
        b=FJVBV8wGJr7NUu7TNVSy8WAGn62GV0NaBhegvX9TouSvX4Ba8EEoffJl45ISdjHXCO
         mJuyuaK28GdIiTa+sOFc3KB/vq0o2FO6JJ947ECABLd6+NsYscz31yY6nphSgFuD6Tzn
         o2e3pFhJPtmRLzlvLAXBOCCVGuWU9nGRYvkem9nU4jigg84tIu7UbfsgHi3yqnWbExvb
         Dagay9JAa5RKfI2RWBYZF1nfrtRupCsS5R05OkaDi7NWG9yMcgRqPZ99PNJn5uuyrGf6
         n3FZeTzD6yzY3vJSo7KLcvk9sx9QF3Ba+TX6NGDf/3ReLZ1CPSmnCLC6xXkAO5iMPhkw
         iHlA==
X-Gm-Message-State: AOJu0YwKjAnhtKKsrhqwKeXk1qRc3HhbxMu3Jp+yUDLpltoCJ5RaSSaA
	pW/bfa6IcZ8lJFwNbuWJmGpIr7ZOkya7vSXtetuT7GnrDv7zgllZGmkF
X-Gm-Gg: ASbGncsHeBkPnk/Js7O0B08SOLaoHMLf4Vf3JXf6acTU5B7u4Wq4ywPMXIbyFCY4Mxl
	FNHDMTDn8We+5/FElbQuMW+4V1CbzqRjY+Vx/epQDDyh3MK5mFaCq/u1njQouz4/aZZU0rF6Cdu
	YCSgJ4qFdA0yR9+XjrJTvLjLV0aBLhtcr+H8I39mFeAIaR2UN/VSvr9wt1LiEk8RIYOHzSJqNcK
	y0XT5ZdtZrTJkPadKgRllsKjRFHzF2YCvOznqZ4JZv8COS2SCR7gB38q6vps1YsSdKym6NptR48
	YsmltbyBKbQ1cBvRdbDC5id5rUvRjMVwrI/0LU7H+NENxUl/bZCOzpLSg0DNHr24uTLu7WeAAZ0
	BUJiLDsbvDWrWWQBogxnPfg2NBA1hFGj2tw==
X-Google-Smtp-Source: AGHT+IHlIMlCpFqCwyRxCYaomTjNp0w3uAgv5ah3ov6n4xhLO8Nbk13dVjJ1wrXN701N2NrdUStjPA==
X-Received: by 2002:a17:902:dace:b0:234:ed31:fc99 with SMTP id d9443c01a7336-237d9777ab4mr84050545ad.21.1750487375842;
        Fri, 20 Jun 2025 23:29:35 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:29d8:8564:5418:3626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d87182b2sm33173105ad.231.2025.06.20.23.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 23:29:35 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:29:34 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH] coccicheck: fail "make" when it fails
Message-ID: <jyof56xql2c23gyckxzmry4smkt2uk64lyofqxk34olzn7evgf@ltq5tiqo4qyg>
References: <xmqqwm97bv7c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwm97bv7c.fsf@gitster.g>

On Thu, Jun 19, 2025 at 08:35:35AM -0800, Junio C Hamano wrote:
> 
> diff --git c/Makefile w/Makefile
> index 70d1543b6b..2c17868a24 100644
> --- c/Makefile
> +++ w/Makefile
> @@ -3475,8 +3475,10 @@ coccicheck-test: $(COCCI_TEST_RES_GEN)
>  coccicheck: coccicheck-test
>  ifdef SPATCH_CONCAT_COCCI
>  coccicheck: contrib/coccinelle/ALL.cocci.patch
> +	! test -s contrib/coccinelle/ALL.cocci.patch
>  else
>  coccicheck: $(COCCICHECK_PATCHES_INTREE)
> +	test $$(cat $(COCCICHECK_PATCHES_INTREE) | wc -c) = 0

Definitely a nitpick, but I think using `-eq` instead of `=`
and might even come handy from a portability point of view.

Just like Peff, agree would be a big improvement to have
this changed for usability.

Carlo
