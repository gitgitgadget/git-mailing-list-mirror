Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D6AD53
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 13:08:38 -0800 (PST)
Received: (qmail 5925 invoked by uid 109); 6 Dec 2023 21:08:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Dec 2023 21:08:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28662 invoked by uid 111); 6 Dec 2023 21:08:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Dec 2023 16:08:39 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Dec 2023 16:08:36 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
Message-ID: <20231206210836.GA106480@coredump.intra.peff.net>
References: <20231117203253.21143-1-adamm@zombino.com>
 <20231128142845.11523-1-adamm@zombino.com>
 <20231128190446.GA10477@coredump.intra.peff.net>
 <ZWethlRRtuQLDRlJ@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWethlRRtuQLDRlJ@nand.local>

On Wed, Nov 29, 2023 at 04:30:46PM -0500, Taylor Blau wrote:

> On Tue, Nov 28, 2023 at 02:04:46PM -0500, Jeff King wrote:
> >   - whatever is consuming the embedded repos could "mkdir -p refs
> >     objects" as needed. This is a minor pain, but I think in the long
> >     term we are moving to a world where you have to explicitly do
> >     "GIT_DIR=$PWD/embedded.git" to access an embedded bare repo. So
> >     they're already special and require some setup; adding an extra step
> >     may not be so bad.
> 
> I hope not. I suppose that using embedded bare repositories in a test
> requires additional setup at least to "cd" into the directory (if they
> are not using `$GIT_DIR` or `--git-dir` already). But I fear that
> imposing even a small change like this is too tall an order for how many
> millions of these exist in the wild across all sorts of projects.

I dunno. I am skeptical that there are millions of these. Who really
wants to embed bare git repos except for projects related to Git itself,
which want test vectors? Is there a use case I'm missing?

-Peff
