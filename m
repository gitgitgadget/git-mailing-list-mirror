From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: CR codes from git commands
Date: Thu, 22 Jan 2009 02:46:57 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901220238380.19665@iabervon.org>
References: <18805.64312.289059.660023@hungover.brentg.com>  <alpine.LNX.1.00.0901212319310.19665@iabervon.org> <e38bce640901212334v1e672d48t81d5c81fecd929eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 08:48:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPuIc-00028H-QP
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 08:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972AbZAVHrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 02:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754882AbZAVHrB
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 02:47:01 -0500
Received: from iabervon.org ([66.92.72.58]:57025 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150AbZAVHrA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 02:47:00 -0500
Received: (qmail 7840 invoked by uid 1000); 22 Jan 2009 07:46:57 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jan 2009 07:46:57 -0000
In-Reply-To: <e38bce640901212334v1e672d48t81d5c81fecd929eb@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106732>

On Wed, 21 Jan 2009, Brent Goodrick wrote:

> On Wed, Jan 21, 2009 at 8:47 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > It's kind of unclear what you're trying to do here. I'm guessing that
> > you're trying to run git with stdio directed to a /dev/tty device, where
> > isatty() is true, but which doesn't interpret ASCII control characters as
> > such. We're not detecting that you can't use a pager on this, and so you
> > have to use PAGER=cat (which might not be a bad idea for things like
> > "man", either). With some clues about the environment, we should be able
> > to do something about this.
> >
> > You're also trying to send the progress output to a log file that you can
> > look at the end of (presumably in a more capable terminal). It should be
> > possible (with an option) to get git to output progress info to a non-tty,
> > and not use the CRs if the output isn't a tty.
> >
> > Or do you want to use a tty that can't handle CRs, and get newlines
> > instead of CRs? (If I'd git on the first computer I used, it would have
> > printed the progress bar over and over in place and probably torn a hole
> > in the paper, but I haven't used that one in over 20 years.)
> 
> Hi Daniel,
> 
> Ideally, yes I would want no CR's but LF's instead (but others who do
> not use my environment may actually like the way it is now, and I seek
> not to disturb that use case).  I could live without the progress
> lines (lines that print repeatedly over in one place on normal
> terminals), but adding " 2>&1 | cat" to every command line just to get
> the CR's to go away, is non-workable for me.
> 
> The environment I'm running git under is the Shell mode inside GNU
> Emacs. I can't tell you what type of terminal it is, because I believe
> that is defined deep in the guts of Emacs. Having read your reply
> above, I'm now wondering whether this is an Emacs issue versus a git
> issue. If it is an Emacs issue, then I am truly embarrassed for having
> wasted everyones time with it.

The terminal type, at least in my version of Emacs, is "dumb", which ought 
to be sufficient to tell git that a pager isn't going to be useful is most 
cases (might be worthwhile to keep "git log" from eating all your memory, 
though), and that using CR to rewrite lines isn't going to work.

	-Daniel
*This .sig left intentionally blank*
