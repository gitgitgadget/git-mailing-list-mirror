X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Fri, 01 Dec 2006 09:59:00 +0100
Message-ID: <456FEED4.7030400@op5.se>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net> <87ejrlvn7r.wl%cworth@cworth.org> <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net> <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se> <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org> <20061130164046.GB17715@thunk.org> <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org> <Pine.LNX.4.64.0611301229290.9647@xanadu.home> <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org> <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org> <Pine.LNX.4.64.0611301521320.9647@xanadu.home> <7vhcwgiqer.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611301624430.9647@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 08:59:26 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <Pine.LNX.4.64.0611301624430.9647@xanadu.home>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32875>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq4Em-0005yc-6T for gcvg-git@gmane.org; Fri, 01 Dec
 2006 09:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030608AbWLAI7N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 03:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030609AbWLAI7N
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 03:59:13 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:19336 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030608AbWLAI7M (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 03:59:12 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 2C7856BCC3; Fri,  1 Dec 2006 09:59:04 +0100 (CET)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre wrote:
> On Thu, 30 Nov 2006, Junio C Hamano wrote:
> 
>> Nicolas Pitre <nico@cam.org> writes:
>>
>>> ...  But let me repeat my last question:
>>>
>>> Would it make sense for "git add" to do the same as "git update-index" 
>>> on already tracked files?  Given the explanation above this would make 
>>> 100% sense to me.
>> I think this makes sense and what we did in the original "git
>> add".
> 
> Wonderful! We might be converging to something then.
> 
> Because, conceptually, it then becomes much easier to tell newbies about 
> the index as follows (this could be pasted in a tutorial somewhere):
> 
>   Contrary to other SCMs, with GIT you have to explicitly "add" all
>   the changes you want to commit together.  This can be done in a few
>   different ways:
> 
>   1) By using "git add <file_spec...>"
> 
>      This can be performed multiple times before a commit.  Note that 
>      this is not only for adding new files.  Even modified files must be
>      added to the set of changes about to be committed.  The "git 
>      status" command gives you a summary of what is included so far for 
>      the commit.  When done you should use the "git commit" command to
>      make it real.
> 
>      Note: don't forget to "add" a file again if you modified it after 
>      the first "add" and before "commit". Otherwise only the previous 
>      "added" state of that file will be committed.
> 
"This is because git tracks content, so what you're really 'add'ing to 
the commit is the *content* of the file in the state it is in when you 
'add' it."


>   2) By using "git commit -a" directly
> 
>      This is a quick way to automatically "add" all modified files to 

.. "add" all tracked and modified files to ...

>      the set of changes and perform the actual commit without having to 
>      separately "add" them.  This will not "add" new files -- those 
>      files still have to be added explicitly before performing a commit.
> 
>   Here's a twist.  If you do "git commit <file1> <file2> ..." then 
>   only the  changes belonging to those explicitly specified files will 
>   be committed, entirely bypassing the current "added" changes.  Those
>   "added" changes will still remain available for a subsequent commit.
> 
>   There is a twist about that twist: if you do "git commit -i <file>..." 
>   then the commit will consider changes to those specified files 
>   _including_ all "added" changes so far.
> 
>   But for instance it is best to only remember "git add" + "git 
>   commit" and/or "git commit -a".
> 
> Doesn't it sounds nice?  The index is being introduced up front without 
> even mentioning it, and I think the above should be fairly palatable to 
> newbies as well.  Would only lack some enhancements to the commit 
> template and the "nothing to commit" message so the user is cued about 
> the fact that "current changeset is empty -- don't forget to 'git add' 
> modified files, or use 'git commit -a'".
> 
> What do you think?
> 

me likes

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
