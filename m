From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: merge summaries
Date: Sat, 19 May 2007 11:35:56 +0200
Message-ID: <73A1C4C5-50E9-4844-85F8-00D99682B6D4@zib.de>
References: <25A3C618-8D12-42A8-9478-D3A4E7633CE7@zib.de> <alpine.LFD.0.98.0705181130580.3890@woody.linux-foundation.org> <7vodki55px.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 19 11:36:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpLMr-0002kq-II
	for gcvg-git@gmane.org; Sat, 19 May 2007 11:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560AbXESJgd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 05:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754880AbXESJgd
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 05:36:33 -0400
Received: from mailer.zib.de ([130.73.108.11]:65283 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560AbXESJgc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 05:36:32 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l4J9Zmw8020242;
	Sat, 19 May 2007 11:35:48 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1a91f.pool.einsundeins.de [77.177.169.31])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l4J9Zlfr024450
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 19 May 2007 11:35:47 +0200 (MEST)
In-Reply-To: <7vodki55px.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47732>


On May 18, 2007, at 8:47 PM, Junio C Hamano wrote:

>> Think about _who_ uses it for those two prominent repositories for  
>> a while.
>>
>> [ pause, ponder here ]
>>
>> In other words, "merge.summary" should be true ONLY FOR TOP-LEVEL
>> MAINTAINERS.
>>
>> Making it true for anybody else is almost always a bug. Yes, I and  
>> Junio
>> have it enabled, but pretty much nobody else should, because if  
>> they pull
>> from me or Junio in order to merge, their merge summaries would be  
>> exactly
>> the wrong way around!
>
> This does not necessarily mean that your lieutenants should not
> use merge.summary when they pull from other trees (or inside
> their own repository to merge in the topics).  They need to
> however disable it with --no-summary when they pull from you
> when they choose to merge instead of rebase to adjust to the
> updated infrastructure in your tree.

[ ... pondering ... ]

Apparently parents of merge commits are not fully equal and summaries
can help to browse the history of a branch. If summaries are enabled
"git log --first-parent" gives hints to all changes at least in
short-log form. Changes along the first-parent-path to the initial
commit are listed in full. All changes that were merged in are
listed in the summaries of the merge. This seems to be a useful feature.

But isn't this true for any branch and any merge. If someone pulls from
you or Junio and runs "git log --first-parent" why shouldn't he see
a summary of the changes that were pulled? At that point his branch's
first-parent-path to the initial commit would not touch the changes
pulled from you. So the summary could help.

What is so wrong if merge summaries of pulls from you were committed
to topic branches. Later when you pull such branches the summaries
shouldn't be a problem. A short-log of the topic branch wouldn't
contain the summaries.

Probably I do not fully understand what "the wrong way around" means.

- Steffen
