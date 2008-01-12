From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add committer and author names to top of COMMIT_EDITMSG.
Date: Fri, 11 Jan 2008 21:30:24 -0800
Message-ID: <7vlk6vy5jj.fsf@gitster.siamese.dyndns.org>
References: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com>
	<7v3at42avd.fsf@gitster.siamese.dyndns.org>
	<9b3e2dc20801111609t3103af1frc23519cab43ae8be@mail.gmail.com>
	<7vbq7r28qo.fsf@gitster.siamese.dyndns.org>
	<9b3e2dc20801111733o477b3aadv6ee76d3aafade54a@mail.gmail.com>
	<7vejcnzu5z.fsf@gitster.siamese.dyndns.org>
	<20080112045231.GB5211@coredump.intra.peff.net>
	<7vprw7y6mz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Sinclair <radarsat1@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 06:31:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDYxb-0008OG-H9
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 06:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbYALFan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 00:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbYALFan
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 00:30:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbYALFam (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 00:30:42 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 08B084662;
	Sat, 12 Jan 2008 00:30:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 72F5B4660;
	Sat, 12 Jan 2008 00:30:37 -0500 (EST)
In-Reply-To: <7vprw7y6mz.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 11 Jan 2008 21:06:44 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70266>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> This is obviously not 1.5.4 material, so I haven't given it that much
>> thought either. But perhaps Stephen's "author message" should simply
>> trigger any time the author is pulled from gecos?

I think what we could do if we wanted to protect people from
unconfigured identity is to stop pulling names from gecos and
hostname, and respect _only_ environment and config.

And fail any operation that we would want configured name and
email (names in reflog does not count as such an operation ---
we've made that mistake once, which made "git clone" impossible
before setting up $HOME/.gitconfig).

That I think I can live with.

If we do that, we do not have to see two extra lines (COMMITTER
and AUTHOR) that spells our own name in the commit message
buffer, which almost always will be a total waste of space.
