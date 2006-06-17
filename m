From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: [PATCH] CVSps fixed; git-cvsimport works, too
Date: Sat, 17 Jun 2006 09:20:23 -0400
Message-ID: <20060617132023.GA29452@pe.Belkin>
References: <20060617122158.GQ7766@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>, cvsps@dm.cobite.com
X-From: git-owner@vger.kernel.org Sat Jun 17 15:20:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fraj5-0001so-7Z
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 15:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWFQNUZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 09:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWFQNUZ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 09:20:25 -0400
Received: from eastrmmtao01.cox.net ([68.230.240.38]:47026 "EHLO
	eastrmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751577AbWFQNUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 09:20:25 -0400
Received: from localhost ([68.0.253.29]) by eastrmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060617132024.TSTW17255.eastrmmtao01.cox.net@localhost>;
          Sat, 17 Jun 2006 09:20:24 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1Frait-0007fx-Ls; Sat, 17 Jun 2006 09:20:23 -0400
To: Yann Dirson <ydirson@altern.org>
Content-Disposition: inline
In-Reply-To: <20060617122158.GQ7766@nowhere.earth>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22015>

On Sat, Jun 17, 2006 at 02:21:58PM +0200, Yann Dirson wrote:
> [for original thread see
> http://www.gelato.unsw.edu.au/archives/git/0511/11812.html]
> 
> Hi Chris,
> 
> I was looking at your patch and test script to decide whether to
> include it in my cvsps patch collection, but it seems there are still
> problems:
> 
> * when run with "-x" it gives the expected result, even with "-A"

This is expected.

> 
> * when run without "-x" and without "-A", the patchset introducing
> file "b" and branch "stable" does not appear, without even a warning

With out "-A" I don't think the patch is operative.

> 
> * when run with "-A" cvsps notices the inconsistency:
> 
> invalid initial_branch for file a, probably from old cache, run with -x.

good advice.

> 
> 
> I have included the current version of your patch in branch "to-check"
> in http://ydirson.free.fr/soft/git/cvsps.git/.  I did not tak time to
> look at it closely yet - do you plan to work on this issue ?

I wondered if you'd find that.  Evidentally, you're being thorough. :)

The intent of my patch is only to affect the branch ancestry
calculation.  IIRC, the patch version is incompatible with cached
results from unpatched versions.  Hence I would only expect it to work
with '-x -A' (unless there was no pre-existing cache file).

I've had one independent report of success from someone who found and
used my patch.

I haven't had to use cvsps recently, so I don't know how much time
I'll have for cvsps hacking, but I'm interested in getting feedback on
my current patch.

There's probably some nicer way to handle the cache incompatibility,
but my current approach has been to tell people to delete their old
cache file or run wih -x.  Suggestions are welcome.

-chris
