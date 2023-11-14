Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207B7156E2
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DCEBA
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 01:05:08 -0800 (PST)
Received: (qmail 30099 invoked by uid 109); 14 Nov 2023 09:05:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Nov 2023 09:05:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13241 invoked by uid 111); 14 Nov 2023 09:05:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Nov 2023 04:05:11 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Nov 2023 04:05:06 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: commit-graph paranoia performance, was Re: [ANNOUNCE] Git
 v2.43.0-rc1
Message-ID: <20231114090506.GA2107135@coredump.intra.peff.net>
References: <xmqq8r785ev1.fsf@gitster.g>
 <20231113205538.GA2028092@coredump.intra.peff.net>
 <ZVMz4iDWfC__H8Jp@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVMz4iDWfC__H8Jp@tanuki>

On Tue, Nov 14, 2023 at 09:46:26AM +0100, Patrick Steinhardt wrote:

> > Should we default GIT_COMMIT_GRAPH_PARANOIA to "0"? Yes, some operations
> > might miss a breakage, but that is true of so much of Git. For day to
> > day commands we generally assume that the repository is not corrupted,
> > and avoid looking at any data we can. Other commands (like "commit-graph
> > verify", but maybe others) would probably want to be more careful
> > (either by checking this case explicitly, or by enabling the paranoia
> > flag themselves).
> 
> I'd be fine with that as a follow-up change, yes. I agree that in
> general we shouldn't see this kind of corruption, and it's good that the
> behaviour can be toggled so easily now.
> 
> I'm happy to write that patch if you don't plan to.

I hadn't started on it, so please feel free to go ahead.

-Peff
