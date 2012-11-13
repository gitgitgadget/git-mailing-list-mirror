From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Tue, 13 Nov 2012 08:13:04 -0800
Message-ID: <7vpq3hfpm7.fsf@alter.siamese.dyndns.org>
References: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
 <20121112233546.GG10531@sigill.intra.peff.net>
 <CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
 <20121113000217.GH10531@sigill.intra.peff.net>
 <CAMP44s16y9WSmnTdb04EMSzXVgzfYP7pSMo6qZi0HY0bjouA0w@mail.gmail.com>
 <20121113032727.GA8387@sigill.intra.peff.net>
 <CAMP44s0SDHVzSd-8Rq7Z1sbiQ6m0pxX+2pgx16_DoWnHeyNsNQ@mail.gmail.com>
 <20121113040104.GA9361@sigill.intra.peff.net>
 <CAMP44s1w3oZhEUM-cnO=kECH2bhdOTGVuKy8JS4uhWFbA_oi3w@mail.gmail.com>
 <20121113074720.GA18746@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 17:13:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYJ7E-0001SK-DO
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 17:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554Ab2KMQNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 11:13:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44567 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753733Ab2KMQNR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 11:13:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 562EFA029;
	Tue, 13 Nov 2012 11:13:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+LJ0mEk8wvhyuQtLBFh7sIugEIc=; b=WFSUte
	cCrzxmhM7AcC+/eytVRbYFCgqvAV13Q3+xzwSsfxkqI2YSyUTZQdUHxnmQPtX5OW
	+yUJ0BPbZ4ZXv7uZ3oMGo0sTbUEDpuYyJ6MJdScyUUGzB+VgoER0b0W48DGBKyuJ
	qHE9+vFzwW6AD7eEu3Uh6qCheMUNvsxwRihbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PPxosfWMG+fcRg42OLFRs6tNGU0t+moh
	gVcoBF61WFGrrQyZysUm5aaXgnJmTVEyC13fWnxghAKQLw0cWIgg7EehXsEtS6n8
	JUOzu5zCF1Rm1jGQjl5zGlLGz2caG12agi2AJ+APlNnrJP9nO0qxGDS30/wpQBor
	+6QetJsvJJc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 428ABA028;
	Tue, 13 Nov 2012 11:13:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62BC8A026; Tue, 13 Nov 2012
 11:13:15 -0500 (EST)
In-Reply-To: <20121113074720.GA18746@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Nov 2012 02:47:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0791EDEC-2DAD-11E2-BA61-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209627>

Jeff King <peff@peff.net> writes:

> On Tue, Nov 13, 2012 at 07:42:58AM +0100, Felipe Contreras wrote:
> ...
>> 5) GIT_COMMITTER
>> 
>> Who should the emails appear to be from? [Felipe Contreras 2nd
>> <felipe.contreras+2@gmail.com>]
>> 
>> Whoa, what happened there?
>> 
>> Well:
>> 
>>   $sender = $repoauthor || $repocommitter || '';
>>   ($repoauthor) = Git::ident_person(@repo, 'author');
>>   % ./git var GIT_AUTHOR_IDENT
>>   Felipe Contreras 2nd <felipe.contreras+2@gmail.com> 1352783223 +0100
>> 
>> That's right, AUTHOR_IDENT would fall back to the default email and full name.
>
> Yeah, I find that somewhat questionable in the current behavior, and I'd
> consider it a bug. Typically we prefer the committer ident when given a
> choice (e.g., for writing reflog entries).

Just to make sure I follow the discussion correctly, do you mean
that the bug is that we pick a fuzzy AUTHOR when COMMITTER is
specified more concretely and we usually use COMMIITTER for this
kind of thing in the first place but send-email does not in this
case (I do not see "git var GIT_AUTHOR_IDENT" returning value from
the implicit logic as a bug in this case---just making sure).

>> 6.1) GIT_AUTHOR without anything else
>> 
>> fatal: empty ident name (for <felipec@nysa.(none)>) not allowed
>> var GIT_COMMITTER_IDENT: command returned error: 128
>
> Doesn't that seem like a regression? It used to work.

I do not think we mind a change to favor GIT_COMMITTER setting over
GIT_AUTHOR to be consistent with others too much, but that indeed is
a big change.  People who are used to the inconsistency that
send-email favors AUTHOR over COMMITTER will certainly find it as a
regression.

> The explicitness needs to be tied to the specific ident we grabbed.
> Probably adding a "git var GIT_AUTHOR_EXPLICIT" would be enough, or
> alternatively, adding a flag to "git var" to error out rather than
> return a non-explicit ident (this may need to adjust the error
> handling of the "git var" calls from send-email).

Yeah, something like that would be necessary for "git var" users to
make this kind of decision.

> While simultaneously breaking "git commit" for people who are happily
> using the implicit generation. I can see the appeal of doing so; I was
> tempted to suggest it when I cleaned up IDENT_STRICT a few months back.
> But do we have any data on how many people are currently using that
> feature that would be annoyed by it?

As we didn't break "git commit" when you worked on IDENT_STRICT, I
do not think we have any data on it ;-)

> ...
> It may be something I would work on myself in the future, but I have
> other things to work on at the moment, and since you are interested in
> the topic, I thought you would be a good candidate to polish it enough
> to be suitable upstream. But instead I see a lot of push-back on what I
> considered to be a fairly straightforward technical comment on a
> regression.
> ...
> But I feel like I am fighting an uphill battle just to convince you that
> regressions are bad, and that I am having to make the same points
> repeatedly.  That makes me frustrated and less excited about reviewing
> your patches; and when I say "it is not my itch", that is my most polite
> way of saying "If that is going to be your attitude, then I do not feel
> like dealing with you anymore on this topic".

For a change with low benefit/cost ratio like this, the best course
of action often is to stop paying attention to the thread that has
become unproductive and venomous, and resurrect the topic after
people forgot about it and doing it right yourself ;-).
