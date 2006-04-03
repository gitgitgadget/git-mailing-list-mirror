From: Andreas Ericsson <ae@op5.se>
Subject: Re: Default remote branch for local branch
Date: Mon, 03 Apr 2006 12:03:17 +0200
Message-ID: <4430F2E5.1030106@op5.se>
References: <1143856098.3555.48.camel@dv> <200604030128.42680.Josef.Weidendorfer@gmx.de> <4430D517.5020205@op5.se> <200604031138.29227.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 12:03:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQLu6-00088o-AT
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 12:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWDCKDT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 06:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWDCKDT
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 06:03:19 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:64685 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751266AbWDCKDS
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 06:03:18 -0400
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 4B92F6BD05; Mon,  3 Apr 2006 12:03:17 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200604031138.29227.Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18324>

Josef Weidendorfer wrote:
> On Monday 03 April 2006 09:56, Andreas Ericsson wrote:
> 
>>Josef Weidendorfer wrote:
>>
>>>Optionally, branching <new> off from <old> could add <new> as
>>>topic branch of <old>: Thus, if you are on <old> and do git-pull,
>>>you get <new> merged in.
>>>
>>
>>This is clearly insane. If I'm on <old> and want to sync with my 
>>upstream source that would be impossible without explicitly telling it 
>>*not* to merge with <new>. Iow, this change would (possibly) simplify 
>>for the one repo maintainer, but make things harder for the 30-odd 
>>developers.
> 
> 
> Yes.
> Therefore I put "optionally" above. But you are right, mixing up
> "merge upstream" and "merge downstream" into one config option is insane.
> 
> Some idea independent but related:
> I still think it is a better UI of a porcelain to try to note metainfo
> automatically, ie. storing somewhere that we branched one off another.
> What about adding "branch.topic" config option for this?
> "git-branch -t newtopic"/"git-checkout -b newtopic -t"
> would create a new topic branch, which is remembered in "branch.topic",
> and "git-pull -t" merges these topic branches?
> To specify that a remote branch is a topic branch of a given local
> branch (to be pulled into with "git-pull -t"), we could add
> "git-branch --add-topic <refspec>|<remoteURL>".
> 

Sorry, but I still don't see the use of it. Usually, some topics mature 
faster than others, meaning I'd still have to do the old "git pull . 
this and that", leaving "the-other-one" to soak a bit longer. What 
you're suggesting would make the odd case easier while adding nothing 
for the normal flow.

For archeological purposes it might make some sense to record what the 
branch was named that you forked from, but to me it's more interesting 
to see which state the code was in when the code forked, and this is 
discernable by the merge-base command.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
