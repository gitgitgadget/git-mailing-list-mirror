From: Andreas Ericsson <ae@op5.se>
Subject: Re: dangling commits
Date: Sun, 15 Jan 2006 21:56:13 +0100
Message-ID: <43CAB6ED.3010703@op5.se>
References: <dqebk9$75f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 15 21:56:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyEvH-00018H-5a
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 21:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWAOU4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 15:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWAOU4R
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 15:56:17 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:25535 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750760AbWAOU4P
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2006 15:56:15 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 097D56BCBE; Sun, 15 Jan 2006 21:56:14 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Nick Williams <njw@jarb.freeserve.co.uk>
In-Reply-To: <dqebk9$75f$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14709>

Nick Williams wrote:
> Hi, after cloning the git repo with
> 
> cg-clone http://www.kernel.org/pub/scm/git/git.git git
> 
> and then doing
> 
> git-fsck-objects --full
> 
> I get the following
> 
> dangling commit 42db15448ea3c21ae458d5ea873157449042c07c
> dangling commit 4d04a4022e7f9f3ada3a64e2010ce65e1fcc5c64
> dangling commit a773f5bda1835d739ee7209589e137ddd7199142
> dangling commit ceb90a511add3b362f1384aa6ea35370d12db315
> 
> However if I do cg-clone git://git.kernel.org/pub/scm/git/git.git
> there's no output from git-fsck --full
> 
> git version = 1.1.GIT
> cogito version = cogito-0.17pre.GIT
> 
> did I do something wrong (again)?
> 

Nopes. One clones over http, so you'll get all objects in the object 
database. The other clones over the far more clever git protocol which 
calculates which objects you need. Obviously you don't need dangling 
commits (and their related blobs), so there will be no such items.

That there are on kernel.org at all is because Junio does rebases of the 
pu branch and then pushes them out, which means that the objects from 
the last rebase of that branch are left dangling.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
