From: Theodore Tso <tytso@mit.edu>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Sun, 7 May 2006 20:33:38 -0400
Message-ID: <20060508003338.GB17138@thunk.org>
References: <7v4q065hq0.fsf@assigned-by-dhcp.cox.net> <87mzdx7mh9.wl%cworth@cworth.org> <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605050806370.3622@g5.osdl.org> <e3fqb9$hed$1@sea.gmane.org> <Pine.LNX.4.64.0605050848230.3622@g5.osdl.org> <46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com> <7vbqubvdbr.fsf@assigned-by-dhcp.cox.net> <46a038f90605062308x53995076k7bf45f0aebcae0c6@mail.gmail.com> <20060507075631.GA24423@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 08 02:33:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcthC-0002vU-BX
	for gcvg-git@gmane.org; Mon, 08 May 2006 02:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWEHAdw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 20:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWEHAdv
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 20:33:51 -0400
Received: from thunk.org ([69.25.196.29]:58333 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751249AbWEHAdt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 20:33:49 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Fcth6-0007a0-SX; Sun, 07 May 2006 20:33:49 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.60)
	(envelope-from <tytso@thunk.org>)
	id 1Fctgw-0005Eg-Ia; Sun, 07 May 2006 20:33:38 -0400
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060507075631.GA24423@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19730>

On Sun, May 07, 2006 at 03:56:31AM -0400, Jeff King wrote:
> On Sun, May 07, 2006 at 06:08:03PM +1200, Martin Langhoff wrote:
> 
> > >> And in any case commits and trees are lightweight and compress well...
> > >Commit maybe, but is this based on a hard fact?
> > No hard facts here :( but I think it's reasonable to assume that the
> > trees delta/compress reasonably well, as a given commit will change
> > just a few entries in each tree.
> 
> A few hard facts (using Linus' linux-2.6 tree):
>   - original packsize: 120996 kilobytes
>   - unpacked: 233338 objects, 1417476 kilobytes
>     This is an 11.7:1 compression ratio (of course, much of this is
>     wasted space from the 4k block size in the filesystem)

If there are 233338 objects, then the average wasted space due to
internal fragmentation is 233338 * 2k, or 466676 kilobytes, or only
36% of the wasted space.  Most of the savings is probably coming from
the compression and delta packing.

						- Ted
