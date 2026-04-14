Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D89371D1F
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199957; cv=none; b=CUcQtdsgrZA7goNAQduyIZW7DXElYgYkPbAfAkVsPt2m7v+8RTwP2ve+X3OZwdoNE4oLnjbFGf0E9s/i1KudEwPQGrlYi6qgK2aSdfmeKEtaETKgNXxYzsYnx3vvpWh841MU89DURCD1PZn7mbW4dTEA/7fnLsUGcMMwMKIfzmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199957; c=relaxed/simple;
	bh=lZ/6/U+RC4BhESWsYXRIMedOhCiRz//cK6n3sqiG16c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUfWEpy/e/UogqDqRwVGjUYID9fsUlRGLroqdMWjPux+4BVb1Hyw9dwfuiG4qZ5/4xNtBFkSrHIeIkWwFI1TTIZ3hNmZfL9OzRCpnYg3SiQR0GmFriI4uYqa8yjvFTmEgKIzJCvJ43BDlmmelEyTlpc3mSpnxOYKJONTAet8EdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/h+plaM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/h+plaM"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so79777505e9.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 13:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776199955; x=1776804755; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MDaqjRJOVTJ0fmwzLGIp/zbceZP052CIL/kFOBO2wO8=;
        b=O/h+plaMcVwfaw3AbV3E3hZHGcqkMpDXhkm23CLknAZd6WxHHvKqtrPwF/mwVr3iDC
         kSrFzv+xRytHIWDUvi3nkMzjVQx/p7lu+CYrbi7t1Qiug/T2d/jMB6DI8dPDtPdObNDS
         5ZKXCaH6hmHQk+fZ0CgBeoKbBlMtPIMtGErLZhpWEIg4Lo/VEMwrdaV5C6OgcyHVRKfq
         sGRIAo9Z4eO3figSuuWi1XKRPb0f8YMxIVboUISxdW9RJrMQ6Bm6qHz53MmgQ/a5Xdmx
         9gKPUrFZPfCJXWGJ/s50tukEtUPpJkzABdy1UVkSl4RqvQPwxjhKu1GL84McRHiwq8uS
         t9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776199955; x=1776804755;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDaqjRJOVTJ0fmwzLGIp/zbceZP052CIL/kFOBO2wO8=;
        b=Dk+ekzKYWVzqdX72KMDJxAxoUmwLFTLIDza2/X7kWlpYlmgOU5eSopUcsphN5llIzu
         WLDqgRF6LWZCejWR/KLjPbsitw2KypeQz4xt/MQzeIaBr9jsbqMGT2nO6L39BZvazSrX
         ez8SmG4bSJlS1Bd3RRAbPwpd1epJrF/gCSLjL8/09ioZGS9qwP4+EdMqNAUXw8dqja5s
         WN1O9P/PrsD+GpfqG1EKaiC5Hp91O8dGbh8SLbRNmA9sKnKhnI1DXjgDx/dZ4JU/avsX
         DCRvfvVK0URFUcU8RnE+YcubWY/JPVjFVLo5Q2s2jVywADwsK4zDKg/tjHsiiVIK6+Gv
         TAYA==
X-Gm-Message-State: AOJu0YwZ1Va0OWC2eusxx72K16WpWe/9Y4x10Ue8FrsGdtEFlX8IIBqf
	rSmXUexqZ2uid+6glvYLzsuUT41KvQrxD/Dw8KuKppS9mKq9iZVUXnP9
X-Gm-Gg: AeBDietIu3m7Nd4nGzJyQ/vrGApEJKjv3OGmxu0uQrmIfV4ZmzKDrZn5eLl0LywdRez
	cZIwl9BWvZIxig75Lk1WHMzgD19a9rRIxR83JlXlNpOIayovV4+lAKP+YFZBV1AAnkxZ9OnP83L
	0WBS4UU8icYWdI2XV5aB1gdIo8jstGOCbNKbB8KFEh8FLl9JmS2y8BGMqoFfLPZ/bihzL9idmAh
	KxdoRnlSkIN8IvAHnskUmC4H9e8dL/bBjRhYazWd1ajKnwMpQFErmlEcl3B8Dy8f3EF5xHsZm5g
	SKtXX31n+kL60Ljg8X7243jXmBaCERMmojieC3tLgVy+YBJUEB3ZpIqKZZlpZX9s2E/DJPYffhT
	mLYkcIcn1D3Zxl6MX9es+qCNiyxErzCRfZU/abziudHwQ7IGudosl/fjJc+dssakFMABa+Zj+tu
	cz78+3JzPCwKbxa6/mVphZRbe8TOyGfylpwPM4yG6C2biYtLpyk0Yi
X-Received: by 2002:a05:600c:c171:b0:488:a894:b27a with SMTP id 5b1f17b1804b1-488d67f0105mr271884815e9.8.1776199954714;
        Tue, 14 Apr 2026 13:52:34 -0700 (PDT)
Received: from localhost (94-21-146-148.pool.digikabel.hu. [94.21.146.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede25a12sm67427375e9.9.2026.04.14.13.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 13:52:34 -0700 (PDT)
Date: Tue, 14 Apr 2026 22:52:33 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] test-lib-functions: use BUG() in 'test_must_fail'
Message-ID: <ad6pEbnSKzUOkS2k@szeder.dev>
References: <20210221192512.3096291-1-szeder.dev@gmail.com>
 <20210221192512.3096291-2-szeder.dev@gmail.com>
 <YDLXf+OoJabrJTWu@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YDLXf+OoJabrJTWu@coredump.intra.peff.net>

On Sun, Feb 21, 2021 at 04:58:23PM -0500, Jeff King wrote:
> On Sun, Feb 21, 2021 at 08:25:12PM +0100, SZEDER Gábor wrote:
> 
> > In many test helper functions we verify that they were invoked with
> > sensible parameters, and call BUG() to abort the test script when the
> > parameters are buggy.  6a67c75948 (test-lib-functions: restrict
> > test_must_fail usage, 2020-07-07) added such a parameter verification
> > to 'test_must_fail', but it didn't report the error with BUG(), like
> > we usually do.
> 
> OK. I do not care all that much between BUG() and not-BUG here, since we
> are unlikely to have a test where test_must_fail returning 0 yields
> success. I guess the most interesting outcome is that we would notice a
> bug in a test_expect_failure block.

If I had managed to send a new version of this patch series in the
last 5 years :), then this would have caught the issue noted in:

  https://public-inbox.org/git/ad6hovxCkwMTG11U@szeder.dev/


