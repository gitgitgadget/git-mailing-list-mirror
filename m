Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF0E2D05D
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720428883; cv=none; b=BsloW3VADnRYPvWNzypY0qRLskrjno0J42goQC3T4amfHI6FglCsKO2uRNwzMMQSvfhtKP6hdV34L8xUIgKbsdsdTlhO2HqNoZ0hDFyFeTzZogvZ2J4h92JSc9W34ZLbyC5/n4CwJKidFg5o0DKN31Okb/MyV0T+f8TUAVWxnww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720428883; c=relaxed/simple;
	bh=q9Zf4O8hWyz1R8tPwefVf/EsOsPn51r1CZgSxL2Wk0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHtz7GX1EWBOz4oTTtc1mMjOtl/5/NA59nwb1tb6sz6cuKTHZ4iMeh408LqD0vOn96gcsVnMe0j8bwnIqqtnIBjTwZek5QrA0Nd8lCo3rwZZ8+tPmztyFcESqQyFsNmvusHnwDYbh8gsgIm+5OJy2aim8Wzo1vhpCvRYI6uxduw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14097 invoked by uid 109); 8 Jul 2024 08:54:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Jul 2024 08:54:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20505 invoked by uid 111); 8 Jul 2024 08:54:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jul 2024 04:54:38 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jul 2024 04:54:40 -0400
From: Jeff King <peff@peff.net>
To: Tomas Nordin <tomasn@posteo.net>
Cc: git@vger.kernel.org
Subject: Re: Unbalanced closing paren in help of git commit
Message-ID: <20240708085440.GA819809@coredump.intra.peff.net>
References: <87o7792xgu.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7792xgu.fsf@posteo.net>

On Sun, Jul 07, 2024 at 12:33:21PM +0000, Tomas Nordin wrote:

> The second line of the help message for git commit looks like this:
> 
>     [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
> 
> See for example https://gitirc.eu/git-commit.html. It has two opening
> parens and three closing parens. <commit> ends with a closing paren
> before the closing bracket. Me and gsish (on IRC) suspect this is a
> misstake.
> 
> What do you think?

Yep, looks like a typo introduced by 00ea64ed7a (doc/git-commit: add
documentation for fixup=[amend|reword] options, 2021-03-15).

Want to try your hand at producing a patch? (It's OK if the answer is
no; it just seems like a good opportunity for somebody to get their feet
wet on contributing).

-Peff
