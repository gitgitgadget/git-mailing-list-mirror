From: Gerrit Pape <pape@smarden.org>
Subject: Re: Why /var/cache/git?
Date: Tue, 26 Oct 2010 15:22:18 +0000
Message-ID: <20101026152218.3931.qmail@d862ae2b10e11a.315fe32.mid.smarden.org>
References: <20101025103006.GA18782@brong.net> <4CC5A13F.2090702@eaglescrag.net> <20101026012224.GA3360@brong.net> <1288099299.8291.6.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bron Gondwana <brong@fastmail.fm>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Oct 26 17:29:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAlSW-0006S8-RH
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 17:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757343Ab0JZP3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 11:29:01 -0400
Received: from a.ns.smarden.org ([109.68.224.7]:41809 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754095Ab0JZP3A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 11:29:00 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Oct 2010 11:29:00 EDT
Received: (qmail 3932 invoked by uid 1000); 26 Oct 2010 15:22:18 -0000
Content-Disposition: inline
In-Reply-To: <1288099299.8291.6.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159994>

On Tue, Oct 26, 2010 at 09:21:39AM -0400, Drew Northup wrote:
> On Tue, 2010-10-26 at 12:22 +1100, Bron Gondwana wrote:
> > I have no problem with /var/git - it's /var/cache/git that worries
> > me, since the FHS quite clearly says that blowing away /var/cache/*
> > is not a problem.  It makes sense to back up /var/lib/ on any machine,
> > since that's somewhere that contains application data.  We already
> > back up a few things from /var/lib (like /var/lib/svn for example,
> > at least until we finish this switchover!)
> 
> Bron,
> Doing a 'git grep "/var"' on the git sources and then searching that
> output for "cache" turns up nothing. I think you'd best bring this up
> with the Debian package maintainer. Debian is well known for thinking it
> knows better than the original authors where stuff should be--and that's
> why I don't run Debian as a server (too much time spent transliterating
> paths just to make stuff work properly--when I'm lucky; it makes an
> excellent desktop for beginners).

Hi, it's also not my preference, but Debian adheres to the FHS.
Unfortunately /var/git is not allowed by the FHS, so a different
location must be chosen for Debian.  I chose /var/cache/git/, and
suggested to populate that directory with symlinks to the repositories
that should be available through git-daemon or gitweb, see
http://bugs.debian.org/483788

Regards, Gerrit.
