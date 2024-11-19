Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F49E1D1506
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732042701; cv=none; b=OCJF2wcw1GAS0pAiL/tpa8LVWfCGzfVF1NC7UfAyBaL/Uv1kfS12IVxTt+PGrzl9ExvrZB21VtAFGw4VQBXj8aHXMhXiunQtO7UBMicjm9YvySiynqZuqSYsDP/89ArV5MY8VlKPWLKPQs83yKcC2V/4U+fquaUCjYQ61Co0ZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732042701; c=relaxed/simple;
	bh=jL+ufKhWhKgoQA488U900TrzuMfxh0F7Op72UvyZ5T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daa299p/fo8t56iGZZ4jZRXvrUjDx2hInmRSrhcQ+FORRfueI91hCjlCVkR+CJil+hkBzvUGFU9pvOBE9nnZoUgjMv8rakA+3tg9BXvIhpcGMXzol3rg016iSKgynT+wTVssmqyhhiDkZo9bAS1fFVCl9diwjpkDWnD+Sm0ZV3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EXFI7kue; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EXFI7kue"
Received: (qmail 7673 invoked by uid 109); 19 Nov 2024 18:58:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jL+ufKhWhKgoQA488U900TrzuMfxh0F7Op72UvyZ5T8=; b=EXFI7kuez86TQc/sGkwJATyzjC4vK9oK5TOgyyN6Ud+B68/XkmRF7Hs34/5bNN53GM8RkRZmp8ifutVJkgdqFgupasyADOwmMPE9o9nLZpv1fEZbJjpvpEoFTrrR1T5IPhJQeF6c3cUsvK/8Qy4M3IFHhZ9tOux5wKAUYwtPgeWhJbCGZ5taeo8A6j/2EvX95PY0SoSeE0lfvwAOhERM0aUVfyFNKjMeHeM31kUDDs3plwwCcBr9YfdfHtG4FOUROi6VYty4AcQ0HzhL/QxAnZ28tUWEA04yuv+Xy8M/L66G66/CobQuzQ7UwEE8TaBDpJEahm1AgEFA+8Hpu4X6oA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Nov 2024 18:58:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2698 invoked by uid 111); 19 Nov 2024 18:58:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Nov 2024 13:58:19 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Nov 2024 13:58:17 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>, git@vger.kernel.org
Subject: Re: Long names for `git log -S` and `git log -G`
Message-ID: <20241119185817.GC15723@coredump.intra.peff.net>
References: <24458598-ebbe-41fc-8517-457fa65ed481@gmail.com>
 <xmqqo72bev71.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo72bev71.fsf@gitster.g>

On Tue, Nov 19, 2024 at 12:52:50PM +0900, Junio C Hamano wrote:

> 
> > `--pickaxe-grep` for `-G` seems like a reasonable alternative name for `-G`.
> 
> That is probably OK (even though "-G" is not exactly what the
> pickaxe machinery wants to do; "--grep-in-patch" might be closer to
> the intent).

FWIW, I like --grep-in-patch. Saying just "--pickaxe-grep" does not
highlight that it is about looking in the patch. I.e., it is not clear
from the name that is different from "-Sfoo --pickaxe-regex".

> The -S feature was written to become one of the building blocks of
> Linus's "clearly superior algorithm", described in [1].  Linus talks
> about "where did this _line_ come from?", but the algorithm is more
> generally about a block of code.  The expected use case is for -S to
> be fed sufficiently unique block of text so that we can efficiently
> detect the transition of occurence count from 1 (because wee start
> from sufficiently unique block of code) down to 0 (which is the
> boundary in history where the block of code was first introduced in
> its current form).  It detects any occurence count change, but its
> primary focus is to find a transition from 1 to 0 (when going
> backwards in history).  Its spirit is more about "finding where it
> appeared in its current shape".

Heh. I do not disagree that was the original focus, but I find that I
use "-S" most frequently to find mentions of a particular function or
other token across the code base. E.g., understanding the historical
uses of a function, or why it has no callers anymore, and so on. So I am
often looking for many appearances or disappearances (though of course
they may or may not happen in a single file).

-Peff
