From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsserver runs hooks/post-receive
Date: Sat, 01 Dec 2007 11:38:37 -0800
Message-ID: <7vprxq4342.fsf@gitster.siamese.dyndns.org>
References: <1195809174-28142-1-git-send-email-mfwitten@mit.edu>
	<7v3aup291c.fsf@gitster.siamese.dyndns.org>
	<7F81126E-5A76-40CA-94BF-82B46C57AFF6@mit.edu>
	<7vmysv87jm.fsf@gitster.siamese.dyndns.org>
	<BFDB9A00-6E92-4880-9FE7-3D0E392D18A9@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat Dec 01 20:39:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyYB5-0005OJ-DA
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 20:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbXLATin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 14:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbXLATin
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 14:38:43 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59812 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXLATim (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 14:38:42 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id ED91C2F0;
	Sat,  1 Dec 2007 14:39:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 749629AD82;
	Sat,  1 Dec 2007 14:39:01 -0500 (EST)
In-Reply-To: <BFDB9A00-6E92-4880-9FE7-3D0E392D18A9@mit.edu> (Michael Witten's
	message of "Sat, 1 Dec 2007 04:17:02 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66734>

Michael Witten <mfwitten@MIT.EDU> writes:

> On 30 Nov 2007, at 9:37:01 PM, Junio C Hamano wrote:
>
>> I'll queue your patch, but I think it should be enhanced to support
>> post-update for consistency.
>
> I'll send another patch that includes support for post-update.
>
>> I'll queue your patch,
>
> Will the old patch already be in place?

Although I would encourage total replacement patch for things not in
'next' yet, in this case, I think we both would prefer a separate patch
that builds on top of the old patch that teaches the server that it
should call post-update as well.

I think it is potentially a sensible thing to do to eventually deprecate
and then remove post-update hook (as your first patch that is queued
already suggests).  I was just saying that 'eventually' is not now.
When that time comes, if you have a separate patch to teach post-update,
that single patch can be reverted independently from the old patch,
which should be less error prone than yanking the support out by hand.
