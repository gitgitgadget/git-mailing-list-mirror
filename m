From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: Some ideas for StGIT
Date: Sat, 4 Aug 2007 10:14:38 -0400
Message-ID: <20070804141438.GA15821@pe.Belkin>
References: <1186163410.26110.55.camel@dv> <200708031914.04344.andyparkins@gmail.com> <1186206085.28481.33.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 16:14:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHKOy-0007uo-U6
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 16:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762299AbXHDOOm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 10:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762182AbXHDOOm
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 10:14:42 -0400
Received: from eastrmmtao105.cox.net ([68.230.240.47]:64860 "EHLO
	eastrmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762144AbXHDOOl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 10:14:41 -0400
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070804141438.YWZB9166.eastrmmtao105.cox.net@eastrmimpo01.cox.net>;
          Sat, 4 Aug 2007 10:14:38 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo01.cox.net with bizsmtp
	id XqEe1X00G0epFYL0000000; Sat, 04 Aug 2007 10:14:38 -0400
Received: from chris by localhost with local (Exim 4.66)
	(envelope-from <c.shoemaker@cox.net>)
	id 1IHKOs-00049l-I8; Sat, 04 Aug 2007 10:14:38 -0400
Content-Disposition: inline
In-Reply-To: <1186206085.28481.33.camel@dv>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54853>

On Sat, Aug 04, 2007 at 01:41:25AM -0400, Pavel Roskin wrote:
> Hello, Andy!
> 
> On Fri, 2007-08-03 at 19:14 +0100, Andy Parkins wrote:
> > On Friday 2007, August 03, Pavel Roskin wrote:
> > 
> > > I don't suggest that StGIT gives up on the git-based storage, but this
> > > mode of operation could be implemented in two ways.
> > 
> > git's shiny new git rebase -i has removed, for me, those times when I needed 
> > stgit.  Perhaps those who've move from git to quilt would try again when 
> > 1.5.3 is out with the magic that is "rebase -i".
> 
> I don't understand how one option can replace StGIT.  I assume you were
> trying to avoid StGIT already, and "git-rebase -i" was just the last
> missing piece.

FWIW, I'm in the same camp.  I'm a huge fan of quilt, and used it
extensively and with large stacks.  (Actually, I still use it whenever
I don't want to bother with importing-to-git a large CVS or SVN
project that I'm tracking.)  When I started using git (and up until
the first time I used git-rebase -i), I assumed I'd eventually have to
use one of the quilt-like add-ons, but I wanted to hold off a little
while until I was comfortable with core-git.

But, after using git-rebase -i, I can't see why I'd need any
quilt-like add-on.  Every time I use git-rebase -i, it's like I'm
editing the patch stack.

> It would be great if you could tell me how your approach would deal with
> the issue of editable patches I mentioned already.  In case I was
> unclear, here's the quote from one of the developers:
> 
> [quote]
> Sometimes, I just make patches in quilt, then I do "quilt 
> refresh", "quilt pop -a", "cd patches" and modify the patches 
> and series file manually, e.g. by moving one patch from one file 
> into the other. 

Well, there are many different ways one might want to modify the
stack, but I find that most of them are quite easy with git-rebase -i.
IMO, here are things that are easier with git-rebase -i than with an
external patch stack:

   - editing the headers (git-rebase makes it easy to find/select the
       patch and even opens the editor for me)
   - reordering patches
   - combining patches (squashing)
   - moving one file's diff from one patch to another

IMO, here are some things that would probably be easier with an external
patch stack:

   - directly editing the diff hunks
   - moving single diff hunks between patches

Maybe there are others, too, but these are things I just don't do
nearly as frequently as the things that git-rebase -i is good at.  (I
use git-rebase -i *constantly*).

> The "cd ..", "quilt push -a" and off I am. That 
> the "database" of quilt is in a known format and I can hack on 
> it with an editor is a plus for me :-)
> [end of quote]

That sounds more like an argument from familiarity than anything else.
Nobody (reasonable) directly hacks git's internal binary format.  The
"known format" I can hack with my editor is just the content itself.
Honestly, when you have commit-handling that is as good as git's,
there's really very little appeal left to editing the diffs directly.

-chris
