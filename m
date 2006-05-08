From: Theodore Tso <tytso@mit.edu>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Sun, 7 May 2006 22:24:32 -0400
Message-ID: <20060508022432.GA26076@thunk.org>
References: <e3fqb9$hed$1@sea.gmane.org> <Pine.LNX.4.64.0605050848230.3622@g5.osdl.org> <46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com> <7vbqubvdbr.fsf@assigned-by-dhcp.cox.net> <46a038f90605062308x53995076k7bf45f0aebcae0c6@mail.gmail.com> <20060507075631.GA24423@coredump.intra.peff.net> <20060508003338.GB17138@thunk.org> <Pine.LNX.4.64.0605071744210.3718@g5.osdl.org> <20060508012632.GD17138@thunk.org> <Pine.LNX.4.64.0605071853290.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 04:24:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcvQa-0004dW-1x
	for gcvg-git@gmane.org; Mon, 08 May 2006 04:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWEHCYg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 22:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWEHCYg
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 22:24:36 -0400
Received: from thunk.org ([69.25.196.29]:42462 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932253AbWEHCYf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 22:24:35 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1FcvQI-0007to-Ii; Sun, 07 May 2006 22:24:34 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.60)
	(envelope-from <tytso@thunk.org>)
	id 1FcvQG-0006oU-Hj; Sun, 07 May 2006 22:24:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605071853290.3718@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19750>

On Sun, May 07, 2006 at 07:04:48PM -0700, Linus Torvalds wrote:
> Is that without compression?

Yes, without compression.  So yes, that probably explains the
difference between your numbers and mine. 

That brings up an interesting question though --- why not skip
compressing files that are under 4k (or whatever the filesystem
blocksize happens to be) if they are unpacked?  It burns CPU time;
maybe not enough to be human-noticeable, but it's still not buying you
anything.

						- Ted
