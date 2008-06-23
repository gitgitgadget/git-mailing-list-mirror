From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: apply --recount, was Re: [PATCH v4] git-add--interactive: manual
 hunk editing mode
Date: Mon, 23 Jun 2008 22:16:08 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806232204550.6440@racer>
References: <200805232221.45406.trast@student.ethz.ch> <200806120855.26847.trast@student.ethz.ch> <20080612071311.GA32491@sigill.intra.peff.net> <200806131748.44867.trast@student.ethz.ch> <20080623183840.GA28887@sigill.intra.peff.net> <alpine.DEB.1.00.0806231952360.6440@racer>
 <20080623195719.GB29569@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 23:19:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAtRL-0008V5-1K
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 23:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbYFWVSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 17:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754061AbYFWVSK
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 17:18:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:55160 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752998AbYFWVSI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 17:18:08 -0400
Received: (qmail invoked by alias); 23 Jun 2008 21:18:07 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp043) with SMTP; 23 Jun 2008 23:18:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19D4wA1eqVDL/kvFDV+HpGvkjNKinE9cDrq2rsY2j
	UJfGXOG6sfZdbh
X-X-Sender: gene099@racer
In-Reply-To: <20080623195719.GB29569@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85930>

Hi,

On Mon, 23 Jun 2008, Jeff King wrote:

> On Mon, Jun 23, 2008 at 07:54:29PM +0100, Johannes Schindelin wrote:
> 
> > I am not sure when I will have time for that (particularly given that 
> > I got sidetracked with the OPTION_OPTIONS patch, when I should have 
> > worked on something completely different).
> 
> Heh, I know the feeling. ;)

Yes, us mere mortals cannot hack on Linux and Git all the time, much as 
we would like to (be able to).

> > In the meantime, feel free to submit in my name.
> 
> Do you remember off the top of your head whether more work was needed? 
> They looked good to me, but then I seem to recall you saying in another 
> thread that Junio pointed out some flaw with your approach (but I never 
> quite understood what the flaw was).

I think it was not a flaw, but something to be worried about: 

http://mid.gmane.org/7v4p87zcv6.fsf@gitster.siamese.dyndns.org

To spare you following that link: Junio wanted to reuse "git apply 
--recount" to apply mboxes, where a separator "^-- $" to the signature is 
quite common, and could be mistaken for a "-" line of a hunk.

I am not quite sure how to deal with this; "--recount=nosig" (assume there 
is no signature) and "--recount=stripsig" (assume that "^-- $" is a 
lead-in to a signature) come to mind, defaulting to "nosig" with a 
warning.

However, I think that this issue should not concern us _now_.  As long as 
--recount is only to be used in "add -i" and "add -e", I think the patch 
is good as is:

http://repo.or.cz/w/git/dscho.git?a=commitdiff;h=c95d4b3da2e5f595f600720b91b8e396b43fe0ae

Ciao,
Dscho
