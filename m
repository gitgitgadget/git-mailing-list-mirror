From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Add commands that git-gc runs underneath
Date: Thu, 30 Aug 2007 08:34:32 -0400
Message-ID: <20070830123432.GD10160@thunk.org>
References: <lkbtwek0.fsf@cante.net> <Pine.LNX.4.64.0708301107320.28586@racer.site> <46D6984D.9040802@op5.se> <Pine.LNX.4.64.0708301254420.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Jari Aalto <jari.aalto@cante.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 30 14:34:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQjEX-0002mn-IK
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 14:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155AbXH3Mek (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 08:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756376AbXH3Mek
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 08:34:40 -0400
Received: from THUNK.ORG ([69.25.196.29]:46893 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755670AbXH3Mej (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 08:34:39 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IQjNE-0002aS-OU; Thu, 30 Aug 2007 08:43:48 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IQjEG-0007Si-KQ; Thu, 30 Aug 2007 08:34:32 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708301254420.28586@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57036>

On Thu, Aug 30, 2007 at 12:58:00PM +0100, Johannes Schindelin wrote:
> On Thu, 30 Aug 2007, Andreas Ericsson wrote:
> 
> > I kinda like it [listing the commands git-gc calls], and it might be 
> > helpful if someone's got a large repo and one part of gc for some reason 
> > didn't complete so they want to start at whatever step it broke off on.
> 
> Let me clarify: I do not like the listing in the man page.  This suggests 
> to the user to delve into plumbing areas where it is all too easy to shoot 
> yourself in the foot.

I'm somewhat sympathetic to that argument, but at the same time, we're
still telling users to read the man page for plumbing areas in order
to understand to get the listing valid command-line options to git
commands.  In addition, the main git(1) man page is dedicating talking
about all sorts of low-level on-disk storage details that arguably
should be in the Documentation/technical that you suggested.  I also
don't quite see how commands like git-repack, git-prune,
git-pack-refs, et. al., are likely to get the user into trouble, any
more than git-gc --prune might.  Those commands are all relatively
safe, and indeed, they are all listed in the git-gc's "SEE ALSO"
section of its man page, so users are already being encouraged to
delve into plumbing areas.

That being said, given the SEE ALSO section, I don't think it adds a
huge amount of value to list the exact set of commands and options by
git-gc.  Also, if we add more functionality to git-gc in the future,
it would be pain to have to keep upgrading to man page uptodate.

   	    	    	    	 	      - Ted
