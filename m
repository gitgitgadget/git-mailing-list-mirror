From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff --check: use colour
Date: Fri, 26 Jan 2007 12:19:30 -0500
Message-ID: <20070126171929.GA23324@coredump.intra.peff.net>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vr6tkdnee.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701251015390.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vk5za925w.fsf@assigned-by-dhcp.cox.net> <17849.13327.527531.262943@lisa.zopyra.com> <Pine.LNX.4.63.0701260034320.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17850.8953.478146.754550@lisa.zopyra.com> <17850.10014.251824.979660@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 18:19:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAUjj-0004wM-IZ
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 18:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbXAZRTd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 12:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbXAZRTd
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 12:19:33 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1370 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161048AbXAZRTc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 12:19:32 -0500
Received: (qmail 5481 invoked from network); 26 Jan 2007 12:19:54 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 26 Jan 2007 12:19:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jan 2007 12:19:30 -0500
Content-Disposition: inline
In-Reply-To: <17850.10014.251824.979660@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37875>

On Fri, Jan 26, 2007 at 10:06:54AM -0600, Bill Lear wrote:

> git format-patch -s HEAD^
> [...]
> which looks to be formatted as a mail message:

Right.

The format is:
  - subject line is the first line of your commit message
  - subsequent body lines are the rest of your commit message, until you
    hit the ---
  - below that is the patch; everything in the patch section that is not
    an actual diff hunk is free-form (e.g., the diffstat).

> Do I optionally edit this file, putting my comments before the
> "Signed-off-by" line, and then just send this off to the list with my
> mail command, i.e.:

Comments before the signed-off-by line will be part of the commit
message; so if you have comments to put there, you probably would have
made them when your were committing. If you have comments to send with
the email ("cover letter"), place them after the --- but before the
diffstat.

> % mail git@vger.kernel.org < 0001-Document-check-option-to-git-diff.patch
> 
> ?

I'm not an expert on 'mail' but I'm not sure if it handles headers
correctly (i.e., it expects body text, _not_ the full rfc822 message).
You can use git-send-email, but I find its interface a little clunky.
You can use git-imap-send to place the message in an IMAP mailbox, which
you can then presumably grab as a 'draft' using your regular mail
client. Or you can use a mail client which understands mbox (most unix
ones do), open the file as an mbox, and then resume it as a draft.

Or finally, you can simply edit in the headers you want, remove the
initial 'From ' line, and pipe it to sendmail. :)

What's easiest for you depends on what your mail setup is like (I use
mutt to open the mbox, then "resend" it with editing).

-Peff
