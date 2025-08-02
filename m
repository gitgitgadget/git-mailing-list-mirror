Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9341FE44A
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754126615; cv=none; b=ATWSQeNpubPfVXunb1S4LG8+l6FUX+oD7EYBmis/SfusL47FYa8/f+JTMTVoEcniCzdDT5XM1aMF3CdjcTlqf7N1cjIGfqdQLlcxnmV61v31iHhAqPi9DoM2K2p40FESoGpLwLgSIA7xUqVwSykSe9argX/wnVMIMKIO1SvKp9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754126615; c=relaxed/simple;
	bh=N5cVwz41FuBk57fENn5b7/IOkU09TlFMElEjym74yR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJCkr2V4jja9puE4piDJk15IZ2XF9NUUahLeTPDBCIUIAR26Vp998HobA2axCnzFTs+YxGWwglsH3dqqV8PaCK1gMOobF/ET7hAt6GiOmlozwx6h76chyRedCn5S3Y/sHI7qbahScKY/njBd/4YGQa9YnBacSSf4FM3gXtgaXEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=T9apBSJr; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="T9apBSJr"
Received: (qmail 8939 invoked by uid 109); 2 Aug 2025 09:23:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=N5cVwz41FuBk57fENn5b7/IOkU09TlFMElEjym74yR0=; b=T9apBSJr6DEtqGmMIgwa9RFYLQLOlKVVb402PaCjhklbam4MkQ4BuNnAP5Ocjqzz3mbPYTjCPjrDpK/shuU/7r+TXhnSV6okXfSq2gMmsfUATzS8GygWFg1QHWqzANdRlJct+PElXzZIPqGlFTPAjcYyZG0PzhxQPFfxaMVJhBXeWqzg7A0c3MeG0RWF8G0ocLdRXWsRj6dA3GCPyyRtcwu3WlPWpFMQeKykDGcfmMwdksCwhmsVAsxqGAMIjCoYeFVMXv/c80+TCRMQ3S4T5Be+DjzTVCuqLJZkIieN+phIqve81G0M1i2a3hVX3RZBOgQBYskzg2TqTlSNqru6Uw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 09:23:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11379 invoked by uid 111); 2 Aug 2025 09:23:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 05:23:36 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 05:23:31 -0400
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH 4/4] builtins: show help on "-h"/"--help-all" with more
 than 2 arguments left
Message-ID: <20250802092331.GA3721454@coredump.intra.peff.net>
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
 <20250726165320.4039-5-ben.knoble+github@gmail.com>
 <xmqqms8qzdd0.fsf@gitster.g>
 <CALnO6CAbTjuFrLbhC24VDmdy4Utx29g92M5eYV9BPahXK+o+1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALnO6CAbTjuFrLbhC24VDmdy4Utx29g92M5eYV9BPahXK+o+1A@mail.gmail.com>

On Wed, Jul 30, 2025 at 05:55:32PM -0400, D. Ben Knoble wrote:

> >  * "git rebase -h new-base" that shows help is probably a bug (think
> >    what should happen with s/rebase/grep/) in the first place.
> 
> And at least according to my tests, "git grep -h new-base" still greps
> rather than shows help. Compare
> - "git grep -h squash" (greps squash)
> - "git rebase -h @{u}" (shows help)

I was somewhat surprised that grep would still work, looking at the
diff. The reason is that it does not call any of the touched functions,
but instead relies on this line in parse-options to trigger help:

  $ git grep -A2 'lone -h'
  parse-options.c:                /* lone -h asks for help */
  parse-options.c-                if (internal_help && ctx->total == 1 && !strcmp(arg + 1, "h"))
  parse-options.c-                        goto show_usage;

rather than any of the if_asked functions you touched. So I think there
may be two problems:

  1. You didn't touch this spot in the parse-options code. Would you
     need to for it to be consistent with the non-parse-options callers
     that use the if_asked functions?

  2. We can only get here if we make it past the help check in
     run_builtin(), that you do modify in your patch. That works for
     git-grep because it does not use RUN_SETUP, and calls
     parse_options() before checking whether we are in a repository.

     So in run_builtin() we do set "help" to 1, but it does nothing
     without the RUN_SETUP flag. But imagine a hypothetical git-foo that
     takes a "-h" option and does require a repository. It would set the
     RUN_SETUP flag, and then:

       git foo -h bar

     would show the help before we even get into cmd_foo() to parse the
     options.

BTW, I applied your patch 4 manually to dig into this. I wasn't able to
apply the whole series. It doesn't go on top of the current 'master',
and applying with "am -3" mentions "sha1 information is lacking or
useless". Did you build this on some other unpublished series?

-Peff
