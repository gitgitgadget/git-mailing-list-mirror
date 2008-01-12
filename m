From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add committer and author names to top of COMMIT_EDITMSG.
Date: Sat, 12 Jan 2008 00:02:38 -0800
Message-ID: <7vve5zv5cx.fsf@gitster.siamese.dyndns.org>
References: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com>
	<7v3at42avd.fsf@gitster.siamese.dyndns.org>
	<9b3e2dc20801111609t3103af1frc23519cab43ae8be@mail.gmail.com>
	<7vbq7r28qo.fsf@gitster.siamese.dyndns.org>
	<9b3e2dc20801111733o477b3aadv6ee76d3aafade54a@mail.gmail.com>
	<7vejcnzu5z.fsf@gitster.siamese.dyndns.org>
	<9b3e2dc20801111825i644da598i7556ef700b870445@mail.gmail.com>
	<7vve5zy72p.fsf@gitster.siamese.dyndns.org>
	<9b3e2dc20801112326p2b4eaf96tbd036ed746eff4a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen Sinclair" <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 09:03:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDbKw-0005h6-GA
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 09:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758991AbYALICx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 03:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758408AbYALICw
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 03:02:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161AbYALICw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 03:02:52 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D0DBF4C66;
	Sat, 12 Jan 2008 03:02:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 553AB4C65;
	Sat, 12 Jan 2008 03:02:45 -0500 (EST)
In-Reply-To: <9b3e2dc20801112326p2b4eaf96tbd036ed746eff4a3@mail.gmail.com>
	(Stephen Sinclair's message of "Sat, 12 Jan 2008 02:26:24 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70294>

"Stephen Sinclair" <radarsat1@gmail.com> writes:

>> To rephrase, you would show AUTHOR when one of the conditions
>> holds true, either:
>>
>>  (1) "not me" (so that we can remind that other's commit is
>>      being amended); _OR_
>>
>>  (2) "funny me" (so that we can catch misconfiguration.
>
> I definitely agree with (1), though having not really done much
> amending of other people's commits I can't vouch for it.  I think (2)
> might not be very reliable.

Yeah, I tend to agree that (2) is probably impossible to
achieve.

Author ident should be reachable e-mail address but some people
seem to prefer committer ident to be tied to the actual machine
even if that makes the ident something that merely resembles a
valid reachable e-mail address but in fact unreachable.  For
such a committer ident, taking it from hostname would be a
reasonable thing to do, but I suspect that is a minority.

Unfortunately we do not have an easy way (other than using
GIT_COMMITTER_EMAIL environment) to define different author and
committer idents.
