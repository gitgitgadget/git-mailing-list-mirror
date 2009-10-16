From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Fri, 16 Oct 2009 13:15:35 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org> <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com> <alpine.LNX.2.00.0910141509200.32515@iabervon.org> <alpine.LFD.2.00.0910141616530.20122@xanadu.home> <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home> <7vws2xa9lu.fsf@alter.siamese.dyndns.org> <20091014230934.GC29664@coredump.intra.peff.net> <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com> <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Oct 16 14:22:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myloz-0003lo-ML
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 14:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055AbZJPMSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 08:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753089AbZJPMSG
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 08:18:06 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:34434 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751614AbZJPMSF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Oct 2009 08:18:05 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 0CA3C357014
	for <git@vger.kernel.org>; Fri, 16 Oct 2009 13:17:28 +0100 (BST)
Received: (qmail 5341 invoked by uid 103); 16 Oct 2009 13:15:35 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/9902. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.025645 secs); 16 Oct 2009 12:15:35 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 16 Oct 2009 13:15:35 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130483>

On Thu, 15 Oct 2009, Daniel Barkalow wrote:

> On Thu, 15 Oct 2009, James Pickens wrote:
>
>> How about not detaching the head at all if the user checks out any ref, and
>> reject commits if he checked out a tag or remote branch.  For example:
>>
>> $ git checkout origin/master
>> $ git status
>> # On branch origin/master
>> $ git commit ;# complain
>
> $ git checkout origin/master
> $ git fetch
> $ git checkout origin/next
> Uncommited file '...' would be overwritten.

How about:

$ git checkout origin/master
$ git fetch
Refusing to fetch, as it would update a checkedout branch
"git fetch -f" will force the update, but you will need to run "git 
reset --hard HEAD" to update your checkout to match.

?

-- 
Julian

  ---
    If you care, you just get disappointed all the time. If you don't care
nothing matters so you are never upset.	  -- Calvin
