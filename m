From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5539 fails on ubuntu for v2.0.0-rc2
Date: Wed, 14 May 2014 10:11:11 -0700
Message-ID: <xmqqiop8l1zk.fsf@gitster.dls.corp.google.com>
References: <536A8FF8.7080909@fabiodalfonso.com>
	<xmqqeh056z6q.fsf@gitster.dls.corp.google.com>
	<20140508041423.GC26630@sigill.intra.peff.net>
	<536B1DF4.5080109@fabiodalfonso.com>
	<20140509155945.GG18197@sigill.intra.peff.net>
	<xmqqy4yavewk.fsf@gitster.dls.corp.google.com>
	<20140510140259.GA6836@sigill.intra.peff.net>
	<20140514101440.GA10173@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fabio D'Alfonso <fabio.dalfonso@fabiodalfonso.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 14 19:15:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkcmA-0003GQ-Lp
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 19:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082AbaENRPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 13:15:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55434 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756429AbaENROw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 13:14:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DEF09154E2;
	Wed, 14 May 2014 13:14:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RDmwjQ29Wffce6vbAKwWClBed64=; b=vVCsSm
	ICH49+Z8svpMihvVdcTjhgpS2HFokksC7npZgQSs81+yxQLZ7FyXz3Zn6er9RBzb
	TjKQaI91diWbmbKAi4/Phyger7+qWQHVSt/eqWuMZXkM6rOawaXDhVeqWqH0JA0e
	A/JXSLFbF6/jiBwnYENDJj3+w+7ZMU9CIXtnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t3+nlSw7/8vQIYsQfOOYDtDDey2n8ESq
	nPD4rEh/eP7k6NBNxXgXPp6fxOeLX+fIjvWB/Rq//uTw6/fUOBKY73nj1A+rWJ0R
	a9pJXeZKk+OFvaxqwkrwqPB1jagusR2/fXnx/lpSxTRYglYDRYBBI1R1xkIM46CC
	73/Pc1oT7q8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C85F5154DF;
	Wed, 14 May 2014 13:14:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 39239151CB;
	Wed, 14 May 2014 13:11:13 -0400 (EDT)
In-Reply-To: <20140514101440.GA10173@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 14 May 2014 06:14:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C07AB37A-DB8A-11E3-87E7-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248928>

Jeff King <peff@peff.net> writes:

> On Sat, May 10, 2014 at 10:02:59AM -0400, Jeff King wrote:
>
>> On Fri, May 09, 2014 at 02:08:27PM -0700, Junio C Hamano wrote:
>> 
>> > >   3. Just disable the http tests when run as root.
>> > >
>> > > I think I'd favor 3. But I'd like to be sure that being root is the
>> > > problem.
>> > 
>> > I agree with both the conclusion and the precondition.
>> 
>> Here's the patch.
>> 
>> The problem starts in v1.9.2, not in v2.0.0, so it's not technically a
>> regression in this cycle. And we are awfully late in the -rc period. But
>> it is just a change in the test script, and one that seems rather
>> unlikely to produce unexpected side effects. I'll leave it you whether
>> you want to queue it for v2.0.0, or for the next maint release.
>
> Hrm, sorry, I was wrong about this. I had thought the
> auto-network-testing had gone into v1.9.2, but it didn't. So this _is_ a
> potential regression in v2.0.0. It's still relatively minor, affecting
> only the test suite, so it can probably wait for post-v2.0.0 if you
> don't want to do another -rc.

A bit more disturbing is that I did not get the impression that we
know the exact reason why these http tests, especially the getwpuid
call, fail for Fabio when run as root.  And if my impression is
correct, then "do not run tests as root" applied as a "solution" to
the failure report, would merely be sweeping the problem under the
rug, even though it is a very good advice in general.

Is it a bug in the server itself that it fails to do getpwuid, or is
it because the system Fabio's on is somehow screwed up?

Until the latter can be ruled out, we might be better off not doing
anything, which may give interested parties an easier way to dig
deeper into the real cause of getpwuid failing, no?  Such a digging
may even result in a better solution (e.g. finding a specific
pattern of misconfigured systems and stop tests only on them).

Personally, I do not think running our tests as root is an
interesting enough problem to warrant the effort from us to dig only
to come up with such a "better solution", and I would be perfectly
happy to apply the "do not run this test as root" patch, or even a
broader "we do not let any test run as root, unless individual tests
explicitly ask us to allow it" somewhere in test-lib.sh included by
everybody.  That may sweep the issue under the rug as a side effect,
but it is OK because it is not the primary mission of our tests to
find issues in either httpd binaries or the system configuration
that may cause the httpd server misbehave in the first place.

So...
