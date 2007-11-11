From: Theodore Tso <tytso@mit.edu>
Subject: Re: Deprecate git-fetch-pack?
Date: Sun, 11 Nov 2007 18:58:19 -0500
Message-ID: <20071111235819.GB7392@thunk.org>
References: <Pine.LNX.4.64.0711101752490.29952@iabervon.org> <7v4pftip42.fsf@gitster.siamese.dyndns.org> <74415967-7F49-426C-8BF5-1A0210C337AB@develooper.com> <Pine.LNX.4.64.0711111103240.4362@racer.site> <7vd4ugcwkm.fsf@gitster.siamese.dyndns.org> <20071111222117.GA7392@thunk.org> <7vabpkbebj.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711112247350.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ask =?iso-8859-1?Q?Bj=F8rn?= Hansen <ask@develooper.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 01:01:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrMk2-0000c9-QA
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 01:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799AbXKLABB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 19:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755804AbXKLABB
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 19:01:01 -0500
Received: from thunk.org ([69.25.196.29]:56221 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755796AbXKLABA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 19:01:00 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IrMrS-0002WN-D9; Sun, 11 Nov 2007 19:11:30 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1IrMh2-0002P6-2Q; Sun, 11 Nov 2007 18:58:20 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711112247350.4362@racer.site>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64537>

On Sun, Nov 11, 2007 at 10:50:26PM +0000, Johannes Schindelin wrote:
> I beg to differ.  The biggest problem with a new user seeing all those 
> completions is that this user is scared.

Well, if we introduce the new user only to "git subcomand", and the
documentation is relatively gentle, I would suspect would solve most
of the problem.  Note BTW, that if your thesis is true, "git help -a"
(which is recommended in the last line of output by "git help") should
cause the typical new user to faint dead away.  :-)

Some other areas that would be worth fixing, in terms of user usability.

1) The references to the tutorial, everyday git, etc., don't actually
have working references in the git man page.  (i.e., what you see when
you run the command "man git").   It would be nice if that were fixed.

2) The command which are displayed by "git help" should use some
serious rethinking.  Ideally, it would be nice if the output fit in a
single 24-line terminal window.   Some candidates for removal:

       a) prune: "git prune" definitely doesn't deserve to be on the
       front and center as displayed by "git help".  Maybe replace it
       with "gc", but now that we have gc.auto, I'm not sure it's
       worth it at all.

       b) revert:  Is that really that common of a command?

       c) show-branch: The output is terrifying without explanation

There are other commands I'm not so sure about, but it is worth
flagging them.  One way that might be helpful is to group the commands
into subcommands, much like gdb does, so you could do something like
"git help other-repos" (where all commands that involve interacting
with other repositories are summarized), and so on.

> But yes, I was only proposing to deprecate all usage of git-<bla> in the 
> documentation.

I agree that de-emphasizing git-<blah> isn't a bad thing.  But I think
we need to look at the big picture here, since "git help" is often one
of the first things a new user might try (and obviously very few git
developers look at it, or "prune" probably would have been removed
from git help a long time ago :-), and the last thing that git help
suggests (and so therefore it will very visible to the newbie user),
is "git help -a" --- and that displays every single git command under
creation, porcelain or plumbing, in one gigantic sorted list.  

Oops, so much for first impressions.  :-)

	   	    	     	   		 - Ted
