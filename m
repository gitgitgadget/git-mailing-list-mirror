From: Theodore Tso <tytso@mit.edu>
Subject: Re: Any objectsions to enhancing git-log to show tags/branch heads?
Date: Mon, 16 Apr 2007 22:21:54 -0400
Message-ID: <20070417022154.GC30340@thunk.org>
References: <E1HdQah-0008Q2-7E@candygram.thunk.org> <Pine.LNX.4.64.0704161552160.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 04:22:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HddKe-0006l3-VG
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 04:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbXDQCWK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 22:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754292AbXDQCWJ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 22:22:09 -0400
Received: from thunk.org ([69.25.196.29]:48138 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754289AbXDQCWI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 22:22:08 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HddQr-0002RS-II; Mon, 16 Apr 2007 22:28:37 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HddKM-0001Gf-FE; Mon, 16 Apr 2007 22:21:54 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704161552160.5473@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44708>

On Mon, Apr 16, 2007 at 04:00:38PM -0700, Linus Torvalds wrote:
> 	commit 02cfc097c2351a2b6e3a65626ce619f038f73c03 (refs/heads/master)

Nice!  And you did it far more efficiently than I probably would have
done it if I tried to code it.  :-)

The one thing that's a bit unfortunate is that with the commit ID
taking up 40 characters, very often there's not enough space on the
screen to display all of the tags and references (and with the default
less options being hardcoded as "-FRSX", the ones that go beyond the
width of the screen get lost.  

So I tried to use --abbrev, and it didn't shrink the size of the id,
like I thought it would.  It didn't object to the option, but
apparently it ignored it.  Funny, I thought it worked before, but it
wasn't before I applied the patch, so it wasn't your patches that were
at fault.

It would be nice if the --pretty=format had a way of specifying the
decorations, so it would be possible to have a format more like:

Author: Linus Torvalds <torvalds@osdl.org>
Date:   Mon Apr 16 15:49:58 2007 -0700
Head: origin/master
Head: master
Tag: v2.6.20-rc7-ext4-1 (signed)

... but that's something I can work on supplying as a patch, given
that you've written the underlying machinery.

					- Ted
