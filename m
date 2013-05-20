From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Random thoughts on "upstream"
Date: Sun, 19 May 2013 21:28:03 -0700
Message-ID: <7vfvxixoks.fsf@alter.siamese.dyndns.org>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
	<CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
	<7vobca3465.fsf@alter.siamese.dyndns.org>
	<7vzjvu1jes.fsf@alter.siamese.dyndns.org>
	<CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
	<7vk3mx1rox.fsf@alter.siamese.dyndns.org>
	<CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
	<7vk3mxze8v.fsf@alter.siamese.dyndns.org>
	<CALkWK0kYKZGhthdrb6-7RD_c2A7E9rscAZU3=JHM-4rYre6w=Q@mail.gmail.com>
	<7vmwrr1pem.fsf@alter.siamese.dyndns.org>
	<CALkWK0=6L529C452MaNGksL5KeVb+cL1SeC=FwA9veS=tNQurA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 06:28:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeHhm-0007rR-ST
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 06:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139Ab3ETE2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 00:28:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60046 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab3ETE2I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 00:28:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF57515952;
	Mon, 20 May 2013 04:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=PQgOa/0wkGDU9/G7PUfFVoXrBOw=; b=JRP6KZUJo0/1whn8RNPt
	+eykYtZGHu2vu9bUeT4hvYvGOKUQuApwFkAOF2K0fA3fU56V/ZvHjSZwPZC33dG5
	xhISDHO/NYIkTadToliXv+JxkgHWsbeMAIgVagr7BdN6lPNdABENC/9EHEw2Z6p2
	QUnfUqKq3b7rZJU3wbF9eg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=PMhHcmPFPxm2yhpQlEfeS+omdG3g0ppxDJT2FMly1FS6AV
	jmmGCwsDQxqnB1YHIZYzwd+xHq8ZrcopnwZ6puuyfPyVE7s4UkscOkcSDHnm3Jjy
	UmZukSuukv6bBpnGinL6tY/pKvMgL8G7xlvAc9Y+SeyHtLqspkIIHF1qVnp8Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B735B15951;
	Mon, 20 May 2013 04:28:07 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C37821594E;
	Mon, 20 May 2013 04:28:06 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB565300-C105-11E2-A904-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224932>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I suspect that the issue you're trying to address is:
>
> [remote "ram"]
>     push = refs/heads/*:refs/heads/rr/*
>
> not dictating which refs to push when I say 'git push' (it'll push all
> the refs under refs/heads/*, not respecting push.default=current in my
> scheme).

That is not what I was addressing.  You outlined your scenario as
"you were not, but you are now, allowed to push an approved ref into
'origin'".  And you do so under a different name.  That is why I set
that rr/ renaming push refspec for a remote ORIGIN not RAM.

And that was done with extensivility your example implied in mind:
you may later be allowed to push other branches as well to origin.
That is why the refspec definition for 'origin' does not hardcode
the name of the branch you are permitted to push there at this
moment.  The fact that hot-branch goes to origin is encapsulated in
the branch.hot-branch.pushremote.  The rule, under which the name of
any branch that goes to the origin is renamed, is encapsulated in
remote.origin.push refspec (the introduction of the new mode
"push.default = single" is necessary to make this work).

When making that change, our fictitious ram did not have to touch
"remote.ram.push" *at all*.  Independent of what the owner of
"origin" and ram agreed in that example, ram would keep doing
exactly the same thing to his own publishing point so that people
who are working off of his work would get updates from the place
known to contain his work from before.

So with "git push ram", it will push everything to "ram" under the
same name *without* rr/ renaming, but that was *by design*, not
something I wanted to or I needded to work around.  And you would
also push to "origin" by doing "git push" while on hot-topic branch.
