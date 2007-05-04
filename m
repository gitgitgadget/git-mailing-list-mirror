From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC?] Telling git about more complex relationships between commits (Was: Re: FFmpeg considering GIT)
Date: Sat, 5 May 2007 00:11:52 +0200
Message-ID: <20070504221152.GF4033@steel.home>
References: <loom.20070502T111026-882@post.gmane.org> <200705040921.33443.johan@herland.net> <81b0412b0705040236w1d5f26bx8ac351ade2f4ea6a@mail.gmail.com> <200705041353.17992.johan@herland.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat May 05 00:12:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk60p-0002JQ-4P
	for gcvg-git@gmane.org; Sat, 05 May 2007 00:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161361AbXEDWL4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 18:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031562AbXEDWL4
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 18:11:56 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:16832 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031510AbXEDWLy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 18:11:54 -0400
Received: from tigra.home (195.4.202.37)
	by post.webmailer.de (klopstock mo9) (RZmta 5.9)
	with ESMTP id T04304j44LDnnN ; Sat, 5 May 2007 00:11:53 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id EBDD1277BD;
	Sat,  5 May 2007 00:11:52 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A4FD8D171; Sat,  5 May 2007 00:11:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200705041353.17992.johan@herland.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl9Ag==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46223>

Johan Herland, Fri, May 04, 2007 13:53:10 +0200:
> As for "Reverts", the commit pointed to should already be in your history, 
> since you cannot revert something that hasn't already been applied at an 
> earlier point in your history. In other words, the reverted commit will 
> automatically be included in your "git gc --prune" or "git clone" regardless 
> of the "Reverts" fields, since "Reverts" can only point to an ancestor.

So it becomes useless after rebase

> As for "Cherry-Pick", it's a fairly weak relationship that shouldn't affect 
> anything except to give a hint to merge, blame, and similar tools. 

In which case, just put it in the message part of commit (in fact, it
was there for some time. And was mostly useless, and got dropped).

And how exactly do you think the tools _can_ use this hint?
Especially merge, which should be absolutely certain about what inputs
and hints gets.
And what use is it for blame? How do you prioritze the hint? Is it
more important than the history (which describes each and every line),
or less? If the hint is more important, than how (and how often) do
you tell the user that the hint was not found (because the commit is
long pruned) and the tool switched back to looking into history.

It's useless.
