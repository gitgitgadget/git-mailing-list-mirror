Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D9A281508
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897154; cv=none; b=d6oxEU6QY7DGOVxoteB3Hii1TafjlhpqGmL0r8zKKrqs+Hd6SbiU24QLEoP7bCFMKR+gmA6m+MCT9fOKJByDlGf444ThRd5zm8RvzEbos3b9xZAEcetgf5fovLb3kIaTSnnPFpYgNKLW+l5/lvTKLxYON/s18MQ0bCgreOTtecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897154; c=relaxed/simple;
	bh=/aZkaxfKD0bBlUldP9xo5yT4zahGWsNQ2nMLisoQzfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyhF9O/NCOqiXSEz+lvBEu1ItRVnbgPGAzTNTulofFYRwE2q3l/MDY/Gn9GElZbo9qu0LIRCSZuOu1Xf2+FlxBjMyYoHbCuxIkIZpLzpeA52+Cod1zuswWD7/6UjPtddG977de4YaR+W6XDu/eCO7cSYYfIuh2hAGrBJgsSrQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FgOU53af; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FgOU53af"
Received: (qmail 489728 invoked by uid 109); 11 Nov 2025 21:39:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/aZkaxfKD0bBlUldP9xo5yT4zahGWsNQ2nMLisoQzfw=; b=FgOU53afyWatf0sHksLo9wYswpMv5hpiasP2tHAaunfk7BfQ0SYpgWvey0TN2N/mLZyM/rULnUlJE4tEyZv6W8wxgoRKVe70n1yMgDokCT3NB1BWcQcMM5WZKiyhcqihqo2P4Y3YG/Uw606ZYmjv6h+AGniBJgBH629snxFZD0VsJ6fyJ/o5pyqBxeEPwgw2yWhAFIlTGxVAzYHRbnxTXmrdt17GZWtg6VAKjNeJlZkxXofywwUUULaxWiNjgYf9YZ3ARBILBzAiHpns+IaXqwCjgDtbI6375skDNtoWDrZ9byOEp+YgSnZrc5bKg83wCpHiVRhRfaXcdEFsa5LLJw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Nov 2025 21:39:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 780306 invoked by uid 111); 11 Nov 2025 21:39:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Nov 2025 16:39:10 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Nov 2025 16:39:10 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] .gitattributes: remove misspelled no-op whitespace
 attribute
Message-ID: <20251111213910.GB4053071@coredump.intra.peff.net>
References: <xmqqv7jgwgxb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv7jgwgxb.fsf@gitster.g>

On Tue, Nov 11, 2025 at 10:41:20AM -0800, Junio C Hamano wrote:

> We could either remove "!indent", or spell it "-indent".  The
> immediate effect would be the same.  It would only start to make a
> difference when/if we enable indent-with-non-tab by default in
> future versions of Git.
> 
> Let's take the former option to remove "!indent" from the list.  We
> would feel the effect first-hand ourselves before anybody else if we
> ever decide to change the built-in default whitespace rules, which
> would be hidden from us if we decide to rewrite it to "-indent"
> instead.

Perfectly explained, and the result makes sense.

I don't know that this patch particularly needed review, but maybe it is
nice for you to know that somebody really is out there reading them. ;)

-Peff
