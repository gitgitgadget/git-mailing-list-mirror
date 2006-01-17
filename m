From: Andreas Ericsson <ae@op5.se>
Subject: Re: Cancelling certain commits
Date: Tue, 17 Jan 2006 11:03:52 +0100
Message-ID: <43CCC108.5000404@op5.se>
References: <7ac1e90c0601160557r78599886nca9be9b6672a1bd7@mail.gmail.com>	<43CBAC0B.3020104@op5.se> <7vvewjlowk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bahadir Balban <bahadir.balban@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 11:04:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EynhC-0004uP-GO
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 11:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWAQKDy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 05:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWAQKDy
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 05:03:54 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:3278 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932361AbWAQKDx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2006 05:03:53 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id AB01F6BCBE; Tue, 17 Jan 2006 11:03:52 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvewjlowk.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14791>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>># make sure "git status" doesn't show any changes
>>
>>$ git branch anchor # to make a safe point to reset to if things go bad
>>$ git reset --hard HEAD~7 # undo commits 3 - 10
>># replay commits 4, 5, 6, 8, 9
>>$ for i in 6 5 4 2 1; do git cherry-pick -r anchor~$i || break; done
>># replay commit 10
>>$ git cherry-pick -r anchor
> 
> 
> I think "6 5 4 2 1 0" would be sweeter.  rev~0 == rev
> 

Didn't know that. The day isn't a complete loss already. :)

> 
>>..., and never *ever*
>>do
>>
>>$ git prune
>>
>>on a repo where you're juggling loose commits like this (although that
>>should actually be safe when you create 'anchor' as a branch rather
>>than as a tag, which Junio usually recommends).
> 
> 
> Sorry, I do not understand this part.  tags and branch heads are
> used in the same way to determine what objects to protect from
> "prune", so I thought there was no difference from the safety
> point of view between the anchor being a branch or a tag.
> 

You're right. That's weird though, because I distinctly remember being 
bitten by this when I was very new to git. OTOH, I probably did 
something stupid that broke the repo before, and my girlfriend provided 
plenty distraction so I didn't do the pruning and the reset'ing on the 
same day.

Would a tag with the same name in a central repo overwrite a local one 
when "git fetch --tags" is used? I think I did this over http, but I'm 
not sure. I know I had to clean up un-annotated tags that got pushed by 
accident after I had restored the lost commits though, so this could be 
a cause (there was an 'anchor' tag in the shared repo as well).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
