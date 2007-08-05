From: Theodore Tso <tytso@mit.edu>
Subject: Re: Terminology question about remote branches.
Date: Sun, 5 Aug 2007 11:48:01 -0400
Message-ID: <20070805154801.GD28263@thunk.org>
References: <854pjfin68.fsf@lola.goethe.zz> <20070804092933.aaec6d52.seanlkml@sympatico.ca> <85ejijgzzg.fsf@lola.goethe.zz> <20070805100532.GG12507@coredump.intra.peff.net> <85172807-B7EB-47DD-813E-FAF5894E1190@zib.de> <20070805110200.GA18083@coredump.intra.peff.net> <85tzre8b4w.fsf@lola.goethe.zz> <20070805115208.GA19734@coredump.intra.peff.net> <85fy2y89kb.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 17:48:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHiL1-00024j-Lq
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 17:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbXHEPsM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 11:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753930AbXHEPsM
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 11:48:12 -0400
Received: from thunk.org ([69.25.196.29]:35382 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146AbXHEPsL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 11:48:11 -0400
Received: from root (helo=tinytim.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IHiTO-0006Bj-EE; Sun, 05 Aug 2007 11:56:54 -0400
Received: from tytso by tinytim.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IHiKn-0004eF-CF; Sun, 05 Aug 2007 11:48:01 -0400
Content-Disposition: inline
In-Reply-To: <85fy2y89kb.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55035>

On Sun, Aug 05, 2007 at 02:12:04PM +0200, David Kastrup wrote:
> Well, that is pretty much exactly what I find fascinating: that the
> behavior is arbitrary and undocumented enough that one can't deduce it
> either by logic or by recollection or by documentation, but just by
> reading the code.

The behavior of how references work and how the config file parameters
under remote.* and branch.* are pretty well understood, and the
conceptual model is pretty simple; see Jeff's message.  And most of it
*is* documented if you look at the git-fetch, git-pull, git-config man
pages --- just not systematically in one place.

What's not so well understood I suspect by most people is how the "git
branch" tool edits the config file.  It was added later, and many of
the git hackers who already know the conceptual model and who are used
to editing .git/config directly to get what they want, don't use git
branch much themselves; that's really for more novice users and more
simpler config files.

To use a GNU emacs example, consider M-x customize, which is this
huge, very fancy, *very* complex hierarchical mechanism with a
pointy-clicky interface for setting options.  Most emacs experts
wouldn't use it, preferring to open code raw emacs-lisp settings in
their .emacs.el.  If you ask an old-time emacs user how to set up some
specific feature setting via M-x customize, they might look at you
blankly, because it's not an interface they use much, if at all.

A similar thing can be said of "git branch"; once you are familiar
with how git works at a conceptual level, it can often be
faster/easier to just hack the .git/config file directly, instead of
using "git branch" to set up things the way you want.  And I'm pretty
sure there are ways to set up the config file when you edit it by hand
that you can't set up via "git branch".

						- Ted
