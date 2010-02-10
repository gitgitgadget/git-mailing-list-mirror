From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git log -p -m: Document, honor --first-parent
Date: Tue, 09 Feb 2010 19:23:18 -0800
Message-ID: <7vk4ullqop.fsf@alter.siamese.dyndns.org>
References: <46d6db661002091545j74f625ffr74ca70a0474948fc@mail.gmail.com>
 <20100209235707.GQ9553@machine.or.cz>
 <7v1vguuf8h.fsf@alter.siamese.dyndns.org>
 <20100210011149.GR9553@machine.or.cz>
 <7vpr4dop1m.fsf@alter.siamese.dyndns.org>
 <20100210021148.GT9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian MICHON <christian.michon@gmail.com>,
	git list <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Feb 10 04:24:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf3BJ-0001Jl-IX
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 04:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004Ab0BJDX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 22:23:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab0BJDXz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 22:23:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 687B298A34;
	Tue,  9 Feb 2010 22:23:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6d320Aj5bMWoSXN8csaRtFUrcpk=; b=qYEXS3
	eLcy4iFHNQxj7IxYUhwI1U4WO4DwbWxbC41oPPeUu4kHLl4exNq0nlm3e+gjXaDx
	zaq04eIBUTiHkoPoMzGEUxZJq0y6Rd7lJiUI39BfPce44TOf+CgLBgsYm/Ju/byP
	SlnF4ZVREo1B/QIRQ1LfDkgOpZPIOLqryNhkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qQDYKtpsfxsq1d+P8xN3nGnl89vX/lyB
	aqvqBt2IlWrQ+JOE60SuOh2E2pR2ksGHtY9JB0My479OPWTfNZorU85+C9HdEEqP
	pwxu1yxph9dnfrHfgbs9UIamDzuBc6nNTUCh2dgqMYz2Tgo+DnkZX74QwXfBcn56
	uEQhEocaxJk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 381B198A33;
	Tue,  9 Feb 2010 22:23:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B88798A2E; Tue,  9 Feb
 2010 22:23:20 -0500 (EST)
In-Reply-To: <20100210021148.GT9553@machine.or.cz> (Petr Baudis's message of
 "Wed\, 10 Feb 2010 03\:12\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A57BDD6C-15F3-11DF-8B7B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139477>

Petr Baudis <pasky@suse.cz> writes:

> * The branch was created long ago, but has merged latest changes of the
> top of HEAD in, and now the branch is merged back, that's a "bad
> fastforward" since that flips the perspective of main-vs-topic branch.
>
> I feel that it's important to point out this caveat.

Ah, I thought you were contrasting between ff and non-ff, but instead you
were giving caveat about trusting "fast-parent", which I didn't realize.

Yeah, but in general, unless it is the final merge to consolidate the work
on the topic to mainline that was delegated by the mainline maintainer to
the topic person, merging _from_ mainline _to_ topic should rarely happen.
And when it happens, relying on the first-parent ancestry obviously breaks
down.

> I really dislike the "first-parent ancestry" wording, I think it muds
> down the whole issue.

I am not particularly fond of the wording, either, but any other word you
would use, you would need to explain the background information, i.e. how
and why the concept embodied by that other word you choose to use relates
to the "--first-parent" option.

You can for example say "the changes introduced to the mainline by each
commit" (and by "commit" we mean both single parent ones directly made
while the mainline was the current branch, and merges made into that
branch); you need to define what you mean by "the mainline", and what your
assumptions are about the workflow employed (e.g. "rarely if ever merge
goes the wrong direction").

>> > +		else if (opt->first_parent_only) {
>> > +			/* Generate merge log entry only for the first
>> > +			 * parent, showing summary diff of the others
>> > +			 * we merged _in_. */
>> 
>> Style?
>
> What's wrong?

	/*
         * We prefer to write multi-line comments
         * like this.
         */
