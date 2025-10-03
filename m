Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18091DB13A
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759491725; cv=none; b=AtzBVQSpPYGEMm6UJdRm6N9prB2ynQU8HKy9CoCQkx37pQoDignJbv1klk6LC0RX62qZpS9o5C+AEdElY6OFjMwN6ym2J8bEQsJjlS+KmZwUAb/r+6QlvPBdGEgfzBe36KYx4IfOBC/R9EvfHP39dvAygJwwIJ8zxRVPvRqwuZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759491725; c=relaxed/simple;
	bh=JaDNro2xHfMeqE3BKlcONeSlfKuolm28U/3E6hb+lyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0I4rexJNmr6l9/GcR/SrmBC8DKQvZKcLNbreULrLfNoT+I6U19XOj12XvXOVHPT0wqTVbvMVtU4o76iY/Cw/88Dm4C7h/80NnEGwqDMgVp3zzyLhMA6kPyKXziILJ4CcThOsvMb6/m0lfdcuLcxNjcXfCf7mUlnCzMWvk9Vf1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=dCBZuNYF; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="dCBZuNYF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759491715; x=1760096515;
	i=oswald.buddenhagen@gmx.de;
	bh=yQFSh4zKAPULQpQRVHVBZ+unAB9AhwkM4oe4OEq9hSM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dCBZuNYFNW/zYqByDhky/XNJWlIng+bCVa8ntlhb8rurRIuisfAeTmbRbjHdZsQU
	 7vIDHWlTLkO7O1K0P+uQsSBtOQVkygzZMLnA7ZmONgSbSbkhNTh4ya4sko2ZM3Wm7
	 GH2azoJ4SVDQVupoHkY/356Iq0Q8hGZvYtRJp3OekwaD9Ch7dp1Rej/f58JZj9pZI
	 XZBmDQiFOoM67ZRqzvNridO+fNITlSIFMO6wRBTQz/LbfL55bqkjyaxcuekpbwKgu
	 bwo6g06XgjtP8FV9z6dBdaRQNW215xJt/bz0KhmEaFpComDQlqIdz34J19PSaOe4a
	 QXK369f/n0LtS7jlGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.107]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Jn-1uQcWg1ue9-00aB5G; Fri, 03
 Oct 2025 13:41:55 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1v4eAc-JCi-00; Fri, 03 Oct 2025 13:41:54 +0200
Date: Fri, 3 Oct 2025 13:41:54 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>, git@vger.kernel.org
Subject: Re: customizing "cherry picked from commit abcd" comment
Message-ID: <aN-2gtXhBFoW5Gw5@ugly.lan>
References: <87v7l18nnt.fsf@prevas.dk>
 <aNus0ulSTb4rAYdF@ugly.lan>
 <xmqq5xd054r2.fsf@gitster.g>
 <aN0TVmEMXOyDZEwR@ugly.lan>
 <xmqqa52ayq4q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqa52ayq4q.fsf@gitster.g>
X-Provags-ID: V03:K1:mNbdNrf77E4ZyHNsUyWr5572Bj/bxEVAXbeNROLjiWsfRY0PD76
 zuwIeVOY1/XilCXs1hP13rmCiSqEuTFMaV7cXnRnSpLVnNDkClJhEoiIle/DIufCEyXJDLi
 0btyrsHAKn8FRxz+OQAkJ+cb6LETE6VbVL8GulWfocWzBzF3RuI8PRi6idhPndaqIvZMJHr
 ZoWleRtfB4qj2SevhzSPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TJuF/rRuuws=;T7IXDJL4tizySQxA0uxW78SGKaH
 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
 sCkqmvaZQyaU6tFx6mG+0tbcmU=
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2025 at 07:49:25PM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>>>I do not know what "an ideological commitment" refers to in this
>>>context,
>>>
>> it refers to the general notion "don't cherry-pick, but merge", which
>> relegates cherry-picks to being a 2nd-class workflow.
>
>Ah, that is not ideological at all, but aversion against
>cherry-picking is purely technical.
>
yes, but it presumes idealized circumstances, which aren't always=20
realistic. insisting on it regardless makes it ideological.

>With only "cherry picked from" trailer, there is no structural link=20
>between the commit that introduced the original change and the=20
>resulting commit.
>It would make it impossible to automatically and reliably take previous=
=20
>cherry picks into account when merging back a side branch or older=20
>maintenance track that are riddled with cherry picks.
>
that's a circular argument, because it refers back to the current=20
(rather bare-bones) implementation of cherry-picks.

>Compared to
>that, a more disciplined approach to (1) fork a topic from the
>oldest potential target of eventual cherry pick and develop your
>solution there, (2) merge the result to the mainline first, per
>trunk-first philosophy, (3) then merge the same down to the older
>targets, is always preferable.  That way, the fact that your
>solution is applicable even down to the "oldest potential target" is
>structurally encoded in the history even at step (1) by the choice of
>the fork point, and with (2) and (3), it is obvious from the history
>structure that the mainline and the older target both have the same
>solution applied.
>
well, yes, this sounds very nice ... "on paper".

but in reality, most people (incl. devs) aren't particularly disciplined=
=20
by default, and it's a bit naive/presumptuous to think that one could=20
educate them by withholding features that would make the result of=20
suboptimal processes suck less (cf. the recent discussion about=20
automating sign-offs [1]).

but let's assume an ideal culture where people are actually committed to=
=20
doing things the right way. then we still face a host of practical=20
problems:

firstly, it's often not obvious what the oldest target branch should be. =
=20
improved tooling (that can be realistically implemented) would go only=20
part of the way, because the reasons for fixes failing in old branches=20
are often subtle and unexpected. therefore, it is much more practical to=
=20
to actually fix the trunk first, and then opportunistically try to=20
backport branch-by-branch as far as the trade-offs are deemed=20
reasonable.

secondly, in your model, the fix needs to be tested on both its primary=20
target branch and each newer branch it gets merged to - a priori, before=
=20
it gets merged anywhere. in a big project with CI runs taking hours (and=
=20
being flaky, as they always seem to be), this is a _massive_ practical=20
problem.

thirdly, it happens often enough that the merge isn't clean, or some=20
logical conflict occurs (see first point). in that case one has to=20
"hide" the fixups in the merge commits (which makes it incredibly hard=20
to follow them later on), or pile fixup commits on top (making things=20
non-atomic, which also doesn't help). in such cases it is much more=20
"honest" to actually have entirely separate commits on the branches,=20
with only weak links between them.

lastly, even if everything goes well, the resulting overall history is a=
=20
tad hard to comprehend when many fixes and branches are involved (the=20
benchmark being "gitk --all"). linked cherry-picks would still have to=20
be visualized, so the problem wouldn't go away entirely, but weak links=20
could be shown in a way that does not distract from the core tree=20
structure (in a cherry-pick-only model, the only merges are those of=20
feature branches to trunk, so the release branches actually form a tree,=
=20
not a dag, and are therefore much easier to follow).

>I am not sure exactly what you refer to "well-integrated support" in=20
>this context.
>
- built-in tools actually use it to its full potential
- 3rd-party tools make heavy use of it, thanks to it being standardized
- manual intervention is rarely necessary, everything "just works"

>But I do not think I would appreciate the vague "well, this is not
>parent-child ancestry relation at all, but this commit and the other
>commit that is totally unrelated in the history space are somehow
>related, so let's add a random commit header to record such a vague
>ill defined notion that they are somehow related, and force the tool
>to pay attention to it somehow via magic."
>
ehm.
to quote two mails back:

On Tue, Sep 30, 2025 at 08:39:29AM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>> your particular use case would imo be better addressed by=20
>> implementing bi-directional linking between picked commits via a=20
>> standardized git-notes namespace.
>
>A nice property of notes is that they can be added after the fact=20
>and can be made bidirectional, so in a workflow that allows adopting=20
>this great suggestion, it is a very sensible thing to do.

that is our baseline.

in the mean time, i've been thinking a bit further:

why would we stop at cherry-picks? we can also track rebases and amends,=
=20
thus addressing all the good questions raised in the recent thread about=
=20
standardizing change-ids [2].

in fact, we would _have_ to track commit rewrites, as the cherry-pick=20
links would become stale otherwise. but this can be recorded as even=20
weaker provenance info in its own right, which would then serve to track=
=20
the evolution of commits.

of course, links to short-lived commits would become stale, so they=20
would need to be garbage-collected.

lots of details to think about ...

[1] https://lore.kernel.org/git/aCM5JY25NVPgyYRP@chrisdown.name/T/#u
[2] https://lore.kernel.org/git/CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FX=
zdcywqUUw@mail.gmail.com/T/#u
