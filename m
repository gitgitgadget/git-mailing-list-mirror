From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: More problems...
Date: Fri, 29 Apr 2005 17:27:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504291717360.30848-100000@iabervon.org>
References: <7vhdhp47hq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Ryan Anderson <ryan@michonline.com>,
	Petr Baudis <pasky@ucw.cz>,
	Russell King <rmk@arm.linux.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 23:41:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRdEK-0007FA-WE
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 23:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbVD2VqB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 17:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbVD2VoF
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 17:44:05 -0400
Received: from iabervon.org ([66.92.72.58]:57094 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S263009AbVD2V3p (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 17:29:45 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DRd1h-0006AZ-00; Fri, 29 Apr 2005 17:27:57 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdhp47hq.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 29 Apr 2005, Junio C Hamano wrote:

> >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
> 
> LT> Absolutely. I use the same "git-pull-script" between two local directories 
> LT> on disk...
> LT> Of course, I don't bother with the linking. But that's the trivial part.
> 
> Would it be useful if somebody wrote local-pull.c similar to
> http-pull.c, which clones one local SHA_FILE_DIRECTORY to
> another, with an option to (1) try hardlink and if it fails
> fail; (2) try hardlink and if it fails try symlink and if it
> fails fail; (3) try hardlink and if it fails try copy and if it
> fails fail?

If someone does this, they should make a pull.c out of http-pull and
rpull; the logic for determining what you need to copy, given what you
have and what the user wants to have, should be shared.

(Note that some usage patterns only require the latest commit, or at least
can deal with fetching other stuff only when needed.)

	-Daniel
*This .sig left intentionally blank*

