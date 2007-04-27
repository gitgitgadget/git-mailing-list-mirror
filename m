From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Add support for grep searches
Date: Fri, 27 Apr 2007 06:21:11 +0200
Message-ID: <20070427042111.GV4489@pasky.or.cz>
References: <20070427034138.1646.15989.stgit@rover> <20070427034729.GU4489@pasky.or.cz> <alpine.LFD.0.98.0704262055270.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 27 06:21:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhHxf-0000iO-OC
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 06:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274AbXD0EVO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 00:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755282AbXD0EVO
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 00:21:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48817 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755274AbXD0EVN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 00:21:13 -0400
Received: (qmail 9194 invoked by uid 2001); 27 Apr 2007 06:21:11 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704262055270.9964@woody.linux-foundation.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45680>

On Fri, Apr 27, 2007 at 05:59:29AM CEST, Linus Torvalds wrote:
> 
> 
> On Fri, 27 Apr 2007, Petr Baudis wrote:
> > 
> > 	http://repo.or.cz/w?p=git.git&a=search&h=HEAD&st=grep&s=hate%5B%5Ev%5D
> 
> That looks bogus. It doesn't find
> 
>  - Documentation/git-cvsimport.txt:
> 
> 	git-cvsimport - Salvage your data out of another SCM people love to hate
> 
> Why?

Because it doesn't accept hate$, it should be like

	http://repo.or.cz/w?p=git.git&a=search&h=HEAD&st=grep&s=hate%28%5B%5Ev%5D%7C%24%29

or even better

	http://repo.or.cz/w?p=git.git&a=search&h=HEAD&st=grep&s=hate%5Cb

but in order to be able to use the regexps without breaking your
backslash key and eyes, I think it's somewhat saner to accept extended
regexps instead of basic regexps; YMMV, I'll let Junio or the list
decide which way is better.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
