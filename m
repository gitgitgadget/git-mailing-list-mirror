Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B73F39B
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 01:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F0ACE
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 17:36:48 -0800 (PST)
Received: (qmail 6933 invoked by uid 109); 15 Nov 2023 01:36:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Nov 2023 01:36:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23308 invoked by uid 111); 15 Nov 2023 01:36:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Nov 2023 20:36:50 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Nov 2023 20:36:46 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by
 default
Message-ID: <20231115013646.GA15245@coredump.intra.peff.net>
References: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>
 <ZVNNXNRfrwc_0Sj3@tanuki>
 <xmqq7cmkz3fi.fsf@gitster.g>
 <xmqqzfzgxops.fsf@gitster.g>
 <20231114194310.GC2092538@coredump.intra.peff.net>
 <xmqq4jhnyhe1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4jhnyhe1.fsf@gitster.g>

On Wed, Nov 15, 2023 at 09:44:38AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > What I'm getting as it that I think we have three options for v2.43:
> >
> >   1. Ship what has been in the release candidates, which has a known
> >      performance regression (though the severity is up for debate).
> >
> >   2. Flip the default to "0" (i.e., Patrick's patch in this thread). We
> >      know that loosens some cases versus 2.42, which may be considered a
> >      regression.
> >
> >   3. Sort it out before the release. We're getting pretty close to do
> >      a lot new work there, but I think the changes should be small-ish.
> >      The nuclear option is ejecting the topic and re-doing it in the
> >      next cycle.
> >
> > I don't have a really strong preference between the three.
> 
> I've been (naively) assuming that #1 is everybody's preference,
> simply because #2 does introduce a regression in the correctness
> department (as opposed to a possible performance regression caused
> by #1), and because #3 has a high risk of screwing up.
> 
> As long as the performance regression is known and on our radar,
> I'd say that working on a maintenance release after Thanksgiving
> would be sufficient.
> 
> I might be underestimating the impact of the loss of performance,
> though, in which case I'd consider that nuclear one, which is the
> simplest and least risky.

I am fine with #1 for the release. Mostly I just wanted to understand
what the plan was (and if we needed to be hurrying to try to make the
non-nuclear #3 work).

-Peff
