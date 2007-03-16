From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 16:12:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org>
 <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316060033.GD31606@spearce.org>
 <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Rocco Rutte <pdmef@gmx.net>
X-From: git-owner@vger.kernel.org Fri Mar 16 16:12:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSE6Q-0000mq-IH
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 16:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbXCPPMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 11:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965356AbXCPPMT
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 11:12:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:42832 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753219AbXCPPMS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 11:12:18 -0400
Received: (qmail invoked by alias); 16 Mar 2007 15:12:17 -0000
X-Provags-ID: V01U2FsdGVkX19fduAypMZfiqcnwRLWZNJawS3bAAjNfRd6NNtVUY
	uozs685t6mMnbV
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42364>

Hi,

[please do not cull the Cc: list]

On Fri, 16 Mar 2007, Rocco Rutte wrote:

> First, I think that would be some cleanup "only" since that basically would
> mean to
> 
>   1) make all functions die()ing return some value and handle it and
>   2) wrap all static vars into structures and pass them around
> 
> If you don't choose a design before wrapping things up in structures, you'll
> probably end up having one structure per source file (at least too many
> structures).

Why? For some tasks, it should be 1) easier, 2) more elegant, and 3) 
faster to write a function which re-initialises the static variables.

Of course, if you want to work with multiple repos _at the same time_, 
this does not help you. But frankly, we don't support that with core-git, 
so why should we in libgit?

> Porting things like qgit to it or writting proper perl/python bindings 
> is wasted time since you'd have to rewrite all of it once you decided 
> which functions to expose and which structures to use (calling the 
> main() routines of builtin's doesn't count as real libifaction, it would 
> rather be a performance improvement only).

Nope. It is _not_ a complete rewrite. More likely, it is minimal 
adjustments. It's not like we will replace apples with cars...

> I'd simply try to find a rough consensus on the data structures and the 
> layer model before starting the project, solve 1), afterwards implement 
> 2) according to it.

We already _have_ the data structures!

Also, in my experience, defining a complete API, and only after that, 
implement it, never works. Rather, start with a _small_ part you want to 
do. Define a clean API _just for that part_. Implement it. Verify that it 
indeed does what it should do (and that means not just _you_ should verify 
it, but it should be stress tested on the list).

We don't have to create the whole world in one day, you know?

Ciao,
Dscho
