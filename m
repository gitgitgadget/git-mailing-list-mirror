Received: from mta0.migadu.com (out-36.mta0.migadu.com [91.218.175.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B686F4A2A72
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173380; cv=none; b=to8YsUI6LWjepY7Kn4J4bG9fxYLvajH92xc9TjBkKnkMVxWWJZP7ibp22U4oFh6kgZ+X/jz8tm7BrpptMcvoovK9AE6sTt0OBrS6uFKvzR18tzGkI/akT9ulO7ypdCzP2oSfi6LqsnkRpDG1S3tr7UZAH+GmDm0bXrYRuw0e2pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173380; c=relaxed/simple;
	bh=5iK54b0YWcR0jjjnxLaKQPFNEzD4zuAvDh5IfmC2haw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ArfVhAvmIh+OAAUwVwAn1jJSYGd6UyBKGjNHaB9WyCOiTcpNAU0v1i8fDSiUOWeJTjZLkzYny7x1SO5eh9GRzbzGSoXn92P19U9fAMWTKoEH5Gpobs+nuCQnx4hnRcH2o6HmZg17pJ1cqbV+0e1i1qR1t3I5cFr9SZMZkTQHSe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=f7KRtSzZ; arc=none smtp.client-ip=91.218.175.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="f7KRtSzZ"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5iK54b0YWcR0jjjnxLaKQPFNEzD4zuAvDh5IfmC2haw=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790173373; v=1; x=1790778173;
 b=f7KRtSzZWNx2tWWkVl2dWy9H9RI8MRuh1Ouip4SGGN+4TeBth7pY8/9kELD7iL7+HlPRFX/m
 +t6ToI1/yojAG7H3Pud21HY+9U4/rvPfiQbjgmKNeFIWvZQjgNBIoF+PjxKfT8PZH6BHF2+Xv39
 AkiyioZc73nPozOStysf8Uf4=
X-Envelope-To: git@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 67b682bb5f72af5e;
	Wed, 23 Sep 2026 14:22:52 +0000
X-Mizu-Trace-ID: 67b682bb5f72af5e
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano
 <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: Security mailing list & process, was Re: My summary of the Git
 Contributors' Summit 2026
In-Reply-To: <5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de>
References: <xmqqwlsei1pv.fsf@gitster.g>
 <76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de> <xmqq4ifhgzvx.fsf@gitster.g>
 <5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de>
Date: Wed, 23 Sep 2026 16:22:47 +0200
Message-ID: <874ifg11zc.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Security mailing list and process

(I decided to split up this topic into a separate mail thread)

> The security list is seeing a large influx of outside reports, apparently
> often AI-assisted or generated. Duplicates and reports outside Git's
> security model consume triage time, while some patches have waited for
> months. Waiting for an empty queue is not a workable release criterion: we
> need to release the fixes we have, rather than hold them indefinitely
> while more reports arrive.

I think we agreed on that. Because we realize the influx will not stop
any time soon.

> No fixed release cadence or guaranteed response time was settled.
>
> Documenting Git's security model would save repeated explanations of what
> does and does not constitute a vulnerability.

This is something I was planning to drive after the summit, so I agree.

> (Personal note, not discussed at the Summit: Stolee had tried to start
> a conversation about Git's security boundary a long time ago, but
> nobody replied.

I was not aware of that, maybe that happened before I started
participating there. But I'm happy to get that conversation going again.
I'll try to digg up that discussion.

> Maybe the AI onslaught will provide enough motivation to get that
> discussion going.)

Yes.

> Moving non-security bugs to the public list more readily was also
> encouraged.

That is true, but then still someone has to do the work. We're already
lacking people to work on /real/ reports, so having people to fix bugs
reported is also a staffing issue.

> A timeout after which public discussion would be presumed OK was
> proposed, but not agreed.

I'm against that, but I don't think we need to agree on that already. We
can think about this after settling the other stuff.

> More company staffing would help, without turning this into an obligation
> for volunteers. Paying for dedicated help was discussed, with onboarding
> costs a concern.

All I can say for now, we at GitLab plan to invest more people power
into dealing with security reports.

> Using AI for triage or fixes raises confidentiality and DCO questions
> of its own. (Personal note: There seemed to be some sentiment in the
> room that contradicted the earlier agreed-on finding on the mailing
> list that using AI for triaging and for investigating wasn't a
> copyright concern and should therefore be considered permissible.)

Yeah, no consensus here. The concern wasn't as much copyright, but
passing vulnerabilities to a model, making it possibly train on that
exposing that information to who-knows-where.

> The release bottleneck is not really tag automation. Merging and
> backporting fixes, preparing advisories, and handling CVEs take work, and
> too much of that knowledge lives in people's heads. Peff volunteered to
> start a public discussion of the process and dig up existing resources.

As I pointed out during the conversation, I just don't know how to do
this.

> (Personal note: I have done that merging, backporting, etc plenty of
> times, and I don't think that it is the bottleneck, and I was rather
> surprised to hear that it is complicated.

It's complicated, because we (or I at least) doesn't know how.

> Sure, there are the expected merge conflicts when merging `maint-*`
> branches, and running -- and fixing! -- CI on all of the tags in a
> private repository should go without saying, but that's all craft of
> the trade.

I'd love to learn more about this.

> Rather, the indecision and lack of engagement on the
> git-security mailing list is what I see as the blocker. I'd happily
> volunteer to juggle those branch thickets if that was truly the
> make-or-break issue here.)

I'm very grateful for that. As I mentioned (not sure that made it into
the notes), I'd love to shadow someone doing this to learn from. This
can help me get this going myself and that would distribute the load and
knowledge among more people, for which seems to be a real need.

> Microsoft's release process reportedly needs about seven weeks. There were
> no objections in the room to proceeding without waiting for that schedule.
> (Personal note: That release process was misrepresented, which is
> surprising

I wouldn't say this is surprising, I think most people just don't know
the details.

> as I coordinated two or three Git for Windows security bugfix
> releases _on the git-security list_ since the most recent Git security
> bugfix release, it's always the same thing: release on a second Tuesday of
> the month, three weeks before that the patches need to have settled,
> everybody goes home with a dependable timeline.

Well, thanks, that's clear.

Personally I think we can try to follow that schedule, if possible. We
currently have a few patches waiting for months to be released, and
that's not because of the Git for Windows release schedule, but more
because the lack of call to action. Those easily can get out with the
GfW cadence.

But some other cases, like the 0day Elijah has been working on this
month, I'm not sure that can wait for GfW?

> It's not really that big of a deal. Testing patches, constructive
> feedback, these are the things that are missing and therefore blocking
> the process. I sensed a lot of finger-pointing in this discussion.

I wouldn't say so, I would blame it on the lack knowledge about the
process. Or maybe that's only me speaking.

> I mean, I don't blame anybody for avoiding security work: it is
> stressful and intense. The responsibility for getting things wrong is
> enormous. I know that because I've done my share of that, probably
> more than most in the Git project, and I will do even more in the
> future.

That's why I'd like to learn from you.

> But when I don't have the time, or the energy, I am aware that
> I, myself, am the bottleneck; I don't need to blame others.)

You are not the bottleneck, or at least, you don't need to be the
bottleneck, we should set up things to spread out the load.

So I would like to suggest you and me collaborate closely to get a next
security release out and then we can go from there.

-- 
Laters,
Toon
