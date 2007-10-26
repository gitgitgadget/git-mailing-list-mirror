From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Teach 'git pull' the '--rebase' option
Date: Fri, 26 Oct 2007 07:43:32 -0400
Message-ID: <20071026114331.GA2693@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site> <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org> <Pine.LNX.4.64.0710260007450.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 13:43:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlNbQ-0001PO-El
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 13:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbXJZLng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 07:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbXJZLng
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 07:43:36 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3635 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbXJZLnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 07:43:35 -0400
Received: (qmail 28535 invoked by uid 111); 26 Oct 2007 11:43:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 26 Oct 2007 07:43:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2007 07:43:32 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710260007450.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62409>

On Fri, Oct 26, 2007 at 12:10:08AM +0100, Johannes Schindelin wrote:

> Fair enough.
> 
> How about this in the man page:
> 
> \--rebase::
> 	Instead of a merge, perform a rebase after fetching.
> 	*NOTE:* Never do this on branches you plan to publish!  This
> 	command will _destroy_ history, and is thus only suitable for
> 	topic branches to be submitted to another committer.

Reasonable, although perhaps it should mention what I suspect might be a
common workflow for this feature: CVS emulation. I.e., there is a
central repo, which is the only thing considered "published". Developers
make commits in their local repo, and then rebase their changes onto the
HEAD before pushing. The only difference from CVS is that you don't
actually get to commit in CVS, you have to do the rebase with your
working tree. :)

I'm imagining a "pull.rebase = 1" config option, and handing this out to
developers accustomed to CVS.

-Peff
