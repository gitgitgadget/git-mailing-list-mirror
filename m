From: Luke Lu <git@vicaya.com>
Subject: Re: git-svn questions: how to clone/init non-standard layout branches/tags?
Date: Wed, 7 Nov 2007 14:56:20 -0800
Message-ID: <D7E592C6-964E-467C-828F-81BA35275F42@vicaya.com>
References: <756D5EE2-FB2C-48DB-8242-14E154E34A9C@vicaya.com> <87597D7C-60FB-4CD8-BB27-7E870001A899@lrde.epita.fr> <8c5c35580711030659x203f8ae8s40366c493a3eeae6@mail.gmail.com> <C81F0AB6-ED04-405F-AA29-CD72816FB7B9@vicaya.com> <8c5c35580711031332y4018dba6y5d24965ebf2fbefb@mail.gmail.com> <8644CD78-25F0-42C4-A163-BD88528594F3@vicaya.com> <8c5c35580711031352n3396807fm3004ebe8f86110ed@mail.gmail.com> <B0D0BB75-58AF-4E4E-8C3F-6E615870016A@vicaya.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>,
	"Benoit SIGOURE" <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 23:56:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IptpF-0007X1-AP
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 23:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbXKGW4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 17:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754041AbXKGW4a
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 17:56:30 -0500
Received: from nz-out-0506.google.com ([64.233.162.238]:12296 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbXKGW43 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 17:56:29 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1857872nze
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 14:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=M8zZbDGCo8ZARwJe1m9Y3TP9c//Xc1I+62Gu87Z9mmQ=;
        b=chyuVpSEFSbKjmbQJbxlODkPE61W3MCDsd2YCLKutD7krvyKLz0MxuSZtM99YT0DqAT2Tj1cFo32dcAqjcQec/ieDxn3dMtaPvU3KmzCFL2bZjeEn3ZuTNbTB/tR7IU+ptJklLK89XDJVCl1w9llOgspx1j1ipVSg4ZHiTS9TS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=E2d98G+EE33/nv9QKfLjOq3OiSMwMx5tyO5vglBZuwxQVFq6wtXrr7I3mhZ+Q8cfasTSGqY0MPQDbmLySYQ0z0MFF3FwXQ9ALm11fZPNPyNlhP3KpaizOFvDYcjuPeMYMRzV8ZZ2Ufr5BuAj4f4ydN+tfRUUNsmkZjPc9MyvNIk=
Received: by 10.141.205.10 with SMTP id h10mr3893087rvq.1194476187328;
        Wed, 07 Nov 2007 14:56:27 -0800 (PST)
Received: from ?192.168.15.20? ( [98.207.63.2])
        by mx.google.com with ESMTPS id l31sm19795650rvb.2007.11.07.14.56.22
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Nov 2007 14:56:24 -0800 (PST)
In-Reply-To: <B0D0BB75-58AF-4E4E-8C3F-6E615870016A@vicaya.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63885>

In case others encounter this problem and want to find a solution...

On Nov 3, 2007, at 2:26 PM, Luke Lu wrote:
> On Nov 3, 2007, at 1:52 PM, Lars Hjemli wrote:
>> On Nov 3, 2007 9:41 PM, Luke Lu <git@vicaya.com> wrote:
>>> On Nov 3, 2007, at 1:32 PM, Lars Hjemli wrote:
>>>> On Nov 3, 2007 9:01 PM, Luke Lu <git@vicaya.com> wrote:
>>>>> I did try to add a "fetch" line for the production branch like  
>>>>> this:
>>>>>
>>>>> [svn-remote "svn"]
>>>>>          url = svn+ssh://host/svn/project
>>>>>          fetch = production:refs/remotes/svn-prod
>>>>>          fetch = trunk:refs/remotes/git-svn
>>>>>
>>>>> which is modeled after http://lists-archives.org/git/420712-git- 
>>>>> svn-
>>>>> remote-tracking-branch-question.html
>>>>>
>>>> Did you forget to run 'git svn fetch' after modifying your .git/
>>>> config?
>>>
>>> Yes, I did. It didn't seem to do anything.
>>
>> Hmm, it works for me, I've been adding and removing branches like  
>> this
>> for months, but my .git/config is slightly different:
>>
>> [svn-remote "svn"]
>>         url = svn://example.org
>>         fetch = project/trunk:refs/remotes/svn/trunk
>>         fetch = project/branches/topic:refs/remotes/svn/topic
>>
>> I don't know if this difference is important, though...
>
> I tried to test this on a local repository like file:///path/ 
> project. It seems to work and get everything properly upon git svn  
> fetch. However it doesn't work for the production branch. If I  
> modify the fetch line a bit to svn/prod instead of svn-prod and try  
> git svn fetch again. It would hang for about 2 minutes and return 0  
> and show nothing in progress. A .git/svn/svn/prod directory is  
> created but it's empty.
>
> One thing that might be special for this branch is that it gets  
> deleted and recreated/copied all the time from trunk. I wonder if  
> git-svn use some kind of heuristics to determine if there is  
> anything to fetch and silently failing...

After some permutations, this is the config that worked for me:

[svn-remote "svn"]
	url = svn+ssh://host/svn
	fetch = project/trunk:refs/remotes/git-svn
	fetch = project/production:refs/remotes/svn/production

The primary difference is that I moved 'project' from url to the  
fetch specs. My original single trunk config looked like this:

[svn-remote "svn"]
	url = svn+ssh://host/svn/project/trunk
	fetch = :refs/remotes/git-svn

I wish that "git svn fetch" could be more verbose about what's going  
on in this case.

__Luke
