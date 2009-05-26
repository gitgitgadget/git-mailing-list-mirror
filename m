From: Andreas Ericsson <ae@op5.se>
Subject: Re: tracking committer vs. author
Date: Tue, 26 May 2009 07:10:11 +0200
Message-ID: <4A1B79B3.6090002@op5.se>
References: <bbd12f0f0905251420l1ab63ca5y32589a4451064b9a@mail.gmail.com>	 <alpine.LNX.2.00.0905260015430.32620@reaper.quantumfyre.co.uk> <bbd12f0f0905251640p16727ea9pedbbc99796def340@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff Brown <jeff@jeffandbetsy.net>
X-From: git-owner@vger.kernel.org Tue May 26 07:10:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8owC-0007FI-KA
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 07:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbZEZFKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 01:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752747AbZEZFKQ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 01:10:16 -0400
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:43776 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751229AbZEZFKP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 May 2009 01:10:15 -0400
Received: from source ([72.14.220.155]) by na3sys009aob103.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSht5t5mLfOvHkZX6iMZq1S9vvi0rq0GC@postini.com; Mon, 25 May 2009 22:10:17 PDT
Received: by fg-out-1718.google.com with SMTP id e12so1324648fga.10
        for <git@vger.kernel.org>; Mon, 25 May 2009 22:10:14 -0700 (PDT)
Received: by 10.86.1.1 with SMTP id 1mr6511330fga.0.1243314614055;
        Mon, 25 May 2009 22:10:14 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id d6sm12106663fga.2.2009.05.25.22.10.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 22:10:12 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <bbd12f0f0905251640p16727ea9pedbbc99796def340@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119993>

Jeff Brown wrote:
> On Mon, May 25, 2009 at 6:28 PM, Julian Phillips
> <julian@quantumfyre.co.uk> wrote:
>> On Mon, 25 May 2009, Jeff Brown wrote:
>>
>>> I have noticed that when we pull changes from non-committers into our
>>> repo, sometimes meta information about who committed the change to the
>>> repo is included along side info about who actually wrote the changes.
>>> For example, see
>>>
>>> http://github.com/grails/grails/commit/8ac450c37d16b0468ba0f92d3008968fd6a41a75
>>> and note that graemerocher has commit privileges to the repo but
>>> ihotary does not.  ihatory's commit was pulled in by graemerocher.
>>>
>>> The commit at
>>> http://github.com/grails/grails/commit/ff770359d152683d5794887cd743a10ce7d04501
>>> was also authored by a non committer.  I pulled that change in myself
>>> this evening.  Notice that there is no info displayed there to
>>> indicate that I (jeffbrown) am the person who pushed that change into
>>> the repo.
>>>
>>> I don't know what was done differently for those 2 scenarios but both
>>> of those commits were authored by folks who do not have commit
>>> privileges to the repo at
>>> http://github.com/grails/grails/commits/master.
>> You say "pulled" for both commits, but do you mean that in an exact git
>> sense (i.e. 'git pull ...' command was used)?  I assume not ...
>>
>> If you pull from someone, then you get their commits, so they are the
>> committer - on the other hand if you apply patches they have sent, then you
>> become committer (though they remain the author of course) as you create new
>> commits (containing basically the same changes and message).
>>
>> If you compare the git repository
>> (http://git.kernel.org/?p=git/git.git;a=summary) where all changes are made
>> by Junio applying patches, to the Linux kernel
>> (http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=summary)
>> where Linus pulls from many (trusted) people you can see that while the
>> commits in git are all committed by Junio, the kernel commits are made by a
>> wide variety of people.
>>
>>> I don't think this is a github issue.  If I am wrong, please let me know.
>>>
>>> If I want to track not only who authored the commit but also who
>>> pushed it into the repo (like you see at
>>>
>>> http://github.com/grails/grails/commit/8ac450c37d16b0468ba0f92d3008968fd6a41a75),
>>> what is the procedure for making that happen?
>> This easiest way is to not pull from people who "don't have commit rights"
>> but to apply a patch series instead, as by pulling you are basically
>> trusting them - possibly more that you intend/want?
>>
>> HTH,
>> --
>> Julian
>>
> 
> I understand all of that but now I am not sure what the best procedure
> is.  This is what I have been doing.
> 
> - create an integration branch
> - pull changes from someones repo into my integration branch
> - do whatever testing/reviewing/etc. necessary and if I want their
> changes, continue...
> - merge integration branch (which contains their changes) into my
> master branch (test etc...)
> - push my master to my origin
> 
> I expect there is a simple way to do what I want without having to
> create patch files, but I don't know what that is.
> 
> Thanks for any suggestions.
> 

Rebase instead of merging, or rebase interactively onto the mergebase
of your integration branch and master if you want to preserve the
merge commits. Since rebase is basically implemented as either
format-patch + am, or cherry-pick (depending on the invocation used),
it will create new commits where you become the committer.

To preserve the merge-commits when integrating you should use a
command such as this. I'm assuming assuming your integration branch
is named 'integrate' and your primary release branch is called
master:
GIT_EDITOR=: git rebase -i --onto $(git merge-base integrate master) \
   integrate

Mind the continued line, please.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
