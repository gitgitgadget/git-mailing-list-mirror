From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] NO_PERL support
Date: Fri, 3 Apr 2009 10:53:29 -0400
Message-ID: <20090403145329.GA25967@coredump.intra.peff.net>
References: <20090403T065545Z@curie.orbis-terrarum.net> <20090403132029.GC21153@coredump.intra.peff.net> <alpine.DEB.1.00.0904031649400.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 03 16:55:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpknx-0001S5-DC
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 16:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934271AbZDCOxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 10:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934267AbZDCOxq
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 10:53:46 -0400
Received: from peff.net ([208.65.91.99]:39920 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934291AbZDCOxp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 10:53:45 -0400
Received: (qmail 31985 invoked by uid 107); 3 Apr 2009 14:54:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 03 Apr 2009 10:54:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2009 10:53:29 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904031649400.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115533>

On Fri, Apr 03, 2009 at 04:51:09PM +0200, Johannes Schindelin wrote:

> > Hmm. With this patch, a user with a NO_PERL build will just get:
> > 
> >   $ git svn
> >   git: 'svn' is not a git-command. See 'git --help'.
> >   $ git add -i
> >   error: unknown switch `i'
> >   usage: ...
> > 
> > I wonder if we should be a little nicer and say "we know about this
> > command or option, but we did not build support for it". OTOH, what you
> > have mirrors what NO_TCLTK does, so perhaps it is not a big deal.
> 
> Actually, "add -i" is a part of another program that does work without 
> Perl, so it is quite a different kind of kettle.
> 
> It is not like "git gui" works with NO_TCLTK but "git gui -i" does not.

Yes, there are really two cases here:

  1. options to programs that will be disabled

  2. whole programs that will not be installed

Are you proposing to print "sorry, perl support not compiled in" (or
whatever) for case 1, but ignore case 2? (And I am not sure if that is a
bad idea, but I am trying to be clear on what you mean).

-Peff
