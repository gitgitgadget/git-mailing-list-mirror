From: Jeff King <peff@peff.net>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 15:19:49 -0400
Message-ID: <20061021191949.GA8096@coredump.intra.peff.net>
References: <45357CC3.4040507@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org> <20061021130111.GL75501@over-yonder.net> <200610211608.18895.jnareb@gmail.com> <20061021181149.GM75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 21:19:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbMNv-0003NZ-DW
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 21:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422833AbWJUTTw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 15:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422686AbWJUTTw
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 15:19:52 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:25069 "HELO
	peff.net") by vger.kernel.org with SMTP id S1422833AbWJUTTv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 15:19:51 -0400
Received: (qmail 31072 invoked from network); 21 Oct 2006 15:19:50 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 21 Oct 2006 15:19:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Oct 2006 15:19:49 -0400
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
Content-Disposition: inline
In-Reply-To: <20061021181149.GM75501@over-yonder.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29661>

On Sat, Oct 21, 2006 at 01:11:49PM -0500, Matthew D. Fuller wrote:

> Maybe that's what you mean by 'centralization'; each branch is central
> to itself.  That seems a pretty useless definition, though.  In my
> mind, actually, it's MORE distributed; my branch remains my branch,
> and your branch remains your branch, and the difference doesn't keep
> us from working together and moving changes back and forth.  Forcing
> my branch to become your branch sounds a lot more "centralized" to me.
> 
> Now, we can discuss THAT distinction.  I'm not _opposed_ to git's

OK, let's discuss. :)

I think the concept of "my" branch doesn't make any sense in git.
Everyone is working collectively on a DAG of the history, and we all
have pointers into the DAG. Something is "my" branch in the sense that I
have a repository with a pointer into the DAG, but then again, so do N
other people. I control my pointer, but that's it.

So don't think of it as "git throws away branch identity" as much as
"git never cared about branch identity in the first place, and doesn't
think it's relevant."

Now, there are presumably advantages and disadvantages to these
approaches. I like the fact that I can prepare a repository from
scratch, import it from cvs, copy it, push it, or do whatever I like,
and the end result is always exactly the same (revids included). With
your model, on the other hand, it seems the advantages are that in many
cases you can do things like distributed revnos.

> agree on branch identity, it's completely pointless to keep yakking
> about revnos, because they're a direct CONSEQUENCE of that difference
> in mental model.  See?  They're an EFFECT, not a CAUSE.  If bzr didn't
> have revnos, I'd STILL want my branch to keep its identity.  You could
> name the mainline revisions after COLORS if you wanted, and I'd still
> want my branch to keep its identity.  Aren't we through rehashing the
> same discussion about the EFFECTS?

I agree completely.

> > 2. But the preferred git workflow is to have two branches in each of
> > two clones. The 'origin' branch where you fetch changes from other
> > repository (so called "tracking branch") and you don't commit your
> > changes to [...]
> 
> Funny, since this reads to me EXACTLY like the bzr flow of "upstream
> branch I pull" and "my branch I merge from upstream" that's getting
> kvetched around...

The difference, I think, is that it's easier in git to move the upstream
around: you simply start fetching from a different place. I'm not clear
on how that works in bzr (if it invalidates revnos or has other side
effects).

-Peff
