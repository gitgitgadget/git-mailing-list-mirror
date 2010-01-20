From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 15:14:26 -0800
Message-ID: <7vljfsz7vx.fsf@alter.siamese.dyndns.org>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
 <7vhbqg376b.fsf@alter.siamese.dyndns.org>
 <20100120195626.GA6641@gnu.kitenet.net>
 <7vska01qrt.fsf@alter.siamese.dyndns.org>
 <4B576F5C.2050102@drmicha.warpmail.net>
 <7veilk1o3s.fsf@alter.siamese.dyndns.org>
 <7v3a201lpz.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1001202354070.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Joey Hess <joey@kitenet.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 21 00:16:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXjlU-0001SK-WE
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 00:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907Ab0ATXOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 18:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862Ab0ATXOn
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 18:14:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850Ab0ATXOl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 18:14:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ECB5E92919;
	Wed, 20 Jan 2010 18:14:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hl35gZspe8fRnYQT0FjE8qAe+kY=; b=wVYfcP
	2BoN5XS8Qsp9Hib7RnSuTkSL/4koL23jo4rHjO2PgV05pJkn6UL6O4qbCkYdPqJs
	EsNiiYmOvYmZOZK5nz6rSKMXQS2RN2THhkm0NqsFKEgaIzy/WVF136ed9ssBIDZ4
	6pF5xSy9o9bUdePhK/5Gu/c0ubdKIrx95+tmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PI38N/+e26jQGnixcJ3/K/p2UmdjtosY
	8coFga5V2u9KRlLvvfX+MnUPnSuYuUHzXPa3PYeIR2ypzd+HppUctFzPx+Zsy1g8
	zuKHm4Aw+1dglc9WvJ/QUOE1O6kinaxfbwg2rzujU7kMLAFp7uJ18HUG9SXvvOYb
	MhHWrNsYIQ4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 933BA92911;
	Wed, 20 Jan 2010 18:14:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B8CC92908; Wed, 20 Jan
 2010 18:14:27 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1001202354070.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed\, 20 Jan 2010 23\:58\:07 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 91DF0516-0619-11DF-A736-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137600>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Makes sense, and the patch actually removes what could be seen as an ugly 
> side effect (why it only ONELINE not getting notes?).

Thanks.

The motivation was that the user should be able to get notes even under
ONELINE mode if desired.  But then the call to get_commit_notes() may want
to inspect the commit format being used and tweak the flag parameter; right
now it always sends NOTES_SHOW_HEADER and NOTES_INDENT.

> I would agree with Peff about the mention of --pretty disabling notes 
> (unless asked for by a user format) in the commit notes as well as in the 
> pretty options,...

Actually I am of two minds regarding --pretty={short,medium} and the
like.  The "how about this" patch may be the safest for people who are
used to read "log --pretty=xxx" output with scripts, but it does look
inconsistent and hard to explain to new people who do not even know that
there were versions of git that does not know about notes.

> but I fully disagree on the need for tests.  We should not 
> have a thorough test suite that runs for days on end, but we should 
> concentrate on things that are more likely to get broken.  And the added 
> code is just too obvious for that.

I agree with that principle, but it doesn't explain nor justify the lack
of tests for format-patch, which would have caught the breakage a lot
earlier.

Or perhaps we all (not just you but I am just as guilty) misjudged "things
that are more likely to get broken", even though we are very well aware
that touching log-tree infrastructure will have fallout all over the "log"
family.
