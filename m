From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: tracking committer vs. author
Date: Tue, 26 May 2009 00:28:46 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0905260015430.32620@reaper.quantumfyre.co.uk>
References: <bbd12f0f0905251420l1ab63ca5y32589a4451064b9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff Brown <jeff@jeffandbetsy.net>
X-From: git-owner@vger.kernel.org Tue May 26 01:30:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8jd5-000444-VB
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 01:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125AbZEYXao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 19:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbZEYXan
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 19:30:43 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:34658 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753056AbZEYXan (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 19:30:43 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 0C1C4C2E08
	for <git@vger.kernel.org>; Tue, 26 May 2009 00:30:43 +0100 (BST)
Received: (qmail 7255 invoked by uid 103); 26 May 2009 00:28:46 +0100
Received: from darkphoton.datavampyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9386. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.037598 secs); 25 May 2009 23:28:46 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 26 May 2009 00:28:46 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <bbd12f0f0905251420l1ab63ca5y32589a4451064b9a@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119982>

On Mon, 25 May 2009, Jeff Brown wrote:

> I have noticed that when we pull changes from non-committers into our
> repo, sometimes meta information about who committed the change to the
> repo is included along side info about who actually wrote the changes.
> For example, see
> http://github.com/grails/grails/commit/8ac450c37d16b0468ba0f92d3008968fd6a41a75
> and note that graemerocher has commit privileges to the repo but
> ihotary does not.  ihatory's commit was pulled in by graemerocher.
>
> The commit at http://github.com/grails/grails/commit/ff770359d152683d5794887cd743a10ce7d04501
> was also authored by a non committer.  I pulled that change in myself
> this evening.  Notice that there is no info displayed there to
> indicate that I (jeffbrown) am the person who pushed that change into
> the repo.
>
> I don't know what was done differently for those 2 scenarios but both
> of those commits were authored by folks who do not have commit
> privileges to the repo at
> http://github.com/grails/grails/commits/master.

You say "pulled" for both commits, but do you mean that in an exact git 
sense (i.e. 'git pull ...' command was used)?  I assume not ...

If you pull from someone, then you get their commits, so they are the 
committer - on the other hand if you apply patches they have sent, then 
you become committer (though they remain the author of course) as you 
create new commits (containing basically the same changes and message).

If you compare the git repository 
(http://git.kernel.org/?p=git/git.git;a=summary) where all changes are 
made by Junio applying patches, to the Linux kernel 
(http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=summary) 
where Linus pulls from many (trusted) people you can see that while the 
commits in git are all committed by Junio, the kernel commits are made by 
a wide variety of people.

> I don't think this is a github issue.  If I am wrong, please let me know.
>
> If I want to track not only who authored the commit but also who
> pushed it into the repo (like you see at
> http://github.com/grails/grails/commit/8ac450c37d16b0468ba0f92d3008968fd6a41a75),
> what is the procedure for making that happen?

This easiest way is to not pull from people who "don't have commit 
rights" but to apply a patch series instead, as by pulling you are 
basically trusting them - possibly more that you intend/want?

HTH,
-- 
Julian

  ---
When in doubt, do what the President does -- guess.
