From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] post-checkout hook, and related docs and tests
Date: Tue, 25 Sep 2007 14:29:07 -0700
Message-ID: <7v4phi5t98.fsf@gitster.siamese.dyndns.org>
References: <1190406421-15620-1-git-send-email-jjengla@sandia.gov>
	<7vzlzfh7xd.fsf@gitster.siamese.dyndns.org>
	<1190654052.6078.14.camel@beauty>
	<7vsl53ap5x.fsf@gitster.siamese.dyndns.org>
	<1190662396.6078.63.camel@beauty>
	<7vejgnai1z.fsf@gitster.siamese.dyndns.org>
	<1190671558.6078.87.camel@beauty>
	<7vfy138vql.fsf@gitster.siamese.dyndns.org>
	<1190738473.6078.102.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Josh England" <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Tue Sep 25 23:29:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaHy3-0001jK-W9
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 23:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926AbXIYV3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 17:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754957AbXIYV3J
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 17:29:09 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:62059 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452AbXIYV3I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 17:29:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070925212908.WPPG27287.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 25 Sep 2007 17:29:08 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id slV71X0081gtr5g0000000; Tue, 25 Sep 2007 17:29:07 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59176>

"Josh England" <jjengla@sandia.gov> writes:

> So this leads to my next question:  Should the post-merge patch be
> brought in under this same umbrella to form a single post-checkout hook,
> or should it stay a separate hook?

I think it is called would be inconvenient for the callee if you
call the same hook without telling the hook script why it is
called, so if you go in the unification route the caller of the
unified hook needs to supply an extra parameter and existing
hooks if any need to be updated --- neither sounds like a very
idea.  The writer of the hooks however can choose to call one
from the other if he wants the same action for both hooks, so it
looks to me that separate hooks for separate purposes is the way
to go.
