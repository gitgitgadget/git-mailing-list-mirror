From: Theodore Tso <tytso@mit.edu>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 13:56:52 -0500
Message-ID: <20070210185652.GG25607@thunk.org>
References: <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de> <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com> <Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0702101049480.1757@xanadu.home> <7vr6syj7uw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702101131070.1757@xanadu.home> <7vmz3mj6yo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702101154130.1757@xanadu.home> <7v1wkxki4a.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702101351430.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Feb 10 19:57:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFxPC-0001Km-HZ
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 19:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbXBJS47 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 13:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbXBJS47
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 13:56:59 -0500
Received: from THUNK.ORG ([69.25.196.29]:35799 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789AbXBJS47 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 13:56:59 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HFxUB-0002ni-Ti; Sat, 10 Feb 2007 14:02:12 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HFxP2-000168-67; Sat, 10 Feb 2007 13:56:52 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702101351430.1757@xanadu.home>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39254>

On Sat, Feb 10, 2007 at 01:53:44PM -0500, Nicolas Pitre wrote:
> On Sat, 10 Feb 2007, Junio C Hamano wrote:
> 
> >  (0) Do nothing.
> > 
> >  (1) We keep the current "git-status [-v] [-a] [[-i|-o] <paths...>]"
> >      command line and do the necessary index manipulation
> >      in-core without writing it out (see git-commit.sh for
> >      details of what it involves).  
> > 
> >  (2) We drop the support for any command line parameter from
> >      "git-status", apply my two patches for Marco to
> >      "git-runstatus", and rename "git-runstatus" to
> >      "git-status".
> > 
> > If I have to pick between the two, I would probably pick (2).
> > While (1) would essentially mean doing "git-commit" entirely
> > in-core without writing the index out until we really make the
> > commit, which is a good thing in itself in the longer term, it
> > is out of the question this late in the game for 1.5.0.
> 
> And don't get me wrong.  I think that for 1.5.0 you should really do (0).

Well, if we're going to change the semantics of git-status, we would
have to do it in 1.5.0 or wait until 1.6.0, wouldn't we?

							- Ted
