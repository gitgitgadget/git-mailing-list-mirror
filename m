Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B9E1A72F
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9475 invoked by uid 109); 12 Jan 2024 06:57:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Jan 2024 06:57:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14929 invoked by uid 111); 12 Jan 2024 06:57:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 Jan 2024 01:57:34 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 12 Jan 2024 01:57:32 -0500
From: Jeff King <peff@peff.net>
To: Victoria Dye <vdye@github.com>
Cc: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/3] t7450: test submodule urls
Message-ID: <20240112065732.GC618729@coredump.intra.peff.net>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
 <cf7848edffca27931aad02c0652adf2715320d35.1704822817.git.gitgitgadget@gmail.com>
 <20240110103812.GB16674@coredump.intra.peff.net>
 <d852ad72-32c4-4b0f-8f34-e8b38b7f71ad@github.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d852ad72-32c4-4b0f-8f34-e8b38b7f71ad@github.com>

On Thu, Jan 11, 2024 at 08:54:47AM -0800, Victoria Dye wrote:

> > All of this is inherited from the existing check_name() code, which I
> > think has all of the same bugs. The test scripts all just use the stdin
> > mode, so they don't notice. It's not too hard to fix, but maybe it's
> > worth just ripping out the unreachable code.
> 
> Thanks for pointing out those issues, I think removing the command line
> input mode is the way to go. The description of the 'check_name()' mentions
> that the stdin mode was "primarily intended for testing". But as 85321a346b5
> (submodule--helper: move "check-name" to a test-tool, 2022-09-01) pointed
> out, 'check_name()' was never used outside of tests anyway, so whatever use
> case was imagined for the command line mode never seemed to have existed. 
> 
> Combine that with the fact that the command line mode is so different from
> the stdin mode (non-zero exit code for invalid names, prints nothing vs.
> zero exit code, prints valid names), there don't seem to be any real
> downsides to removing the unused code.

That sounds like a good plan to me. :)

-Peff
