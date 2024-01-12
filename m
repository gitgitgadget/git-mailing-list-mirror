Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD065C90C
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9760 invoked by uid 109); 12 Jan 2024 07:31:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Jan 2024 07:31:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15148 invoked by uid 111); 12 Jan 2024 07:31:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 Jan 2024 02:31:38 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 12 Jan 2024 02:31:36 -0500
From: Jeff King <peff@peff.net>
To: "Matthew B. Gray" <hey@matthew.nz>
Cc: git@vger.kernel.org
Subject: Re: Help: Trying to setup triangular workflow
Message-ID: <20240112073136.GG618729@coredump.intra.peff.net>
References: <b59c59f6-29e1-4d67-bace-13adcc108454@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b59c59f6-29e1-4d67-bace-13adcc108454@app.fastmail.com>

On Fri, Jan 12, 2024 at 03:23:58PM +1300, Matthew B. Gray wrote:

> Here's what I get from running the documented example:
> 
>   λ git config push.default current
>   λ git config remote.pushdefault myfork
>   λ git switch -c mybranch origin/main
>   λ git push
>   * [new branch]          mybranch -> mybranch
>   branch 'mybranch' set up to track 'myfork/mybranch'.

This push step is rewriting your upstream config. Do you have
push.autoSetupRemote configured? In general you wouldn't want that for a
triangular flow.

Though I think it also is only supposed to kick in if there is no
tracking configured already. Why did the "git switch" invocation not set
up tracking itself? When I run those commands it does. Do you have
branch.autoSetupMerge turned off in your config?

-Peff
