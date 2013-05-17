From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Random thoughts on "upstream"
Date: Fri, 17 May 2013 09:45:02 -0700
Message-ID: <7vk3mx1rox.fsf@alter.siamese.dyndns.org>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
	<CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
	<7vobca3465.fsf@alter.siamese.dyndns.org>
	<7vzjvu1jes.fsf@alter.siamese.dyndns.org>
	<CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 18:45:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdNmL-0006hJ-NX
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 18:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382Ab3EQQpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 12:45:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37251 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755333Ab3EQQpF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 12:45:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC2EC1D86C;
	Fri, 17 May 2013 16:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XEG3Htx9+c5fgD7rP+/+5hWiR6k=; b=jgoRhF
	3OQZ0fSy9IeC9kIBBruER++MrXS7W8oYSaijmAw5v61ubAsNasEL/P28YMoCZmZW
	E6Y4OZIqcXSsvbn7Clv5XHobwWowrTWNC0Ml4bW+pua5NTmS2IUFNDBZ3nzXPOHx
	MzSyWphnNgTUvX3chFO6ikNJYqIfQncLQEhRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tHFQry5JqpqjVo1jNMfgNpCBLaR2rmNx
	hngWS/0TC6RwwsCSVuLgIQZL6MOdWGMvOE7B8VQ9RHYxZozp6eQhDorBUbfduXqN
	blS2rLBJV6CKXtWAD7+RSVUIIe52y+3b4jo1NF4L4Y4/vBIva5Md881Lae3nntOH
	s7tCBLZORLc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0AB71D86B;
	Fri, 17 May 2013 16:45:04 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D73C1D868;
	Fri, 17 May 2013 16:45:04 +0000 (UTC)
In-Reply-To: <CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 17 May 2013 18:13:13 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FC0E09E-BF11-11E2-99DD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224700>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Which is the exact argument I presented on the other thread.  However,
> Felipe has a point: we shouldn't cripple @{f} (I think "fork" is a
> good name for it) in the name of generality.

Please clarify the semantics of @{f}.  Does it conceptually refer to
where the current branch is going to be pushed to (i.e. a pair of
(<remote>, <ref>))?  Will we have a remote tracking branch for it
to record what we pushed there the last time?  I am guessing that
your answers to both of these questions are "Yes", and frotz@{f}
would resolve to refs/remotes/there/topics/frotz-for-juno in the
sample set-up in the message you are responding to.

	Side note: I do not think "fork" rings bell to the end
	users.  Who is forking from what?  I am guessing you are
	trying to make a short form of "the branch in my public
	pepository I push this branch to, and other people would
	consider it my fork of the upstream project", but it is hard
	to do the reverse, i.e. a new person who is presented a word
	'fork' to guess that you wanted to refer to the above by
	that word.

I am not saying branch.<name>.push should not exist.  Having a
finest-grained special case would be an escape hatch you can use
when you want to do something unusual.

But it has exactly the same issue as branch.<name>.pushremote;
adding it without having the single "all of my pushes go to here,
not to 'origin'" would have meant that for N branches you have to
set the same thing N times.  We fixed it with remote.pushdefault
before the series graduated.  If you only add branch.<name>.push,
then people have to configure it N times, for N branches they want
to push out.

Reusing the existing push refspecs was just a suggestion to solve
that issue, and I am not married to that particular design.  You or
Felipe may be able to come up with a better alternative to achieve
the same goal and that is perfectly fine.  I just wanted to make
sure that we do not force the user to repeatedly set the same thing
over and over in the common case.

By the way, about "crippling".

I do not think of a reason why you cannot implement that @{f} with
the 'single' matching (or its better version you may come up with).
If "git push" can figure out where it would push to, you certainly
should be able to borrow that same logic to see what tracking branch
you are locally using to track the last push result for the current
branch in response to @{f} request, no?
