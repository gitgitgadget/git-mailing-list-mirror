From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] stash: accept options also when subcommand 'save'
 is omitted
Date: Wed, 19 Aug 2009 00:46:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908190041200.8306@pacific.mpi-cbg.de>
References: <1250599567-31428-1-git-send-email-Matthieu.Moy@imag.fr> <vpqws51l1hb.fsf@bauges.imag.fr> <20090818174509.GA27518@coredump.intra.peff.net> <alpine.DEB.1.00.0908182337200.8306@pacific.mpi-cbg.de> <20090818223028.GB31176@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 19 00:45:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdXR2-000848-3B
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 00:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbZHRWph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 18:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbZHRWph
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 18:45:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:52128 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750787AbZHRWpg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 18:45:36 -0400
Received: (qmail invoked by alias); 18 Aug 2009 22:45:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 19 Aug 2009 00:45:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19JEQBc5OpJDY1ZohqEm73z1re+Zduy5L6DKZ9pmJ
	edr7UnWc1Jcxy1
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090818223028.GB31176@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126477>

Hi,

On Tue, 18 Aug 2009, Jeff King wrote:

> On Tue, Aug 18, 2009 at 11:42:58PM +0200, Johannes Schindelin wrote:
> 
> > > I think yours is nicer, especially as we have just added the 
> > > '-p|--patch' option, as well. With what is there now, you can do 
> > > "git stash -p", but not "git stash -p -k".
> > 
> > But it is sloppy, in that it blindly accepts options that might be 
> > valid for several subcommands, not just "save".
> > 
> > That was the reason I did not implement it this way.
> > 
> > But we do not have such ambiguous options yet.
> > 
> > Or do we?  Look at what "list" accepts!
> > 
> > So please register my objection.
> 
> I don't see the problem. Either the option works for "stash save" or it
> does not.  If I say "git stash --quiet", then it _must_ be "git stash
> save --quiet", and not "git stash pop --quiet", because "save" is the
> only default command.

So if I say "git stash -q" by mistake, but wanted to say "git stash drop 
-q", then I am borked?

Bah!  I say: bah!

You're basically reintroducing at least part of the DWIMery that was 
reverted in 9488e875 and I have the distinct feeling that some people in 
this thread do not think hard enough about what would adher to the 
principle of least surprise even in the future (or even for people 
introducing other stash save options).

Well, you just go ahead and push through your patch, and I do what I 
promised on my blog.
