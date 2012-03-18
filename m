From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Sun, 18 Mar 2012 11:50:04 -0700
Message-ID: <7vipi1d9r7.fsf@alter.siamese.dyndns.org>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
 <7vty1ndcoi.fsf@alter.siamese.dyndns.org> <4F6461D7.40303@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 19:50:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9LBI-00055Y-Kl
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 19:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab2CRSuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 14:50:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33984 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501Ab2CRSuI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 14:50:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36920767E;
	Sun, 18 Mar 2012 14:50:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lere5KWyDzJ+YW2JWyrJJC9QGX8=; b=a6b7fd
	br14udkqW1rErQW2mxxavSvCB0a52df90vQ0WO2SrBPtWRmKis4E5JQBC3sOQjxk
	yg33KtLUkTDG7pae+bCyKBBrhsdLrD+yC+GU0VaqRjn9eEIxXfJD7Z2YKtSNcQuv
	Pp0KHOKArFxiI014NoB9Bqpi6eUaCPIlMiK4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nh3uU067hhXmk6oRJzpx3DOJZdaga36f
	NYmZoYuo+DM+d+o4tc6klxJ92qyJAH3otf9Zt+pO8CAe/z3DFKiOr7dXL3noq7+D
	sAoCjnjdrXir/cCf6d9NESx10P4iTYYfNCwQ5vTbMlEiM0EdcPQKKzG9xkaSxnmu
	Kz/lJQW898g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E344767D;
	Sun, 18 Mar 2012 14:50:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4C657679; Sun, 18 Mar 2012
 14:50:05 -0400 (EDT)
In-Reply-To: <4F6461D7.40303@pileofstuff.org> (Andrew Sayers's message of
 "Sat, 17 Mar 2012 10:05:11 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D6378FE-712B-11E1-A2F0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193387>

Andrew Sayers <andrew-git@pileofstuff.org> writes:

> On 17/03/12 05:22, Junio C Hamano wrote:
>> If the conclusion of the discussion is that we will change the default,
>> the transition to the new default will go like this:
>> 
>>  1. An announcement message to let the user communities know about the
>>     future change will be distributed in a way similar to the previous
>>     request-for-discussion message was distributed.
>> 
>>  2. The first version of Git that is released after such an announcement
>>     will start issuing a warning ...
>> 
>>  3. We wait for a few release cycles.
>> 
>>  4. The default changes. ... 
>>     The warning message will be reworded ...
>>     being the 'matching' in the future", it will say "has changed to X".
>> 
>>  5. We wait for a few release cycles.
>> 
>>  6. The warning is removed.
>> 
>> A typical release cycle lasts for 8-10 weeks.
> 
> Unfortunately, "a few release cycles" strikes me as a rather hopeful
> description.  For example, a user installing the new Ubuntu LTS release
> (due out next month) would feel completely justified in not upgrading
> until 2017, whereas the rest of us would get rather bored disabling the
> same old warning in every new repo we create for the next five years.

There is nothing hopeful about it.

The point of a release like LTS is to shield the users of the distribution
from what happens in upstream, so it is up to the distro to help users. We
do not have a way to help their users in a direct way, other than letting
the distro know about the change, and educate the distros how they help
their users.

If I were a user of such a distro whose sole point is a long term support,
I would expect that a LTS that was originally released before point #2
whose lifespan extends beyond point #6 to backport only the "warning"
changes to such a release between #2 and #6 timespan as a point update to
such a LTS release. Otherwise the distro is actively doing a disservice to
its users.  Such a distro can also choose to revert the "warning removal"
change #6 in their binary when they release a new LTS. If they did not
backport "add warning" to their earlier LTS release, that is at least what
they can do to help their users.

But again, that is not something we have direct control over, and it is
not very useful to discuss this on this list. Ubuntu LTS support forum
might be a better place, but in short, it is not a problem we can solve
(nor we should be solving), as long as we have a reasonable migration plan
and if the user is locked out of that migration plan---whoever is doing
the locking-out is taking responsibility for these users who are out of
our reach.
