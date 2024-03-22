Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F34416
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 05:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711084482; cv=none; b=VJfVmUjNnuy/cZtdNUHEgY7uMbH8TjzFkIuiPdgsmHNzHGofUs6UFmm9lmGh1X+djwF3RfRocC4sjJe1Nt2v/S26NhRhBvdH8IwhvGSazh9nK1+HvLKahmaErLg/2RvimbomO0EkFfffGq8i0SEQj2KklDZ2hye/dNvoc/uNv7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711084482; c=relaxed/simple;
	bh=AfC/E2REpVg7o0hbVlttZU9R6suy0cqOo54AWcrwzYY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OMZl40x6g2D1rT6tfY8pVFNZs7pSiK4ZwlWk+NKWU/wSt+SNCyGToKc/apvoep52DiOZ7MoEwYw3mExo4PYGhvk3u8rSqIP8mq63Rt3lkOHNGRVWhDXwU4rkactn6TQ4vBN07skndEli6akBAv9CkMPjpu07s+etABiMIOJz39Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=TSgnTpQF; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="TSgnTpQF"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711084477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WfoxscLuUGuoMrpQIx/cPsPf+yWG903KOsUlVJ65vDI=;
	b=TSgnTpQFC3lt6RQJ00EnhMgzSvmWFnN774PCvYxwE5b5MdgVPcUS1Mkc/H1j+IQc1eDY4B
	NLpnoFCLnJKUSjSe8ILndcCGpbg6azstopcCcw7G+4moyCFgOcQLPCrnddO+JeUTsop+3d
	yMiUAZeCkf8TzRCW3iubAzooq0SthWesxIWoup64J57LBgla4dea8ElbBxkPwxDc3FhXlc
	1hntWgHy2SbbO1dJEAVonVUT+y08PP1dNZe6PxWX38hOEDQ1YWYGncUDosiTyWnB41lmYH
	Xuf56v+8G5jyInHl1Bnz7DJ++o4XbGSeyfccuIlkAhRxqp4GUu5GbHK1Mni/kw==
Date: Fri, 22 Mar 2024 06:14:37 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Brian Lyles <brianmlyles@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 phillip.wood123@gmail.com, =?UTF-8?Q?Jean-No=C3=ABl_AVILA?=
 <jn.avila@free.fr>
Subject: Re: What's cooking in git.git (Mar 2024, #05; Tue, 19)
In-Reply-To: <17bef643ca4eabab.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
References: <17bef643ca4eabab.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Message-ID: <c62a14c7de6ff487b1f66f149d685126@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-22 03:47, Brian Lyles wrote:
> I would agree that it would be hard to advertise without some change
> there. I think that documenting an optional opportunity for now before
> considering if it should be a requirement later makes sense.

IMHO, making it a strict requirement would only raise the bar for
contributors even higher, and increase the "do this, do that" kind
of traffic on the mailing list.  In other words, I think it's the
best to start slowly and see how many new patches will include the
additional summary.

> Would it be beneficial to request some specific heading, phrase, or
> other structured text such that this summary is obvious, or even easily
> extracted with some sort of script? Or is that perhaps overkill for 
> now?
> I could see relying on any sort of automatic extraction being 
> unreliable
> even with such a recommendation so perhaps it's not worth pursuing for
> that reason, but I could imagine it may be useful to have a 
> standardized
> way to separate this release notes/what's cooking summary from the rest
> of the cover letter (which also acts as a summary of the series).

Of course, it would be nice to have a strict format in place, to
allow automated parsing and extraction, but I'm not sure how many
patches would actually adhere to that requirement.
