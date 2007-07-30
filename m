From: Craig Boston <craig@olyun.gank.org>
Subject: Re: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 14:29:23 -0500
Message-ID: <20070730192922.GB64467@nowhere>
References: <20070730180710.GA64467@nowhere> <alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 21:29:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFavo-0002io-Ue
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 21:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761380AbXG3T3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 15:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755930AbXG3T3Z
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 15:29:25 -0400
Received: from ion.gank.org ([69.55.238.164]:2241 "EHLO ion.gank.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758448AbXG3T3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 15:29:24 -0400
Received: by ion.gank.org (Postfix, from userid 1001)
	id 47E8911253; Mon, 30 Jul 2007 14:29:23 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54253>

On Mon, Jul 30, 2007 at 11:56:56AM -0700, Linus Torvalds wrote:
> It should literally be as easy as doing something like
> 
> 	cd /path/to/cvs/checkout_X
> 	export GIT_DIR=/path/to/git/repo
> 	git add .
> 	git commit -m"Import yyyymmdd snapshot"

Aha!  I didn't know that you could point to a repository with GIT_DIR
and do useful operations without a working directory.  My "master" repo
that gets backed up and cloned everywhere is a bare repo anyway; I had
been cloning it with -s and then using 'git push' to get changes back
into it.

A couple questions on that:

1. Will it notice deleted files?
2. How can I tell it what branch to commit to?

> You'd have to make sure that you have the CVS directories ignored, of 
> course, and if you don't want to change the CVS directory at all (which is 
> a good idea!) you'd need to do that by using the "ignore" file in your 
> GIT_DIR, and just having the CVS entry there, instead of adding a
> ".gitignore" file to the working tree and checking it in.

Not a problem, I'm using cvsup in checkout mode so there are no CVS
dirs.  The checkout directory is an exact snapshot of "What The
Repository Should Look Like."

> The above is totally untested, of course, but I think that's the easiest 
> way to do things like this. In general, it should be *trivial* to do 
> snapshots with git using just about _any_ legacy SCM, exactly because you 
> can keep the whole git setup away from the legacy SCM directories with 
> that "GIT_DIR=.." thing. 

I'll make a backup of my repo and give it a try.

Thanks!

Craig
