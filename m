From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Fri, 16 May 2014 09:52:15 -0700
Message-ID: <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
	<20140516084126.GB21468@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 16 20:15:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlMf6-0001WW-QP
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 20:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756738AbaEPSPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 14:15:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56196 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716AbaEPSPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 14:15:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F13D19603;
	Fri, 16 May 2014 14:15:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QFgR6T0LRlufbX8uYPyhRYC7vu0=; b=tbtBtG
	ClYe6Izee1pZzyFSVsA1Tyf9Sf7jmmWyBDrWJqL6HE8tQjJQ/dLOsrC6/fewPRNK
	sqtUmfxjuFvX0JoSavMbzSwfjj6Kgr+qWj2ceRYzJZiMwTWZV1BptQ10Qgrmd68Z
	YHQWuSiTfJeprcmRIxOlTHEhiv9F94UMTCs7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N8rphjf9ojqC5vP94Ta3NxhJI3qDzOZL
	qZueut+uqfq535BgIEUXG40qqM8hxEO1pD8JLfAK8UCNEBC92cz0vsB7iGoxixDx
	AWM7Kjdn36CCQ2khukxO6QBQnL3AK0nQPIssVVMTPflI/pAj/EcTQp+RF/SbV1wS
	tT/WZtVqZxw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5577B19602;
	Fri, 16 May 2014 14:15:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7A31115D20;
	Fri, 16 May 2014 12:52:18 -0400 (EDT)
In-Reply-To: <20140516084126.GB21468@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 16 May 2014 04:41:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 71008BB2-DD1A-11E3-B393-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249402>

Jeff King <peff@peff.net> writes:

> On Thu, May 15, 2014 at 03:56:29PM -0700, Junio C Hamano wrote:
>
>> Two announcements for their version 0.2 on the list archive are not
>> quite enough to advertise them to their users.
>
> I do not think this README nor a mention in the release notes will get
> their attention either, and many people (and packagers) will continue to
> use the stale versions forever until those versions go away.
>
> I would much rather _replace_ them with a README in the long run, and
> people will notice that they are gone, and then use the README to update
> their install procedure.
>
> For 2.0, I am hesitant to do that, though I do not have a problem with a
> README like this as a heads-up to prepare packagers for the future. I
> say hesitant because people may have been test-packaging 2.0.0-rc3 in
> preparation for release, and it will be annoying to them to suddenly
> switch.

I share the latter two of the above three.  I was giving distro
packagers a bit more credit for their diligence in knowing what they
are packaging than you seem to be in your first point, but I admit
that it is a blind faith.

> But that being said, this is Felipe's code. While we have a legal right
> to distribute it in v2.0, if he would really prefer it out for v2.0, I
> would respect that.

I am fine with that.

> I would prefer to instrument the code with warnings, as that is the sort
> of thing a packager moving from -rc3 to -final might not notice, and
> shipping the warnings to end users who did not package the software in
> the first place will not help them. It is the attention of the packagers
> (and source-builders) you want to get.

I do agree that a new warning every time it is run will be a more
likely to grab users' attention.  The conclusion I draw from that
shared observation is that the user will be annoyed all the time,
without having a power to do anything about the annoyance, until the
report s/he (or other users) Throw at the packager, even when the
version that was packaged hasn't diverged that much yet, which does
not help end users.

I guess the ideal we want is to make sure their build break.  What
if we do the README in addition to rename contrib/remote-helpers to
contrib/obsolete-remote-helpers (or s/obsolete/graduated/)?  It will
give the packagers three choices and I think it hurts people much
less.

 * The packagers that dump the entirety of contrib/ to somewhere
   without doing anything to expose the scripts to user's PATH do
   not have to do anything.  The users who chose to pick them up
   from there notice the missing contrib/remote-helpers, notice
   "obsolete" (or "graduated"), and read README.

 * The packagers that pick up from contrib/remote-helpers and
   arrange the scripts to be on user's PATH will find their build
   broken, because they are no longer where they expect them to be.
   They will notice "obsolete"(or "graduated"), and read README.

   - They can choose to pick them up from "obsolete", perhaps for
     expediency, perhaps for their change aversion, but that will
     not last once we grabbed their attention, and they will switch
     their upstream in some later release once such a choice makes
     them feel dirty enough.

   - They can choose to switch their upstream right now in response
     to the breakage.

I would say that the options I see are these three, and I would rank
the "warn every time" as less helpful to end-users:

 - rename contrib/remote-helpers to contrib/obsolete-remote-helpers
   and add README to point at the upstream.

 - remove contrib/remote-helpers scripts and add README.

 - warn every time the user runs the scripts.

Or am I reacting to a typo and you meant to say "I would prefer not
to instrument"?  Your "shipping the warnings to end users who did
not package the software will not help" was unclear if you meant the
README that has warning or warning message they have to see every
time from the instrumented code.
