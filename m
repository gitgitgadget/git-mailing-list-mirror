From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git fetch workflow improvements
Date: Sat, 9 Feb 2008 13:20:29 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802091318080.11591@racer.site>
References: <3f4fd2640802090257m9ab8e24l2a836abfd2ef6bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 14:21:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNpdz-0004da-Ta
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 14:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755131AbYBINU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 08:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755004AbYBINU0
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 08:20:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:57412 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754867AbYBINUY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 08:20:24 -0500
Received: (qmail invoked by alias); 09 Feb 2008 13:20:22 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp056) with SMTP; 09 Feb 2008 14:20:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/YsSEF7YHYLcvfkv8CqYBb3MgpH0HZtKDU5/Ap1h
	uoQTS4d+GYfTRz
X-X-Sender: gene099@racer.site
In-Reply-To: <3f4fd2640802090257m9ab8e24l2a836abfd2ef6bf@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73222>

Hi,

On Sat, 9 Feb 2008, Reece Dunn wrote:

> I have some ideas on improvements I would like to make to git fetch. I 
> am not familiar with the implementation details of builtin-fetch.c and 
> friends, and having a brief look at the implementation I am unsure how 
> to proceed.
> 
> The ideas for improvements I have are:
> 
>     1.  When running `git fetch` on a bare repository that does not have 
> a remote called 'origin', fetch fails. I would like this to pick up the 
> first remote entry in the config file.

I am opposed to that.  If you want a default remote, then set the remote 
"origin".  That is well established semantics, and you would only confuse 
yourself if all of a sudden you fetched from a remote that you erroneously 
added at some stage.

>     2.  When mirroring a repository such as the Linux kernel and its 
> stable repositories in the same git repository, it would be useful to be 
> able to fetch the latest data from all the remotes that you are tracking 
> in the config file. I envision this being done by running `git fetch 
> -all`.

$ git remote update

>     3.  When fetching, if everything is up-to-date, display a message 
> saying so.

We recently tried to unverbosify the transports.  So I think this would be 
a step back.

Ciao,
Dscho
