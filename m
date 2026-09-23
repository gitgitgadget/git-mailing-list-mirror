Received: from mta1.migadu.com (out-79.mta1.migadu.com [95.215.58.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B924CCDC0
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174472; cv=none; b=OGYHfyDvyDU1C57n3nOXARiYDl2cTV5Nq9zCC7oSH9+SgDlHmSvqGVXKg7MLfg0gm7rDAUrB3N0slgwaafU57VfTzXvorwHHkKGFxdc4qXz1PHOr+1HpiOgMg0DB+VLHkPrAmQkR+cFjV/ON3buDn40Yx28jQl84BDFL383XV/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174472; c=relaxed/simple;
	bh=wj5T2SLW4ej2oNqQFaz5Mt1XeAmmK7pHYBlJTWi4e0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nJ9T4eO/M3t4aMk7BZWKuKoclqqE9H8vZG0DY769+63f78wowWiApKcI4Pi+uI/utaTgB7gpdfT3UORrML31pJ54ctp594tSK6ED4GR7RVUK6KkK8SJ49aRv4IWr4ws6mjAGkI1R0WdrOeSdMeDoswmkrxcfd6vDr3TrnazTDOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=nZNHmAft; arc=none smtp.client-ip=95.215.58.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="nZNHmAft"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wj5T2SLW4ej2oNqQFaz5Mt1XeAmmK7pHYBlJTWi4e0k=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790174465; v=1; x=1790779265;
 b=nZNHmAftnkGEXzvWpr3YijRVlsDEVqy+0WEEp/2YWPFFGbY3WIuHsq0kosIUKg6jUrPM60y/
 +A1QtbazJoZX4HVUwtCjWSWetiIEldxzmONbbtkH1sAOG05Af5EzV/+7kU0h9Xlhh/XXP6b9cnq
 vwtCwY9GveOyWHh6jUa29pqU=
X-Envelope-To: git@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 5206c69c2a952ab5;
	Wed, 23 Sep 2026 14:41:05 +0000
X-Mizu-Trace-ID: 5206c69c2a952ab5
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano
 <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: Git Contributor' summit: Documentation, was: Re: My summary of
 the Git Contributors' Summit 2026, was Re: Git v3.0 timeline, was Re:
 What's cooking in git.git (Sep 2026, #08)
In-Reply-To: <5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de>
References: <xmqqwlsei1pv.fsf@gitster.g>
 <76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de> <xmqq4ifhgzvx.fsf@gitster.g>
 <5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de>
Date: Wed, 23 Sep 2026 16:40:58 +0200
Message-ID: <871pak1151.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Documentation
>
> Julia's work highlights the gap between documentation written by people
> who know Git inside out and users who do not yet know what objects, the
> index, or upstream mean. We need approachable learning material as well as
> reference documentation. Both need work; keeping manpages concise does not
> mean they cannot have better explanations and examples. (Personal note: I
> am beyond excited that Julia, whose work I have always admired, 

I've expressed myself multiple times as well how excited I am to have
Julia working on this, but it cannot be expressed enough.

> got interested in improving Git's documentation, which is in dear need
> of being improved, mainly because it does not cater to the majority of
> Git users out there who are unlikely to wander onto the Git mailing
> list, ever. I just hope that old-timers who really do not need the
> documentation nor understand the need of those who do need it show
> enough appreciation for the fresh views and for Julia's understanding
> of the target audience.)

I think the old-timers do, but it takes skills to have a very deep
understanding and still being able to explain things to newbies.

> Discoverability matters, too. The website (https://git-scm.com/) needs
> clearer entry points for learning Git, and existing guides are harder to
> find than manpages. Missing subsection links are another improvement we
> could make incrementally. (Personal note: Judging by the history of that
> site, I do wonder whether the core Git contributors are interested in
> helping this effort at all. For example, there are a growing number of PRs
> suggesting to add new UIs to the growing list, but I gave up reviewing
> them because I was the only one doing so.)

I share the blame here. Some time ago I volunteered to step in to do
maintainance work on git-scm.com, but I haven't been devoting as much
time as I would like.

Talking about the UI list, that's a problem which I'm not sure worth
discussing here, but to folks interested, there is some context in the
PR[1] you created.

[1]: https://github.com/git/git-scm.com/pull/2179

> There was support for replacing outdated material and for merging useful
> improvements, then iterating, rather than trying to perfect everything
> before it lands. Bringing user feedback to the list without flooding it
> remains a challenge.

Iteration will be key here, and I would say some steps have been taken
already. Very tiny steps though.

Finding a medium to gather user feedback is the problem. I think Discord
is a better place than the mailing list (assuming that's what you mean
by "list"?).

> The current funding covers only 100 hours split between two people.
> Additional project and company funding was encouraged; brian, Emily, and
> Mark offered to explore company support. (Personal note: I had tried, back
> when GitHub still funded my team, to start something like that, without
> any success. To the contrary, even Git for Windows and Git Credential
> Manager got defunded.)
>
> On the tooling side, using only Asciidoctor instead of maintaining both
> AsciiDoc and Asciidoctor support was proposed as a possible Git v3.0
> change. Distribution support and rendering differences need checking, with
> doc-diff suggested for comparing the outputs. Patrick filed an issue
> during the discussion. (Personal note: AFAIU the AsciiDoc spec is now
> maintained by Asciidoctor, and I am aware already of one change that was
> made to the spec without adapting AsciiDoc accordingly. So the entire
> discussion might be quite moot already.)
>
> Other ideas included richer diagrams for HTML while retaining text
> versions for manpages

This feels feasible. I think brian suggested to use Open Blocks[2] and
have a man-page ASCII version next to /something else/.

[2]: https://docs.asciidoctor.org/asciidoc/latest/blocks/open-blocks/

> and privacy-respecting traffic measurements to help prioritize
> documentation work.

For the record, we have been talking about this[3] in the past.

[3]: https://github.com/git/git-scm.com/issues/2054

> No diagram format was chosen

Yeah, that's the issue.

> and caching and AI scraping complicate getting useful traffic data.
> Mermaid was proposed, and even GraphViz. (Personal note: I added
> support for Mermaid diagrams to https://git-scm.com/, but it turned
> out to be too limited, so I added GraphViz support. The support code
> for this is a bit of a beast, having a wasm version of GraphViz for
> development, pre-rendering the diagrams as SVG and as PDF during
> deployment of the site; it was quite a bit of fun to implement all
> that.)

Thanks for that! They don't look bad on the cheat sheet[4].

[4]: https://git-scm.com/cheat-sheet#combine-diverged-branches

-- 
Laters,
Toon
