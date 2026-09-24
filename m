Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2887543B6C5
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 23:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790293049; cv=none; b=fKWjheVG2r8NwLNJr0K/qCD7QLUrYoDxq/wF6g4O8TSCCr4OMhusD3O7RlSK7GwOyY7hmvSd7CQoy0xvwyVhUAbO6vj0jTZcOfCZvzrPNsfrKQe8sDlOdI7JieCoU0l3gz88CdROXwLJqZxftKxPXb+Vnk/F+8X6eKxMoMj9YNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790293049; c=relaxed/simple;
	bh=jb8rtllySQiU/YyAWoioMnan44E/S3x862/SsdhzeC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y19VixgkUSIq8bL5+ZH7YR8H+UobdmUvQZ8mKVMysHFGlxEjC59u3I3DJL6Fkh7ButzCY4aoGe5IUr7hE5v5n0D4R/Ej+kTqrNJLOrOItGlrYPNvW1XYhQntygCUfjV7vm6G/gTmCz09AjZqxcAGDSRBys0N1dBojxV1tZmGVTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Y72bzJSp; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Y72bzJSp"
Received: (qmail 49159 invoked by uid 106); 24 Sep 2026 23:37:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jb8rtllySQiU/YyAWoioMnan44E/S3x862/SsdhzeC4=; b=Y72bzJSp4y2Q6Rwr+c8nJZ0BjRlNkZST9XywFQiE1ok45FwDIaB9hwQc/cChocGnZxFWAqCOT40oSFcfelmqrtNXSlVyerHEe8fcz+SchGblNwqXjJhCsPDfHQaHG9vUTw0dfhIz2/+Vm0E2CgCsSxmECWrupOTF//vEWcLUoV9mU4aap98VFyWoXq5+QPKr47Fu78vadkdb1u34iUHJXZiqi81p/Qoe1sFV1ul/xHyrDo4B3HSVvNyJ/MQr4YZV1BhUzUYkj1GMq0yC0QKkYColIm/R1n6A2IibLae1t3/iLZV4gh27e2T3OxMnPE7MOTpVYLHz4MrHG+hXp+4FSg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Sep 2026 23:37:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 198067 invoked by uid 111); 24 Sep 2026 23:37:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Sep 2026 19:37:26 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 24 Sep 2026 19:37:26 -0400
From: Jeff King <peff@peff.net>
To: Julia Evans <julia@jvns.ca>
Cc: Junio C Hamano <gitster@pobox.com>,
	Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 0/7] [doc] Add new page on merge conflicts
Message-ID: <20260924233726.GB765100@coredump.intra.peff.net>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <xmqq33uyz3yp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq33uyz3yp.fsf@gitster.g>

On Thu, Sep 24, 2026 at 03:20:30PM -0700, Junio C Hamano wrote:

> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > Julia Evans (7):
> >   [doc] Add new gitmergeconflicts man page
> >   [doc] git-merge: link to new merge conflicts guide
> >   [doc] git-rebase: link to new merge conflicts guide
> >   [doc] git-revert: link to new merge conflicts guide
> >   [doc] git-cherry-pick: link to new merge conflicts guide
> >   [doc] git-pull: link to new merge conflicts guide
> >   [doc] ignore conflict markers in gitmergeconflicts.adoc
> 
> With this merged, 'seen' seems to fail
> 
> 	$ make check-docs
> 
> with these lines at the end
> 
>             ...
>             MKDIR -p .build/lint-docs/doc-style/includes
>             LINT DOCSTYLE includes/cmd-config-section-all.adoc
>             LINT DOCSTYLE includes/cmd-config-section-rest.adoc
>             GEN lint-docs-manpages
>         no link: gitmergeconflicts

Weirdly applying Julia's patches myself did not result in the same
error. It's only when they're merged to seen. Ah. It's due to
ta/command-list-guides-sync-lint, which isn't yet in master.

I think that is giving us a good signal, though. The guide should be
mentioned in command-list.txt, so that it is linked from git(1). See
c655855559 (doc: git: list gitdatamodel(7) as a concept guide,
2026-09-05) for some prior art.

-Peff
