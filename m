From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Delete current branch
Date: Fri, 19 Jul 2013 15:52:19 -0700
Message-ID: <7vmwpitb6k.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=8q4J2yi2to_+41kJSA5E59CBwkG69Hj7MmTPgUnSh5Q@mail.gmail.com>
	<7vr4euy4c6.fsf@alter.siamese.dyndns.org>
	<CALkWK0m-q=Aoof62zhXnUYsJ7PQZwTLbQ50BUEmufVO4gtWNUA@mail.gmail.com>
	<7vppuewl6h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 00:52:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0JXG-0005h1-Vv
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 00:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719Ab3GSWwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 18:52:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484Ab3GSWwW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 18:52:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 616E132A45;
	Fri, 19 Jul 2013 22:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bmLgvnIbMvVrVpdxshr+5eKqtng=; b=fEr9PO
	YeL05sH31F6xzTgxgUsFv172MhjmtTH6azAz/xLfth1IVUPuHysHWale6/DAL2T0
	oR/8PI9OxBGFZCc7Kt3uZ6orOdp1vvYcQ3wOywSc1QW9h+hevQQCtVkq5grMDIRO
	9Ol1ArFftItjnFNjGodQabRNE4CO5BnnXYRDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=En3vhTSaJ/zp6/ei3gCytWb8RGVgN14R
	rlkIpAIrwd8VIY/NraziIY+7OiRv2WTBcxs3MiHI6L8WeSMYlBFQFYZnQ+VJb3b0
	lncyfjZlj5PUTU+Y5btBCcR7tl0vKOs/ng63ddRPS8kDHN73NycvpdKLB/2YwgcU
	jmqAquPq0tQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 555F932A44;
	Fri, 19 Jul 2013 22:52:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C3FB32A43;
	Fri, 19 Jul 2013 22:52:20 +0000 (UTC)
In-Reply-To: <7vppuewl6h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 19 Jul 2013 09:48:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE7CD2F0-F0C5-11E2-B3C9-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230855>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>> Did you know that the general way to spell the branch previously you
>>> were on is "@{-1}" and "checkout -" is an ugly special case that is
>>> possible only because "checkout" does not happen to take a "-" as a
>>> valid argument that means something else (like the more usual "read
>>> from standard input")?
>>
>> I disagree that it is ugly: it's a very commonly used shortcut that I
>> like.
>
> It does not matter if you like it or not ;-).
>
> I do agree that "checkout -" is 100% more pleasing to the eye than
> "checkout @{-1}" from visual "prettyness" point of view.
>
> But there is a very commonly accepted long tradition for "-" to mean
> "read from the standard input", so we cannot reuse it to mean "the
> branch I was previously on" for every command without first making
> sure the command will never want to use "-" for the other common
> purpose.
>
> That limits the context we could use "-" and we cannot consistently
> use it everywhere. I find _that_ ugly from the "design cleanliness"
> point of view.

Having said all that.

d18ba221 (sha1_name: support @{-N} syntax in get_sha1(), 2009-01-17)
was primarily for the follow-up patch 696acf45 (checkout: implement
"-" abbreviation, add docs and tests, 2009-01-17).  Two years after
them, we finally did 4e8115ff (merge: allow "-" as a short-hand for
"previous branch", 2011-04-07).

There is no reason we cannot continue.

As long as the addition is carefully prepared so that we know it
will not conflict (or be confused by users) with possible other uses
of "-", I do not think we would mind "git branch -D -" and other
commands to learn "-" as a synonym for @{-1}.
