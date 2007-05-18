From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 18:08:40 +0200
Message-ID: <20070518160840.GK18276@pasky.or.cz>
References: <200705170539.11402.andyparkins@gmail.com> <200705181524.40705.Josef.Weidendorfer@gmx.de> <20070518133922.GK4708@mellanox.co.il> <200705181751.15435.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 18 18:08:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp50c-0001jl-DN
	for gcvg-git@gmane.org; Fri, 18 May 2007 18:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756354AbXERQIm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 12:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756577AbXERQIm
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 12:08:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59929 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756380AbXERQIm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 12:08:42 -0400
Received: (qmail 8056 invoked by uid 2001); 18 May 2007 18:08:40 +0200
Content-Disposition: inline
In-Reply-To: <200705181751.15435.Josef.Weidendorfer@gmx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47619>

On Fri, May 18, 2007 at 05:51:14PM CEST, Josef Weidendorfer wrote:
> On Friday 18 May 2007, Michael S. Tsirkin wrote:
> > > Subproject identifiers appear in versioned .gitmodule files, so
> > > they are fixed with the history of the project. You can not change
> > > the names without rewriting history.
> > 
> > Actually, I think this means that moving the
> > directory where the subproject resides will involve
> > editing .gitmodule. I sthat true?
> 
> Yes.
> This was a design decision by Linus. The alternative way
> would have been a separate gitlink object, which includes the
> commit SHA1 of the subproject _and_ a subproject identifier,
> thus increasing the number of objects.
> 
> The current way is far simpler, but you have to edit the .gitmodule
> file when moving subprojects around. The argument by Linus was
> that this inconvenience should be acceptable as moving subprojects
> around should only happen very few times in the lifetime of a
> project, and involves heavy rearranging either way, such that editing
> .gitmodules info is the smaller issue.

Furthermore, git mv can trivially take care of this anyway...

> > This would be annoying. 
> > 
> > Can't a project name be a git attribute for the gitlink object?
> 
> Of course. The name can be put into the .gitattributes file instead of
> a separate .gitmodules file.
> 
> > This way I can move the object and it keeps the project name.
> 
> No.
> Git attributes do not magically move around when you move files or
> directories. You always have to change the .gitattribute file too, if
> you want to move attributes with files. Of course, this is not needed
> if you use glob patterns in .gitattributes which also fits for moved
> files. 

Actually, git-mv might take care of this too? ;-) (Would it be
considered a Bad Thing, or should I whip up a patch?)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
