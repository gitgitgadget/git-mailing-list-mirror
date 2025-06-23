Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A3F23A9BB
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674962; cv=none; b=drtNpTpUTZm2ec5u4A1/RGUH3IwZYH/N37AbDv+L/yUcCDggQCJo/jtDD4A21hcEGnWlPPQtWwAYMYT/nUk7L+D4mKJeWTGq6Da0q2CehZfKLyAUCNBnFLh21xiiOyDLG5h7eByvjsisWWT6+Wem8EueieBvkw/pB+wKV20T2BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674962; c=relaxed/simple;
	bh=mGfj/MAsYAMDqEEbTnQb9cFCvObELhz8bxhGM0fSbpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi0sfe4+ztvqL3ueLQZYxNHxl0nJsEQ8v0QyWWkpKJUfOqCkZjHEFeVCr8BCc9LfnAHZI9ebIf8RHhFUoKvBt6+sa2WYGMy1fezHixURIi/T9NPtGXo0FjZNdxZZ2WH+bKJkE1pJ+Mxx+ottf8+4z/YcHMHzmDp01nycA4oqedg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dyu1yoCm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dyu1yoCm"
Received: (qmail 10010 invoked by uid 109); 23 Jun 2025 10:35:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mGfj/MAsYAMDqEEbTnQb9cFCvObELhz8bxhGM0fSbpM=; b=dyu1yoCmCd81E5lWN9dQs0d4ThOhWQhn1BLKH0HTxXpf11g3v3gfZ3lp0DFWf0f0E8Hr9iHR9xESGz1qzv4oap2jX0wpvSEAokIQ+VpJtj0FXebapBEOv7YFeJ/IL4fP3ctz1D4Qw7SaimaziogVdWLctf5wJrYIgbBQFaXO8ew8eSq79Vxe1m2LRv1OYOxZoaVoE1TDcCBlSPo1Bt5DwmtquCPs7/ZStZMPfpu+QCatKAIzkX9xPo62m0wBu/J5P5NYvblMvtwSRjpwiBc3jwAiiTG9X7c9ggiRhtfcc7/lkXoDJH8kem/8hIW27bLB8A1kSE0NmdQu4LbwKLzu0w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Jun 2025 10:35:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15784 invoked by uid 111); 23 Jun 2025 10:35:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Jun 2025 06:35:50 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Jun 2025 06:35:50 -0400
From: Jeff King <peff@peff.net>
To: kryzet <hassankhalloof20@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: repository maintenance: git prints warning messages while
 cloning https://github.com/git/git.git
Message-ID: <20250623103550.GA649507@coredump.intra.peff.net>
References: <CAB2ApcOds+SZszEHhMwG5YvxQcRE01jKgP1modo1WhcwWeGeYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB2ApcOds+SZszEHhMwG5YvxQcRE01jKgP1modo1WhcwWeGeYA@mail.gmail.com>

On Sun, Jun 22, 2025 at 07:00:49AM +0000, kryzet wrote:

> While cloning the source code repository from
> https://github.com/git/git.git, the following warnings are printed:
> 
> warning: object d6602ec5194c87b0fc87103ca4d67251c76f233a:
> missingTaggerEntry: invalid format - expected 'tagger' line
> warning: object 2b5bfdf7798569e0b59b16eb9602d5fa572d6038: badFilemode:
> contains bad file modes
> [...]

These are fsck warnings. Presumably you've enabled transfer.fsckObjects
(or fetch.fsckObjects) in your config file.

These lines are expected for git.git. It's an old project, and there are
objects in the early part of the history that have some (mostly
harmless) quirks. In this case, the v0.99 tag doesn't have a "tagger"
field, and a number of old tree entries have mode "100664" rather than
"100644" (we later standardized on a few modes, since recording the
exact group mode on people's systems was prone to noise).

Since a git clone transmits the full history, those funny objects will
live on forever.

You can safely ignore them, but if you want to quiet the noise you can
put:

  [fetch "fsck"]
  badFileMode = ignore
  missingTaggerEntry = ignore

in your ~/.gitconfig file.

-Peff

PS There's one other small oddity, which is that running "git fsck" in
   the resulting clone will show only the tag warning. That's because
   fsck doesn't check badFileMode unless you also pass "--strict". But
   fetch/push checks are always done in strict mode. TBH I am not sure
   that is wise, but the behavior here is mostly historical. I suspect
   it would be good for somebody to take a careful look and clean up the
   severity of the various warnings (some of which are security
   relevant, and some of which are just mild misconfigurations or old
   bugs).
