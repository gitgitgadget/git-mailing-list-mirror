From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2014, #02; Fri, 9)
Date: Sun, 11 May 2014 10:51:19 -0700
Message-ID: <xmqqk39suru0.fsf@gitster.dls.corp.google.com>
References: <xmqq61lewtkf.fsf@gitster.dls.corp.google.com>
	<536d4bd48e3f9_585ea5308b2@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 19:51:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjXuN-00062I-Hi
	for gcvg-git-2@plane.gmane.org; Sun, 11 May 2014 19:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179AbaEKRv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2014 13:51:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59503 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136AbaEKRv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2014 13:51:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B5A8816C31;
	Sun, 11 May 2014 13:51:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7jqH78fcXVIQLxJsPVT9yGapZ5E=; b=aP2lVi
	e27639jIcJPqRtMlLc4VRZOVYgavcBWGiw2shmn8ToLzk3PZ8kGyTZCzFt6O0sFd
	l1T0Ig1Any+yHjq3h3rAW5d/s0juctEru+Wefs0byWtMykKmfL5JhsJJjUV5xb8S
	jVwCeLIOaT1lrm+mENMRCPrSZPHeYf2XlaXlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HhNx1o6qoQvQN17cb3SzJTQjArWmlEdW
	EoxtiYwsovGnpeSZgJN8KBekOuA4BLTDA1MzZpjNymSCe7Ith0N6yAMjM87uC+pp
	A7gps0tRh5VU4PMhAs//GXF2vDzGKfT/Enc5sWXZHVVzGz6HsnM5KMr/fQq889vN
	WlDfQfyM488=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA91216C30;
	Sun, 11 May 2014 13:51:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A303716C20;
	Sun, 11 May 2014 13:51:20 -0400 (EDT)
In-Reply-To: <536d4bd48e3f9_585ea5308b2@nysa.notmuch> (Felipe Contreras's
	message of "Fri, 09 May 2014 16:42:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DC2E951C-D934-11E3-8AF1-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248676>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> * fc/remote-helpers-hg-bzr-graduation (2014-04-29) 11 commits
>>  - remote-hg: trivial cleanups
>>  - remote-hg: make sure we omit multiple heads
>>  - git-remote-hg: use internal clone's hgrc
>>  - t: remote-hg: split into setup test
>>  - remote-hg: properly detect missing contexts
>>  - remote-{hg,bzr}: store marks only on success
>>  - remote-hg: update to 'public' phase when pushing
>>  - remote-hg: fix parsing of custom committer
>>   (merged to 'next' on 2014-04-22 at fed170a)
>>  + remote-helpers: move tests out of contrib
>>  + remote-helpers: move out of contrib
>>  + remote-helpers: squelch python import exceptions
>> 
>>  As there were announcements for these two to be maintained as
>>  independent third-party projects ($gmane/248561, $gmane/248583),
>
> Clarification: after Junio unlilaterally blocked any further progress
> towards grauduation to the core, which was the intention since the very
> beginning.

After seeing your repeated attempts to spread misinformation, I was
planning to totally ignore you, but because "What's cooking" is one
of the important project-wide report, I'll respond one last time.

Even though I was originally leaning towards moving them into core
(after all, why would I have merged the bottom three commits to
'next' otherwise?), I was later convinced, during the discussion
that started with John Keeping's objection [*1*], that I was wrong,
and if they moves outside contrib/, the best direction for them to
go is not to the core but to become independent third-party plug-in
for allow users to pick up the latest without being restricted by
our release schedule to ensure no-regressions to the entire system.

At some point I have to decide what would be the best next step, and
your counter-arguments did not make much sense to me.  The decision
is that the best course for these two is either staying in contrib/
if they are not ready, or becoming independent third-party projects
if they are.

Is making that decision as the maintainer unilateral?

I would not mind asking the others, as your discussion tactic seems
to be "repeated voices start sounding like a chorus, and a chorus is
project concensus".

Those who are observing from the sideline, please raise your hand if
you think the three-line "Clarification" Felipe gave us is a fair
and accurate clarification.  Anybody?

I also do not mind seeing hands raised of those who do not agree,
even though I already know that they would be a silent majority.

Remember, I intend to make this message the "one last time" one.  In
the past, any time you made absurd claims by twisting facts and what
other people said, I tried to contain the damage to innocent
bystanders (who may not know Git and the history of the discussion
well enough to make their own judgment) by double-checking facts and
correcting you.  These days, I still do the same fact-checking,
which steals time from the project that would be better spent in
other ways, but because I know your counter-arguments will be
nitpicking on subissues that do not matter in the larger picture and
resulting back-and-force will end up wasting a lot more time without
anything to improve the project, I started to apply the "do not feed
a troll".

I'll stop wasting time even on fact-checking from now on whenever
you say anything.  It's not worth the project's time.


[Reference]

*1* http://thread.gmane.org/gmane.comp.version-control.git/248641/focus=248643
