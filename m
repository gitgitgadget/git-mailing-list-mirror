From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/3] cherry-pick: add support to copy notes
Date: Wed, 29 May 2013 10:09:55 +0200
Message-ID: <877giixl4c.fsf@linux-k42r.v.cablecom.net>
References: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
	<1369745947-19416-2-git-send-email-felipe.contreras@gmail.com>
	<7vobbv119k.fsf@alter.siamese.dyndns.org>
	<87mwrfx9ug.fsf@linux-k42r.v.cablecom.net>
	<51a56bef1b9c2_807b33e1899991@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Christian Couder" <chriscool@tuxfamily.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 10:10:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhbSQ-00016y-3F
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 10:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028Ab3E2IKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 04:10:00 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:57633 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964806Ab3E2IJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 04:09:57 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 29 May
 2013 10:09:51 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 29 May 2013 10:09:55 +0200
In-Reply-To: <51a56bef1b9c2_807b33e1899991@nysa.mail> (Felipe Contreras's
	message of "Tue, 28 May 2013 21:46:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225773>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Thomas Rast wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Thomas Rast Cc'ed as he has been the primary force behind this line
>> > of "notes" usability.
>> 
>> Thanks for pointing this out to me.
>> 
>> > Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >
>> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> >> ---
>> >>  builtin/revert.c  |   2 +
>> >>  sequencer.c       | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>> >>  sequencer.h       |   2 +
>> >>  t/t3500-cherry.sh |  32 +++++++++++++
>> >>  4 files changed, 169 insertions(+), 3 deletions(-)
>> >
>> > "git cherry-pick" should help maintaining notes just like amend and
>> > rebase, but how should this interact with notes.rewrite.<command>,
>> > where the command is capable of doing this without an explicit
>> > option once you tell which notes need to be maintained?
>> 
>> Since we already have the notes.rewrite.<command> convention, it would
>> seem the obvious choice to line it up with the others.  The main
>> bikeshedding opportunity is whether this should be an exception and
>> default to false (all other commands default it to true).
>> 
>> Also: how does this interact with notes.rewriteRef and the corresponding
>> env vars?  Why?
>> 
>> How does it interact with 'cherry-pick -n' if this is done in sequence,
>> effectively squashing several commits (this use-case is actually
>> suggested by the manpage), if multiple source commits had notes?  Should
>> it respect notes.rewriteMode (and by default concatenate)?  (I don't
>> know if the sequencer state is expressive enough already to carry this
>> in a meaningful way across cherry-pick commands.)
>
> Feel free to implement that. I'm just interested in 'git cherry-pick' being
> usable for 'git rebase' purposes.

Which would have been obvious to all but the most casual readers, eh?

We've been over this already:

  The body should provide a meaningful commit message, which:

    . explains the problem the change tries to solve, iow, what is wrong
      with the current code without the change.

    . justifies the way the change solves the problem, iow, why the
      result with the change is better.

    . alternate solutions considered but discarded, if any.

I'll gladly review your patches again once you have done that.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
