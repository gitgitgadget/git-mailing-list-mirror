From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk patch collection pull request
Date: Tue, 23 Oct 2007 10:20:47 +1000
Message-ID: <18205.15967.792413.775786@cargo.ozlabs.ibm.com>
References: <20071019052823.GI14735@spearce.org>
	<alpine.LFD.0.999.0710191227340.26902@woody.linux-foundation.org>
	<18201.34779.27836.531742@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710192149020.3794@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 02:21:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik7WF-0007Lk-Nh
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 02:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbXJWAVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 20:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbXJWAVD
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 20:21:03 -0400
Received: from ozlabs.org ([203.10.76.45]:41630 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbXJWAVB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 20:21:01 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 41626DDE33; Tue, 23 Oct 2007 10:21:00 +1000 (EST)
In-Reply-To: <alpine.LFD.0.999.0710192149020.3794@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62063>

Linus Torvalds writes:

> On Sat, 20 Oct 2007, Paul Mackerras wrote:
> > 
> > Do you mean that when you have a file limit, the diff window should
> > just show the diffs for those files, not any other files the commit
> > might have modified?
> 
> Yes. The same way "git log -p" works by default.
> 
> With perhaps a checkbox to toggle the "--full-diff" behaviour.

OK, done.  The checkbox is in the Edit/Preferences window.  It's
called "Limit diffs to listed paths" and it's on by default.

> > That would be easy enough to implement in gitk.
> 
> Well, the "--merged" case is slightly trickier, since git will figure out 
> the pathnames on its own (it limits pathnames to the intersection of the 
> names you give one the command line *and* the list of unmerged files, ie 
> the "filter" becomes "git ls-files -u [pathspec]".

If you use the --merge flag, gitk will do a git ls-files -u at
startup, and use the result as the list of paths (after intersecting
it with the paths on the command line, if you specify paths there).

I pondered whether I needed to re-do the git ls-files -u when you
update the view with File->Update.  I decided not to for now, but it
would be possible to add it.

> But goodie. I look forward to it ;)

I just pushed it out to my gitk.git repo (master branch).  Enjoy. :)

Paul.
