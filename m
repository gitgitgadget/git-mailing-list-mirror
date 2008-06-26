From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
 to
Date: Thu, 26 Jun 2008 03:59:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0806260121000.4503@eeepc-johanness>
References: <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com> <alpine.DEB.1.00.0806251109380.9925@racer> <486220CE.3070103@viscovery.net> <alpine.DEB.1.00.0806251334060.9925@racer> <20080625135100.GF20361@mit.edu>
 <7v63rx2zwf.fsf@gitster.siamese.dyndns.org> <20080625195003.GB15077@mit.edu> <32541b130806251304u39c8ffdenc52904391aebd089@mail.gmail.com> <20080625203822.GA7827@mit.edu> <20080625224428.GB12567@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>, Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jun 26 04:00:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBgmw-0002Ol-KJ
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 04:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbYFZB7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 21:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbYFZB7Y
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 21:59:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:51823 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751252AbYFZB7X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 21:59:23 -0400
Received: (qmail invoked by alias); 26 Jun 2008 01:59:21 -0000
Received: from unknown (EHLO eeepc-johanness) [87.112.52.237]
  by mail.gmx.net (mp056) with SMTP; 26 Jun 2008 03:59:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+tx3xU7FatF5sdk32w+4l1T3m29yBe3377DfwbTQ
	S8B9OXKWvKzqJY
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080625224428.GB12567@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86385>

Hi,

On Thu, 26 Jun 2008, Petr Baudis wrote:

> On Wed, Jun 25, 2008 at 04:38:22PM -0400, Theodore Tso wrote:
> > On Wed, Jun 25, 2008 at 04:04:47PM -0400, Avery Pennarun wrote:
> > > How about making "git checkout" default to HEAD if no revision is 
> > > supplied?  There's precedent for this in, say, git-diff (and I think 
> > > a few others).
> > > 
> > > Incidentally, "checkout <filename>" was also the way to do a revert 
> > > operation in CVS.  And the way to switch branches, too, iirc.  So 
> > > git isn't being too unusual here.  That said, the commands were 
> > > deliberately renamed in svn because CVS was considered largely 
> > > insane.
> > 
> > The one thing I would worry about is the potential ambiguity if you do 
> > something like "git checkout FOOBAR", and FOOBAR was both a branch 
> > name as well as a file name.  How should it be interpreted?  I'd argue 
> > the real problem was we conflated two distinct operations: "switching 
> > to a new branch", and "reverting a file" to the same name, checkout.
> > 
> > Hence the suggestion to add a new command, "git revert-file", where 
> > there would be no ambiguity.
> 
> Just to chime in, this reminds me of Cogito - it had cg-switch for
> switching branches (like git checkout) and cg-restore for restoring
> files in working copy (like git checkout, too; but you would pass -f if
> you wanted to overwrite existing copy).

Yeah, I was kinda disappointed that this part of Cogito never was picked 
up by Git "core".

I really liked the fact that Cogito was a test-bed for UI enhancements, 
and miss it a bit.  It was nice how it drove the UI enhancements of Git, 
and I am a little sad that Cogito was discontinued.  (And no, I do not see 
any contender picking up the task of driving Git's UI in the right 
direction.)
 
> (Though, Cogito didn't quite get it right either since it tried to 
> overload cg-switch with the git branch functionality of creating new 
> branches. I still didn't quite come in terms with any UI model of the 
> branches I know about.)

To the contrary, I think that "git branch --create <branch>" _should_ 
switch to the newly created branch.  That is what users expect, and Cogito 
got that right.

Ciao,
Dscho
