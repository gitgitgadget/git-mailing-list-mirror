From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Thu, 16 May 2013 16:24:24 -0700
Message-ID: <7vk3my33vb.fsf@alter.siamese.dyndns.org>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<7v61yi9arl.fsf@alter.siamese.dyndns.org>
	<CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com>
	<7v8v3e7udi.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Szu8oHBKMapZ6dQ1K67MXDcACuUF-+Y-jC+EgHs2QEA@mail.gmail.com>
	<7vk3my6bu1.fsf@alter.siamese.dyndns.org>
	<CAMP44s2W5MUneTwcSnr=Ey715paKgSL6MqXmYKdSmw4NqdL4qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 01:24:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud7XJ-0003JA-Mp
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 01:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691Ab3EPXY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 19:24:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38211 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977Ab3EPXY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 19:24:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E79A1FD58;
	Thu, 16 May 2013 23:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zn12Jwbf6gj16eYcZnU/CeaPO8Q=; b=yDoDu1
	sjeolTUXb4BOvmWiXXri8xYbv1EoZyUaVUUHzTl8UFqWBmy9o/CKoJHcpdwqkHj3
	wJLsdXsz77O40f1qPzbDfqhfrjMyDxjkwDZSqj/rxRD6496dwB8XSzvUB0i/Q3+r
	6ztOu//nZIqHADXOTt4RmsYypbfzRoyM80k2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C5BI8MsBAkfgOzWQBSQ1kdG7VfNaPEUW
	X4EzkJhHvq4vzNW5bvW/iel7xMJOafAZmioHdgtUuJzDGHblaZBypMl1UM8GIza9
	3MFoFOTR0+IuPQfq6r+VoZVGZdm9KuQD/PWH94D2QjPGWVzN1l0Qt33fACRhHedO
	5S5IggsmQFk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6279B1FD56;
	Thu, 16 May 2013 23:24:26 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C04711FD55;
	Thu, 16 May 2013 23:24:25 +0000 (UTC)
In-Reply-To: <CAMP44s2W5MUneTwcSnr=Ey715paKgSL6MqXmYKdSmw4NqdL4qQ@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 18:07:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF8781D8-BE7F-11E2-BBD4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224633>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, May 16, 2013 at 1:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>>> If you come from "git pull" is "git fetch" + "git merge",
>>>> and if your current branch is integrating with your local branch,
>>>
>>> How many times do I have to say that 'git pull' is not 'git fetch' +
>>> 'git merge'?
>>>
>>> You must think everybody has 'merge.defaulttoupstream=true'.
>>
>> I am confused.  What does that have anything to do with this topic?
>> It only affects what a lazy "git merge" (without any other parameter
>> on the command line) does, doesn't it?
>
> And that's what we are talking about here; commands without any other
> parameter in the command like.
>
> So "git pull $nothing" is *not* "git fetch $nothing" + "git merge $nothing".

Of course not.  But what does it change the equation?

Let's rephrase the above, then.

	"git pull" with 0 or more arguments is to first

        - make sure that necessary history is available in your
          repository

        - prepare FETCH_HEAD to record what is to be merged

        which is done by running "git fetch" with appropriate
        arguments against the repository of your upstream, and then
        to

        - merge the upstream history

        which is done by running "git merge" with appropriate
        arguments (which in turn is formulated by reading FETCH_HEAD
        that is left by the previous "git fetch" step).

So if your "upstream" happens to live in a local repository, it is
very natural to run "git fetch" against repository "." (with
appropriate arguments, like 'refs/heads/master' if you were on your
mywork branch that was forked from your 'master' branch).  Running
"git fetch ." is hardly "does not make any sense whatever" from that
point of view.  It is just a natural consequence that our local
repository is merely one of the repositories we could fetch/pull
from.
