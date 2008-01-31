From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-push: forced update of tag shows unabbreviated SHA1
Date: Thu, 31 Jan 2008 02:21:49 -0800
Message-ID: <7vodb2cn2a.fsf@gitster.siamese.dyndns.org>
References: <47A1948F.6080308@viscovery.net>
	<20080131100625.GB25546@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 11:22:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKWZG-00011T-RG
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 11:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764934AbYAaKWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 05:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbYAaKWG
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 05:22:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933019AbYAaKWB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 05:22:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 59E4E38AD;
	Thu, 31 Jan 2008 05:21:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DB05638AB;
	Thu, 31 Jan 2008 05:21:55 -0500 (EST)
In-Reply-To: <20080131100625.GB25546@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 31 Jan 2008 05:06:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72119>

Jeff King <peff@peff.net> writes:

> ... then for every 12345678* that we don't have, we will claim
> the correct abbreviation is 1234568.
>
> In practice, I doubt this is a problem.
>
> But getting back to your point: yes, I agree it is a little ugly.
> Rewriting find_unique_abbrev would be necessary for fixing it, and I'm
> not sure it is worth the trouble.

I think that needs to be done carefully.  I recall some callers
do expect it to return NULL for nonexistant objects, so the bug
you noted above as "rare case" may need to be fixed, which I
think is more important than coming up with a potentially too
short abbreviation.
