From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Stashing individual files
Date: Tue, 03 Jan 2012 12:08:52 -0800
Message-ID: <7vfwfwtup7.fsf@alter.siamese.dyndns.org>
References: <CAJ6vYjduoBNrRcvcvQbX_yY-3-Qm5ZbXOM0WQpWRwC1H1OCqaA@mail.gmail.com>
 <20120103190612.GC20926@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Leong <walkraft@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 03 21:09:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiAfM-0003Aj-11
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 21:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868Ab2ACUI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 15:08:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41929 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754731Ab2ACUIz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 15:08:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86F8D6264;
	Tue,  3 Jan 2012 15:08:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uH6cXaMJ/sFGQhu1P2VwsAGVWWc=; b=joJSdp
	nKa6U6NmIibF8fdL/yOK4IWAg49B3CHrCKNeNM3sNKyAfwv31RAQ3vkPVLwluBuB
	4/61h2pwDrWk9oTyAVQQ0TI3VqWsuJmed5b0meqBBNFfK2OyzMZVsCkqGRBZXzYa
	Rc3X5XRE8xkY6NQWRfQI8Q3MSUJD5d16e4tww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lUzp7X59liNLTrIB4jlJ36clko0WTq9d
	A/WtiajouMHAI5J3zJe9rQlSnBiDpGttKUdzlzzT++K+u63q/4wGupfifGY+71N1
	w5HrtHEJVfvBWz45qhZevUrg0N/L0LKjxpO7/pku405bTlSLys/RXN1dZdbgVwTp
	RjodTUroIEc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DF056263;
	Tue,  3 Jan 2012 15:08:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F151B6262; Tue,  3 Jan 2012
 15:08:53 -0500 (EST)
In-Reply-To: <20120103190612.GC20926@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 3 Jan 2012 14:06:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2B3B696-3646-11E1-BCD3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187888>

Jeff King <peff@peff.net> writes:

> I think that would be OK compromise, though. I'd rather not introduce a
> whole new "stashfiles" command (or even a new subcommand of stash) if we
> can avoid it.

Why wouldn't a simple "git diff -- paths >P.diff" work?

What does such a partial stash leave in the working tree, how does the
user deal with the remaining local changes, what happens after such a
partial stash is applied/popped?

I wouldn't have worried about such a change before e0e2a9c (stash: drop
dirty worktree check on apply, 2011-04-05) but now we allow application of
stashed changes to the dirty working tree (which is a very good thing), I
am not sure how sensibly these changes in different places would interact
if we start supporting partial stashing.
