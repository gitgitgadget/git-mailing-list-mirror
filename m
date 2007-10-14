From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sun, 14 Oct 2007 14:40:50 -0400
Message-ID: <20071014184050.GB31260@fieldses.org>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com> <Pine.LNX.4.64.0710130130380.25221@racer.site> <853awepyz6.fsf@lola.goethe.zz> <20071013202713.GA2467@fieldses.org> <Pine.LNX.4.64.0710140135020.25221@racer.site> <alpine.LFD.0.999.0710131810550.6887@woody.linux-foundation.org> <20071014014445.GN27899@spearce.org> <3f4fd2640710140320h5c1e1f7gf9f43a626aaa6897@mail.gmail.com> <47125BF7.2070503@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Reece Dunn <msclrhd@googlemail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 20:41:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih8Ok-00062V-Sq
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 20:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763973AbXJNSlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 14:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763968AbXJNSlA
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 14:41:00 -0400
Received: from mail.fieldses.org ([66.93.2.214]:43362 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763961AbXJNSk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 14:40:58 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1Ih8OQ-0002jD-LG; Sun, 14 Oct 2007 14:40:50 -0400
Content-Disposition: inline
In-Reply-To: <47125BF7.2070503@midwinter.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60892>

On Sun, Oct 14, 2007 at 11:12:07AM -0700, Steven Grimm wrote:
> But that's just an aspect of a more general fact: it's hard to use git 
> without getting exposed to the plumbing at least a little. Another example 
> is the manpages: try to look up the commonly-used options to "git diff" 
> (porcelain) and you will be forced to learn about "git rev-parse" 
> (plumbing).

As "plumbing" goes, "git rev-parse" isn't that bad, and the reference
here (to the "SPECIFYING REVISIONS" section) strikes me as reasonable.
We could factor out the common documentation into a separate (hopefully
more user-friendly) manpage about specifying revisions, I guess, and
refer to it everywhere instead of git-rev-parse.  I don't know--any
other ideas?

> It's possible git's introductory documentation should delay talking 
> about "git branch" until later, and start off talking about how to work 
> with one (checked out) branch per repo.

One frequent use case is the case of a tester that wants to try out a
bugfix in some topic branch.  You want to tell them: "please test the
fix-that-bug branch in git://myproject.org/~me/repo.git".  They need to
get that checked out somehow.  And they should be able to do it without
re-cloning every time.

That's one motivation, among others, for including git-branch (and
git-remote) very early.

Though actually the quickest way to checkout an arbitrary revision is
with detached heads, and that doesn't require learning git-branch right
away.  I've tried rewriting the user-manual start that way but wasn't
happy with the result and didn't get too far.  (See
git://linux-nfs.org/~bfields/git.git docwork-detached.)

> Update to a dirty working copy. I think there's a tendency in these parts 
> to vastly underestimate the importance of being able to pull down updates 
> from a master repository while you're in the middle of development. 
> Mercurial's equivalent to bare "git pull", namely "hg pull" followed by "hg 
> update", works fine if you have edits in your working copy; if there are 
> conflicting changes, it pops you into a conflict resolution UI (or adds 
> conflict markers, depending on your settings) and you continue on your 
> merry way after resolving everything. This workflow is really common, 
> especially in corporate settings where there's very fine-grained 
> collaboration going on during initial development (a huge difference from 
> the open-source world where most of the time it's just one person doing an 
> initial prototype.) Right now working this way is a pain in git. Less so 
> now that we have "git stash", but it could still be much, much smoother.

I'm lost--how is "hg pull" different from "git pull" in this respect?

> Verbosity. IMO Mercurial swings too far in this direction, but in general 
> it's either completely silent or very terse in its output.

Yes, there's a lot of low-hanging fruit here for someone that's
interested in streamlining the default git command output.  The
challenge is to get it a little terser while still being helpful (and
preserving progress meters, and not obscuring what's going on any more
than necessary).

--b.
