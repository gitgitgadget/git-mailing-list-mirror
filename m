Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BB61E283B
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370385; cv=none; b=Z321CfoRZqFwd5GOHX3P68KAUqATR2DeK7gVu5W7DKVK0Ecle4AZ6utjQdlYYDOjEgck+kxMJ7TaGwDe9K7I8Pv/zOoEe8mxGYHrR9jfEFwif6vfxBdd69ZhxG1IDoUbPUZ9xqtDfSMN0LLNcbLjGD49fn7jE9n5RP4kkCTyHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370385; c=relaxed/simple;
	bh=yQdAkzTKjIt9E55sAUnI7UsNn3PUeGQLr7kURO0tPNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYydnICee7+Tx/8cJgXT/kggKfSJqqfRdGd1C/Nk7C1DLusJpqxVq7Kl4rIb3y994CbMBWzKGRljc3WD4+vsrFhf+NTGbwl7URnL6tpro4fhkzaBdgRRnd3N8kjPMVWoX0cg9B2NTzfsQtv+coLBx7L4XvHUL9ig4N5oq73cIyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VChcMvLV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VChcMvLV"
Received: (qmail 8931 invoked by uid 109); 8 Oct 2024 06:52:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=yQdAkzTKjIt9E55sAUnI7UsNn3PUeGQLr7kURO0tPNE=; b=VChcMvLVN/mK0nfwDL6KYZVG7Nmh1dvrWJMu9x0qp+qwFEO8RaMb7r/+hYKwzRlewkq/6qCoOrQbrLoawJzLABs8Ws7TGdHppBrAqfODFueA8UxuYBBmddGj9yYFqQRyJEgeyKX9yxIUHAcWbPppM29QVxmHplARj1PEgbwtLX7qyRs/Au6EHRv1pU1xX4W6kLnSpK/lsvLU5vof/pNact1Qxd35kU1xzA8m0rjyruOLlTB7qEIYqDzY2YOB1+m77eZRy1LY3MXHHMbl1l7HkKrUJt0REbWdzNHKysDoBgDA10MNFzpfY7oIhIE6EtUE4tZMntWfM5WmhpMzlYK4lw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Oct 2024 06:52:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15096 invoked by uid 111); 8 Oct 2024 06:52:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Oct 2024 02:52:55 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 8 Oct 2024 02:52:55 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] object-name: don't allow @ as a branch name
Message-ID: <20241008065255.GA676291@coredump.intra.peff.net>
References: <cover.1728331771.git.code@khaugsbakk.name>
 <b88c2430f88b641d69e5f161d3a18cce113a81c9.1728331771.git.code@khaugsbakk.name>
 <20241007204447.GB603285@coredump.intra.peff.net>
 <9a64a58b-3d08-44b4-96a5-9031863de4f1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a64a58b-3d08-44b4-96a5-9031863de4f1@app.fastmail.com>

On Mon, Oct 07, 2024 at 10:56:36PM +0200, Kristoffer Haugsbakk wrote:

> > There's a bit of subtlety here which makes the term "invalid" somewhat
> > vague. The refname "refs/heads/HEAD" is allowed by plumbing, as we try
> > to maintain backwards compatibility there. So the current prohibition is
> > just within the porcelain tools: we won't allow "git branch HEAD"
> > because it's an easy mistake to make, even though you could still create
> > it with "git update-ref".
> 
> Got it.  Creating this one (or something like `refs/heads/HEAD` for that
> matter) is allowed by the plumbing tools.  But the porcelain ones are
> blocked.
> 
> Also the plumbing query `git check-ref-format --branch @` now returns
> false.  Since it has to harmonize with what the branch creation
> porcelain can do.

Yeah, good point. I was thinking the existing test was purely about the
git-branch porcelain, but "check-ref-format --branch" follows the same
rules.

> > And naturally we'd want the same rules for "refs/heads/@". I think it
> > might be worth adding "...in plumbing" to the end of the subject, and/or
> > calling out this distinction in the text.
> 
> Did you mean something like “disallow in porcelain”?

Oops, yes, I had it backwards. Good catch.

-Peff
