From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sat, 20 Oct 2007 12:19:45 +0200
Message-ID: <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>	 <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail .com>	 <Pine.LNX.4.64.0710130130380.25221@racer.site> <1192827476.4522.93.camel@cacharro.xalalinux.org> <4719B655.90204@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Federico Mena Quintero <federico@novell.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Oct 20 12:20:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjBRB-0005h7-QI
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 12:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031AbXJTKTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 06:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756018AbXJTKTy
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 06:19:54 -0400
Received: from mailer.zib.de ([130.73.108.11]:35055 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755823AbXJTKTx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 06:19:53 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9KAIHtc006067;
	Sat, 20 Oct 2007 12:19:41 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1a6f2.pool.einsundeins.de [77.177.166.242])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9KAIF1B020481
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 20 Oct 2007 12:18:16 +0200 (MEST)
In-Reply-To: <4719B655.90204@op5.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61815>


On Oct 20, 2007, at 10:03 AM, Andreas Ericsson wrote:

>
> Personally, I can't help but think that the numerous times I've  
> heard "oh
> gods, that's a lot of commands" should finally mean something. I've  
> started
> taking a look at which of them one can bundle together. If we can  
> drop the
> porcelainish commands down to ~30 or so, and hide the plumbing from  
> git-<tab>
> listings, the initial hurdle people have to jump would be  
> significantly lower.

Maybe we could group commands into more categories?

plumbing: should be hidden from the 'normal' user. Porcelain
   should be sufficient for every standard task.

core porcelain: this is what everyone needs who works in a
   pure git based workflow based on push/pull. You can't use
   git without these commands. But these commands are already
   sufficient to solve most of your tasks.

mail porcelain: the list will probably hate me for this, but
   I think all commands needed to create and send patches per
   mail are not essential. I suspect that I'll _never_ ask
   my colleagues at work to send me a patch by mail. They'll
   always push it to a shared repo.

import/export: Many commands are only used for importing
   from or exporting to other version control systems. Examples
   are git-cvs*, git-svn*. They are not needed once you switched
   to git.

admin: Some commands are not used in a typical workflow. For
   example git-filter-branch or git-fsck have a more admin
   flavor.

There might be more categories. I am not sure because there
a quite a few commands that I _never_ used and have no clear
idea about what they do.


So here are a few questions:

Could we find a small set of core porcelain commands that
completely cover a typical workflow? The core section of the
manual should only refer to those commands. Absolutely no
plumbing should be needed to tweak things. In principle, a
typical user should be able to work if _all other_ commands
except for core porcelain are hidden from his PATH.

Another section in the manual should describe a workflow based
on sending patches around. Obviously the mail porcelain is
needed for this.

... and so forth.

I don't know if we really want to hide the commands from PATH.
But maybe we should consider grouping them into subdirectories,
or provide another way to for the user to focus on the core
porcelain.

	Steffen
