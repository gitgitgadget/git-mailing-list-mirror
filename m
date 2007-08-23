From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 06:20:36 -0400
Message-ID: <20070823102036.GG7267@thunk.org>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz> <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221154150.16727@xanadu.home> <Pine.LNX.4.64.0708221713540.20400@racer.site> <86mywjcwv7.fsf@lola.quinscape.zz> <3f4fd2640708221434i4f5650e0u9adb523742666f40@mail.gmail.com> <Pine.LNX.4.64.0708231006220.20400@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Reece Dunn <msclrhd@googlemail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 23 12:20:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO9nz-0005gi-1Z
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 12:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759043AbXHWKUn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 06:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758526AbXHWKUn
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 06:20:43 -0400
Received: from thunk.org ([69.25.196.29]:42787 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758036AbXHWKUn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 06:20:43 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IO9wg-0008J9-9g; Thu, 23 Aug 2007 06:29:46 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IO9no-0003E8-Mw; Thu, 23 Aug 2007 06:20:36 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708231006220.20400@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56489>

On Thu, Aug 23, 2007 at 10:10:20AM +0100, Johannes Schindelin wrote:
> > > Red herring.  The proposal was not to do nothing, but rather give git
> > > a dedicated scripting language internal to it.
> > 
> > That is a really neat idea.
> 
> Why?  Why should just _having_ a dedicated scripting language _per se_ be 
> a neat idea?  We do not _need_ it!  We script git in bash, perl, other 
> people in Python, Ruby, and even Haskell.  So why should we _take away_ 
> that freedom from others to script Git in whatever language they like 
> most?  There is no good reason.

Users should be able to script in whatever language they want; that's
clear.  However, what some people were talking about was an internal
scripting language that would be used for writing git commands, as an
alternative to an alternative future where everything gets moved to C.
(To accomodate those Windows users who for some silly reason refuse to
install Cygwin, bash, and perl on their Windows development box.  :-)

I mean, even today, if you were to implement some core git porcelein
command in Haskell, and submitted it for inclusion into the mainline
git tree, Junio would I suspect look somewhat skeptically at it.

So for those people who think an internal scripting language would be
a worthwhile way of implementing certain git commands, instead of
converting them all to C, my suggestion would be to "show us the
code".  Actually create the git to LUA bindings, and then show how
easily it would be to rewrite a bunch of the existing git commands
which are currently implemented in shell in LUA instead.  If you can
demonstrate that it could very easily and quickly get rid of all of
the remaining shell scripts and create a version of git that would be
considered a first class Windows port that doesn't require Cygwin, I'm
sure people would spend time looking at the results.

But if people are just gushing over the glories of elisp and saying
things like *someone* should create a scripting language for git, it's
just going to be a waste of everyone's time.

Regards,

						- Ted
