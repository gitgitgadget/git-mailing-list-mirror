From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Wed, 1 Mar 2006 21:26:30 +0100
Message-ID: <200603012126.30797.Josef.Weidendorfer@gmx.de>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de> <200603011906.33433.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0603011023080.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Eric Wong <normalperson@yhbt.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 21:27:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEXuW-0005wB-DU
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 21:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWCAU0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 15:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWCAU0m
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 15:26:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:19334 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751172AbWCAU0l (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 15:26:41 -0500
Received: (qmail invoked by alias); 01 Mar 2006 20:26:40 -0000
Received: from p549692CD.dip0.t-ipconnect.de (EHLO linux) [84.150.146.205]
  by mail.gmx.net (mp034) with SMTP; 01 Mar 2006 21:26:40 +0100
X-Authenticated: #352111
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.1
In-Reply-To: <Pine.LNX.4.64.0603011023080.22647@g5.osdl.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17010>

On Wednesday 01 March 2006 19:25, Linus Torvalds wrote:
> > 	git log origin/master..
> > 
> > is really not that bad
> 
> It really is.
> 
> Think like a user. If I pull from "origin", then the name of that thing is 
> "origin", not "origin/master" or "o/master". A user doesn't care what the  
> remote branch name is - the whole _point_ of the .git/remotes/xyzzy file 
> is to give a short description that includes the names of the branches you 
> pull from.

So the get_sha1() magic should map "origin" to "remote/origin/master" (or instead
hardcoded master the remote branch from the first "Pull:" line) ?
The ambiguity here would be that shortcut names of remote repositories should not be
used as tag or head names...

I think a big plus of this would be that gitk can show branches tracking remote ones
with another color.
 
> The good news is that "get_sha1()" shouldn't be thse at hard to extend on. 
> Just add a case at the end that says "do we have a .git/remotes/%s file, 
> and if so, parse it".

To be able to say "git log origin.." you need the above magic, too.

Josef
