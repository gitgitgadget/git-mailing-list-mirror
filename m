From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Fri, 24 Mar 2006 19:37:12 -0500
Message-ID: <20060325003712.GA32320@pe.Belkin>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org> <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org> <Pine.LNX.4.64.0603221717120.26286@g5.osdl.org> <20060323200306.GG31387@lug-owl.de> <20060324003944.GA28652@pe.Belkin> <20060324075229.GH31387@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 25 01:37:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMwmO-0004AH-9V
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 01:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWCYAhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 19:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWCYAhP
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 19:37:15 -0500
Received: from eastrmmtao01.cox.net ([68.230.240.38]:37609 "EHLO
	eastrmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751221AbWCYAhO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 19:37:14 -0500
Received: from localhost ([24.250.31.7]) by eastrmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060325003706.IIW3988.eastrmmtao01.cox.net@localhost>;
          Fri, 24 Mar 2006 19:37:06 -0500
Received: from chris by localhost with local (Exim 4.43)
	id 1FMwmG-0008Pv-Mr; Fri, 24 Mar 2006 19:37:12 -0500
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Content-Disposition: inline
In-Reply-To: <20060324075229.GH31387@lug-owl.de>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17944>

On Fri, Mar 24, 2006 at 08:52:29AM +0100, Jan-Benedict Glaw wrote:
> On Thu, 2006-03-23 19:39:44 -0500, Chris Shoemaker <c.shoemaker@cox.net> wrote:
> > On Thu, Mar 23, 2006 at 09:03:06PM +0100, Jan-Benedict Glaw wrote:
> > > On Wed, 2006-03-22 17:28:23 -0800, Linus Torvalds <torvalds@osdl.org> wrote:
> > > It seems there's a patch like
> > > http://www.gelato.unsw.edu.au/archives/git/0602/16278.html is missing?
> > > ...or we need a better cvsps.  Shall I add it and try again / try to
> > > continue, or give up on it for now?  Though it would be nice to have
> > > these two large and important source trees under GIT control :-)
> > 
> > You make want to try the cvsps patch I attached to the email here:
> > 
> > http://www.gelato.unsw.edu.au/archives/git/0511/11812.html
> 
> [...]

> invalid initial_branch for file bfd/po/BLD-POTFILES.in, probably
> from old cache, run with -x.

I guess that error message wasn't quite as obvious as I intended.

That means you have old cvsps cache state hanging around.  You can
either run cvsps with -x or delete the cache file manually.  Those are
the files in ~/.cvsps.

Incidentally, I'd recommend doing this in two stages during
trouble-shooting.  Run cvsps first and verify that you can produce a
valid ancestry tree.  If it's not-quite-right you can even edit the
cvsps output to reparent the incorrect branches.  Then run
git-cvsimport after you're satisfied with the ancestry.

-chris
