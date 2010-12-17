From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: add missing configuration variables
Date: Fri, 17 Dec 2010 12:52:07 -0800
Message-ID: <7v7hf8i0lk.fsf@alter.siamese.dyndns.org>
References: <1292395613-12859-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <20101215130046.GB25647@sigill.intra.peff.net>
 <alpine.DEB.1.10.1012151931030.25560@debian>
 <20101216042304.GA886@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 17 21:52:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PThHs-0007do-G0
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 21:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147Ab0LQUwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 15:52:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755303Ab0LQUwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 15:52:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B62C3701;
	Fri, 17 Dec 2010 15:52:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mihQ6Wp8FRbZf3T666ZJHF5XueE=; b=pzhsdv
	RVd/w95Cyg+iP0OlpYdys6wA8pq8LXkdQMQtg5kZptM14xIO/BoY01g7B7duOJkj
	eaVYsMmYgavA1y1YI5DEeAKnID1kV7XH9bIS1sQaEbwaKX2l/bnHASSVqQXJ2f5A
	Z3kh6gI3Wp3riy1VljVKCZ1J8FUVeUzMW+Cnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FXjeVbnwqEqxTmiV5Otjd+6l0r144ujf
	O0wEZ6FSb79bP1wwCIUaV6fSkT3eD1LdS1kTu/BEj6k6ianIAV9WlsgW02F2Q8QN
	1FoSKGKNeE2ODTmLEHowi0WEfe5bfKT0i0UqxtFqbf9ZSVLgoqQ9RUOwjF6JdNlK
	zC5fSOSiteI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 160523700;
	Fri, 17 Dec 2010 15:52:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DFC5936FE; Fri, 17 Dec 2010
 15:52:36 -0500 (EST)
In-Reply-To: <20101216042304.GA886@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 15 Dec 2010 23\:23\:04 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 96BF9DCE-0A1F-11E0-B2C2-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163890>

Jeff King <peff@peff.net> writes:

> On Wed, Dec 15, 2010 at 08:44:45PM +0100, Martin von Zweigbergk wrote:
>
>> > One note:
>> > 
>> > >  		color.diff
>> > >  		color.diff.commit
>> > >  		color.diff.frag
>> > > +		color.diff.func
>> > >  		color.diff.meta
>> > >  		color.diff.new
>> > >  		color.diff.old
>> > >  		color.diff.plain
>> > >  		color.diff.whitespace
>> > 
>> > We have color.diff.branch coming soon (I think it is in 'next' now).
>
> The "correct" thing to do from a topic branch standpoint is to submit
> this patch without it as its own topic, submit a patch with just
> color.diff.branch on top of the other topic, and then the merge
> resolution will include both sets.

Perhaps, if we had color.diff.branch ;-).

> In this case, it might be OK to just start shipping color.diff.branch in
> the completion list. It doesn't hurt anything to have the extra
> completion before the feature is in, and the feature seems very likely
> to make it in soon.
>
> But I'll let Junio decide how meticulous about history he wants to be.

Well, in this case, probably the right thing to do is to ignore this
addition to completion as the lowest priority item for now, wait for other
changes that add or modify the set of configuration variables to land on
'master', and then resubmit a single patch.

Yes, merge is wonderful and easy, but it is merely a tool to help
coordination between developers (the ones who add code to understand new
variables, the others who add completion to help spell the new variables),
not a replacement.  And orderly submission of patches that are related and
have dependencies is a prime example of such coordination.
