Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF67FC2E0
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674498; cv=none; b=r072uCibFjtumkO9RXVeN1gInN5YJX0OHwJstgQpfVnFieF3OTe4YrOKJsCkV+Io/wNh2StbXTKFBlSYDBCm1U0V+OFb68WQQwE3SBTj67fuGE61gaNdgDPZlDEQQDmQ0J3uICoDx9mmMYH1hfPZj6QVybKPObsbEaGwuRRUk4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674498; c=relaxed/simple;
	bh=Domi8k0G+Q5QH6UAEtimWeLd+Wh21qCjGQa6we8Hkyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZT9UAbDAxU92aF4bZzW3cH2yGnyQQYlHuvu/c8gmabJgg6p1giXELEoNtBoEuHdiBhxiRPhfZ6dVkW8CC22Rt49Xj3AePkjt04rL7/rSfSlf2OqTYPmCfJhgyxn4MgDlaJiefBDVgbBkAJu/6nmQV+tdVdxq0Gfp6/oPKQA5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SnQrQ85x; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SnQrQ85x"
Received: (qmail 10623 invoked by uid 109); 24 Sep 2025 00:41:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=Domi8k0G+Q5QH6UAEtimWeLd+Wh21qCjGQa6we8Hkyw=; b=SnQrQ85xwD7VSwr8iunFWoCN9+n6mOlqEZGpKC6tUvuOZPCDUZoApuO6tSEtTEMIbVdkestBnMunL6NHosTupkaCkMMxyILZF0eX0d1FdzKS6yGbzFwDSkM1WLV8pV6zLv3h3FkYaSLmAe3dpUhRmWSMowWaBWnXGX83qc2+va8LS5YPY4adTDFaB+d0FdWJfpyuqmcQI5dItjiaA4wW1xO2oU4D5DMMBSDA9LNa6hCxkE2nXJlJeDPPMqVEGedUFVXyNVx0QWEiHfa2bj3W+eS26T4WQuKxlnCrObQrsDroclXSBBB9PTJl6kq4aVxqVUFNmB7eVOtkI+yxzyf2ZA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Sep 2025 00:41:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16432 invoked by uid 111); 24 Sep 2025 00:41:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Sep 2025 20:41:34 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 23 Sep 2025 20:41:33 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: format-patch: why are the Range-diff: and Interdiff: headers
 translated?
Message-ID: <20250924004133.GA1142438@coredump.intra.peff.net>
References: <3945bf06-ba04-4ecb-887e-0f3a76e1c2f8@app.fastmail.com>
 <CAPig+cS-qYqpK2GOzSLQtqF_gqan6hftnnOnfMFUKby1nT5n7w@mail.gmail.com>
 <54b9d6a1-6edf-43e0-8e6b-e096f322df64@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54b9d6a1-6edf-43e0-8e6b-e096f322df64@app.fastmail.com>

On Tue, Sep 23, 2025 at 09:59:55PM +0200, Kristoffer Haugsbakk wrote:

> I’m not concerned about machine-readability.  My thought was that
> localization/l10n of this software was intended for the user themselves.
> And also that users might, without intending to do so necessarily, end
> up using localized output in contexts where they do want English
> strings, like on an English-language mailing list.  Even though they
> might prefer Spanish (from my Colombian example) when using Git
> themselves.
> 
> But there might for all I know be Colombian/Latin American patch mailing
> lists where localization like this works great.
> 
> I’m not really in the natural target group for l10n Git.  I might be
> totally missing all the use-cases here.

I'm not a user of the l10n stuff either, so you can take my opinion with
a grain of salt. But it seems obvious to me that "the language I am most
comfortable using" and "the language for the project I am contributing
to" might not necessarily be the same.

I'm not sure how well gettext supports this use case, though. The first
one should obviously come from LANG, etc. If we added a hypothetical
format.lang config option, is there a way to tell gettext to translate a
string using a language string provided per-call, rather than from the
environment?

I don't know that anybody is really even asking for this, so I'm not
proposing to spend a lot of effort on it. But the thread made me wonder
what is even possible/easy to do here.

-Peff
