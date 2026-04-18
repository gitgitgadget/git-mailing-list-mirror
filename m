Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC562032D
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776546321; cv=none; b=LmTWaBfu3h0hY6PIFCW2E5QqVn5MQsWm5wZJgagPpxtdEdqgyKIiILdzHLwjZ/oJceD6Amo6ICCZmrZQETjpzGLx9oQM6+nAOTPAvmR50iMqZfMiucyZ9n8fNV/yOi1YNjhcsUcx4JonNRqL6CI2GwNa3NjLBAugPfmOJbjQDdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776546321; c=relaxed/simple;
	bh=1JHsM3jCAWrpl6QpcgPPkv1QaZu+3vzanXpkxRv0+7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGOH68x0Vaku/SXey32DuJNKqw4du41npU5b+jeHDZwIX3G7hMkWGoF1TkLqYqhm7dIrqqZSXIXgSSHPBLexP63BA9zeNXYBNH+2dNI7d/gi0zACXmsJx3fxBYuPozf+I2iosPsW5BfTDr4It+QM6YJPXrajkhRAg6f6k3QMei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=I6i1T+9m; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="I6i1T+9m"
Received: (qmail 393105 invoked by uid 106); 18 Apr 2026 21:05:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1JHsM3jCAWrpl6QpcgPPkv1QaZu+3vzanXpkxRv0+7Q=; b=I6i1T+9mLfuMpMtqLBQzacMIZHGBd33On0/tNOLbFcsIi7O7Q9L5+jtWCR+EHYd4EmCAsNfnPasa/B7uQEipieSNntKqVKr7cXnIl5FK5U5lCkyolaU21V8Sjluz3wABbooMmxA1zeLqZM3g4A2tofnAjoe2Gph2BgLPgdwSMP4iUeJXPJYwUYzRFLPtVN29t7vDKk88v2zKNBs4dOVhkQv7b5hqVC+utCp+rLk6HyXLcPB3HZwKtzjqrlu/Tnf4HXms1yacE9/7gfX/inFs5IiCzbRYoUBkQzXaTa30GXT2zzzcXLYATlxkPkOOgcjSgG45c/K+PAhbu4k+d8vWxQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Apr 2026 21:05:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 660288 invoked by uid 111); 18 Apr 2026 21:05:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Apr 2026 17:05:18 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Apr 2026 17:05:18 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ben Knoble <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org,
	=?utf-8?B?R8OhYm9y?= SZEDER <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 12/12] t: detect errors outside of test cases
Message-ID: <20260418210518.GA9632@coredump.intra.peff.net>
References: <20260418065009.GA2619713@coredump.intra.peff.net>
 <AA6F33AD-25C2-4AB0-A624-35C7B0BE0F66@gmail.com>
 <20260418174446.GA1695@coredump.intra.peff.net>
 <xmqqtst8ul4q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtst8ul4q.fsf@gitster.g>

On Sat, Apr 18, 2026 at 12:24:53PM -0700, Junio C Hamano wrote:

> We could forget about "we know this is a good shell by its name and
> version" and test the feature we depend on ourselves, perhaps?

I looked into that but didn't get anywhere useful. You can try to test
all of the "set -e" scenarios we care about, but there are a lot of
them. For example, I would never have thought to check how "command"
behaves inside a &&-chain while "set -e" is in effect.

So you basically end up adding a test case for the bugs you find, at
which point it is not much better than blocking known-bad versions.

-Peff
