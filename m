From: Jeff King <peff@peff.net>
Subject: Re: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Tue, 15 Feb 2011 22:46:06 -0500
Message-ID: <20110216034606.GA2414@sigill.intra.peff.net>
References: <20110212070538.GA2459@sigill.intra.peff.net>
 <20110213123151.GA31375@book.hvoigt.net>
 <20110215063903.GA28634@sigill.intra.peff.net>
 <20110215191620.GA56397@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@googlemail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 04:46:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpYLJ-000141-5j
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 04:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954Ab1BPDqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 22:46:10 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56539 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754866Ab1BPDqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 22:46:09 -0500
Received: (qmail 3306 invoked by uid 111); 16 Feb 2011 03:46:08 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 16 Feb 2011 03:46:08 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Feb 2011 22:46:06 -0500
Content-Disposition: inline
In-Reply-To: <20110215191620.GA56397@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166922>

On Tue, Feb 15, 2011 at 08:16:21PM +0100, Heiko Voigt wrote:

> > It seems a little heavy-handed to have a dialog pop up for each commit.
> > It's not actually dangerous to create a commit on a detached HEAD; it's
> > just dangerous to _leave_ without referencing your new commits.
> 
> Hmm, how about adding a checkbox:
> 
>   [ ] Do not ask again
> 
> In my experience anything other than a popup will be overseen so I would
> suggest doing it at least once to prepare the user for the possible
> consequences.

Yeah, that's much better IMHO because at least clueful people can
dismiss it after the first time.

> IMO such a message is a good thing for the GUI regardless whether we
> implement the leaving detached HEAD state warning. First I think a
> typical GUI user does not commit on a detached head that often since
> there is currently no way to use these commits from the GUI (e.g.
> format-patch, rebase, ...).

Fair enough. I really have no idea what sorts of things gui users do, or
how they perceive the system.

> Second because a detached head is very practical for testing work on a
> remote branch the message box would remind most users to switch to
> their development branch first. If they only get that message after a
> series of commits it might become a hassle for them to get these
> commits onto another branch (remember no format-patch or rebase
> currently).

Good point.

> > I do think a pop-up is appropriate when you try to check something else
> > out, and commits you have made on the detached HEAD are about to become
> > unreferenced. But this is something even the CLI doesn't do, so it would
> > make sense to see how the check is implemented there first before doing
> > anything in git-gui.
> 
> From what I read in this thread it currently seems to be not so easy to
> precisely find out whether some commit is referenced. (If we care about
> stuff outside of remotes, heads and tags). But maybe we do not need
> that for the GUI.

Yeah, I think there is still some question about how it should happen,
and any check in the gui should probably be the same as in the cli.  But
from the rest of what you say, that shouldn't impact whether a
per-commit warning is worth doing.

-Peff
