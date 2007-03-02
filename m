From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Many different remote branch sources
Date: Fri, 2 Mar 2007 16:47:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703021645200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0703020253i3e1478a9pf505c0d95442536c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 16:48:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN9zU-0003at-Pd
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 16:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992533AbXCBPrm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 10:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992532AbXCBPrm
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 10:47:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:41927 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992535AbXCBPrl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 10:47:41 -0500
Received: (qmail invoked by alias); 02 Mar 2007 15:47:40 -0000
X-Provags-ID: V01U2FsdGVkX18igYpTq/4iYVtwJF7D84ATYe7JStc/W1uGMOy36k
	fepAzewwFlDVyC
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0703020253i3e1478a9pf505c0d95442536c@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41220>

Hi,

On Fri, 2 Mar 2007, Alex Riesen wrote:

> The following does not seem to work:
> 
>  [remote "dev1"]
>    url = ...
>    fetch = ...
>  [remote "dev2"]
>    url = ...
>    fetch = ...
> 
>  [branch "integration"]
>    remote = dev1
>    merge = refs/heads/topic1
> 
>  [branch "integration"]
>    remote = dev2
>    merge = refs/heads/topic2
> 
> How can I specify that a branch has more then one
> remote branch it can be merged with?

The branch.<branchname> information is purely for determining what you 
want to do when saying "git pull" (without other arguments).

In your case, I'd strongly advise against using this construct, since you 
don't want to merge with dev1 and dev2 _at the same time_.

Rather, add a "fetch = refs/heads/topic1" at the _top_ of the remotes.dev1 
section, and say "git pull dev1" when you want to pull from dev1.

Ciao,
Dscho
