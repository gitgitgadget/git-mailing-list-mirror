From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Regarding: git-lost+found
Date: Wed, 9 Nov 2005 18:06:04 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511091759520.25300@iabervon.org>
References: <Pine.LNX.4.63.0511081811080.18406@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvez1bjjv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 00:06:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZz1N-0007xJ-E2
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVKIXGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVKIXGM
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:06:12 -0500
Received: from iabervon.org ([66.92.72.58]:27407 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751080AbVKIXGK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 18:06:10 -0500
Received: (qmail 30333 invoked by uid 1000); 9 Nov 2005 18:06:04 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Nov 2005 18:06:04 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvez1bjjv.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11431>

On Wed, 9 Nov 2005, Junio C Hamano wrote:

> Maybe we could use .git/lost+found/{commit,other}/?{40} and hang
> committish under one directory and the rest in another?  Then we
> could do this:
> 
>           $ gitk $(cd .git/lost+found/commit && echo ??*)
> 
> After you find what you want, you would do 'git tag' or 'git
> branch' to reconnect them, but we can reasonably expect that is
> to happen soon after you ran lost+found and before the next time
> you run prune, because that was why you ran git-lost+found in
> the first place.

Why have git-lost+found write to files at all? It seems to me easiest to 
have the list go to standard out, and you could do "gitk `git-lost+found 
-t commit`" to see lost commits, and reconnect them as desired. (Making up 
command line syntax for listing only the commits.)

	-Daniel
*This .sig left intentionally blank*
