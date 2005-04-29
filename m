From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: More problems...
Date: Fri, 29 Apr 2005 22:19:03 +0100
Message-ID: <20050429221903.F30010@flint.arm.linux.org.uk>
References: <20050429170127.A30010@flint.arm.linux.org.uk> <20050429182708.GB14202@pasky.ji.cz> <20050429195055.GE1233@mythryan2.michonline.com> <Pine.LNX.4.58.0504291311320.18901@ppc970.osdl.org> <7vhdhp47hq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Ryan Anderson <ryan@michonline.com>,
	Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 23:21:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRcux-0005Bf-UW
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 23:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbVD2VZD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 17:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbVD2VWT
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 17:22:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21512 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262991AbVD2VTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 17:19:09 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DRct7-0004zg-Ew; Fri, 29 Apr 2005 22:19:05 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DRct5-00036m-W4; Fri, 29 Apr 2005 22:19:04 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <7vhdhp47hq.fsf@assigned-by-dhcp.cox.net>; from junkio@cox.net on Fri, Apr 29, 2005 at 02:07:29PM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 02:07:29PM -0700, Junio C Hamano wrote:
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

What would be nice is if it finds an existing file for the one it's
trying to hard link, it compares the contents (maybe - is this actually
necessary?) and if identical, it removes the original file replacing
it with a hard link.

This means that you'll always be trying to maintain the hard linked
structure between various working trees in the background.

But maybe this should have an option to enable this behaviour.

-- 
Russell King

