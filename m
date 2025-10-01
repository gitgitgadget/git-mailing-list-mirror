Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F31C5F13
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759353129; cv=none; b=QhmqDDuiWSDPhW8Ieo5XuxatSuJSnkSE9xPBtdiEhRPz+3gfc6SORQBMGbsbD/kKJrdug23eUpHs+MT9oVN0HaCQ6OpEhvwZT4eSBiSDPnl2g2HVduDpYHEFfMMiXd6wdYyr92mYRv5ZnnvM64UKOWeaKIL3Ey3jXvUSV5ZOXTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759353129; c=relaxed/simple;
	bh=IIBfYndWT7Ht5SGSQQ9KTE7RX0HxkW/bgfFrdjCmYtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMYWv+ALzz1U/AnGqOhXIMPHrC3dpu4cTcm5Vu5+dLTMzfK4rhuJb/7v+OI1TWsN3vGMQX6rbgTlHomOPCfPwL0K7KVWlWMCZIQuOVB57eweIDMZk4myOlctPXdvUr2lQNq4u3AiXQARNp5UsUPnge74xCpLBfBLEwGYVLS3eXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NtwvyvUP; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NtwvyvUP"
Received: (qmail 98663 invoked by uid 109); 1 Oct 2025 21:12:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IIBfYndWT7Ht5SGSQQ9KTE7RX0HxkW/bgfFrdjCmYtM=; b=NtwvyvUPGyoEAOMV9U9FFTS+25qiI4Y7x0DzQColfdvChuqERctq4UFJ273HdxPOMb6ICiG4UiKVxlZv0fcoJ9gJZAiPLHrEJ7TX5Hfucf20fVZjvaspiflmOcCSQM+54FGlUHyjjmFVIW5jWOj1A7teEk2+8WPMb94H5HDX0fMzgiXu4HN6rThL1oWNXYIIF6ZQTD8iNrc0eCW7nz75u808U/pbTKW9gHLzW/bJB0Hpm90GI2egLNnWC9kvfnhM7697SDUVT73NF7o8tzLQPZQQzzUqPoDgHsiSiU31p4XgKyijF6AphfB5b/oP8YTywJ1ey7q04VgK8/9qL3Cm0w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Oct 2025 21:12:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 140584 invoked by uid 1000); 1 Oct 2025 21:12:05 -0000
Date: Wed, 1 Oct 2025 17:12:05 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Henrique Soares <henriquegogo@gmail.com>, git@vger.kernel.org
Subject: Re: How mantainers check Git diffs and patches?
Message-ID: <20251001211046.GA30565@localhost>
References: <aNygY8Cm7LEaBzV6@localhost>
 <ba6b9a5e-72b5-4d66-a484-37140438702a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba6b9a5e-72b5-4d66-a484-37140438702a@app.fastmail.com>

On Wed, Oct 01, 2025 at 10:15:35AM +0200, Kristoffer Haugsbakk wrote:

> Here is a relevant message (2016).
> 
> https://lore.kernel.org/git/20160809113703.57irthzzpg6j3dmv@sigill.intra.peff.net/

Oh good, you just saved me a lot of digging and/or retyping. ;) I think
that message is a bit more philosophical, but in the thread below it
there are some actual scripts and mutt commands I use. I'm sure they've
probably gotten some small bug fixes over the years (especially the
patch-sending script), so if anybody is reading them as more than just
inspiration, let me know and I am happy to share a more current version.

-Peff
