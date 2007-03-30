From: Theodore Tso <tytso@mit.edu>
Subject: Re: basics... when reading docs doesn't help
Date: Fri, 30 Mar 2007 16:23:12 -0400
Message-ID: <20070330202312.GG3198@thunk.org>
References: <Pine.LNX.4.60.0703292225100.10351@poirot.grange> <20070329211616.GH6143@fieldses.org> <7vabxv3fnx.fsf@assigned-by-dhcp.cox.net> <20070329214654.GI6143@fieldses.org> <Pine.LNX.4.60.0703292354100.10351@poirot.grange> <Pine.LNX.4.64.0703291531030.6730@woody.linux-foundation.org> <Pine.LNX.4.60.0703301855480.4757@poirot.grange> <Pine.LNX.4.64.0703301126390.6730@woody.linux-foundation.org> <Pine.LNX.4.60.0703302135590.10784@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 30 22:23:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXNdE-0000E1-QH
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 22:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbXC3UX3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 16:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753594AbXC3UX3
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 16:23:29 -0400
Received: from thunk.org ([69.25.196.29]:41447 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753587AbXC3UX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 16:23:28 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HXNiz-0006A3-TF; Fri, 30 Mar 2007 16:29:30 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HXNcu-000669-GE; Fri, 30 Mar 2007 16:23:12 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0703302135590.10784@poirot.grange>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2007 at 09:49:20PM +0200, Guennadi Liakhovetski wrote:
> Aha, so, that's how it is then! Why hasn't anybody explained this to me 
> strait away?!:-))))

A lot of this is in the git 1.5's User Manual:

	http://www.kernel.org/pub/software/scm/git/docs/user-manual.html

See also the man page for git-remote, or here:

	http://www.kernel.org/pub/software/scm/git/docs/git-remote.html


> Yeah, hopefully, I'll learn to at least use this thing efficiently enough. 
> Someone has to write a book on it though...

The user-manual and the git tutorials are pretty good --- just make
sure you look at the ones that come with git 1.5.0, or the ones at
http://www.kernel.org/pub/software/svm/git/docs (which reflects the
Documentation as of the latest development version of git).

The problem is that there are some tutorials on the web which assume
git 1.4.x, or cogito, and that has been listed as a defect by people
who have been confused because those tutorials are out of date with
respect to modern git.[1]

[1] http://changelog.complete.org/posts/594-More-on-Git,-Mercurial,-and-Bzr.html

> And, so, it's a pity I cloned Paul's tree yesterday with the "old" git. 
> And from your answer above it seems like some features of the "new" git 
> will not be available with this tree, like equally named local and remote 
> branches, etc. There isn't a way to convert such a "old style" tree to the 
> "new style", is there? Not a big deal, will re-clone at some point, maybe 
> when we get local git mirrors...

Yeah, we need to really make sure the word gets out that new git users
should really make sure they are using git 1.5, and not git 1.4.x; it
is such an improvement in terms of usability over git 1.4.x that there
really is no comparison.  (Of course, guess what Debian is going to
ship in their soon-to-be-release "stable" distribution?  git 1.4.4.  Sigh...)

It is possible to get the new style naming, by using the git remote
command.  Just do

	git remote add origin <url>

...and that will adjust your git configuration file appropriate.
Check out the git 1.5.0 release notes, and the git-config man page,
and there are some other adjustments you can make as well that will
make git more efficiently, at the cost of breaking some level of
compatibility with git 1.4.x tools which replicate via the "dumb" http
protocol.  But for local development repositories that generally isn't
a concern.

						- Ted
