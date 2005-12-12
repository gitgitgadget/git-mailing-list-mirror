From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Allow saving an object from a pipe
Date: Mon, 12 Dec 2005 12:12:12 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512121210010.25300@iabervon.org>
References: <Pine.LNX.4.64.0512101724290.25300@iabervon.org>
 <7v64pwuyny.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 18:11:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElrDF-0004WV-Kz
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 18:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVLLRLW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 12:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVLLRLW
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 12:11:22 -0500
Received: from iabervon.org ([66.92.72.58]:43269 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751177AbVLLRLW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 12:11:22 -0500
Received: (qmail 6569 invoked by uid 1000); 12 Dec 2005 12:12:12 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Dec 2005 12:12:12 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64pwuyny.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13526>

On Sat, 10 Dec 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > In order to support getting data into git with scripts, this adds a
> > --stdin option to git-hash-object, which will make it read from stdin.
> 
> Thanks, will apply.
> 
> To be honest, though, I am still debating myself about the merit
> of not having to have a temporary file.  Because we need the
> size of the blob available before starting to hash (i.e. we
> cannot say "atend"), index_pipe ends up keeping the whole blob
> data in memory, which is not much better than the caller storing
> it in a temporary file and driving the normal hash-object from
> the command line anyway.

It's not much better for efficiency, but it's a whole lot easier to write 
the script without having to worry about a temporary file, what could 
happen to it while you're trying to use it, and making sure it gets 
cleaned up afterwards. It can also save on disk writes, depending on where 
you put it and how the system is configured.

	-Daniel
*This .sig left intentionally blank*
