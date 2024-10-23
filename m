Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3064E1474D9
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708211; cv=none; b=HNa/8gSezjHqAGHkRaf9gbxc8tCjZLNV2kCh56/Rr2B2vjrFwOd2UN/nWx1MlGCx7T53XasYhALp64L/w6qPoIAqXbUVwQiJOPYbBnqWtPTloMum76Q9+cUW3YOf/7d8riNQ+zrwZLRybCXkDjA2YDOMr4IHdmaD2RJsJN5pArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708211; c=relaxed/simple;
	bh=XE/nDMbWOPQ/lKWFms7X3jOdi9d9CsmlWITnPGCpiK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olDbc1yc7+tGF9MGBTAVb/8G7RcUegHdupQ0OnVESleDK9TWGjdp8IM6qbBYpn7SQbkKQRRGEVuhTtqkeLXBc60hXNTyDy2SMLCUiFroOQ2/IReUzfEc5cUhjzmkK1LTpU/3lzN9PwMZIWfnJ5PBcYyruMawoJIlzvWn5KKbkvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=E+xNeB2f; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="E+xNeB2f"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e3c3da5bcdso436977b3.2
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 11:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729708208; x=1730313008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0wigY3pjjnM8igDl3tVIll/zdlg+QhATLYMx5F5p1uI=;
        b=E+xNeB2fpR61wAJ3vHsYR6ynoABKQQIz7xNIEaYFeXlfdIje+iyaH/K079VHrzHWng
         DKdhxVhG6Y90btV9VXmrpRWCOkwY0doiJ3jhQuhgQ5PMbwAoTgw2QXrORVUtUwov/2VZ
         uXuLwx1CL38IV9smNUygdHymgYsngNrHyQDW+EZJ9Zvf80SxoYbwsGkrQ4YgkfA6Kaj3
         T7Z9nGpvM4KgvtqkMMvkm8HKwCf0hbBrJhN2zo+rNdmMELez+EdevMsWAiUP6AjPccEE
         //1neSlTUUbf1b9kEszufw2htIA5n5IuT4J9o9NzlFu/QxoVh7AfUSYV2UIkfh+IgD1X
         yVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729708208; x=1730313008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wigY3pjjnM8igDl3tVIll/zdlg+QhATLYMx5F5p1uI=;
        b=lc//fDV37QzFOAzKlbCE1x3O0+maPanpco7Vw4J/HfWLMlba0h68A8q2UVo7FwNG9P
         FKFQncXx2fc9KiXGExhjVA81rGaXYKebCAZ3bBiDOXMQtbjr60ZV85mQb/PiKa0KfQ79
         bl3+w0KBPdC7O7keE6MAOWx48Xc6N85xuZ6OUvhUjY75IjENE/0Pmvbg84WxDW+Krcvq
         D5xO48UqaGEC+seKfa78FzllAnR/gQMDpFvYpPFtdwvnAPrPJZvgO/8PoAMI3QExMxom
         BL1jgi+ecmJZoAXZUZszdUJlHoi0Fxt5R7ZDnxR0z8WcfQijVuJSagSYWQgf8QssVw+D
         jppQ==
X-Gm-Message-State: AOJu0YyyLWWQeSXDDNSyglIZxPHYHcELYIL65aHKuuUOXd6nuae5XM/4
	28O8YJzSQNOT6w2fXvLFYVRVkYwBGLSLTxfRObZgBY8G6RhqRkfCt9wjMbfubCM=
X-Google-Smtp-Source: AGHT+IHuFcUE6ps+6cnE28pZjb6OboKg5XU9BvPoGYKc3QyfzWYvz3yc3xitQxLhEzN/xWKnDEGQjg==
X-Received: by 2002:a05:690c:6508:b0:6e2:ada7:ab89 with SMTP id 00721157ae682-6e7f0ed3a28mr44004437b3.26.1729708207949;
        Wed, 23 Oct 2024 11:30:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e7f4176c90sm3896037b3.100.2024.10.23.11.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:30:07 -0700 (PDT)
Date: Wed, 23 Oct 2024 14:30:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] compat/mingw: support POSIX semantics for atomic
 renames
Message-ID: <ZxlAriZuYZNrOWJF@nand.local>
References: <cover.1729695349.git.ps@pks.im>
 <d17ca1c7ce38e12fe113f15b078c12bc92e8f0aa.1729695349.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d17ca1c7ce38e12fe113f15b078c12bc92e8f0aa.1729695349.git.ps@pks.im>

On Wed, Oct 23, 2024 at 05:05:03PM +0200, Patrick Steinhardt wrote:
> ---
>  compat/mingw.c             | 87 ++++++++++++++++++++++++++++++++++++--
>  t/t0610-reftable-basics.sh |  8 ++--
>  2 files changed, 88 insertions(+), 7 deletions(-)

All well reasoned and explained as usual. I'm glossing over the
Windows-specific parts, though they look correct to me if I squint and
pretend that I have even a passing familiarity with the platform ;-).

This looks good, and I am glad to hear that it was tested on Windows 8.1
by Johannes, and on Windows 10 by you. Do we have any reason to believe
it would break on Vista? If so, should we test there as well?

Otherwise, this is looking good, modulo the handful of typos that was
noticed earlier in the thread on this patch. Thanks to you and Johannes
for working on this together!

Thanks,
Taylor
