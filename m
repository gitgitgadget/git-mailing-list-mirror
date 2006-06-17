From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: [PATCH] CVSps fixed; git-cvsimport works, too
Date: Sat, 17 Jun 2006 10:34:43 -0400
Message-ID: <20060617143443.GA29602@pe.Belkin>
References: <20060617122158.GQ7766@nowhere.earth> <20060617132023.GA29452@pe.Belkin> <20060617134717.GR7766@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>, cvsps@dm.cobite.com
X-From: git-owner@vger.kernel.org Sat Jun 17 16:34:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frbsx-0004aV-2N
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 16:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbWFQOeq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 10:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWFQOep
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 10:34:45 -0400
Received: from eastrmmtao02.cox.net ([68.230.240.37]:15020 "EHLO
	eastrmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751638AbWFQOep (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 10:34:45 -0400
Received: from localhost ([68.0.253.29]) by eastrmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060617143444.XQTV15470.eastrmmtao02.cox.net@localhost>;
          Sat, 17 Jun 2006 10:34:44 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1Frbsp-0007hi-Rl; Sat, 17 Jun 2006 10:34:43 -0400
To: Yann Dirson <ydirson@altern.org>
Content-Disposition: inline
In-Reply-To: <20060617134717.GR7766@nowhere.earth>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22017>

On Sat, Jun 17, 2006 at 03:47:17PM +0200, Yann Dirson wrote:
> On Sat, Jun 17, 2006 at 09:20:23AM -0400, Chris Shoemaker wrote:
> > > 
> > > * when run with "-A" cvsps notices the inconsistency:
> > > 
> > > invalid initial_branch for file a, probably from old cache, run with -x.
> > 
> > good advice.
> > 
> > > 
> > > 
> > > I have included the current version of your patch in branch "to-check"
> > > in http://ydirson.free.fr/soft/git/cvsps.git/.  I did not tak time to
> > > look at it closely yet - do you plan to work on this issue ?
> > 
> > I wondered if you'd find that.  Evidentally, you're being thorough. :)
> > 
> > The intent of my patch is only to affect the branch ancestry
> > calculation.  IIRC, the patch version is incompatible with cached
> > results from unpatched versions.  Hence I would only expect it to work
> > with '-x -A' (unless there was no pre-existing cache file).
> 
> All those tests were done with your patch applied, so the cache was
> generated and re-read using the pached version.

Are you saying there was no pre-existing cache file when the patched
version was first run?  Did you delete it?  If so, then there's a bug
somewhere.

> 
> > There's probably some nicer way to handle the cache incompatibility,
> > but my current approach has been to tell people to delete their old
> > cache file or run wih -x.  Suggestions are welcome.
> 
> If the cache format is changed, this would be a good candidate for the
> "v2" cache format.  I already have 2 (incomplete) patches that well
> need to bump the cache format version - see branches multitag (allow
> several tags per patchset) and semicolon (allow semicolons in
> filenames).

IIRC, it's not syntactically incompatible - it's just that the patched
version can tell that it doesn't trust the initial branch
determinations that are stored in the cache file by an unpatched
version.

The complaint is basically, Hey, there's an initial branch
determination already made for this file, but it's not the one I would
have made, so it must have been restored from a cache file that I
didn't make.

-chris

> 
> Best regards,
> -- 
> Yann Dirson    <ydirson@altern.org> |
> Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
>                                     |  Freedom, Power, Stability, Gratis
>      http://ydirson.free.fr/        | Check <http://www.debian.org/>
