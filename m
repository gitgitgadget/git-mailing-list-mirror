From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] transport-helper: update remote helper namespace
Date: Sat, 13 Apr 2013 22:13:55 -0700
Message-ID: <7v8v4l7ils.fsf@alter.siamese.dyndns.org>
References: <1365638832-9000-1-git-send-email-felipe.contreras@gmail.com>
 <1365638832-9000-3-git-send-email-felipe.contreras@gmail.com>
 <20130411043346.GE14551@sigill.intra.peff.net>
 <CAMP44s0FkiwPMJVhVBNa32J3rgghRZy6xDTN-YnHKcQ4Fj0BMQ@mail.gmail.com>
 <20130411050509.GC27795@sigill.intra.peff.net>
 <CAMP44s1LF46VU0E4W=r-qog3JY+Y-qyYGfkqxLEnTG8X8GoWOA@mail.gmail.com>
 <CAMP44s3+eaRbeXP0bPXMSE8Z1K_Lqyu8e1XCvudkapkTJFBWnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 08:05:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URG3v-0001Hn-Dl
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 08:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140Ab3DNGFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 02:05:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45554 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab3DNGFG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 02:05:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92DDFE3ED;
	Sun, 14 Apr 2013 06:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=aU4O6HuJ5oBewzphGBv2fay/hzY=; b=gmDEEwyS1WK1f2RRXloj
	SAIMiJ7TOBQyn3y0sLy7xp/EQzkyNLF8TustjHQwD6z9Rp3qWyOq6m+vgorHHPcl
	pBs48XRbSsVqSv5a4kjqKBwEXBcFkJA15M6g9ssKQB2WwajVR3AbJ/U6sSHNEosr
	F4V8X83WUu3f5Fh7p8P3Hm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=TUPrqQUc6GcvcRwA89jjym5IEgdAzPI6YLt/G78iQBI3aA
	RrN1gs4FzLMNsWDOVMkGPla3F5VRExvB/ayJQgI31DSACNwVCUOiCVgyyrB+Pc4v
	SaMKOLtDrCz6+7A+1PlupCZ7MsXqdwxPE0H8NlmdG7td8JMicJoWo6xcDDgJU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89E2EE3EB;
	Sun, 14 Apr 2013 06:05:05 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1ED21E3EA; Sun, 14 Apr 2013
 06:05:05 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4075636C-A4C9-11E2-B4B1-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221081>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Why wasn't this patch merged to 'pu'? To my knowledge nobody raised
> any real concerns.

There are many reasons not to queue _everything_ ever posted to the
list on 'pu', and they are almost always not a deliberate rejection.

The maintainer may have thought he is not the best person to judge
changes to the area the patch touches, and may be expecting further
comments from others, but haven't said "Comments?" and waiting for
them to say something without being asked. Or the maintainer may
have judged that it is likely to result in wasted work if he queues
that version of the patch, fixing trivial nits himself, only to see
a reroll arrive before the day's integration cycle finishes (which
makes him run the cycle again). Or the maintainer may have been busy
tending to other topics. Or the maintainer may have pushed the patch
down the queue for any of the above reasons to deal with it later,
and after having tended to others' topics, may have forgotten about
that patch.

Do I need to go on?

> I know I said I was going
> to update the commit message, but I don't think that reason to not put
> it in 'pu'.

For this particular case, I think that was exactly the reason why it
is not in 'pu' today. I actually did not remember the reason when
you asked above, until I read the above "I said I'll update".

One major reason why I queue a patch that is clearly not ready for
'next' is because I do not want to forget about the topic and not
because I want to keep the particular version of the patch. I do so
especially when contributor is unlikely to come back soon. If you
said you would come back soon, I do not even have to judge if it is
"clearly not ready" or "it is good enough" for next, and I have to
remember one less thing. The more I can put in "this will come back
so I do not have to do anything" bin, not in the "queue it as-is for
now, because it is likely that it won't be rerolled soon and I'll
forget about it" bin, the easier for me and we as the development
process as a whole can scale better.
