From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH decompress BUG] Fix decompress_next_from() wrong argument value
Date: Fri, 11 Jan 2008 16:16:16 -0800
Message-ID: <7vfxx3290v.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550801111247l1ccf171ene5b53b8d6841a864@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 01:17:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDU3V-0000s6-Tp
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 01:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760038AbYALAQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 19:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbYALAQa
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 19:16:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbYALAQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 19:16:29 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 38045343A;
	Fri, 11 Jan 2008 19:16:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A6F653437;
	Fri, 11 Jan 2008 19:16:23 -0500 (EST)
In-Reply-To: <e5bfff550801111247l1ccf171ene5b53b8d6841a864@mail.gmail.com>
	(Marco Costalba's message of "Fri, 11 Jan 2008 21:47:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70231>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Patch to be applied above decompress helper series.

No way.  That will mean that the resulting series will start
with a known bug.

> Not to be pedantic, but have a function that gives two really
> coupled values, as a buffer pointer and the size, the first as return
> value and the second through a variable at file scope is not something
> you are going to see advertised in the programming books!
>
> Sorry for this little rant but this bug really made me crazy.

Pardon me.  Are you talking about a bug you introduced earlier
in your own series that hasn't been applied (and you very well
know will not be until 1.5.4 is out, now we are deep in -rc
cycle)?

If so, you did a great disservice to me by sounding as if you
are blaming somebody else's existing bug.  I wasted some time
hunting for a non-existent bug in the code that is being readied
for 1.5.4 final for quite some time, in order to pick only the
relevant "fix" from your patch.

It turns out, luckily, existing code did not have such a bug.
What a relief for the maintainer in bugfix-only freeze mode.

Next time around, please mark the patch on the Subject: line to
be squashed to your earlier [PATCH 5/6] before [PATCH 6/6].
That will also solve the bisectability problem.

Anyway, thanks.  I was planning to queue the series in 'pu' or
'next' after tagging -rc3, so not be silent and giving a proper
fix was the right thing to do.  My above rant is just about the
presentation.
