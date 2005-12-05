From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Weirdness with port-update hook and local push
Date: Mon, 5 Dec 2005 17:01:04 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512051651050.25300@iabervon.org>
References: <Pine.LNX.4.64.0512051530560.25300@iabervon.org>
 <Pine.LNX.4.63.0512052138560.6554@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 05 23:02:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjONo-0005DT-2h
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 23:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVLEWAZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 17:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVLEWAZ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 17:00:25 -0500
Received: from iabervon.org ([66.92.72.58]:64267 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964798AbVLEWAY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 17:00:24 -0500
Received: (qmail 31355 invoked by uid 1000); 5 Dec 2005 17:01:04 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Dec 2005 17:01:04 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512052138560.6554@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13240>

On Mon, 5 Dec 2005, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 5 Dec 2005, Daniel Barkalow wrote:
> 
> > I have the following post-update hook:
> > 
> > -----
> > #!/bin/sh
> > 
> > unset GIT_DIR
> > cd /home/barkalow/auto-working/web
> > if ! git pull /home/barkalow/git/web.git/
> > then
> >   exit 1  
> > fi
> > make
> > -----
> > 
> > >From that "git pull", I'm getting:
> > 
> > /home/barkalow/bin/git-pull: line 108: 30608 Broken pipe      git-merge $no_summary $no_commit $strategy_args "$merge_name" HEAD $merge_head
> > 
> > It works fine when pushing over ssh,
> 
> Maybe it runs as a different user? (Sorry if this sounds dumb, but that's 
> exactly the kind of solution I usually find after *days*.)

I think it's an environment thing of some sort, most likely, but it can't 
be the user; nothing's setuid and I'm only one user.

The thing that confuses me is that it works when run from ssh or directly, 
but not when run from a local push. I'd expect the two that work to be 
most different.

	-Daniel
*This .sig left intentionally blank*
