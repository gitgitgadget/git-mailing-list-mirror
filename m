From: Theodore Tso <tytso@mit.edu>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 21:39:58 -0500
Message-ID: <20070128023958.GF9897@thunk.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <20070127201640.GA25637@coredump.intra.peff.net> <Pine.LNX.4.64.0701271432450.25027@woody.linux-foundation.org> <20070127235238.GA28706@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 28 03:40:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAzxp-0002s6-33
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 03:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbXA1CkK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 21:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbXA1CkK
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 21:40:10 -0500
Received: from THUNK.ORG ([69.25.196.29]:38169 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932337AbXA1CkI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 21:40:08 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HB02V-0003ui-D2; Sat, 27 Jan 2007 21:45:08 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HAzxW-0008Ul-LF; Sat, 27 Jan 2007 21:39:58 -0500
Content-Disposition: inline
In-Reply-To: <20070127235238.GA28706@coredump.intra.peff.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38012>

On Sat, Jan 27, 2007 at 06:52:38PM -0500, Jeff King wrote:
> But it's still pretty ugly. I'm not inclined to hack on it much more --
> IMHO, a nice curses interface like tig would be much more sensible.

For emacs users, it would even be better to tie it into emacs.  That
way you're already at the line number looking at the source code when
you start wondering, "who the f*ck created this mess?".  The way I'd
design it would to have emacs split the window vertically, and place
the blame information in a buffer whose scrolling was synchronized
with the main window.  

One of the things that I noticed myself doing (and I'm guessing many
other people would do it as well), is that you have a tendency to wait
until the attribution information has started filling in before you
start scrolling to the part of the code you were interested in --- and
since the beginning of the fle often hasn't changed much until the
earliest beginnings of the project, that can be quite a while.  And of
course, scrolling to the right part of the file is a pain.  So
building it into the editor is not only convenient, but it avoids the
psychological effects that could make it seem slow because how long it
takes to fill the attribution for these first bits:

/*
 * Copyright (C) 1991, 1992 Linus Torvalds
 * Copyright (C) 1994,      Karl Keyte: Added support for disk statistics
 * Elevator latency, (C) 2000  Andrea Arcangeli <andrea@suse.de> SuSE
 * Queue request tables / lock, selectable elevator, Jens Axboe <axboe@suse.de>
 * kernel-doc documentation started by NeilBrown <neilb@cse.unsw.edu.au> -  July2000
 * bio rewrite, highmem i/o, etc, Jens Axboe <axboe@suse.de> - may 2001
 */


Anyway, this should be relatively easily for emacs, and for eclipse
(although I don't think anyone is using eclipse to do Kernel hacking,
is there?).  I have no idea how you would hack this into Vim, other
than passing the line number into the GUI so it can open right into
the function that the developer was looking at.

						- Ted
