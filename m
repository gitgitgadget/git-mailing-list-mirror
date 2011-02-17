From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Thu, 17 Feb 2011 18:27:21 +0100
Message-ID: <20110217172720.GA91738@book.hvoigt.net>
References: <20110212070538.GA2459@sigill.intra.peff.net> <20110213123151.GA31375@book.hvoigt.net> <20110215063903.GA28634@sigill.intra.peff.net> <20110215191620.GA56397@book.hvoigt.net> <20110216034606.GA2414@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@googlemail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 17 18:27:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq7dY-0002zN-8S
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 18:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757219Ab1BQR1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 12:27:23 -0500
Received: from darksea.de ([83.133.111.250]:55800 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754325Ab1BQR1W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 12:27:22 -0500
Received: (qmail 28025 invoked from network); 17 Feb 2011 18:27:20 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 17 Feb 2011 18:27:20 +0100
Content-Disposition: inline
In-Reply-To: <20110216034606.GA2414@sigill.intra.peff.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167095>

Hi,

On Tue, Feb 15, 2011 at 10:46:06PM -0500, Jeff King wrote:
> On Tue, Feb 15, 2011 at 08:16:21PM +0100, Heiko Voigt wrote:
> 
> > > It seems a little heavy-handed to have a dialog pop up for each commit.
> > > It's not actually dangerous to create a commit on a detached HEAD; it's
> > > just dangerous to _leave_ without referencing your new commits.
> > 
> > Hmm, how about adding a checkbox:
> > 
> >   [ ] Do not ask again
> > 
> > In my experience anything other than a popup will be overseen so I would
> > suggest doing it at least once to prepare the user for the possible
> > consequences.
> 
> Yeah, that's much better IMHO because at least clueful people can
> dismiss it after the first time.

I tried to implement such a dialog yesterday. Unfortunately my tcl/tk
fu seems not sufficient enough. I managed to create the dialog but did
not get the results which button was clicked. It has something to do
with the scope of variables in tcl. Pat you would probably be able to
fix this. I can send you the code if you are interested?

> > > I do think a pop-up is appropriate when you try to check something else
> > > out, and commits you have made on the detached HEAD are about to become
> > > unreferenced. But this is something even the CLI doesn't do, so it would
> > > make sense to see how the check is implemented there first before doing
> > > anything in git-gui.
> > 
> > From what I read in this thread it currently seems to be not so easy to
> > precisely find out whether some commit is referenced. (If we care about
> > stuff outside of remotes, heads and tags). But maybe we do not need
> > that for the GUI.
> 
> Yeah, I think there is still some question about how it should happen,
> and any check in the gui should probably be the same as in the cli.  But
> from the rest of what you say, that shouldn't impact whether a
> per-commit warning is worth doing.

Will someone be working on this? Otherwise: Implementing the previously
suggested solution is quite straightforward for git-gui. I could
implement that check in git-gui first and once the CLI has some
mechanism for this check we could switch to that.

Cheers Heiko
