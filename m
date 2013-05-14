From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/10] remote-hg: fixes and cleanups
Date: Tue, 14 May 2013 11:21:26 -0700
Message-ID: <7vhai5juc9.fsf@alter.siamese.dyndns.org>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<7vfvxql66j.fsf@alter.siamese.dyndns.org>
	<CAMP44s134n9az4anLAnNH6DLT92kAJjW3_rYUx1hGZJ6ECWAYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 20:21:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcJqz-0000Ay-R1
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 20:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758071Ab3ENSVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 14:21:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56884 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758067Ab3ENSV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 14:21:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ECE91EC91;
	Tue, 14 May 2013 18:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ETzp9uq2YKRo2YEMOImvQx33lgk=; b=OOX6p5
	zc5PQLA+/PWHtJoN9rVHICpfY4xQ8hHsULbpt33kJ0RHYZk/Ac7sCY9eeEDab+xj
	48l4l+vlBuAEVU9d9CtiACfl9LML2XPPNj1fYGiV7FIJFDYBZ+xv+vBDVgnjEbGI
	TmI+M9CMzfYS8M30xcDxfxG3AqDMy1SJYBxug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CwUKy4yEQfQAj4I4ljh6fmNb3nV+J4ta
	ilPs4Zl63Y/uylN/NGTZUNNV5GINCY0LeCDaPZhARcoFRKjd2QjcZ6k5XsQ6BMnd
	HwzCf1KR0DKffL//b6mAm+070mBzGgIMl69fE1/sEIZJmTVxv1qT/7SFqa7EOzyb
	QUaK+HviG6A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96CB91EC90;
	Tue, 14 May 2013 18:21:28 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 193671EC8D;
	Tue, 14 May 2013 18:21:28 +0000 (UTC)
In-Reply-To: <CAMP44s134n9az4anLAnNH6DLT92kAJjW3_rYUx1hGZJ6ECWAYA@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 13 May 2013 22:34:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17F4DB4A-BCC3-11E2-A024-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224310>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, May 13, 2013 at 8:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> And others, please spend time on testing the 1.8.3-rc2 to make sure
>> what we are going to ship is free of embarrassing regressions.
>
> The whole purpose of this series is to avoid regressions, that's why I
> sent them for 1.8.3.

We agreed to make an exception to let remote-bzr updates go in even
after v1.8.3-rc1, because it is too young and you can afford to
check that the updated code will give only gains to its userbase
that matters without hurting them by checking with Emacs and other
projects.

I do not recall us doing a similar exception for remote-hg.  Did we?

If we didn't, then a 10-patch series at this point in the cycle is
way too late for me to be comfortable taking.

We merged the 21-patch remote-hg series from you on Apr 21st, a week
before -rc0, and it has been 3 weeks.  Back then you thought it made
things better without regression, and I expected that loose ends
could be fixed by -rc1 with enough time to cook them in 'next'
(meaning tying such loose ends would be just the matter of a couple
of trivial patches at most).  But now you are saying they regress
things and need 6 (in 'next') + 10 + 47 patches to fix on top, in
order not to hurt existing users?

What is going on?

People make mistakes and the initial submission being buggy is *not*
a problem per-se, but what quality assurance do the 10-patch and/or
the follow up 47-patch series have over these 21 patches to assure
us that they do not introduce more problems, when we are this close
to the final, way less than the 3 weeks we had?

The best we could do to avoid regressions (if there are reported
ones) is to revert specific changes that cause the regression that
are already in v1.8.3-rc2.  Which one(s) should we be reverting, and
do you have a regression report that says the commit(s) in question
breaks things for a specific project, and reverting it(them) makes
things work again?
