From: Luke Lu <git@vicaya.com>
Subject: Re: git-svn questions: how to clone/init non-standard layout branches/tags?
Date: Sat, 3 Nov 2007 14:26:49 -0700
Message-ID: <B0D0BB75-58AF-4E4E-8C3F-6E615870016A@vicaya.com>
References: <756D5EE2-FB2C-48DB-8242-14E154E34A9C@vicaya.com> <87597D7C-60FB-4CD8-BB27-7E870001A899@lrde.epita.fr> <8c5c35580711030659x203f8ae8s40366c493a3eeae6@mail.gmail.com> <C81F0AB6-ED04-405F-AA29-CD72816FB7B9@vicaya.com> <8c5c35580711031332y4018dba6y5d24965ebf2fbefb@mail.gmail.com> <8644CD78-25F0-42C4-A163-BD88528594F3@vicaya.com> <8c5c35580711031352n3396807fm3004ebe8f86110ed@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Benoit SIGOURE" <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 22:27:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoQX1-0004l0-Tu
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 22:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669AbXKCV1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 17:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754311AbXKCV1b
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 17:27:31 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:46747 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589AbXKCV1a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 17:27:30 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1134136rvb
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 14:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=HSdRKNdHNneA2IkE32fHV0ufChybowO4YBNtKfGlZhU=;
        b=nDSV5aF+PmN720a3p31WuxriX6EulA41E78pu+CgyY3fQ4tVntV/t82uexlnVfsfUktvAWJc8+h1B+nrRAHLmH4GF1ijqNE8eE/UlapmnUWslYjbm3mVJrzfJQA7qJS3p6DaoaMH7M3NqGhQ58x4T/a/JruDd16HPYlQwrnl63c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=PGvjsNrmJG6latLzPDtx3nLdD/hkeC8mPWIJ9jN4Xgk9CfigqHM2wGAOGRWtPEOxLUQNAgrMyZNNH7YzjGMXd9r0hbCXT78bgywEb8sDn0W7wipkpO1CODKymbyIeMbi1/CmOOHNhJom6mQHLsyyt3zib1iCBFgVCgk2LQl6yH0=
Received: by 10.140.132.8 with SMTP id f8mr1588698rvd.1194125249508;
        Sat, 03 Nov 2007 14:27:29 -0700 (PDT)
Received: from ?192.168.15.20? ( [98.207.63.2])
        by mx.google.com with ESMTPS id l21sm8367274rvb.2007.11.03.14.27.25
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Nov 2007 14:27:26 -0700 (PDT)
In-Reply-To: <8c5c35580711031352n3396807fm3004ebe8f86110ed@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63315>


On Nov 3, 2007, at 1:52 PM, Lars Hjemli wrote:

> On Nov 3, 2007 9:41 PM, Luke Lu <git@vicaya.com> wrote:
>> On Nov 3, 2007, at 1:32 PM, Lars Hjemli wrote:
>>> On Nov 3, 2007 9:01 PM, Luke Lu <git@vicaya.com> wrote:
>>>> I did try to add a "fetch" line for the production branch like  
>>>> this:
>>>>
>>>> [svn-remote "svn"]
>>>>          url = svn+ssh://host/svn/project
>>>>          fetch = production:refs/remotes/svn-prod
>>>>          fetch = trunk:refs/remotes/git-svn
>>>>
>>>> which is modeled after http://lists-archives.org/git/420712-git- 
>>>> svn-
>>>> remote-tracking-branch-question.html
>>>>
>>> Did you forget to run 'git svn fetch' after modifying your .git/
>>> config?
>>
>> Yes, I did. It didn't seem to do anything.
>
> Hmm, it works for me, I've been adding and removing branches like this
> for months, but my .git/config is slightly different:
>
> [svn-remote "svn"]
>         url = svn://example.org
>         fetch = project/trunk:refs/remotes/svn/trunk
>         fetch = project/branches/topic:refs/remotes/svn/topic
>
> I don't know if this difference is important, though...

I tried to test this on a local repository like file:///path/project.  
It seems to work and get everything properly upon git svn fetch.  
However it doesn't work for the production branch. If I modify the  
fetch line a bit to svn/prod instead of svn-prod and try git svn  
fetch again. It would hang for about 2 minutes and return 0 and show  
nothing in progress. A .git/svn/svn/prod directory is created but  
it's empty.

One thing that might be special for this branch is that it gets  
deleted and recreated/copied all the time from trunk. I wonder if git- 
svn use some kind of heuristics to determine if there is anything to  
fetch and silently failing...

__Luke
