From: Nick Williams <njw@jarb.freeserve.co.uk>
Subject: Re: dangling commits
Date: Sun, 15 Jan 2006 21:37:00 +0000
Message-ID: <dqedel$d0q$1@sea.gmane.org>
References: <dqebk9$75f$1@sea.gmane.org> <43CAB6ED.3010703@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jan 15 22:05:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyF4O-000357-LS
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 22:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWAOVFp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 16:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWAOVFp
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 16:05:45 -0500
Received: from main.gmane.org ([80.91.229.2]:13976 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750850AbWAOVFo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jan 2006 16:05:44 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EyF4F-00032t-8E
	for git@vger.kernel.org; Sun, 15 Jan 2006 22:05:39 +0100
Received: from modem-2654.jaguar.dialup.pol.co.uk ([81.76.186.94])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Jan 2006 22:05:39 +0100
Received: from njw by modem-2654.jaguar.dialup.pol.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Jan 2006 22:05:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: modem-2654.jaguar.dialup.pol.co.uk
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
In-Reply-To: <43CAB6ED.3010703@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14710>

Andreas Ericsson wrote:
> Nick Williams wrote:
> 
>> Hi, after cloning the git repo with
>>
>> cg-clone http://www.kernel.org/pub/scm/git/git.git git
>>
>> and then doing
>>
>> git-fsck-objects --full
>>
>> I get the following
>>
>> dangling commit 42db15448ea3c21ae458d5ea873157449042c07c
>> dangling commit 4d04a4022e7f9f3ada3a64e2010ce65e1fcc5c64
>> dangling commit a773f5bda1835d739ee7209589e137ddd7199142
>> dangling commit ceb90a511add3b362f1384aa6ea35370d12db315
>>
>> However if I do cg-clone git://git.kernel.org/pub/scm/git/git.git
>> there's no output from git-fsck --full
>>
>> git version = 1.1.GIT
>> cogito version = cogito-0.17pre.GIT
>>
>> did I do something wrong (again)?
>>
> 
> Nopes. One clones over http, so you'll get all objects in the object 
> database. The other clones over the far more clever git protocol which 
> calculates which objects you need. Obviously you don't need dangling 
> commits (and their related blobs), so there will be no such items.

OK, that makes sense - thanks for the explanation.

> 
> That there are on kernel.org at all is because Junio does rebases of the 
> pu branch and then pushes them out, which means that the objects from 
> the last rebase of that branch are left dangling.
> 

So, is there any advantage of using http? Seems like git:// makes more 
sense.
