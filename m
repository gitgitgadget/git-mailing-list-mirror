From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Thu, 12 Apr 2012 08:56:34 -0700
Message-ID: <7vpqbdeyfh.fsf@alter.siamese.dyndns.org>
References: <vpqwr5uceis.fsf@bauges.imag.fr>
 <20120406071520.GD25301@sigill.intra.peff.net>
 <vpqr4w12tjj.fsf@bauges.imag.fr>
 <20120406080004.GA27940@sigill.intra.peff.net>
 <4F7FF19B.1060407@alum.mit.edu>
 <20120407075150.GA18168@sigill.intra.peff.net>
 <7viphaygsg.fsf@alter.siamese.dyndns.org> <vpq62d6dyzr.fsf@bauges.imag.fr>
 <20120412075535.GC31122@sigill.intra.peff.net>
 <vpqhawp2wxs.fsf@bauges.imag.fr>
 <20120412081407.GE31122@sigill.intra.peff.net>
 <vpqfwc9wckl.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 12 17:56:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIMO2-0003df-9N
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 17:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934467Ab2DLP4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 11:56:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49879 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934420Ab2DLP4h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 11:56:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1C8C6CD9;
	Thu, 12 Apr 2012 11:56:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h4gvacJbfT8nIU1Yt9d9JkUCLEI=; b=mQjf4o
	Xixj9LdJwNbAkAw464vRlZImQ4FlmqdOfOfflquvoh2jE/nZB5giTRRkkJYu7Sat
	x4cNKlk23gX97T8ZRBkIOP4YSkQsZkSVQc8nq+IggWtxPNY26nc3DzJNihozjIML
	7SrdmYKeZiMnkpQCvqnl/oAdeq5jRiOnZDklM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d8RxIvhqbM8sKNgDG9wkMlfnzajUvljG
	Pjw+GK/SmExTvDW60yJYxwZmFsTDwtRwlSmgLq2/5JdUpoSWYOm+/i8GBjnF98EG
	0cXLxZnNW+jx8No4R9FC/OHrfrfB7K4CeNy+5MrY5UCVoNaZf6rw31R0PBveSQcl
	3AawD/NMGX4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8BEE6CD8;
	Thu, 12 Apr 2012 11:56:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B2AF6CD7; Thu, 12 Apr 2012
 11:56:36 -0400 (EDT)
In-Reply-To: <vpqfwc9wckl.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu, 12 Apr 2012 10:59:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1549EF14-84B8-11E1-9523-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195340>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jeff King <peff@peff.net> writes:
>
>> Then the rule is not really "act only if upstream and current would do
>> the same thing".
>
> Right. That would be closer to "fail with explicit error when where to
> push is not clear enough".

I think that is a good explanation.

>> On the one hand, I think what you are suggesting is reasonable in most
>> cases. On the other hand, what if the lack of upstream is because the
>> user failed to configure it properly? Then it could be surprising.
>>
>> I don't have a strong opinion either way.
>
> No strong opinion either, but I wanted to raise the point to make sure
> we agree.
>
> With your patch, "git push" fails with
>
>   fatal: The current branch branch-name has no upstream branch.
>   To push the current branch and set the remote as upstream, use
>   
>       git push --set-upstream origin branch-name
>
> so it's not really bad: the suggestion guides the user to a situation
> where the next "git push" will succeed unambiguously. As a side effect,
> the next "git pull" will fetch from the same branch, which is probably
> what the user wants if he hasn't explicitely configured an upstream
> branch yet.

Sounds sensible.
