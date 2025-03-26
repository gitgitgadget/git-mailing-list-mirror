Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE511F7069
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011463; cv=none; b=kSAn7REzpLdXaBwNwRuir/zKcEwR77/Yrty8Gdg6a1JQoe6Lp5AFqRBKdY7SJTapy4ps2ZW/0yaYSx5yGDGRM5im1ZcM0s4Fbf6yZWR5mVrM8sMIwrxcNdUZxMFh0pGuX3wUlh+o+8dsKQBB/FtZl2RusSEluOAh2ANvdsFfcEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011463; c=relaxed/simple;
	bh=H1yOtdYB0Q8YQHLrwO1dYn8KOHyErYhvVxvK6XnDU/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPGbWPLtyyvfF7HUF/5aWXeIk+UtiaUs4W1RMqkUQUN6pNNiky+dZ4+D2CMv1qS2XAlY9YdpbFh53qKP1Zkt96WEVEhot3kM9E+SxFPgvHwDQVVEg8lOvpwbnMwTjsp9gk/MN4etyyLvSt2yAEqSFosuMkBH91EUxgL89OqQJuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SC0MsLaN; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SC0MsLaN"
Received: (qmail 13661 invoked by uid 109); 26 Mar 2025 17:51:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=H1yOtdYB0Q8YQHLrwO1dYn8KOHyErYhvVxvK6XnDU/k=; b=SC0MsLaNjnE9UbIeBET3abF8phsG0wnTEWL7gdRnWAOqEl6gxaS0GON65Ob0ypMG/7fyg9+/m59vJdBdcqFIc1iIjJD8KsxjlLd4vkqb8YDbDMxhkeTo2PF10utwaOxnXgYo9WSz0Yg/6xTd0hYMbLAEqZ/VMXBNJGqpl62RZEix1yg6cAMyh8GXpjgnAp1awUS5pIeShEXCKcLgArQgKtWYm1o+tHDK+74MWavZmOjfYuieOVj0cI2TVeDQ7qL6Xm9K9BrOUZJYtipJoY6Dn1I3sHNHqMChUjz9hGllMypnb8PZwRmKynaVYd3IipMoX4K5U7FGdjedse4aS6U1aw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Mar 2025 17:51:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17851 invoked by uid 111); 26 Mar 2025 17:50:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Mar 2025 13:50:59 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Mar 2025 13:50:59 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/10] Avoid the comma operator
Message-ID: <20250326175059.GB2508080@coredump.intra.peff.net>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>

On Tue, Mar 25, 2025 at 11:32:04PM +0000, Johannes Schindelin via GitGitGadget wrote:

> The comma operator
> [https://en.cppreference.com/w/c/language/operator_other#Comma_operator] is
> rarely used in C anymore, and typically indicates a typo. Just like in these
> instances, where a semicolon was meant to be used, as there is no need to
> discard the first statement's result here.
> 
> Changes since v1:
> 
>  * Use -Wcomma when compiling with clang and with DEVELOPER=1.
>  * Address the remaining instances pointed out by clang (and by Phillip).

Thanks for fixing these. I checked the diff against the quick-and-dirty
patch I posted earlier in the thread, and your resolutions for the
"easy" cases look good (though like others, I'd prefer switching to
semicolons for the one in diff-delta.c).

For the harder cases inside while() conditionals, the rewrites all look
correct to me. I do think that getting rid of the commas often makes the
result easier to read, but the discussion on wildmatch shows that it's
easy to get the transformation wrong. So I'd be happy enough slapping a
"(void)" on that one and moving on with our lives. The goal is not to
prettify that code (which was not even written for Git in the first
place) but to silence -Wcomma false positives so that we can find the
actual problems.

-Peff
