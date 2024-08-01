Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681391EB4B1
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722532569; cv=none; b=XQgAc316l7NhXd7cylL/zvec8ydFqtY5aIiz4Au1gCGQLDuG4z1JUCb+mxSj8vZHQtBygMSw973IVMziqk3erZod2ERvcJNL1TiB9X1Tytktqm8et5WLqjFZ+QNEvrBJ4dAyyly7ysFDoGPxXNDK3KbAOZxQA/bkMfhfg7xiRtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722532569; c=relaxed/simple;
	bh=QV3+37XAEIyj/gSNaiVQDIXi7S8rLHb8TFN4ibdx894=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcElLQUhnE0AsDcMgLpnI3cwtQoKnPrdC9TPzSy1+fcdMYeuhGtWetGFEWiNRDyGnykl6D83GU31e/9h3zf+wzwXo28wClR4rQToGe0W3XxVsy39CNgXuL5tg6HIAel+gGpnMmJLmbWX2wBKll6N/UURH/0p3kx4y9IgpHwFqdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ROitvP6d; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ROitvP6d"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6519528f44fso55138657b3.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722532566; x=1723137366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7uH++cXMtXa6tH1r0wMUeCvIXfvdf5819gflG//YUZM=;
        b=ROitvP6dXp5K8nVh/mYLLBn/h7wLfuvMXKl9WAzH/9TUJB61wTMudaR+lh0U5Y5Bm8
         7vg0OuxPnV9pM8towjzVOkSP8gr4RRfHui0NsWR5Pl4p7s9uycixBmB4hS+koH4CAUi7
         1Xtjy260WWuE8RpZ1X41VbDIRzRzfb2lkXGa/ERUju/meIv8Mh36NPQHgs6htIJq9luj
         8Lk7MiogHrqx6RGXFrKNs/lo1z14bJIdFEFcL9vRyoARB2edF83dtM3iY0sjC9C4Wook
         ZRYNWXetQUnKwgO+KlHJqVja622y9b5tRyvnGeJ/kLLDVlWQP5NP5OcEsrugX3YdSKVB
         1ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722532566; x=1723137366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uH++cXMtXa6tH1r0wMUeCvIXfvdf5819gflG//YUZM=;
        b=DbThr9X//Jcrdgnyo4jLGmAI7a1bJnQVql6CSL1kMEpJ/I5CQ+nr3GhybtlSwBi+q/
         G7YTwqY5jhM3W7FXWvAJcL/xYYNUfMEXzxJcmN3XYyGeOsr99wJyrD/MIte6GgYA7weA
         k583fy37yPwQSmBV7dIL16nqHIapIYetCWnPwiE/wDfv6RMhWd2DaJc4HwoxV+Ly3kSi
         m92QAG7r4W4ez8G+e9EA86PacRXDwGyPA0o2m1OQGYSxMiTOqREfJVhOpL0Tvs7QAHDp
         87CVBf/5rBUFhJY5ftMahN1DC/NFVNKWV2G3wnT+RFS67lPuasiN6RNJ2C6vuI3MsZHS
         vcWQ==
X-Gm-Message-State: AOJu0Ywi9uJ6QsSirUDvCXuxR1ugbIIxADch9zSjXNJ+dnKjwVsouJSP
	18fz2fOGe7mgAY3TgxF2YbNtCCb8GDV9qrQQ52M4t5aPYOAyWC3/NmVPw0BdIDc9oX+B6ND/jdZ
	m
X-Google-Smtp-Source: AGHT+IF5prf8mmjiP6EBqZvKXiKKqecPWWkTj0x0+/Ep3efHFNHA6TLa+qfJJjHAIwZgcrCP5/+N4g==
X-Received: by 2002:a0d:fd03:0:b0:650:9d94:799f with SMTP id 00721157ae682-68961037c71mr8343597b3.26.1722532566190;
        Thu, 01 Aug 2024 10:16:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-689b324ba5bsm129847b3.100.2024.08.01.10.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:16:05 -0700 (PDT)
Date: Thu, 1 Aug 2024 13:16:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/23] Memory leak fixes (pt.3)
Message-ID: <ZqvC1CfRj0dQkmMF@nand.local>
References: <cover.1721995576.git.ps@pks.im>
 <Zqpt0/6zBOpYh4aj@nand.local>
 <ZqtFIblPxqoXww-p@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqtFIblPxqoXww-p@tanuki>

On Thu, Aug 01, 2024 at 10:19:45AM +0200, Patrick Steinhardt wrote:
> On Wed, Jul 31, 2024 at 01:01:07PM -0400, Taylor Blau wrote:
> > On Fri, Jul 26, 2024 at 02:13:43PM +0200, Patrick Steinhardt wrote:
> > >  57 files changed, 251 insertions(+), 73 deletions(-)
> >
> > I took a careful read through these patches, and found most of them easy
> > to review. I was admittedly a little lost with the "fix various leak"
> > patches, and having slightly more context in the commit descriptions
> > there would have been helpful.
>
> Yeah, I was a bit torn here on whether to expand the commit messages or
> not. I just didn't think it's all that useful to always say "Variable x
> is allocated, but never freed" for trivial cases where allocation and
> freeing need to happen in the same function, much less so if we repeat
> such commits for every single such variable in the same subsystem. So I
> just threw those fixes into a single bag.

I think sometimes that level of detail is useful, e.g., for tracking
where the leak came from, if it's always existed, etc.

But I agree enumerating each leak in an otherwise straightforward commit
is not a good use of author or reviewer time. I think more useful would
be enumerating the kinds of leaks that you clean up.

Thanks,
Taylor
