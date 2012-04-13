From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Fri, 13 Apr 2012 12:31:58 -0700
Message-ID: <7vmx6f2ztd.fsf@alter.siamese.dyndns.org>
References: <vpqwr5uceis.fsf@bauges.imag.fr>
 <20120406071520.GD25301@sigill.intra.peff.net>
 <vpqr4w12tjj.fsf@bauges.imag.fr>
 <20120406080004.GA27940@sigill.intra.peff.net>
 <4F7FF19B.1060407@alum.mit.edu>
 <20120407075150.GA18168@sigill.intra.peff.net>
 <4F7FFD7A.80104@pileofstuff.org>
 <20120412071150.GB31122@sigill.intra.peff.net>
 <4F874639.5090207@pileofstuff.org> <7vlim04ou1.fsf@alter.siamese.dyndns.org>
 <20120412221110.GA22426@sigill.intra.peff.net>
 <A13E3113738743C6B002BB6B076E1FEE@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>,
	"Andrew Sayers" <andrew-git@pileofstuff.org>,
	"Michael Haggerty" <mhagger@alum.mit.edu>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Git List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 21:32:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SImEA-0001rJ-Pm
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 21:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956Ab2DMTcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 15:32:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751970Ab2DMTcH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 15:32:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 105307BA8;
	Fri, 13 Apr 2012 15:32:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b9FMMbZSbwHYjPne9Wp1Hc+IL5c=; b=QD/8Qc
	zaA1SU39NtxekYZc532D3kiWwjMMHTlOaiZOsX8s+rnkJRuHEtRs/r/GMGv4Pp05
	b6rUq2DG1JmPM44EUjmd5n9asFKF++l8jPwfvFtjrUNP1HbANBTiGcFazRYu1+1B
	/5tzcSv4vo8URijtSv+x4la/hE6X2ZkEFWo7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wtJuyux1FDIFQPh57PT2akiqOfk+pD7z
	wiE3VrhIHGYMqU+OZdn9aTRDJxXrqLGbCvAsV8wXN9w1hHxsz4OelcV/JT43pRSO
	Q1NwwllUIjsX4thD9uoJqiOUuKTcU8sp9RMlW8vYpu/kMLlMiJVu078gjbo4s/le
	kUxlvp34jrQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 039B07BA7;
	Fri, 13 Apr 2012 15:32:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A2AA7BA5; Fri, 13 Apr 2012
 15:32:00 -0400 (EDT)
In-Reply-To: <A13E3113738743C6B002BB6B076E1FEE@PhilipOakley> (Philip Oakley's
 message of "Thu, 12 Apr 2012 23:59:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57015086-859F-11E1-821D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195437>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Jeff King" <peff@peff.net> Sent: Thursday, April 12, 2012 11:11 PM
>> On Thu, Apr 12, 2012 at 02:33:58PM -0700, Junio C Hamano wrote:
>>
>>> Andrew Sayers <andrew-git@pileofstuff.org> writes:
>>>
>>> > So if the problem is that the documentation cues the reader to think
>>> > about upstreams but not to think about downstreams, the solution is to
>>> > find excuses to talk more about downstreams.  As far as I'm concerned
>>> > @{upstream} means "the place that commits come from when I `git pull`",
>>> > so it makes perfect sense to me that @{downstream} would mean "the
>>> > place
>>> > commits go to when I `git push`".
>
>>> In a separate message I completely misunderstood what you meant by
>>> "downstream".
>
> It would be useful to have "upstream" and "downstream" clarified in
> the documentation, say the Workflows man pages or some suitable
> place.

Perhaps, but I am not convinced.  I am not convinced that it is a bad idea
either, so I'll think aloud for several paragraphs, and probably will not
reach a conclusion in this message. Just a food for thought...

I think the word "downstream" has rarely been used in the context of Git,
but because it is a natural opposite for the word "upstream", I've seen it
used when people talk about others who fork from them, e.g. Linus can call
his lieutenants his downstream.

The word "upstream" almost always refers to "the place the updates from
others come to me from".  Linus is the upstream for his lieutenants---the
lieutenants pull from Linus.  In the shared repository "everybody pulls
from there to get updates from others, and everybody pushes there to
propagate their own work to others" setting, the shared repository is the
upstream for the project participants---again, they pull from there.

Notice however that the word "upstream" is meaningless for the integrator
with the above definition of the word.  "The place the updates from others
come to Linus from" ought to be his "upstream", but the workflow does not
go like so. Linus does not have a fixed "upstream" he pulls from before
he starts his day. For that matter, the lieutenants are not supposed to
pull from Linus every day before they start their work, either, but when
they need to synchronize with the upstream, they pull from Linus, so in
that sense, the word "upstream" means something to them.

I suspect that using the word "downstream" to mean "the place the result
of my work is pushed to" will only add to the confusion.

In a distributed "kernel-like" workflow, the lieutenants obviously do not
push to Linus's repository. If we raise the level of discussion to talk
about the flows of data, ignoring the difference of mechanism used
(i.e. "push" vs "format-patch | send-email"), the work by lieutenants is
still fed back to their "upstream".  They "upstream" (verb) the result of
their work.

Perhaps it was a mistake to use the word "upstream" in a shared repository
workflow, which invites the confusing word "downstream". In that context,
there is not really an "up" vs "down" relationship.  "shared" vs "mine"
relationship is all that exists in that context.
